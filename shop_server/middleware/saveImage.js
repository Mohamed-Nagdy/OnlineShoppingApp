const fs = require('fs')
var cloudinary = require('cloudinary').v2;

// var data = 'data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAA..kJggg==';

async function decodeBase64Image(dataString) {

    cloudinary.config({
        cloud_name: process.env.CLOUD_NAME,
        api_key: process.env.API_KEY,
        api_secret: process.env.API_SECRET
    });

    const valid_extensions = ['png', 'jpg', 'jpeg'];
    var matches = dataString.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/)
    response = {};
    // console.log(matches);
    if (matches.length !== 3) {
        return new Error('Invalid input string');
    }

    extension = matches[1].split("/")[1].toLowerCase().trim();
    data = Buffer.from(matches[2], 'base64');
    let imageName = `${Date.now()}-image.${extension}`
    if (valid_extensions.indexOf(extension) !== -1) {

        var dir = './images/'
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir);
        }

        console.log('full dir: ', dir, 'existed: ', fs.existsSync(dir));

        fs.writeFile(`./images/${imageName}`, data, function(err) {
            if (err) {
                console.log('error when save image: ', err)
                response.status = 500;
                response.error = err.toString();
            }
        });

        // upload image to cloudinary
        result = await cloudinary.uploader.upload(`./images/${imageName}`);

        console.log(result);
        console.log(result.url);
        response.name = result.url
        response.status = 200;
        response.path = dir;
        response.type = matches[1];
        // response.name = imageName;
        response.extension = extension;
    } else {
        response.status = 404
        response.error = 'extension not supported'

    }

    return response;
}


// { type: 'image/jpeg',
//   data: <Buffer 89 50 4e 47 0d 0a 1a 0a 00 00 00 0d 49 48 44 52 00 00 00 b4 00 00 00 2b 08 06 00 00 00 d1 fd a2 a4 00 00 00 04 67 41 4d 41 00 00 af c8 37 05 8a e9 00 00 ...> }


module.exports = decodeBase64Image;