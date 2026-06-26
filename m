Return-Path: <dmaengine+bounces-11800-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sMrtK+wTPmpk/ggAu9opvQ
	(envelope-from <dmaengine+bounces-11800-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:53:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C36CA844
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TyiGaBs4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11800-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11800-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FAF73012D89
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F33CB8EB;
	Fri, 26 Jun 2026 05:53:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C443CB2C5;
	Fri, 26 Jun 2026 05:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453208; cv=none; b=dNnBvH24evsxyYAH933Ce1CYzjYtVQRwCmKo4Fw9LRE3VX2nBfn1B8IbYe3wUBYMtZSEn5PxVC2lvaERoE+XTp+DVy0Qq9JQG6NvckQXp20pqhOlwnfzPS+f8PK3nnV1UTVXU6LoTDNXdyjK9h9AzUupeAbfQYWvvNnBMcNk9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453208; c=relaxed/simple;
	bh=NhemCubYxEjvyuouPmqh/bzuYezN/8oiregtKli2mHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rFpC+9p6Hgvo+LypLlZFK04+8n240yjVtfDv0dNiIO1j2LKmA3EyV0/eA62MLsKyvr5sDc7+oqleG2UJ8yNUs0j/pXoxPpuLnQbT1eDNwifwqy0Kp9Mm2i0QQwkY1xb+1g3oSF23hiP6EKtsvXNsZw66Pe7jY2GlsrldqDrf6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyiGaBs4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2721F000E9;
	Fri, 26 Jun 2026 05:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782453206;
	bh=+oS9klRNd/ef66+AiUymoOz3JyM27Nw+NUbN+vW4dBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyiGaBs4XMgDhpNZMWhTK2K+4dcFcMx09XAxuLUvz4UOiXhwlnkEiSwR2sJxUN54s
	 zl7SAVQNidXnsTkdI2QsnkQiRTKfl3Vvqz2Rrh8zJTGo4+59ANaCC15eg114wQwxIf
	 /Utbz7/agXz5ELn6bR/VKifKpCrnVMOA0FkgMp9m7a1FxeNCZKDn8LP6ISh5hESkJs
	 V1MoFU+RaHJQbRkgKZXBkh2MAjhWpQyBz7ZJnIvNJcxtAoFFvSinRD1ZcOXRJWrKtS
	 p5mbOwH5fBnXgkTltwkRQm/L7iPHGGN1wMk6vmTe3w6ZyQKExnrx5eVcz9wSXxRyvb
	 2lgY+KwiCWeVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] dmaengine: amlogic: Add general DMA driver for
 A9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao via B4 Relay" <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: dmaengine@vger.kernel.org, neil.armstrong@linaro.org, Frank.Li@kernel.org, vkoul@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260626-amlogic-dma-v9-2-558d672c4a95@amlogic.com>
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
 <20260626-amlogic-dma-v9-2-558d672c4a95@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:53:25 +0000
Message-Id: <20260626055325.ED2721F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11800-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+xianwei.zhao.amlogic.com@kernel.org,m:dmaengine@vger.kernel.org,m:neil.armstrong@linaro.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:linux-amlogic@lists.infradead.org,m:devnull@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,amlogic.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A99C36CA844

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Use-After-Free during driver removal due to missing IRQ synchroniz=
ation.
- [High] Sleeping in atomic context when freeing virtual DMA descriptors.
- [High] Out-of-bounds write in `aml_dma_prep_slave_sg` when processing zer=
o-length scatterlist elements.
- [High] Broken pause/resume state machine logic leading to channel stall a=
nd state corruption.
- [Medium] `aml_dma_terminate_all()` fails to reset channel error state, ca=
using permanent stall.
- [Medium] `aml_dma_tx_status()` improperly handles unissued descriptors, c=
ausing false errors and incorrect residues.
- [Medium] Mismatched DMA address registers used for 64-bit physical addres=
ses.
--

commit 7102a7639af273fc6303ccde475117debb548165
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>

dmaengine: amlogic: Add general DMA driver for A9

