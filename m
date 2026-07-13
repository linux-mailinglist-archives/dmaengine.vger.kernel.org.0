Return-Path: <dmaengine+bounces-12400-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PEJfMuTqVGqdhAAAu9opvQ
	(envelope-from <dmaengine+bounces-12400-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:40:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACB74BBD9
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:40:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kwVv4v8Q;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12400-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12400-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AE3D306A519
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DC371878;
	Mon, 13 Jul 2026 13:26:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF042B751
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:26:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949164; cv=none; b=bEADplGZCcq7U2uu+p9IfRLr+CtYokwDv/nY1YKZIjBfG/irbVRFZO7nNYkhW+6A48B109xghlGBSs6QpUGejxC+yjg+VW9IB/OtdHkPjY0X8t8D5cnDCX/J2MoOOl9IHRtpb0j9ZL4+7RpGrqdK0nTv54I195z6oZ74CjgR710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949164; c=relaxed/simple;
	bh=whT+Hi+mQTPBY8EYLvyFeA+eZBpfkrcDE7LwlDmz6JY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pl0by9npSoM+wMnVoR4sanNJo41hU73l9ObdpsT+gk4PwXExVyGVM08kTbZc4Z8Rl0qsmpVBfVj28UEueFa+pSK3DAluzsx6EG5sVuJQt7X7n10FcvSdlAICX+Pqr33gdo+emu+Vt8Y1JTYmiZzXuQeS5am7ICsuVSI+EkK+fFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwVv4v8Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5BA1F00A3A;
	Mon, 13 Jul 2026 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949163;
	bh=hi69OsUymGEUG/2XBugwgybhIkUOTFVQUUnxCd6O3UA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwVv4v8QfUgUo35ADVnCoMro6PHVC2hbOKWsJ8pydgfc6UEVT/tlsJnZqn7wR+4nH
	 8priYei4BIeNIeFZRcGRvOVPM93fNlqcgqiJ8Nro+1i7UiQh0XLzlJlQVVSneiyCzu
	 BM4Lyqaa5WPFRSy5f3S9PUarNw+WXAit3cuMxT7qq79IddnviMUD+pJ/ekSQ+PO/Fb
	 wxraZZR+hTeGIqzqN9gpUmQ0rPY6JjcBNpg6uE8yTp509f4fPYnb8KhfGTOuE+wgu8
	 guVlCyQYgrAEm5P4w1HNMz3uGDFF+5mIbUXpW8MScudBndR223PrM0F1oExol9BESi
	 chpdpWHo0wrzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-14-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-14-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:26:02 +0000
Message-Id: <20260713132602.DA5BA1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12400-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,qualcomm.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0ACB74BBD9

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error path in `qce_submit_cmd_desc()` attempts to free a non=
-reusable DMA descriptor using `dmaengine_desc_free()`, which will fail and=
 leak the descriptor.
--

--- Patch [14]: [PATCH v21 14/14] crypto: qce - Communicate the base physic=
al address to the dmaengine ---
commit abb736f89a48907c45dba4ccf37ffa56752bda22
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Communicate the base physical address to the dmaengine

This commit attaches metadata containing the scratchpad address and directi=
on
to the BAM DMA descriptor. It also adds an error handling path to free the
descriptor if metadata attachment or submission fails.

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
Does this error path leak the DMA descriptor?

Looking at dmaengine_desc_free() in include/linux/dmaengine.h, it checks if
the descriptor is reusable and returns -EPERM if it is not:

static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
{
        if (!dmaengine_desc_test_reuse(desc))
                return -EPERM;

        return desc->desc_free(desc);
}

Since the descriptor allocated earlier in qce_submit_cmd_desc() by
dmaengine_prep_slave_sg() is a standard descriptor and not marked as
reusable, it appears dmaengine_desc_free() will fail without actually
freeing the memory if either dmaengine_desc_attach_metadata() or
dma_submit_error() triggers the goto.

Is there a different method intended for cleaning up non-reusable
descriptors in this error path, or should the descriptor be allowed to
complete with a failure instead?

>  err_unmap_sg:
>  	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEV=
ICE);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D14

