global.tabulate = function(report) {
    let cols = report.columns
    let table = document.createElement('table')
    table.id= 'report_table'
    let header = table.createTHead()
    let tr = header.insertRow(-1)
    for (let i = 0; i < cols.length; i++) {
        let th = document.createElement('th')
        th.innerHTML = cols[i].heading
        tr.appendChild(th)
    }
    let body = table.createTBody()
    for (let i = 0; i < report.data.length; i++) {
        tr = body.insertRow(-1)
        tr.className = i % 2 == 0 ? 'even' : 'odd'
        for (let j = 0; j < cols.length; j++) {
            let cel = tr.insertCell(-1)
            cel.innerHTML = report.data[i][cols[j].key]
            cel.className = cols[j].cls
        }
    }
    return table
}

global.getReport = function (report_name) {
    let xhttp = new XMLHttpRequest()

    xhttp.onload = function () {
        if (this.readyState == 4 && this.status == 200) {
            let elem = document.getElementById('data')
            elem.innerHtml = ""
            let title = document.getElementById('page_title')
            title.innerHtml = ""

            let report = JSON.parse(this.responseText);
            title.innerText = report.title

            if (existing = document.getElementById('report_table')) {
                elem.replaceChild(tabulate(report), existing)
            } else {
                elem.appendChild(tabulate(report))
            }
        }
    }

    xhttp.open("GET", "data/get/" + report_name, true)
    xhttp.send()
}
