Return-Path: <dmaengine+bounces-12398-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X2UWJpHqVGp/hAAAu9opvQ
	(envelope-from <dmaengine+bounces-12398-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:39:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B865474BB8F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EFIvqB4H;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12398-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12398-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C26130C6745
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FE431E79;
	Mon, 13 Jul 2026 13:22:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF442431E6C
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:22:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948977; cv=none; b=dHEhcPi7puKVfK9MTw3c65RoF1HVGSxkUrFroN8Qv9VIPI/63lbVRlbgBrMfSMl2HUUDAjlzLDl+W1BSZ0UEm0p6mcYVeYjNvFFszrCbqRfR2Bzo6fY1JC7aFZJ3hAh73OB3VAEfo/bwbbIQEXuuH0KRk/qSlYPWi2zTI7DWRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948977; c=relaxed/simple;
	bh=wK2GDlJ3TmlsWgf8zswbChSVLzb1TiAL/6smIYAPgLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ua7OHBWOOQ0xWd4h/JiZX12Tc7SoJeDYJXFmidlg2ceqV4XlBEABlDi2FLj1z8fN5ZuWtcRnRTaNIpxKxo8uO//9Tmt1EJzZY+n87byJCfcnaKduFCU8adCKKcOMSs90hTAzglnSMRI8nH5+dOCyDUPc+WfOgVaNlZFxx1bNP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFIvqB4H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7E81F000E9;
	Mon, 13 Jul 2026 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948974;
	bh=Ky4vw5vosxIvQTWpm0rRkOHsW9ECxL7Y7hus0AtshW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFIvqB4HcygtDZ/cd2CHgt/f6KaJpguToGjM3Qo9dpzV8fpXEvNf13IJDgaG7HqcM
	 0T65g0Qy8aCbT2Jp+dLubLMplzQ5iur9daUR3OUevz/2sU69SjtCTF7RnkpCqxH44g
	 HncXVLk8TEO0igiAlCOc6cr0YCxYT5Mq1lhUGnrfEjU9zgUs4etMFLFJmxwv20zZZl
	 oXaar7dNdfebO5Hxe3TEWoikIIQ2nBLfY9/fc/d64zQ33/svsS1je/ZlJq4Zvfd2ok
	 ug15gbP1V1LVk8SwPcD4Its7YMqt2f7IN+uN/16arTEadTLZ+HjNcSVftqybRwC7gl
	 nibhY1W4mgQrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 12/14] crypto: qce - Map crypto memory for DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-12-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-12-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:22:53 +0000
Message-Id: <20260713132253.BF7E81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12398-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B865474BB8F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Devres teardown ordering leads to Use-After-Free of DMA channels.
--

--- Patch [12]: [PATCH v21 12/14] crypto: qce - Map crypto memory for DMA -=
--
commit b1c15310873afc3b915460ae4afcab5b35bb8ea3
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Map crypto memory for DMA

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index aa4a0b1774908..4031b4516d651 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -254,6 +263,18 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	qce->async_req_enqueue =3D qce_async_request_enqueue;
>  	qce->async_req_done =3D qce_async_request_done;
> =20
> +	qce->dma_size =3D resource_size(res);
> +	qce->base_dma =3D dma_map_resource(dev, res->start, qce->dma_size,
> +					 DMA_BIDIRECTIONAL, 0);
> +	qce->base_phys =3D res->start;
> +	ret =3D dma_mapping_error(dev, qce->base_dma);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
This is a pre-existing issue, but looking at qce_crypto_probe() earlier in
the function, could devres teardown ordering lead to a use-after-free of
the DMA channels?

Currently, workqueue cancellation is registered before the DMA channels are
requested:

drivers/crypto/qce/core.c:qce_crypto_probe() {
    ...
	INIT_WORK(&qce->done_work, qce_req_done_work);
	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
	if (ret)
		return ret;

	ret =3D devm_qce_dma_request(qce);
	if (ret)
		return ret;
    ...
}

Because devres actions execute in LIFO order during device unbind or late
probe failure, the devm-managed DMA channels will be freed before
qce_cancel_work() runs.

If done_work is scheduled but executes during or after the DMA channels are
freed, it will dequeue the next request and attempt to map and submit it
using the now-freed txchan and rxchan.

Should the workqueue cancellation be registered after the DMA channels are
requested to ensure any pending work is stopped before the channels are
released?

>  	return devm_qce_register_algs(qce);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D12

