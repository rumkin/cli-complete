# Bash completion

Missed cli completion tool for node.js. Just place `cli-complete.js` into home directory to enable bash completion
for your local application.

# Install

Completion works only if installed globally because it writes file into `/etc/bash_completion.d/`.

```bash
npm install cli-completion -g
```

# Usage

Create `cli-completion.js` inside your project's directory. Example:

```javascript
if (process.argv.length === 3) {
    console.log("server generate dump");
}
```

Type `node` or `iojs` first then script name and after that use `[TAB]`.

```
> node app[TAB] # -> app.js
> node app.js serv[TAB] # -> server
```

Or using `cli-completion` helper:

```javascript
var complete = require('cli-complete');

complete({
    server: ['start', 'stop', 'reload'],
    generate: ['view', 'controller'],
    dump: true,
    restore: function(){
        // Output complete value
        console.log('today yesterday');
    }
})
```

# Note

Currently for unix systems only.