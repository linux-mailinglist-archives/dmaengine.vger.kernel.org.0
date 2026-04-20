Return-Path: <dmaengine+bounces-10055-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFj0EZge5mkMsAEAu9opvQ
	(envelope-from <dmaengine+bounces-10055-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 14:39:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6942AD97
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE96A3024DCD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1239EF22;
	Mon, 20 Apr 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JMI6Xm92"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605139EF1F
	for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688462; cv=none; b=nkRb+i21sjNk7lUgVDajawbk99uGSI6c+L+f9/4It7qm+ig2LPwjx6jFOrky7YQ4rtfqcsWxC+S70tW2WqyGi0TV2+I44UTI1GAO+x+VNivPJ9/Cd1h5uIjxurxsW7GFjYFi5Dsu9uPcxlMBlmBSnGbhGHAqnwbnmqzjhjxV01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688462; c=relaxed/simple;
	bh=JbZKB0n+GFV0OBpzIrmVAI6C9Bk53uw2sEoaPlhHCOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7RidJ6jh29UcGVLE376gCaowpI+w63NYw2iu54sCZhsT916v2Hh+UxfydrOuKd0etz9Ng5dvQjIGUBD5veFTPHR8ISUpr6Jj72Oh9OhcpJyfXmys+Djnz8/Y2n217k/H2tdXrigcpn6fmKvii3ggFM4HdRp60LqI73uoSD87RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JMI6Xm92; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso33854445e9.2
        for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1776688459; x=1777293259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdpW+5L4fuwiJNGl1s+W8ELjLb4UMMlsktWZrXN7fjU=;
        b=JMI6Xm9234mhSr/51NNFxYM/mKCvbQCVbxh9WTi+u0uT7ozB37Xdf7USzS8OYoEKBN
         ZWXAGTd51aVkBMn3kYc84KAyzpWHy/B7697CQnFDWW/EvWAiYvmK6kzV2a5STG4RHXme
         wJx02MD5ZAr+oZlp8ZrEchgnTAaGCK/CGKVmoe/vpIQvoholGlmPoBBpPcLOm95SQA4s
         TDrDFCGgGbJo3GYpTYe9baILM4RcY0bi2WdALtXMXHXVgEVKBYGOdQrR1YKm0rRjHUC0
         slZjHlcX8RC35JEIIuE8aZqsVQHlNGPqgnWy+doMo23IS+YFxJXOJvM0cmSbWxrfpqsF
         m4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688459; x=1777293259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdpW+5L4fuwiJNGl1s+W8ELjLb4UMMlsktWZrXN7fjU=;
        b=iLmyUtXs0o/gGy0tB9BwbA83Nm6R3Bf9N6jEHz93CeH4Q9jKXHWgEU6vJWaAUK+HhN
         8y3oEddQ7wMn9ycpvYkdToVKhZloc1AAnpiJntKooMLqRu10OkYX6k/0lkZterHcqaT1
         26etFNige6HRD/tRR1yV2kpLsu4TeiWj1Tc258RPD4U5KuQDr+Q4XDSojVdxo5h/AmAp
         V85X9qzXdkT52fLcB65/3n/wh9JhRz0l0JlpRRaWN2Jk+crzRw8IyYv6I6h/SANxL7gn
         FZSowehhtqh2JGkUgwNAMf8glOMo9377ozGN4MXZExshmCYVzqzOJ+eqm1X7enIHJm4B
         k5VA==
X-Gm-Message-State: AOJu0YwW0CjY4GJIUnYztDiJ3juRcDRro/Kn6K0/mTMs5jU6cwp2sz8y
	qbd6NaVbMg2N6BCMu87fgCH4x/XqhsfHREqBBLyUgf/1KJFJrNa9nlBGYQt1l7nf5bo=
X-Gm-Gg: AeBDievBhIIr4qI35z4IuGHf1GIQHlz6EJdoTnzmHn5C6zy84BqUePHOIXO7qKz2N6i
	cmPdqra6LDB/8G7dMdm3qlQbBoVOgF3DVsuDTYcew2zjZcpgL4ERPLlVHkDf3BE+NDqSz5NF6gL
	CwgaxZHqfV7A4BVl5zfUifZHA8ebcpWQzJjSn6rQ5iCZtVQFMEEOV2Lo/ZTZ+/umPJ6Xh7VPgiv
	OE6vroPwB/Nd7jEbESgGrXZcG600Mt6WyLWBECKt2hic6Kz3RFNO+xtGT7OvwKiJAaQQ7z1oFXf
	q5wemE9ahS6PAdUEkQv+pDBIfmSowMR4nM+pzHfLC6foLBzefb+rEwXHGW00F4SQOvfSywjhQ18
	tBfyJp2KffJibW/egcSMg+bvxmArQCpj80C6th/hM1FWNz8/OYvaLjKO7hsfnmkI0SuXbfp4hTx
	qgjy36mb2xrqdXibBUodQ2N5Vkb1QSKJbfRFl6CSwSCg==
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id 5b1f17b1804b1-4891fa59adfmr35778405e9.9.1776688458190;
        Mon, 20 Apr 2026 05:34:18 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc13938fsm427469375e9.10.2026.04.20.05.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 05:34:17 -0700 (PDT)
Message-ID: <25318dd3-5892-4db1-97db-afb1c4b263a3@tuxon.dev>
Date: Mon, 20 Apr 2026 15:34:16 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko.dev review (Re: [PATCH v4 04/17] dmaengine: sh: rz-dmac: Use
 rz_dmac_disable_hw())
To: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-5-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260411114303.2814115-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10055-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,tuxon.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 50A6942AD97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > commit f7b3ac8bceb85f09d10e2c6b3d49ae768415c77c
 > Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 > dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
 > This patch unifies the hardware disable code by replacing an open-coded
 > register write with rz_dmac_disable_hw(), moving it after vchan_init()
 > so the channel device is properly initialized.
 > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 > > index 1717b407ab9e9..40ddf534c0948 100644
 > > --- a/drivers/dma/sh/rz-dmac.c
 > > +++ b/drivers/dma/sh/rz-dmac.c
 > [ ... ]
 > > @@ -1000,15 +1000,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 > >     }
 > >     rz_lmdesc_setup(channel, lmdesc);
 > >
 > > -   /* Initialize register for each channel */
 > > -   rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 > > -
 > >     channel->vc.desc_free = rz_dmac_virt_desc_free;
 > >     vchan_init(&channel->vc, &dmac->engine);
 > This is not a bug introduced by this patch, but seeing the vchan
 > initialization here made me wonder about the driver teardown path.
 > When vchan_init() is called, it sets up a background tasklet for the
 > channel. During driver removal in rz_dmac_remove(), the DMA device is
 > unregistered, but it does not appear that tasklet_kill() is ever called
 > for this tasklet.
 > Because the channel structures are allocated with devm_kzalloc, their
 > memory is automatically freed immediately after rz_dmac_remove() returns.
 > If a DMA transfer is active when the driver is forcefully unbound, could
 > the IRQ thread schedule the tasklet via vchan_cookie_complete() right
 > before the IRQ is freed by devres?
 > Since free_irq() waits for the IRQ thread to finish but does not flush
 > tasklets, could this scheduled tasklet execute after the device memory
 > has been freed, resulting in a use-after-free?
 > Should the driver explicitly kill the tasklet before returning from
 > rz_dmac_remove()?
 > >     INIT_LIST_HEAD(&channel->ld_queue);
 > >     INIT_LIST_HEAD(&channel->ld_free);
 > >     INIT_LIST_HEAD(&channel->ld_active);

tasklet_setup() only sets the members of a struct tasklet object. The tasklet 
itself is scheduled at runtime when the DMA clients requests transfers. On 
remove the DMA clients would have already been called the 
rz_dmac_terminate_all() and/or rz_dmac_device_synchronize() which should kill 
the previously scheduled tasklet.


