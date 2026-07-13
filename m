Return-Path: <dmaengine+bounces-12399-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gWRD3fqVGpzhAAAu9opvQ
	(envelope-from <dmaengine+bounces-12399-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:39:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D164674BB61
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i6JG2n1V;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12399-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12399-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6534302A0B2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213F426425;
	Mon, 13 Jul 2026 13:24:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA39371878
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949092; cv=none; b=mUw0SIQgE/6N2CcxuBYECi7tq1dY/9gyRiKF5ToYclHHUIVqGwUMbi5lig21vfNVp6UWMJFbjEq/bePe3HWKCFvbR4bSrD+ip23r3heh5/4H2JwE1UMsaZUR06kXy21aEwsxXeqiW8Cwz/w4ktfMhFeHC4Ddq5mVmg4+ef8TUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949092; c=relaxed/simple;
	bh=98S9unl3ehhk8Yb6yKkOfcAx6pWM8Dz20mDjTUp1CKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQGyzGmWYcxWiaoDEcIulER2NinJQd2Bcy6FzSYFm4ZKeQUtBpTiKGAND+RxZQohrOop1mzuPS4u1K4Jqj/vWlhD3CA655jhN0Rms6PuhYpKUvmt+mdGAn53kUW1sEaRSx1JxO0rEgKNTnQCEymlVitCNr0tt9s1lcK4jFSGQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6JG2n1V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7211F00A3E;
	Mon, 13 Jul 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949091;
	bh=a/9pTIKl2EL3gkRQfu33NgkktbookJgKiJx1s8J4LSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6JG2n1VCVT7YdBv4XEirjKIOha+SEDQ/4RGiFCkSayAyJW/YkdAv1pcnVgfIhU1P
	 oI0VgeusGzDR0UvLGXA+58kUY4sMARGszXacpIqyJDLUkJrBAWsCOaebYcpwSClWYw
	 2lWYspB0VsA4oL7nCVwpxCr9PilUMEPCw/tdMX1uSL1WowRxqhDR0YHPdXb2g3GZXr
	 ugtkqSo56yOESQbcCN/V2c5MFcs1dTWwkUvK3RAeMGepO/vq+SMwKl4eivrpQ9da/D
	 Qq+PDRnlpeuF98UbI8XfKmTR5kmqEDGlhOz38F4wdM07d6jM0xylzMn83wcv9nPset
	 IxtM0VHmb305w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 13/14] crypto: qce - Add BAM DMA support for crypto
 register I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-13-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-13-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:24:50 +0000
Message-Id: <20260713132451.4C7211F00A3E@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12399-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D164674BB61

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] BAM DMA command descriptors are written with native host-endian =
`u32` values, causing byte-swapping data corruption on big-endian platforms.
- [Medium] Early return in `qce_dma_terminate_all()` leaks DMA mappings and=
 skips terminating the TX channel if RX channel termination fails.
- [Medium] Leaked DMA descriptor in error path due to incorrect use of `dma=
engine_desc_free` on a non-reusable descriptor.

Pre-existing issues:
- [High] Memory leak of `rctx->adata` buffer in CCM requests with associate=
d data on both success and error paths.
- [High] The error path in `qce_aead_async_req_handle` unmaps the wrong sca=
tterlist for CCM requests, leading to a DMA mapping leak and invalid unmap.
- [High] Failure of `dma_map_sg` for the source scatterlist is bypassed due=
 to an incorrect error check, leading to an invalid unmap.
--

--- Patch [13]: [PATCH v21 13/14] crypto: qce - Add BAM DMA support for cry=
pto register I/O ---
commit 07a714be1f94a3c7b4d4c5c79104848b7570dad5
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Add BAM DMA support for crypto register I/O

Switch to using BAM DMA for register I/O in addition to passing data. To
that end: provide the necessary infrastructure in the driver, modify the
ordering of operations as required and replace all direct register writes
with wrappers queueing DMA command descriptors.

> diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
> index 92d84941d3dbf..48ea7fb9a91e6 100644
> --- a/drivers/crypto/qce/aead.c
> +++ b/drivers/crypto/qce/aead.c
[ ... ]
> @@ -461,17 +461,17 @@ qce_aead_async_req_handle(struct crypto_async_reque=
st *async_req)
>  			src_nents =3D dst_nents - 1;
>  	}
> =20
> -	ret =3D qce_dma_prep_sgs(&qce->dma, rctx->src_sg, src_nents, rctx->dst_=
sg, dst_nents,
> -			       qce_aead_done, async_req);
> +	ret =3D qce_start(async_req, tmpl->crypto_alg_type);
>  	if (ret)
>  		goto error_unmap_src;
> =20
> -	qce_dma_issue_pending(&qce->dma);
> -
> -	ret =3D qce_start(async_req, tmpl->crypto_alg_type);
> +	ret =3D qce_dma_prep_sgs(&qce->dma, rctx->src_sg, src_nents, rctx->dst_=
sg, dst_nents,
> +			       qce_aead_done, async_req);
>  	if (ret)
>  		goto error_terminate;
> =20
> +	qce_dma_issue_pending(&qce->dma);
> +
>  	return 0;
> =20
>  error_terminate:

[Severity: High]
This is a pre-existing issue, but does this function leak memory allocated
for CCM requests with associated data?

qce_aead_async_req_handle() calls qce_aead_ccm_prepare_buf() which
allocates:

    rctx->adata =3D kzalloc(...)

The buffer allocated for rctx->adata is never freed anywhere in the driver,
neither in the success path (qce_aead_done) nor in the error paths. Will
this reliably exhaust kernel memory for every CCM request?

[Severity: High]
This is a pre-existing issue, but is the wrong scatterlist being unmapped
in the error path?

If an error occurs, the error handler incorrectly unmaps the original user
scatterlist:

    error_unmap_src:
        if (diff_dst)
            dma_unmap_sg(qce->dev, req->src, rctx->src_nents, dir_src);

For CCM requests with associated data, the dynamically constructed
scatterlist rctx->src_sg is mapped. Does unmapping req->src instead cause a
permanent DMA mapping leak and trigger IOMMU faults?

[Severity: High]
This is a pre-existing issue, but does this function incorrectly check the
return value of dma_map_sg()?

Earlier in this function:

    src_nents =3D dma_map_sg(qce->dev, rctx->src_sg, rctx->src_nents,
                           dir_src);
    if (src_nents < 0) {

dma_map_sg() returns 0 on failure, not a negative value. Will this bypass
the error check, pass a count of 0 to qce_dma_prep_sgs(), and eventually
lead to an invalid unmap?

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 26347e9fc078a..1b43c56503334 100644
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
> +
> +	dma_desc =3D dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, mapped, DMA=
_MEM_TO_DEV, attrs);
> +	if (!dma_desc) {
> +		ret =3D -ENOMEM;
> +		goto err_unmap_sg;
> +	}
> +
> +	qce_desc->dma_desc =3D dma_desc;
> +	cookie =3D dmaengine_submit(qce_desc->dma_desc);
> +
> +	ret =3D dma_submit_error(cookie);
> +	if (ret)
> +		goto err_unmap_sg;
> +
> +	return 0;
> +
> +err_unmap_sg:
> +	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
> +	return ret;
> +}

[Severity: Medium]
Is there a leaked DMA descriptor on this error path?

If dmaengine_desc_free(dma_desc) is ever used on error paths here (e.g., if
metadata attachment or submission fails):

    err_free_desc:
        dmaengine_desc_free(dma_desc);

Is it safe to call this? This API does not free non-reusable descriptors,
and returns -EPERM instead, leaving the descriptor permanently leaked in
the unsubmitted pool.

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

[Severity: Medium]
Will this cause endianness issues on big-endian platforms?

In qce_write_dma(), a native host-endian u32 value is passed by reference:

    qce_write_dma()
       unsigned int reg_addr =3D ...
       qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);

Here, the pointer is cast to __le32 * and dereferenced without using
cpu_to_le32(). Won't the BAM DMA hardware receive incorrectly byte-swapped
values?

[ ... ]
> @@ -98,28 +200,36 @@ int qce_dma_prep_sgs(struct qce_dma_data *dma, struc=
t scatterlist *rx_sg,
[ ... ]
>  int qce_dma_terminate_all(struct qce_dma_data *dma)
>  {
> +	struct qce_device *qce =3D container_of(dma, struct qce_device, dma);
> +	struct qce_bam_transaction *bam_txn =3D dma->bam_txn;
>  	int ret;
> =20
>  	ret =3D dmaengine_terminate_all(dma->rxchan);
> -	return ret ?: dmaengine_terminate_all(dma->txchan);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If dmaengine_terminate_all(dma->rxchan) returns an error, the function
returns immediately. Does this early return leak the DMA mappings for
bam_txn->wr_sgl and skip terminating the TX channel entirely?

> +
> +	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
> +
> +	return dmaengine_terminate_all(dma->txchan);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D13

