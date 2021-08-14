
var report = null;

sortReportData = function (key) {
    let col = report.columns.find(coldef => coldef.key == key)
    let hi_lo = col.sort
    col.sort = hi_lo == 'hi' ? 'lo' : 'hi'
    report.data.sort(function (a, b) {
        let a_val = a[key] == 'Total' ? 99999999 : a[key]
        let b_val = b[key] == 'Total' ? 99999999 : b[key]
        return hi_lo == 'lo' ? a_val - b_val : b_val - a_val
    })
    putTable(tabulate(report))
}

tabulate = function (report) {

    formatted = function (val, fmt) {
        if (fmt == "pct") {
            return val.toFixed(2) + "%"
        }
        if (val && fmt == "2dp") {
            return val.toFixed(2)
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
        if(col.sort != null) {
            th.addEventListener('click', function () {
                sortReportData(col.key)
            })
            th.className = "sortable"
        }
        tr.appendChild(th)
    })

    let body = table.createTBody()
    report.data.forEach((row, index) => {
        let tr = body.insertRow(-1)
        tr.className = index % 2 == 0 ? 'even' : 'odd'
        cols.forEach((col) => {
            let cel = tr.insertCell(-1)
            cel.innerHTML = formatted(row[col.key], col.format)
            if (col.key == "name") {
                cel.addEventListener('click', function () {
                    getPlayerPerformance(row.id, row.name)
                })
            }
            cel.className = col.cls
        })
    })
    return table
}

filtersFor = function (report, report_name) {
    let form = document.createElement('div')
    form.id = 'report_filter'
    let input = document.createElement('input')
    input.type = 'text'
    input.name = 'input_item'
    form.appendChild(input)
    let button = document.createElement('button')
    button.addEventListener('click', function () {
        getReport(report_name, `min_innings=100`)
    })
    button.innerText = "Update"
    form.appendChild(button)
    return form
}

getPlayerPerformance = function (id, name) {
    let qry = `player_id=${id}&player_name=${name}`
    console.log(qry)
    getReport('performance', qry)
}

putTable = function (table) {
    let report_target = document.getElementById('data')
    if (existing = document.getElementById('report_table')) {
        report_target.replaceChild(table, existing)
    } else {
        report_target.appendChild(table)
    }
}

global.getReport = function (report_name, qry="") {
    let xhttp = new XMLHttpRequest()

    xhttp.onload = function () {
        if (this.readyState == 4 && this.status == 200) {
            report = JSON.parse(this.responseText);

            let title = document.getElementById('page_title')
            title.innerText = report.title
            let subtitle = document.getElementById('subtitle')
            subtitle.innerText = report.subtitle

            let filter_target = document.getElementById('filter')
            let filters = filtersFor(report, report_name)
            if (existing = document.getElementById('report_filter')) {
                filter_target.replaceChild(filters, existing)
            } else {
                filter_target.appendChild(filters)
            }

            putTable(tabulate(report))
        }
    }

    let url = "report/" + report_name
    if (qry.length > 0) {
        url += '?' + qry
    }

    xhttp.open("GET", url, true)
    xhttp.send()
}
