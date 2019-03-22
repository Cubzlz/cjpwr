# cjpwr
`cjpwr` includes two very simple functions:  

- `pwr()` carries out a simple power analysis for conjoint designs.   
- `pwr-n()` tells you what sample size you need, given your design, to have acceptable power.

`pwr()` takes four arguments: `n` (sample size), `t` (number of choice tasks per respondent), `a` (number of alternatives per choice task), and `c` (number of analysis cells - equal to largest number of possible levels for any one feature, or the largest product of levels of any two attributes for power of two-way interaction estimates). It simply divides `t*n*a` by `c`. The output of `pwr` includes the result of this calculation, and two statements telling you whether your design exceeds the minimal minimum threshold (500) and the ideal minimum threshold (1000). 

`pwr_n()` takes only `t`, `a`, and `c`. It returns two `n` values - one for the minimal and one for the ideal threshold.

The calculation is based on recommendations from Orme (2010) and Johnson and Orme (2003).
