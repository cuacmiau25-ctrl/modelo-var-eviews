' Abrir Workfile | cambiar la ruta del archivo según su ubicación
wfopen "c:\users\usuario\onedrive\7mo_ciclo\econometría_ii\tarea final\workfiles\datos.wf1"


'------------------------------------------------------------
' PRIMERA PREGUNTA=======================================================================================
'------------------------------------------------------------
' Creación de dummys para incorporar al modelo para ciertas variables en un periodo especificado
series dum98_3 = 0
smpl 1998q3 1998q3
dum98_3 = 1
smpl 1995q4 2021q4

series dum20_2 = 0
smpl 2020q2 2020q2
dum20_2 = 1
smpl 1995q4 2021q4

' Códificación para hallar el mejor SARIMA usando el código vinculado al comando Automatic Arima Forecasting
freeze(ipc_sarima) ipc.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_ipc) ipc_f c

freeze(energyindex_sarima) energyindex.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_energyindex) energyindex_f c

freeze(foodindex_sarima) foodindex.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_foodindex) foodindex_f c

freeze(metalindex_sarima) metalindex.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_metalindex) metalindex_f c

freeze(pbichina_sarima) pbichina.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_pbichina) pbichina_f c

freeze(tcbancario_sarima) tcbancario.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_tcbancario) tcbancario_f c

freeze(tasasombra_sarima) tasasombra.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_tasasombra) tasasombra_f c

freeze(tasadeinteres_sarima) tasadeinteres.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_tasadeinteres) tasadeinteres_f c dum98_3

freeze(pbiperu_sarima) pbiperu.autoarma(maxar=4, maxma=4, maxsar=1, maxsma=1, select=sic, agraph, atable, etable, eqname=eq_pbiperu) pbiperu_f c dum20_2



' Codificación para agregar los valores de los indicadores de predicción a tablas: una tabla para predicción estática y otra para predicción dinámica

'''"""TABLA DE INDICADORES ESTÁTICOS"

' Crear una tabla para almacenar los resultados
table indicadores_estaticos
indicadores_estaticos(1, 1) = "Indicador"
indicadores_estaticos(1, 2) = "energyindex"
indicadores_estaticos(1, 3) = "foodindex"
indicadores_estaticos(1, 4) = "ipc"
indicadores_estaticos(1, 5) = "metalindex"
indicadores_estaticos(1, 6) = "pbichina"
indicadores_estaticos(1, 7) = "pbiperu"
indicadores_estaticos(1, 8) = "tasadeinteres"
indicadores_estaticos(1, 9) = "tasasombra"
indicadores_estaticos(1, 10) = "tcbancario"
indicadores_estaticos(2, 1) = "RMSE"
indicadores_estaticos(3, 1) = "MAE"
indicadores_estaticos(4, 1) = "MAPE"
indicadores_estaticos(5, 1) = "TIC"

''''''''''''''''''''''''''''''''''''''''''''' energyindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para energyindex
eq_energyindex.fit(e, g, ga) energyindex_estatico
' Calcular los indicadores de pronóstico para energyindex
scalar RMSE_energyindex_estatico = @rmse(energyindex_estatico, energyindex)
scalar MAE_energyindex_estatico = @mae(energyindex_estatico, energyindex)
scalar MAPE_energyindex_estatico = @mape(energyindex_estatico, energyindex)
scalar TIC_energyindex_estatico = @theil(energyindex_estatico, energyindex)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 2) = RMSE_energyindex_estatico
indicadores_estaticos(3, 2) = MAE_energyindex_estatico
indicadores_estaticos(4, 2) = MAPE_energyindex_estatico
indicadores_estaticos(5, 2) = TIC_energyindex_estatico

'''''''''''''''''''''''''''''''''''''''''' foodindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para foodindex
eq_foodindex.fit(e, g, ga) foodindex_estatico
' Calcular los indicadores de pronóstico para foodindex
scalar RMSE_foodindex_estatico = @rmse(foodindex_estatico, foodindex)
scalar MAE_foodindex_estatico = @mae(foodindex_estatico, foodindex)
scalar MAPE_foodindex_estatico = @mape(foodindex_estatico, foodindex)
scalar TIC_foodindex_estatico = @theil(foodindex_estatico, foodindex)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 3) = RMSE_foodindex_estatico
indicadores_estaticos(3, 3) = MAE_foodindex_estatico
indicadores_estaticos(4, 3) = MAPE_foodindex_estatico
indicadores_estaticos(5, 3) = TIC_foodindex_estatico

'''''''''''''''''''''''''''''''''''''''''' ipc
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para ipc
eq_ipc.fit(e, g, ga) ipc_estatico
' Calcular los indicadores de pronóstico para ipc
scalar RMSE_ipc_estatico = @rmse(ipc_estatico, ipc)
scalar MAE_ipc_estatico = @mae(ipc_estatico, ipc)
scalar MAPE_ipc_estatico = @mape(ipc_estatico, ipc)
scalar TIC_ipc_estatico = @theil(ipc_estatico, ipc)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 4) = RMSE_ipc_estatico
indicadores_estaticos(3, 4) = MAE_ipc_estatico
indicadores_estaticos(4, 4) = MAPE_ipc_estatico
indicadores_estaticos(5, 4) = TIC_ipc_estatico

