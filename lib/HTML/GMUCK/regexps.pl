#
# This file is generated using genregexps.PL, do not edit!
# $Id: regexps.pl,v 1.1 2004/08/07 23:40:22 scop Exp $
#

# Matches a ">" that is not preceded by "-" (to protect Perl's "->").
$Tag_End = qr/(?<!-)>/o;

# Matches a non-">" char or a "->", $Tag_End negated.
$Non_Tag_End = qr/(?:[^>]|(?<=-)>)/o;

# This is used in optimizations.  Elements are from <a> to <var>.
# We also allow end tags, hence the "/".
$Tag_Start = qr/<\/?[a-vA-V]/o;

# Attributes with URI values.
$URI_Attrs = '\b(?:(?:a(?:ction|rchive)|background|c(?:ite|lassid|ode(?:base)?)|data|for|href|lo(?:ngdes|wsr)c|p(?:luginspag|rofil)e|src|usemap|xmlns))\b';

# Elements with optional end tags.
$End_Omit = '\b(?:(?:d[td]|li|option))\b';

# All known elements.
$All_Elems = '\b(?:(?:a(?:bbr|cronym|ddress|pplet|rea)|b(?:ase(?:font)?|do|gsound|ig|l(?:ink|ockquote)|ody|utton|r)|c(?:aption|enter|ite|o(?:de|lgroup|l))|d(?:el|fn|i[rv]|[dlt])|em(?:bed)?|f(?:ieldset|o(?:nt|rm)|rame(?:set)?)|h(?:ead|tml|[54361r2])|i(?:frame|layer|mg|n(?:put|s)|sindex)|kbd|l(?:abel|egend|i(?:nk|sting)|i)|m(?:ap|e(?:nu|ta)|ulticol)|no(?:br|embed|frames|layer|script)|o(?:bject|pt(?:group|ion)|l)|p(?:aram|laintext|re)|s(?:amp|cript|elect|mall|pa(?:cer|n)|t(?:r(?:ike|ong)|yle)|u[pb])|t(?:able|body|extarea|foot|head|itle|[rthd])|ul|var|wbr|xmp|[qbausip]))\b';

# Minimizable attributes.
$Min_Attrs = '\b(?:(?:c(?:hecked|ompact)|d(?:e(?:clare|fer)|isabled)|ismap|multiple|no(?:href|resize|shade|wrap)|readonly|selected))\b';

# Elements with forbidden end tags.
$Min_Elems = '\b(?:(?:area|b(?:ase(?:font)?|r)|col|embed|frame|hr|i(?:mg|nput|sindex)|link|meta|param))\b';

# Elements that require an end tag but are commonly seen without it.
$Compat_Elems = '\b(?:(?:script|textarea|p))\b';

# MIME types. RFC 2046 says x-foo top-level types are allowed, but discouraged.
$MIME_Type = qr/^\b(?:(?:a(?:pplication|udio)|image|m(?:essage|ultipart)|text|video))\b\/\w+?[-\w\.]+?\w+\b$/i;

# Elements that have attributes with multiple (comma-separated) MIME types:
#   form, input: accept
# Parens in these regexps:
#   1: element, 2: attribute, 3:first quote,
#   4: value (including possible end quote), 5: value
$tmp =
  '<(%s)\b\s??' . $Non_Tag_End .
  '*?\s(%s)=(\\\?["\'])?((.*?)(?:\3|\s|' . $Tag_End . '))';
@MIME_Attrs =
  map { qr/$_/i }
  ( sprintf($tmp, '\b(?:(?:link|param|s(?:cript|tyle)|a))\b', 'type'),
    sprintf($tmp, 'object', '(?:code)type'),
    sprintf($tmp, 'form', 'enctype'),
  );
undef $tmp;

