# Cómo ayudar a Donna Auchaway

Podés contribuir con un "issue" acá en GitHub, con cosas que quieras que
arreglemos, agreguemos, cambiemos, etc.

Si querés ayudar con código, podés clonar el repositorio y hacer un pull
request. Probablemente necesites correr el código por tu cuenta, para probar
cambios y demás. Para eso necesitás [crear un bot
propio](#configuración-para-un-bot-de-pruebas) y configurarlo.

## Configuración para un bot de pruebas

### Telegram

Primero hay que hablar con el bot oficial de Telegram para crear otros bots,
que se llama [BotFather](https://t.me/botfather). Esto se hace con el comando
`/newbot`. Ahí BotFather te pregunta un nombre para el bot, y un "username" que
va a ser el `@username`. Una vez creado, BotFather te da una API Key, que es lo
que se usa para comunicar nuestro código con Telegram. Guardala porque es
importante (y no la compartas con nadie).

Con el comando `/mybots` podés elegir el bot que acabás de crear y
configurarlo mediante un menú con botoncitos. Clickeá "Edit Bot", y configurá lo que quieras.

Los `commands` son la lista de comandos que se muestra en un botoncito que
tiene una `/` cuando alguien habla con el bot:

```
start - Hola Donna!
stop - Chau Donna!
help - Aiuda!
pronombres - Mis pronombres son...
contame_de - Contame algo de...
about - Contame de vos
```

La `description` es el texto de presentación del bot, que aparece cuando
alguien abre el chat por primera vez:

```
Hola, soy Donna. Mis pronombres son neutros (elle) y soy le cyborg de Auch (@auchbdsm)!

Puedo recordar tus pronombres y preferencias sobre mensajes privados de otrxs miembrxs del grupo, así cualquiera puede preguntarme antes de interactuar con vos. También podés preguntarme por quien quieras!

Podés pedirme *aiuuuuda!!!* 😱 con /help y te explico mejor todo.
```

Y el `about` es el texto que se lee en el perfil del bot:

```
Soy Donna Auchaway. Mis pronombres son neutros (elle) y soy le cyborg de Auch!
```

Para leer más sobre los bots y la API de Telegram para estos, se puede ver la
[documentación oficial](https://core.telegram.org/bots).

Una vez configurado el bot nuevo en Telegram, hay que configurar nuestro entorno con el username del bot (su @) y la API Key que nos dió BotFather, en variables de entorno locales. Por ejemplo, en linux:

```sh
export DONNA_TELEGRAM_BOTNAME=username_que_elegimos
export DONNA_TELEGRAM_API_KEY=API Key que nos dió BotFather
```

Finalmente se puede iniciar el bot con `bin/donna`.
