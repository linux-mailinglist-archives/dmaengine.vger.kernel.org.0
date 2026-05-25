Return-Path: <dmaengine+bounces-10832-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EF8Edf0E2olIAcAu9opvQ
	(envelope-from <dmaengine+bounces-10832-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:05:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AD5C6E25
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23FD302ED5D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCF3A963A;
	Mon, 25 May 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZfhIfDW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62893ADBA2
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692683; cv=none; b=WysFfYEQDP9NteB9eeJ2K9GIobdnL7gqLYIVN3M7g6fxG8Wbmw84iNvjEXB3XKupJXLWNuXmPglz7jZuLbiQgMYtYP/5LU2TBbngd9YjLxFYU8B6TkdWkGojsi7ggMrqxjCDJiHlVdNkZDwS4SJ168ISRO8DNEiEf6+lNvGrcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692683; c=relaxed/simple;
	bh=pkNdc7UjmZ9aY/R2aaQiGsEAaq1DekcHjHkiV8tmHqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2XIG9aQpEJ/H1k7/JddRZwIjqOMSaD6kiKHVdO473egihyWnH1gbKl/Ji5ji2WqMgA0ZFN2bLnXIZpoVJRimF+RsW8Ak7GvxTwO5MOE6QPUuRI9t8NrgIGXR9AzxcZNBWW1vjJXp0z5ml/DNghN8KkF/0vyHj+dnXVdIl9Litw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZfhIfDW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E971F000E9;
	Mon, 25 May 2026 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779692679;
	bh=WLQVgtxyjJ0IWkcqQ1l1tKZDhdnE9q4WiNUhlReDnpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZfhIfDWllmN0dTwhAiZ9YPvtUA7Aq7L8f6SGTJEZGUwkHE3JIBrhBJ3PIxrrDYCP
	 sunDzIkBIVSpCqVC4b/4a9QDuxoflbzlp6MiFH4Gbmvr+kP/Xw8L52kknVHAckTVOl
	 PIx1kAsO2qtzY4trXVgOKnVDRu5g1xmT2NXaXsdrs3kM5UgOn0StFe4puuU/homaP+
	 coJYD1KptdIvrq0+VtaoqsTQtDDv4ejyKLzDZFt3qpnyAVfGcgW1d43XMcMXnIf2P+
	 F0TWLio2DOxf8fYdfBHEV08SbSn6tLICyIOui541l1uSyZOuO45QpkQytrCNUAhr+e
	 CsyUfbFbRpkIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] dmaengine: dw-edma: Add partial channel
 ownership mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260525062420.3315904-4-den@valinux.co.jp>
References: <20260525062420.3315904-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 07:04:38 +0000
Message-Id: <20260525070439.00E971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10832-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 9D3AD5C6E25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The partial ownership validation check fails to ensure exclusive d=
irection ownership when the hardware channel count exceeds the driver's max=
imum supported channels, leading to unsafe sharing of direction-wide regist=
ers.

Pre-existing issues:
- [High] The driver requests shared IRQs before fully initializing the IRQ =
context data, leading to a NULL pointer dereference if an interrupt fires e=
arly.
- [High] IRQs are freed before the DMA device is unregistered in `dw_edma_r=
emove()`, which can cause ongoing or newly submitted DMA transfers to perma=
nently hang.
- [High] The software IRQ mask is updated before `vchan_init` is called, po=
tentially causing an interrupt handler to lock an uninitialized spinlock.
- [High] Tasklets initialized by `vchan_init` are not killed on the error p=
ath of `dw_edma_probe()`, leading to a potential use-after-free.
--

commit de1f8f856f48478dee0587184f6b0a5366a8f8f7
Author: Koichiro Den <den@valinux.co.jp>
dmaengine: dw-edma: Add partial channel ownership mode