'''''''''''''''''''''''''''''''''''''''''' metalindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para metalindex
eq_metalindex.fit(e, g, ga) metalindex_estatico
' Calcular los indicadores de pronóstico para metalindex
scalar RMSE_metalindex_estatico = @rmse(metalindex_estatico, metalindex)
scalar MAE_metalindex_estatico = @mae(metalindex_estatico, metalindex)
scalar MAPE_metalindex_estatico = @mape(metalindex_estatico, metalindex)
scalar TIC_metalindex_estatico = @theil(metalindex_estatico, metalindex)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 5) = RMSE_metalindex_estatico
indicadores_estaticos(3, 5) = MAE_metalindex_estatico
indicadores_estaticos(4, 5) = MAPE_metalindex_estatico
indicadores_estaticos(5, 5) = TIC_metalindex_estatico

'''''''''''''''''''''''''''''''''''''''''' pbichina
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para pbichina
eq_pbichina.fit(e, g, ga) pbichina_estatico
' Calcular los indicadores de pronóstico para pbichina
scalar RMSE_pbichina_estatico = @rmse(pbichina_estatico, pbichina)
scalar MAE_pbichina_estatico = @mae(pbichina_estatico, pbichina)
scalar MAPE_pbichina_estatico = @mape(pbichina_estatico, pbichina)
scalar TIC_pbichina_estatico = @theil(pbichina_estatico, pbichina)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 6) = RMSE_pbichina_estatico
indicadores_estaticos(3, 6) = MAE_pbichina_estatico
indicadores_estaticos(4, 6) = MAPE_pbichina_estatico
indicadores_estaticos(5, 6) = TIC_pbichina_estatico

'''''''''''''''''''''''''''''''''''''''''' pbiperu
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para pbiperu
eq_pbiperu.fit(e, g, ga) pbiperu_estatico
' Calcular los indicadores de pronóstico para pbiperu
scalar RMSE_pbiperu_estatico = @rmse(pbiperu_estatico, pbiperu)
scalar MAE_pbiperu_estatico = @mae(pbiperu_estatico, pbiperu)
scalar MAPE_pbiperu_estatico = @mape(pbiperu_estatico, pbiperu)
scalar TIC_pbiperu_estatico = @theil(pbiperu_estatico, pbiperu)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 7) = RMSE_pbiperu_estatico
indicadores_estaticos(3, 7) = MAE_pbiperu_estatico
indicadores_estaticos(4, 7) = MAPE_pbiperu_estatico
indicadores_estaticos(5, 7) = TIC_pbiperu_estatico

'''''''''''''''''''''''''''''''''''''''''' tasadeinteres
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para tasadeinteres
eq_tasadeinteres.fit(e, g, ga) tasadeinteres_estatico
' Calcular los indicadores de pronóstico para tasadeinteres
scalar RMSE_tasadeinteres_estatico = @rmse(tasadeinteres_estatico, tasadeinteres)
scalar MAE_tasadeinteres_estatico = @mae(tasadeinteres_estatico, tasadeinteres)
scalar MAPE_tasadeinteres_estatico = @mape(tasadeinteres_estatico, tasadeinteres)
scalar TIC_tasadeinteres_estatico = @theil(tasadeinteres_estatico, tasadeinteres)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 8) = RMSE_tasadeinteres_estatico
indicadores_estaticos(3, 8) = MAE_tasadeinteres_estatico
indicadores_estaticos(4, 8) = MAPE_tasadeinteres_estatico
indicadores_estaticos(5, 8) = TIC_tasadeinteres_estatico

'''''''''''''''''''''''''''''''''''''''''' tasasombra
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para tasasombra
eq_tasasombra.fit(e, g, ga) tasasombra_estatico
' Calcular los indicadores de pronóstico para tasasombra
scalar RMSE_tasasombra_estatico = @rmse(tasasombra_estatico, tasasombra)
scalar MAE_tasasombra_estatico = @mae(tasasombra_estatico, tasasombra)
scalar MAPE_tasasombra_estatico = @mape(tasasombra_estatico, tasasombra)
scalar TIC_tasasombra_estatico = @theil(tasasombra_estatico, tasasombra)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 9) = RMSE_tasasombra_estatico
indicadores_estaticos(3, 9) = MAE_tasasombra_estatico
indicadores_estaticos(4, 9) = MAPE_tasasombra_estatico
indicadores_estaticos(5, 9) = TIC_tasasombra_estatico

