# require_relative '../support/helper_methods'
# require 'json'
# require 'rspec'
#
# string = '{
#     "version": 1,
#     "id": "nm0002071",
#     "fullName": "Will Ferrell",
#     "characters": [
#         {
#             "id": 106106,
#             "movieId": "tt4481514",
#             "personId": "nm0002071",
#             "fullName": "[\"Scott Johansen\"]"
# },
#     {
#         "id": 143568,
#         "movieId": "tt3685236",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 73941,
#         "movieId": "tt2561572",
#         "personId": "nm0002071",
#         "fullName": "[\"James\"]"
#     },
#     {
#         "id": 46752,
#         "movieId": "tt1092633",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 67584,
#         "movieId": "tt1855401",
#         "personId": "nm0002071",
#         "fullName": "[\"Damien Weebs\"]"
#     },
#     {
#         "id": 57256,
#         "movieId": "tt1001526",
#         "personId": "nm0002071",
#         "fullName": "[\"Megamind\"]"
#     },
#     {
#         "id": 102371,
#         "movieId": "tt0457400",
#         "personId": "nm0002071",
#         "fullName": "[\"Dr. Rick Marshall\"]"
#     },
#     {
#         "id": 103378,
#         "movieId": "tt1608290",
#         "personId": "nm0002071",
#         "fullName": "[\"Jacobim Mugatu\"]"
#     },
#     {
#         "id": 19057,
#         "movieId": "tt1920849",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 121550,
#         "movieId": "tt1702425",
#         "personId": "nm0002071",
#         "fullName": "[\"Armando\"]"
#     },
#     {
#         "id": 144305,
#         "movieId": "tt1528854",
#         "personId": "nm0002071",
#         "fullName": "[\"Brad Whitaker\"]"
#     },
#     {
#         "id": 32116,
#         "movieId": "tt6266538",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 144675,
#         "movieId": "tt3165612",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 23407,
#         "movieId": "tt5657846",
#         "personId": "nm0002071",
#         "fullName": "[\"Brad\"]"
#     },
#     {
#         "id": 139467,
#         "movieId": "tt1490017",
#         "personId": "nm0002071",
#         "fullName": "[\"Lord Business\",\"President Business\",\"The Man Upstairs\"]"
#     },
#     {
#         "id": 84953,
#         "movieId": "tt1255919",
#         "personId": "nm0002071",
#         "fullName": "[\"Sherlock Holmes\"]"
#     },
#     {
#         "id": 157148,
#         "movieId": "tt2103254",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 121577,
#         "movieId": "tt1695994",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 56390,
#         "movieId": "tt2788716",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 150485,
#         "movieId": "tt1531663",
#         "personId": "nm0002071",
#         "fullName": "[\"Nick Halsey\"]"
#     },
#     {
#         "id": 7381,
#         "movieId": "tt1386588",
#         "personId": "nm0002071",
#         "fullName": "[\"Allen Gamble\"]"
#     },
#     {
#         "id": 64953,
#         "movieId": "tt1790886",
#         "personId": "nm0002071",
#         "fullName": "[\"Rep. Camden Cam Brady\"]"
#     },
#     {
#         "id": 74839,
#         "movieId": "tt1428538",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     },
#     {
#         "id": 11917,
#         "movieId": "tt1229340",
#         "personId": "nm0002071",
#         "fullName": "[\"Ron Burgundy\"]"
#     },
#     {
#         "id": 35450,
#         "movieId": "tt2702724",
#         "personId": "nm0002071",
#         "fullName": "\\N"
#     }
# ]
# }'
#
#
# string1 = '[
#     {
#         "version": 1,
#         "id": "nm0000093",
#         "fullName": "Brad Pitt",
#         "description": "An actor and producer known as much for his versatility as he is for his handsome face, Golden Globe-winner Brad Pitts most widely recognized role may be Tyler Durden in Fight Club (1999). However, his portrayals of Billy Beane in Moneyball (2011), and Rusty Ryan in the remake of Oceans Eleven (2001) and its sequels, also loom large in his ...",
#         "birthDate": -190598400,
#         "characters": [
#             {
#                 "id": 178434,
#                 "movieId": "tt4016250",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Brad Pitt\"]"
#             },
#             {
#                 "id": 202917,
#                 "movieId": "tt2713180",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Don Wardaddy Collier\"]"
#             },
#             {
#                 "id": 180510,
#                 "movieId": "tt2024544",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Bass\"]"
#             },
#             {
#                 "id": 190040,
#                 "movieId": "tt1764234",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Jackie\"]"
#             },
#             {
#                 "id": 198617,
#                 "movieId": "tt1596363",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Ben Rickert\"]"
#             },
#             {
#                 "id": 165518,
#                 "movieId": "tt3640424",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Max Vatan\"]"
#             },
#             {
#                 "id": 168462,
#                 "movieId": "tt1210166",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Billy Beane\"]"
#             },
#             {
#                 "id": 181182,
#                 "movieId": "tt4758646",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Glen McMahon\"]"
#             },
#             {
#                 "id": 186121,
#                 "movieId": "tt0361748",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Lt. Aldo Raine\"]"
#             },
#             {
#                 "id": 195660,
#                 "movieId": "tt0478304",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Mr. OBrien\"]"
#             },
#             {
#                 "id": 168995,
#                 "movieId": "tt1001526",
#                 "personId": "nm0000093",
#                 "fullName": "[Metro Man]"
#             },
#             {
#                 "id": 207239,
#                 "movieId": "tt0816711",
#                 "personId": "nm0000093",
#                 "fullName": "[Gerry Lane]"
#             },
#             {
#                 "id": 177037,
#                 "movieId": "tt3707106",
#                 "personId": "nm0000093",
#                 "fullName": "[\"Roland\"]"
#             }
# ]
# }
# ]'
#
#
# @response_body = JSON.parse(string1)
# # value_to_be_extractd = @response_body['characters'][1]['id'].to_s
# #
# # p value_to_be_extractd
#
# p @response_body[0]["characters"].map {|h1| h1['movieId'] if h1['id']==178434}.compact.first
#
# # value_chr = @response_body['characters'].find {|h1| h1['key']=='tt4481514'}['movieId']
# #
# # p "value_chr: #{value_chr}"
#
#
# #
# # s =  '{"incidents": [{"number": 1,"status": "open","key": "abc123"},{"number": 2,"status": "open","key": "xyz098"},{"number": 3,"status": "closed","key": "lmn456"}]}'
#
# # s = '{"version": 1, "id": "nm0002071", "fullName": "Will Ferrell", "characters": [{"id": 106106, "movieId": "tt4481514", "personId": "nm0002071","fullName": "[\"Scott Johansen\"]"},{"id": 143568,"movieId": "tt3685236","personId": "nm0002071","fullName": "N\"}]}'
# # # Parse the JSON
# #
# # p h = JSON.parse(s)
# # # Find the required number using map
# #
# #
# # p h["characters"].map {|h1| h1['id'] if h1['movieId']=='tt3685236'}.compact.first
#
# # p h["incidents"].map {|h1| h1['number'] if h1['key']=='xyz098'}.compact.first
# # # Or you could also use find as below
# #
# # h["incidents"].find {|h1| h1['key']=='xyz098'}['number']
# # # Or you could also use select as below
# #
# # h["incidents"].select {|h1| h1['key']=='xyz098'}.first['number']