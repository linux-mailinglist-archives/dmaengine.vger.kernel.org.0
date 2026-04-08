Return-Path: <dmaengine+bounces-9930-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJD5Aw8l1mklBQgAu9opvQ
	(envelope-from <dmaengine+bounces-9930-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 11:51:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD383BA22F
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 11:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BA23020A6E
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C53ACEFB;
	Wed,  8 Apr 2026 09:50:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCF39E183
	for <dmaengine@vger.kernel.org>; Wed,  8 Apr 2026 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641804; cv=none; b=hVVek+moDBQ4P3PITDeGl7u0NxsMLsfRHZWe8wUvRKCt9P+LxLYQjLX1qfHIUDDhQGhYfvbPSv0py8CUCqUZCOjKPsdU3ww9WgegIGDJxzSKd3SydHl1tUdouf4MrM5E6N3MbrWqkMzEk/yiK+l/GjseiesR6xwxREQ0o8DP+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641804; c=relaxed/simple;
	bh=O0dPKIPUwqcZQdDhmwfagNKRPoro50YwQ5jiiYuAkY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQFn0TwWE1jKxwBF6BGy47jDaTm641mvV3nfqOaieoP4l3EfTbxLJnyRDLcP9jNM3qN5iFO0LGBHHhDJXOWxJwj5aiF0muvesp0TvqYwMXD+o7/BShngG4o0FawsZOhOe4WQ6ZGkY05aHzDmgpSnjcD/O4PrxmppCxXtif2biT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47018d341f8so3155044b6e.3
        for <dmaengine@vger.kernel.org>; Wed, 08 Apr 2026 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775641794; x=1776246594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quvvcejYXNcTSghIu/ABG/aBBVzSmRl0OrHbMTAKiNc=;
        b=szAgreVQGKR6kBw0bkWNk3qeXF6lSC5can9vRfMcgClEn41qMRVMHG1Wo1eamIOMxL
         VW3XIO7jvhHQTaDvbGgLLyXt5K4/polE8TdP+fkzEhoi64JGUDE2mqHSrIprEvITQ5aq
         +mUawKsspya3rZMjfrDGFT7T8Fw4GsPzVOlihoxgHZeJEuQwJrNKINRGEFgHKHOqA3vW
         L0gTiWZ+sHCf+cm+2jDhv75clyqmFCXOlK3fMRsLJPJOJqzDxUp+/LPFaCzDC+LmgA+V
         id3qPwyxl9PxUBivyxk4YNkubuH+MdjqYLilRi2/trJeo9PCJGrxqFwgE3QTXQ8xbTUK
         8dZg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZvOuXL6Dj2RgfjdzcrNoi8pmZYDv+rZf6OjkQG3JdG6XVYdKLFtge2uvhLziKPkff66UvmzglMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wo91utbOpOwvDG/Vk3GgUBYr/ctG8L16PYCKvWA1d8hCCzIU
	0TRJyWJSxmJoabQyU8w6/PUu4eixQr/GB5Nj9T0GHZTx6aJ0/lTxD8QB/LCyRoN0
X-Gm-Gg: AeBDievCKympqKCQ4N2bFv9ohnFaz0WS5tDmfvUwr49RPN80hmeKDbiWkYbvD5kCJ45
	LrCQQiVpkFfzoNHJL4rK//26zbUH667QeBS6BmCPU2yYYF9leJ38rxC32pMUENNB4dETN3epRiG
	zphDdCtwlxTRAPBB3qSew9tvDsjl/bZNVb8LP+5H+7SUBsc2ThWpcCe+mMoK1zEQ8DpL4DrkdqD
	7g7eBhHsMwDqOjoljEyc0daqsuOQwp2ianP2MpY5+OaDK88ksnvv8/EBlsbSnnJY6qOBLP3bLj7
	h6YJAcUXgsrNHWa0vdl5aDYpoajCsr813ydry4uBVIH7kwkYQNKeEiQjn5vOLangY1vIl+ISbnU
	qAZyEl8CXUwh7IiMT5QysWVw25U8aXVgmUcLGleo115l41i4INpELy8Y284JItRcpHN2Rl7oZZt
	evyNrKrBJjO6YbBwtTgDtiHU1M78F+4WKI09dIxJv/WWa45DkjG/FiHeXwXe/yf0P5
X-Received: by 2002:a05:6820:6108:b0:688:2480:7fa8 with SMTP id 006d021491bc7-689c1c169a5mr254600eaf.21.1775641793781;
        Wed, 08 Apr 2026 02:49:53 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25acbesm18719700fac.11.2026.04.08.02.49.53
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:49:53 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47018d341f8so3155032b6e.3
        for <dmaengine@vger.kernel.org>; Wed, 08 Apr 2026 02:49:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQcsn+ht7vs73yMVBXua/1J4Kn7meMMEj1LGCZrN4g9RLao45k0Z2A4Z88pA40PiFQFj6XBvA1fho=@vger.kernel.org
X-Received: by 2002:a05:6122:a5c9:10b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-56ee9cfa0fbmr3844058e0c.3.1775641295235; Wed, 08 Apr 2026
 02:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com> <20260402090524.9137-25-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260402090524.9137-25-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 11:41:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLb3Wj=4qK_5jLsiN28i2LDYPVH9ch91Y6e8XyT+yjjA@mail.gmail.com>
X-Gm-Features: AQROBzD3bL2aOOG6EzT_imFnbWnAbXmWWZH1UF0TeTlDTbev2ZgK_ZCcpyzlvIk
Message-ID: <CAMuHMdVLb3Wj=4qK_5jLsiN28i2LDYPVH9ch91Y6e8XyT+yjjA@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] arm64: dts: renesas: r9a09g047e57-smarc: add
 DA7212 audio codec support
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9930-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.003];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,mail.gmail.com:mid,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DD383BA22F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Thu, 2 Apr 2026 at 11:10, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> RZ/G3E SMARC board has a DA7212 audio codec connected via I2C1 for
> sound input/output using SSI3/SSI4 where:
>
>  - The codec receives its master clock from the Versa3 clock
>    generator present on the SoM
>  - SSI4 shares clock pins with SSI3 to provide a separate data
>    line for full-duplex audio capture.
>
> Enable audio support on RZ/G3E SMARC2 EVK boards with a DA7212 audio codec.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts

> @@ -280,6 +358,42 @@ &sdhi1 {
>         vqmmc-supply = <&vqmmc_sd1_pvdd>;
>  };
>
> +&snd_rzg3e {

Please preserve sort order (alphabetical, by label).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

