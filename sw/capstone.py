import capstone as cs
from elftools.elf.elffile import ELFFile
import sys
with open(sys.argv[1], 'rb') as f:
    elf = ELFFile(f)
    code = elf.get_section_by_name('.text')
    ops = code.data()
    addr = code['sh_addr']
    md = cs.Cs(cs.CS_ARCH_RISCV, cs.CS_MODE_32)
    md.detail = True
    for i in md.disasm(ops, addr):        
        print(f'0x{i.address:x}:\t{i.mnemonic}\t{i.op_str}')