# All known attributes.
$All_Attrs = '\b(?:(?:a(?:bbr|c(?:ce(?:pt(?:\-charset)?|sskey)|tion)|l(?:i(?:gn|nk)|t)|rchive|xis)|b(?:ackground|gcolor|order)|c(?:ell(?:padd|spac)ing|h(?:ar(?:off|set)?|ecked)|ite|l(?:ass(?:id)?|ear)|o(?:de(?:base|type)?|l(?:or|span|s)|mpact|ntent|ords))|d(?:at(?:etime|a)|e(?:clare|fer)|i(?:sabled|r))|enctype|f(?:ace|or|rame(?:border)?)|h(?:e(?:aders|ight)|ref(?:lang)?|space|ttp\-equiv)|i(?:smap|d)|l(?:a(?:bel|ng(?:uage)?)|eftmargin|ink|ongdesc)|m(?:a(?:rgin(?:height|width)|xlength)|e(?:dia|thod)|ultiple)|n(?:ame|o(?:href|resize|shade|wrap))|o(?:bject|n(?:blur|c(?:hange|lick)|dblclick|focus|key(?:down|press|up)|load|mouse(?:down|move|o(?:ut|ver)|up)|reset|s(?:elec|ubmi)t|unload))|pro(?:file|mpt)|r(?:e(?:adonly|[lv])|ows(?:pan)?|ules)|s(?:c(?:heme|ope|rolling)|elected|hape|ize|pan|rc|t(?:a(?:ndby|rt)|yle)|ummary)|t(?:a(?:bindex|rget)|ext|itle|opmargin|ype)|usemap|v(?:al(?:ign|ue(?:type)?)|ersion|link|space)|w(?:idth|rap)))\b';

$tmp = '<((%s)\b\s??.*?(?:\s(%s)=|' . $Tag_End . '))';

# Required attributes by element.
# This has some special cases which are handled in code.  See _attributes()
my %tmp =
    ( action  => sprintf($tmp, 'form', 'action' ),
      alt     => sprintf($tmp, '\b(?:(?:area|img))\b', 'alt'    ),
      cols    => sprintf($tmp, 'textarea', 'cols'   ),
      content => sprintf($tmp, 'meta', 'content'),
      dir     => sprintf($tmp, 'bdo', 'dir'    ),
      height  => sprintf($tmp, 'applet', 'height' ),
      href    => sprintf($tmp, 'base', 'href'   ),
      id      => sprintf($tmp, 'map', 'id'     ), # *
      label   => sprintf($tmp, 'optgroup', 'label'  ),
      name    => sprintf($tmp, '\b(?:(?:input|map|param))\b', 'name' ), # *
      rows    => sprintf($tmp, 'textarea', 'rows'   ),
      size    => sprintf($tmp, 'basefont', 'size'   ),
      src     => sprintf($tmp, 'img', 'src'    ),
      type    => sprintf($tmp, '\b(?:s(?:cript|tyle))\b', 'type'   ),
      width   => sprintf($tmp, 'applet', 'width'  ),
    );
%Req_Attrs = map { $_ => qr/$tmp{$_}/i } keys(%tmp);
undef %tmp;

# Deprecated attributes as of HTML 4.01, not including deprecated elements
# and their attributes.
@Depr_Attrs =
  map { qr/$_/i }
  ( sprintf($tmp, '\b(?:(?:caption|div|h[r123456]|i(?:frame|mg|nput)|legend|object|table|p))\b', 'align' ),
    sprintf($tmp, 'body', '\b(?:(?:alink|background|link|text|vlink))\b'),
    sprintf($tmp, 'hr', '\b(?:(?:noshade|width))\b'),
    sprintf($tmp, '\b(?:(?:img|object))\b', '\b(?:(?:border|hspace|vspace))\b'),
    sprintf($tmp, '\b(?:t[dh])\b', '\b(?:(?:bgcolor|height|nowrap|width))\b'),
    sprintf($tmp, '\b(?:[ou]l)\b', 'type'),
    sprintf($tmp, '\b(?:(?:body|t(?:able|r)))\b', 'bgcolor'),
    sprintf($tmp, '\b(?:[dou]l)\b', 'compact'),
    sprintf($tmp, 'ol', 'start'),
    sprintf($tmp, 'li', 'value'),
    sprintf($tmp, 'html', 'version'),
    sprintf($tmp, 'br', 'clear'),
    sprintf($tmp, 'script', 'language'),
    sprintf($tmp, 'li', 'type'),
    sprintf($tmp, 'pre', 'width'),
  );
undef $tmp;

# Deprecated elements as of HTML 4.01.
$Depr_Elems = '\b(?:(?:applet|basefont|center|dir|font|isindex|menu|strike|[su]))\b';


