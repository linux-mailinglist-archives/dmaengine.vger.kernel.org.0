Return-Path: <dmaengine+bounces-10635-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJw5BwDODmqdCQYAu9opvQ
	(envelope-from <dmaengine+bounces-10635-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 11:18:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C65A226B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1E8E318CF21
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243C30F548;
	Thu, 21 May 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGNOsEBv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4F33D6C1;
	Thu, 21 May 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354007; cv=none; b=oYhLZR0vwu5X17SFgh90CEXxXWSMYI4MFe66pZLXkXEow1JT47dU2C62Ypd5jGasSJz+OxJ9LxyscfgNOI9znmx2R0cAIowN/0JgwHvCCoxDCwj8FOhuZ2LFtLmOs9U1OZx74KRE+67FlwhX2tfvkEeEiXQ9ycFPwoXnpNzyYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354007; c=relaxed/simple;
	bh=xh4cd1sNKeB2Ag/TDFawofC9ZteBgtcaw9alS/08mnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaohKFa9DIANmJKq48an1/k5AsU/KugtKw4DGpigMZsH7Igcwy8UirlKTdTQ0K/j3I5Zl/tir/gCQvvENiq9p+qBJgeGeKQvwNFe2oEo4pwVga2v0C7+CRoe5Y0hKd7e2i8p+A7reDqQN+eBZx93zrwiWaKEQmpwc8WvsVEB9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGNOsEBv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377841F000E9;
	Thu, 21 May 2026 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779354005;
	bh=YuNOutbIKFNcGBRG6RS+kt+hqAaWYY7b+WS4E/mXI6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGNOsEBvhZDxBwjHpEzxrOBxoXOnDdu8GfMx9afkSSEFCcF+tK/oMFk4JzIgKyWga
	 V9UUEJcQema6G48IDTWy0xojxdcMKJsRkBTNDEFj4xiW/IaQDjlePP7pG8ayMxiIPr
	 Rf5Mb29IDFvl70MS/oj3fk7NyfHApo2Mi0tP6w0Cf7pAuavSGj+zdYB04446rFVV7g
	 AeydRSRuZLm5i03lAQvb9zdNA9p78YD5LaWEUobKVyeFd5nefsohJlg8uuNpwIN1MX
	 8/Gh++z1W7TtFNsucDsdLUAdEXYtAR2FmLOStG3WPzh/IH5RU41fIlPaJx9cmN5vg4
	 Nw6pYVZslGXnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] dmaengine: amlogic: Add general DMA driver for
 A9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xianwei Zhao via B4 Relay" <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: robh@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260521-amlogic-dma-v8-2-86cc2ce94142@amlogic.com>
References: <20260521-amlogic-dma-v8-2-86cc2ce94142@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 09:00:04 +0000
Message-Id: <20260521090005.377841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10635-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 849C65A226B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 17 potential issue=
(s) to consider:
- [Critical] The naive ring buffer allocator overflows on large scatterlist=
s and silently overwrites active in-flight DMA descriptors.
- [High] The DMA engine device is unregistered twice on driver removal and =
probe error paths.
- [High] The DMA controller is exposed to clients before hardware and inter=
rupts are fully initialized.
- [High] Integer truncation in the calculation of the allocation length for=
 `aml_dma_dev` leads to a heap buffer overflow.
- [High] The driver allocates memory with `GFP_KERNEL` inside a DMA prepara=
tion callback, which can sleep in atomic context.
- [High] The driver unconditionally dereferences `cur_desc` in the interrup=
t handler and `terminate_all`, leading to a kernel panic if the channel is =
idle.
- [High] A single DMA transfer error permanently deadlocks the channel.
- [High] Calling `aml_dma_prep_slave_sg` with an empty scatterlist results =
in a buffer underflow write.
- [High] Mismatch between allocated links and written links for zero-length=
 scatterlist elements.
- [High] Missing `tasklet_kill()` during driver removal leads to Use-After-=
Free.
- [High] For WCH (DEV_TO_MEM) channels, the hardware is never unpaused afte=
r `terminate_all()` or `pause()`.
- [High] The 64-bit physical address of the DMA descriptor list is truncate=
d to 32 bits, causing DMA faults.
- [Medium] Incorrect and non-compliant descriptor residue calculation in `a=
ml_dma_tx_status`.
- [Medium] Signed integer overflow due to 32-bit shift in the interrupt han=
dler.
- [Medium] Concurrent modification of `aml_chan->status` without locking ca=
uses state corruption.
- [Medium] The shared interrupt handler unconditionally returns `IRQ_HANDLE=
D` even when it processes no events.
- [Medium] Hardware descriptor fields use native endianness and unaligned 6=
4-bit access.
--

commit 6328a62df7a031573dae5a113f1f4a5b08fd7d50
Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: dmaengine: amlogic: Add general DMA driver for A9

This patch adds a new DMA engine driver for the Amlogic A9 general-purpose
DMA controller. It handles transfer operations using the virt-dma framework
and registers the controller using the dmaengine API.

> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 0000000000000..7dae5ba15c7e7
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c
> @@ -0,0 +1,682 @@
[ ... ]
> +struct aml_dma_sg_link {
> +#define LINK_LEN		GENMASK(26, 0)
> +#define LINK_IRQ		BIT(27)
> +#define LINK_EOC		BIT(28)
> +#define LINK_LOOP		BIT(29)
> +#define LINK_ERR		BIT(30)
> +#define LINK_OWNER		BIT(31)
> +	u32 ctl;
> +	u64 address;
> +	u32 revered;
> +} __packed;

[Severity: Medium]
Will this __packed structure cause alignment faults on architectures sensit=
ive
to unaligned memory accesses? The 64-bit address field is forced to an
unaligned 4-byte offset. Are the native types (u32, u64) safe here, or could
they break DMA execution on big-endian kernels?

[ ... ]
> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
[ ... ]
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	vd =3D vchan_find_desc(&aml_chan->vchan, cookie);
> +	if (vd) {
> +		list_for_each_entry(vd, &aml_chan->vchan.desc_issued, node) {
> +			aml_desc =3D to_aml_dma_desc(vd);
> +			residue +=3D aml_desc->data_len;
> +			if (vd->tx.cookie =3D=3D cookie)
> +				break;
> +		}

[Severity: Medium]
Does this incorrectly accumulate the data_len of independent descriptors?
Furthermore, since list_for_each_entry() overwrites the loop cursor 'vd', c=
ould
this traverse the entire desc_issued list without breaking if the target
cookie resides in desc_submitted, thereby returning an incorrect total?

[ ... ]
> +static int find_dma_chan_link(struct aml_dma_chan *aml_chan, u32 num)
> +{
> +	int idx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
> +	if ((aml_chan->idx_next + num) >=3D DMA_MAX_LINK)
> +		idx =3D 0;
> +	else
> +		idx =3D aml_chan->idx_next;
> +	aml_chan->idx_next =3D idx + num;
> +	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
> +
> +	return idx;
> +}

[Severity: Critical]
Is it possible for 'num' to be larger than DMA_MAX_LINK (256)? If a scatter=
list
needs more than 256 links, could idx_next become out of bounds and cause the
descriptor preparation loop to write past the end of the sg_link array? Cou=
ld
this also silently overwrite active in-flight descriptors without checking =
if
they are currently being processed?

[ ... ]
> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
[ ... ]
> +	aml_desc =3D kzalloc(sizeof(*aml_desc), GFP_KERNEL);

[Severity: High]
Can this allocation sleep in atomic context? Dmaengine prep callbacks are
expected to be callable from atomic contexts (e.g. inside interrupt handler=
s or
while holding spinlocks). Should GFP_NOWAIT or GFP_ATOMIC be used instead?

> +	if (!aml_desc)
> +		return NULL;
> +	link_count =3D sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
> +	aml_desc->idx =3D find_dma_chan_link(aml_chan, link_count);
> +	sg_link =3D aml_chan->sg_link + aml_desc->idx;
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		avail =3D sg_dma_len(sg);
> +		paddr =3D sg->dma_address;
> +		while (avail > SG_MAX_LEN) {
> +			/* set dma address and len to sglink*/
> +			sg_link->address =3D paddr;
> +			sg_link->ctl =3D FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> +			paddr =3D paddr + SG_MAX_LEN;
> +			avail =3D avail - SG_MAX_LEN;
> +			sg_link++;
> +		}
> +		/* set dma address and len to sglink*/
> +		sg_link->address =3D paddr;
> +		sg_link->ctl =3D FIELD_PREP(LINK_LEN, avail);
> +
> +		aml_desc->data_len +=3D sg_dma_len(sg);
> +		sg_link++;
> +	}

[Severity: High]
If a scatterlist element has a length of 0, sg_nents_for_dma() will not all=
ocate
a link slot for it. Will this loop unconditionally increment sg_link++ for =
that
element anyway, causing the driver to consume more link slots than allocate=
d and
corrupt the ring buffer?

> +
> +	/* the last sg set eoc flag */
> +	sg_link--;
> +	sg_link->ctl |=3D LINK_EOC;

[Severity: High]
If aml_dma_prep_slave_sg() is called with sg_len =3D=3D 0, the for_each_sg =
loop
will not execute. Could this cause sg_link-- to point before the allocated
descriptor index, leading to an out-of-bounds underflow write?

[ ... ]
> +static int aml_dma_chan_pause(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan =3D to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma =3D aml_chan->aml_dma;
> +
> +	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUS=
E);
> +	aml_chan->pre_status =3D aml_chan->status;
> +	aml_chan->status =3D DMA_PAUSED;

[Severity: Medium]
Are these status updates subject to race conditions? aml_chan->status is
modified here without acquiring aml_chan->vchan.lock, while it is also modi=
fied
concurrently by the interrupt handler.

[ ... ]
> +static void aml_dma_start(struct aml_dma_chan *aml_chan)
> +{
[ ... ]
> +	if (aml_chan->direction =3D=3D DMA_MEM_TO_DEV) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> +			     (aml_chan->sg_link_phys + aml_desc->idx * DMA_LINK_SIZE));

