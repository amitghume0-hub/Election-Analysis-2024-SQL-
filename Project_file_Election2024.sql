select * from const_details;
select * from consti_result;
select * from state_result;
select * from states;
select * from party_result;

--Q Total seats in Constituency ?
select 
    distinct count(PARLIAMENT_CONSTITUENCY) as total_seats
    from consti_result;

--Q.1 What is the total number of seats available for elections in each state?

SELECT 
    s.State AS State_Name,
    COUNT(cr.Constituency_ID) AS Avl_Seats
FROM 
    consti_result cr
inner JOIN 
    state_result sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
inner JOIN 
    states s ON sr.State_ID = s.State_ID
GROUP BY 
    s.State
ORDER BY 
    s.State;


--Q.2 Total Seats Won by NDA Allianz ?


select 
    sum(case when party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP',                                -- all the data collect from google
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
    then won
    else 0
    end) as Seats_won
    from party_result;
            

--Q.3 Seats Won by NDA Allianz Parties ?

select party as party_name,
won as seats_won
from party_result
where  party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP',                                -- all the data collect from google
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
order by won desc;



--Q.4 Total Seats Won by I.N.D.I.A. Allianz

select 
    sum(case  
        when party in(
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                --'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                --'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
            then won
            else 0
            end) seat_won
        from party_result;



--Q.5 Seats Won by I.N.D.I.A. Allianz Parties ?

select party as party_name,
won as seats_won
from party_result
where party in ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                --'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                --'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
            order by won desc;

--Q.6 Add new column field in table party_result to get the Party Allianz as NDA, I.N.D.I.A and OTHER

Alter table party_result
    add party_alliance varchar(50);
update party_result
    set party_alliance = 'I.N.D.I.A'
    where party in('Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    --'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

update party_result
set party_alliance = 'NDA'
where party in('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP',                                -- all the data collect from google
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM');

update party_result
set party_alliance='other'
where party_alliance is null;



--Q.7 Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select 
    p.party_alliance,
    count(cr.CONSTITUENCY_ID)as seats_won
from 
    consti_result  cr
join party_result p
    on cr.party_id = p.party_id
where p.party_alliance in('NDA','I.N.D.I.A','other')
group by p.party_alliance
order by seats_won;


--Q.8 Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

select
    cr.WINNING_CANDIDATE as candidate_name,
    p.party,
    cr.TOTAL_VOTES,
    cr.margin as margin_of_victory,
    cr.Constituency_Name,
    s.state
from 
     consti_result cr
JOIN party_result p ON cr.Party_ID = p.Party_ID
JOIN state_result sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.State = 'Uttar Pradesh' AND cr.Constituency_Name = 'AMETHI';


--Q.9 What is the distribution of EVM votes versus postal votes for candidates in a specific constituency ?

select
    cd.candidate,
    cd.party,
    cd.EVM_VOTES,
    cd.postal_votes,
    cd.total_votes,
    cr.Constituency_Name
from 
    const_details cd
join 
    consti_result cr on cd.Constituency_ID = cr.Constituency_ID
where 
    cr.Constituency_Name = 'MATHURA'
order by 
    cd.total_votes desc;

--Q.10 Which parties won the most seats in s State, and how many seats did each party win ?
select
     p.party,
    count(cr.constituency_id)as seats_won
from
    consti_result cr
join
    party_result p on cr.party_id = p.party_id
join
    state_result sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join
    states s on sr.STATE_ID  = s.STATE_ID
where
    s.state = 'Andhra Pradesh'
group by p.party
order by seats_won desc;


--Q.11 What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024 ?


SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    consti_result cr
JOIN 
    party_result p ON cr.Party_ID = p.Party_ID
JOIN 
    state_result sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A', 'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;
 
--Q12. Which candidate received the highest number of EVM votes in each constituency (Top 10) ?

select 
    cr.CONSTITUENCY_NAME,
    cd.CONSTITUENCY_ID,
    cd.candidate,
    cd.evm_votes

from 
    const_details cd
join
    consti_result cr on cd.CONSTITUENCY_ID = cr.CONSTITUENCY_ID
where 
    cd.evm_votes = (
    select max(cd1.evm_votes)
    from const_details cd1
    where cd1.CONSTITUENCY_ID = cd.CONSTITUENCY_ID)
order by cd.evm_votes desc;


--Q.13 Which candidate won and which candidate was the runner-up 
--in each constituency of State for the 2024 elections?

WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        const_details cd
    JOIN 
        consti_result cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        state_result sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Gujarat')
SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    consti_result cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;


--Q.14 For the state of Maharashtra, what are the total number of seats, total number of candidates,
--total number of parties,total votes (including EVM and postal), and the breakdown of EVM and postal votes ?

SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    consti_result cr
JOIN 
    const_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    state_result sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    party_result p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';

select * from const_details;
select * from consti_result;
select * from state_result;
select * from states;
select * from party_result;






