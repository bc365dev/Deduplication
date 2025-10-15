
function generateDiffHTML(str1, str2) {
    var controlAddIn = document.getElementById("controlAddIn");

    const matcher = new difflib.SequenceMatcher(null, str1, str2);
    const opcodes = matcher.get_opcodes();
    const html = [];

    for (const [tag, i1, i2, j1, j2] of opcodes) {
        if (tag === 'equal') {
            for (let i = j1; i < j2; i++) {
                html.push(`<span>${str2[i]}</span>`);
            }
        } else if (tag === 'replace') {
            for (let i = j1; i < j2; i++) {
                html.push(`<span style="color:red;">${str2[i]}</span>`);
            }
        } else if (tag === 'insert') {
            for (let i = j1; i < j2; i++) {
                html.push(`<span style="color:green;">${str2[i]}</span>`);
            }
        } else if (tag === 'delete') {
            for (let i = i1; i < i2; i++) {
                html.push(`<span style="color:gray;text-decoration:line-through;">${str1[i]}</span>`);
            }
        }
    }
    controlAddIn.innerHTML = `<div>${html.join('')}</div>`;
}
