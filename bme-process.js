const fs = require('fs');
const jpenc = require('encoding-japanese');

const data = fs.readFileSync(process.argv[2]);

const converted = "-*-- ILLEGAL DATA --*-\r\n" + jpenc.codeToString(jpenc.convert(data, 'UNICODE')).replace(/^-\*.*\*-(\r\n)|(\n)$/gm, '');
fs.writeFileSync(process.argv[2], converted);

