codeunit 73000 "Text Utils Tests BC365D"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        LibraryAssert: Codeunit "Library Assert";
        TextUtilities: Codeunit "Text Utilities BC365D";

    [Test]
    procedure Test01_IdenticalStrings()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('hello', 'hello');
        LibraryAssert.AreEqual(0, Result, 'Identical strings');
    end;

    [Test]
    procedure Test02_EmptyStrings()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('', '');
        LibraryAssert.AreEqual(0, Result, 'Both empty strings');
    end;

    [Test]
    procedure Test03_EmptyToNonEmpty()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('', 'hello');
        LibraryAssert.AreEqual(5, Result, 'Empty to hello');

        Result := TextUtilities.TextDistance('world', '');
        LibraryAssert.AreEqual(5, Result, 'World to empty');
    end;

    [Test]
    procedure Test04_SingleSubstitution()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('cat', 'bat');
        LibraryAssert.AreEqual(1, Result, 'Single substitution');
    end;

    [Test]
    procedure Test05_SingleInsertion()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('cat', 'cats');
        LibraryAssert.AreEqual(1, Result, 'Single insertion');
    end;

    [Test]
    procedure Test06_SingleDeletion()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('cats', 'cat');
        LibraryAssert.AreEqual(1, Result, 'Single deletion');
    end;

    [Test]
    procedure Test07_CompletelyDifferent()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('abc', 'xyz');
        LibraryAssert.AreEqual(3, Result, 'Completely different');
    end;

    [Test]
    procedure Test08_KnownCase_Kitten()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('kitten', 'sitting');
        LibraryAssert.AreEqual(3, Result, 'Kitten to sitting');
    end;

    [Test]
    procedure Test09_CaseSensitive()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('Hello', 'hello');
        LibraryAssert.AreEqual(1, Result, 'Case sensitivity');
    end;

    [Test]
    procedure Test10_SpecialCharacters()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('test@123', 'test#123');
        LibraryAssert.AreEqual(1, Result, 'Special characters');
    end;

    [Test]
    procedure Test11_Symmetry()
    var
        Result1: Integer;
        Result2: Integer;
    begin
        Result1 := TextUtilities.TextDistance('hello', 'world');
        Result2 := TextUtilities.TextDistance('world', 'hello');
        LibraryAssert.AreEqual(Result1, Result2, 'Symmetry property');
    end;

    [Test]
    procedure Test12_TriangleInequality()
    var
        DistAB: Integer;
        DistBC: Integer;
        DistAC: Integer;
    begin
        DistAB := TextUtilities.TextDistance('cat', 'bat');
        DistBC := TextUtilities.TextDistance('bat', 'rat');
        DistAC := TextUtilities.TextDistance('cat', 'rat');

        LibraryAssert.IsTrue(DistAC <= (DistAB + DistBC), 'Triangle inequality');
    end;

    [Test]
    procedure Test13_LongerStrings()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('Saturday', 'Sunday');
        LibraryAssert.AreEqual(3, Result, 'Saturday to Sunday');

        Result := TextUtilities.TextDistance('intention', 'execution');
        LibraryAssert.AreEqual(5, Result, 'Intention to execution');
    end;

    [Test]
    procedure Test14_ReversedStrings()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('abc', 'cba');
        LibraryAssert.AreEqual(2, Result, 'Reversed strings');
    end;

    [Test]
    procedure Test15_SingleCharacters()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('a', 'b');
        LibraryAssert.AreEqual(1, Result, 'Single different characters');

        Result := TextUtilities.TextDistance('a', 'a');
        LibraryAssert.AreEqual(0, Result, 'Single same characters');
    end;

    [Test]
    procedure Test16_WithSpaces()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('hello world', 'hello  world');
        LibraryAssert.AreEqual(1, Result, 'Extra space handling');

        Result := TextUtilities.TextDistance('no spaces', 'no spaces');
        LibraryAssert.AreEqual(0, Result, 'Space removal');
    end;

    [Test]
    procedure Test17_Numbers()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('123', '124');
        LibraryAssert.AreEqual(1, Result, 'Number difference');

        Result := TextUtilities.TextDistance('abc123', 'abc124');
        LibraryAssert.AreEqual(1, Result, 'Mixed string with numbers');
    end;

    [Test]
    procedure Test18_LargerTest()
    var
        Result: Integer;
        String1: Text;
        String2: Text;
        i: Integer;
    begin
        // Build test strings of 15 characters each
        String1 := '';
        String2 := '';
        for i := 1 to 15 do begin
            String1 += 'a';
            String2 += 'b';
        end;

        Result := TextUtilities.TextDistance(String1, String2);
        LibraryAssert.AreEqual(15, Result, 'All different 15-char strings');
    end;

    [Test]
    procedure Test19_PartialMatches()
    var
        Result: Integer;
    begin
        Result := TextUtilities.TextDistance('book', 'books');
        LibraryAssert.AreEqual(1, Result, 'Book to books');

        Result := TextUtilities.TextDistance('test', 'tent');
        LibraryAssert.AreEqual(1, Result, 'Test to tent');

        Result := TextUtilities.TextDistance('example', 'sample');
        LibraryAssert.AreEqual(2, Result, 'Example to sample');
    end;

    [Test]
    procedure Test20_EdgeCases()
    var
        Result: Integer;
    begin
        // Very short transformations
        Result := TextUtilities.TextDistance('a', '');
        LibraryAssert.AreEqual(1, Result, 'Single char to empty');

        Result := TextUtilities.TextDistance('', 'a');
        LibraryAssert.AreEqual(1, Result, 'Empty to single char');

        // Punctuation
        Result := TextUtilities.TextDistance('test!', 'test?');
        LibraryAssert.AreEqual(1, Result, 'Punctuation difference');
    end;
}