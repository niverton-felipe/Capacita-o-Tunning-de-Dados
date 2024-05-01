CREATE TABLE METAS (
mes tinyint not null,
lj tinyint not null,
saldo varchar(20) not null,
meta varchar(20) not null
);
INSERT into METAS (mes, lj, saldo, meta) values
(4, 2, '153:59', '123:00:00'),
(4, 2, '25:33', '00:00:00'),
(4, 2, '29:57', '08:00'),
(4, 2, '38:58', '45:00:00'),
(4, 2, '94:47', '20:00'),
(4, 2, '23:41', '15:00:00'),
(4, 2, '215:37', '70:00:00'),
(4, 2, '213:41','120:00:00'),
(4, 2, '235:38','80:00:00'),
(4, 2, '36:13', '13:00:00');



declare @Mes int;
set @Mes= 4;

with
normalizaHMS as (
SELECT lj,
case len(saldo) - len(replace(saldo, ':', ''))
when 1 then saldo + ':00'
when 2 then saldo end as saldo,
case len(meta) - len(replace(meta, ':', ''))
when 1 then meta + ':00'
when 2 then meta end as meta
from METAS
where mes = @Mes
),
separaCampos as (
SELECT lj, saldo, meta,
cast(parsename(replace(saldo, ':', '.'), 3) as int) as saldoH,
cast(parsename(replace(saldo, ':', '.'), 2) as int) as saldoM,
cast(parsename(replace(meta, ':', '.'), 3) as int) as metaH,
cast(parsename(replace(meta, ':', '.'), 2) as int) as metaM
from normalizaHMS
),
somaCampos as (
SELECT lj,
sum(saldoH) as sum_saldoH,
sum(saldoM) as sum_saldoM,
sum(metaH) as sum_metaH,
sum(metaM) as sum_metaM
from separaCampos
group by lj
),
ajustaCampos as (
SELECT lj,
(sum_saldoH + (sum_saldoM / 60)) as sum_saldoH,
(sum_saldoM % 60) as sum_saldoM,
(sum_metaH + (sum_metaM / 60)) as sum_metaH,
(sum_metaM % 60) as sum_metaM
from somaCampos
)

SELECT @Mes as mes, lj,
cast(sum_saldoH as varchar) + ':' + right('00' + cast(sum_saldoM as varchar), 2) as saldo,
cast(sum_metaH as varchar) + ':' + right('00' + cast(sum_metaM as varchar), 2) as meta
from ajustaCampos;