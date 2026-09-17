# dotfiles

Configuraciones personales versionadas. Cada carpeta es un paquete independiente que se instala via GNU Stow.

## Contenido

| Aplicación | Descripción       | Carpeta  |
|------------|-------------------|----------|
| Neovim     | Editor de texto   | `nvim/`  |
| Pi         | Coding agent      | `pi/`    |

## Instalación

Requiere [GNU Stow](https://www.gnu.org/software/stow/).

```bash
git clone git@github.com:mitnitox/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim -t ~
```

## Desinstalar

```bash
stow -D nvim -t ~
```

## Agregar una app nueva

1. Crear carpeta con estructura del home: `<app>/.config/<app>/...`
2. Ejecutar `stow <app> -t ~`.

## License

Sin licencia por ahora.
