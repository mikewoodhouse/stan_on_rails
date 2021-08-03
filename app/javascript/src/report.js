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
                    getPlayerPerformance(`${row.id}`)
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

getPlayerPerformance = function (id) {
    console.log(`getPlayerPerformance(${id})`)
    let qry = `id=${id}`
    console.log(id)
    getReport('perf', qry)
}

global.getReport = function (report_name, qry="") {
    let xhttp = new XMLHttpRequest()

    xhttp.onload = function () {
        if (this.readyState == 4 && this.status == 200) {
            let report = JSON.parse(this.responseText);

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

            let report_target = document.getElementById('data')
            let table = tabulate(report)
            if (existing = document.getElementById('report_table')) {
                report_target.replaceChild(table, existing)
            } else {
                report_target.appendChild(table)
            }
        }
    }

    let url = "data/get/" + report_name
    if (qry.length > 0) {
        url += '?' + qry
    }

    console.log(url)

    xhttp.open("GET", url, true)
    xhttp.send()
}
