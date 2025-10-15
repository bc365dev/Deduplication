Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady')

function lcs(a, b) {
    const m = a.length, n = b.length;
    const dp = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (a[i] === b[j]) dp[i][j] = 1 + dp[i+1][j+1];
            else dp[i][j] = Math.max(dp[i+1][j], dp[i][j+1]);
        }
    }

    const result = [];
    let i = 0, j = 0;
    while (i < m && j < n) {
        if (a[i] === b[j]) {
            result.push({type: 'equal', char: a[i]});
            i++; j++;
        } else if (dp[i+1][j] >= dp[i][j+1]) {
            result.push({type: 'delete', char: a[i++]});
        } else {
            result.push({type: 'insert', char: b[j++]});
        }
    }
    while (i < m) result.push({type: 'delete', char: a[i++]});
    while (j < n) result.push({type: 'insert', char: b[j++]});
    return result;
}

window.ShowSourceData = function(data) {
    try {
        const source = data.sourceData || '';
        const related = data.relatedSourceData || '';
        const container = document.getElementById('controlAddIn');
        container.innerHTML = '';

        const diffContainer = document.createElement('div');
        diffContainer.style.fontFamily = 'monospace';
        diffContainer.style.whiteSpace = 'pre-wrap';

        const diff = lcs(source, related);

        // Merge consecutive changes for better readability
        let buffer = '', lastType = null;
        diff.forEach(({type, char}, idx) => {
            if (type === lastType || lastType === null) {
                buffer += char;
            } else {
                appendSpan(diffContainer, buffer, lastType);
                buffer = char;
            }
            lastType = type;
        });
        appendSpan(diffContainer, buffer, lastType);

        container.appendChild(diffContainer);

        function appendSpan(parent, text, type) {
            if (!text) return;
            const span = document.createElement('span');
            span.textContent = text;
            if (type === 'delete') span.style.backgroundColor = '#f3a6a6';
            if (type === 'insert') span.style.backgroundColor = '#a6f3a6';
            parent.appendChild(span);
        }

    } catch (err) {
        console.error(err);
    }
};



