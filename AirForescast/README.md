# AirForestal

Este repositorio contiene el archivo HTML `Version1.html` del proyecto AirGuardian Sentinel (Air quality monitoring demo).

Instrucciones rápidas:

1. Abre PowerShell y navega a la carpeta del proyecto:

```powershell
cd "C:\Users\Ariana\Desktop\AirForescast"
```

2. Ejecuta el script de configuración (te pedirá la URL remota y si prefieres SSH o HTTPS):

```powershell
.\setup-git.ps1
```

3. El script inicializará Git (si es necesario), hará commit de los archivos y añadirá el remoto con el nombre `origin` apuntando al repo `AirForestal` que indiques. Luego realizará `git push -u origin main`.

Notas:
- No compartas tokens o contraseñas por texto. Si usas HTTPS, Git credential manager te pedirá credenciales cuando hagas push.
- Para repos privados se recomienda configurar SSH y usar la URL `git@github.com:TU_USUARIO/AirForestal.git`.
