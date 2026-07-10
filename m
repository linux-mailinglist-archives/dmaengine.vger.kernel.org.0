Return-Path: <dmaengine+bounces-12268-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aMV8O+eKUGpI1AIAu9opvQ
	(envelope-from <dmaengine+bounces-12268-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:02:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6F7377CB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:02:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gwW2LCD2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12268-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12268-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 575BE300ADA0
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 06:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256533955D2;
	Fri, 10 Jul 2026 06:02:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA52157487;
	Fri, 10 Jul 2026 06:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663330; cv=none; b=hE/LtCkKQFNSDcj9aWf4S0fE73HVuPWn3I4xU2Mpwh2LrVTR53jkohbIGjo7k4a4OT7atMOifErIVh7NY0hc6oFfI3OOeMzr480THLE/Zz0ME5gGov9I3kwtFPlLV4SOQIdNgyHGcRtHiaEwscRk9c7woANO+TD0gwzowDSEo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663330; c=relaxed/simple;
	bh=CPc0OmNLnBPIoGSrOd4ZGthnyLXyTsCPjh70df9LyJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuoaTrKxDjy2sz/+sOEag3u4MoPFiygB4IOXvQhgoHolzpRyv3sp9Ax40MpvNMmwK8jbfuOBZE4f9Bx/TtWeGNnLZlkCX1o9cGcghQjLh7yt81NCQ10IF7YYit7eqrVkzeM1BiUSnV4/Qzyo9AdPn7GfF6T6Q3scOa8RNlc8gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwW2LCD2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94341F000E9;
	Fri, 10 Jul 2026 06:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663328;
	bh=ar0yGh+cIGAItWENq97rezTQTEq+OHxfFEYHf0XTmbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwW2LCD2guWUTPkDKuwnPHj3TaLiN8vnSvN/1+7VtkVjaB7SW4sxfp6ovmUPxpUdK
	 tPs3f7Y+leQqddvCOJRqnwV6a5E4PbifVjFY8FY/a8H5dfAQeABZbNSPbBvzoRVe4U
	 UUeNyLS4kNQIoVDGdaWVAF3DYBD0cy4U+dEMbZQZwg/2oankyA8BgmEox6BdsuIBxY
	 aEoZoq2GoLDdKr2FZ7StkR9nAAGKDkCh4z33c4fuXqikEA9vUx0PV+kDq5APtymRHR
	 RdqjBa03cGJE6Y9vmQLkb4EXDwKttijI1+d+m2d+8iqizIjtFTrCQWJ3sg+XEbYnHZ
	 4jQG481cIryZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] dmaengine: amlogic: Add general DMA driver for
 A9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao" <xianwei.zhao@amlogic.com>
Cc: Frank.Li@kernel.org, neil.armstrong@linaro.org, conor+dt@kernel.org, robh@kernel.org, vkoul@kernel.org, linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260710-amlogic-dma-v10-2-ff4deae837e7@amlogic.com>
References: <20260710-amlogic-dma-v10-0-ff4deae837e7@amlogic.com>
 <20260710-amlogic-dma-v10-2-ff4deae837e7@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 06:02:07 +0000
Message-Id: <20260710060207.E94341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12268-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xianwei.zhao@amlogic.com,m:Frank.Li@kernel.org,m:neil.armstrong@linaro.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,amlogic.com:email,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFC6F7377CB

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Scheduled descriptor free works are never flushed, leading to a us=
e-after-free on module unload.
- [High] Missing IRQ synchronization before killing tasklets in remove() le=
ads to use-after-free.
- [High] Failure to check the return value of platform_get_irq() breaks def=
erred probing.
- [High] `SG_MAX_LEN` is defined as an unaligned maximum value, causing una=
ligned physical address boundaries for subsequent DMA segments.
- [High] Missing 64-bit DMA Mask Configuration forces SWIOTLB bounce buffer=
ing on ARM64.
- [High] Resuming a paused DMA channel fails to restart pending transfers, =
leaving the channel permanently stalled.
- [High] Missing src_addr_widths configuration breaks DEV_TO_MEM clients.
- [Medium] Lockless status check leads to spurious errors and incorrect DMA=
_IN_PROGRESS returns.
- [Medium] aml_dma_tx_status() fails to report the DMA_PAUSED state.
--

