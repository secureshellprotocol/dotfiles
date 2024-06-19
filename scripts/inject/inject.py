#!/usr/bin/env python3
import os, subprocess
import shutil

def copy_dir(cwd: str, injectPath: str):
    for f in os.scandir(cwd):
        if f.name == 'injectpath':
            continue
        injectPath = os.path.expanduser(injectPath)
        if not os.path.isdir(injectPath):
            os.makedirs(injectPath)
        if os.path.isdir(f.name):
            if not os.path.exists(f'{injectPath}/{f.name}'):
                os.makedirs(f'{injectPath}/{f.name}')    
            copy_dir(f'{cwd}/{f.name}', f'{injectPath}/{f.name}')
        print(f'discovered {cwd}/{f.name}')
        shutil.copyfile(f'{cwd}/{f.name}', f'{injectPath}/{f.name}')
        print(f'copied to {injectPath}/{f.name}')

# init
gitRootFinder: list[str] = ['git', 'rev-parse', '--show-toplevel']
if subprocess.call(gitRootFinder,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.STDOUT
    ):
    print("Run this within the 'stuff' git repo!")
    exit(-1)

rootpath: str = (
    subprocess.run(gitRootFinder, 
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    ).stdout.decode('utf-8')[0:-1]
)
cwd: str = rootpath + '/dotfiles'

# parsing stage
terminfo: os.terminal_size = shutil.get_terminal_size((80,24))

pathCheck: list[str] = ['type', '-P']
packageList: list[tuple[str, str]] = []
for package in os.scandir(cwd):
    if package.name[0] == '.':
        continue
    checkPrint: str = 'checking for ' + package.name
    padLength: int = terminfo[0] - len(checkPrint) -3
    print(f'{checkPrint}{"." * padLength}',end='')
    try:
        packagePath: str = (
            subprocess.run(pathCheck + [package.name],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
            ).stdout.decode('utf-8')[0:-1]
        )
        if packagePath and os.path.isfile(packagePath): # not empty
            packageList.append((package.name, packagePath))
            print('yes')
            continue
        # not a real package
        print('.no')
    except Exception as e:
        print(e)
        continue

# injection stage
for packageSet in packageList:
    package = packageSet[0]
    packagePath = packageSet[1]
    try:
        injectpath_fd = open(f'{cwd}/{package}/injectpath')
        injectPath = injectpath_fd.read()[0:-1]
        injectpath_fd.close()
    except Exception as e:
        print(f'Could not find injectpath for {package}!')
        continue
    copy_dir(f'{cwd}/{package}', injectPath)
