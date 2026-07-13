Return-Path: <dmaengine+bounces-12395-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3w3zEPjmVGpdgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12395-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:24:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FFC74B896
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SAnEtwAa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12395-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12395-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CA0B3054514
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A042314A;
	Mon, 13 Jul 2026 13:17:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E961421F07
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:17:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948658; cv=none; b=lYegwzf1oUWwCQD/UUNnYHYlYu97e92u5igTbJk7NkdZQpQ34o3D5L/Aj9yrULtyhemVD37105rsdO49R96Alw3mGC0ekl1VeUKaOTgQUDdMxoLRqUN4iLUvZyTLC/FdJN9PO7wjn/Wv+xecmL6gDxyQ8PrujLbnIkAg2HpyUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948658; c=relaxed/simple;
	bh=5xv3kiV5HwsASW8740oeC3drjlyh/pPwnBvqKQJl3fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpDcCMCQYdaa83AYR8i+5kts0vPmyKxbDWhJXuVfTjYbtiEnI77XdGNnFst0IFT4nRb6PeK5Y3kF5W6+liskUM3ZHHH8VWY7CzPhxpojXOSJUjYwLMo7z0J4YA9D32PK4WC1jzVjhfB+yElrEnGApMwCB2PlA5W75p4CLknpP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAnEtwAa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E421F000E9;
	Mon, 13 Jul 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948657;
	bh=teHtcNMeK1Ld5FeVa89gQqzGmjGqSLRzl7GyjUfKcU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAnEtwAawAuK+eCJW8lYQN0Rsapf5ZVLhnPe/IYBsGjhiGnoovVns/+Nb9DO5B0xu
	 AVAPGsFE4hyw+S/n5cWYrxVWgJE2Xd5Vnc30LF/wrrkd7apH9iL1d0ufYP9oh1rIDc
	 lF5bhPVXdn7P7SexdFtcQZNozK9G1gxlF/y43sz8MfaCbyz/9+Vmcf4/KlSg1Lg6F1
	 n5JvTG3dd2ezSOouTu67/icFnbsSEHb0asY8hcAoFdNfc/TF4szVapZ+IOX4w2cc2f
	 OakFEhhYhVvu7YQOYw82gEdIFTNZbc0CYjvRChlMwb6pS3F0fLyvGgDqV2BYzk8XTm
	 yE8TN3qz7LApA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-6-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-6-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:17:36 +0000
Message-Id: <20260713131736.D1E421F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12395-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,qualcomm.com:email,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6FFC74B896

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] `dma_map_sg()` and `dma_unmap_sg()` incorrectly use the client dev=
ice (`chan->slave`) instead of the BAM DMA controller device.
- [High] Descriptor-specific metadata is incorrectly stored in the global c=
hannel state, causing a state leak and potential memory corruption.
- [High] Missing endianness conversion (`cpu_to_le32`) when assigning the p=
hysical address to the BAM hardware descriptor.
- [High] Silent fallback to unlocked operation if memory allocation fails f=
or pipe lock descriptors.
- [Medium] Mapping an embedded structure member (`lock_ce`) for DMA violate=
s DMA API cacheline alignment rules.
- [Medium] `bam_metadata_attach` casts and reads the user-provided `data` b=
uffer without validating `len`.
- [Medium] Silent truncation of a physical address to a 24-bit offset.
--

--- Patch [6]: [PATCH v21 06/14] dmaengine: qcom: bam_dma: add support for =
BAM locking ---
commit 6c206bd6717df7ed7061a889f4998d1b7849b74d
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: add support for BAM locking

