Select `Type`, YearModel
From Motorbikes
where YearModel = (
	Select min(YearModel) from Motorbikes
);

/*Select `Type`, YearModel
From Motorbikes
order by YearModel asc limit 1;*/


