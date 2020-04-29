const fs = require('fs');

const data = JSON.parse(fs.readFileSync(process.argv[2]));
const songs = data.songs

for (const song of songs) {
    let seven_keys = 0;

    const title = song.title;

    for (const chart of song.charts) {
        if (chart.keys == '7K') {
            seven_keys += 1;
        }
    }

    for (const chart of song.charts) {
        chart.info.title = title;
        if (seven_keys <= 1) {
            chart.info.difficulty = 5;
        }

        if (chart.info.difficulty == 1) {
            chart.info.subtitles = ["[BEGINNER]"];
        } else if (chart.info.difficulty == 2) {
            chart.info.subtitles = ["[NORMAL]"];
        } else if (chart.info.difficulty == 3) {
            chart.info.subtitles = ["[HYPER]"];
        } else if(chart.info.difficulty == 4) {
            chart.info.subtitles = ["[ANOTHER]"];
        } else if (chart.info.difficulty == 5) {
            chart.info.subtitles = ["[LEGGENDARIA]"];
        } else {
            chart.info.subtitles = ["[DISTORTED]"];
        }
    }
}

fs.writeFileSync(process.argv[2], JSON.stringify(data, null, 4));
