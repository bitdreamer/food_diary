import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// Keyboard is a custom keyboard and 
// place for what you type to appear and a button to say 
// when you are done.
class KeyBoarg extends StatelessWidget
{ final TextEditingController tec;
  KeyBoarg( this.tec);

  @override
  Widget build( BuildContext context )
  { bool upper = false;
    return Column
    ( children:
      [ Row
        ( children:
          [ OneKey( upper?"Q":"q", justALetter,tec),
            OneKey( upper?"W":"w", justALetter,tec),
            OneKey( upper?"E":"e", justALetter,tec),
            OneKey( upper?"R":"r", justALetter,tec),
            OneKey( upper?"T":"t", justALetter,tec),
            OneKey( upper?"Y":"y", justALetter,tec),
            OneKey( upper?"U":"u", justALetter,tec),
            OneKey( upper?"I":"i", justALetter,tec),
            OneKey( upper?"O":"o", justALetter,tec),
            OneKey( upper?"P":"p", justALetter,tec),
            OneKey( upper?"7":"7", justALetter,tec),
            OneKey( upper?"8":"8", justALetter,tec),
            OneKey( upper?"9":"9", justALetter,tec),
            
          ],
        ),
        Row
        ( children:
          [ OneKey(upper?"A":"a", justALetter,tec),
            OneKey(upper?"S":"s", justALetter,tec),
            OneKey(upper?"D":"d", justALetter,tec),
            OneKey(upper?"F":"f", justALetter,tec),
            OneKey(upper?"G":"g", justALetter,tec),
            OneKey(upper?"H":"h", justALetter,tec),
            OneKey(upper?"J":"j", justALetter,tec),
            OneKey(upper?"K":"k", justALetter,tec),
            OneKey(upper?"L":"l", justALetter,tec),
            OneKey( upper?"←":"←", backup,tec),
            OneKey(upper?"4":"4", justALetter,tec),
            OneKey(upper?"5":"5", justALetter,tec),
            OneKey(upper?"6":"6", justALetter,tec),
          ],
        ),
        Row
        ( children:
          [
            OneKey(upper?"Z":"z", justALetter,tec),
            OneKey(upper?"X":"x", justALetter,tec),
            OneKey(upper?"C":"c", justALetter,tec),
            OneKey(upper?"V":"v", justALetter,tec),
            OneKey(upper?"B":"b", justALetter,tec),
            OneKey(upper?"N":"n", justALetter,tec),
            OneKey(upper?"M":"m", justALetter,tec),
            OneKey(upper?" ":" ", justALetter,tec),

            OneKey(upper?".":".", justALetter,tec),
            OneKey(upper?"0":"0", justALetter,tec),
            OneKey(upper?"1":"1", justALetter,tec),
            OneKey(upper?"2":"2", justALetter,tec),
            OneKey(upper?"3":"3", justALetter,tec),
          ],
        ),
      ]
    );
  }

  // add this letter to 'sez'
  void justALetter(String s, TextEditingController tec )
  {
     tec.text = tec.text + s;
  }

  // take the last letter off of sez
  void backup( String s, BuildContext context ) // arg for consistency
  {
  }

  // add this accent to the last character of 'sez'
  void addTone( String s, BuildContext context )
  {
    
  }

  // shift upper case <--> lower case
  void doShift( String s, BuildContext context )
  {
  }


}

class OneKey extends StatelessWidget
{ 
  final String theS; // the character ON the button
  final Function theF; // what to do when pressed
  final String showS; // =theS except for space, which shows "␣"
  final TextEditingController tec;

  OneKey( this.theS, this.theF, this.tec, {super.key}) 
  : showS = (theS==" ")?"␣":theS; // █// ␠

  @override
  Widget build( BuildContext context )
  { return Expanded 
    ( child: TextButton
      ( onPressed: () { theF(theS,tec); },
        style: TextButton.styleFrom( padding: const EdgeInsets.all(0),),
        child:  Text
        ( showS, 
          style: const TextStyle
          ( fontSize:20,
            color:Colors.black,
            // backgroundColor: Colors.yellow,
          ), 
        ),
      ),
    );
  }
}


// map for glueing 'letter accent' (string with two characters) into that
// letter with that accent.  Returns null if you cannot put that accent on
// that character.
Map< String , String > charMap =
{
  "aˉ":"ā", "eˉ":"ē", "iˉ":"ī", "oˉ":"ō", "uˉ":"ū", "üˉ":"ǖ", // tone 1
  "Aˉ":"Ā", "Eˉ":"Ē", "Iˉ":"Ī", "Oˉ":"Ō", "Uˉ":"Ū", "Üˉ":"Ǖ",
  "aˊ":"á", "eˊ":"é", "iˊ":"í", "oˊ":"ó", "uˊ":"ú", "üˊ":"ǘ", // tone 2
  "Aˊ":"Á", "Eˊ":"É", "Iˊ":"Í", "Oˊ":"Ó", "Uˊ":"Ú", "Üˊ":"Ǘ",
  "aˇ":"ǎ", "eˇ":"ě", "iˇ":"ǐ", "oˇ":"ǒ", "uˇ":"ǔ", "üˇ":"ǚ", // tone 3
  "Aˇ":"Ǎ", "Eˇ":"Ě", "Iˇ":"Ǐ", "Oˇ":"Ǒ", "Uˇ":"Ǔ", "Üˇ":"Ǚ",
  "aˋ":"à", "eˋ":"è", "iˋ":"ì", "oˋ":"ò", "uˋ":"ù", "üˋ":"ǜ", // tone 4
  "Aˋ":"À", "Eˋ":"È", "Iˋ":"Ì", "Oˋ":"Ò", "Uˋ":"Ù", "Üˋ":"Ǜ",
};

/*
 ˉ ˊ  ˋ  ˇ  ̈
 from Wikipedia ...
ā ē ī ō ū ǖ Ā Ē Ī Ō Ū Ǖ
The second tone (rising or high-rising tone) is denoted by an acute accent (ˊ):
á é í ó ú ǘ Á É Í Ó Ú Ǘ
The third tone (falling-rising or low tone) is marked by a caron/háček (ˇ). It is not the rounded breve (˘), though a breve is sometimes substituted due to ignorance or font limitations.
ǎ ě ǐ ǒ ǔ ǚ Ǎ Ě Ǐ Ǒ Ǔ Ǚ
The fourth tone (falling or high-falling tone) is represented by a grave accent (ˋ):
à è ì ò ù ǜ À È Ì Ò Ù Ǜ
The fifth tone (neutral tone) is represented by a normal vowel without any accent mark:
a e i o u ü A E I O U Ü
*/