This commit adds support for BAM pipe locking by prepending and appending
dummy command descriptors with LOCK/UNLOCK bits. It uses a client-provided
scratchpad address passed via descriptor metadata.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index f3e713a5259c2..f08549ee3872e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -72,6 +76,11 @@ struct bam_async_desc {
> =20
>  	struct bam_desc_hw *curr_desc;
> =20
> +	/* BAM locking infrastructure */
> +	bool is_lock_desc;
> +	struct scatterlist lock_sg;
> +	struct bam_cmd_element lock_ce;

[Severity: Medium]
Is it safe to map lock_ce for DMA here without cacheline alignment?

Since lock_ce is embedded inside the dynamically allocated
struct bam_async_desc, it shares a cacheline with heavily accessed CPU memb=
ers
like desc_node.

Would this violate DMA API cacheline alignment rules and risk memory
corruption during cache maintenance operations on non-coherent architecture=
s?

[ ... ]

> @@ -686,6 +702,35 @@ static int bam_slave_config(struct dma_chan *chan,
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

[Severity: Medium]
Does this function need to validate the length of the data buffer?

If a caller accidentally provides a short metadata buffer, could accessing
metadata->scratchpad_addr result in an out-of-bounds memory read?

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
Is it intentional to write transaction-specific metadata directly into the
global channel state here?

If a client queues multiple descriptors with different metadata, won't the
latest call overwrite the state for all pending descriptors?

Also, since bchan->scratchpad_addr is not cleared in bam_free_chan(), if a
new client acquires the channel, could bam_setup_pipe_lock() read a stale
scratchpad_addr and silently inject dummy locks writing to the previous
client's memory?

> +
> +	return 0;
> +}

[ ... ]

> @@ -859,6 +909,15 @@ static int bam_resume(struct dma_chan *chan)
>  	return 0;
>  }
> =20
> +static void bam_dma_free_lock_desc(struct virt_dma_desc *vd)
> +{
> +	struct bam_async_desc *async_desc =3D container_of(vd, struct bam_async=
_desc, vd);
> +	struct dma_chan *chan =3D vd->tx.chan;
> +
> +	dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);

[Severity: High]
Should this unmap use the BAM DMA controller device instead of chan->slave?

Because the BAM DMA controller is the bus master reading the command elemen=
t,
using the client device's domain might result in an invalid IOVA or IOMMU
translation faults.

> +	kfree(async_desc);
> +}

[ ... ]

> @@ -1046,13 +1113,102 @@ static void bam_apply_new_config(struct bam_chan=
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

[Severity: Medium]
Does bam_prep_ce_le32() safely handle a full phys_addr_t?

The struct defines scratchpad_addr as a phys_addr_t, but bam_prep_ce_le32()
appears to mask the address with 0xffffff, discarding bits above the lowest
24 bits. If a client provides a 32-bit or 64-bit physical address, will the
dummy write target the wrong address?

> +	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_des=
c->lock_ce));
> +
> +	mapped =3D dma_map_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVI=
CE);

[Severity: High]
Similar to the unmap path, should this mapping use the BAM DMA controller
device rather than the client device (chan->slave)?

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);

[Severity: High]
Is a cpu_to_le32() conversion missing here when assigning to desc->addr?

Since sg_dma_address() returns a dma_addr_t in host CPU byte order, writing
this directly to the __le32 addr field could result in a byte-swapped addre=
ss
on Big-Endian systems, causing the BAM DMA engine to read from an invalid
IOVA.

> +	desc->size =3D cpu_to_le16(sizeof(struct bam_cmd_element));

[ ... ]

> @@ -1072,6 +1229,18 @@ static void bam_start_dma(struct bam_chan *bchan)
>  		return;
> =20
>  	while (vd && !IS_BUSY(bchan)) {
> +		/*
> +		 * Open a LOCK/UNLOCK bracket around each fresh sequence.
> +		 * Sentinels inserted by bam_setup_pipe_lock() are skipped: they
> +		 * already have bam_locked set and must not trigger a second pair.
> +		 */
> +		if (!bchan->bam_locked &&
> +		    !container_of(vd, struct bam_async_desc, vd)->is_lock_desc) {
> +			ret =3D bam_setup_pipe_lock(bchan);
> +			if (ret =3D=3D 0 && bchan->bam_locked)
> +				vd =3D vchan_next_desc(&bchan->vc);
> +		}

[Severity: High]
If bam_setup_pipe_lock() fails and returns an error code, is it safe to
proceed to queue the DMA transaction unlocked?

Since the commit message states the lock is strictly required to prevent
config writes while the engine is busy, could silently ignoring the failure
allow unpredictable hardware behavior?

> +
>  		list_del(&vd->node);

[ ... ]

> @@ -1191,8 +1364,11 @@ static void bam_issue_pending(struct dma_chan *cha=
n)
>   */
>  static void bam_dma_free_desc(struct virt_dma_desc *vd)
>  {
> -	struct bam_async_desc *async_desc =3D container_of(vd,
> -			struct bam_async_desc, vd);
> +	struct bam_async_desc *async_desc =3D container_of(vd, struct bam_async=
_desc, vd);
> +	struct dma_chan *chan =3D vd->tx.chan;
> +
> +	if (async_desc->is_lock_desc)
> +		dma_unmap_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVICE);

[Severity: High]
As noted earlier, should this unmap use the BAM DMA controller device inste=
ad
of chan->slave?

> =20
>  	kfree(async_desc);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D6

