Return-Path: <dmaengine+bounces-10556-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCmAJPptDGpKhgUAu9opvQ
	(envelope-from <dmaengine+bounces-10556-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:04:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA575580361
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C46B530160DC
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729B46B5;
	Tue, 19 May 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6Wwxmz6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0419CD0A
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198998; cv=none; b=XVlFk6OhTRfOM2k/WtI0SdaQ3n5PJ7TGstXIPgQiKutIWXYvk9P2VdsCMMyjWHD6iu9sbkiLLkvSgec+47vrzNSbSUeK2/lz6I0dIZ/2oXRXfFinfaW6+AhwwpZpZmojMmfR5HiMFjhGHDxQneZwdALQm88zmdFstkGPRVCILzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198998; c=relaxed/simple;
	bh=xwxvHd7V8VHSKrK2otqrgdTFXSmm/3W4zbLV23EsLDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWDnyH4ZKAdemzAkR+h1cKR0Xr0cGOGDDv4R/77DNgkMAAWDJwJ3SAUQU4lvLwU1FAGWD/lMujeJzWDU/Cy1qAfsRM0DCckmFBQcY3DI+5wm7r6HKGOv2sDgYc7kkkmDh/XvVwdfoMxNS1fMH+ns3GgAsRhlwesufNXdtG1VpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6Wwxmz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDAAC2BCB8;
	Tue, 19 May 2026 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198997;
	bh=xwxvHd7V8VHSKrK2otqrgdTFXSmm/3W4zbLV23EsLDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I6Wwxmz6uk274ErxzdRzFyFy8R//NEr97iuRU8ABKeGY/8qDLkuJXAkvQgNbv7GGK
	 mY0jPfAKqVagwL6YRYTLTzHUInMPFRQQg1VWcCkiM11I6X/To+MIW9ZYH/k/oLEjum
	 7tfG7ncUhc7Teb3PJCdhOJSfi15Ei8Qf863/gvQH8GPOj+5kd/HVFmqpefGfE4ISys
	 vkjTC2ZdFo2idXvxnB2J7IuTU43J1Q3aOqLrQTEw/I85o0v9sWYFBMne8cggsK+fjV
	 WpxllNvPDhgAIPt9KNIoxGU6KzzOZTmf1K0PUWJLbx6xWx1QE9jDTs003Akf1pmBQj
	 7LLfGbgpprp1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 13/14] crypto: qce - Add BAM DMA support for crypto
 register I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-13-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-13-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:56:30 +0000
Message-Id: <20260519135637.8FDAAC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10556-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: EA575580361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] DMA API misuse causing potential memory corruption or IOMMU faults.
- [High] Missing endianness conversion for BAM DMA command data.
- [High] Buffer overflow due to missing bounds checking in BAM DMA arrays.
- [High] Resource leak of DMA mappings on successful crypto operations.
- [Medium] Race condition in `qce_dma_terminate_all()` due to improper DMA =
unmap ordering.
- [Low] Unused coherent DMA memory allocation for register reads.
- [Low] Suboptimal scatterlist construction for BAM command descriptors.
--

commit 7d591e31fc1682350db9b4ee4360e0e434326203
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Add BAM DMA support for crypto register I/O
   =20
Switch to using BAM DMA for register I/O in addition to passing data. To
that end: provide the necessary infrastructure in the driver, modify the
ordering of operations as required and replace all direct register writes
with wrappers queueing DMA command descriptors.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 3db46fc0c419a..b66e6386fccda 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> +int qce_submit_cmd_desc(struct qce_device *qce)
> +{
> +	struct qce_desc_info *qce_desc =3D qce->dma.bam_txn->desc;
> +	struct qce_bam_transaction *bam_txn =3D qce->dma.bam_txn;
> +	struct dma_async_tx_descriptor *dma_desc;
> +	struct dma_chan *chan =3D qce->dma.rxchan;
> +	unsigned long attrs =3D DMA_PREP_CMD;
> +	dma_cookie_t cookie;
> +	unsigned int mapped;
> +	int ret;
> +
> +	mapped =3D dma_map_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, D=
MA_TO_DEVICE);
> +	if (!mapped)
> +		return -ENOMEM;

Does this leak the DMA mapping on successful crypto operations?

