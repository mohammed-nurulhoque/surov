#!/usr/bin/env python3
import sys, subprocess
from enum import Enum
from ctypes import c_int32, c_uint32, c_int8, c_int16

from rvenums import *

'''
Invariants:
values in register file & data mem are always represented as +ve python integers
'''

class Instr:
    def __init__(self, op, rd=None, rs1=None, rs2=None, imm=None) -> None:
        self.op = op
        self.rd = rd
        self.rs1 = rs1
        self.rs2 = rs2
        self.imm = imm

class InvalidPC(Exception):
    pass

class Trap(Exception):
    def __init__(self, code=None):
        self.exit_code = code


Syscall = Enum('Syscall', [
    ('READ', 63),
    ('WRITE', 64),
    ('EXIT', 93)
], start=0)

def sign_extend(value, bits):
    sign_bit = 1 << (bits - 1)
    return (value & (sign_bit - 1)) - (value & sign_bit)

exbits = lambda n, a, b: (n & ((1 << b) - 1)) >> a
opcode = lambda i: exbits(i, 0, 7)
rs1    = lambda i: exbits(i, 15, 20)
rs2    = lambda i: exbits(i, 20, 25)
rd     = lambda i: exbits(i, 7, 12)
f3     = lambda i: exbits(i, 12, 15)
f7     = lambda i: exbits(i, 25, 32)
arith  = lambda i: exbits(i, 30, 31)
i_imm  = lambda i: sign_extend(exbits(i, 20, 32), 12)
s_imm  = lambda i: sign_extend(exbits(i, 7, 12) | (exbits(i,25,32) << 5), 12)
b_imm  = lambda i: sign_extend((exbits(i, 8, 12) << 1) |\
                               (exbits(i, 25, 31) << 5) |\
                               (exbits(i, 7, 8) << 11) |\
                               (exbits(i, 31, 32) << 12), 13)
u_imm  = lambda i: si(exbits(i, 12, 32) << 12)
j_imm  = lambda i: sign_extend((exbits(i, 21, 31) << 1) |\
                               (exbits(i, 20, 21) << 11) |\
                               (exbits(i, 12, 20) << 12) |\
                               (exbits(i, 31, 32) << 20), 21)

class Mem:
    def __init__(self, img: bytes, base: int) -> None:
        self.base = base
        self.arr = bytearray(img)
    def lb(self, i):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        return int.from_bytes(self.arr[i:i+1], byteorder='little')
    def lh(self, i):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        return int.from_bytes(self.arr[i:i+2], byteorder='little')
    def lw(self, i):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        return int.from_bytes(self.arr[i:i+4], byteorder='little')
    def sb(self, i, v):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        self.arr[i:i+1] = si(v).to_bytes(1, byteorder='little', signed=True)
    def sh(self, i, v):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        self.arr[i:i+2] = si(v).to_bytes(2, byteorder='little', signed=True)
    def sw(self, i, v):
        if i < self.base or i > self.base + len(self.arr): raise Trap()
        i -= base
        self.arr[i:i+4] = si(v).to_bytes(4, byteorder='little', signed=True)


def si(i):
    return c_int32(i).value
def ui(i):
    return c_uint32(i).value
def sb(i):
    return c_int8(i).value
def sh(i):
    return c_int16(i).value


def shamt(i):
    return i & 0b11111