'''''''''''''''''''''''''''''''''''''''''' tcbancario
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico estático para tcbancario
eq_tcbancario.fit(e, g, ga) tcbancario_estatico
' Calcular los indicadores de pronóstico para tcbancario
scalar RMSE_tcbancario_estatico = @rmse(tcbancario_estatico, tcbancario)
scalar MAE_tcbancario_estatico = @mae(tcbancario_estatico, tcbancario)
scalar MAPE_tcbancario_estatico = @mape(tcbancario_estatico, tcbancario)
scalar TIC_tcbancario_estatico = @theil(tcbancario_estatico, tcbancario)
' Agregar los resultados a la tabla
indicadores_estaticos(2, 10) = RMSE_tcbancario_estatico
indicadores_estaticos(3, 10) = MAE_tcbancario_estatico
indicadores_estaticos(4, 10) = MAPE_tcbancario_estatico
indicadores_estaticos(5, 10) = TIC_tcbancario_estatico
' Mostrar la tabla con los resultados
'show indicadores_estaticos

'''''''''''''''""" TABLA DE INDICADORES DINÁMICOS"

' Crear una tabla para almacenar los resultados
table indicadores_dinamicos
indicadores_dinamicos(1, 1) = "Indicador"
indicadores_dinamicos(1, 2) = "energyindex"
indicadores_dinamicos(1, 3) = "foodindex"
indicadores_dinamicos(1, 4) = "ipc"
indicadores_dinamicos(1, 5) = "metalindex"
indicadores_dinamicos(1, 6) = "pbichina"
indicadores_dinamicos(1, 7) = "pbiperu"
indicadores_dinamicos(1, 8) = "tasadeinteres"
indicadores_dinamicos(1, 9) = "tasasombra"
indicadores_dinamicos(1, 10) = "tcbancario"
indicadores_dinamicos(2, 1) = "RMSE"
indicadores_dinamicos(3, 1) = "MAE"
indicadores_dinamicos(4, 1) = "MAPE"
indicadores_dinamicos(5, 1) = "TIC"

'''''''''''''''''''''''''''''''''''''''''''''energyindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para energyindex
eq_energyindex.forecast(e, g, ga) energyindex_dinamico
' Calcular los indicadores de pronóstico dinámico para energyindex
scalar RMSE_energyindex_dinamico = @rmse(energyindex_dinamico, energyindex)
scalar MAE_energyindex_dinamico = @mae(energyindex_dinamico, energyindex)
scalar MAPE_energyindex_dinamico = @mape(energyindex_dinamico, energyindex)
scalar TIC_energyindex_dinamico = @theil(energyindex_dinamico, energyindex)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 2) = RMSE_energyindex_dinamico
indicadores_dinamicos(3, 2) = MAE_energyindex_dinamico
indicadores_dinamicos(4, 2) = MAPE_energyindex_dinamico
indicadores_dinamicos(5, 2) = TIC_energyindex_dinamico

'''''''''''''''''''''''''''''''''''''''''''''foodindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para foodindex
eq_foodindex.forecast(e, g, ga) foodindex_dinamico
' Calcular los indicadores de pronóstico dinámico para foodindex
scalar RMSE_foodindex_dinamico = @rmse(foodindex_dinamico, foodindex)
scalar MAE_foodindex_dinamico = @mae(foodindex_dinamico, foodindex)
scalar MAPE_foodindex_dinamico = @mape(foodindex_dinamico, foodindex)
scalar TIC_foodindex_dinamico = @theil(foodindex_dinamico, foodindex)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 3) = RMSE_foodindex_dinamico
indicadores_dinamicos(3, 3) = MAE_foodindex_dinamico
indicadores_dinamicos(4, 3) = MAPE_foodindex_dinamico
indicadores_dinamicos(5, 3) = TIC_foodindex_dinamico

'''''''''''''''''''''''''''''''''''''''''''''ipc
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para ipc
eq_ipc.forecast(e, g, ga) ipc_dinamico
' Calcular los indicadores de pronóstico dinámico para ipc
scalar RMSE_ipc_dinamico = @rmse(ipc_dinamico, ipc)
scalar MAE_ipc_dinamico = @mae(ipc_dinamico, ipc)
scalar MAPE_ipc_dinamico = @mape(ipc_dinamico, ipc)
scalar TIC_ipc_dinamico = @theil(ipc_dinamico, ipc)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 4) = RMSE_ipc_dinamico
indicadores_dinamicos(3, 4) = MAE_ipc_dinamico
indicadores_dinamicos(4, 4) = MAPE_ipc_dinamico
indicadores_dinamicos(5, 4) = TIC_ipc_dinamico

