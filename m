Return-Path: <dmaengine+bounces-10754-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHInN/51EGoZXgYAu9opvQ
	(envelope-from <dmaengine+bounces-10754-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:27:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E45B6E0D
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 475DA303C035
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69104219EF;
	Fri, 22 May 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFhR0pkc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6451E49F
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463510; cv=none; b=S+M2lmviePGjuLe1Cx904UjpECBNgFudloGpSlK69lmQ4xXxxpSsbLP2FYs9UoYNJiVo0wTsI5ZFLsUMQH8HZU2V30GCAyBVxFB5wVwwAYV0G6c6o0NiVO7D4h30pHkEeZa0q7XmOB4ejT6I3PvKRBzpkcVvKKqp4ssUssLYGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463510; c=relaxed/simple;
	bh=HEsP6a3UH4UMcy5r2HkyNp/8wps6PbR9AiAwU1Otyys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kvRZ9KR63ONTpObGvNZfp9dEfyRdru64/UpJ5yxiuQ+1vuvZvrxiBzfOvJY4WDvJLjPxBSTLuSajOstpxM2s771n5P8ZTvc8YlEK1FddjdjfKiQKMjNAANndOQsqfmFhr3xJ2HoRqV0UqjadNICLQeCW02cKGS/zj+OzDItpMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFhR0pkc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A241F000E9;
	Fri, 22 May 2026 15:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463506;
	bh=nei5e9XJpTmeJv/UQRPckB844dDuj4sW3zi9Ygr1xUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFhR0pkcoR4VJunnRoeII9Tcn5qjKWjk4dNfh54zPo+0RWdMugiT3q2ep7qzbTXnq
	 tNacytX5qROyXF396cNRB1vuZJoCIQYgopA5d4yLR1rX2eMY4x/80tE/Le4XXS9zUh
	 yVYgDGXetE/C+kDwGjkMaqvqFkA6/efdsljfxdjyFn5pe3zinR+YtZ7BerDKM7kfmu
	 6/IomqUWyxQHnlxR+9HXt0uVLh6Jhe6d3Jf4WA4ydlzzOLYnQurQcaVOpWVo6xPnrH
	 oYZ5MkUhV8dvO1389xqzxIHpsmll+k1bnYAXZYf9n7N7v0k9I4VT8O/SCFDnf8wMOC
	 KZBmJRNPYuOwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-6-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-6-99103926bafc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:25:05 +0000
Message-Id: <20260522152506.63A241F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10754-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 431E45B6E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Assigning dmaengine cookies to internal dummy descriptors breaks t=
he monotonic sequence of completions, causing premature completion reportin=
g for client descriptors.
- [High] Unconditional addition of LOCK/UNLOCK descriptors in `bam_start_dm=
a()` causes duplicate lock injections and queue accumulation upon channel r=
esume.
- [High] Failure to allocate the UNLOCK descriptor leaves the hardware pipe=
line permanently locked.
- [High] The command element is DMA-mapped using the client peripheral devi=
ce instead of the DMA controller device.
- [High] Per-descriptor metadata updates globally shared channel state, cau=
sing a persistent state leak across transactions.
- [High] The DMA-mapped `lock_ce` buffer is not cacheline-aligned and share=
s a cacheline with CPU-modified fields.
- [High] Internal dummy descriptors are not assigned the `DMA_CTRL_ACK` fla=
g, leading to a permanent memory and DMA mapping leak.
- [Medium] The pipe locking logic checks the wrong transfer direction, comp=
letely disabling the feature for RX channels.
- [Medium] `bam_metadata_attach()` does not validate the `len` argument bef=
ore dereferencing the metadata payload.
- [Medium] Missing `cpu_to_le32()` conversion when assigning the DMA addres=
s to the hardware descriptor.
--

commit e7baf190c2e5ffe3e7505c85ae0eb210175ae10a
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: add support for BAM locking

Add support for BAM pipe locking. To that end: when starting DMA on an RX
channel - prepend the existing queue of issued descriptors with an
additional "dummy" command descriptor with the LOCK bit set. Once the
transaction is done (no more issued descriptors), issue one more dummy
descriptor with the UNLOCK bit.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 04fe1d546be73..40b5d5c24067a 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
[ ... ]
> @@ -72,6 +76,10 @@ struct bam_async_desc {
> =20
>  	struct bam_desc_hw *curr_desc;
> =20
> +	/* BAM locking infrastructure */
> +	struct scatterlist lock_sg;
> +	struct bam_cmd_element lock_ce;
> +
>  	/* list node for the desc in the bam_chan list of descriptors */
>  	struct list_head desc_node;

[Severity: High]
Does this struct layout cause cacheline tearing on non-coherent
architectures?

lock_ce is embedded directly inside the dynamically allocated
struct bam_async_desc without cacheline alignment, meaning it shares a
cacheline with CPU-modified fields like desc_node. Concurrently modifying
list pointers while the DMA API performs cache maintenance operations on the
same cacheline violates ARCH_DMA_MINALIGN rules and can corrupt data.

[ ... ]
> @@ -652,6 +664,35 @@ static int bam_slave_config(struct dma_chan *chan,
>  	return 0;
>  }
> =20
> +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, voi=
d *data, size_t len)
> +{
> +	struct bam_chan *bchan =3D to_bam_chan(desc->chan);
> +	const struct bam_device_data *bdata =3D bchan->bdev->dev_data;
> +	struct bam_desc_metadata *metadata =3D data;

[Severity: Medium]
Could this result in an out-of-bounds read if a caller provides a
truncated payload?

The data pointer is cast and used without verifying that len is at
least sizeof(struct bam_desc_metadata).

> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (!bdata->pipe_lock_supported)
> +		/*
> +		 * The client wants to use locking but this BAM version doesn't
> +		 * support it. Don't return an error here as this will stop the
> +		 * client from using DMA at all for no reason.
> +		 */
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&bchan->vc.lock);
> +
> +	bchan->scratchpad_addr =3D metadata->scratchpad_addr;

[Severity: High]
Does saving scratchpad_addr to the shared channel structure cause a state
leak across transactions?

This state is never cleared. If a client submits a transfer with metadata
and later submits transfers without metadata, the stale scratchpad_addr
remains in bchan, potentially causing dummy lock writes to freed or
reallocated physical addresses.

[ ... ]
> +static struct bam_async_desc *
> +bam_make_lock_desc(struct bam_chan *bchan, unsigned long flag)
> +{
> +	struct dma_chan *chan =3D &bchan->vc.chan;
> +	struct bam_async_desc *async_desc;
> +	struct bam_desc_hw *desc;
> +	struct virt_dma_desc *vd;
> +	struct virt_dma_chan *vc;
> +	unsigned int mapped;
> +	dma_cookie_t cookie;
> +	int ret;
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
Should this mapping use the DMA controller's device instead of the client
peripheral device?

The BAM DMA controller is the bus master fetching the command element, so
mapping it with chan->slave will place it in the wrong IOMMU domain.
Additionally, chan->slave may be NULL in modern dmaengine drivers,
potentially leading to a NULL pointer dereference.

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);

[Severity: Medium]
Does this missing endianness conversion write an invalid address to hardware
on big-endian architectures?

This assignment implicitly casts the CPU-endian dma_addr_t to a
little-endian __le32 field without the necessary cpu_to_le32()
conversion.

> +	desc->size =3D cpu_to_le16(sizeof(struct bam_cmd_element));
> +
> +	vc =3D &bchan->vc;
> +	vd =3D &async_desc->vd;
> +
> +	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
> +	vd->tx.flags =3D DMA_PREP_CMD;

[Severity: High]
Will the omission of the DMA_CTRL_ACK flag cause an unbounded memory leak?

The virt-dma core retains completed descriptors in vc->desc_completed
until async_tx_test_ack() evaluates to true. Since these dummy
descriptors are never returned to the client to be ACKed, they will
permanently accumulate in the list.

> +	vd->tx.desc_free =3D vchan_tx_desc_free;
> +	vd->tx_result.result =3D DMA_TRANS_NOERROR;
> +	vd->tx_result.residue =3D 0;
> +
> +	cookie =3D dma_cookie_assign(&vd->tx);

[Severity: High]
Does assigning cookies to dummy descriptors break the monotonic sequence of
completions?

Because the LOCK descriptor is prepended to desc_issued, it executes and
completes before the client's payload descriptors. When the LOCK completes,
vchan_cookie_complete() advances completed_cookie. A client polling
via dma_cookie_status() will falsely see its pending transfers as complete
before they have even started.

> +	ret =3D dma_submit_error(cookie);
> +	if (ret) {
> +		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);
> +		kfree(async_desc);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return async_desc;
> +}
> +
> +static int bam_do_setup_pipe_lock(struct bam_chan *bchan, bool lock)
> +{
> +	struct bam_device *bdev =3D bchan->bdev;
> +	const struct bam_device_data *bdata =3D bdev->dev_data;
> +	struct bam_async_desc *lock_desc;
> +	unsigned long flag;
> +
> +	lockdep_assert_held(&bchan->vc.lock);
> +
> +	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
> +	    bchan->direction !=3D DMA_MEM_TO_DEV)

