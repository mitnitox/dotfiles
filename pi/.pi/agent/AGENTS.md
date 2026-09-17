# AGENTS.md

Reglas base para agentes trabajando en este proyecto. Este archivo lo carga pi automáticamente al arrancar y se inyecta en el system prompt como contexto transversal — aplicalo siempre, en cualquier modo o agente.

## Estructura relacionada en `~/.pi/agent/`

- `AGENTS.md` (este archivo): instrucciones globales, auto-cargado por pi al inicio.
- `settings.json`: configuración de pi (proveedor/modelo por defecto, paquetes, tema, `defaultAgent` opcional).
- `agents/*.md`: definiciones de agentes (mode switching) cargadas por la extensión `pi-agent-mode`. Cada archivo es un agente con frontmatter YAML:
  - Globales: `~/.pi/agent/agents/*.md`
  - De proyecto (sobrescriben los globales con el mismo `name`): `<cwd>/.pi/agents/*.md`
  - Frontmatter admitido: `name`, `description`, `model` (formato `provider/model-id`), `tools` (whitelist separada por comas; los tools que no estén ahí quedan deshabilitados).
  - El cuerpo del archivo se prepende al system prompt cuando el agente está activo.
- `skills/`: skills auto-descubiertos (estándar Agent Skills). Distinto de `agents/` — los agents son modos persistentes con whitelist de tools; las skills son paquetes de conocimiento on-demand.

Comandos: `/agent [name|clear]` cambia de agente, `/agents` lista, `Ctrl+Shift+M` cicla, `Alt+S` busca.

## Principios

- Entender antes de modificar: inspeccionar el código real, no asumir cómo funciona.
- Cambios pequeños, enfocados y fáciles de revisar. No tocar nada fuera del alcance de la tarea.
- Respetar la arquitectura y convenciones existentes. Reutilizar antes de crear algo nuevo.
- Ser creativo cuando el problema lo permite, pero justificar decisiones no obvias.
- Si hay ambigüedad real (requisito poco claro, riesgo de romper algo, varias formas válidas de resolverlo), preguntar antes de decidir. No adivinar en silencio.
- No hacer cambios destructivos ni irreversibles sin autorización explícita.

## Exploración

Antes de tocar código: ubicar el punto de entrada relevante, revisar abstracciones y dependencias existentes, entender efectos secundarios. No recorrer el proyecto entero si la tarea es acotada.

## Código

- Claridad y simplicidad por sobre soluciones ingeniosas.
- Consistente con el estilo y las convenciones ya presentes en el proyecto (idioma, formato, patrones), sea cual sea el lenguaje.
- Nombres descriptivos, funciones con una sola responsabilidad.
- Comentar solo lo no obvio (decisiones, trade-offs), no lo que el código ya explica.
- No reescribir código funcionando sin necesidad concreta.

## Dependencias

Evaluar si ya existe una solución equivalente en el proyecto antes de agregar una librería nueva. Preferir la solución más simple y mantenible; usar versiones compatibles con lo existente.

## Seguridad (siempre, sin excepciones)

- Nunca exponer ni escribir en código secretos, tokens, contraseñas o credenciales. Usar variables de entorno o el mecanismo de config existente.
- Nunca deshabilitar controles de seguridad para "solucionar" algo temporalmente.
- Tratar con especial cuidado el código de terceros: no asumir que es seguro, no ejecutar ni instalar nada sin revisar qué hace.
- No ejecutar comandos destructivos (`rm -rf`, `git reset --hard`, `git push --force`, eliminación de ramas, reescritura de historial, etc.) sin autorización explícita.
- No ocultar ni tragar errores silenciosamente; manejo de errores consistente con el resto del proyecto.
- Validar entradas en los límites del sistema (APIs, archivos, input de usuario).

## Git

No sobrescribir trabajo del usuario ni cambios no relacionados presentes en el working tree. No crear commits automáticamente salvo que se pida explícitamente.

## Comandos

Entender qué hace un comando antes de ejecutarlo. Preferir comandos específicos sobre globales. No instalar nada globalmente sin necesidad real.

## Tests

No son obligatorios por ahora. Si el proyecto ya tiene tests relacionados con el cambio, correrlos y no romperlos. Si algo no se puede validar, decirlo explícitamente en vez de asumir que funciona.

## Al terminar una tarea

Reportar brevemente: qué se cambió, qué archivos, qué se validó (y qué no se pudo validar), y cualquier riesgo o decisión relevante que se haya tomado. No afirmar que algo fue probado si no se ejecutó.

## Regla fundamental

Entender → (preguntar si hace falta) → implementar → validar lo que se pueda. La velocidad nunca es excusa para saltarse seguridad o comprensión del código.