'''''''''''''''''''''''''''''''''''''''''''''metalindex
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para metalindex
eq_metalindex.forecast(e, g, ga) metalindex_dinamico
' Calcular los indicadores de pronóstico dinámico para metalindex
scalar RMSE_metalindex_dinamico = @rmse(metalindex_dinamico, metalindex)
scalar MAE_metalindex_dinamico = @mae(metalindex_dinamico, metalindex)
scalar MAPE_metalindex_dinamico = @mape(metalindex_dinamico, metalindex)
scalar TIC_metalindex_dinamico = @theil(metalindex_dinamico, metalindex)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 5) = RMSE_metalindex_dinamico
indicadores_dinamicos(3, 5) = MAE_metalindex_dinamico
indicadores_dinamicos(4, 5) = MAPE_metalindex_dinamico
indicadores_dinamicos(5, 5) = TIC_metalindex_dinamico

'''''''''''''''''''''''''''''''''''''''''''''pbichina
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para pbichina
eq_pbichina.forecast(e, g, ga) pbichina_dinamico
' Calcular los indicadores de pronóstico dinámico para pbichina
scalar RMSE_pbichina_dinamico = @rmse(pbichina_dinamico, pbichina)
scalar MAE_pbichina_dinamico = @mae(pbichina_dinamico, pbichina)
scalar MAPE_pbichina_dinamico = @mape(pbichina_dinamico, pbichina)
scalar TIC_pbichina_dinamico = @theil(pbichina_dinamico, pbichina)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 6) = RMSE_pbichina_dinamico
indicadores_dinamicos(3, 6) = MAE_pbichina_dinamico
indicadores_dinamicos(4, 6) = MAPE_pbichina_dinamico
indicadores_dinamicos(5, 6) = TIC_pbichina_dinamico

'''''''''''''''''''''''''''''''''''''''''''''pbiperu
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para pbiperu
eq_pbiperu.forecast(e, g, ga) pbiperu_dinamico

' Calcular los indicadores de pronóstico dinámico para pbiperu
scalar RMSE_pbiperu_dinamico = @rmse(pbiperu_dinamico, pbiperu)
scalar MAE_pbiperu_dinamico = @mae(pbiperu_dinamico, pbiperu)
scalar MAPE_pbiperu_dinamico = @mape(pbiperu_dinamico, pbiperu)
scalar TIC_pbiperu_dinamico = @theil(pbiperu_dinamico, pbiperu)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 7) = RMSE_pbiperu_dinamico
indicadores_dinamicos(3, 7) = MAE_pbiperu_dinamico
indicadores_dinamicos(4, 7) = MAPE_pbiperu_dinamico
indicadores_dinamicos(5, 7) = TIC_pbiperu_dinamico

'''''''''''''''''''''''''''''''''''''''''''''tasadeinteres
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para tasadeinteres
eq_tasadeinteres.forecast(e, g, ga) tasadeinteres_dinamico
' Calcular los indicadores de pronóstico dinámico para tasadeinteres
scalar RMSE_tasadeinteres_dinamico = @rmse(tasadeinteres_dinamico, tasadeinteres)
scalar MAE_tasadeinteres_dinamico = @mae(tasadeinteres_dinamico, tasadeinteres)
scalar MAPE_tasadeinteres_dinamico = @mape(tasadeinteres_dinamico, tasadeinteres)
scalar TIC_tasadeinteres_dinamico = @theil(tasadeinteres_dinamico, tasadeinteres)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 8) = RMSE_tasadeinteres_dinamico
indicadores_dinamicos(3, 8) = MAE_tasadeinteres_dinamico
indicadores_dinamicos(4, 8) = MAPE_tasadeinteres_dinamico
indicadores_dinamicos(5, 8) = TIC_tasadeinteres_dinamico

'''''''''''''''''''''''''''''''''''''''''''''tasasombra
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para tasasombra
eq_tasasombra.forecast(e, g, ga) tasasombra_dinamico
' Calcular los indicadores de pronóstico dinámico para tasasombra
scalar RMSE_tasasombra_dinamico = @rmse(tasasombra_dinamico, tasasombra)
scalar MAE_tasasombra_dinamico = @mae(tasasombra_dinamico, tasasombra)
scalar MAPE_tasasombra_dinamico = @mape(tasasombra_dinamico, tasasombra)
scalar TIC_tasasombra_dinamico = @theil(tasasombra_dinamico, tasasombra)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 9) = RMSE_tasasombra_dinamico
indicadores_dinamicos(3, 9) = MAE_tasasombra_dinamico
indicadores_dinamicos(4, 9) = MAPE_tasasombra_dinamico
indicadores_dinamicos(5, 9) = TIC_tasasombra_dinamico

'''''''''''''''''''''''''''''''''''''''''''''tcbancario
' Establecer el rango de la muestra
smpl 2018q1 2021q1
' Generar el pronóstico dinámico para tcbancario
eq_tcbancario.forecast(e, g, ga) tcbancario_dinamico
' Calcular los indicadores de pronóstico dinámico para tcbancario
scalar RMSE_tcbancario_dinamico = @rmse(tcbancario_dinamico, tcbancario)
scalar MAE_tcbancario_dinamico = @mae(tcbancario_dinamico, tcbancario)
scalar MAPE_tcbancario_dinamico = @mape(tcbancario_dinamico, tcbancario)
scalar TIC_tcbancario_dinamico = @theil(tcbancario_dinamico, tcbancario)
' Agregar los resultados a la tabla
indicadores_dinamicos(2, 10) = RMSE_tcbancario_dinamico
indicadores_dinamicos(3, 10) = MAE_tcbancario_dinamico
indicadores_dinamicos(4, 10) = MAPE_tcbancario_dinamico
indicadores_dinamicos(5, 10) = TIC_tcbancario_dinamico
' Mostrar la tabla con los resultados
'show indicadores_dinamicos


