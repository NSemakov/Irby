//
//  SongController.swift
//  Irby
//
//  Created by John Smith on 04.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import UIKit

class SongController: UIViewController
{
// MARK: - Init
    
    // ...
    
// MARK: - Properties
    
    @IBOutlet weak var songTextView: UITextView!
    
// MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.songTextView.text = self.chooseSongText(self.song)
    }
    
    func setTitleString(_ string: String) {
        self.navigationItem.title = string
        self.song = string
    }
    
// MARK: - Private Functions 
    
    private func chooseSongText(_ string: String?) -> String
    {
        guard let string = string else { return "" }
        switch string {
        case Commons.SkilletBackFromDead:
            return "[Intro:] \n" +
            "[Вступление:]\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "[Verse 1:]\n" +
                "[Куплет 1:]\n" +
                "Cold and black inside this coffin\n" +
                "В этом гробу темно и холодно,\n" +
                "‘Cause you all try to keep me down.\n" +
                "Вы же все пытаетесь не дать мне подняться.\n" +
                "How it feels to be forgotten?\n" +
                "Каково это быть забытым?\n" +
                "But you'll never forget me now!\n" +
                "Но теперь вы никогда меня не забудете!\n" +
                "Enemies clawing at my eyes,\n" +
                "Враги пытаются выцарапать мне глаза,\n" +
                "I scratch and bleed, just to stay alive, yeah!\n" +
                "Я скребусь и истекаю кровью лишь бы выжить, да!\n" +
                "The zombies come out at night,\n" +
                "Зомби выходят по ночам,\n" +
                "They'll never catch me,\n" +
                "Им никогда не поймать меня,\n" +
                "They'll never catch me.\n" +
                "Им никогда не поймать меня.\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "[Chorus:]\n" +
                "[Припев:]\n" +
                "Light it up, light it up, now I'm burning,\n" +
                "Разжигайте, разжигайте огонь, сейчас я пылаю,\n" +
                "Feel the rush, feel the rush of adrenaline,\n" +
                "Ощутите трепет, ощутите прилив адреналина,\n" +
                "We are young, we are strong, we will rise\n" +
                "Мы молоды, мы сильны, мы восстанем,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "To the floor, to the floor, hit the red line,\n" +
                "На танцпол, на танцпол, до предела,\n" +
                "Flying high, flying high at the speed of light,\n" +
                "Летим высоко, высоко, на скорости света,\n" +
                "Full of love, full of light, full of fight\n" +
                "Наполнен любовью, наполнен светом, наполнен светом,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "[Verse 2:]\n" +
                "[Куплет 2:]\n" +
                "Break the skin, spread like poison,\n" +
                "Прорвём кожу, растечёмся под ней, как яд,\n" +
                "Dying slow when we all attack.\n" +
                "Они будет медленно умирать, когда мы все ринемся в атаку.\n" +
                "How it feels to be the broken?\n" +
                "Каково это, быть сломленным?\n" +
                "You took a piece now I'm biting back.\n" +
                "Ты отхватил кусок, а теперь я кусаюсь в ответ.\n" +
                "Enemies clawing at my eyes,\n" +
                "Враги пытаются выцарапать мне глаза,\n" +
                "I scratch and bleed, just to stay alive, yeah!\n" +
                "Я скребусь и истекаю кровью лишь бы выжить, да!\n" +
                "The zombies come out at night,\n" +
                "Зомби выходят по ночам,\n" +
                "They'll never catch me,\n" +
                "Им никогда не поймать меня,\n" +
                "They'll never catch me.\n" +
                "Им никогда не поймать меня,\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес\n" +
                "[Chorus:]\n" +
                "[Припев:]\n" +
                "Light it up, light it up, now I'm burning,\n" +
                "Разжигайте, разжигайте огонь, сейчас я пылаю,\n" +
                "Feel the rush, feel the rush of adrenaline,\n" +
                "Ощутите трепет, ощутите прилив адреналина,\n" +
                "We are young, we are strong, we will rise\n" +
                "Мы молоды, мы сильны, мы восстанем,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "To the floor, to the floor, hit the red line,\n" +
                "На танцпол, на танцпол, до предела,\n" +
                "Flying high, flying high at the speed of light,\n" +
                "Летим высоко, высоко, на скорости света,\n" +
                "Full of love, full of light, full of fight\n" +
                "Наполнен любовью, наполнен светом, наполнен светом,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "[Bridge:]\n" +
                "[Переход:]\n" +
                "Deep down, for the count, don't you dare cut me out,\n" +
                "Почти в отключке, не могу встать, но даже не вздумайте списывать меня,\n" +
                "Never break, never bow,\n" +
                "Никогда не сломаюсь, никогда не склонюсь,\n" +
                "Never beg, not a doubt.\n" +
                "Никогда не буду умолять, несомненно.\n" +
                "The zombies come out at night,\n" +
                "Зомби выходят по ночам,\n" +
                "They'll never catch me,\n" +
                "Им никогда не поймать меня,\n" +
                "They'll never catch me.\n" +
                "Им никогда не поймать меня.\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "[Chorus:]\n" +
                "[Припев:]\n" +
                "Light it up, light it up, now I'm burning,\n" +
                "Разжигайте, разжигайте огонь, сейчас я пылаю,\n" +
                "Feel the rush, feel the rush of adrenaline,\n" +
                "Ощутите трепет, ощутите прилив адреналина,\n" +
                "We are young, we are strong, we will rise\n" +
                "Мы молоды, мы сильны, мы восстанем,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "To the floor, to the floor, hit the red line,\n" +
                "На танцпол, на танцпол, до предела,\n" +
                "Flying high, flying high at the speed of light,\n" +
                "Летим высоко, высоко, на скорости света,\n" +
                "Full of love, full of light, full of fight\n" +
                "Наполнен любовью, наполнен светом, наполнен светом,\n" +
                "‘Cause I'm back, back, back from the dead tonight!\n" +
                "Ведь сегодня я воскрес, воскрес, воскрес из мёртвых!\n" +
                "[Outro:]\n" +
                "[Заключение:]\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "Dead tonight.\n" +
                "Мёртвых сегодня.\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "Back from the dead tonight.\n" +
                "Сегодня воскрес из мёртвых.\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "Dead tonight.\n" +
                "Мёртвых сегодня.\n" +
                "B-b-b-b-b-back-back-back!\n" +
                "В-в-в-воскрес, воскрес, воскрес!\n" +
                "Back from the dead tonight.\n" +
                "Сегодня воскрес из мёртвых.\n" +
                "Источник: http://www.Irby-lab.com/songs/s/skillet/back_from_the_dead.html\n" +
                "© Лингво-лаборатория «Амальгама»: http://www.Irby-lab.com/.\n"
            
        case Commons.TheBeatlesYesterday:
            return "Вчера (перевод Чинара Бабаева из Калуги)\n" +
            "\n" +
            "Yesterday, all my troubles seemed so far away\n" +
            "Вчера все мои проблемы казались такими далекими,\n" +
            "Now it look as though they're here to stay\n" +
            "А сегодня я не представляю своей жизни без них.\n" +
            "Oh, I believe in yesterday\n" +
            "О, я верю во вчерашний день.\n" +
            "\n" +
            "\n" +
            "Suddenly, I'm not half the man I used to be\n" +
            "Неожиданно я стал уже не тем, кем был раньше,\n" +
            "There's a shadow hanging over me\n" +
            "Уныние овладело мной,\n" +
            "Oh, yesterday came suddenly\n" +
            "О, вчера настало так внезапно\n" +
            "\n" +
            "\n" +
            "[Chorus:]\n" +
            "[Припев:]\n" +
            "Why she had to go I don't know, she wouldn't say\n" +
            "Почему ей пришлось уйти? Не знаю, она не сказала,\n" +
            "I said something wrong, now I long for yesterday\n" +
            "Я сказал что-то не то… Я так хочу вернуться во вчерашний день.\n" +
            "\n" +
            "\n" +
            "Yesterday, love was such an easy game to play\n" +
            "Вчера любовь была такой простой игрой,\n" +
            "Now I need a place to hide away\n" +
            "А сегодня я вынужден прятаться,\n" +
            "Oh, I believe in yesterday\n" +
            "О, я верю во вчерашний день\n" +
            "\n" +
            "Источник: http://www.Irby-lab.com/songs/b/beatles/yesterday.html\n" +
            "© Лингво-лаборатория «Амальгама»: http://www.Irby-lab.com/.\n"
            
            
        case Commons.SkilletRise:
            return
                "Rise (оригинал Skillet)\n" +
                    "\n" +
                    "Восстань (перевод rodweb из Калининграда)\n" +
                    "\n" +
                    "All I see is shattered pieces,\n" +
                    "Всё, что я вижу — осколки.\n" +
                    "I can't keep it hidden like a secret,\n" +
                    "Я не могу больше хранить тайну,\n" +
                    "I can't look away\n" +
                    "Я не могу отвернуться\n" +
                    "From all this pain in the world we've made.\n" +
                    "От всей боли в этом мире, что мы причинили.\n" +
                    "\n" +
                    "\n" +
                    "Every day you need a bulletproof vest\n" +
                    "Каждый день тебе нужен бронежилет,\n" +
                    "To save yourself from what you could never guess\n" +
                    "Чтобы спастись от очередной неожиданности.\n" +
                    "Am I safe today,\n" +
            "В безопасности ли я сегодня,\n" +
            "When I step outside in the wars we wage?\n" +
            "Выходя на улицу, в войны, что мы ведём?\n" +
            "\n" +
            "\n" +
            "Our future's here and now,\n" +
            "Наше будущее здесь и сейчас,\n" +
            "Here comes the countdown...\n" +
            "Идёт обратный отсчёт...\n" +
            "\n" +
            "\n" +
            "Sound it off, this is our call:\n" +
            "Выскажи всё, вот наш призыв:\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "It's our time to change it all:\n" +
            "Настал наш час всё изменить:\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "\n" +
            "\n" +
            "Unite and fight\n" +
            "Объединитесь и сражайтесь\n" +
            "To make a better life!\n" +
            "За лучшую жизнь!\n" +
            "Everybody, one for all!\n" +
            "Все как один,\n" +
            "Sound off, this is the call:\n" +
            "Выскажите всё, вот наш призыв:\n" +
            "\n" +
            "\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "\n" +
            "\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "\n" +
            "\n" +
            "Like a hand grenade thrown in a hurricane,\n" +
            "Как ручная граната, брошенная в ураган,\n" +
            "Spinning in chaos, trying to escape the flame.\n" +
            "Кручусь в хаосе, стараясь избежать пламени.\n" +
            "Yesterday is gone\n" +
            "Вчера прошло быстрее,\n" +
            "Faster than the blast of a car bomb.\n" +
            "Чем взрыв автомобильной бомбы.\n" +
            "\n" +
            "\n" +
            "And when the scars heal, the pain passes\n" +
            "Когда же шрамы заживают, боль уходит,\n" +
            "As hope burns, we rise from the ashes.\n" +
            "Надежда возгорается, мы восстаём из пепла,\n" +
            "Darkness fades away,\n" +
            "Тьма ослабевает,\n" +
            "And the light shines on a brave new day.\n" +
            "И свет сияет дивным новым днём.\n" +
            "\n" +
            "\n" +
            "Our future's here and now,\n" +
            "Наше будущее здесь и сейчас,\n" +
            "Here comes the countdown...\n" +
            "Идёт обратный отсчёт...\n" +
            "\n" +
            "\n" +
            "Sound it off, this is our call:\n" +
            "Выскажи всё, вот наш призыв:\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "It's our time to change it all:\n" +
            "Настал наш час всё изменить:\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "\n" +
            "\n" +
            "Unite and fight\n" +
            "Объединись, сражайся!\n" +
            "To make a better life!\n" +
            "За лучшую жизнь!\n" +
            "Everybody, one for all!\n" +
            "Все как один,\n" +
            "Sound off, this is the call:\n" +
            "Выскажите всё, вот наш призыв:\n" +
            "\n" +
            "\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "\n" +
            "\n" +
            "Tonight we rise!\n" +
            "Сегодня, мы восстаём!\n" +
            "\n" +
            "\n" +
            "In a world gone mad (in a voice so sad)\n" +
            "В съехавшем с катушек мире (с грустью в голосе)\n" +
            "Sometimes it's crazy (crazy)\n" +
            "Иногда кажется безумным (безумным!) —\n" +
            "To fight for what you believe\n" +
            "Сражаться за то, во что веришь,\n" +
            "But you can't give up (No)\n" +
            "Но ты не можешь сдаться (Нет!),\n" +
            "If you want to keep what you love... (Keep what you love)\n" +
            "Если хочешь сохранить то, что любишь... (сохранить то, что любишь),\n" +
            "Keep what you love... (Keep what you love)\n" +
            "Сохранить то, что любишь... (сохранить то, что любишь),\n" +
            "Keep what you love...\n" +
            "Сохранить то, что любишь...\n" +
            "Never give up! No!\n" +
            "Никогда не сдавайся! Нет!\n" +
            "\n" +
            "\n" +
            "Rise! Rise in revolution!\n" +
            "Восстань! Поднимись на революцию!\n" +
            "Rise! Rise in revolution!\n" +
            "Восстань! Поднимись на революцию!\n" +
            "Everybody one for all,\n" +
            "Все как один,\n" +
            "Sound off, this is the call:\n" +
            "Выскажите всё, вот наш призыв:\n" +
            "\n" +
            "\n" +
            "Rise! Like we're alive!\n" +
            "Восстань! Мы оживаем!\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "Rise! Make a better life!\n" +
            "Восстань! Сделай жизнь лучше!\n" +
            "Tonight we rise!\n" +
            "Сегодня мы восстаём!\n" +
            "\n" +
            "\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "\n" +
            "\n" +
            "Rise! Rise!\n" +
            "Восстань, восстань!\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "Rise! Rise!\n" +
            "Восстань, восстань!\n" +
            "Rise in revolution!\n" +
            "Поднимись на революцию!\n" +
            "\n" +
            "\n" +
            "Rise!\n" +
            "Восстань!\n" +
            "\n" +
            "\n" +
            "*Telephone Rings*\n" +
            "*Звонит телефон*\n" +
            "\n" +
            "\n" +
            "— 911.\n" +
            "— 911.\n" +
            "— There's a guy here with a gun!\n" +
            "— Тут парень с пистолетом!\n" +
            "— Ma'am? Ma'am?\n" +
            "— Мэм? Мэм?\n" +
            "— Kids, get under the table! Kids, get under the table!\n" +
            "— Дети, прячьтесь под стол! Дети, лезьте под стол!\n" +
            "\n" +
            "\n" +
            "*Newscast*\n" +
            "*Выпуск новостей*\n" +
            "\n" +
            "\n" +
            "We are getting in reports from all around the globe,\n" +
            "Мы получаем сообщения со всего земного шара,\n" +
            "showing the highest unemployment rates\n" +
            "Свидетельствующие о высочайшем уровне безработицы\n" +
            "Since the end of World War Two.\n" +
            "С момента окончания Второй Мировой войны.\n" +
            "Many are losing their jobs, their homes,\n" +
            "Многие теряют работу, дома,\n" +
            "And in many cases - their hope.\n" +
            "И во многих случаях — надежду.\n" +
            "\n" +
            "\n" +
            "*Police Radio*\n" +
            "*Полицейская рация*\n" +
            "\n" +
            "\n" +
            "– You are such a failure!\n" +
            "— Ты полный неудачник!\n" +
            "– What's wrong with you?\n" +
            "— Что с тобой происходит?\n" +
            "– You're worthless!\n" +
            "— Ты никчёмный!\n" +
            "– You can't do anything right!\n" +
            "— Ты не можешь ничего сделать правильно!\n" +
            "– I wish you had never been born.\n" +
            "— Лучше бы ты не появлялся на свет!\n" +
            "\n" +
            "Источник: http://www.Irby-lab.com/songs/s/skillet/rise.html\n" +
            "© Лингво-лаборатория «Амальгама»: http://www.Irby-lab.com/.\n"
            
            
        default:
            return "In the town where I was born\n" +
            "В городке, где я родился,\n" +
            "Lived a man who sailed to sea\n" +
            "Жил человек, который плавал по морям.\n" +
            "And he told us of his life\n" +
            "И он рассказал нам о своей жизни\n" +
            "In the land of submarines\n" +
            "В стране подводных лодок.\n" +
            "\n" +
            "\n" +
            "So we sailed up to the sun\n" +
            "Мы ходили под парусом до самого солнца,\n" +
            "Till we found the sea of green\n" +
            "Пока не нашли зеленое море.\n" +
            "And we lived beneath the waves\n" +
            "Мы жили под волнами\n" +
            "In our yellow submarine\n" +
            "В нашей желтой подводной лодке.\n" +
            "\n" +
            "\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "\n" +
            "\n" +
            "And our friends are all aboard\n" +
            "Все наши друзья на борту,\n" +
            "Many more of them live next door\n" +
            "Многие из них живут совсем рядом,\n" +
            "And the band begins to play\n" +
            "И наша группа начинает играть…\n" +
            "\n" +
            "\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "\n" +
            "\n" +
            "As we live a life of ease\n" +
            "Вот так мы весело и легко живем,\n" +
            "Everyone of us has all we need\n" +
            "У каждого из нас есть все, что нужно,\n" +
            "Sky of blue and sea of green\n" +
            "Небо голубое, море зеленое\n" +
            "In our yellow submarine\n" +
            "В нашей желтой субмарине!\n" +
            "\n" +
            "\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "\n" +
            "\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "We all live in a yellow submarine\n" +
            "Мы все живем в нашей желтой подводной лодке,\n" +
            "Yellow submarine, yellow submarine\n" +
            "Желтой подводной лодке, желтой подводной лодке.\n" +
            "\n" +
            "\n" +
            "\n" +
            "\n" +
            "\n" +
            "\n" +
            "Источник: http://www.Irby-lab.com/songs/b/beatles/yellow_submarine.html\n" +
            "© Лингво-лаборатория «Амальгама»: http://www.Irby-lab.com/.\n"
        }
    }
    
// MARK: - Variables
    
    private var songNumber: Int?
    
    private var song: String?

}
