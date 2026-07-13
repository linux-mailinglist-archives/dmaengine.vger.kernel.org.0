Return-Path: <dmaengine+bounces-12397-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CbjDLrHnVGqSgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12397-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:27:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C037374B8F7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:27:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aBzZCHi6;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12397-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12397-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA786306E179
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536B40BCD2;
	Mon, 13 Jul 2026 13:18:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E94229A5
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:18:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948733; cv=none; b=Kk0af3yOzEeszAukpmZkGHzwRFzEqavGUCN/FWge1rxMCiMVxs4CxW50OrFdRTIDxwouMmlrVjyS03ZiDFBhbLvCZjcZecH/T2GklS0gWANQh9qqxqhsLi3cqPHbneKcOlPqY9Fj6GyesrZBgx/3dXN41nGjR2giL3ITTWhJ8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948733; c=relaxed/simple;
	bh=oEd7hLvJwtZ2RITSvVcXivFaN3J49n8+I+LAkAux+rs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Opx515VrVBij81ySY5vNl+ErYENHbllBo8SbKR6/m7/UROQIUlA3cYOA8nt6MkQ08oJVnLk1FdLZeWVl1LIIntb6rCUQm4kgFvVan8Qn0IM5QcLNsFdsYXoOKb54tFS6iCrwQX68QVxhED7XXSMbu9Kq9djellblPtkcxbptRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBzZCHi6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1841F00A3A;
	Mon, 13 Jul 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948732;
	bh=3sf0fE1Q0vvvYfA24hD+Zcx/q7RD6KYZkrfAe+hjSjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBzZCHi6poCmqdu6LCq+ambvHtr63QFZwZN5dk7DTZAcMi32UUkqJWwwPqFvOo1if
	 Tg7PSoHU9rz5PHmzXVG9hke8f0QyygNMLEKkX+OXEdRa+xgrtoLQeJL5RF9jWfXbhi
	 JmrxkMovWmQPm0sBE/rlWbwk+kE5WTEHHgwn6s4kLrxwZwRvb5TkOJVEfGQX8pH8z7
	 7snWo9kUh3LP5DJRTxdT5yWyiXl4U6K6ryDYDWieKipw4bJMJW8nLFh6MuHytepamG
	 3IfbsKdaIxsPw0yR1QYLTPFKIV74V17SzA0SaA6ldlRJGyLTFwcpeHyKY/98fP4oee
	 O7J4jIfxzbZKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 08/14] crypto: qce - Include algapi.h in the core.h
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-8-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-8-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:18:51 +0000
Message-Id: <20260713131852.0D1841F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12397-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C037374B8F7

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] bam_make_lock_desc maps the command descriptor using the slave dev=
ice pointer instead of the DMA controller device, which will cause IOMMU fa=
ults or unresolvable physical addresses.
- [High] LIFO devres execution order in qce_crypto_probe causes the DMA cha=
nnels to be freed before the workqueue is cancelled, leading to use-after-f=
ree if the workqueue executes concurrently.
- [High] BAM pipe locking is restricted to TX channels (Memory-to-Device), =
which directly contradicts the commit message stating it applies to RX chan=
nels.

Pre-existing issues:
- [High] Writing to BAM registers after forcefully suspending the device ca=
uses an unclocked access crash.
--

--- Patch [8]: [PATCH v21 08/14] crypto: qce - Include algapi.h in the core=
.h header ---
commit 2564fb6b194c2eaa4eed81579eda988d138343a5
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Include algapi.h in the core.h header

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index ac74f69914d61..dd860435d2c47 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c

[ ... ]

> @@ -226,6 +232,11 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> +	INIT_WORK(&qce->done_work, qce_req_done_work);
> +	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);

[Severity: High]
Does registering the workqueue cancellation here cause a use-after-free
during device teardown?

Since devres actions are executed in reverse order (LIFO),
devm_qce_dma_request() registers qce_dma_release() which will run first
and release the DMA channels.

Only after that does qce_cancel_work() execute, meaning if
qce_req_done_work() runs concurrently during this window, it could
access the already freed DMA channels.

> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_qce_dma_request(qce->dev, &qce->dma);
>  	if (ret)
>  		return ret;

[ ... ]

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1bb26af0405f3..f08549ee3872e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c

[ ... ]

> @@ -1021,13 +1113,102 @@ static void bam_apply_new_config(struct bam_chan=
 *bchan,
>  	bchan->reconfigure =3D 0;
>  }
> =20
> +static struct bam_async_desc *
> +bam_make_lock_desc(struct bam_chan *bchan, unsigned long flag)
> +{
> +	struct dma_chan *chan =3D &bchan->vc.chan;
> +	struct bam_async_desc *async_desc;
> +	struct bam_desc_hw *desc;
> +	struct virt_dma_desc *vd;
> +	struct virt_dma_chan *vc;
> +	unsigned int mapped;
> +
> +	async_desc =3D kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
> +	if (!async_desc) {
> +		dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\=
n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	sg_init_table(&async_desc->lock_sg, 1);
> +
> +	async_desc->num_desc =3D 1;
> +	async_desc->curr_desc =3D async_desc->desc;
> +	async_desc->dir =3D DMA_MEM_TO_DEV;
> +	async_desc->is_lock_desc =3D true;
> +
> +	desc =3D async_desc->desc;
> +
> +	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRIT=
E_COMMAND, 0);
> +	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_des=
c->lock_ce));
> +
> +	mapped =3D dma_map_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVI=
CE);

[Severity: High]
Does mapping the command descriptor using chan->slave instead of the DMA
controller device cause IOMMU faults?

The memory is mapped into the peripheral's IOMMU domain rather than the
DMA controller's domain, which could lead to DMA faults when the controller
tries to read the descriptor.

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);
> +	desc->size =3D cpu_to_le16(sizeof(struct bam_cmd_element));

[ ... ]

> +static int bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	const struct bam_device_data *bdata =3D bchan->bdev->dev_data;
> +	struct bam_async_desc *lock_desc, *unlock_desc;
> +
> +	lockdep_assert_held(&bchan->vc.lock);
> +
> +	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
> +	    bchan->direction !=3D DMA_MEM_TO_DEV)

[Severity: High]
Does restricting this hardware locking workaround to DMA_MEM_TO_DEV (TX)
channels contradict the intent to apply it to RX channels?

The commit message states "when starting DMA on an RX channel - prepend
the existing queue...", but this check prevents the locking from applying
to DMA_DEV_TO_MEM (RX) channels.

> +		return 0;
> +
> +	/*
> +	 * Allocate both the LOCK and the UNLOCK descriptors up-front so the
> +	 * operation is all-or-nothing: if either allocation fails we free both

[ ... ]

> @@ -1401,6 +1603,8 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	struct bam_device *bdev =3D platform_get_drvdata(pdev);
>  	u32 i;
> =20
> +	free_irq(bdev->irq, bdev);
> +
>  	pm_runtime_force_suspend(&pdev->dev);
> =20
>  	of_dma_controller_free(pdev->dev.of_node);
> @@ -1409,8 +1613,6 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

[Severity: High]
This is a pre-existing issue, but does writing to BAM_IRQ_SRCS_MSK_EE after
pm_runtime_force_suspend() has disabled the clock cause a synchronous
external abort?

Since the clock is turned off by the suspend callback, this unclocked access
can trigger a fatal bus error.

> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> -
>  	for (i =3D 0; i < bdev->num_channels; i++) {
>  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
>  		tasklet_kill(&bdev->channels[i].vc.task);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D8