'------------------------------------------------------------
' SEGUNDA PREGUNTA ==============================================================================
'------------------------------------------------------------



'------------------------------------------------------------
' SECCIÓN 1: DEFINICIÓN DE SERIES
'------------------------------------------------------------

'definir smp
smpl 1995Q4 2021Q4

'desestacionalización de PBIPERU
pbiperu.x12

' Se definen 9 series econométricas que se usarán en las pruebas
series p_1 = tasadeinteres
series p_2 = tasasombra
series p_3 = pbiperu_sa
series p_4 = energyindex
series p_5 = foodindex
series p_6 = metalindex
series p_7 = pbichina
series p_8 = tcbancario
series p_9 = ipc


'lista para las diferenciaciones
%difer = "0 1"

for %dif {%difer}
			' Asignar valor a %orden según el valor de %dif usando if anidado
			if %dif = "1" then
    				%orden = "_dif1"
				else
    				if %dif = "2" then
        				%orden = "_dif2"
    				else
        				if %dif = "0" then
            				%orden = ""
        				else
            				' Opcional: manejo para otros casos si %dif no es "0", "1" ni "2"
            				%orden = "valor_desconocido"
        				endif
    				endif
			endif
	
	for !k = 1 to 9
		'---------------adf-----------------
	freeze(r_1_1_!k{%orden}) p_!k.uroot(dif={%dif},exog=none) 'prueba sin componente determinístico
	freeze(r_1_2_!k{%orden}) p_!k.uroot(dif={%dif}) 'prueba con intercepto
	freeze(r_1_3_!k{%orden}) p_!k.uroot(dif={%dif},exog=trend) 'drift y tendencia
         	'---------phillips-perron--------
	freeze(r_2_1_!k{%orden}) p_!k.uroot(pp, dif={%dif}, exog=none)
	freeze(r_2_2_!k{%orden}) p_!k.uroot(pp,dif={%dif})
	freeze(r_2_3_!k{%orden}) p_!k.uroot(pp,dif={%dif}, exog=trend)
        	'---------adf-gls--------
	freeze(r_3_2_!k{%orden}) p_!k.uroot(dfgls,dif={%dif})
	freeze(r_3_3_!k{%orden}) p_!k.uroot(dfgls, exog=trend,dif={%dif})
        	'---------ers---------
	freeze(r_4_2_!k{%orden}) p_!k.uroot(ers,maxlag=15,dif={%dif})
	freeze(r_4_3_!k{%orden}) p_!k.uroot(ers,maxlag=15, exog=trend,dif={%dif})
        	'--------ng_perron---------
	freeze(r_5_2_!k{%orden}) p_!k.uroot(np, maxlag=15,dif={%dif})
	freeze(r_5_3_!k{%orden}) p_!k.uroot(np, maxlag=15,exog=trend,dif={%dif})
	next !k
	
	'creación de las tablas en workfile:
	for !v = 1 to 9
		table(40,9) ru_!v{%orden}
		    	if !v = 1 then
        				ru_!v{%orden}(1,1) = "tasa de interes interbancaria"
    				else
        				if !v = 2 then
            				ru_!v{%orden}(1,1) = "tasa sombra de la FED"
        				else
            				if !v = 3 then
                				ru_!v{%orden}(1,1) = "pbi peru"
            				else
                				if !v = 4 then
                    				ru_!v{%orden}(1,1) = "energyindex"
                				else
                    				if !v = 5 then
                        				ru_!v{%orden}(1,1) = "foodindex"
                    				else
                        				if !v = 6 then
                            				ru_!v{%orden}(1,1) = "metalindex"
                        				else
                            				if !v = 7 then
                                				ru_!v{%orden}(1,1) = "pbi china"
                            				else
                                				if !v = 8 then
                                    				ru_!v{%orden}(1,1) = "tipo de cambio bancario"
                                				else
                                    				ru_!v{%orden}(1,1) = "ipc"
                                				endif
                            				endif
                        				endif
                    					endif
                				endif
            				endif
        				endif
    				endif
		'generando los valores para la tabla
		!m = 0
		!o = 0
		!r = 0
		!u = 0
		%opciones = "none drift ""drift and trend"""
		
	
	
		for !k = 1 to 5
					if !k = 1 then
						ru_!v{%orden}(2,1)="ADF"
					else 
						if !k = 2 then
							ru_!v{%orden}(8,1)="PP"
						else	
							if !k = 3 then
							ru_!v{%orden}(14,1)="ADF-GLS"
							!o = 1
							else 
								if !k = 4 then
									ru_!v{%orden}(20,1)="ERS"
									!o = 1
									!r = 2
								else
									if !k = 5 then
										ru_!v{%orden}(26,1)="NG-Perrón"
										!o = 0
										!r = 2
									endif
								endif
							endif
						endif
					endif
    				for !n = 1 to 3
        				' Construir el nombre del objeto freeze
        				%nombre_objeto = "r_"+@str(!k)+"_"+@str(!n)+"_"+@str(!v)+%orden
				
        				' Verificar si el objeto existe
        				if @isobject(%nombre_objeto) then
            				' Si existe, extraemos los valores
						
						ru_!v{%orden}(3+!m,1)="t_stat"
						ru_!v{%orden}(4+!m,1)="vc 1%"
						ru_!v{%orden}(5+!m,1)="vc 5%"
						ru_!v{%orden}(6+!m,1)="vc 10%"
							if !k >=3 and !n >= 2 then
								!u = -1
							endif
						ru_!v{%orden}(2+!m, !n + 1+!u) = @word(%opciones, !n) 
            				ru_!v{%orden}(3+!m, !n + 1+!u) = @val({%nombre_objeto}(7+!r,4+!o))
            				ru_!v{%orden}(4+!m, !n + 1+!u) = @val({%nombre_objeto}(8+!r,4+!o))
            				ru_!v{%orden}(5+!m, !n + 1+!u) = @val({%nombre_objeto}(9+!r,4+!o))
            				ru_!v{%orden}(6+!m, !n + 1+!u) = @val({%nombre_objeto}(10+!r,4+!o))
        				endif
    				next !n
    				!m = !m + 6
		next !k
		'exportar las imágenes una vez terminada la construcción de la tabla
		'ru_!v{%orden}.save(t=png) c:\users\user01\onedrive\7mo_ciclo\econometría_ii\tarea final\pruebas de raices unitarias\ru_!v{%orden}.png
	next !v

