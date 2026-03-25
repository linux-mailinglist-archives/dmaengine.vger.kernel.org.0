Return-Path: <dmaengine+bounces-9640-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EluE1+Xw2nNrwQAu9opvQ
	(envelope-from <dmaengine+bounces-9640-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 09:05:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7B3211DE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 09:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D41030C70FB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2026 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4176283FEF;
	Wed, 25 Mar 2026 08:03:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6075382398
	for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425795; cv=none; b=GFkw0OtM3aRByRc8UkstWb8ON8cYGh37uQr4VfJqos6WQHNMxjpla6GmhVWznUTz1EwkkKhPFAJvFKNLq3yt+RmjM/toEJFmDbbRs5g0+q/rmB4Bww/fviZX/HfayNK5Y2N0O3egd/x5vQX4y4bCe4ARbIw3QnCDT8n4rtH5044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425795; c=relaxed/simple;
	bh=ZYG/k7kjLeCs+G5BXN/DGjRFcRRtBzlVxNoa6nU4SS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2g4kUKlnOOphgr6hexBsORUtoyTGLMcfS6yJjZlGLK8Hy7Gu3FCj99fkDiYfSq8UB1vGZ/h1vGf9foFjh7NjzZOVMb22h3qdkOp+GYjPBxTfgtOj95WwcGVusIyU6lzkN4NayuPsIpEQKfZmU8ooUKBVgJ6yn5L/SyTYAdW44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56cde28a9b6so1864955e0c.3
        for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2026 01:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425792; x=1775030592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEgogPO73kZUH+F/LPjEzcWkUO0MFC82X3nlBvBxxvY=;
        b=Xb+72kUEkfh7udQTdo/0ZMS8TUDkO+zirrSGB9dSKmgZiMvNau712G7XemIJh5TI5p
         8Qekr/nR0pF9dzNyof0wgWhfqlU6Hgn8oypGAEm7Mj/4LRV+JHHKGCcSSsd3KKHLNp4o
         mDxnCf8x1QVM8Xq+mnjLalvPn+SEx5xpvXoR/dejTRg/2sJsqaO0NUfQmTR+2TQ4q199
         jrOMnpKyPaj3UFt8Usc3QtJp24biA8gRpYGo4d7xV5C/+FbO65f+PCKQ1pvLx5AKCeXL
         nAvRa2oWIAcxNtvsPfcAc6T7VgJwANJOS6ZoEfpv6uKJS90EFn0L/9NSwsX8wV9Vy0f6
         dTpw==
X-Forwarded-Encrypted: i=1; AJvYcCVfztQhLatCYIdh1a8d6tmQmLbp/hRIcMpbpR90hl90qVHK1cSo1xOwcr5akJha+/0z8WOUSMiC8jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbmvAWi/XBamJVo684O4jpd6X+yIeCsmwupDVzfcn+5mZOdQm
	/Nh3/K/w9cbKnqKEefwY8pwtfKP7JGsozPoPVVmtrCjFOTNxXGCCeRIMujW3qYGRBCs=
X-Gm-Gg: ATEYQzykexdXF84HtVuCjnnsaMCZTT32GmIassMIhm5Aj9EFwcK5e7JUxTi45itJk2k
	f/lG4LwS3a6QhA2ACWZXMp/YJgPSGFi0yg/DcrNruaj5Z2lGDCikrj+p1N3S4tH3aqRijrjQeD1
	7w+jN1RFS5veS7tvpJLDraBjWxMdmQ9LymETccE3+rPWJ5aLbWoZKrLb6UNnqhsH1VLiyYKmnVh
	KZYs3jp3JTVECsMaTgk8WdMJfzhLipWHZFzEE/kupSO8KlBLcLJB55rdOy9J0pYfkqgXYRvB7YU
	eao3T2/E+RR6UMib+piKTkiYa+rVriKvkQ7Q5YsigCx7ech2Y7LVbbyPvOievjKzvznjmmjH9r0
	xgnAYrurX8+9Vv/gYCHQ+8o2TZYlUadaDcI1lAsCAn8l4oakA28xEiqfxTOlsWxOqEO32ldr363
	N1Tjds/QhQ1SH5QkiKr70Wvp7v8Jq/8RTnHNq3b7s75oEaWpUW4Q3FE2O5izm18dCb
X-Received: by 2002:a05:6122:678d:b0:56b:95a5:da18 with SMTP id 71dfb90a1353d-56d22069f0amr668162e0c.10.1774425791565;
        Wed, 25 Mar 2026 01:03:11 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcf1554sm19582985e0c.17.2026.03.25.01.03.10
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 01:03:10 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so2708765e0c.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Mar 2026 01:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEAuWv4vcHZXur4b7W1S4uQYm5wydFPYaTwzc2b9dlLvgpcKfygjgn5Bz4TY+LkL/P3OCs00ytB5E=@vger.kernel.org
X-Received: by 2002:a05:6122:311e:b0:56a:e0e2:69b3 with SMTP id
 71dfb90a1353d-56d21cf9aa1mr1214240e0c.0.1774425790419; Wed, 25 Mar 2026
 01:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com> <20260320112838.2200198-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260320112838.2200198-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 09:02:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUw+Dg4wEv9+F71aWgY9SLxPO6DyXO+30Gi_sNFpxechQ@mail.gmail.com>
X-Gm-Features: AQROBzBTFk3wDshBCZKCcekMpDggyNDKzrPFZ_w0YB_UnpLQ_sKycSkS0HnN5zA
Message-ID: <CAMuHMdUw+Dg4wEv9+F71aWgY9SLxPO6DyXO+30Gi_sNFpxechQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com, 
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	p.zabel@pengutronix.de, fabrizio.castro.jz@renesas.com, 
	john.madieu.xa@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	tommaso.merciai.xr@bp.renesas.com, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-9640-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: BAE7B3211DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,

On Fri, 20 Mar 2026 at 12:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
> files occasionally contained random spikes when viewed with a tool such
> as Audacity. These spikes were also audible as popping noises.
>
> Using cyclic DMA resolves this issue. The driver was reworked to use the
> existing support provided by the generic PCM dmaengine APIs. In addition
> to eliminating the random spikes, the following issues were addressed:
> - blank periods at the beginning of recorded files, which occurred
>   intermittently, are no longer present
> - no overruns or underruns were observed when continuously recording
>   short audio files (e.g. 5 seconds long) in a loop
> - concurrency issues in the SSI driver when enqueuing DMA requests were
>   eliminated; previously, DMA requests could be prepared and submitted
>   both from the DMA completion callback and the interrupt handler, which
>   led to crashes after several hours of testing
> - the SSI driver logic is simplified
> - the number of generated interrupts is reduced by approximately 250%
>
> In the SSI platform driver probe function, the following changes were
> made:
> - the driver-specific DMA configuration was removed in favor of the
>   generic PCM dmaengine APIs. As a result, explicit cleanup goto labels
>   are no longer required and the driver remove callback was dropped,
>   since resource management is now handled via devres helpers
> - special handling was added for IP variants operating in half-duplex
>   mode, where the DMA channel name in the device tree is "rt"; this DMA
>   channel name is taken into account and passed to the generic PCM
>   dmaengine configuration data
>
> All code previously responsible for preparing and completing DMA
> transfers was removed, as this functionality is now handled entirely by
> the generic PCM dmaengine APIs.
>
> Since DMA channels must be paused and resumed during recovery paths
> (overruns and underruns), the DMA channel references are stored in
> rz_ssi_hw_params().
>
> The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
> driver no longer manages DMA transfers directly.
>
> Finally, rz_ssi_stream_is_play() was removed, as it had only a single
> remaining user after this rework, and its logic was inlined at the call
> site.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/sound/soc/renesas/Kconfig
> +++ b/sound/soc/renesas/Kconfig
> @@ -56,6 +56,7 @@ config SND_SOC_MSIOF
>  config SND_SOC_RZ
>         tristate "RZ/G2L series SSIF-2 support"
>         depends on ARCH_RZG2L || COMPILE_TEST
> +       select CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM

Please drop the "CONFIG_"-prefix.

>         help
>           This option enables RZ/G2L SSIF-2 sound support.
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

