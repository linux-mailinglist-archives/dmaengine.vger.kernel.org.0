Return-Path: <dmaengine+bounces-10962-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PBqOqXVFWrRcgcAu9opvQ
	(envelope-from <dmaengine+bounces-10962-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 19:17:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C345DA7D3
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9C123024E0B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572B409DFD;
	Tue, 26 May 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exjk45Mh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0C405C38
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815630; cv=none; b=iTSGPnzzY3GmYTaReUEWS1bgjl/ltVnI8G5wYYFMitq6tfH+EAhO/zsgjmF1xNIZxcFC9DenMngrj4RDpW3AmxgHcxc8qqJ/jabTAgSl5M7+1ZB39P5RNoI67T6R7hBV/b2/ZOOb+5qb1yuc2nUUp3mQc1/B2MGtNlNbg+FB8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815630; c=relaxed/simple;
	bh=4CJkVEpbiuu61eJc5HPCTthPPbYrl92clevkgw+xZHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5r+aQIMxeIBSTy9Kic4lNWLoTEnDeRePxV/5RmPhltb4oo7UBvahiDuuJBIGqWAlEo7pnBGjV0Bu7CtTLdv56x5Re0S2YIEAFgrv036DLgNl+pTAPPYLyLi7BIhUZijpIkQvUID77MzLEtO9O1rMXaHz3LgQHVLz5NePBAYxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exjk45Mh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242AA1F00A3F;
	Tue, 26 May 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815623;
	bh=fAGpii1CR2UpwAELobhC3fbzwYUbxHE0eebCzM/Ki/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exjk45MhnrH0OkjILdRiooPvDOBWp8T15NfEn6PGcRH7q90mmhlO3P+d032IpnqCT
	 JSwuOaFo+mKWzUGsMGGESuV4nN9PKolML+ulMVXWZnT1qL9dq9NcN9OofFllweCDgZ
	 I1aYnMg5+gvu9twG+NY8pzqCMCfLcC7NmzwPmEbiDJds/sE+vt4U6R4QTWUEIR7AEM
	 MJMnwSXHwjV7yWnSG6kSFzcdORpGfPIGyF8nNqMLRqAXyFM9pAhxMGD6ZXeMDRdAqv
	 Wb8oU19dvBhL1j2njouSBeQv+wxMARgTqgwKCpXP9enurhKm6Xqg20IeT5NvItosxS
	 4tIWqd/DOcfXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/14] crypto: qce - Add BAM DMA support for crypto
 register I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-13-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-13-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:13:42 +0000
Message-Id: <20260526171343.242AA1F00A3F@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10962-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 92C345DA7D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Host-endian register values are written directly to BAM DMA comman=
d descriptors without byte-swapping, breaking register writes on big-endian=
 architectures.
- [Medium] Early return on error in `qce_dma_terminate_all()` leaks a DMA m=
apping and leaves the TX DMA channel running.

Pre-existing issues:
- [High] `qce_dma_terminate` explicitly frees devres-managed resources, cau=
sing double-frees and kernel panics.
--

commit 9259099a81bab443e790b41fd7e4fc53cf2bad0a
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Add BAM DMA support for crypto register I/O

This patch switches the driver to use BAM DMA for register I/O in addition
to passing data. It provides the necessary infrastructure to queue DMA comm=
and
descriptors and replaces direct register writes with DMA write wrappers.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index c2602d35baa6a..769cc71da9007 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -11,6 +13,96 @@

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

[Severity: High]
Does this cast to __le32 correctly handle endianness on big-endian
architectures?

Since buf points to a host-endian u32 passed from qce_write_dma(), casting
it directly bypasses byte-swapping. The prior writel() mechanism
automatically handled endianness conversion.

Could this result in reverse byte order being written to the BAM command
element on big-endian platforms?

[ ... ]

> @@ -42,6 +134,16 @@ int devm_qce_dma_request(struct qce_device *qce)
>  		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
>  				     "Failed to get RX DMA channel\n");
> =20
> +	dma->bam_txn =3D devm_kzalloc(dev, sizeof(*dma->bam_txn), GFP_KERNEL);
> +	if (!dma->bam_txn)
> +		return -ENOMEM;
> +
> +	dma->bam_txn->desc =3D devm_kzalloc(dev, sizeof(*dma->bam_txn->desc), G=
FP_KERNEL);
> +	if (!dma->bam_txn->desc)
> +		return -ENOMEM;
> +
> +	sg_init_table(dma->bam_txn->wr_sgl, QCE_BAM_CMD_SGL_SIZE);
> +
>  	return devm_add_action_or_reset(dev, qce_dma_terminate, dma);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at the
qce_dma_terminate callback that is being registered here:

static void qce_dma_terminate(void *data)
{
        ...
        dma_release_channel(dma->txchan);
        dma_release_channel(dma->rxchan);
        kfree(dma->result_buf);
}

Does explicitly freeing devres-managed resources here cause a double-free?

Passing a devres-managed pointer to kfree() can cause an immediate slab
allocator panic because it points past the internal devres header.
Additionally, manually releasing devm DMA channels will result in a
double-free when the kernel later cleans up the devres resources.

[ ... ]

> @@ -101,28 +203,36 @@ int qce_dma_prep_sgs(struct qce_dma_data *dma, stru=
ct scatterlist *rx_sg,

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
> +
> +	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
> +
> +	return dmaengine_terminate_all(dma->txchan);
>  }

[Severity: Medium]
If dmaengine_terminate_all(dma->rxchan) returns an error, does this early
return leak the DMA mapping for bam_txn->wr_sgl?

It appears that bypassing the rest of the teardown sequence will leave the
mapping unfreed and potentially leave the TX DMA channel running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D13

