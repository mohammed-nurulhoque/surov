from enum import Enum


REG = Enum('REG', ['x0', 'ra', 'sp', 'gp', 'tp', 't0', 't1', 't2',
                   's0', 's1', 'a0', 'a1', 'a2', 'a3', 'a4', 'a5',
                   'a6', 'a7', 's2', 's3', 's4', 's5', 's6', 's7',
                   's8', 's9', 's10', 's11', 't3', 't4', 't5', 't6'
                   ], start=0)
                   
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
        ('sys'  , 0b1110011),
        ('fence', 0b0001111)])

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

f7shadd = 0b0010000

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

SYSF3 = Enum('SYSF3', [
    ('ecallbrk',0b000),
    ('csrrs',   0b010)
])

CSR = Enum('CSR', [
    ('CYCLE',   0x00),
    ('TIME',    0x01),
    ('INSTRET', 0x02),
    ('CYCLEH',  0x80),
    ('TIMEH',   0x81),
    ('INSTRETH',0x82)
])