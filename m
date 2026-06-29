Return-Path: <dmaengine+bounces-11859-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P7t0OjNGQmr03QkAu9opvQ
	(envelope-from <dmaengine+bounces-11859-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:17:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C986D8CA2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:17:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bXdxQM5U;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11859-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11859-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD58A300CDA4
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250533FAE08;
	Mon, 29 Jun 2026 10:17:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F53E5EC4
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:17:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728239; cv=none; b=IpfXvTKXonIsPF1kY1dxOnl2vYVnUBRFoSNGBBZDnL3+uBasJAQA03TFEYwYL2n3C/GndEM+M5jXsX0V3/pWSI3QHVzPagkUFQ/RLSb+3o8AHf94JNnisvezpen1q2W5QyU6HCPztc0yHgYfe+P+TNSwsdb2ksHFNH5CWG31V70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728239; c=relaxed/simple;
	bh=4YFFve/8GRpMXwLaSavRv23jSSWlmBwSJtiN0yr/Lcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sat4CHR70mFlf1MX14CSD4/aaIRIsO5jQLTNsEFyq/iJ2NCXm48Z/NFw7CRoVrhaSVkB6Gg9inKp/+Wi21jOgsqH2oHThUjuknA0VJxWlmVbCeROXiPH5maXemNnIHRuMnVAY+RKN51k+5g33aqqCTynQc7eilDDQ6xMkw2rMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXdxQM5U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A721F000E9;
	Mon, 29 Jun 2026 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728238;
	bh=g2zZJLw8QOXEZSr2d1hYQj/iDtQoSY6cQTKo/cXDu6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXdxQM5UWk8iApFvANwZrp7KJ+Cv+kB5rOQfWu0mRdtt/jkR+sg9ChiTGmA9fPkd4
	 hUIwnJdNrgpgt+9/bXm7fpLia/emiDRQuEvNIC/iYThvfoIEiq+C502ABQfFCjfMgD
	 v4gAIPcWAzpINV8ghRbZ/TyNlJH8B5bHqDmLUfysOnwvnPcRk+/SLxZHwbEwh9kol+
	 OQVE46LMaaggw7DjIN/D2mxNzoujVsAOASORmic6Xk247IcmPRYyPBm/u+qyWYb16y
	 wz2Ui/WzSGTge1ZkvUnWK/uDTeDqjAeSvhkxrroOmB2CgNFGz9j965SWJFXKv+l2TY
	 Uyf/KUntp+BVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-11-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-11-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:17:17 +0000
Message-Id: <20260629101718.38A721F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11859-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74C986D8CA2

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Commit message references a non-existent API function.

Pre-existing issues:
- [High] The devres unwinding order frees the DMA channels and result buffe=
r BEFORE the background workqueue is explicitly canceled, creating a Use-Af=
ter-Free window.
--

commit f6e312d1a680b31426e3cdbbdcdf493a9628353f
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Use existing devres APIs in devm_qce_dma_request()

Switch to devm_kmalloc() and devm_dma_alloc_chan() in devm_qce_dma_request()
to simplify the function and drop error labels.

>     Switch to devm_kmalloc() and devm_dma_alloc_chan() in
>     devm_qce_dma_request(). This allows us to drop two labels and shrink =
the
>     function.

[Severity: Low]
This isn't a bug, but the commit message references devm_dma_alloc_chan()
instead of the actually used devm_dma_request_chan().

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index d60efb5c26d88..26347e9fc078a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
[ ... ]
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
>  }

[Severity: High]
This is a pre-existing issue, but does the devres unwinding order here
create a window for a use-after-free?

In qce_crypto_probe(), qce_cancel_work is registered before the DMA=20
resources are requested:

drivers/crypto/qce/core.c:qce_crypto_probe() {
    ...
    INIT_WORK(&qce->done_work, qce_req_done_work);
    ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
    if (ret)
        return ret;

    ret =3D devm_qce_dma_request(qce);
    ...
}

Since devres actions are unwound in reverse order of registration (LIFO),
during unbind or late probe failure, the DMA termination registered here
will execute first. This frees txchan, rxchan, and result_buf.

Only after the DMA resources are freed does the unwinding sequence call
cancel_work_sync() for the done_work. If the background workqueue
qce_req_done_work() is already running or scheduled, could it process
subsequent crypto requests by calling qce_handle_queue() and accessing the
now-freed DMA channels and buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D11

