global.tabulate = function (report) {

    formatted = function (val, fmt) {
        if (fmt == "pct") {
            return val.toFixed(2) + "%"
        }
        return val
    }

    let cols = report.columns
    let table = document.createElement('table')
    table.id= 'report_table'
    let header = table.createTHead()
    let tr = header.insertRow(-1)

    cols.forEach((col) => {
        let th = document.createElement('th')
        th.innerHTML = col.heading
        tr.appendChild(th)
    })

    let body = table.createTBody()
    report.data.forEach((row, index) => {
        let tr = body.insertRow(-1)
        tr.className = index % 2 == 0 ? 'even' : 'odd'
        cols.forEach((col) => {
            let cel = tr.insertCell(-1)
            cel.innerHTML = formatted(row[col.key], col.format)
            cel.className = col.cls
        })
    })
    return table
}

global.getReport = function (report_name) {
    let xhttp = new XMLHttpRequest()

    xhttp.onload = function () {
        if (this.readyState == 4 && this.status == 200) {
            let report = JSON.parse(this.responseText);

            let title = document.getElementById('page_title')
            title.innerText = report.title
            let subtitle = document.getElementById('subtitle')
            subtitle.innerText = report.subtitle

            let elem = document.getElementById('data')
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