'------------------------------------------------------------
' SECCIÓN 2: REALIZAR PRUEBAS DE RAÍCES UNITARIAS CON RUPERTA (BUROOT)
'------------------------------------------------------------
' Para cada serie (p_1 a p_9), se ejecutan varias pruebas de ruptura:
' - minT (mínima T)
' - minincpt (ruptura en intercepto mínima)
' - maxincpt (ruptura en intercepto máxima)
' - absincpt (ruptura absoluta en intercepto)
' - user (ruptura específica: Q1 2020, Q1 2001, etc)

for !k = 1 to 9
    ' Dickey-Fuller min T
    freeze(br_minT_int_!k{%orden})         p_!k.buroot(dif={%dif},nograph)                  ' Sin tendencia
    freeze(br_minT_intbreak_!k{%orden})     p_!k.buroot(exog=trend, dif={%dif},nograph)      ' Con tendencia
    freeze(br_minT_both_!k{%orden})        p_!k.buroot(exog=trend, break=both,dif={%dif}, nograph)   ' Ambos
    freeze(br_minT_trendbrk_!k{%orden})    p_!k.buroot(exog=trend, break=trend,dif={%dif}, nograph)  ' Solo ruptura en tendencia

    ' Intercept break (min-incpt)
    freeze(br_minincpt_int_!k{%orden})       p_!k.buroot(breakmethod=minincpt, dif={%dif}, trim=10, nograph)
    freeze(br_minincpt_intbreak_!k{%orden})  p_!k.buroot(exog=trend, breakmethod=minincpt,dif={%dif}, trim=10, nograph)
    freeze(br_minincpt_both_!k{%orden})      p_!k.buroot(exog=trend, break=both, breakmethod=mintrend, dif={%dif},trim=10, nograph)
    freeze(br_minincpt_trendbrk_!k{%orden})  p_!k.buroot(exog=trend, break=trend, breakmethod=mintrend,dif={%dif}, trim=10, nograph)

    ' Intercept break (max-incpt)
    freeze(br_maxincpt_int_!k{%orden})       p_!k.buroot(breakmethod=maxincpt, trim=10,dif={%dif}, nograph)
    freeze(br_maxincpt_intbreak_!k{%orden})  p_!k.buroot(exog=trend, breakmethod=maxincpt, trim=10,dif={%dif}, nograph)
    freeze(br_maxincpt_both_!k{%orden})      p_!k.buroot(exog=trend, break=both, breakmethod=maxtrend,dif={%dif}, trim=10, nograph)
    freeze(br_maxincpt_trendbrk_!k{%orden})  p_!k.buroot(exog=trend, break=trend, breakmethod=maxtrend,dif={%dif}, trim=10, nograph)

    ' Intercept break (abs-incpt)
    freeze(br_absincpt_int_!k{%orden})       p_!k.buroot(breakmethod=absincpt,dif={%dif}, trim=10, nograph)
    freeze(br_absincpt_intbreak_!k{%orden})  p_!k.buroot(exog=trend, breakmethod=absincpt,dif={%dif}, trim=10, nograph)
    freeze(br_absincpt_both_!k{%orden})      p_!k.buroot(exog=trend, break=both, breakmethod=abstrend, dif={%dif},trim=10, nograph)
    freeze(br_absincpt_trendbrk_!k{%orden})  p_!k.buroot(exog=trend, break=trend, breakmethod=abstrend, dif={%dif},trim=10, nograph)

    ' User-specific break
		%fecha = "2020q1"
			if !k = 1 then
				%fecha = "2001q1"
				else
					if !k = 4 then
							%fecha = "2020q2"
					else
						if !k = 7 then
							%fecha = "2020q1"
						endif
					endif
			endif
    freeze(br_user_int_!k{%orden})           p_!k.buroot(breakmethod=user, userbreak={%fecha},dif={%dif}, nograph)
    freeze(br_user_intbreak_!k{%orden})      p_!k.buroot(exog=trend, breakmethod=user, userbreak={%fecha}, dif={%dif},nograph)
    freeze(br_user_both_!k{%orden})          p_!k.buroot(exog=trend, break=both, breakmethod=user, userbreak={%fecha},dif={%dif}, nograph)
    freeze(br_user_trendbrk_!k{%orden})      p_!k.buroot(exog=trend, break=trend, breakmethod=user, userbreak={%fecha},dif={%dif}, nograph)
