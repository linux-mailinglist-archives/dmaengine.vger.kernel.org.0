Return-Path: <dmaengine+bounces-12472-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O+7YKKvyVWq5wgAAu9opvQ
	(envelope-from <dmaengine+bounces-12472-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:26:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4217525EE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="IaJwc/2e";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12472-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12472-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02875309E3C1
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE433FAE0C;
	Tue, 14 Jul 2026 08:22:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99713FBED8;
	Tue, 14 Jul 2026 08:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017348; cv=none; b=D8J3vRglrQ2LDhkr1isZlevJryQfscy78RFgZXx5pTrGCdt6l4IMjhVCm9xqJbWtje9gPsj/t12EXsvLiQLYk9l1JfyBQHjvq7e9oAZR5WIG3qFcqWq1DfAHrWuPzKIFNTfEXNLZDH4iyyr2s8a3bLEEXkXyZMRAtZp18mOweLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017348; c=relaxed/simple;
	bh=2wmllSFtRM04qkBx6rOyomFUoGUsSeG5w4KKjMQgOus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m0NeUz1ezgWfwXn6SYXnX80d0Q0iT9kAHKlvNY6XUi3CYHHQcCxtedRM6jZ8j3WYskfTB0cjzWZAz8lVw/cqXgg7xDI5iPTGJ9qi3B1tSaCJFaKRhevnNXMGP8bzi2xBjC1WsqDFXZntcTDp0k6dFy9YU5lD1Fc7PTkStC04jK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaJwc/2e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F34A1F000E9;
	Tue, 14 Jul 2026 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784017336;
	bh=ZgCfN1XdYNEEHbdhzLqMbv1I7M4zFQsvLNwz9yYNGV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IaJwc/2ec84qLtUX4arFfxSKhYY5gWM3olvcuIYy/3/J8ck3H5/ugafBDRIStsr7j
	 ewN2X0MoB1DlzCx5pqBwBR634gBWvlkwqTBxp2jl0Ka/8NXVAi2++GdQ/0WlrMZp9F
	 zrn4gtuxYxORYuh/hN8L2wQ7+AmZ7i2SeTFokCMjksTSv7fy1nYlUhXfPk77rdOjXC
	 hYGZ8De+Ef11i9m4tzyjNkLJW0+5i72CwjUP6FbMJvLx9gCslYvg5lRka1q48zdIjX
	 8HWBvR6cX/9LGbD/1QfeQ+szNY5qf/fupoH7g+0It4kxAs6lv0EeFqibPMfUltnn8a
	 YEajG60lit0Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] dmaengine: amlogic: Add general DMA driver for
 A9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao" <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260714-amlogic-dma-v11-2-de79c2394282@amlogic.com>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
 <20260714-amlogic-dma-v11-2-de79c2394282@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 08:22:15 +0000
Message-Id: <20260714082216.6F34A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12472-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xianwei.zhao@amlogic.com,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:neil.armstrong@linaro.org,m:linux-amlogic@lists.infradead.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED4217525EE

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] aml_dma_tx_status falsely reports in-flight transfers as DMA_COMPL=
ETE, causing data corruption.
- [High] Data race and TOCTOU NULL pointer dereference in aml_dma_tx_status=
 due to early lock release.
- [High] Use-After-Free in devres-managed remove path due to tasklet schedu=
led after tasklet_kill.
- [High] Pending free_work items on the global workqueue cause a kernel pan=
ic on module unload.
- [High] aml_dma_terminate_all() masks interrupts but does not clear pendin=
g interrupt status, potentially corrupting subsequent transfers.
- [Medium] Missing src_addr_widths configuration prevents DMA_DEV_TO_MEM cl=
ients from validating capabilities.
- [Medium] DMA descriptors use host-endian fields, breaking hardware functi=
onality on big-endian platforms.
--

--- Patch [2]: [PATCH v11 2/3] dmaengine: amlogic: Add general DMA driver f=
or A9 ---
commit 91d4c9c09e9b3baa0931dae1e37c022fae2b7447
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>

dmaengine: amlogic: Add general DMA driver for A9

This patch introduces a new DMA engine driver for Amlogic A9 SoCs. The
general-purpose DMA controller is used by multiple peripherals such as I2C,
PIO, and I3C.

> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 0000000000000..9de650a79abac
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c

[ ... ]

> +struct aml_dma_sg_link {
> +#define LINK_LEN		GENMASK(26, 0)
> +#define LINK_IRQ		BIT(27)
> +#define LINK_EOC		BIT(28)
> +#define LINK_LOOP		BIT(29)
> +#define LINK_ERR		BIT(30)
> +#define LINK_OWNER		BIT(31)
> +	u32 ctl;
> +	u32 addr_low;
> +	u32 addr_high;
> +	u32 revered;
> +} __packed;

