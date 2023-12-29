import pandas as pd
import matplotlib.pyplot as plt

path = 'dataE.xls'

df = pd.read_excel(path)

sorted_data = df.sort_values(by='2022', ascending=False)
ua_data = df[df['Country Name'] == 'Ukraine']

top_10 = sorted_data.head(10)
bottom_10 = sorted_data.tail(10)

#Vytvoření grafu pro 10 největších a 10 nejmenších zemí pro každý rok
plt.figure(figsize=(12, 8))

for country in top_10['Country Name']:
    plt.plot(df.loc[df['Country Name'] == country, '1960':'2022'].columns, df.loc[df['Country Name'] == country, '1960':'2022'].values.flatten(), label=country)
for country in bottom_10['Country Name']:
    plt.plot(df.loc[df['Country Name'] == country, '1960':'2022'].columns, df.loc[df['Country Name'] == country, '1960':'2022'].values.flatten(), label=country)


plt.title('Vývoj počtu obyvatel ve vybraných zemích')
plt.xlabel('Rok')
plt.ylabel('Počet obyvatel')
plt.legend()
plt.ticklabel_format(style='plain', axis='y')
plt.xticks(df.columns[4::5])
plt.tight_layout()
plt.show()


#Procentuální změna od roku 2000 do 2022
df['Percent Change'] = ((df['2022'] - df['2000']) / df['2000']) * 100

sorted_data = df.sort_values(by='Percent Change', ascending=False)
top_5_growth = sorted_data.head(10)
bottom_5_growth = sorted_data.tail(10)

plt.figure(figsize=(15, 8))
for index, value in enumerate(top_5_growth['Percent Change']):
    plt.text(value, index, f'{value:.2f}%', va='center', fontsize=10)

for index, value in enumerate(bottom_5_growth['Percent Change']):
    plt.text(value, index + len(top_5_growth), f'{value:.2f}%', va='center', fontsize=10)

plt.barh(top_5_growth['Country Name'], top_5_growth['Percent Change'], color='green', label='Přírůstek')
plt.barh(bottom_5_growth['Country Name'], bottom_5_growth['Percent Change'], color='red', label='Pokles')
plt.title('Procentuální přírůstky a poklesy obyvatelstva ve vybraných státech')
plt.xlabel('Procentuální změna od roku 2000 do 2022 (%)')
plt.ylabel('Stát')
plt.legend()
plt.gca().invert_yaxis()  #protože se ty nejnižší zobrazovaly nahoře
plt.show()


#Trend za poslední rok
df['Percent Change'] = ((df['2022'] - df['2021']) / df['2021']) * 100
sorted_data = df.sort_values(by='Percent Change', ascending=False)
top_5_growth = sorted_data.head(5)
bottom_5_growth = sorted_data.tail(5)

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 12))

ax1.bar(df['Country Name'], df['Percent Change'], color='blue', label='Světový trend')
ax1.set_title('Procentuální změna průměrné populace za poslední rok')
ax1.set_ylabel('Trend změny populace za poslední rok (2021-2022)')
ax1.legend()
ax1.tick_params(axis='x', rotation=90)

for i, (country, percent_change) in enumerate(zip(top_5_growth['Country Name'], top_5_growth['Percent Change'])):
    ax2.bar(country, percent_change, color='green', label='Top 5' if i == 0 else '')
    ax2.text(country, percent_change, f'{percent_change:.2f}%', ha='center', va='bottom', color='black')

for i, (country, percent_change) in enumerate(zip(bottom_5_growth['Country Name'], bottom_5_growth['Percent Change'])):
    ax2.bar(country, percent_change, color='red', label='Spodních 5' if i == 0 else '')
    ax2.text(country, percent_change, f'{percent_change:.2f}%', ha='center', va='top', color='black')

ax2.set_title('5 nejvyšších přírůstků a poklesů obyvatelstva za poslední rok')
ax2.set_xlabel('Stát')
ax2.set_ylabel('Procentuální změna od roku 2021 do 2022 (%)')
ax2.legend()
ax2.tick_params(axis='x', rotation=45)
plt.tight_layout()
plt.show()


#Klouzavý průměr a error bary pro Ukrajinu
klouzavy_prumer = ua_data.iloc[:, 4:].rolling(3, axis=1).mean()

plt.figure(figsize=(12, 8))
plt.plot(ua_data.columns[4:], klouzavy_prumer.values.flatten(), label='Klouzavý průměr', color='red', linestyle='dashed')
plt.errorbar(ua_data.columns[4:], ua_data.values.flatten()[4:], yerr=ua_data.values.flatten()[4:] * 0.05, label='Error bary')

plt.title('Vývoj obyvatel na Ukrajině')
plt.xlabel('Rok')
plt.ylabel('Počet obyvatel')
plt.legend()
plt.ticklabel_format(style='plain', axis='y')
plt.xticks(df.columns[4::3])
plt.tight_layout()
plt.show()
