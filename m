Return-Path: <dmaengine+bounces-11863-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7KkAE4dHQmri3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11863-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:23:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC96D8DA9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KpKfOVog;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11863-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11863-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EF87300B872
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AE3E2AD2;
	Mon, 29 Jun 2026 10:22:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4DB38F947
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:22:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728552; cv=none; b=F517lSPv1chAmyZaS3laLzL5RBxiLg6p0tfq441r02ATwgo+LLfXHz9ULIs07FndoRfVyf+aHZcGQf+JZxnT53xhvhdbCm9rkL2K5koAs3y8XdDT2eE4q/4bMpGsmYWah8VRcpATPdZh75GT6OK+Hef6frC5rXMMLWbsKFrAsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728552; c=relaxed/simple;
	bh=+Tf7HocFEpsSkY8gr6HLBQRhVD1ezieeq3V3CoaMohY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RlTPm5VAfTRWSFl9I4y47+FeXvtNxZVRqAjrnZm94+eBZ+1n9TSvxw5zsPdd2RCkOwZqr7ZGXMSKP8Ct9ywTmdiYwRCeehBCBcp3SU1L+moIUKf4fyrE4qsS7kQyCeH70nC0YRC5990AB+xDbAu+6teaBEAyZt/u/IqHdKDPYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpKfOVog; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C7F1F000E9;
	Mon, 29 Jun 2026 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728551;
	bh=td1serWI2vGx2LtmCh8cfwurzEmXr8gyufiwNdZnKzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpKfOVogt8nmreaL2D3kB04e6UcK8/BOKcvYtNOBM/KvvDZ/zrrMquH70hcd8JbfS
	 GNt64E9qb7scjyj5j6pWto7R8dZEGhU0sVUe3g4/MCLqzl2c6uUvO7uAdG5WbSOY/P
	 2mBOgs82SPM+rz4v5LasbGlWu4cZsCg1kXbQ78FOoWbhmZPkpzv4LKnBlAebpgZvzV
	 w2LqFzvZ0txVQmq3f4MsgiPZUOySQrP3rCVlIQ6OpA8QwHMj/qEgcKNLExtSHrZM0c
	 GOnCk8v2ixWVVInNfSEMP8Ot6jPzCpApMfrP0KhOHakyQF3DQ+y2s8LZQ97XWUS9Vf
	 u4LZjFQKf38Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 13/14] crypto: qce - Add BAM DMA support for crypto
 register I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-13-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-13-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:22:30 +0000
Message-Id: <20260629102230.E5C7F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11863-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3AC96D8DA9

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Incorrect endianness conversion for BAM DMA register writes on big=
-endian architectures.
- [Medium] DMA descriptor leak in qce_submit_cmd_desc() on error paths.

Pre-existing issues:
- [High] Memory allocated for rctx->adata is never freed.
- [High] Incorrect dma_map_sg failure check for src_sg ignores mapping erro=
rs.
--

commit bf3a155521eb3078dcc0111460444f36ebb69ebf
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Add BAM DMA support for crypto register I/O

Switch to using BAM DMA for register I/O in addition to passing data. To
that end: provide the necessary infrastructure in the driver, modify the
ordering of operations as required and replace all direct register writes
with wrappers queueing DMA command descriptors.

> diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
> --- a/drivers/crypto/qce/aead.c
> +++ b/drivers/crypto/qce/aead.c
> @@ -463,17 +463,17 @@ qce_aead_async_req_handle(struct crypto_async_reque=
st *async_req)

[Severity: High]
This is a pre-existing issue, but does this code leak the rctx->adata buffer
allocated for AES-CCM operations? It looks like if memory is dynamically
allocated for rctx->adata via kzalloc() during CCM processing, it is never
freed in either the success completion path or error handling paths of
qce_aead_async_req_handle(), which could lead to memory exhaustion when
processing untrusted network traffic.

[Severity: High]
This is also a pre-existing issue, but does the error check for dma_map_sg()
earlier in qce_aead_async_req_handle() correctly handle mapping failures?
dma_map_sg() returns 0 on error, not a negative value. The check for
(src_nents < 0) evaluates to false, which means a mapping failure could be
ignored, causing the driver to proceed and later call dma_unmap_sg() with
invalid parameters.

[ ... ]

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> +int qce_submit_cmd_desc(struct qce_device *qce)
> +{
[ ... ]
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
Does this error path leak the unsubmitted DMA descriptor? If the DMA
submission fails and we go to err_unmap_sg, the rollback bypasses
qce_dma_terminate_all() or any mechanism to flush the descriptor. Since the
DMA_CTRL_REUSE flag was not passed during preparation, attempting to explic=
itly
free it later will return an error without freeing the descriptor.

[ ... ]

> +static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma=
_data *dma,
> +				  unsigned int addr, void *buf)
> +{
[ ... ]
> +	idx =3D bam_txn->bam_ce_idx;
> +	bam_ce_buf =3D &bam_txn->bam_ce[idx];
> +	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));
[ ... ]
> +void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
> +{
> +	unsigned int reg_addr =3D ((unsigned int)(qce->base_phys) + offset);
> +
> +	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
> +}

[Severity: High]
Is there an endianness mismatch here on big-endian architectures?
In qce_write_dma(), a CPU-endian u32 stack address is passed to
qce_prep_dma_cmd_desc(). That function then casts the pointer to __le32* and
reads it directly into the BAM descriptor without byte swapping. Will this
result in reversed bytes being written to the crypto hardware registers on
big-endian CPUs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D13

