import sys
from enum import Enum
from typing import Dict
from ctypes import c_int32, c_uint32, c_int8, c_int16

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
    pass

REG = Enum('REG', ['x0', 'ra', 'sp', 'gp', 'tp', 't0', 't1', 't2',
                   's0', 's1', 'a0', 'a1', 'a2', 'a3', 'a4', 'a5',
                   'a6', 'a7', 's2', 's3', 's4', 's5', 's6', 's7',
                   's8', 's9', 's10', 's11', 't3', 't4', 't5', 't6'
                   ], start=0)

Syscall = Enum('Syscall', [
    'WRITE',
    'KILL',
    'GETPID',
    'READ',
    'SBRK',
    'LSEEK',
    'ISATTY',
    'FSTAT',
    'CLOSE',
    'EXIT'
], start=0)

def sign_extend(value, bits):  
    mask = (1 << bits) - 1  
    value = value & mask 
    if (value & (1 << (bits - 1))):
        value -= (1 << bits)  
    return value

exbits = lambda n, a, b: (n & ((1 << b) - 1)) >> a
opcode = lambda i: exbits(i, 0, 7)
rs1    = lambda i: exbits(i, 15, 20)
rs2    = lambda i: exbits(i, 20, 25)
rd     = lambda i: exbits(i, 7, 12)
f3     = lambda i: exbits(i, 12, 15)
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

OPC = Enum('OPC', [
        ('opop' , 0b0110011),
        ('opimm', 0b0010011),
        ('load' , 0b0000011),
        ('store', 0b0100011),
        ('br'   , 0b1100011),
        ('jal'  , 0b1101111),
        ('jalr' , 0b1100111),
        ('lui'  , 0b0110111),
        ('auipc', 0b0010111),
        ('sys'  , 0b1110011)])

OPIMMF3 = Enum('OPIMMF3', [
        ('addi', 0b000),
        ('slti', 0b010),
        ('sltiu', 0b011),
        ('xori', 0b100),
        ('ori', 0b110),
        ('andi', 0b111),
        ('slli', 0b001),
        ('sri', 0b101)])

OPOPF3 = Enum('OPOPF3', [
        ('addsub', 0b000),
        ('sll', 0b001),
        ('slt', 0b010),
        ('sltu', 0b011),
        ('xor', 0b100),
        ('sr', 0b101),
        ('orr', 0b110),
        ('aand', 0b111)])

LOADF3 = Enum('LOADF3', [
        ('lb', 0b000),
        ('lh', 0b001),
        ('lw', 0b010),
        ('lbu', 0b100),
        ('lhu', 0b101)])

STOREF3 = Enum('STOREF3', [
        ('sb', 0b000),
        ('sh', 0b001),
        ('sw', 0b010)])

BRF3 = Enum('BRF3', [
        ('beq', 0b000),
        ('bne', 0b001),
        ('blt', 0b100),
        ('bge', 0b101),
        ('bltu', 0b110),
        ('bgeu', 0b111)])



#def opopDecoder(op):

