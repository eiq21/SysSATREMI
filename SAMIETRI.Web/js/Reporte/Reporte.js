Reporte = {};

Reporte.Form = {
    Id: '#cmbArea',
    strNumberDocument: '#txtDNI',
    startDate: '#txtDesde',
    endDate: '#txtHasta',
    generar: '#btnGenerar',
    divAlert: '#divAlert',
    rboArea: '#rboArea',
    rboResumen: '#rboResumen',
    TipoReporte: 'TipoReporte'
}

Reporte.Config = function () {
    $(Reporte.Form.divAlert).hide();
    Reporte.LoadComboArea();
    $(Reporte.Form.rboArea).prop('checked', true);

}


Reporte.setEvent = function () {
    $(Reporte.Form.generar).click(Reporte.exportar);

    $("input[name='" + Reporte.Form.TipoReporte + "']").change(function () {

        if (this.value == "1") {
            $(Reporte.Form.Id).prop('disabled', false);
            $(Reporte.Form.Id).val('-1');

            $(Reporte.Form.strNumberDocument).prop('disabled', false);
            $(Reporte.Form.strNumberDocument).val('');
        } else {
            $(Reporte.Form.Id).prop('disabled', true);
            $(Reporte.Form.Id).val('-1');

            $(Reporte.Form.strNumberDocument).prop('disabled', true);
            $(Reporte.Form.strNumberDocument).val('');
        }

    });

}

Reporte.Valid = function () {
    if ($(Reporte.Form.startDate).val() == "") {
        alert("Debe ingresar la fecha de Desde.")
        return false;
    }
    else if ($(Reporte.Form.endDate).val() == "") {
        alert("Debe ingresar la fecha Hasta.")
        return false;
    } else if ($.trim($(Reporte.Form.startDate).val()) != '' && $.trim($(Reporte.Form.endDate).val()) != '') {
        var desde = $(Reporte.Form.startDate).val(),
        hasta = $(Reporte.Form.endDate).val();

        var split = desde.indexOf('/');
        if (split > 1) {
            split = '/';
        } else {
            split = '-';
        }

        var splitDesde = desde.split(split);
        var AnioMesDesdeDia = splitDesde[2] + splitDesde[1] + splitDesde[0];

        var splitHasta = hasta.split(split);
        var AnioMesHastaDia = splitHasta[2] + splitHasta[1] + splitHasta[0];

        if (parseFloat(AnioMesDesdeDia) > parseFloat(AnioMesHastaDia)) {
            alert('La fecha Desde no debe ser mayor que el fecha Hasta');
            return false;
        }
    }

    return true;
}


Reporte.Alert = function (elem, message, timeout) {
    $(elem).show().html('<div class="alert"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span></div>');
    if (timeout || timeout === 0) {
        setTimeout(function () {
            $(elem).alert('close');
        }, timeout);
    }
};


Reporte.exportar = function () {

    if (Reporte.Valid()) {
        var params = {};
        params.rpt = $(Reporte.Form.rboArea).is(':checked') === true ? "reporte_por_area" : "reporte_resumen";

        params.Id = $(Reporte.Form.Id).val();
        params.strNumberDocument = $(Reporte.Form.strNumberDocument).val() == "" ? null : $(Reporte.Form.strNumberDocument).val();
        params.startDate = $(Reporte.Form.startDate).val() == "" ? null : $(Reporte.Form.startDate).val();
        params.endDate = $(Reporte.Form.endDate).val() == "" ? null : $(Reporte.Form.endDate).val();

        var url = "../Service/reporte.ashx?v=1";
        $.each(params, function (key, value) {
            url += "&" + key + "=" + value;
        });
        window.open(url, "_blank");
    }

}

Reporte.LoadComboArea = function () {

    $.ajax({
        type: "POST",
        url: "frmPrincipal.aspx/LoadComboArea",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        async: false,
        dataType: "json",
        success: function (msg) {
            var sItems = "";
            $(Reporte.Form.Id).html("<option value='-1'>TODOS</option>");
            if (msg.d != null) {
                $.each(msg.d, function (index, value) {
                    sItems += ("<option value='" + value.Id + "'>" + value.Name + "</option>");
                });

                $(Reporte.Form.Id).append(sItems);
            };
        },
        error: function (msg) {
            Mensaje("Error", msg.responseText);
        }
    });
}
