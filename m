Return-Path: <dmaengine+bounces-9626-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDZuKp6WwmkbfQQAu9opvQ
	(envelope-from <dmaengine+bounces-9626-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:50:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A6309BAC
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25672301BA73
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A03FD14C;
	Tue, 24 Mar 2026 13:45:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF93FE34E
	for <dmaengine@vger.kernel.org>; Tue, 24 Mar 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359925; cv=none; b=oUiRJ7PPYovSgerxplENeRvs1v67BNghiacOxIRS2OvS+72v+ob26obd1QqP9qlwsAnQtuDBzhlQTZaKb6vjfwakUCAuKXhQdJXJIKuyZs11dus6M2SUUqcaTazB+BM1jwXjoyMJeWlkBhzFc9Uzn8q1Zm+zdakk1hixbo8pHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359925; c=relaxed/simple;
	bh=jxD2923ET52CY8fhMQtErtaWu+053QLtVBSwzxbDk0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6mvrVgDj7dOGOPBz4dvaUmMjcOQ2PoFf1Pn1Zwj3mmzQl5wN7UF6PbyRm859hOVVDQwZpwR9JoP9BkONn+2PljPdigi6POfMX1dlyiF/T5681Z8Nlijp2J55htT3MSCiXBo4TGvOv7I5JAMidvhrERzSgSU9bQqCGPjki9dffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-41708f6c3feso716489fac.3
        for <dmaengine@vger.kernel.org>; Tue, 24 Mar 2026 06:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359922; x=1774964722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFHE6SbqkfrINgqOev1LeMJP9y3Lb6YlEweE9fpbW9I=;
        b=lzdsFKkIdBs6uN1e+PF4IAnW8zhZi8SxkF0dYGWrysL3lCjGTtj9KWsrQYV1I1spwk
         3X8oCSSEkXWpGsL4SV3meuaGQppmvFWeTl39Fk5KGVBbOUNurWx86QeQZMOv/TIoCXZ4
         1HH1iLSGsYh977B069vPsppvWW2VxW5EGAlw1dxf5g6SAODkqsFdC3Aa0hGty5Tu9V/r
         CrSVWKaag7jsHVApAHIQ6XCthmBlUclSSPndDb3xTAutDhVvcBqCWD73IBev4H5vZQT0
         fOjKZXF2NJRtb54Ve2/Ybfi9jBXZQxdI8/ZehnXrwxRU7ZSrp+ROcRt0FC35yUBDPp8Q
         PzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbYOnxk09tWOIb1NSfj8G/x8gSbknRq9/iTGgcPTER8oGZG7lfv6HHRTC3QnFO6MCkjAknwAT8c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0u+ZgIh8ioNxhJFzVFIwM0FyU62Zc/4aVw7S3sLKgDj6XecA
	npcJnlDPBN+F5Nfy9NGlcGL67xF7Wjv8Qyq1pQRw0QL0EWEM6AgjpE9hMNwRQ0r9EYk=
X-Gm-Gg: ATEYQzwBGADDulFDgqkSXTQoD/jgxrahE0ldBQflyeQtQVjNSddh1AkBZphtGe58Lqz
	EdnEVxVQxA2X599NbrndCKjToD/qQxCC/wIdqgLvucHiElnSeRh5VoNpxMnzX+yUKPt7sGKvr44
	UbLlHf88fvK1uhaARFJhax/txWSkbjo4Y239huZGpjEgepdIGqEF4dppZMucoUMq0t2BNIw8awr
	0Wu/fyCLhyspBToHok1/HCIww6ChdaciHcjcGaLtPtHiMno4OHxTiFLL642RFJ9re44arWluq+S
	v2bHoqcIWSY0RG/miMLij+eQskb2KqN8piDDyT9mAW5tJ/ayxYhCA/5LMvjnBv7K6buwOM9nb8U
	WKsk2XvWyNgD4QWflTAAXYBqHEuAzN83YALqO5v/BWx1N1MIXpEGVJOZLDZ2rJIyxIPWrsEXIwu
	vN7B6eXTJgLssca1fL3KiXgz9Kf469P/1nbF15t7xfRkm2Hv9HVtglNYM/xNJo
X-Received: by 2002:a05:6870:5689:b0:3f4:fed5:d88b with SMTP id 586e51a60fabf-41c111dfd93mr10624116fac.35.1774359922405;
        Tue, 24 Mar 2026 06:45:22 -0700 (PDT)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com. [209.85.160.53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5f99sm13797760fac.2.2026.03.24.06.45.22
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 06:45:22 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-417571c6083so654614fac.2
        for <dmaengine@vger.kernel.org>; Tue, 24 Mar 2026 06:45:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNiVE+kgwk+GNrhTlc0wddutklh11Hk9vZq+fBUfkfmYNkePkaDy0iQRbx/I9H/rKaCOS5YXTpJ2g=@vger.kernel.org
X-Received: by 2002:a05:6122:7d2:b0:56b:5893:d042 with SMTP id
 71dfb90a1353d-56cde498b94mr8236000e0c.12.1774359455206; Tue, 24 Mar 2026
 06:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com> <20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 14:37:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9uvkcU789W+K38qxVTVQbFHGOaBgqNkj7SbTR8WShoA@mail.gmail.com>
X-Gm-Features: AQROBzBcCn1BnwXSbjTDtD6HtzQVV_AICC4S_yzN7SsVw9iP4uwy2_3tUoSu3Ao
Message-ID: <CAMuHMdW9uvkcU789W+K38qxVTVQbFHGOaBgqNkj7SbTR8WShoA@mail.gmail.com>
Subject: Re: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9626-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,linux-m68k.org:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 207A6309BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Thu, 19 Mar 2026 at 16:56, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add SSI support for the Renesas RZ/G3E SoC, which differs from earlier
> generations in several ways:
>
>  - The SSI block always operates in BUSIF mode; RZ/G3E does not implement
>    the SSITDR/SSIRDR registers used by R-Car Gen2/Gen3/Gen4 for direct SSI
>    DMA.
>    Consequently, all audio data must pass through BUSIF.
>  - Each SSI instance has its own reset line, exposed using per-SSI names
>    such as "ssi0", "ssi1", etc., rather than a single shared reset.
>
> To support these differences, update rsnd_ssi_use_busif() to always
> return 1 on RZ/G3E, ensuring that the driver consistently selects the
> BUSIF DMA path. Also update the reset acquisition logic to request the
> appropriate per-SSI reset controller based on the SSI instance name.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/sound/soc/renesas/rcar/ssi.c
> +++ b/sound/soc/renesas/rcar/ssi.c
> @@ -123,8 +123,15 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
>  {
>         struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
>         struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
> +       struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
>         int use_busif = 0;
>
> +       /*
> +        * RZ/G3E does not support PIO mode. Always use BUSIF.
> +        */
> +       if (rsnd_flags_has(priv, RSND_SSI_ALWAYS_BUSIF))
> +               return 1;
> +
>         if (!rsnd_ssi_is_dma_mode(mod))
>                 return 0;
>
> @@ -865,6 +872,8 @@ static int rsnd_ssi_common_remove(struct rsnd_mod *mod,
>                 rsnd_flags_del(ssi, RSND_SSI_PROBED);
>         }
>
> +       rsnd_dma_detach(io, mod, &io->dma);

This goes BOOM on R-Car Gen3 and Gen4:

    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000004
    Mem abort info:
      ESR = 0x0000000096000004
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
      FSC = 0x04: level 0 translation fault
    Data abort info:
      ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    [0000000000000004] user address but active_mm is swapper
    Internal error: Oops: 0000000096000004 [#1]  SMP
    CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
7.0.0-rc5-arm64-renesas-07233-g377893124b8a #3530 PREEMPT
    Hardware name: Renesas Gray Hawk Single board based on r8a779h0 (DT)
    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : rsnd_dma_detach+0x10/0x20
    lr : rsnd_ssi_common_remove+0x48/0x74
    sp : ffff8000818ebac0
    x29: ffff8000818ebac0 x28: ffff000441c02938 x27: ffff0004408a8410
    x26: 000000000000000d x25: 0000000000000000 x24: ffff8000817b9970
    x23: 0000000000000000 x22: 000000000000000c x21: 00000000fffffdfb
    x20: ffff000441c02938 x19: ffff0004402bc080 x18: 00000000ffffffff
    x17: ffff000440ba6600 x16: ffff000440ba6a00 x15: ffff8000818eb700
    x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000030
    x11: 0101010101010101 x10: ffff800080fa7670 x9 : 1fffe00088052d21
    x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : feff636d746e722d
    x5 : 000000000000003c x4 : ffff800080a9dcc4 x3 : ffff0004402be800
    x2 : ffff000441c029b8 x1 : ffff000441c02938 x0 : 0000000000000000
    Call trace:
     rsnd_dma_detach+0x10/0x20 (P)
     rsnd_ssi_common_remove+0x48/0x74
     rsnd_probe+0x2d0/0x448
     platform_probe+0x58/0x90
     really_probe+0xb8/0x294
     __driver_probe_device+0x74/0x124
     driver_probe_device+0x3c/0x158
     __driver_attach+0xe0/0x1b4
     bus_for_each_dev+0x78/0xd4
     driver_attach+0x20/0x28
     bus_add_driver+0xe0/0x1e0
     driver_register+0x58/0x114
     __platform_driver_register+0x20/0x28
     rsnd_driver_init+0x18/0x20
     do_one_initcall+0x7c/0x184
     kernel_init_freeable+0x200/0x2e0
     kernel_init+0x20/0x1cc
     ret_from_fork+0x10/0x20
    Code: a9bf7bfd aa0003e1 910003fd f9400040 (b9400402)
    ---[ end trace 0000000000000000 ]---

> +
>         return 0;
>  }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

