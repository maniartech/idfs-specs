
## Intuitive Date Format Specifiers (IDFS)

We've developed the Intuitive Date Format Specifiers (IDFS) for `gotime`. `IDFS is a cAsE-insensitive format`, eliminating ambiguity often associated with dd-mm-yyyy formats. This intuitive specifiers makes date and time formatting simple and hackable. entry by removing the need to remember upper and lower case attributes, a common issue with other similar formats. For example, %Y represents a four-digit year, while %y denotes a two-digit year in strftime. In contrast, IDFS intuitively uses yyyy for a four-digit year and yy for a two-digit year. Typing dates is also more straightforward with IDFS, as the format yyyy-mm-dd is easier to remember and input compared to the less intuitive 2006-01-02.

It supports simple, human-friendly date-time formatting. The table below displays the supported formats. Internally, `gotime` utilizes time.Time.Format() and converts human-friendly formats into the time.Time format. For instance, it transforms yyyy-mm-dd into 2006-01-02 before using time.Time.Format() to format the date.

### Date Formats

| Format | Output   | Description                                   |
| ------ | -------- | --------------------------------------------- |
| `y`    | `6`      | Year without century with leading zero        |
| `yy`   | `06`     | Two-digit year with leading zero              |
| `yt`   | `6th`    | Year in ordinal format                        |
| `yb`   | ` 6`     | Year in blank-padded two digits               |
| `yyyy` | `2006`   | Four-digit year                               |
| `m`    | `1`      | Month without leading zero                    |
| `mm`   | `01`     | Month in two digits with leading zero         |
| `mt`   | `1st`    | Month in ordinal format (not for parsing)     |
| `mb`   | ` 1`     | Month in blank-padded two digits              |
| `mmm`  | `Jan`    | Month in short name                           |
| `mmmm` | `January`| Month in full name                            |
| `w`    | `1`      | Week of the year without leading zero         |
| `ww`   | `01`     | Week of the year with leading zero            |
| `wt`   | `1st`    | Week of the year in ordinal format            |
| `wb`   | ` 1`     | Week of the year in blank-padded two digits   |
| `www`  | `Mon`    | Three-letter weekday name                     |
| `wwww` | `Monday` | Full weekday name                             |
| `d`    | `2`      | Day without leading zero                      |
| `dd`   | `02`     | Day in two digits with leading zero           |
| `db`   | `2`      | Day in blank-padded two digits                |
| `dt`   | `2nd`    | Day in ordinal format (not for parsing)       |
| `ddd`  | `002`    | Zero padded day of year                       |

### Time Formats

| Format | Output | Description                                      |
| ------ | ------ | ------------------------------------------------ |
| `h`    | `3`    | Hour in 12-hour format without leading zero      |
| `hh`   | `03`   | Hour in 12-hour format with leading zero         |
| `ht`   | `3rd`  | Hour in ordinal format                           |
| `hb`   | ` 3`   | Hour in blank-padded two digits                  |
| `hhh`  | `15`   | Hour in 24-hour format without leading zero      |
| `i`    | `4`    | Minute without leading zero                      |
| `ii`   | `04`   | Minute with leading zero                         |
| `it`   | `4th`  | Minute in ordinal format                         |
| `ib`   | ` 4`   | Minute in blank-padded two digits                |
| `s`    | `5`    | Second without leading zero                      |
| `ss`   | `05`   | Second with leading zero                         |
| `st`   | `5th`  | Second in ordinal format                         |
| `sb`   | ` 5`   | Second in blank-padded two digits                |
| `a`    | `pm`   | AM/PM in lowercase                               |
| `aa`   | `PM`   | AM/PM in uppercase                               |
| `0`    | `0`    | Single microsecond digit without leading zero, can be combined with more zeros to represent more digits. For example, `000` represents three zero-padded microsecond digits, and `000000` represents six zero-padded microsecond digits. |
| `9`    | `9`    | Single microsecond digit without leading zero, can be combined with more nines to represent more digits. For example, `999` represents three nine-padded microsecond digits, and `999999` represents six nine-padded microsecond digits. |

### Timezone Formats

| Format | Output  | Description                                        |
| ------ | ------- | -------------------------------------------------- |
| `z`    | `Z`     | The Z literal represents UTC                       |
| `zz`   | `MST`   | Timezone abbreviation                              |
| `o`    | `±07`   | Timezone offset with leading zero (only hours)     |
| `oo`   | `±0700` | Timezone offset with leading zero without colon    |
| `ooo`  | `±07:00`| Timezone offset with leading zero with colon       |

#### The conventions followed by IDFS specifiers design

- When a `single character specifier` is used, it is without leading zero or padding. For example, `y`, `m`, `d`, `h`, `i`, `s` represent year, month, day, hour, minute, and second without leading zero or padding respectively.
- When `two characters of same family (consicutively)` are used, they are padded with leading zeros. For example, `yy`, `mm`, `dd`, `hh`, `ii`, `ss` represent two-digit year, month, day, hour, minute, and second with leading zeros respectively.
- When `b suffix` is used, it is blank-padded with leading zeros. For example, `yb`, `mb`, `db` represent two-digit year, month, and day with leading space padding respectively.
-
