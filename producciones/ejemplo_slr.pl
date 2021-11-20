prod(0,'EP',[nt('E')]).
prod(1,'E',[nt('E'),t('+'),nt('T')]).
prod(2,'E',[nt('T')]).
prod(3,'T',[nt('T'),t('*'),nt('F')]).
prod(4,'T',[nt('F')]).
prod(5,'F',[t('('),nt('E'),t(')')]).
prod(6,'F',[t('id')]).