The wr_sgl scatterlist is mapped for DMA here, but there does not appear to
be a corresponding dma_unmap_sg() on the successful completion paths of the
crypto requests. The unmapping is currently only handled in
qce_dma_terminate_all() during error cleanup.

> +
> +	dma_desc =3D dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr=
_sgl_cnt,
> +					   DMA_MEM_TO_DEV, attrs);

Should this pass the mapped variable instead of bam_txn->wr_sgl_cnt?

Because dma_map_sg() coalesces contiguous physical memory regions, the
number of returned segments can be fewer than the original count. Passing
the original wr_sgl_cnt might force the DMA engine to process trailing,
unmapped scatterlist entries, which could lead to IOMMU faults or memory
corruption.

> +	if (!dma_desc) {
> +		ret =3D -ENOMEM;
> +		goto err_unmap_sg;
> +	}

[ ... ]

> +static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma=
_data *dma,
> +				  unsigned int addr, void *buf)
> +{
> +	struct qce_bam_transaction *bam_txn =3D dma->bam_txn;
> +	struct bam_cmd_element *bam_ce_buf;
> +	int bam_ce_size, cnt, idx;
> +
> +	idx =3D bam_txn->bam_ce_idx;
> +	bam_ce_buf =3D &bam_txn->bam_ce[idx];
> +	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));

Could this result in incorrect endianness on big-endian hardware?

The value passed to buf originates as a native host-endian u32 from
qce_write_dma(). Casting it directly to __le32 * and dereferencing it skips
the use of cpu_to_le32(). This would write native big-endian values directly
to the little-endian BAM DMA hardware.

> +
> +	bam_ce_buf =3D &bam_txn->bam_ce[bam_txn->pre_bam_ce_idx];
> +	bam_txn->bam_ce_idx++;

Does this code overflow the bam_txn->bam_ce[] array?

The array is sized to QCE_BAM_CMD_ELEMENT_SIZE (128), but there are no
bounds checks before unconditionally incrementing bam_ce_idx.

> +	bam_ce_size =3D (bam_txn->bam_ce_idx - bam_txn->pre_bam_ce_idx) * sizeo=
f(*bam_ce_buf);
> +
> +	cnt =3D bam_txn->wr_sgl_cnt;
> +
> +	sg_set_buf(&bam_txn->wr_sgl[cnt], bam_ce_buf, bam_ce_size);
> +
> +	++bam_txn->wr_sgl_cnt;

Similarly, does this overflow the bam_txn->wr_sgl[] array?

It is also sized to QCE_BAM_CMD_SGL_SIZE (128) and incremented without
checking if the bounds have been exceeded.

> +	bam_txn->pre_bam_ce_idx =3D bam_txn->bam_ce_idx;

Could the scatterlist construction be improved here?

By setting pre_bam_ce_idx equal to bam_ce_idx after every write, this
appears to create a separate 16-byte scatterlist entry for every individual
register write instead of batching adjacent command elements into a single
contiguous scatterlist segment.

> +}
> +
> +void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
> +{
> +	unsigned int reg_addr =3D ((unsigned int)(qce->base_phys) + offset);
> +
> +	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
> +}
> +
>  int devm_qce_dma_request(struct qce_device *qce)
>  {

[ ... ]

> +	qce->read_buf =3D dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ * size=
of(*qce->read_buf),
> +					    &qce->read_buf_dma, GFP_KERNEL);

Is this allocated memory actually used?

The driver appears to allocate this coherent DMA memory, but continues to
use the synchronous readl() for qce_read(), leaving this buffer unused.

> +	if (!qce->read_buf)
> +		return -ENOMEM;
> +
>  	return 0;
>  }

[ ... ]

>  int qce_dma_terminate_all(struct qce_dma_data *dma)
>  {
> +	struct qce_device *qce =3D container_of(dma, struct qce_device, dma);
> +	struct qce_bam_transaction *bam_txn =3D dma->bam_txn;
>  	int ret;
> =20
> +	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
> +
>  	ret =3D dmaengine_terminate_all(dma->rxchan);
>  	return ret ?: dmaengine_terminate_all(dma->txchan);
>  }

Could this ordering cause an IOMMU fault?

Calling dma_unmap_sg() before dmaengine_terminate_all() can mean that the
memory is unmapped while the DMA engine is still actively processing
descriptors during an error or cancellation path. Should the hardware be
terminated prior to unmapping the memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D13

