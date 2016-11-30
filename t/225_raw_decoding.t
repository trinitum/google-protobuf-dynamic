use t::lib::Test;

{
    my $d = Google::ProtocolBuffers::Dynamic->new('t/proto');
    $d->load_file("person.proto");
    $d->map({package => 'test', prefix => 'Test'});

    my $person1 = {
        name => "John Smith",
        id => 12345,
        email => 'john.smith@example.com',
    };
    my $person2 = {
        name => "Smith Johns",
        id => 54321,
        email => 'smith.johns@example.com',
    };
    my $people = {
        persons => [$person1, $person2],
    };

    my $encoded = Test::PersonArray->encode($people);
    my $decoded = Test::PersonArray->decode($encoded, 1);
    eq_or_diff $decoded, $people;
}

done_testing();