--- Patch [2]: [PATCH v10 2/3] dmaengine: amlogic: Add general DMA driver f=
or A9 ---
commit 99b90ddfd63851fd9f1a5c3ca30d4210c8de8c83
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: dmaengine: amlogic: Add general DMA driver for A9

This patch introduces a general-purpose DMA controller driver for Amlogic
A9 SoCs. It includes support for virtual channels, SG list scatter/gather
capabilities, and basic transfer modes like Mem-to-Dev and Dev-to-Mem.

> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 0000000000000..388b5a581ae58
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c

[ ... ]

> +#define MAX_CHAN_ID		32
> +#define SG_MAX_LEN		GENMASK(26, 0)

[Severity: High]
Does this define the segment boundary as an unaligned odd length?

Since GENMASK(26, 0) equates to 134,217,727 bytes, which is an odd number,
using it to split segments will corrupt the alignment of all subsequent
physical addresses in the chain.

Could this cause hardware alignment faults on the AXI bus for clients
submitting large buffers?

[ ... ]

> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	struct aml_dma_desc *aml_desc =3D NULL;
> +	struct virt_dma_desc *vd;
> +	u32 residue =3D 0, done;
> +	unsigned long flags;
> +	enum dma_status ret;
> +
> +	ret =3D dma_cookie_status(chan, cookie, txstate);
> +	if (ret =3D=3D DMA_COMPLETE || !txstate)
> +		return ret;

[Severity: Medium]
Should this function intercept the status to report DMA_PAUSED?

The core dma_cookie_status() will return DMA_IN_PROGRESS for pending
transfers. Because this unconditionally returns that value, it fails to
substitute the driver's internal DMA_PAUSED state when the channel is
paused.

This prevents clients from detecting that a channel has successfully paused.

> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	vd =3D vchan_find_desc(&aml_chan->vchan, cookie);
> +	if (vd) {
> +		aml_desc =3D to_aml_dma_desc(vd);
> +		residue =3D aml_desc->data_len;
> +	} else if (aml_chan->cur_desc && aml_chan->cur_desc->vd.tx.cookie =3D=
=3D cookie) {
> +		aml_desc =3D aml_chan->cur_desc;
> +		regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
> +		residue =3D aml_desc->data_len - done;
> +	} else {
> +		dev_err(aml_dma->dma_device.dev, "cookie error\n");
> +	}

[Severity: Medium]
Can this lockless status check lead to spurious cookie errors?

Since dma_cookie_status() is called before acquiring the lock, the transfer
could complete immediately after the check. By the time the lock is
acquired, vchan_find_desc() will fail to find the descriptor, falling
through to the else branch.

This would print a spurious "cookie error" and return a stale
DMA_IN_PROGRESS status with a zero residue. Would re-evaluating the cookie
status inside the lock prevent this race?

[ ... ]

> +	sg_link =3D aml_desc->sg_link;
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		avail =3D sg_dma_len(sg);
> +		if (avail =3D=3D 0)
> +			continue;
> +		paddr =3D sg->dma_address;
> +		while (avail > SG_MAX_LEN) {
> +			/* set dma address and len to sglink*/
> +			sg_link->addr_low =3D lower_32_bits(paddr);
> +			sg_link->addr_high =3D upper_32_bits(paddr);
> +			sg_link->ctl =3D FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> +			paddr =3D paddr + SG_MAX_LEN;
> +			avail =3D avail - SG_MAX_LEN;
> +			sg_link++;
> +		}

[Severity: High]
Will this split corrupt the physical address alignment?

Because SG_MAX_LEN is an odd number, adding it to paddr guarantees that the
subsequent segment will start at an unaligned physical address. Could this
cause hardware faults during transfers?

[ ... ]

