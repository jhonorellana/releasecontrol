bat
@echo off
echo Levantando el sistema ReleaseControl...
:: Iniciar el Backend en una nueva ventana
start "Backend ReleaseControl" cmd /k "cd /d C:\PROYECTOS\ReleaseControl_01\backend && php artisan serve --host=127.0.0.1 --port=8001"
:: Iniciar el Frontend en otra ventana nueva
start "Frontend ReleaseControl" cmd /k "cd /d C:\PROYECTOS\ReleaseControl_01\frontend && ng serve -o --port 4201"
echo El sistema se esta iniciando en ventanas separadas.