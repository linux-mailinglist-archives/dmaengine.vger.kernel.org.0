Return-Path: <dmaengine+bounces-9929-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NZDKi0j1mklBQgAu9opvQ
	(envelope-from <dmaengine+bounces-9929-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 11:43:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185043BA081
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A37D305A459
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C73B19D7;
	Wed,  8 Apr 2026 09:38:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A953B5307
	for <dmaengine@vger.kernel.org>; Wed,  8 Apr 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641104; cv=none; b=e0wkpEVY962P3ZW3SoHcRx5hxXt1yggd/U23qA1hR8RDaobPJRFlG7jZTf5nSbCNCmt7fP7cNrg6Dgf+oHH8ofqvcuSE1JEI9RF3prc4Mb7hTUOGeTtQB/vxvNN2j5AU6oWkVtaeq2LYPbodaroEYAkLi6kZJ5N2jkFPHtl+Tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641104; c=relaxed/simple;
	bh=W4ocsbAken2i1Z0tr+aaOqS3kOkoeXQXKr5uS8XVQrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trfZW3Op6gpiIHBVkxJBhnWch+kr7uUcWdB9FXZG7M0a8TePvB/du2n+cB4JcMPo2PCzoEJ1KZ34balQ15H0wpf3d8EUvXG4y7zdnvLOqVCN5BoiI1whvpnTkoVG51KuHseW2uZ4d8g/bZFZW0TGjz+m9lS0OdeuVuE69Gav3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-604fb44270aso2035699137.2
        for <dmaengine@vger.kernel.org>; Wed, 08 Apr 2026 02:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775641101; x=1776245901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENmHKB8IOhUHnCXPKR1y0jyIBHSgRsTMWLYy39EVq6U=;
        b=rG3yUxJTm22DGiaXTgZLVwjvLNcSWlmjOzNBd9e5OelVzqZAhZDul/zV9uxeYn1jEv
         sgMlgw+fp1nqEtmFaKYpm1ZpCrXdOznwmjYluO9cAylF8kdCQFcZLVssTwQ6OotaVWzX
         AKjn1ECdobF4Wj72c1XMJVFLn7EEsk/V7tFcI97YLvIOzuSzS7a/Klr/nX0vJ54zuPbT
         Ou+WWFcynaUtCxHpHfyRWZ/029URIWEgkT+Y2/6gHBGMhmEqM8bEY0IdTeOF8BE55IWB
         fAkzaC6mlQjr0NXMl/08SmsT1xr8Ti/6XozURv8jhgH/w8OBkC25QPaTdR17x0yVwXqE
         CYTA==
X-Forwarded-Encrypted: i=1; AJvYcCVsxsIksJajifsbNbsBGFJjbBVzhHT6Hi8Emh9KlxN3l6NdAaYJrAGol5YhUImqLzFJAGntvLbJ5Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlVDaSBDaxWAUPjpBaqDJIxp4gLqo6d4lciyoFhV2ZUgV1gWz
	nOA0iYlZAS1z2OzijsKp+RhIwxwqn5DwTJK1/gO9h3Y5J2bJYILFqTVqAKTidIbg
X-Gm-Gg: AeBDiete6hlk4tUKHF9AYzB7J0Ubg/ZQG2YWcbsunI84swNpfplURBykIdbU3BpsFZZ
	o6gxDxw3THo9VGswXeIKv/ZR58g6iuQVMsXwz0fOfYxsMNvjkUaBE7YtmsHLvRNNNAWkSWmQOWZ
	Pm0j/LicDsdKSqOV7OArNKGsRufEdWjAHFGYVvTq5ostWKcBwUzoUGei9pqQRYXHPKqX1KZv1se
	gk9gLwqnkas4IAqmgCMccKFfJT5sh3aacCRrBR0TndGDYujgZkl8URXetZRh7axW/y+ZgbbbrCa
	TK5sUXxnlmpgMpK5Vxm+OSTiNr2UdFk+ph2XjoAl7NAwplm6VQpYf4ZWAqNflsh3SYBlcGXsIQF
	jBgl7msf1k+ekh7y9uijAbHa/VLAxEVLXbL+P3sHRCFa0PPySZGfjYKczsDMPAUn8iU7QlDJ8PH
	I3y4jBLg2R7BvaypKro1R8oVrpsrJjkvNPsC8FnobjOxa6iP6qp208avAI6Nmz
X-Received: by 2002:a05:6102:160b:b0:607:a195:6f38 with SMTP id ada2fe7eead31-607a1957028mr327792137.3.1775641101389;
        Wed, 08 Apr 2026 02:38:21 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605b214b45fsm14170391137.5.2026.04.08.02.38.20
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:38:20 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9519e97c01aso1551721241.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Apr 2026 02:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6U4pXF2+9O5qfnIMeI0cW7aoLg8VRSMON41Mb4IFbkxGZL6QRSoQIkIWGVfqo4RlGct4BypM9Xzo=@vger.kernel.org
X-Received: by 2002:a05:6102:f9a:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-605a50dbbb6mr7039796137.32.1775641100526; Wed, 08 Apr 2026
 02:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com> <20260402090524.9137-3-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260402090524.9137-3-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 11:38:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+a7cXRY=yEmXQW9=rYnyMCifhZs+je8LDHL6r=mBDMw@mail.gmail.com>
X-Gm-Features: AQROBzBW_0NoE-RyS2BqqQAlrdl0pZXBq89zZ06PmjJcnH1QXimxqhe4p2F4Ftk
Message-ID: <CAMuHMdU+a7cXRY=yEmXQW9=rYnyMCifhZs+je8LDHL6r=mBDMw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] clk: renesas: r9a09g047: Add audio clock and
 reset support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	John Madieu <john.madieu@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9929-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.205];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 185043BA081
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Thu, 2 Apr 2026 at 11:07, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add clock and reset entries for audio-related modules on the RZ/G3E SoC.
>
> Target modules are:
>  - SSIU (Serial Sound Interface Unit) with SSI ch0-ch9
>  - SCU (Sampling Rate Converter Unit) with SRC ch0-ch9, DVC ch0-ch1,
>    CTU/MIX ch0-ch1
>  - ADMAC (Audio DMA Controller)
>  - ADG (Audio Clock Generator) with divider input clocks and audio
>    master clock outputs
>
> While at it, reorder plldty_div16 to group it with other plldty fixed
> dividers.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g047-cpg.c
> +++ b/drivers/clk/renesas/r9a09g047-cpg.c

