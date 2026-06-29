Return-Path: <dmaengine+bounces-11858-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gv0OKM9GQmpu3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11858-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:19:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A46D8D29
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ACPtIGed;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11858-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11858-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D1B33005E8E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6D3FCB0A;
	Mon, 29 Jun 2026 10:16:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63B3B2FD4
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:16:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728176; cv=none; b=BDR45CIWuZ4MpXGC91Qx8JUSeM4xYRXTxBpjqwThAX14IiyY6vzCo3fOnHRPQXvvRc4ufSjX6Br8pxPNonstfeoTlvyd67zfuwqG5KjmCR6zeI/Oe0rBkEPEQcSzdr2Z42V0UgwhyJ6k5s1iX7PyxyVFIYnWTCQ2CFYmgp70UsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728176; c=relaxed/simple;
	bh=p4fO68t2YUsdopmamKnSgRC0bVYgGoOzDytI3EAn374=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vGJdXyrFD3JMtO5ucChUitYkmPsoXU5jEXC+DLNjQunL5slvNdSXh4s/E/0aV6MJ7HBVolel5Njpkimx0VCbgfoZk5+r1CstOV6n/UAZXp93fv/Cx/r7Nr63OOH1czv7B3zSRbsilh5vz/1K8mBa9DxGgRQ+ycIX1X7iaS8AQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACPtIGed; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0821F00A3D;
	Mon, 29 Jun 2026 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728174;
	bh=v+LZcHQ9oW2mjm1wzuQ102T8kG2XQ0ghvwfrKESkcVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACPtIGedtf0AVZR7Iek0vbgpx6Uodbkbku36WU/OTNMFw9fpffXibWkSN40IuWfXK
	 iR88xcWtloBYvFHKQ9O0eO/nsfZUv6RzfjgU40bpNTmAhLKU5sPARIV6BGrPqJ5zH3
	 DSmieYA0C8IiIcFVoHrFsrwgX4UChCFBUrDR0i107uwcFRuBZUTnPT9nRaoumqDkdW
	 0vsts29mamSolq3lC9N7w9Bd/0S4MGkqIvwinqbqPQN0vF1H8qhkQ+Y/Cfn7ZMgzXN
	 W7iGUF7RbARG08+cnbDGcBnoQtq2h05NZpjst5uUl3zDWcacaT0bvJTPXFmlgESXkD
	 tFtYX43OBkniw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-6-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-6-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:16:13 +0000
Message-Id: <20260629101613.DA0821F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11858-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 143A46D8D29

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Race condition in locked descriptor processing leaves appended tra=
nsactions unprotected.
- [High] Missing endianness conversion on physical address assigned to hard=
ware descriptor.
- [High] Per-descriptor metadata is unsafely stored in the shared channel s=
tate.
- [High] Mapping an unaligned embedded structure field for DMA.
- [Medium] Internal command buffers are mapped using the client device inst=
ead of the DMA controller device.
- [Medium] Logic mismatch restricts BAM locking to TX channels instead of R=
X channels.
--

commit 74132b5d8141c72f8f781c94cfc7fae626e96be7
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: add support for BAM locking

Add support for BAM pipe locking. To that end: when starting DMA on an RX
channel - prepend the existing queue of issued descriptors with an
additional "dummy" command descriptor with the LOCK bit set. Once the
transaction is done (no more issued descriptors), issue one more dummy
descriptor with the UNLOCK bit.

[ ... ]

> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c

[ ... ]

> @@ -686,6 +701,35 @@ static int bam_slave_config(struct dma_chan *chan,
>  	return 0;
>  }
> =20
> +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, voi=
d *data, size_t len)
> +{
> +	struct bam_chan *bchan =3D to_bam_chan(desc->chan);
> +	const struct bam_device_data *bdata =3D bchan->bdev->dev_data;
> +	struct bam_desc_metadata *metadata =3D data;
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
> +	bchan->direction =3D metadata->direction;

[Severity: High]
Does this safely handle multiple descriptors being prepared before they are
issued?

Since the attach callback operates per-descriptor, storing these properties
directly into the shared bchan object could overwrite the state of previous=
ly
prepared descriptors.=20

When the locked sequence is eventually executed, might the channel apply th=
is
overwritten metadata to all pending transactions, potentially using the wro=
ng
scratchpad address for earlier ones?

> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -1046,13 +1114,101 @@ static void bam_apply_new_config(struct bam_chan=
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
> +
> +	desc =3D async_desc->desc;
> +
> +	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRIT=
E_COMMAND, 0);
> +	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_des=
c->lock_ce));

