export function bigIntToString(bigIntValue) {
  const bytes = [];
  let tempBigInt = bigIntValue;

  while (tempBigInt > BigInt(0)) {
    const byteValue = Number(tempBigInt & BigInt(255));
    bytes.push(byteValue);
    tempBigInt = tempBigInt >> BigInt(8);
  }

  const decoder = new TextDecoder();
  const asciiString = decoder.decode(Uint8Array.from(bytes));
  return asciiString;
}

export function parseNonStandardJSON(jsonString) {
  // Replace unquoted keys and values with double-quoted keys and values
  const fixedJsonString = jsonString
    .replace(/([a-zA-Z_][a-zA-Z0-9_]*):/g, '"$1":')
    .replace(/(\d+[a-zA-Z_][a-zA-Z0-9_]*),/g, '"$1",')
    .replace(/(true|false),/g, '"$1",');

  // Parse the JSON string
  const jsonObject = JSON.parse(fixedJsonString);

  return jsonObject;
}

export function parseNonStandardJSON2(jsonString) {
  // Replace unquoted keys and values with double-quoted keys and values
  const fixedJsonString = jsonString
    .replace(/([a-zA-Z][a-zA-Z0-9]):/g, '"$1":')
    .replace(/(\d+[a-zA-Z][a-zA-Z0-9]),/g, '"$1",')
    .replace(/(true|false),/g, '"$1",');

  // Parse the JSON string
  const jsonObject = JSON.parse(fixedJsonString);

  return jsonObject;
}

export function stringToBigInt(input) {
  if (input === "") {
    return null;
  }

  const encoder = new TextEncoder();
  const encodedBytes = encoder.encode(input);

  let bigIntValue = BigInt(0);
  for (let i = 0; i < encodedBytes.length; i++) {
    const byteValue = BigInt(encodedBytes[i]);
    const shiftedValue = byteValue << BigInt(8 * i);
    bigIntValue = bigIntValue | shiftedValue;
  }

  return bigIntValue;
}

export function generateBadge(status) {
  if (status == "true") {
    return (
      <span className="inline-flex items-center gap-x-1.5 rounded-md bg-green-100 px-1.5 py-0.5 text-xs font-medium text-green-700">
        <svg
          className="h-1.5 w-1.5 fill-green-500"
          viewBox="0 0 6 6"
          aria-hidden="true">
          <circle cx={3} cy={3} r={3} />
        </svg>
        True
      </span>
    );
  } else if (status == "false") {
    return (
      <span className="inline-flex items-center gap-x-1.5 rounded-md bg-pink-100 px-1.5 py-0.5 text-xs font-medium text-pink-700">
        <svg
          className="h-1.5 w-1.5 fill-pink-500"
          viewBox="0 0 6 6"
          aria-hidden="true">
          <circle cx={3} cy={3} r={3} />
        </svg>
        False
      </span>
    );
  }
}



export function removeType(text) {
    var arr = text.split('u');
return arr[0];

}