Amlogic A9 SoCs include a general-purpose DMA controller that can be used
by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
is associated with a dedicated DMA channel in hardware.

> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> index 0000000000000..bce6932f3a12e
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c

[ ... ]

> +static void aml_dma_free_desc(struct virt_dma_desc *vd)
> +{
> +	struct aml_dma_desc *aml_desc =3D to_aml_dma_desc(vd);
> +
> +	dma_free_coherent(aml_desc->dma_device->dev,
> +			  aml_desc->sg_link_size,
> +			  aml_desc->sg_link,
> +			  aml_desc->sg_link_phys);

[Severity: High]
Does this code sleep in atomic context?

When the virtual DMA descriptor is freed, vchan_dma_desc_free_list() calls
this callback from within vchan_complete(), which runs in tasklet
(softirq) context. Calling a sleepable function like dma_free_coherent()
from a tasklet can result in a scheduling while atomic panic.=20

Could this driver use dma_pool_alloc/free or kzalloc/kfree for descriptor
management instead?

> +	kfree(aml_desc);
> +}

[ ... ]

> +/* DMA transfer state  update how many data reside it */
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

[Severity: Medium]
Will this incorrectly handle unissued descriptors?

Looking at aml_dma_tx_status(), it attempts to locate a descriptor using
vchan_find_desc(), which exclusively searches the desc_issued list.

If a client queries the status of a descriptor that was submitted (residing
in desc_submitted) but not yet issued via issue_pending(), vchan_find_desc()
will return NULL.=20

This causes the driver to log a spurious "cookie error" and return a residue
of 0, which might incorrectly imply the pending transfer is complete.

> +	}
> +	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);

[ ... ]

> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	struct aml_dma_desc *aml_desc =3D NULL;
> +	struct aml_dma_sg_link *sg_link =3D NULL;
> +	struct scatterlist *sg =3D NULL;
> +	u64 paddr;
> +	u32 link_count, avail;
> +	u32 i;

[ ... ]

> +	sg_link =3D aml_desc->sg_link;
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		avail =3D sg_dma_len(sg);
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
> +		/* set dma address and len to sglink*/
> +		sg_link->addr_low =3D lower_32_bits(paddr);
> +		sg_link->addr_high =3D upper_32_bits(paddr);
> +		sg_link->ctl =3D FIELD_PREP(LINK_LEN, avail);
> +
> +		aml_desc->data_len +=3D sg_dma_len(sg);
> +		sg_link++;

[Severity: High]
Can this write out of bounds for zero-length scatterlist elements?

Earlier in aml_dma_prep_slave_sg(), sg_nents_for_dma() calculates the
required number of link descriptors. For an SG element with length 0, it
computes DIV_ROUND_UP(0, SG_MAX_LEN), adding 0 to the link count.

However, this for_each_sg loop unconditionally consumes at least one link
slot per SG element, setting its properties and incrementing sg_link.

If a client provides an empty SG element, this mismatch might result in an
out-of-bounds write past the end of the dma_alloc_coherent array, leading
to memory corruption.

> +	}

[ ... ]

> +static int aml_dma_chan_pause(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUS=
E);
> +	aml_chan->pre_status =3D aml_chan->status;
> +	aml_chan->status =3D DMA_PAUSED;

[Severity: High]
Is the pause and resume state tracking prone to corruption?

If aml_dma_chan_pause() is called twice, it overwrites pre_status with
DMA_PAUSED, which might brick the channel upon resume.

Also, if a client submits a new transaction while paused,
aml_dma_chan_resume() restores DMA_COMPLETE but doesn't call
aml_dma_start(), which could permanently stall the channel.

> +	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
> +
> +	return 0;
> +}

[ ... ]

> +static int aml_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	int chan_id =3D aml_chan->chan_id;
> +	struct virt_dma_desc *cur_vd;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);

[Severity: Medium]
Will the channel stall permanently if terminated after errors?

When a channel hits 6 hardware errors, aml_dma_start() halts the channel
and abandons pending processing. To recover, a client driver typically calls
dmaengine_terminate_all().

