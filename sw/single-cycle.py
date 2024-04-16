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

class IMem:
    def __init__(self) -> None:
        self.arr = []
        
    def get(self, i) -> Instr:
        if i % 4 != 0 or (i//4 >= len(self.arr)):
            raise InvalidPC
        return self.arr[i // 4]

class DMem:
    def __init__(self) -> None:
        self.arr = [0 for i in range(256)]
    def lb(self, i):
        return self.arr[i]
    def lh(self, i):
        return self.arr[i] & (self.arr[i+1] << 8)
    def lw(self, i):
        return self.arr[i] & \
               (self.arr[i+1] << 8) & \
               (self.arr[i+2] << 16) & \
               (self.arr[i+3] << 24)
    def sb(self, i, v):
        self.arr[i] = v & 0xff
    def sh(self, i, v):
        self.arr[i] = v & 0xff
        self.arr[i+1]  = (v >> 8) & 0xff
    def sw(self, i, v):
        self.arr[i] = v & 0xff
        self.arr[i+1]  = (v >> 8) & 0xff
        self.arr[i+2]  = (v >> 16) & 0xff
        self.arr[i+3]  = (v >> 24) & 0xff


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

class Top:
    def __init__(self, pc, rf: Dict[str, int], imem: IMem, dmem: DMem) -> None:
        self.pc = pc
        self.rf = rf
        self.imem = imem 
        self.dmem = dmem

    def clock(self):
        instr = self.imem.get(self.pc)
        rdval = None
        if instr.rs1:
            rs1val = self.rf[REG[instr.rs1]]
        if instr.rs2:
            rs2val = self.rf[REG[instr.rs2]]
        imm = instr.imm
        next_pc = self.pc + 4
        match instr.op:
            case 'lui':
                rdval = ui(imm)
            case 'auipc':
                rdval = ui(self.pc + imm)
            # arithmetic r-i
            case 'addi':
                rdval = ui(rs1val + imm)
            case 'slti':
                rdval = int(si(rs1val) < si(imm))
            case 'sltiu':
                rdval = int(ui(rs1val) < ui(imm))
            # arithmetic r-r
            case 'add':
                rdval = ui(rs1val + rs2val)
            case 'sub':
                rdval = ui(rs1val - rs2val)
            case 'slt':
                rdval = int(si(rs1val) < si(rs2val))
            case 'sltu':
                rdval = int(ui(rs1val) < ui(rs2val))
            # logical r-i
            case 'xori':
                rdval = rs1val ^ ui(imm)
            case 'ori':
                rdval = rs1val | ui(imm)
            case 'andi':
                rdval = rs1val & ui(imm)
            case 'slli':
                rdval = rs1val << imm
            case 'srli':
                rdval = rs1val >> imm
            case 'srai':
                rdval = ui(si(rs1val) >> imm)
            # logical r-r
            case 'sll':
                rdval = rs1val << shamt(rs2val)
            case 'srl':
                rdval = rs1val >> shamt(rs2val)
            case 'sra':
                rdval = ui(si(rs1val) >> shamt(rs2val))
            case 'xor':
                rdval = rs1val ^ rs2val
            case 'or':
                rdval = rs1val | rs2val
            case 'and':
                rdval = rs1val & rs2val
            # loads
            case 'lb':
                rdval = sb(self.dmem.lb(ui(rs1val + imm)))
            case 'lbu':
                rdval = self.dmem.lb(ui(rs1val + imm))
            case 'lh':
                rdval = sh(self.dmem.lh(ui(rs1val + imm)))
            case 'lhu':
                rdval = self.dmem.lh(ui(rs1val + imm))
            case 'lw':
                rdval = self.dmem.lw(ui(rs1val + imm))
            # stores
            case 'sb':
                self.dmem.sb(ui(rs1val + imm), rs2val)
            case 'sh':
                self.dmem.sh(ui(rs1val + imm), rs2val)
            case 'sw':
                self.dmem.sw(ui(rs1val + imm), rs2val)
            # jumps
            case 'jal':
                next_pc = ui(self.pc + imm)
                rdval = self.pc + 4
            case 'jalr':
                next_pc = ui(rs1val + imm)
                rdval = self.pc + 4
            # branches
            case 'beq':
                if (rs1val == rs2val):
                    next_pc = ui(self.pc + imm)
            case 'bne':
                if (rs1val != rs2val):
                    next_pc = ui(self.pc + imm)
            case 'blt':
                if (si(rs1val) < si(rs2val)):
                    next_pc = ui(self.pc + imm)
            case 'bltu':
                if (rs1val < rs2val):
                    next_pc = ui(self.pc + imm)
            case 'bge':
                if (si(rs1val) >= si(rs2val)):
                    next_pc = ui(self.pc + imm)
            case 'bgeu':
                if (rs1val >= rs2val):
                    next_pc = ui(self.pc + imm)
            # system
            case 'ecall':
                raise Trap
            case 'ebreak':
                raise Trap

        if rdval and instr.rd != 'x0':
            self.rf[REG[instr.rd]] = rdval
        self.pc = next_pc
        return self.pc

class CPU:
    def __init__(self) -> None:
        self.pc = 0
        self.rf = {r: 0 for r in REG}
        self.imem = IMem()
        self.dmem = DMem()

        self.cycle = 0
        self.retired = 0

        self.Top = Top(self.pc, self.rf, self.imem, self.dmem)

    def clock(self):
        self.pc = self.Top.clock()

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
    cpu.imem.arr = [
        Instr('bge', rs1='x0', rs2='a0', imm=24),
        Instr('addi', 'a5', 'x0', imm=0),
        Instr('add', 'a4', 'a1', 'a5'),
        Instr('sb', rs1='a5', rs2='a4', imm=0),
        Instr('addi', 'a5', 'a5', imm=1),
        Instr('bne', rs1='a0', rs2='a5', imm=-12),
        Instr('ebreak')
    ]
    cpu.rf[REG.a0] = 256
    cpu.rf[REG.a1] = 0
    try:
        while True:
            cpu.clock()
    except Trap:
        print('=== Simulation Ended ===')
        print('r0: ', cpu.rf[REG.a0])
        for i in range(8):
            print(' | '.join(f'{v:0{2}x}' for v in cpu.dmem.arr[i*8:i*8+8]))