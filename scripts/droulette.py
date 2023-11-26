#!/usr/bin/python3

import random

number_of_shots=100
bet_red=True
bet_color=True
bet_1_to_18=True
bet_high_low=True
bet_even=True
bet_even_odd=True
beginning_units=100
current_bet_red=0
current_bet_even=0
current_bet_1_to_18=0
winning_cnt_red=0
winning_cnt_even=0
winning_cnt_1_to_18=0

red_numbers=[1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
black_numbers=[2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]

def place_bet(current_bet):
    global beginning_units
    if (current_bet == 0):
        current_bet += 1
        beginning_units -= 1
    #print('placing bet current bet: ' + str(current_bet))
    return current_bet

def won_bet(current_bet, winning_cnt):
    global beginning_units
    current_bet = current_bet * 2
    if (winning_cnt == 1):
        beginning_units += 1
        current_bet = 1
    elif (winning_cnt == 2):
        cash_amt = 0
        print('cash unit amount: ' + str(cash_amt) + ', total units: ' + str(beginning_units))
    else:
        cash_amt = winning_cnt - 2
        beginning_units = beginning_units + cash_amt
        current_bet = current_bet - cash_amt
        print('cash unit amount: ' + str(cash_amt) + ', total units: ' + str(beginning_units))
    #print('won bet current bet: ' + str(current_bet))
    return current_bet

def lost_bet(current_bet):
    current_bet = 0
    #print('lost bet current bet: ' + str(current_bet))
    return current_bet

for x in range(number_of_shots):

    print('===================================================================')

    number = random.randint(0,37)

    if (bet_color):
        current_bet_red = place_bet(current_bet_red)
        print('placing red bet. Current bet: ' + str(current_bet_red) + ', total units: ' + str(beginning_units))
    if (bet_even_odd):
        current_bet_even = place_bet(current_bet_even)
        print('placing even bet. Current bet: ' + str(current_bet_even) + ', total units: ' + str(beginning_units))
    if (bet_high_low):
        current_bet_1_to_18 = place_bet(current_bet_1_to_18)
        print('placing 1 to 18 bet. Current bet: ' + str(current_bet_1_to_18) + ', total units: ' + str(beginning_units))

    print('total units ' + str(beginning_units))
    
    if number == 37:
        print("00 - Double Zero" + ', total units: ' + str(beginning_units))
        if (bet_color):
            current_bet_red = lost_bet(current_bet_red)
            winning_cnt_red = 0
            print('lost red bet. Current bet: ' + str(current_bet_red) + ', total units: ' + str(beginning_units))
        if (bet_even_odd):
            current_bet_even = lost_bet(current_bet_even)
            winning_cnt_even = 0
            print('lost even bet. Current bet: ' + str(current_bet_even) + ', total units: ' + str(beginning_units))
        current_bet_1_to_18 = lost_bet(current_bet_1_to_18)
        winning_cnt_1_to_18 = 0
        print('lost 1 to 18 bet. Current bet: ' + str(current_bet_1_to_18) + ', total units: ' + str(beginning_units))
        continue
    if number == 0:
        print('0 - Zero' + ', total units: ' + str(beginning_units))
        if (bet_color):
            current_bet_red = lost_bet(current_bet_red)
            winning_cnt_red = 0
            print('lost red bet. Current bet: ' + str(current_bet_red) + ', total units: ' + str(beginning_units))
        if (bet_even_odd):
            current_bet_even = lost_bet(current_bet_even)
            winning_cnt_even = 0
            print('lost even bet. Current bet: ' + str(current_bet_even) + ', total units: ' + str(beginning_units))
        current_bet_1_to_18 = lost_bet(current_bet_1_to_18)
        winning_cnt_1_to_18 = 0
        print('lost 1 to 18 bet. Current bet: ' + str(current_bet_1_to_18) + ', total units: ' + str(beginning_units))
        continue
    
    is_red = False
    is_even = False
    is_1_to_18 = False

    print('number: ' + str(number) + ', ', end='')
    if number in red_numbers:
        print('RED, ', end='')
        is_red = True
    else:
        print('BLACK, ', end='')
        is_red = False
    
    if number % 2 == 0:
        print('EVEN, ', end='')
        is_even = True
    else:
        print('ODD, ', end='')
        is_even = False
    
    if number >= 1 and number <= 18:
        print('1 to 18')
        is_1_to_18 = True
    else:
        print('19 to 36')
        is_1_to_18 = False

    if (bet_color):
        if (is_red is True and bet_red is True):
            winning_cnt_red += 1
            current_bet_red = won_bet(current_bet_red, winning_cnt_red)
            print('won red bet. Current bet: ' + str(current_bet_red) + ', winning count: ' + str(winning_cnt_red) + ', total units: ' + str(beginning_units))
        if (is_red is False and bet_red is True):
            winning_cnt_red = 0
            current_bet_red = lost_bet(current_bet_red)
            print('lost red bet. Current bet: ' + str(current_bet_red) + ', winning count: ' + str(winning_cnt_red) + ', total units: ' + str(beginning_units))
        if (is_red is False and bet_red is False):
            winning_cnt_red += 1
            current_bet_red = won_bet(current_bet_red, winning_cnt_red)
            print('won black bet. Current bet: ' + str(current_bet_red) + ', winning count: ' + str(winning_cnt_red) + ', total units: ' + str(beginning_units))
        if (is_red is True and bet_red is False):
            winning_cnt_red = 0
            current_bet_red = lost_bet(current_bet_red)
            print('lost black bet. Current bet: ' + str(current_bet_red) + ', winning count: ' + str(winning_cnt_red) + ', total units: ' + str(beginning_units))

    if (bet_even_odd):
        if (is_even is True and bet_even is True):
            winning_cnt_even += 1
            current_bet_even = won_bet(current_bet_even, winning_cnt_even)
            print('won even bet. Current bet: ' + str(current_bet_even) + ', winning count: ' + str(winning_cnt_even) + ', total units: ' + str(beginning_units))
        if (is_even is False and bet_even is True):
            winning_cnt_even = 0
            current_bet_even = lost_bet(current_bet_even)
            print('lost even bet. Current bet: ' + str(current_bet_even) + ', winning count: ' + str(winning_cnt_even) + ', total units: ' + str(beginning_units))
        if (is_even is False and bet_even is False):
            winning_cnt_even += 1
            current_bet_even = won_bet(current_bet_even, winning_cnt_even)
            print('won odd bet. Current bet: ' + str(current_bet_even) + ', winning count: ' + str(winning_cnt_even) + ', total units: ' + str(beginning_units))
        if (is_even is True and bet_even is False):
            winning_cnt_even = 0
            current_bet_even = lost_bet(current_bet_even)
            print('lost odd bet. Current bet: ' + str(current_bet_even) + ', winning count: ' + str(winning_cnt_even) + ', total units: ' + str(beginning_units))

    if (bet_high_low):
        if (is_1_to_18 is True and bet_1_to_18 is True):
            winning_cnt_1_to_18 += 1
            current_bet_1_to_18 = won_bet(current_bet_1_to_18, winning_cnt_1_to_18)
            print('won 1 to 18 bet. Current bet: ' + str(current_bet_1_to_18) + ', winning count: ' + str(winning_cnt_1_to_18) + ', total units: ' + str(beginning_units))
        if (is_1_to_18 is False and bet_1_to_18 is True):
            winning_cnt_1_to_18 = 0
            current_bet_1_to_18 = lost_bet(current_bet_1_to_18)
            print('lost 1 to 18 bet. Current bet: ' + str(current_bet_1_to_18) + ', winning count: ' + str(winning_cnt_1_to_18) + ', total units: ' + str(beginning_units))
        if (is_1_to_18 is False and bet_1_to_18 is False):
            winning_cnt_1_to_18 += 1
            current_bet_1_to_18 = won_bet(current_bet_1_to_18, winning_cnt_1_to_18)
            print('won 19 to 36 bet. Current bet: ' + str(current_bet_1_to_18) + ', winning count: ' + str(winning_cnt_1_to_18) + ', total units: ' + str(beginning_units))
        if (is_1_to_18 is True and bet_1_to_18 is False):
            winning_cnt_1_to_18 = 0
            current_bet_1_to_18 = lost_bet(current_bet_1_to_18)
            print('lost 19 to 36 bet. Current bet: ' + str(current_bet_1_to_18) + ', winning count: ' + str(winning_cnt_1_to_18) + ', total units: ' + str(beginning_units))