next !k


'------------------------------------------------------------
' SECCIÓN 3: CREACIÓN DE TABLAS PARA ALMACENAR RESULTADOS
'------------------------------------------------------------
' Se crea una tabla qru_!v para cada serie (1-9)
for !v = 1 to 9
    table(40,9) qru_!v{%orden}

    if !v = 1 then
        qru_!v{%orden}(1,1) = "tasa de interes interbancaria"
    else
        if !v = 2 then
            qru_!v{%orden}(1,1) = "tasa sombra de la FED"
        else
            if !v = 3 then
                qru_!v{%orden}(1,1) = "pbi peru"
            else
                if !v = 4 then
                    qru_!v{%orden}(1,1) = "energyindex"
                else
                    if !v = 5 then
                        qru_!v{%orden}(1,1) = "foodindex"
                    else
                        if !v = 6 then
                            qru_!v{%orden}(1,1) = "metalindex"
                        else
                            if !v = 7 then
                                qru_!v{%orden}(1,1) = "pbi china"
                            else
                                if !v = 8 then
                                    qru_!v{%orden}(1,1) = "tipo de cambio bancario"
                                else
                                    qru_!v{%orden}(1,1) = "índice de precios al consumidor"
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endif
next !v


'------------------------------------------------------------
' SECCIÓN 4: RELLENAR LAS TABLAS CON LOS RESULTADOS
'------------------------------------------------------------
' Iniciar bucle sobre las series
for !v = 1 to 9

    ' Reiniciar contadores para cada serie
    !m = 0       ' fila base para cada test (se incrementa por cada test)
    !r = 13      ' fila donde se encuentra el estadístico t en los objetos freeze
    !o = 4       ' columna donde se encuentran los valores en los objetos freeze

    ' Definir listas de tests y variantes
    %tests    = "mint minincpt maxincpt absincpt user"     ' Tipos de pruebas
    %variants = "int intbreak both trendbrk"              ' Variantes de componentes determinísticos

    ' Bucle sobre cada tipo de prueba (5 tipos)
    for !k = 1 to 5
        qru_!v{%orden}(2+!m,1) = @word(%tests,!k)   ' Nombre del test en la primera columna

        ' Bucle sobre cada variante (4 variantes)
        for !n = 1 to 4
            %vex = @word(%variants,!n)      ' Obtener variante actual (int, intbreak, etc.)
            %nombre_objeto = "br_"+@word(%tests,!k)+"_"+%vex+"_"+@str(!v)+%orden

            ' Verificar si el objeto existe antes de intentar acceder a él
            if @isobject(%nombre_objeto) then
                ' Escribir encabezados solo una vez por test
                qru_!v{%orden}(2+!m,!n + 1) = %vex
                qru_!v{%orden}(3+!m,1) = "t_stat"
                qru_!v{%orden}(4+!m,1) = "vc 1%"
                qru_!v{%orden}(5+!m,1) = "vc 5%"
                qru_!v{%orden}(6+!m,1) = "vc 10%"

                ' Extraer valores del objeto freeze y colocarlos en la tabla
                qru_!v{%orden}(3+!m, !n+1) = @val({%nombre_objeto}(!r,  !o))
                qru_!v{%orden}(4+!m, !n+1) = @val({%nombre_objeto}(!r+1,!o))
                qru_!v{%orden}(5+!m, !n+1) = @val({%nombre_objeto}(!r+2,!o))
                qru_!v{%orden}(6+!m, !n+1) = @val({%nombre_objeto}(!r+3,!o))
            endif
        next !n

        ' Incrementar fila base para siguiente test
        !m = !m + 6
    next !k
		'comando para exportar las imágenes de las tablas
		'qru_!v{%orden}.save(t=png) c:\users\user01\onedrive\7mo_ciclo\econometría_ii\tarea final\pruebas de raices unitarias\qru_!v{%orden}.png
