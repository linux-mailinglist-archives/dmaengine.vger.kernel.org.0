Return-Path: <dmaengine+bounces-10760-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOCHNOKQEGqIZgYAu9opvQ
	(envelope-from <dmaengine+bounces-10760-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 19:22:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E55B81C3
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5FCF3026A98
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4613537E5;
	Fri, 22 May 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ZkqXsZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14785351C25
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470136; cv=none; b=pjJPiM1Tuvs0L1ajNbBtNT/OiZo4VdDhHCFkWwnByPhvNi8Mca8KlT+/yCCIlnry2DF7B4YyLUEN0xy8Y8MHURtusavBJCbkmk68zhhAfdEh/NVCgARxNsLYniYxXzQluNRMxGHEdgXjtI3VX8UFYMMwyQQ9O+NCMzbLdWSSa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470136; c=relaxed/simple;
	bh=wa++zXBVQMs6+k1wALWS0TGyAQmSybgqpDZP1OhBmVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIW4W7Pje57XzYMvQ60Qo6TT/TTTgddtm06zbhiDhrNvEH/7wNQqCeahMhOZ7InKHSf9LX8Xno9psi+u+1mLxrlTluptQFPmPLmNbLJX13i3tbX7d+tYM6iyL0lS36xaI3t/k7R5wCK4mGb5Q1afnVAYMkQpzVG3DU8dNTRvZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ZkqXsZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05B51F000E9;
	Fri, 22 May 2026 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470135;
	bh=KXmbwdp5k/cLznDREF045u0nBMy/9AP1I2sdkLdR3Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7ZkqXsZqRxO5GJ71Ty4PjzCFyeXlxYGKPdeGhb1Lg+lMpIzU0xBWavIa+I+Yh5dm
	 mxIJQ/VSa0247777GACm43yBYGWvj6tbNfi0ZJceQ38MCWbAKiNnXmwP+5yZpANaKa
	 iBph3VvBzhIS0+DGLRQgti1iKlMmKfS7Gx81KQD9ei5NiQNpvPrXm9eRiM3BV/9Nym
	 Ui+fmbUEbHMqJtw2bOK5IWAyH3X8nuv6jwWte5r8YEI3OOKF1ASJGuHe9Kp6nlIJgM
	 RPzgse5CFl/kZH7QUMUxl7Y7Gua9t2bUkGRy3WCCS6xWq9StzhgIvI1hg8hdzK/Z+P
	 B8gjjXF54f9qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-11-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-11-99103926bafc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 17:15:34 +0000
Message-Id: <20260522171534.C05B51F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10760-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 2F8E55B81C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The asynchronous workqueue `done_work` is canceled after the DMA r=
esources (`txchan`, `rxchan`, `result_buf`) are released during driver unbi=
nd, leading to a Use-After-Free (UAF).
--

commit 9b35f36899d792c9a860c0ba48fbc33cb494e4e0
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Use existing devres APIs in devm_qce_dma_request()

This patch switches devm_qce_dma_request() to use devm_kmalloc() and
devm_dma_request_chan(). This removes the need for custom resource release
handling and shrinks the function.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index c29b0abe94453..3db46fc0c419a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -12,47 +12,26 @@
[ ... ]
>  int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma =3D &qce->dma;
>  	struct device *dev =3D qce->dev;
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
[ ... ]
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
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but could this devm transition expose a
use-after-free during driver unbind?

In qce_crypto_probe(), a devres action is added to cancel the done_work task
before devm_qce_dma_request() is called. Because the devres framework execu=
tes
cleanup actions in reverse order of registration (LIFO), during unbind or p=
robe
failure, devres will first free these managed DMA resources (result_buf,
txchan, and rxchan) before calling cancel_work_sync() for done_work.

If done_work is pending or executing when the device is unbound via sysfs,
qce_req_done_work() can call qce_handle_queue(), which dequeues backlog
requests and submits them using the already freed result_buf and released D=
MA
channels.

Would it be safer to register the devres action for qce_cancel_work after
the DMA resources are allocated to ensure safe cleanup ordering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-qcom-qce-c=
md-descr-v18-0-99103926bafc@oss.qualcomm.com?part=3D11

