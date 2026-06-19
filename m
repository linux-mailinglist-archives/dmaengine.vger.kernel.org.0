Return-Path: <dmaengine+bounces-11636-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5FKdGQzQNGpthgYAu9opvQ
	(envelope-from <dmaengine+bounces-11636-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 07:13:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69E6A3ED7
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 07:13:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZXPT8gDI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11636-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11636-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BAE1304D752
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6B330656;
	Fri, 19 Jun 2026 05:13:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46227306743;
	Fri, 19 Jun 2026 05:13:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781846023; cv=none; b=ndnYfCoAEfzASVIngJUXnu5rcNYyujPi5PLEyiF+ZJiwEVN2yP2U35QXTa7PSym/nsEQ8BlkodKCo2DNdfXpuoy9Pa/whJjyGuMVMSFYiuATjxYGc8zvVTLaisNINGsibFy1uQ+HJVnDn1AToF0Fwi7juVxhmhtijJ3qTfTqBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781846023; c=relaxed/simple;
	bh=YeDhLsmSHpuldpoUsL46AW9cIzzlYHOGkAPxh7EgYJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YMZZgub9VZPPvuit7VUJvfDopOrQuNd8VQwKPzBnRgcDP3LkALZCTEG6P7u9KRBviCwAgwZH7wll+62ZTL4nHFMHnjTfrbl0pr+lCS3102r/ih8YpW12plZSK6/TkR+RtzTm5vOWVb+t3EaairJyKiBKp9VUaNO4a4Io9/da0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXPT8gDI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8166C1F000E9;
	Fri, 19 Jun 2026 05:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781846021;
	bh=jlFuPad2Awrm3osmtp+zkZ1LvIWE0pE6oPvkZeQoJ2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXPT8gDICosgIblWuO9EYZvXbMae2olwRQjlH62SAHrH8JwZOKm6em6zJ7RUy4cu5
	 mBTyVg1hqIUng+LGfS7fXj4wtLLON7azSGuKzzsA9mBVeH2ir9djFbscK9V357plb3
	 WKIUo0vfN8iaJaaOiWF5+9yarBoTil7pYoWU3u/K9q/aTy/rVpN8d61RFlTVcQyFdc
	 1sJUZhLBnxYQ5RLuZ/hA294BDCeI5c/XSPSp66pRDUb/y9ba2PxLAoZDdRxw/EcfUZ
	 58pKxZFd5FZWivIqX+LWnQXnjhSe3iHMv3uUEyDkisKtnUuHnEb71buJJTNrFkwOFG
	 b1fxK990fJvpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260619-sun60i-a733-dma-v1-1-da4b649fc72a@gmail.com>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
 <20260619-sun60i-a733-dma-v1-1-da4b649fc72a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 05:13:41 +0000
Message-Id: <20260619051341.8166C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11636-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE69E6A3ED7

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] The parameter `chan_num` in the newly introduced `read_irq_en` and =
`write_irq_en` callbacks is highly misleading because it expects a register=
 index, not a channel number.

Pre-existing issues:
- [Critical] `sun6i_dma_interrupt` incorrectly maps interrupts for higher c=
hannels to the wrong physical channel structs because it ignores the outer =
register index.
- [High] Integer division truncation in the `sun6i_dma_interrupt` loop boun=
d completely ignores interrupts for higher channels on SoCs where the chann=
el count is not a multiple of the channels per register.
- [High] `sun6i_dma_terminate_all` and `sun6i_dma_pause`/`resume` acquire `=
sdev->lock` without disabling softirqs, creating a deadlock with the DMA ta=
sklet.
- [High] `sun6i_dma_interrupt` accesses `vchan->cyclic` and dereferences `p=
chan->desc` without holding `vc.lock`, racing with channel teardown.
--

commit 47f7d45b0543fc62a4eb37d06b46eeffe4dd06c6
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Refactor to support A733 interrupt and register handl=
ing