> +static int aml_dma_chan_resume(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PA=
USE);
> +	aml_chan->status =3D aml_chan->pre_status;
> +	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
> +
> +	return 0;
> +}

[Severity: High]
Does this function need to inspect the desc_issued list or call
aml_dma_start() after clearing the pause state?

If a client queues a new transfer and calls issue_pending() while the
channel is paused, aml_dma_start() returns early. The transfer stays in
desc_issued.

Without a call to aml_dma_start() during resume, the queued descriptors
remain trapped indefinitely and the channel stalls.

[ ... ]

> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;

[ ... ]

> +	aml_dma->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(aml_dma->clk))
> +		return PTR_ERR(aml_dma->clk);
> +
> +	aml_dma->irq =3D platform_get_irq(pdev, 0);
> +
> +	aml_dma->pdev =3D pdev;
> +	aml_dma->dma_device.dev =3D &pdev->dev;

[Severity: High]
Can this break deferred probing if platform_get_irq() fails?

If platform_get_irq() returns -EPROBE_DEFER, storing it directly without
checking for negative errors means it will later be passed to
devm_request_irq().

The request will treat it as a massive invalid IRQ number and reject it
with -EINVAL, permanently failing the probe.

[Severity: High]
Does the DMA device initialization here miss declaring 64-bit addressing
capabilities to the core framework?

The hardware naturally supports 64-bit physical addresses, but since
dma_set_mask_and_coherent() is never called to set a 64-bit mask, the
framework will fall back to a 32-bit mask.

Will this force any memory mapped above 4GB to use SWIOTLB bounce buffers
on ARM64 systems?

[ ... ]

> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources =3D aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources =3D aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status =3D aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg =3D aml_dma_prep_slave_sg;
> +	dma_dev->device_pause =3D aml_dma_chan_pause;
> +	dma_dev->device_resume =3D aml_dma_chan_resume;
> +	dma_dev->device_terminate_all =3D aml_dma_terminate_all;
> +	dma_dev->device_issue_pending =3D aml_dma_issue_pending;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_=
SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;

[Severity: High]
Does missing src_addr_widths configuration break DEV_TO_MEM clients?

The driver advertises DMA_DEV_TO_MEM support, but only populates
dst_addr_widths.

When generic DMA clients (like ALSA/ASoC) attempt to configure the channel
for capture (Rx), the capability check will fail because src_addr_widths
is 0, causing the framework to reject the channel.

[ ... ]

> +static void aml_dma_remove(struct platform_device *pdev)
> +{
> +	struct aml_dma_dev *aml_dma =3D platform_get_drvdata(pdev);
> +	struct aml_dma_chan *aml_chan =3D NULL;
> +	int i;
> +
> +	of_dma_controller_free((&pdev->dev)->of_node);
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);

[Severity: High]
Could unloading this module lead to a use-after-free from un-flushed work?

The aml_dma_free_desc() function schedules free_work on the global system
workqueue. If a DMA channel is freed just before or during module unload,
the scheduled work is not flushed or waited upon before devres drops the
backing memory.

The asynchronous work will execute after aml_dma is freed, dereferencing a
dangling pointer.

> +
> +	for (i =3D 0; i < MAX_CHAN_ID; i++) {
> +		aml_chan =3D aml_dma->aml_rch[i];
> +		if (aml_chan)
> +			tasklet_kill(&aml_chan->vchan.task);
> +		aml_chan =3D aml_dma->aml_wch[i];
> +		if (aml_chan)
> +			tasklet_kill(&aml_chan->vchan.task);
> +	}
> +}

[Severity: High]
Does killing tasklets here without IRQ synchronization expose a race window?

Because devm_request_irq() is used, the interrupt is freed by devres after
remove() completes. If an interrupt handler is actively executing on another
CPU, it can call tasklet_schedule() immediately after tasklet_kill()
finishes.

Devres then frees the structures, and the newly scheduled tasklet will later
execute on freed memory in the softirq context. Would calling
synchronize_irq() before killing tasklets prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-amlogic-dm=
a-v10-0-ff4deae837e7@amlogic.com?part=3D2

