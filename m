Return-Path: <dmaengine+bounces-9744-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLCuFR/HymmL/wUAu9opvQ
	(envelope-from <dmaengine+bounces-9744-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:55:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4A360039
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72A38300F29F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A337701A;
	Mon, 30 Mar 2026 18:55:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB33BED0D
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896913; cv=none; b=Na9lExBD0wbsoMcZi+04mjgQyBiIlA4adLaj8OU2bqRBarOneyX0PW8v7BX0B2EPnewjtzkGCI2DrMSTdFtv8Zx5djqeGIsHQ6cvoq9c/bdJHEKIgR7XrG04xYoHYPxjJ9fTCEtUipndCblk1iULfBeQyRwSNzEIpG67JDlicus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896913; c=relaxed/simple;
	bh=PZJA8OYSHkcjEb6yeCr4bU8DRy/2gacrQ+n6Z6q9zPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6sjU4gwr+mg5xV6ZFMt9n8YY8V2PaVrDAFCX+pgu0pVqY0SUcmsofllIN1+jWtk3W4wZ7vo4TS+amqJuU0wolMJMARSOgVY8ozcwYvxLQzt5l40LEMh1TbZfgxJ9C+4LI7emXu40ubslNq8cASTJLps71iZwTxc7HuvOr4fSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc3ca1922so549928085a.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 11:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896911; x=1775501711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmbdfERIdYVjSOaA8rBMP7lXVvFsi5yyzuqKEhnFPsQ=;
        b=aq/rhEQlNnTO3ulyHkOn5eeB4RvbQofV7LWbu65rSGg3w8DaZrmTA+dZFehyjDAsd1
         iMWbUDNd23xLBzJxp0cePHHxTiQQ1yN/9LmQsY5F3ggkbmTNvBkx+6T5JHQkmz1E/87e
         ji9glxdASzjZ0ph/6mejyANwYyR9bH4Nxc2/RN29iMTorY6yngJQyV8D8rYY5ZYSe+I+
         JM4oRODOLEIh3817BJ4d8g2QLQ5nSYLxAH1MaQOaaLL7hjDDBa4Q5arPw7QchwLhNzzW
         VVx7XD15OJWhuVhP5Dlak3Dux6efhFgeqvk/40BL80DRmH/pdBHiNnsTTmmfHusAU6Hp
         AHqg==
X-Forwarded-Encrypted: i=1; AJvYcCXTR9tEkhr6HXTirsygVAbZ/CiK04hEKrZ8ghQrC7VE/RNKKBsX5Mhe11TYlgx/nvnpHy3vkpcwIIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HAA95Dm4OhoixMYrD27Rjd95ssOWPpPk/mmBrclp2X336idD
	WMtgBZtRlztvdAH8vEwSq9AuhVomhAgq/ns4ZYw+bsDxPugITxxnm3cINfAHk/PR
X-Gm-Gg: ATEYQzzjD/9HfGQlWi3pK57gjYKBzV4tajDd3MzZHx3fToxj+CCcn7sPFp8nsSuLf8I
	2MQlR5lbwKUNWUkF5uTqNiCn6K3YvQKNn7dwxs3WdsjetVYJW1oLp0S7H02Q7OzN7v0AwnqpG1X
	Czak1aLmDS7Ll9p7u6VOnA/pzOxtXesWAvqTTwJm+orUx0bekgrvRw52zURo7OhRbl6Xa3NchSJ
	UIVFWPIUOzW2Go88o+pU9VnaKy8L7Tss/BpYqHVpeNp2AEgBQG8ym3QE2esF+mHd/XgoL95Bq9V
	GVGiDA/jxRs6uE2riR1WxJ0APzk6mfJwX5WVTmCeEgIpC8rYAqyoFBEC8dregz+5r5ksl4qqaFc
	9F50xhZbrdVNEaSeN6qk/7SzyF1iNzqZyN+wWNEZtn6eI8MEk/SGpOCwvrrMzNyqXK25QlkfGrQ
	3AL5Dp0C9DbmxbSyIs8pV+6ZxE4+R9dExcWXXXYwlHiJQ8jzAGUBo6wHiJoev9rdtW
X-Received: by 2002:a05:6214:2dc8:b0:89c:4b84:8a78 with SMTP id 6a1803df08f44-8a2c9605429mr10914176d6.14.1774896910373;
        Mon, 30 Mar 2026 11:55:10 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed003a918sm73347976d6.44.2026.03.30.11.55.10
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:55:10 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c70b5594f4so584978385a.1
        for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 11:55:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi9ixbFi0BjtdDHLftJgQm5JGuvEc9SDZg6utraNYhxua76AmudF9mmlxH6dK6AKu/6lALXJzG48o=@vger.kernel.org
X-Received: by 2002:a05:6122:21a7:b0:56a:ed84:e2 with SMTP id
 71dfb90a1353d-56d7bf9a1a3mr395634e0c.1.1774896484928; Mon, 30 Mar 2026
 11:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-8-john.madieu.xa@bp.renesas.com> <20260320-peculiar-cat-of-acumen-c6f6b3@quoll>
 <TY6PR01MB173775E9970A41ED3A7FFF1DAFF52A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
In-Reply-To: <TY6PR01MB173775E9970A41ED3A7FFF1DAFF52A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2026 20:47:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6Ac_=BugNJaqWnazdDsuzBB765jpzXt8fUasbypXFxg@mail.gmail.com>
X-Gm-Features: AQROBzBY2yW50P7_EhVQZxwFTstX-3Z9DxWPu0ijoIOHvrdSgZhFLZHzJwI06ec
Message-ID: <CAMuHMdW6Ac_=BugNJaqWnazdDsuzBB765jpzXt8fUasbypXFxg@mail.gmail.com>
Subject: Re: [PATCH 07/22] ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, "magnus.damm" <magnus.damm@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	John Madieu <john.madieu@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,renesas.com,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9744-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54B4A360039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Mon, 30 Mar 2026 at 17:40, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > RZ/G3E has a different audio architecture from R-Car Gen2/Gen3/Gen4,
> > > with additional clocks and resets:
> > > - Per-SSI ADG clocks (adg.ssi.0-9)
> > > - SCU related clocks (scu, scu_x2, scu_supply)
> > > - SSIF supply clock
> > > - AUDMAC peri-peri clock
> > > - ADG clock
> > > - Additional resets for SCU, ADG, and AUDMAC peri-peri
> > >
> > > RZ/G3E has 5 DMA controllers that can all be used by audio peripherals.
> > > To allow the DMA core to distribute channels across all available
> > > controllers, increase the maximum number of DMA entries in DVC, SRC,
> > > and SSIU sub-nodes so that multiple providers can be listed with
> > > repeated channel names.
> > >
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

> > > b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > > index e8a2acb92646..bc8885c4fa24 100644
> > > --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > > @@ -58,6 +58,7 @@ properties:
> > >            - renesas,rcar_sound-gen2
> > >            - renesas,rcar_sound-gen3
> > >            - renesas,rcar_sound-gen4
> > > +          - renesas,rcar_sound-r9a09g047     # RZ/G3E
> >
> > Do not use underscores in compatibles. Previously used wrong style is not
> > the excuse here, just like previously poor code, mistakes, bugs,
> > unreadable approches is not justification to repeat the same.
>
> Got it.
>
> > >    reg:
> > >      minItems: 1
> > > @@ -97,20 +98,22 @@ properties:
> > >
> > >    resets:
> > >      minItems: 1
> > > -    maxItems: 11
> > > +    maxItems: 14
> > >
> > >    reset-names:
> > >      minItems: 1
> > > -    maxItems: 11
> > > +    maxItems: 14
> > >
> > >    clocks:
> > >      description: References to SSI/SRC/MIX/CTU/DVC/AUDIO_CLK clocks.
> > >      minItems: 1
> > > -    maxItems: 31
> > > +    maxItems: 47
> > >
> > >    clock-names:
> > >      description: List of necessary clock names.
> > >      # details are defined below
> > > +    minItems: 1
> > > +    maxItems: 47
> > >
> > >    # ports is below
> > >    port:
> > > @@ -136,9 +139,17 @@ properties:
> > >
> > >          properties:
> > >            dmas:
> > > -            maxItems: 1
> > > +            description:
> > > +              Must contain unique DMA specifiers, one per available
> > > +              DMAC. On RZ/G3E, up to 5 for transmission.
> > > +            minItems: 1
> > > +            maxItems: 5
> > >            dma-names:
> > > -            const: tx
> > > +            minItems: 1
> > > +            maxItems: 5
> > > +            items:
> > > +              enum:
> > > +                - tx
> >
> > Multiple levels, multiple if:then: (further) - I don't find this binding
> > manageable/readable. You should split it, with common binding defining
> > common part of hardware or interface if there is such.
>
> I as you suggested, I'll split it. Just to double check, should I fix
> any bug found in there (like existing compatible strings having underscore
> separators) ? Or should I just split and make sure only new SoC support is
> bug free ?

You cannot just change existing compatible values, as they are part
of the DT ABI.

When you split RZ/G3E off into a separate file, please drop the
"rcar"-part[*] in its compatible value, and move the SoC-specific part
right after the comma.  Perhaps "renesas,r9a09g047-sound"?

[*] Disclaimer: I haven't read the RZ/G3E audio chapter yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