Some endpoint DMA frontends expose only a subset of a controller that is
also initialized by the endpoint-side OS. This patch adds a partial
ownership flag so dw-edma does not reset controller-wide state in probe()
or remove(), preventing disruption of a peer OS instance.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index a70e0640d082c..fcef9a27b6cef 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -1159,13 +1174,23 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> =20
>  	raw_spin_lock_init(&dw->lock);
> =20
> -	dw->wr_ch_cnt =3D min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt =3D min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	hw_wr_ch_cnt =3D min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> +			     EDMA_MAX_WR_CH);
> +	hw_rd_ch_cnt =3D min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> +			     EDMA_MAX_RD_CH);
> +
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		/*
> +		 * Direction-wide registers are shared by all channels in that
> +		 * direction, so a direction must have a single owner.
> +		 */
> +		if ((chip->ll_wr_cnt && chip->ll_wr_cnt !=3D hw_wr_ch_cnt) ||
> +		    (chip->ll_rd_cnt && chip->ll_rd_cnt !=3D hw_rd_ch_cnt))
> +			return -EOPNOTSUPP;
> +	}

[Severity: High]
Does this validation safely ensure exclusive ownership of the direction
when the hardware has more channels than EDMA_MAX_WR_CH?

If the underlying hardware has 16 channels, hw_wr_ch_cnt will be clamped
to 8 (EDMA_MAX_WR_CH). If the frontend assigns 8 channels to an instance,
the check (chip->ll_wr_cnt !=3D hw_wr_ch_cnt) evaluates to 8 !=3D 8 (false).

This incorrectly grants the instance ownership, allowing it to modify
direction-wide registers without synchronization, which can race with
whichever entity owns the remaining 8 channels.

> =20
> -	dw->rd_ch_cnt =3D min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt =3D min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->wr_ch_cnt =3D min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> +	dw->rd_ch_cnt =3D min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
[ ... ]
> @@ -1182,8 +1207,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
> =20
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}
> =20
>  	/* Request IRQs */
>  	err =3D dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);

[Severity: High]
This is a pre-existing issue, but can an early interrupt trigger a NULL
pointer dereference here?

dw_edma_irq_request() requests shared IRQs using uninitialized dw->irq[i]
structures. The essential pointer irq->dw is not populated until
dw_edma_channel_setup() executes later in the probe sequence.

Since DW_EDMA_CHIP_PARTIAL skips disabling the core and leaves the
hardware active, an interrupt could fire between these calls, leading
the handler dw_edma_interrupt_common() to unconditionally dereference
the NULL dw_irq->dw pointer to access dw_irq->dw->core.

[Severity: High]
This is a pre-existing issue, but does dw_edma_channel_setup() expose
an uninitialized spinlock to interrupt handlers?

During dw_edma_channel_setup(), a channel is unmasked via
irq->wr_mask |=3D BIT(chan->id) before its virtual channel structure is
initialized via vchan_init().

Since IRQs have already been requested by dw_edma_irq_request() above,
an interrupt can fire immediately and execute
spin_lock_irqsave(&chan->vc.lock, flags) on a completely uninitialized
spinlock, leading to undefined behavior or lockups.

[Severity: High]
This isn't a bug introduced by this patch, but are tasklets left active
on the error path?

In dw_edma_channel_setup(), vchan_init() initializes a tasklet for each
channel. If a subsequent probe step fails (such as dma_async_device_register
failing), the function jumps to err_irq_free, frees the IRQs, and returns
without calling tasklet_kill().

Since the channel memory is managed by devres, it is automatically freed up=
on
probe failure. If a tasklet was scheduled by an interrupt before the IRQ was
freed, it will execute after the channel memory has been freed, resulting i=
n a
use-after-free.

[ ... ]
> @@ -1227,8 +1254,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
> =20
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
> +		dw_edma_core_off(dw);
> =20
>  	/* Free irqs */
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)

[Severity: High]
This isn't a bug introduced by this patch, but does freeing IRQs before
unregistering the DMA device risk permanently hanging ongoing transfers?

In dw_edma_remove(), free_irq() is called before
dma_async_device_unregister(). dma_async_device_unregister() is
responsible for quiescing the DMA engine, flushing pending requests,
and notifying clients.

By freeing the IRQs first, any ongoing transfers will finish in hardware
but their completion interrupts will be dropped, causing clients waiting
on these completions to hang indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D3

