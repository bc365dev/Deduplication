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

        const table = document.createElement('table');
        table.classList.add('diff-table');

        // Source Data Row
        const sourceRow = document.createElement('tr');
        sourceRow.classList.add('diff-row');
        const sourceLabel = document.createElement('td');
        sourceLabel.classList.add('diff-label');
        sourceLabel.textContent = 'Source Data:';
        const sourceData = document.createElement('td');
        sourceData.classList.add('diff-data');
        sourceData.textContent = source;
        sourceRow.appendChild(sourceLabel);
        sourceRow.appendChild(sourceData);
        table.appendChild(sourceRow);

        // Related Data Row
        const relatedRow = document.createElement('tr');
        relatedRow.classList.add('diff-row');
        const relatedLabel = document.createElement('td');
        relatedLabel.classList.add('diff-label');
        relatedLabel.textContent = 'Related Data:';
        const relatedData = document.createElement('td');
        relatedData.classList.add('diff-data');

        // Generate diff for related data
        const diff = lcs(source, related);
        let buffer = '', lastType = null;
        diff.forEach(({type, char}) => {
            if (type === 'equal' || type === 'insert') {
                if (lastType !== type && lastType !== null) {
                    appendSpan(relatedData, buffer, lastType);
                    buffer = char;
                } else {
                    buffer += char;
                }
                lastType = type;
            }
        });
        appendSpan(relatedData, buffer, lastType);

        relatedRow.appendChild(relatedLabel);
        relatedRow.appendChild(relatedData);
        table.appendChild(relatedRow);

        container.appendChild(table);

        function appendSpan(parent, text, type) {
            if (!text) return;
            const span = document.createElement('span');
            span.textContent = text;
            if (type === 'insert') span.classList.add('diff-highlight-insert');
            parent.appendChild(span);
        }

    } catch (err) {
        console.error(err);
    }
};



