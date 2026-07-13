Return-Path: <dmaengine+bounces-12394-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6wiGhDnVGpkgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12394-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:24:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6874B8A4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:24:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Sz2yh/vK";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12394-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12394-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8287F302F8A2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EA421896;
	Mon, 13 Jul 2026 13:16:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70492420E81
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:16:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948594; cv=none; b=JLFxblUmvvQv3cUz+oqK6Z9NgK90kZPMl6v0KPcJt9+a//CehP0i6Yzf+sd0OrD2v1Wx0Fqs7pBycmZGuswOFAeO4lNR7rAE/G1qS7xYeegf9ZwyFy+n6eumyvMwUiz3KhZsuOa2GpqV+Bo/WZEGEjoo4xpA3SfoQoOpfFBDmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948594; c=relaxed/simple;
	bh=J044Gtm8DcSYm8tYlUzkIMrj+EJZlvfG/vqrgrbzK/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUYhzcoS5212vuhLyyVgqgKbtQIxu19cyf3At6KzobnF+BqIK0aKu1WOEKwfcPyJq1FzV5jEOAQe9DeWAQ9AjDsUPZ0brKscdsR1PZT0XjUS8njYqhTg5ypQskg/S0Qdl7xD5R9GcX67wnDGpUMt1vu5su5k13Hx4VBKBK/e3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz2yh/vK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB9F1F00A3A;
	Mon, 13 Jul 2026 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948593;
	bh=LRjzYM1cX1ClXE/Dabt0y9RHfE/ZrArFEr0LssL6CsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sz2yh/vKrDe4Jv6VVx5ItQcFucnRmbtWWAJaa2W5FzEyG9f0GLojkZh7hwjzIkT5X
	 0z5rCBS6xMlOLmSKelHSQmOC8WBkKi/BQ9aZlBs32SlGwRwk6OPKsx6JS4jKj8wyyX
	 cZSVGeaTaGHe+ZbWvXll7r5T9aOCgJGl1gF0/qfDxd0QmLWVzaC7bJCmVooyuOHVzW
	 uwbKYecBpBa7h5bMWpiWT6HxjyjD1Fh6hvaPKBr9f50JlEfo0yXahlv8sLCV0s3v6J
	 L1h2CGyzi7cVO8S9lgXvEnbJgrF8qaNrCkvE06biSnNC1kF9ChAdWjGBdE6nRFLYX0
	 pzt0Ees9eUHLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-11-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-11-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:16:32 +0000
Message-Id: <20260713131632.DFB9F1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12394-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8F6874B8A4

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The crypto request workqueue can execute after DMA channels and th=
e result buffer have been freed, leading to a Use-After-Free during device =
unbind or probe failure.
--

--- Patch [11]: [PATCH v21 11/14] crypto: qce - Use existing devres APIs in=
 devm_qce_dma_request() ---
commit ae30a428f07757ca3220181d917faca67619bbbd
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Use existing devres APIs in devm_qce_dma_request()

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index d60efb5c26d88..26347e9fc078a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
[ ... ]
> @@ -12,49 +12,34 @@
> =20
>  #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
> =20
> -static void qce_dma_release(void *data)
> +static void qce_dma_terminate(void *data)
>  {
>  	struct qce_dma_data *dma =3D data;
> =20
>  	dmaengine_terminate_sync(dma->txchan);
>  	dmaengine_terminate_sync(dma->rxchan);
> -	dma_release_channel(dma->txchan);
> -	dma_release_channel(dma->rxchan);
> -	kfree(dma->result_buf);
>  }
> =20
>  int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma =3D &qce->dma;
>  	struct device *dev =3D qce->dev;
> -	int ret;
> =20
> -	dma->txchan =3D dma_request_chan(dev, "tx");
> +	dma->result_buf =3D devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BU=
F_SZ, GFP_KERNEL);
> +	if (!dma->result_buf)
> +		return -ENOMEM;
> +
> +	dma->txchan =3D devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->txchan))
>  		return dev_err_probe(dev, PTR_ERR(dma->txchan),
>  				     "Failed to get TX DMA channel\n");
> =20
> -	dma->rxchan =3D dma_request_chan(dev, "rx");
> -	if (IS_ERR(dma->rxchan)) {
> -		ret =3D dev_err_probe(dev, PTR_ERR(dma->rxchan),
> -				    "Failed to get RX DMA channel\n");
> -		goto error_rx;
> -	}
> -
> -	dma->result_buf =3D kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
> -				  GFP_KERNEL);
> -	if (!dma->result_buf) {
> -		ret =3D -ENOMEM;
> -		goto error_nomem;
> -	}
> -
> -	return devm_add_action_or_reset(dev, qce_dma_release, dma);
> +	dma->rxchan =3D devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(dma->rxchan))
> +		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
> +				     "Failed to get RX DMA channel\n");
> =20
> -error_nomem:
> -	dma_release_channel(dma->rxchan);
> -error_rx:
> -	dma_release_channel(dma->txchan);
> -	return ret;
> +	return devm_add_action_or_reset(dev, qce_dma_terminate, dma);

[Severity: High]
This is a pre-existing issue, but does this devres registration order leave=
 a
use-after-free window during device unbind or probe failure?

In qce_crypto_probe() in drivers/crypto/qce/core.c, qce_cancel_work is
registered before calling devm_qce_dma_request():

	INIT_WORK(&qce->done_work, qce_req_done_work);
	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
	if (ret)
		return ret;

	ret =3D devm_qce_dma_request(qce);

Because devres actions execute in reverse order of registration, during unb=
ind
the DMA resources and result_buf registered here in devm_qce_dma_request()
will be freed first. Then, qce_cancel_work() will finally be executed to ca=
ncel
the workqueue.

If a crypto request completes and schedules qce->done_work just before or
during teardown, could the worker execute concurrently and access the alrea=
dy
freed DMA channels and result_buf inside qce_handle_queue()?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D11

