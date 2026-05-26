Return-Path: <dmaengine+bounces-10957-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDt9Fs+/FWrYZgcAu9opvQ
	(envelope-from <dmaengine+bounces-10957-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 17:44:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 579375D8F8B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197483205366
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AD3B2FE6;
	Tue, 26 May 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd+GHXLv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8B3D412B
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807675; cv=none; b=s3UppqQEb/1kctveqdH/xnk/x43IOL2EtRs4EOms0u4Q6DFe6bwciqD9P58zHvPwtkcP6uvMJhRxUv93TQ/aBOz/PwWrJBQpbm5EA3OTGSaWNOBu/ct0b61eVTmyYy5CA9GPQEYkNZRVBXaN5ZDm8WffLLfzXvin6KaC6gytXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807675; c=relaxed/simple;
	bh=XlxAdDJ475itex/QmHQ+wLS4XhzipImqA+E3ouIR32I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XdXGeSt0o8opACLiUamE9cs5r0qCW3V67MBK1J+NInsWTF34zx79iW5tNRZWYCjRgqrzgO7UkeELDtEyglZZvdyHtyRTmlBtWdQ7YK9FpMgJ24phjvr5rMyLOp1fDks31o7dFY1J09zJigtL1qkMNjLTt/+u6AZiF1AjBpdo8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd+GHXLv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC11F000E9;
	Tue, 26 May 2026 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807674;
	bh=G/sn5LjoXXRrrCuN7nUMKWedorR2NGuGBJX1m48FbW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nd+GHXLvkk8LIrLshFbAVSNGzJJHHMwIP2gLd95GC5M10QhVFKZg5nWGYz8j9EAiP
	 lUINfTR5PoXJ4NiOGFqspqN85N35sUyV49apYaGU5T3k+Wo0jkxM1H+KIFFsraxw+I
	 1WFQCgIN6hGrVajl65xQrLhluc8+OT0Id+gk0qfpHvTO70nor2Oxuh6yXgcE/g8OHI
	 MVZrio6aKEW7WK5SXvpM9a/Sf7URT10rSbvycnyBGmXIy8EDpN1sXw32jmX19PWEJf
	 RSg613uKWfrRlavSBkQ8exvMsxxaMasv/TcSeTXgSMW1FIGE6ooGqPa7WOW+EOHvsr
	 iv/BdwrXfOhLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/14] dmaengine: qcom: bam_dma: add support for BAM
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-6-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-6-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:01:13 +0000
Message-Id: <20260526150113.C3EC11F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10957-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 579375D8F8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Dummy lock descriptors steal DMA cookies and cause premature c=
ompletion of client transfers.
- [High] Hardware FIFO exhaustion causes unbounded spurious injections of n=
ested LOCK and UNLOCK descriptors.
- [High] A partial allocation or mapping failure leaves the BAM pipeline pe=
rmanently locked.
- [High] Pipe locking is applied exclusively to TX channels, contradicting =
the stated intent to support RX channels.
- [High] The dummy command descriptor is mapped using the client peripheral=
's device instead of the DMA engine's device.
- [High] Missing `cpu_to_le32()` conversion for the DMA descriptor hardware=
 address.
- [High] The `lock_ce` command element shares a CPU cache line with other s=
tructure members, leading to false sharing.
- [Medium] Missing length validation when attaching descriptor metadata.
--

commit 8b6f3d804203416c63344d33ae0ad758f79620c7
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: add support for BAM locking

Add support for BAM pipe locking. When starting DMA on an RX channel, this
prepends the queue of issued descriptors with a dummy command descriptor wi=
th
the LOCK bit set, and appends one with the UNLOCK bit once the transaction =
is
done.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 04fe1d546be73..84fd9e181bdd5 100644
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

[Severity: High]
Is it safe to embed lock_ce directly in struct bam_async_desc without
cache line alignment?

Since lock_ce is mapped for DMA, sharing a CPU cache line with other members
like desc_node could violate the DMA API. On architectures with non-coherent
caches, DMA cache maintenance operations might cause memory corruption or
lost CPU writes to adjacent fields in the structure.

> +
>  	/* list node for the desc in the bam_chan list of descriptors */
>  	struct list_head desc_node;
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

[Severity: Medium]
Could this result in an out-of-bounds read if len is smaller than expected?