next !v
next

'------------------------------------------------------------
' TERCERA PREGUNTA  Y CUARTA PREGUNTA=============================================================================================
'------------------------------------------------------------
smpl 1995q4 2021q4

' Transformar la data de las series

	' Bloque externo

freeze(tasasombra_line) tasasombra.line


pbichina.x12(mode=m,save="d10 d11")
genr var_pbichina = (log(pbichina_sa)-log(pbichina_sa(-4)))*100
freeze(pbichina_line) var_pbichina.line


genr var_metalindex = (log(metalindex)-log(metalindex(-4)))*100
freeze(metalindex_line) var_metalindex.line


genr var_foodindex = (log(foodindex)-log(foodindex(-4)))*100
genr var_energyindex = (log(energyindex)-log(energyindex(-4)))*100

group gg var_foodindex var_energyindex
freeze(foodandenergy) gg.line


graph _series1.merge tasasombra_line pbichina_line metalindex_line foodandenergy



' Bloque interno

pbiperu.x12(mode=m,save="d10 d11")
genr var_pbiperu = (log(pbiperu_sa)-log(pbiperu_sa(-4)))*100
freeze(pbiperu_line) var_pbiperu.line


genr var_ipc = (log(ipc)-log(ipc(-4)))*100
freeze(ipc_line) var_ipc.line


freeze(tasadeinteres_line) tasadeinteres.line


genr var_tcbancario = (log(tcbancario)-log(tcbancario(-4)))*100
freeze(tcbancario_line) var_tcbancario.line


graph _series2.merge pbiperu_line ipc_line tasadeinteres_line tcbancario_line



' Modelo VAR

	' Base 02 (energía)

var var1.ls 1 1 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario

series d20_1 = 0

smpl 2020q1 2020q1

d20_1 = 1

smpl 1995q4 2021q4

var var1.ls 1 1 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1



	' Número de rezagos óptimo

freeze(var1_laglen) var1.laglen(8)

var var2.ls 1 2 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1

freeze(var2_estabilidad) var2.arroots



' Introducción de variable dummy

	' Para corregir el Residuo 01

series d01_01 = 0

smpl 2001q1 2001q2

d01_01 = 1

smpl 1995q4 2021q4

var var2.ls 1 2 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1 d01_01



series d08_1 = 0

smpl 2008q1 2008q4

d08_1 = 1

smpl 1995q4 2021q4

var var2.ls 1 2 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1 d01_01 d08_1



series d01_4 = 0

smpl 2001q4 2001q4

d01_4 = 1

smpl 1995q4 2021q4

var var2.ls 1 2 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1 d01_01 d08_1 d01_4



	' Para corregir el Residuo 02

series d21_1 = 0

smpl 2021q1 2021q1

d21_1 = 1

smpl 1995q4 2021q4

var var2.ls 1 2 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1 d01_01 d08_1 d01_4 d21_1



' Aumentar un rezago no arregla la condición de normalidad, ni tampoco es estable

var var3.ls 1 3 tasasombra var_pbichina var_metalindex var_energyindex var_pbiperu var_ipc tasadeinteres var_tcbancario @ c d20_1 d01_01 d08_1 d01_4 d21_1

var3.arroots



' Condiciones del modelo VAR

	' Normalidad con test de Jarque Bera

freeze(var2_norm) var2.jbera


	' Test de Autocorrelación LM

freeze(var2_autoc) var2.arlm(10)


	' Test de heterocedasticidad White

freeze(var2_heteroc) var2.white


'SVAR empleando el criterior de  Cholesky
'freeze(var2_impulse) var2.impulse(24,se=a)

 		  'grafiquito1, impulso-respuesta
freeze(var2_impulse) var2.impulse(24,se=a)
freeze(var2_impulse_acum) var2.impulse(24,se=a) @imp 1 2 3 4 5 6 7 8

'Descomposicion de la Varianza

freeze(var2_dec_cholesky) var2.decomp(24)

'---------------------svar------------------------------


var2.cleartext(svar)
var2.append(svar) @VEC(S)=NA, NA, NA, NA, NA, NA, NA, NA, 0, NA, NA, NA, NA, NA, NA, NA, 0, 0,9.5, NA, 0.0522, NA, NA, NA, 0, 0 ,0 ,NA ,NA ,NA ,NA ,NA ,0 ,0 ,0 ,0 ,0.0414 ,NA ,NA ,-1.23 ,0 ,0 ,0 ,0, NA ,NA ,NA ,NA,0,0,0,0,0,0,NA,NA,0,0,0,0,NA,0,0,NA
' Si no converge, probar otros valores iniciales: var2.svar(f0=n)  /  var2.svar(f0=u)  /  var2.svar(f0=1)
var2.svar

'impulso respuesta svar
var2.impulse(24, imp=struct) 

'decomposion de la varianza struc
var2.decomp(24, m, imp=struct)


