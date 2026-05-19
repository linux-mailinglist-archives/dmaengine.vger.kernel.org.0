Return-Path: <dmaengine+bounces-10555-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6uPfAD5sDGpKhgUAu9opvQ
	(envelope-from <dmaengine+bounces-10555-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:57:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E955801B9
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABFA30B73C4
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658573403F4;
	Tue, 19 May 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXJENFo8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A9293B5F
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198869; cv=none; b=efk39pO1RVoqoqRVObAHSGi+Rm3q+5+CIJpJKK8nxYGXVUaLJT3yWkhfNyAoJbPHyaP2pM4fWimek78T/AFkoW3BfTiDxjfJH6DNGNh4I79bVIFA3ai6e3AM2d9UOEVNfA6GcidGvyBH0Xz6de6Y9gB2VTRKV/p9d8nlhy9JZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198869; c=relaxed/simple;
	bh=xrZO3CeX5y4d7ITA9Qb2eDEub46Se8pQn3L7Scm7/cA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYBhW8R/xAtKz/7PS+l9ITyLSnoIdLLpM5JYPxB38kEs3DxO4OrD3+H7jlRp19pq2RExiNDilrD+vIRP5aebzIa1KY+mMTQaSeGg7q/E3tYbNCiu369dLYMU56LFotOq7CWeqGo0B051348+dijE0//uRDgQZZCibSMEUy+oFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXJENFo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6C7C2BCB3;
	Tue, 19 May 2026 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198868;
	bh=xrZO3CeX5y4d7ITA9Qb2eDEub46Se8pQn3L7Scm7/cA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EXJENFo85r5yFd47PyLFGjD+UNq11A/OhKtqgOdWrRH9z8CfYwbr5s6z7wI/7gFKG
	 CtLEf8UPO0yflbur7pVFwE3fSewJfdvj2W2jatbRYFQ4SMx2iV1JsdUSoxbUQecgv3
	 48G1cEcsQK5gXjIO59+LDh+JOhoGRLTaKulERHxUnpYeP4l4rHg12urtYzY/u3vAeh
	 kQEAOT8ObbZ7MtMGO75YFXb5yaRt+eRhnCTFy6qVUkD6ZCqKQD7NE8jnE0drrjovMP
	 u70hrWk62+UoQLVP94POh9VTNMVYlcq+xDMNAn3xWdsq4LlwC0wK6UaxPArtpXtJD1
	 zpl10g1q/3JxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-6-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-6-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:54:27 +0000
Message-Id: <20260519135428.9D6C7C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10555-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 62E955801B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Out-of-order DMA cookie assignment causes premature transactio=
n completion for clients.
- [Critical] Native integers assigned directly to little-endian hardware de=
scriptors.
- [High] Unconditional injection of LOCK/UNLOCK descriptors corrupts the pe=
nding transaction queue.
- [High] Unhandled allocation failure for UNLOCK descriptor leaves the BAM =
pipe permanently locked.
- [High] DMA engine control flag is invalidly passed as a DMA mapping attri=
bute.
- [High] Descriptor-specific metadata unsafely overwrites global channel st=
ate.
- [Medium] Direction check contradicts commit message intent, explicitly sk=
ipping pipe locking for RX channels.
- [Medium] Missing length validation in `bam_metadata_attach` allows out-of=
-bounds reads.
--

commit 44d1fcb40281218d18c6b56492066d2d5e6beb61
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: add support for BAM locking

Add support for BAM pipe locking by prepending a dummy command descriptor
with the LOCK bit set, and appending one with the UNLOCK bit once the
transaction is done. The dummy writes use a scratchpad address provided via
descriptor metadata.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 30318cf01ee20..2c9f90313c313 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
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
> +
> +	if (!data)
> +		return -EINVAL;
> +

Does this code need to validate the len parameter? If the caller passes a
buffer smaller than sizeof(struct bam_desc_metadata), will this read
out-of-bounds memory when accessing the metadata fields?

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

By saving descriptor-specific metadata directly into the global channel
structure, could this overwrite the state if a client queues multiple
descriptors with different metadata?

Also, does the scratchpad_addr remain set for subsequent unrelated
transactions, potentially causing dummy writes to a stale address?

> +
> +	return 0;
> +}
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
[ ... ]
> +	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRIT=
E_COMMAND, 0);
> +	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_des=
c->lock_ce));
> +
> +	mapped =3D dma_map_sg_attrs(chan->slave, &async_desc->lock_sg,
> +				  1, DMA_TO_DEVICE, DMA_PREP_CMD);

DMA_PREP_CMD is a dmaengine control flag, but it's being passed as the attrs
parameter here. Could this cause undefined DMA mapping behavior by being
interpreted as a mapping attribute like DMA_ATTR_ALLOC_SINGLE_PAGES?

Additionally, since unmapping is done without attributes later, will this
violate the requirement that mapping and unmapping attributes must match?

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);
> +	desc->size =3D sizeof(struct bam_cmd_element);

Since the addr and size fields of struct bam_desc_hw are little-endian,
will assigning native integers here corrupt the physical address and size
on big-endian systems?

> +
> +	vc =3D &bchan->vc;
> +	vd =3D &async_desc->vd;
> +
> +	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
> +	vd->tx.flags =3D DMA_PREP_CMD;
> +	vd->tx.desc_free =3D vchan_tx_desc_free;
> +	vd->tx_result.result =3D DMA_TRANS_NOERROR;
> +	vd->tx_result.residue =3D 0;
> +
> +	cookie =3D dma_cookie_assign(&vd->tx);

Because this happens inside bam_start_dma(), after the client has already
prepared and queued their own descriptors, will the new LOCK descriptor
receive a cookie value that is numerically larger than the pending client
transactions?

Since the LOCK descriptor is inserted at the head of desc_issued and will
complete first, will this update the channel's completed_cookie to this
higher value, causing clients to see their own transactions as prematurely
completed?

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

The commit message explicitly states this is intended for RX channels.
However, DMA_MEM_TO_DEV specifies a TX transfer. Does this check skip
locking for RX channels (DMA_DEV_TO_MEM), contradicting the commit message?

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

If the first call successfully creates the LOCK descriptor (returning 0)
but the second call fails to allocate the UNLOCK descriptor, will the LOCK
descriptor remain queued without its corresponding UNLOCK, permanently
deadlocking the channel?

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
> @@ -1030,6 +1170,9 @@ static void bam_start_dma(struct bam_chan *bchan)
> =20
>  	lockdep_assert_held(&bchan->vc.lock);
> =20
> +	bam_setup_pipe_lock(bchan);

If bam_start_dma() encounters a full BAM FIFO and exits early, it leaves
unprocessed descriptors in the desc_issued list. When bam_start_dma() is
called again later, won't it prepend another LOCK and append another UNLOCK
into the middle of the pending transaction sequence, corrupting the hardware
stream?

> +
> +	vd =3D vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D6