class Mem:
    def __init__(self) -> None:
        self.arr = bytearray(256)
    def lb(self, i):
        return int.from_bytes(self.arr[i:i+1], byteorder='little')
    def lh(self, i):
        return int.from_bytes(self.arr[i:i+2], byteorder='little')
    def lw(self, i):
        return int.from_bytes(self.arr[i:i+4], byteorder='little')
    def sb(self, i, v):
        self.arr[i:i+1] = v.to_bytes(1, byteorder='little')
    def sh(self, i, v):
        self.arr[i:i+2] = v.to_bytes(2, byteorder='little')
    def sw(self, i, v):
        self.arr[i:i+4] = v.to_bytes(4, byteorder='little')


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
    return max(map(lambda x: x.bitlength(), l)//12 + 1)
shifts = {i: 0 for i in range(32)}
adderx = {i: 0 for i in range(3)}

class CPU:
    def __init__(self) -> None:
        self.pc = 0
        self.rf = {r: 0 for r in REG}
        self.mem = Mem()
        self.cycle = 0
        self.retired = 0

    def clock(self):
        instr = self.mem.lw(self.pc)
        #print(f'pc: {self.pc:08x} | instr: {instr:08x} | opcode: {opcode(instr):08x} | cycle: {self.cycle}')
        rdval = None
        next_pc = self.pc + 4
        self.cycle += 1
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
                        shifts[imm] += 1
                        rdval = rs1val << imm
                    case OPIMMF3.sri:
                        shifts[imm] += 1
                        if arith(instr):
                            rdval = si(rs1val) >> imm
                        else:
                            rdval = rs1val >> imm
                    # arithmetic r-i
                    case OPIMMF3.addi:
                        rdval = rs1val + imm
                        adderx[bitsreq([rdval, rs1val, imm])] += 1
                    case OPIMMF3.slti:
                        rdval = int(si(rs1val) < si(imm))
                        adderx[bitsreq([rdval, rs1val, imm])] += 1
                    case OPIMMF3.sltiu:
                        rdval = int(ui(rs1val) < ui(imm))
                        adderx[bitsreq([rdval, rs1val, imm])] += 1
            case OPC.opop:
                rs1val = self.rf[REG(rs1(instr))]
                rs2val = self.rf[REG(rs2(instr))]
                # arithmetic r-r
                match OPOPF3(f3(instr)):
                    case OPOPF3.addsub:
                        if arith(instr):
                            rdval = rs1val - rs2val
                        else:
                            rdval = rs1val + rs2val
                        adderx[bitsreq([rdval, rs1val, rs2val])] += 1
                    case OPOPF3.slt:
                        rdval = int(si(rs1val) < si(rs2val))
                        adderx[bitsreq([rdval, rs1val, rs2val])] += 1
                    case OPOPF3.sltu:
                        rdval = int(ui(rs1val) < ui(rs2val))
                        adderx[bitsreq([rdval, rs1val, rs2val])] += 1
                    
                    # logical r-r
                    case OPOPF3.sll:
                        shifts[shamt(rs2val)] += 1
                        rdval = rs1val << shamt(rs2val)
                    case OPOPF3.sr:
                        shifts[shamt(rs2val)] += 1
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
                adderx[bitsreq([ui(rs1val + imm), rs1val, imm])] += 1
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
                adderx[bitsreq([ui(rs1val + imm), rs1val, imm])] += 1
                match STOREF3(f3(instr)):
                    case STOREF3.sb:
                        if rs1val == 0x8000000:
                            print(chr(rs2val), end='')
                        self.mem.sb(ui(rs1val + imm), rs2val)
                    case STOREF3.sh:
                        self.mem.sh(ui(rs1val + imm), rs2val)
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
                if i_imm(instr) == 0: # ecall
                    call = self.rf[REG.a0]
                    arg1 = self.rf[REG.a1]
                    arg2 = self.rf[REG.a2]
                    arg3 = self.rf[REG.a3]
                    match Syscall(call):
                        case Syscall.WRITE:
                            print(self.mem.arr[arg2:arg2+arg3], end='')
                        case _:
                            print(f'\nUnsupported syscall: {call}')
                            raise Trap()
                else: # ebreak
                    print('\nEBREAK')
                    raise Trap()

        if rdval is not None and REG(rd(instr)) != REG.x0:
            self.rf[REG(rd(instr))] = ui(rdval)
        self.pc = next_pc
        self.retired += 1
        return self.pc

if __name__ == "__main__":
    cpu = CPU()
    ''' Simulated program:
    === Source:
    def f(int n, char[] A):
        A[0:n] = [0:n]

    === Assembly:
        blez    a0,.L1
        li      a5,0
    .L3:
        add     a4,a1,a5
        sb      a5,0(a4)
        addi    a5,a5,1
        bne     a0,a5,.L3
    .L1:
        ebreak 
    '''
    # def decode(bytes):
    #     i = ui(struct.unpack('<I', b)[0])
    #     return TopDecoders[opcode(i)](i)
    with open(sys.argv[1], 'rb') as f:
        cpu.mem.arr = bytearray(f.read())

    cpu.mem.arr = cpu.mem.arr.ljust(0x800, b'\x00')

    try:
        while True:
            cpu.clock()
    except Trap:
        print('=== Simulation Ended ===')
        print('cycles: ', cpu.cycle)
        print('retired: ', cpu.retired)
        print('r0: ', cpu.rf[REG.a0])
        for i in range(8):
            print(' | '.join(f'{v:0{2}x}' for v in cpu.mem.arr[i*8:i*8+8]))
        print("shifts: ", shifts)