This patch refactors the sun6i-dma driver to support the Allwinner A733 DMA
controller. It moves interrupt handling and register dumping functions into
the sun6i_dma_config structure to handle different register layouts.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..d92e702320d9f 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -138,6 +138,11 @@ struct sun6i_dma_config {
>  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
> +	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num);
> +	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_=
val);

[Severity: Low]
Is the chan_num parameter name misleading here?

Looking at sun6i_dma_start_desc(), the value passed to these callbacks is
actually the register index (irq_reg), not the physical channel number.

Could this cause confusion for future implementers who might try to use it
as a literal channel index?

[ ... ]

> @@ -549,14 +573,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, voi=
d *dev_id)
>  	u32 status;
> =20
>  	for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {

[Severity: High]
This is a pre-existing issue, but does this loop bound properly handle
platforms where the channel count is not a multiple of the channels per
register?

Because integer division truncates, a platform like sun8i-h3 (which defines
nr_max_channels =3D 12) will evaluate 12 / 8 as 1.

Does this mean the loop only runs for i =3D 0 (handling channels 0-7) and
completely drops interrupts for channels 8-11, potentially leading to an
unhandled hardware interrupt storm? Should this use DIV_ROUND_UP?

> -		status =3D readl(sdev->base + DMA_IRQ_STAT(i));
> +		status =3D sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
> =20
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>  			str_high_low(i), status);
> =20
> -		writel(status, sdev->base + DMA_IRQ_STAT(i));
> +		sdev->cfg->write_irq_stat(sdev, i, status);
> =20
>  		for (j =3D 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
>  			pchan =3D sdev->pchans + j;

[Severity: Critical]
This is a pre-existing issue, but does this correctly calculate the physical
channel pointer for higher channels?

Inside this interrupt loop, i represents the interrupt register index and j
is the local bit offset within that register. By calculating the physical
channel as sdev->pchans + j, it completely ignores the outer register index
offset.

If an interrupt triggers on physical channel 8 (i=3D1, j=3D0), won't the co=
de
incorrectly assign it to sdev->pchans + 0?

Could this incorrectly complete the active transfer for channel 0, causing
use-after-free issues and DMA state corruption? Should the assignment be
sdev->pchans + j + i * sdev->cfg->num_channels_per_reg?


[Severity: High]
This is a pre-existing issue, but does sun6i_dma_interrupt() have a race
condition with channel teardown?

In the hardirq handler sun6i_dma_interrupt(), vchan->cyclic is checked
locklessly:

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
	...
	if (vchan->cyclic) {
		vchan_cyclic_callback(&pchan->desc->vd);
	}
	...
}

Concurrently, sun6i_dma_terminate_all() can run on another CPU, acquire
vchan->vc.lock, set vchan->cyclic =3D false, set pchan->desc =3D NULL, and =
free
the descriptors:

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
	...
	vchan->cyclic =3D false;
	...
}

If the IRQ handler checks vchan->cyclic just before it is modified, could it
proceed to dereference pchan->desc after it has been nulled or freed?


[Severity: High]
This is a pre-existing issue, but do sun6i_dma_terminate_all(),
sun6i_dma_pause(), and sun6i_dma_resume() have a deadlock window?

These functions acquire sdev->lock using a plain spin_lock() from process
context:

drivers/dma/sun6i-dma.c:sun6i_dma_terminate_all() {
	...
	spin_lock(&sdev->lock);
	...
}

However, sdev->lock is also acquired by sun6i_dma_tasklet(), which runs in
softirq context.

If a hard interrupt occurs on the same CPU while this lock is held, and the
interrupt handler returns and processes pending softirqs (including the
scheduled sun6i_dma_tasklet()), won't the tasklet attempt to acquire
sdev->lock using spin_lock_irq(), resulting in a same-CPU ABBA deadlock?

Should process context use spin_lock_bh() or spin_lock_irqsave() when locki=
ng
resources shared with softirqs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-sun60i-a73=
3-dma-v1-0-da4b649fc72a@gmail.com?part=3D1