# Attributes whose value is an integer, from HTML 4.01 and XHTML 1.0.
# A couple of special cases here, handled in _attributes().
@Int_Attrs =
  map { qr/$_/i }
  (
   # NUMBER/Number
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'textarea', '\b(?:(?:col|row)s)\b'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:t[dh])\b', '\b(?:(?:col|row)span)\b'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'input', 'maxlength'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'select', 'size'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:col(?:group)?)\b', 'span'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'ol', 'start'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:area|button|input|object|select|textarea|a))\b', 'tabindex'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'li', 'value'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'pre', 'width'),
   # Pixels
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:applet|img))\b', '\b(?:[hv]space)\b'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:i?frame)\b', '\b(?:margin(?:height|width))\b'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'hr', 'size'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:img|table))\b', 'border'), # img: HTML 4
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'object', '\b(?:(?:border|hspace|vspace))\b'),
   sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:t[dh])\b', '\b(?:(?:height|width))\b'), # XHTML 1.0
  );

# Attributes whose value is %Length, from HTML 4.01 and XHTML 1.0.
# Some special cases here, handled in _attributes().
@Length_Attrs =
  map { qr/$_/i }
  ( sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'table', '\b(?:cell(?:padd|spac)ing)\b'),
    sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:col(?:group)?|t(?:body|foot|head|[dhr])))\b', 'charoff'),
    sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:applet|i(?:frame|mg)|object))\b', 'height'),
    sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:(?:applet|hr|i(?:frame|mg)|object|table))\b', 'width'),
    sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, '\b(?:t[dh])\b', '\b(?:(?:height|width))\b'), # HTML 4
    sprintf(q{<((%s)\b\s??[^>]*?\s(%s)=(["'])([^>]+?)\4)}, 'img', 'border'), # XHTML 1.0
  );

# Attributes that have a fixed set of values, from HTML 4.01.
@Fixed_Attrs = ();
push(@Fixed_Attrs, [ qr/<((hr)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:center|justify|left))\b/i, 'left|center|justify' ]);
push(@Fixed_Attrs, [ qr/<((input)\b\s??[^>]*?\s(type)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:button|checkbox|file|hidden|image|password|r(?:adio|eset)|submit|text))\b/i, 'text|password|checkbox|radio|submit|reset|file|hidden|image|button' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:applet|i(?:frame|mg|nput)|object))\b)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:bottom|left|middle|right|top))\b/i, 'top|middle|bottom|left|right' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:i?frame)\b)\b\s??[^>]*?\s(frameborder)=(["'])([^>]+?)\4)/i, qr/\b(?:[01])\b/i, '0|1' ]);
push(@Fixed_Attrs, [ qr/<((button)\b\s??[^>]*?\s(type)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:button|reset|submit))\b/i, 'button|submit|reset' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:i(?:mg|nput))\b)\b\s??[^>]*?\s(ismap)=(["'])([^>]+?)\4)/i, qr/\b(?:ismap)\b/i, 'ismap' ]);
push(@Fixed_Attrs, [ qr/<((object)\b\s??[^>]*?\s(declare)=(["'])([^>]+?)\4)/i, qr/\b(?:declare)\b/i, 'declare' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:i?frame)\b)\b\s??[^>]*?\s(scrolling)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:auto|no|yes))\b/i, 'yes|no|auto' ]);
push(@Fixed_Attrs, [ qr/<((ol)\b\s??[^>]*?\s(type)=(["'])([^>]+?)\4)/i, qr/\b(?:[1aAiI])\b/i, '1|a|A|i|I' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:div|h[123456]|p))\b)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:center|justify|left|right))\b/i, 'left|center|right|justify' ]);
push(@Fixed_Attrs, [ qr/<((table)\b\s??[^>]*?\s(rules)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:all|cols|groups|none|rows))\b/i, 'none|groups|rows|cols|all' ]);
push(@Fixed_Attrs, [ qr/<((input)\b\s??[^>]*?\s(checked)=(["'])([^>]+?)\4)/i, qr/\b(?:checked)\b/i, 'checked' ]);
push(@Fixed_Attrs, [ qr/<((param)\b\s??[^>]*?\s(valuetype)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:DATA|OBJECT|REF))\b/i, 'DATA|REF|OBJECT' ]);
push(@Fixed_Attrs, [ qr/<((script)\b\s??[^>]*?\s(defer)=(["'])([^>]+?)\4)/i, qr/\b(?:defer)\b/i, 'defer' ]);
push(@Fixed_Attrs, [ qr/<((table)\b\s??[^>]*?\s(frame)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:above|b(?:elow|o(?:rder|x))|hsides|lhs|rhs|v(?:oid|sides)))\b/i, 'void|above|below|hsides|lhs|rhs|vsides|box|border' ]);
push(@Fixed_Attrs, [ qr/<((br)\b\s??[^>]*?\s(clear)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:all|left|none|right))\b/i, 'left|all|right|none' ]);
push(@Fixed_Attrs, [ qr/<((ul)\b\s??[^>]*?\s(type)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:circle|disc|square))\b/i, 'disc|square|circle' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:pre|s(?:cript|tyle)))\b)\b\s??[^>]*?\s(xml:space)=(["'])([^>]+?)\4)/i, qr/\b(?:preserve)\b/i, 'preserve' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:col(?:group)?|t(?:body|foot|head|[dhr])))\b)\b\s??[^>]*?\s(valign)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:b(?:aseline|ottom)|middle|top))\b/i, 'top|middle|bottom|baseline' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:a(?:rea)?)\b)\b\s??[^>]*?\s(shape)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:circle|default|poly|rect))\b/i, 'rect|circle|poly|default' ]);
push(@Fixed_Attrs, [ qr/<((li)\b\s??[^>]*?\s(type)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:circle|disc|square|[1aAiI]))\b/i, 'disc|square|circle|1|a|A|i|I' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:d(?:ir|l)|menu|ol|ul))\b)\b\s??[^>]*?\s(compact)=(["'])([^>]+?)\4)/i, qr/\b(?:compact)\b/i, 'compact' ]);
push(@Fixed_Attrs, [ qr/<((table)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:center|left|right))\b/i, 'left|center|right' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:button|input|opt(?:group|ion)|select|textarea))\b)\b\s??[^>]*?\s(disabled)=(["'])([^>]+?)\4)/i, qr/\b(?:disabled)\b/i, 'disabled' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:input|textarea))\b)\b\s??[^>]*?\s(readonly)=(["'])([^>]+?)\4)/i, qr/\b(?:readonly)\b/i, 'readonly' ]);
push(@Fixed_Attrs, [ qr/<((form)\b\s??[^>]*?\s(method)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:ge|pos)t)\b/i, 'get|post' ]);
push(@Fixed_Attrs, [ qr/<((html)\b\s??[^>]*?\s(xmlns)=(["'])([^>]+?)\4)/i, qr/\b(?:http\:\/\/www\.w3\.org\/1999\/xhtml)\b/i, 'http://www.w3.org/1999/xhtml' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:col(?:group)?|t(?:body|foot|head|[dhr])))\b)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:c(?:ente|ha)r|justify|left|right))\b/i, 'left|center|right|justify|char' ]);
push(@Fixed_Attrs, [ qr/<((hr)\b\s??[^>]*?\s(noshade)=(["'])([^>]+?)\4)/i, qr/\b(?:noshade)\b/i, 'noshade' ]);
push(@Fixed_Attrs, [ qr/<((frame)\b\s??[^>]*?\s(noresize)=(["'])([^>]+?)\4)/i, qr/\b(?:noresize)\b/i, 'noresize' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:t[dh])\b)\b\s??[^>]*?\s(nowrap)=(["'])([^>]+?)\4)/i, qr/\b(?:nowrap)\b/i, 'nowrap' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:t[dh])\b)\b\s??[^>]*?\s(scope)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:col(?:group)?|row(?:group)?))\b/i, 'row|col|rowgroup|colgroup' ]);
push(@Fixed_Attrs, [ qr/<((area)\b\s??[^>]*?\s(nohref)=(["'])([^>]+?)\4)/i, qr/\b(?:nohref)\b/i, 'nohref' ]);
push(@Fixed_Attrs, [ qr/<((\b(?:(?:caption|legend))\b)\b\s??[^>]*?\s(align)=(["'])([^>]+?)\4)/i, qr/\b(?:(?:bottom|left|right|top))\b/i, 'top|bottom|left|right' ]);

1;
