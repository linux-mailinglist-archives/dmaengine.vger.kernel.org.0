Return-Path: <dmaengine+bounces-9678-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBGAF3RXxWkk9gQAu9opvQ
	(envelope-from <dmaengine+bounces-9678-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 16:57:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F90337F9B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC8530DB995
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80041161C;
	Thu, 26 Mar 2026 15:27:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EF3FFABB
	for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538875; cv=none; b=JZMIBZn51O9sNP/xf31jk0bN9GC24mG5TsNZCfKWCWp0DSySDuHhJX9hqsA7a1yleZxw7Oz3+6Dk1dP0m9hmkxSIUMHZUoPDjC6NH77J882HuhAgiTOWL2qJ2jMbb7b2tWC0HUGSSZ7vCxdwGskgRFWZhfIsT0zS492v7IjYw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538875; c=relaxed/simple;
	bh=peWwslY60X5deNxQgqJv7OYyoSx6v0JNvTUpeeVZ1q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czkwNwQOVXQEmrTn8FLokIXbPy7MADGzS6saqiUe7hnsxuH9zYYytU1WqaP2bEyYLRi+elbc1iDJe87CrtkjNIPL00AqWpJAar02hH1YoyO+VoxKpD5Mo6vHe41/DzX9BhpH4uqXzdzn6ZoMJjYwenngnWMBzOfP0VZ7LgaIjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso630375241.3
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 08:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538873; x=1775143673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICY5En3i4NzNQi5qrag5c9s0SZbURVLCotK2DvpExx4=;
        b=iGL4yMB8y4ZPo9Sy0CJJt6cuTpjEAOwMTzijIOw36Iqpk6jNR8FJmcQpLfppJ+C9fg
         fDHUU15V0UbaefOv3xOLUhF7tCrzr7LTjV5v67jBdljqNUxcgOg3/8W9yXwI9oUEchwR
         UCiMsikJURqHqBKvQP8SatDARTLfJ0zDIfCnZzWwrLOiBh5WjX9iJnQp5lYfQBF7iKHc
         64xqeaz9aTcCH7QOx3NUGQMeEOzG7foPWNttKeMLGcAEkvihM8MAXDr1w6YjoMmtCWXf
         seCIjXVvs8zzO3xDVIFr0jP5rMcVPTVKve7ppEd0VhOdruPFpHhMpg1Nx0RWeAVpd7s6
         PDpg==
X-Forwarded-Encrypted: i=1; AJvYcCVxwdhRpS4a4Xbt0YoBJKow6cED8o/a7y/kOn0HlkXtR10mnFBKVq0Ywq1wp6N+yj8YGP3GHzUcKHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUjnhA3QQHOd/mQwmJb/cU51FSGNQO3Wf9o89EgFlluQ693el
	nNPS1f5uHfUr2yrpwmxuTwpuu7Klwg+q7F5Woe++v7wbwGhzzhLNunKHSPnB4Few2NE=
X-Gm-Gg: ATEYQzyptPR8LtVHShyX7R6YWi7glSPJ4mNkjqWYwPeFX0Psytgm35q5i77WHpT9qOr
	ZlEGc8nGYXRIAi8Qm4yapWzUyEEk4lURUUNmDhZWcs5+lQXe3raGnKqPQ/33/q39XqrwvbncYzm
	eoshwZTVOdQdySt3QosGtFXrdFPhk8748lvby+gzN+rwwfyQP6dU4GcqF9nh8JjeVBZX/Z7qLQi
	d2nBj/LykMvsYZovAKBgxo5HJeJvK/tzXG0wPK6iHmKFD+rtYgUCaJrq+sNKnyOLUhuDSdtDiXA
	ZtXGwtwW7G/d8kuxQCLsQVpo6831dUF2Nr5DNgHNFWWB+ZxXlA4uXtl4vKFnMc/YPLDeRmrXDWj
	o1m7z2b/ERHsm6O16QNiWEHf3NtQbaEsbMNmIey1wy5qT1g3nNw9McaA5hF3XbF72I4s0TyyRz6
	paSYDIZiJ7s4mvdsubXteD9FGU7u74w8XglY71RxKToP2dKHAQS4XrbYkBBEhl
X-Received: by 2002:a05:6102:dca:b0:5f5:4f68:9f7e with SMTP id ada2fe7eead31-6037900d2a0mr4006917137.8.1774538873355;
        Thu, 26 Mar 2026 08:27:53 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be5afc43sm3916129241.13.2026.03.26.08.27.51
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 08:27:51 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so686855241.0
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 08:27:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeAT1V41Lg84767G8AUVPptWI/s4qDmDpBC7fVTIt4MaYro68pjBodr7dsbH1kN7PaRcjo2VWlNqQ=@vger.kernel.org
X-Received: by 2002:a05:6102:5801:b0:5f5:2539:9b11 with SMTP id
 ada2fe7eead31-603870ce0f5mr4152226137.14.1774538871002; Thu, 26 Mar 2026
 08:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com> <20260319155334.51278-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260319155334.51278-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 16:27:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbP5Bbr9KuxoEb48zUvubT3CN7sC9oVat2NcNWaBwOtQ@mail.gmail.com>
X-Gm-Features: AQROBzCXM6uPDs6UcVr58TTtg0-_14CRbEgbIPerOfaOzDyxBM9HF9kuEp2hlRY
Message-ID: <CAMuHMdVbP5Bbr9KuxoEb48zUvubT3CN7sC9oVat2NcNWaBwOtQ@mail.gmail.com>
Subject: Re: [PATCH 04/22] dt-bindings: dma: renesas,rz-dmac: Document
 optional DMA ACK cell
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9678-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,renesas.com:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: 68F90337F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Thu, 19 Mar 2026 at 16:55, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Some peripherals on RZ/V2H, RZ/V2N, and RZ/G3E SoCs require explicit
> ACK signal routing through the ICU. Document the optional second cell
> in the DMA specifier for specifying the ACK signal number.
>
> The first cell remains unchanged and specifies the encoded MID/RID and
> channel configuration. The optional second cell specifies the DMA ACK
> signal number for peripherals requiring level-based handshaking.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

Just a quick head-up, as I haven't read the actual secion in the
documentation yet.

> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -63,17 +63,27 @@ properties:
>        - const: register
>
>    '#dma-cells':
> -    const: 1
> -    description:
> +    description: |
>        The cell specifies the encoded MID/RID or the REQ No values of
>        the DMAC port connected to the DMA client and the slave channel
>        configuration parameters.
> +      Use 1 cell for basic DMA configuration.
> +      Use 2 cells when DMA ACK signal routing through ICU is required
> +      (RZ/V2H, RZ/V2N, RZ/G3E audio peripherals such as SSIU, SPDIF, SRC, DVC).
> +
> +      First cell:
>        bits[0:9] - Specifies the MID/RID or the REQ No value
>        bit[10] - Specifies DMA request high enable (HIEN)
>        bit[11] - Specifies DMA request detection type (LVL)
>        bits[12:14] - Specifies DMAACK output mode (AM)
>        bit[15] - Specifies Transfer Mode (TM)
>
> +      Second cell (optional, when #dma-cells = <2>):
> +      bits[6:0] - DMA acknowledge signal number (from ICU ACK table),
> +                  where 0 is a valid signal number.
> +                  Required for peripherals using level-based DMA
> +                  handshaking (SSIU, SPDIF, RSPI, SCU, ADC, PDM).

How do you expect this to work? #dma-cells applies to all DMA consumers
of this provider, and these SoCs already have DMA users relying on
#dma-cells being one.
In addition, you cannot have optional cells: if #dma-cells is two,
then all consumers must supply two cells (of course we could switch
all of them to two cells at once).  However, as zero is a valid signal
number, we cannot use that as a dummy when no DMA acknowledge signal
number is needed (we could use e.g. 0xffffffff instead).

Is there any other way to provide this information?
E.g. could we have a table in the driver that contains this info for
the (presumably few) MID/RID values that need it?

> +
>    dma-channels:
>      const: 16
>
> @@ -212,6 +222,20 @@ allOf:
>          - renesas,icu
>          - resets
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-dmac
> +    then:
> +      properties:
> +        '#dma-cells':
> +          enum: [1, 2]
> +    else:
> +      properties:
> +        '#dma-cells':
> +          const: 1
> +
>    - if:
>        properties:
>          compatible:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