[Severity: High]
Could this mapping violate DMA API requirements for cacheline alignment?

The lock_ce field is embedded within struct bam_async_desc and is not
guaranteed to be cacheline-aligned to ARCH_DMA_MINALIGN. Mapping it via
dma_map_sg() means it shares a cacheline with other fields.

If the CPU modifies adjacent fields (like async_desc->desc_node) while the
DMA mapping is active, it dirties the cacheline. On non-coherent
architectures, could this lead to unpredictable behavior and trigger DMA API
debug warnings?

> +
> +	mapped =3D dma_map_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVI=
CE);

[Severity: Medium]
Should this use the BAM DMA controller device instead of the client device?

The DMA mapping is being created in the IOMMU domain of the client device
(chan->slave). If the client device and the BAM controller do not share an
IOMMU domain, the BAM controller might be unable to access the command
element, resulting in an IOMMU fault.

Would it be better to map this using chan->device->dev or bchan->bdev->dev
since the BAM controller is the one reading the command buffer?

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);

[Severity: High]
Is an endianness conversion missing here?

The desc->addr field is __le32, but it is being assigned a native
dma_addr_t without cpu_to_le32().=20

On big-endian systems, won't this write the wrong byte order into the hardw=
are
descriptor and cause the BAM controller to fetch from an invalid memory add=
ress?

> +	desc->size =3D cpu_to_le16(sizeof(struct bam_cmd_element));
> +
> +	vc =3D &bchan->vc;
> +	vd =3D &async_desc->vd;
> +
> +	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
> +	vd->tx.flags =3D DMA_PREP_CMD;
> +	vd->tx_result.result =3D DMA_TRANS_NOERROR;
> +	vd->tx_result.residue =3D 0;
> +
> +	return async_desc;
> +}
> +
> +static int bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	const struct bam_device_data *bdata =3D bchan->bdev->dev_data;
> +	struct bam_async_desc *lock_desc, *unlock_desc;
> +
> +	lockdep_assert_held(&bchan->vc.lock);
> +
> +	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
> +	    bchan->direction !=3D DMA_MEM_TO_DEV)

[Severity: Medium]
Does this logic correctly target RX channels?

The commit message explicitly states: "when starting DMA on an RX channel",
but DMA_MEM_TO_DEV specifies the TX direction.=20

Will this silently skip the lock setup for RX channels (DMA_DEV_TO_MEM)?

> +		return 0;

[ ... ]

> @@ -1064,9 +1220,23 @@ static void bam_start_dma(struct bam_chan *bchan)
> =20
>  	lockdep_assert_held(&bchan->vc.lock);
> =20
> +	vd =3D vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;
> =20
> +	/*
> +	 * Wrap the issued work with a LOCK/UNLOCK pair exactly once, at the
> +	 * start of a fresh sequence and only when there is real work to lock
> +	 * around. On a re-entry after a full FIFO, we see the BAM is locked
> +	 * and must not add another pair we simply continue loading the
> +	 * remainder of the same locked sequence.
> +	 */
> +	if (!bchan->bam_locked) {
> +		ret =3D bam_setup_pipe_lock(bchan);
> +		if (ret =3D=3D 0 && bchan->bam_locked)
> +			vd =3D vchan_next_desc(&bchan->vc);
> +	}

[Severity: High]
Is there a race condition here if new descriptors are appended?

If a new descriptor is submitted via vchan_issue_pending() while the hardwa=
re
is busy processing a locked sequence, the new descriptor is appended after =
the
UNLOCK descriptor.

When bam_start_dma() loops to process this new descriptor, bchan->bam_locked
is still true because it is only cleared asynchronously when the UNLOCK
hardware interrupt fires:

process_channel_irqs() {
    ...
    if (flags & DESC_FLAG_UNLOCK)
        bchan->bam_locked =3D false;
    ...
}

Because bchan->bam_locked is still true, won't this skip adding a new LOCK,
leaving the new transaction unprotected in the hardware FIFO?

> +
>  	ret =3D pm_runtime_get_sync(bdev->dev);
>  	if (ret < 0)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D6

