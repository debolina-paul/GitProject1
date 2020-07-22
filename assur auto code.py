import sqlalchemy as db
# -*- coding: utf-8 -*-
"""
Éditeur de Spyder

Ceci est un script temporaire.

import mysql.connector as mysql

"""




import sqlalchemy as sal
from sqlalchemy import create_engine
import pandas as pd


from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://newuser:Simplon1821!@localhost/Simplon')
n = pd.read_sql_query("select * from jeux_video",engine)
print(n)


engine = create_engine('mysql+pymysql://newuser:Simplon1821!@localhost/assure auto')
A = pd.read_sql_query("select * from clients",engine)
print(A)



CL_ID=pd.read_sql_query('SELECT max(CL_ID) as max FROM clients', engine)['max']
CL_ID = CL_ID[0] + 1

CL_Nom = input("Enter nom")
CL_Prenom = input("Enter Prenom")
CL_Adresse = input("Enter Adress")
CL_Vill = input("Enter vill")
CL_Tel = input("Enter Tel number")
code_pos = input ("Enter code postal")

while not(code_pos.isdigit()):
    print("want to insert a number")
    code_pos=input("type the code postal of the client")


engine.execute('INSERT INTO clients (CL_ID, CL_Nom, CL_Prenom, CL_Adresse, CL_Vill, CL_Tel, code_postal) VALUES (%s,"%s", "%s","%s", "%s", "%s", "%s");' %(CL_ID ,CL_Nom.upper(), CL_Prenom.upper(), CL_Adresse, CL_Vill, CL_Tel, code_pos))



B = pd.read_sql_query("select * from contrat",engine)
print(B)


CO_ID=pd.read_sql_query('SELECT max(CO_ID) FROM contrat', engine)
CO_ID = CO_ID.iloc[0,0]
if(CO_ID == None):
    CO_ID = 0
CO_ID = CO_ID +1

CO_DATE = "2020-12-06"
CO_catagorie = input("Enter catagory")
CO_avenant = input("Enter avenant")
CO_bonus = input("Enter bonus")
CO_Manus = input("Enter manus")
CL_ID_FK = CL_ID


engine.execute('INSERT INTO contrat (CO_ID, CO_DATE, CO_catagorie, CO_avenant, CO_Bonus, CO_Minus, CL_ID_FK ) VALUES (%s, "%s", "%s", "%s","%s", "%s", %s);' %(CO_ID,CO_date,CO_catagorie,CO_avenant,CO_bonus,CO_Manus, CL_ID_FK ))


