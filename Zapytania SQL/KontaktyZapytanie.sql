***KONTAKTY***

USE CDN;
SELECT 
	CDN.CRMKontakty.CRK_NumerPelny AS 'Numer Dokumentu',
	CDN.operatorzy.Ope_Kod AS 'Opiekun',
	CDN.CRMKontakty.CRK_Temat AS 'Temat',
	CDN.Kontrahenci.Knt_Kod AS 'Kontrahent',
	CDN.CRMKontakty.CRK_Opis AS 'Opis',

	CDN.DefEtapy.DEt_Kod AS 'Etap Realizacji',

	CASE
		WHEN CDN.CRMKontakty.CRK_Obsluga = 0
			THEN 'Przed Sprzeda��'
			ELSE 'Po Sprzeda�y'
	END AS 'Obsluga',

	CDN.CRMKontakty.CRK_OpeZalKod AS 'Kto Za�o�y�',
	CDN.CRMKontakty.CRK_OpeModKod AS 'Kto Ostatnio Zmodyfikowa�',

	CASE
		WHEN CDN.CRMKontakty.CRK_Bufor = 0
			THEN 'Zako�czono'
			ELSE 'Kontakt W Realizacji'
	END AS 'Bufor',

	CDN.CRMKontakty.CRK_TS_Zal AS 'Data Za�o�enia Dokumentu',

	CASE
		WHEN CDN.CRMKontakty.CRK_Zadanie = 0
			THEN 'Nie'
			ELSE 'Tak'
	END AS 'Czy Zadanie?',

	CDN.CRMKontakty.CRK_TerminOd AS 'Termin Od',
	CDN.CRMKontakty.CRK_TerminDo AS 'Termin Do',

	CASE 
		WHEN CDN.CRMKontakty.CRK_Zadanie = 1 AND CDN.CRMKontakty.CRK_Priorytet = 1 THEN 'Najwy�szy' 
		WHEN CDN.CRMKontakty.CRK_Zadanie = 1 AND CDN.CRMKontakty.CRK_Priorytet = 2 THEN 'Wysoki'
		WHEN CDN.CRMKontakty.CRK_Zadanie = 1 AND CDN.CRMKontakty.CRK_Priorytet = 3 THEN 'Niski'
		WHEN CDN.CRMKontakty.CRK_Zadanie = 1 AND CDN.CRMKontakty.CRK_Priorytet = 4 THEN 'Najni�szy'
		ELSE '' 
	END AS Priorytet,

	CAST((CDN.CRMKontakty.CRK_CzasKontaktu-'1899-12-30 00:00:00.000') as time(0)) AS 'Czas Kontaktu',
	CDN.CRMKontakty.CRK_DataDok AS 'Data Rozpocz�cia'
	

FROM 
	CDN.CRMKontakty JOIN 
				CDN.operatorzy ON CDN.CRMKontakty.CRK_OpiekunId = CDN.operatorzy.Ope_OpeID
			JOIN 
				CDN.Kontrahenci ON CDN.CRMKontakty.CRK_PodID = CDN.Kontrahenci.Knt_KntId
			JOIN
				CDN.DefEtapy ON CDN.CRMKontakty.CRK_EtapRealizacji = CDN.DefEtapy.DEt_DEtId
WHERE 
	CRK_TS_Zal > CAST(YEAR(getdate()) AS varchar(4)) + '-01-01 00:00:00.000';