[Severity: Medium]
Since this structure describes a hardware memory descriptor, should these
fields use __le32 instead of u32 to ensure the driver functions correctly on
big-endian architectures?

[ ... ]

> +static void aml_dma_free_desc(struct virt_dma_desc *vd)
> +{
> +	struct aml_dma_desc *aml_desc =3D to_aml_dma_desc(vd);
> +
> +	schedule_work(&aml_desc->free_work);
> +}

[Severity: High]
Does scheduling memory cleanup on the system workqueue here introduce a pan=
ic
on module unload?

If the driver module is unloaded while a work item is still pending, the
module's text segment will be unmapped. When the workqueue executes
aml_dma_free_desc_work(), it might jump to unmapped memory because
aml_dma_remove() does not appear to flush this work.

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
> +	if (ret =3D=3D DMA_COMPLETE)
> +		return ret;
> +
> +	ret =3D aml_chan->status;

[Severity: High]
Could this overwrite the correct DMA_IN_PROGRESS return value from
dma_cookie_status() with aml_chan->status?

If aml_chan->status is usually set to DMA_COMPLETE during initialization,
polling clients might mistakenly believe the transfer is finished before it
actually is, leading to data corruption.

> +	if (!txstate)
> +		return ret;
> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	vd =3D vchan_find_desc(&aml_chan->vchan, cookie);
> +	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
> +	if (vd) {
> +		aml_desc =3D to_aml_dma_desc(vd);
> +		residue =3D aml_desc->data_len;
> +	} else if (aml_chan->cur_desc && aml_chan->cur_desc->vd.tx.cookie =3D=
=3D cookie) {

[Severity: High]
Can releasing the lock before accessing aml_chan->cur_desc lead to a
NULL pointer dereference?

If a hardware interrupt completes the transfer concurrently, it sets cur_de=
sc
to NULL. A thread executing this code could check aml_chan->cur_desc (findi=
ng
it non-NULL), but if the interrupt handler clears the pointer right after,
the subsequent aml_chan->cur_desc->vd.tx.cookie access would dereference NU=
LL.

Alternatively, aml_desc could be assigned NULL, causing a dereference when
calculating the residue.

> +		aml_desc =3D aml_chan->cur_desc;
> +		regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
> +		residue =3D aml_desc->data_len - done;
> +	} else {
> +		dev_err(aml_dma->dma_device.dev, "cookie error\n");
> +	}
> +	dma_set_residue(txstate, residue);
> +
> +	return ret;
> +}

[ ... ]

> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{

[ ... ]

> +		while (avail > SG_MAX_LEN) {
> +			/* set dma address and len to sglink*/
> +			sg_link->addr_low =3D lower_32_bits(paddr);
> +			sg_link->addr_high =3D upper_32_bits(paddr);
> +			sg_link->ctl =3D FIELD_PREP(LINK_LEN, SG_MAX_LEN);

[Severity: Medium]
Should these assignments use cpu_to_le32() to ensure proper conversion of
host-endian values before writing to coherent DMA memory? Without it, this
could break hardware functionality on big-endian platforms.

[ ... ]

> +static int aml_dma_terminate_all(struct dma_chan *chan)
> +{

[ ... ]

> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUS=
E);
> +	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEA=
R);
> +
> +	if (aml_chan->direction =3D=3D DMA_MEM_TO_DEV)
> +		regmap_set_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id));
> +	else if (aml_chan->direction =3D=3D DMA_DEV_TO_MEM)
> +		regmap_set_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id));

[Severity: High]
Does masking the interrupts here without also clearing the pending interrupt
status (via CLEAR_RCH or CLEAR_WCH) risk corrupting subsequent transfers?

If an interrupt is already pending, its status bit remains set. When
aml_dma_start() is called later and unmasks the interrupt, it will fire
immediately and falsely complete the new transfer.

[ ... ]

> +static int aml_dma_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	dma_dev->device_issue_pending =3D aml_dma_issue_pending;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_=
SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);

[Severity: Medium]
Since this driver advertises DMA_DEV_TO_MEM support, is there a missing
configuration for src_addr_widths?

If omitted, client drivers validating source widths using
dma_get_slave_caps() will see a width of 0 and might fail initialization.

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
Can a use-after-free occur during driver unbind if an interrupt fires
concurrently?

Since the devres-managed IRQ is not freed or synchronized before calling
tasklet_kill(), an active interrupt handler on another CPU could schedule t=
he
tasklet again right after tasklet_kill() returns. Once the remove function
finishes, devres frees the channel memory containing the tasklet, leading to
execution on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-amlogic-dm=
a-v11-0-de79c2394282@amlogic.com?part=3D2

