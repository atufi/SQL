declare
  c_gr_len constant pls_integer := 4;
  l_enc  varchar2(5000) := '&encoded_pwd';
  l_dec  varchar2(5000);
  l_key  number;
  l_val  number;
  l_mask number;
  l_chars pls_integer;
begin
  l_chars := length(l_enc) / 4 - 1;
  l_key   := to_number(substr(l_enc,
                              1,
                              c_gr_len));

  for l_i in 1 .. l_chars
  loop
    l_val  := to_number(substr(l_enc,
                               l_i * 4 + 1,
                               c_gr_len)) - 1000;
    l_mask := l_key + (10 * (l_i));
    l_dec := l_dec || chr(((l_val + l_mask) - BitAND(l_val,
                                                     l_mask) * 2) / 16);
  
  end loop;
  dbms_output.put_line(l_dec);
end;