> @@ -460,6 +483,96 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
>                                                 BUS_MSTOP(3, BIT(4))),
>         DEF_MOD("tsu_1_pclk",                   CLK_QEXTAL, 16, 10, 8, 10,
>                                                 BUS_MSTOP(2, BIT(15))),
> +       DEF_MOD("ssif_clk",                     CLK_PLLCLN_DIV8, 15, 5, 7, 21,

Please preserve sort order (by _onindex, _onbit);

> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("scu_clk",                      CLK_PLLCLN_DIV8, 15, 6, 7, 22,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("scu_clkx2",                    CLK_PLLCLN_DIV4, 15, 7, 7, 23,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("admac_clk",                    CLK_PLLCLN_DIV8, 15, 8, 7, 24,
> +                                               BUS_MSTOP(2, BIT(5))),
> +       DEF_MOD("adg_clks1",                    CLK_PLLCLN_DIV8, 15, 9, 7, 25,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_clk_200m",                 CLK_PLLCLN_DIV8, 15, 10, 7, 26,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_audio_clka",               CLK_AUDIO_CLKA, 15, 11, 7, 27,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_audio_clkb",               CLK_AUDIO_CLKB, 15, 12, 7, 28,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_audio_clkc",               CLK_AUDIO_CLKC, 15, 13, 7, 29,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi0_clk",                 CLK_PLLCLN_DIV8, 22, 0, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi1_clk",                 CLK_PLLCLN_DIV8, 22, 1, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi2_clk",                 CLK_PLLCLN_DIV8, 22, 2, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi3_clk",                 CLK_PLLCLN_DIV8, 22, 3, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi4_clk",                 CLK_PLLCLN_DIV8, 22, 4, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi5_clk",                 CLK_PLLCLN_DIV8, 22, 5, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi6_clk",                 CLK_PLLCLN_DIV8, 22, 6, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi7_clk",                 CLK_PLLCLN_DIV8, 22, 7, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi8_clk",                 CLK_PLLCLN_DIV8, 22, 8, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("adg_ssi9_clk",                 CLK_PLLCLN_DIV8, 22, 9, -1, -1,
> +                                               BUS_MSTOP(2, BIT(2))),
> +       DEF_MOD("dvc0_clk",                     CLK_PLLCLN_DIV8, 23, 0, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("dvc1_clk",                     CLK_PLLCLN_DIV8, 23, 1, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("ctu0_mix0_clk",                CLK_PLLCLN_DIV8, 23, 2, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("ctu1_mix1_clk",                CLK_PLLCLN_DIV8, 23, 3, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src0_clk",                     CLK_PLLCLN_DIV8, 23, 4, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src1_clk",                     CLK_PLLCLN_DIV8, 23, 5, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src2_clk",                     CLK_PLLCLN_DIV8, 23, 6, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src3_clk",                     CLK_PLLCLN_DIV8, 23, 7, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src4_clk",                     CLK_PLLCLN_DIV8, 23, 8, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src5_clk",                     CLK_PLLCLN_DIV8, 23, 9, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src6_clk",                     CLK_PLLCLN_DIV8, 23, 10, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src7_clk",                     CLK_PLLCLN_DIV8, 23, 11, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src8_clk",                     CLK_PLLCLN_DIV8, 23, 12, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("src9_clk",                     CLK_PLLCLN_DIV8, 23, 13, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("scu_supply_clk",               CLK_PLLCLN_DIV8, 23, 14, -1, -1,
> +                                               BUS_MSTOP(2, BIT(0) | BIT(1))),
> +       DEF_MOD("ssif_supply_clk",              CLK_PLLCLN_DIV8, 24, 0, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi0_clk",                     CLK_PLLCLN_DIV8, 24, 1, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi1_clk",                     CLK_PLLCLN_DIV8, 24, 2, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi2_clk",                     CLK_PLLCLN_DIV8, 24, 3, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi3_clk",                     CLK_PLLCLN_DIV8, 24, 4, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi4_clk",                     CLK_PLLCLN_DIV8, 24, 5, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi5_clk",                     CLK_PLLCLN_DIV8, 24, 6, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi6_clk",                     CLK_PLLCLN_DIV8, 24, 7, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi7_clk",                     CLK_PLLCLN_DIV8, 24, 8, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi8_clk",                     CLK_PLLCLN_DIV8, 24, 9, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
> +       DEF_MOD("ssi9_clk",                     CLK_PLLCLN_DIV8, 24, 10, -1, -1,
> +                                               BUS_MSTOP(2, BIT(3) | BIT(4))),
>  };
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

