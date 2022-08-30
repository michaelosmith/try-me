SELECT
	client_id
	, contract_nr
	, MAX(sum_days) AS client_contract_length
FROM (	
	SELECT *, sum(contract_days) OVER (PARTITION BY client_id, contract_nr ORDER BY end_date) AS sum_days
	FROM  (
	   SELECT *, count(*) FILTER (WHERE NOT continous_contract) OVER (PARTITION BY client_id ORDER BY end_date) AS contract_nr
	   FROM  (
		  SELECT client_id, start_date, end_date
			   , start_date <= lag(end_date, 1, end_date) OVER (PARTITION BY client_id ORDER BY end_date) + 1 AS continous_contract
			   , (end_date - start_date) AS contract_days
		  FROM   client_contracts
		  ) sub1
	   ) sub2
	) sub3
GROUP BY client_id, contract_nr
ORDER BY client_id