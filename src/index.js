module.exports = complete;
var fs = require('fs');

function complete(argv, completion) {
    if (arguments.length === 1) {
        completion = argv;
        argv = process.argv;
    }

    if (argv === process.argv) argv = argv.slice(2);
    else argv = argv.slice();


    while(argv.length > 1) {
        if (argv.length === 2 && typeof completion[argv[0]] === 'function') {
            completion[argv[0]](argv[1]);
            return;
        } else if (completion[argv[0]] === 'function') {
            completion[argv[0]]();
            return;
        } else if (argv.length === 2 && Array.isArray(completion[argv[0]])) {
            console.log(completion[argv[0]].filter(createFilter(argv[1])).join(" "));
            return;
        }

        if (! isPlainObject(completion[argv[0]])) {
            return;
        }

        completion = completion[argv.shift()];
    }

    console.log(Object.keys(completion).filter(createFilter(argv[0])).join(' '));
}

function createFilter(value) {
    return function(item) {
        return item.slice(0, value.length) === value;
    }
}

function isPlainObject(target) {
    return target && typeof target === "object" && target.constructor === Object;
}