[Severity: Medium]
Does this check entirely skip locking for RX channels?

The commit message explicitly states the feature is designed for "starting
DMA on an RX channel" (which is DMA_DEV_TO_MEM). However, aborting if
bchan->direction !=3D DMA_MEM_TO_DEV restricts this entirely to TX channels,
contradicting the stated intent.

> +		return 0;
> +
> +	flag =3D lock ? DESC_FLAG_LOCK : DESC_FLAG_UNLOCK;
> +
> +	lock_desc =3D bam_make_lock_desc(bchan, flag);
> +	if (IS_ERR(lock_desc))
> +		return PTR_ERR(lock_desc);
> +
> +	if (lock)
> +		list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +	else
> +		list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +
> +	return 0;
> +}
> +
> +static void bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	if (bam_do_setup_pipe_lock(bchan, true) || bam_do_setup_pipe_lock(bchan=
, false))

[Severity: High]
Does this short-circuit logic risk permanently locking the hardware pipelin=
e?

If the LOCK descriptor allocation succeeds but the UNLOCK allocation fails
(e.g., -ENOMEM), the short-circuit evaluates to true and the function
exits. The engine will execute the already-queued LOCK but never receive an
UNLOCK, resulting in a permanent hardware deadlock.

> +		dev_err(bchan->vc.chan.slave, "Failed to setup BAM pipe lock descripto=
rs");
> +}
> +
>  /**
>   * bam_start_dma - start next transaction
>   * @bchan: bam dma channel
>   */
>  static void bam_start_dma(struct bam_chan *bchan)
>  {
> -	struct virt_dma_desc *vd =3D vchan_next_desc(&bchan->vc);
> +	struct virt_dma_desc *vd;
>  	struct bam_device *bdev =3D bchan->bdev;
>  	struct bam_async_desc *async_desc =3D NULL;
>  	struct bam_desc_hw *desc;
> @@ -1030,6 +1169,9 @@ static void bam_start_dma(struct bam_chan *bchan)
> =20
>  	lockdep_assert_held(&bchan->vc.lock);
> =20
> +	bam_setup_pipe_lock(bchan);
> +

[Severity: High]
Will unconditionally calling bam_setup_pipe_lock() cause duplicate lock
injections if the hardware FIFO is full?

If bam_start_dma() exits early due to IS_BUSY(bchan), unprocessed payload
descriptors and the UNLOCK descriptor remain in the list. When the channel
resumes and bam_start_dma() is re-invoked to process the backlog, it will
blindly inject another pair of LOCK/UNLOCK descriptors into the middle of t=
he
ongoing transaction stream.

> +	vd =3D vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-qcom-qce-c=
md-descr-v18-0-99103926bafc@oss.qualcomm.com?part=3D6