def bitsreq(l: list):
    return max(map(lambda x: x.bit_length()//12 + 1, l))

def op_cycles(inst):
    if f7(instr) == f7shadd:
        return 3
    else:
        match OPOPF3(f3(instr)):
            case OPOPF3.sll: return 3 + 
inst_cycles ={
    OPC.opop:  lambda instr: 3,
    OPC.opimm: lambda _: 2,
    OPC.load:  lambda _: 3,
    OPC.store: lambda _: 3,
    OPC.br:    lambda _: 4,
    OPC.jal:   lambda _: 2,
    OPC.jalr:  lambda _: 2,
    OPC.lui:   lambda _: 2,
    OPC.auipc: lambda _: 2,
    OPC.sys:   lambda _: 2,
    OPC.fence: lambda _: 2

}

class Cntrs:
    def __init__(self):
        self.cycle = 0
        self.time = 0
        self.retired = 0
        self.jalr = 0
        self.jalr0 = 0
    
    def update(self, instr: int) -> None:
        op = OPC(opcode(instr))
        cycles = inst_cycles[op](instr)
        self.time += cycles
        self.cycle += cycles
        self.retired += 1
        if op == OPC.jalr:
            self.jalr += 1
            if i_imm(instr) == 0:
                self.jalr0 += 1

    def print_stats(self, ):
        sys.stderr.write(f'cycles: {self.cycle}')
        sys.stderr.write(f'time: {self.time}')
        sys.stderr.write(f'insr retired: {self.retired}')
        sys.stderr.write(f'jalr: {self.jalr}')
        sys.stderr.write(f'jalr imm=0: {self.jalr0}')

class CPU:
    def __init__(self, img: bytes, base: int, pc_init: int) -> None:
        self.pc = pc_init
        self.rf = {r: 0 for r in REG}
        self.mem = Mem(img, base)
        self.cntrs = Cntrs()


    def clock(self):
        instr = self.mem.lw(self.pc)
        rdval = None
        next_pc = self.pc + 4
        match OPC(opcode(instr)):
            case OPC.lui:
                rdval = u_imm(instr)
            case OPC.auipc:
                rdval = self.pc + u_imm(instr)
            case OPC.opimm:
                imm = i_imm(instr)
                rs1val = self.rf[REG(rs1(instr))]
                match OPIMMF3(f3(instr)):
                    # logical r-i
                    case OPIMMF3.xori:
                        rdval = rs1val ^ ui(imm)
                    case OPIMMF3.ori:
                        rdval = rs1val | ui(imm)
                    case OPIMMF3.andi:
                        rdval = rs1val & ui(imm)
                    case OPIMMF3.slli:
                        imm = imm & 31
                        rdval = rs1val << imm
                        inext = self.mem.lw(next_pc)
                    case OPIMMF3.sri:
                        imm = imm & 31
                        if arith(instr):
                            rdval = si(rs1val) >> imm
                        else:
                            rdval = rs1val >> imm
                    # arithmetic r-i
                    case OPIMMF3.addi:
                        rdval = rs1val + imm
                    case OPIMMF3.slti:
                        rdval = int(si(rs1val) < si(imm))
                    case OPIMMF3.sltiu:
                        rdval = int(ui(rs1val) < ui(imm))
            case OPC.opop:
                rs1val = self.rf[REG(rs1(instr))]
                rs2val = self.rf[REG(rs2(instr))]
                if f7(instr) == f7shadd:
                    rdval = (rs1val << (f3(instr) >> 1)) + rs2val
                else:
                    # arithmetic r-r
                    match OPOPF3(f3(instr)):
                        case OPOPF3.addsub:
                            if arith(instr):
                                rdval = rs1val - rs2val
                            else:
                                rdval = rs1val + rs2val
                        case OPOPF3.slt:
                            rdval = int(si(rs1val) < si(rs2val))
                        case OPOPF3.sltu:
                            rdval = int(ui(rs1val) < ui(rs2val))

                        # logical r-r
                        case OPOPF3.sll:
                            rdval = rs1val << shamt(rs2val)
                        case OPOPF3.sr:
                            if arith(instr):
                                rdval = si(rs1val) >> shamt(rs2val)
                            else:
                                rdval = rs1val >> shamt(rs2val)
                        case OPOPF3.xor:
                            rdval = rs1val ^ rs2val
                        case OPOPF3.orr:
                            rdval = rs1val | rs2val
                        case OPOPF3.aand:
                            rdval = rs1val & rs2val
            # loads
            case OPC.load:
                imm = i_imm(instr)
                rs1val = self.rf[REG(rs1(instr))]
                match LOADF3(f3(instr)):
                    case LOADF3.lb:
                        rdval = sb(self.mem.lb(ui(rs1val + imm)))
                    case LOADF3.lbu:
                        rdval = self.mem.lb(ui(rs1val + imm))
                    case LOADF3.lh:
                        rdval = sh(self.mem.lh(ui(rs1val + imm)))
                    case LOADF3.lhu:
                        rdval = self.mem.lh(ui(rs1val + imm))
                    case LOADF3.lw:
                        rdval = self.mem.lw(ui(rs1val + imm))
            # stores
            case OPC.store:
                imm = s_imm(instr)
                rs1val = self.rf[REG(rs1(instr))]
                rs2val = self.rf[REG(rs2(instr))]
                match STOREF3(f3(instr)):
                    case STOREF3.sb:
                        if rs1val == 0x8000000:
                            print(chr(rs2val), end='')
                        self.mem.sb(ui(rs1val + imm), sb(rs2val))
                    case STOREF3.sh:
                        self.mem.sh(ui(rs1val + imm), sh(rs2val))
                    case STOREF3.sw:
                        self.mem.sw(ui(rs1val + imm), rs2val)
            # jumps
            case OPC.jal:
                imm = j_imm(instr)
                next_pc = ui(self.pc + imm)
                rdval = self.pc + 4
            case OPC.jalr:
                imm = i_imm(instr)
                rs1val = self.rf[REG(rs1(instr))]
                next_pc = ui(rs1val + imm)
                rdval = self.pc + 4
            # branches
            case OPC.br:
                imm = b_imm(instr)
                rs1val = self.rf[REG(rs1(instr))]
                rs2val = self.rf[REG(rs2(instr))]
                match BRF3(f3(instr)):
                    case BRF3.beq:
                        if (rs1val == rs2val):
                            next_pc = ui(self.pc + imm)
                    case BRF3.bne:
                        if (rs1val != rs2val):
                            next_pc = ui(self.pc + imm)
                    case BRF3.blt:
                        if (si(rs1val) < si(rs2val)):
                            next_pc = ui(self.pc + imm)
                    case BRF3.bltu:
                        if (rs1val < rs2val):
                            next_pc = ui(self.pc + imm)
                    case BRF3.bge:
                        if (si(rs1val) >= si(rs2val)):
                            next_pc = ui(self.pc + imm)
                    case BRF3.bgeu:
                        if (rs1val >= rs2val):
                            next_pc = ui(self.pc + imm)
            # system
            case OPC.sys:
                imm = i_imm(instr)
                match SYSF3(f3(instr)):
                    case SYSF3.ecallbrk:
                        if imm == 0: # ecall
                            call = self.rf[REG.a5]
                            arg1 = self.rf[REG.a0]
                            arg2 = self.rf[REG.a1]
                            arg3 = self.rf[REG.a2]
                            match Syscall(call):
                                case Syscall.WRITE:
                                    arg2 -= base
                                    print(self.mem.arr[arg2:arg2+arg3].decode(), end='')
                                    self.rf[REG.a0] = arg3
                                case Syscall.EXIT:
                                    sys.stderr.write('\n exit called\n')
                                    raise Trap(arg1)
                                case _:
                                    sys.stderr.write(f'\nUnsupported syscall: {call}\n')
                                    raise Trap()
                        elif imm == 1: # ebreak
                            sys.stderr.write('\nEBREAK\n')
                            raise Trap()
                        else:
                            sys.stderr.write(f'\n Unrecognized instruction :{instr}\n')
                    case SYSF3.csrrs:
                        imm = exbits(instr, 20, 32)
                        try:
                            match CSR(imm & 0xFF):
                                case CSR.CYCLE:
                                    rdval = self.cntrs.cycle
                                case CSR.TIME:
                                    rdval = self.cntrs.time
                                case CSR.INSTRET:
                                    rdval = self.cntrs.retired
                                case CSR.CYCLEH:
                                    rdval = self.cntrs.time >> 32
                                case CSR.TIMEH:
                                    rdval = self.cntrs.cycle >> 32
                                case CSR.INSTRETH:
                                    rdval = self.cntrs.retired >> 32
                        except ValueError as e:
                            sys.stderr.write(f'invalid csr @pc: {self.pc:x} instr: {instr:x}')
            case OPC.fence:
                pass
            case _:
                sys.stderr.write(f'\n Unrecognized instruction :{instr}\n')
        self.cntrs.update(instr, rs1val, rs2val)

        if rdval is not None and REG(rd(instr)) != REG.x0:
            self.rf[REG(rd(instr))] = ui(rdval)
        self.pc = next_pc
        return self.pc

if __name__ == "__main__":
    filename = sys.argv[1]

    cmd = f'readelf -l {filename} | grep \'Entry\\|LOAD\''
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True).stdout.strip().split('\n')
    entry = int(result[0].split()[2], 0)
    base = None
    sys.stderr.write(f'Reading memory image from {filename}\n')
    with open(filename, 'rb') as f:
        memimg = bytes()
        prev_end = None
        for loadseg in result[1:]:
            offset, _, address, fsize, memsize = map(lambda n: int(n, 0), loadseg.split()[1:6])
            if base is None:
                base = address
            f.seek(offset, 0)
            if prev_end is not None:
                memimg += bytes(address - prev_end)
            memimg += f.read(fsize).ljust(memsize, b'\x00')
            prev_end = address + memsize
    sys.stderr.write(f'base: {base:x} entry: {entry:x} image-size:{len(memimg)}\n')
    memimg += bytes(8192) # stack

    cpu = CPU(memimg, base, entry)
    cpu.rf[REG.sp] = (base + len(memimg) - 4) // 16 * 16

    try:
        while True:
            cpu.clock()
    except Trap as t:
        sys.stderr.write('=== Simulation Ended ===\n')
        if t.exit_code is not None:
            sys.stderr.write(f'called exit with code {t.exit_code}\n')
        cpu.cntrs.print_stats()
