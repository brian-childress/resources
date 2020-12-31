const csvToJson = require("csvtojson");
const fs = require("fs");

csvToJson()
  .fromFile("file.csv")
  .then((output) => {
    fs.writeFile("file.json", JSON.stringify(output), (error) => {
      if (error) {
        throw error;
      }
      console.info("Successfully converted file");
    });
  })
  .catch((error) => {
    console.error(`Error converting: ${error}`);
  });
