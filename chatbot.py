#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 11:51:57 2020

@author: simplon
"""


import random
List_intro = ["How are you?", 
         "How was your day?"]
List_keyword = ["Dad", 
         "Mom", 
         "Buddy"]
List_keyword_respose = ["How's you %s?",
                        "Do you have a problem with %s",
                        "Why are you thinking about your %s right now?"]
List_Question = ["Why are you asking me this question?",
                  "Would you dare to ask this question to a human?",
                  "Unfortunately, I can not answer this question"]
List_Vague = ["I am listening",
              "I regret",
              "Is there a good news?",
              "Yes, that's the problem",
              "Do you mean it?",
              "Hmm... may be!"]
start_random = random.randint(0, len(List_intro)-1)
print(List_intro[start_random])

response = input()
while response != "":
    for word in List_keyword:
        if response.find(word) !=-1:
            rp = random.randint(0, len(List_keyword_respose)-1)
            response = input(List_keyword_respose[rp].format(mot))
    if response.find("?") != -1:
        rp = random.randint(0, len(response_List_Question)-1)
        reponse = input(response_List_Questions[rp])
    else:
        rp = random.randint(0,len(List_Vague)-1)
        response = input(List_Vague[rp])