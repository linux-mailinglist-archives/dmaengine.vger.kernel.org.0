Return-Path: <dmaengine+bounces-11864-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2XMvHAJIQmo23wkAu9opvQ
	(envelope-from <dmaengine+bounces-11864-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:25:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DEF6D8DFF
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m1XXQFHG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11864-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11864-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DCB30138BA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B283B2FD4;
	Mon, 29 Jun 2026 10:25:02 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5933B961
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:25:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728701; cv=none; b=SwI4Xe7f4N4t2futfwxu9UZlCPmUV2btCw8OgVzdEPaCSIvhl4fPO8Mbc4Mrfx2eq953FZ4dT1c8Q7K12lkI1HJFbvAkB+A8geTov8deGRKvn3eRc9a3+8tPLwPcOzNFrkTaKFnNbRJ891IVTE9d208/EhFXTFZ+reaISmGJi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728701; c=relaxed/simple;
	bh=4aFCWE2pY7u8sT95TVO1lciPw7cFZX0Jx2eNnxM00lA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZW7GIbZ/ZgvUMnHohV9C6FWoB1QTjBUl2vCMRjTP/CWyoMdA8heiT0GqUXuUblKrXhq30qswsFxn4HvdTZ/MXgkAxBfxPE8KdrDbiGk9bklXTEytg9M6fhPdga/mUQbiQ4HvSy+NAqFs5fXrMZLte6U3NSgJ4Yabk/b1pOvSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1XXQFHG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377A1F000E9;
	Mon, 29 Jun 2026 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728700;
	bh=cY6xGBFvVZ2GxJXZuWFItHK9B9hNq1J7LXTamM2V2uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1XXQFHGfneONKx/sBKAuhviRhdCTNmjcKS6KQRrsZAeGZrsRjZ05Dl8eyBoT5DxS
	 aC9o09ks7ZC4p8cVYWWbavsJH+ni3SQcO9x3u+4m+pi52AqXjYiBleGaC++RK1DS+e
	 R04iaQy1uqcg7xX4i2T+DOQX0/NWQ3mzHmkmLgk5HoC3J72R+O5oErqpxk9xTPT1JZ
	 09w7iho/gliKFDqTUj8y40xUEaW8xm/y7OTapeB9uSJzT6xL6jQeQi3CCPU29sr3+j
	 9PzSd96iCh24d+lTRQkDNsa3T0btcCRoI+z46WF1zCwm0VAkCr/qjiHwjtyTqTwoWr
	 HeF7gJfskiiJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-14-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-14-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:24:59 +0000
Message-Id: <20260629102500.6377A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11864-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5DEF6D8DFF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Ineffective descriptor cleanup on error paths leads to a memory =
leak because `dmaengine_desc_free()` is called on a non-reusable descriptor.
--

commit 7c11f5b2471b4e0caed5825bea7adc1ce06d76de
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Communicate the base physical address to the dmaengine

This commit attaches metadata containing the base physical address to the
DMA descriptor for the BAM DMA engine. It also adds error handling paths
to free the descriptor and unmap the scatterlist if the metadata attachment
or the DMA submission fails.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 1b43c56503334..6410f8dc5bcf5 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c

[ ... ]

> @@ -60,15 +65,21 @@ int qce_submit_cmd_desc(struct qce_device *qce)
>  		goto err_unmap_sg;
>  	}
> =20
> +	ret =3D dmaengine_desc_attach_metadata(dma_desc, &meta, sizeof(meta));
> +	if (ret)
> +		goto err_free_desc;
> +
>  	qce_desc->dma_desc =3D dma_desc;
>  	cookie =3D dmaengine_submit(qce_desc->dma_desc);
> =20
>  	ret =3D dma_submit_error(cookie);
>  	if (ret)
> -		goto err_unmap_sg;
> +		goto err_free_desc;
> =20
>  	return 0;
> =20
> +err_free_desc:
> +	dmaengine_desc_free(dma_desc);

[Severity: Medium]
Does this error path successfully free the descriptor?

Earlier in qce_submit_cmd_desc(), the descriptor attributes are defined
without the reuse flag:

    unsigned long attrs =3D DMA_PREP_CMD;
    ...
    dma_desc =3D dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, mapped,
                                       DMA_MEM_TO_DEV, attrs);

Since the descriptor is not prepared with the DMA_CTRL_REUSE flag,=20
dmaengine_desc_free() will return an error instead of freeing the memory:

include/linux/dmaengine.h:dmaengine_desc_free() {
	/* this is supported for reusable desc, so check that */
	if (!dmaengine_desc_test_reuse(desc))
		return -EPERM;

	return desc->desc_free(desc);
}

Could this cause a memory leak of the DMA descriptor if=20
dmaengine_desc_attach_metadata() fails or dma_submit_error() returns an err=
or?

>  err_unmap_sg:
>  	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D14