The driver casts the data pointer to struct bam_desc_metadata * and
dereferences it without validating that len is at least the size of
struct bam_desc_metadata.

> +
> +	if (!bdata->pipe_lock_supported)
[ ... ]
> @@ -1012,13 +1057,105 @@ static void bam_apply_new_config(struct bam_chan=
 *bchan,
[ ... ]
> +static struct bam_async_desc *
> +bam_make_lock_desc(struct bam_chan *bchan, unsigned long flag)
> +{
[ ... ]
> +	bam_prep_ce_le32(&async_desc->lock_ce, bchan->scratchpad_addr, BAM_WRIT=
E_COMMAND, 0);
> +	sg_set_buf(&async_desc->lock_sg, &async_desc->lock_ce, sizeof(async_des=
c->lock_ce));
> +
> +	mapped =3D dma_map_sg(chan->slave, &async_desc->lock_sg, 1, DMA_TO_DEVI=
CE);

[Severity: High]
Should the memory be mapped using the DMA engine's device rather than the
client peripheral's device?

Because the BAM DMA controller executes this command, the memory needs to be
mapped into its own address space. If the DMA controller and the peripheral
are in different IOMMU domains, mapping it for chan->slave might yield an
address that triggers an IOMMU fault when the BAM DMA controller accesses i=
t.

> +	if (!mapped) {
> +		kfree(async_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr =3D sg_dma_address(&async_desc->lock_sg);

[Severity: High]
Are we missing a cpu_to_le32() conversion here?

The physical DMA address returned by sg_dma_address() is assigned directly
to desc->addr, which is of type __le32. On big-endian architectures, this
might cause the address to be written with the wrong byte order, leading the
hardware engine to fetch from an invalid physical address.

> +	desc->size =3D cpu_to_le16(sizeof(struct bam_cmd_element));
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

[Severity: Critical]
Will assigning a new cookie to the lock descriptor cause premature completi=
on
of client transfers?

Calling dma_cookie_assign() gives this descriptor a higher cookie value than
the client's already-submitted descriptors. Since the LOCK descriptor is
prepended to desc_issued, it executes first. When it completes, the channel=
's
completed_cookie is updated to this higher value.

Subsequent calls to dma_cookie_status() will falsely report the pending cli=
ent
descriptors as complete, potentially causing the client to free or reuse me=
mory
while the hardware is still performing DMA.

> +	ret =3D dma_submit_error(cookie);
[ ... ]
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

[Severity: High]
Does this logic contradict the commit message's stated intent to support
RX channels?

The check here aborts if the direction is not DMA_MEM_TO_DEV (a TX channel).
This applies pipe locking exclusively to TX channels, completely disabling =
it
for the intended RX channels.

> +		return 0;
> +
> +	flag =3D lock ? DESC_FLAG_LOCK : DESC_FLAG_UNLOCK;
[ ... ]
> +	return 0;
> +}
> +
> +static void bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	if (bam_do_setup_pipe_lock(bchan, true) || bam_do_setup_pipe_lock(bchan=
, false))

[Severity: High]
Could a partial allocation failure leave the BAM pipeline permanently deadl=
ocked?

The insertion relies on short-circuiting logic. If the first call successfu=
lly
adds the LOCK descriptor to desc_issued, and the second call for the UNLOCK
subsequently fails (e.g. returning -ENOMEM), an error is logged but the LOCK
descriptor is never rolled back.

The transaction would then execute with the LOCK, but since no UNLOCK is
issued, the channel remains permanently locked.

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
> @@ -1030,6 +1167,9 @@ static void bam_start_dma(struct bam_chan *bchan)
> =20
>  	lockdep_assert_held(&bchan->vc.lock);
> =20
> +	bam_setup_pipe_lock(bchan);

[Severity: High]
Could this unconditionally accumulate spurious nested LOCK and UNLOCK descr=
iptors
if the hardware FIFO is full?

During execution, if the loop over descriptors breaks early due to
!IS_BUSY(bchan), it leaves the remaining descriptors in desc_issued.
When the next interrupt triggers bam_start_dma() to continue the transactio=
n,
it will unconditionally add another LOCK and UNLOCK pair. This seems to bre=
ak
the hardware protocol by accumulating duplicate locking commands in the mid=
dle
of a continuous transfer.

> +
> +	vd =3D vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D6

