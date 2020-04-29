const Kuroshiro = require("kuroshiro");
const KuromojiAnalyzer = require("kuroshiro-analyzer-kuromoji");
const kuroshiro = new Kuroshiro();

if (!Kuroshiro.Util.hasJapanese(process.argv[2])) {
    console.log(process.argv[2]);
} else {
    kuroshiro.init(new KuromojiAnalyzer()).then((res) => {
        kuroshiro.convert(process.argv[2], { to: "romaji", romajiSystem: "passport" }).then((res) => {
            console.log(res);
        });
    })
}