[Severity: High]
Does passing a 64-bit dma_addr_t (sg_link_phys) to regmap_write() silently
truncate the upper 32 bits of the address? If memory is allocated above 4GB,
will this lead to incorrect memory accesses by the DMA controller?

> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_desc->=
data_len);
> +		regmap_clear_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id));
> +		/* for rch (tx) need set cfg 0 to trigger start */
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
> +	} else if (aml_chan->direction =3D=3D DMA_DEV_TO_MEM) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
> +			     (aml_chan->sg_link_phys + aml_desc->idx * DMA_LINK_SIZE));
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_desc->=
data_len);
> +		regmap_clear_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id));
> +	}

[Severity: High]
For WCH (DEV_TO_MEM) channels, aml_dma_start() neglects to write to WCH_CFG.
If aml_dma_terminate_all() or aml_dma_chan_pause() previously set the CFG_P=
AUSE
bit, will WCH channels remain indefinitely paused?

> +}
[ ... ]
> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
> +{
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
> +		aml_chan->status =3D (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;

[Severity: Medium]
Could this shift result in a signed integer overflow? If 'i' reaches 31
(since MAX_CHAN_ID is 32), shifting the signed 32-bit literal '1' causes
undefined behavior. Should this use 1U << i or BIT(i) instead?

[Severity: High]
If a hardware error occurs and aml_chan->status is set to DMA_ERROR, is the=
re
any mechanism to reset the status back to DMA_COMPLETE? Without a reset pat=
h,
will aml_dma_start() simply return immediately for all future transfers,
permanently deadlocking the channel?

> +		spin_lock(&aml_chan->vchan.lock);
> +		aml_desc =3D aml_chan->cur_desc;
> +		if (aml_chan->status =3D=3D DMA_ERROR) {
> +			aml_desc->vd.tx_result.result =3D DMA_TRANS_READ_FAILED;
> +			regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &cpl_da=
ta);
> +			aml_desc->vd.tx_result.residue =3D aml_desc->data_len - cpl_data;
> +		}

[Severity: High]
If a spurious interrupt fires, or if it fires concurrently with
aml_dma_terminate_all() (which sets cur_desc to NULL), will aml_desc be NULL
here? This appears to unconditionally dereference aml_desc, potentially cau=
sing
a NULL pointer dereference.

[ ... ]
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Because this driver requests a shared interrupt line (IRQF_SHARED), shouldn=
't
the handler return IRQ_NONE if it processed no events (e.g., done and end
were both 0)? Returning IRQ_HANDLED unconditionally could break shared inte=
rrupt
semantics and cause issues with the kernel's spurious interrupt detection.

[ ... ]
> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;
[ ... ]
> +	ret =3D of_property_read_u32(np, "dma-channels", &chan_nr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
> +
> +	len =3D sizeof(struct aml_dma_dev) + sizeof(struct aml_dma_chan) * chan=
_nr;
> +	aml_dma =3D devm_kzalloc(&pdev->dev, len, GFP_KERNEL);

[Severity: High]
Is the calculation of 'len' susceptible to an integer overflow? 'chan_nr' is
read directly from the device tree and isn't bounds-checked before being us=
ed
in the calculation of the signed integer 'len'. Could a large 'chan_nr' cau=
se
a heap buffer overflow later during initialization?

[ ... ]
> +	ret =3D dmaenginem_async_device_register(dma_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n=
");
> +
> +	ret =3D of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
> +	if (ret)
> +		goto err_dmaenginem_register;
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
> +
> +	ret =3D devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_ha=
ndler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), aml_dma);

[Severity: High]
Does exposing the DMA controller to clients before the interrupt is request=
ed
leave a window where a client could queue a transfer and the hardware could
generate an unhandled interrupt? Should the interrupt be initialized before
dmaenginem_async_device_register() and of_dma_controller_register() are cal=
led?

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request_irq\n");
> +		goto err_of_dma_controller;
> +	}
> +
> +	platform_set_drvdata(pdev, aml_dma);
> +
> +	return 0;
> +
> +err_of_dma_controller:
> +	of_dma_controller_free(np);
> +err_dmaenginem_register:
> +	dma_async_device_unregister(dma_dev);

[Severity: High]
Because dmaenginem_async_device_register() already registers a devres action
to unregister the device upon failure, does calling dma_async_device_unregi=
ster()
here manually result in a double-free or list corruption?

> +
> +	return ret;
> +}
> +
> +static void aml_dma_remove(struct platform_device *pdev)
> +{
> +	struct aml_dma_dev *aml_dma =3D platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free((&pdev->dev)->of_node);
> +	dma_async_device_unregister(&aml_dma->dma_device);

[Severity: High]
Similarly, does calling dma_async_device_unregister() here cause a double-f=
ree
since dmaenginem_async_device_register() was used?

[Severity: High]
Is a call to tasklet_kill() needed here during removal? Since the virt-dma
framework schedules tasklets for DMA completions, failing to kill them could
lead to a use-after-free if a tasklet executes after the driver has been un=
loaded.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-amlogic-dm=
a-v8-0-86cc2ce94142@amlogic.com?part=3D2