However, aml_dma_terminate_all() doesn't reset aml_chan->status to
DMA_COMPLETE or aml_chan->err_num to 0. Any subsequent transactions
submitted to this channel might hang forever because aml_dma_start() will
immediately return due to the persistent error state.

> +	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUS=
E);

[ ... ]

> +static void aml_dma_start(struct aml_dma_chan *aml_chan)
> +{
> +	struct virt_dma_desc *vd =3D vchan_next_desc(&aml_chan->vchan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +	struct aml_dma_desc *aml_desc =3D NULL;
> +	int chan_id =3D aml_chan->chan_id;

[ ... ]

> +	if (aml_chan->direction =3D=3D DMA_MEM_TO_DEV) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> +			     lower_32_bits(aml_desc->sg_link_phys));
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR_HIGH,
> +			     upper_32_bits(aml_desc->sg_link_phys));

[Severity: Medium]
Are the correct DMA address registers being used for 64-bit addresses?

The hardware registers define RCH_ADDR (0xc), RCH_ADDR_LOW (0x20), and
RCH_ADDR_HIGH (0x24).

In aml_dma_start(), the lower 32 bits of the physical address are programmed
into the legacy 32-bit RCH_ADDR (0xc) rather than RCH_ADDR_LOW (0x20), while
writing the upper 32 bits to RCH_ADDR_HIGH (0x24).

If the hardware expects the lower bits of a 64-bit address at 0x20, this
might result in an invalid address and immediate DMA failures.

> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_desc->=
data_len);

[ ... ]

> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct aml_dma_dev *aml_dma =3D dev_id;
> +	struct aml_dma_chan *aml_chan;
> +	struct aml_dma_desc *aml_desc;
> +	u32 done, eoc_done, err, err_l, end;
> +	u32 cpl_data;
> +	int i =3D 0;

[ ... ]

> +	while (done) {
> +		i =3D ffs(done) - 1;
> +		regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(i));
> +		done &=3D ~BIT(i);
> +		aml_chan =3D aml_dma->aml_rch[i];
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
> +			continue;
> +		}
> +		spin_lock(&aml_chan->vchan.lock);
> +		aml_chan->status =3D (err & BIT(i)) ? DMA_ERROR : DMA_COMPLETE;

[Severity: High]
Can an interrupt overwrite the paused state?

If an interrupt fires while the channel is paused, this handler uncondition=
ally
overwrites status to DMA_COMPLETE and calls aml_dma_start(). Could this unp=
ause
the hardware and break the pause semantics?

> +		aml_desc =3D aml_chan->cur_desc;

[ ... ]

> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;

[ ... ]

> +	ret =3D devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_ha=
ndler,
> +			       0, dev_name(&pdev->dev), aml_dma);

[Severity: High]
Can this cause a use-after-free during driver removal?

Since devm_request_irq() is used in aml_dma_probe(), the IRQ remains active
until after aml_dma_remove() completes.=20

In aml_dma_remove(), the driver loops and calls tasklet_kill(&aml_chan->vch=
an.task):

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
> +
> +	for (i =3D 0; i < MAX_CHAN_ID; i++) {
> +		aml_chan =3D aml_dma->aml_rch[i];
> +		if (aml_chan)
> +			tasklet_kill(&aml_chan->vchan.task);

But an executing interrupt handler on another CPU can subsequently call
vchan_cookie_complete() and reschedule the tasklet.=20

Once remove() returns, devres unregisters the DMA engine, frees the IRQ, and
frees the driver struct via devm_kfree. The tasklet will then run and access
freed memory, causing a use-after-free panic.=20

Should the driver explicitly free or disable the IRQ using devm_free_irq()
before calling tasklet_kill()?

> +		aml_chan =3D aml_dma->aml_wch[i];
> +		if (aml_chan)
> +			tasklet_kill(&aml_chan->vchan.task);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-amlogic-dm=
a-v9-0-558d672c4a95@amlogic.com?part=3D2

