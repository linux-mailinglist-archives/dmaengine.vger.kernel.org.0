Return-Path: <dmaengine+bounces-10958-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE5dJQnJFWqMbAcAu9opvQ
	(envelope-from <dmaengine+bounces-10958-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:23:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A75D999A
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA09303EC02
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C1316189;
	Tue, 26 May 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8TvOBuy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E812364942
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809637; cv=none; b=K3u3Bcx071z2AByJZhSn14vO3pQZGRjNtd/MXrGyq0XhgkuG8V/5FZYx/xNoKepgjLaOnK/Jk6C6/8jKU0nlqlIR4L09YIkglgwowXkpW8Y3IwFPk/QwzswA8/LQThTQ0BiTxA8oEH3gdbNj4hh8+x0kyvvX4ChR7AgtV5PkbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809637; c=relaxed/simple;
	bh=B6v00+VSDpO1wrOX78Y1oly1ZK0pnY7KV4pHHNipg5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNhTcuUA9qBq34HC8ZgWG4e6aAbw3x1+qG1Xt6z64LagG/KTK2kzomXmJfrBPzuwX+ISqzNX6erfCal3VJtukwfkb/4onhT+euiKX55ezgtfLWAEjGeDNUNuJHYacZKnIe4YfNrNn7K1c69jLFdB81JAaEnAs68rkJVCzyfTxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8TvOBuy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FDF1F000E9;
	Tue, 26 May 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809635;
	bh=FG8tlv0RudPIgzKcFFaLyf3kZqHmHPZ3FBLdXR/G+rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8TvOBuygmCvThHTbBkiWheCoxMmwBN4eKQPcFmYUAF4/c+oyINAD/wpcsCLmGTv4
	 eYGDwc3nKXBoHBClcjKil4xnsLWK3ezhJw4j1bNL7aNsJRa7RXmZ0UU+nhKc+iUiki
	 8rwYmMq2c40w4mBc9vKJVAVDPf3KPN0Ow2X4NMjFVbS5vn/HHH1gQSPLfHql5FiVJX
	 YKQTQvkoiMJm1KbyuMEo9FkjvKX5mHI8ogfaseOQjH6rA8Ne90gVDIX9YYItiuoO9N
	 Q7p/zDg//2GC9bZ+UM7MfcLAzOQKL0EVd+lXyQkHD2b920GORZ+pgerw70dYFHcJzm
	 /i+uF+Dm0e9zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/14] crypto: qce - Cancel work on device detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-7-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-7-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:33:55 +0000
Message-Id: <20260526153355.63FDF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10958-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE7A75D999A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a devres action to cancel the workqueue but r=
egisters it before DMA request and mutex initialization, causing a teardown=
 order that leads to Use-After-Free and locking of a destroyed mutex.

Pre-existing issues:
- [High] Synchronous freeing of `qce_alg_template` in algorithm unregistrat=
ion functions can lead to a Use-After-Free if active Transform (tfm) instan=
ces are still in use.
--

commit 346a6daf560fef47a46685921528f09b6a107436
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Cancel work on device detach

This commit introduces a devres action to cancel the done_work workqueue
during device detach or probe error. It moves the workqueue initialization
earlier in the probe sequence to ensure it is cancelled after outstanding
DMA transfers are terminated. Additionally, it ensures all transfers are
explicitly terminated in the DMA release action.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D7

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index b966f3365b7de..f671946cf7351 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c

[ ... ]

> @@ -227,6 +234,11 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> +	INIT_WORK(&qce->done_work, qce_req_done_work);
> +	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_qce_dma_request(qce->dev, &qce->dma);
>  	if (ret)
>  		return ret;

[Severity: High]
Does registering the work cancellation before DMA and mutex initialization
introduce a teardown order issue?

Devres actions execute in reverse order of registration (LIFO). During driv=
er
unbind or probe failure, the cleanup sequence would be:

1. Mutex is destroyed (via devm_mutex_init cleanup)
2. qce_dma_release() executes, releasing DMA channels and freeing
   dma->result_buf
3. qce_cancel_work() synchronously cancels the workqueue

If the work item (qce_req_done_work) is scheduled before the workqueue is
cancelled, could it execute concurrently with or after the mutex and DMA
cleanups?

When the work runs, it might attempt to lock the destroyed qce->lock and
dequeue the next crypto request using the freed dma->result_buf, which
could lead to a use-after-free.

> @@ -239,7 +251,6 @@ static int qce_crypto_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		return ret;
> =20
> -	INIT_WORK(&qce->done_work, qce_req_done_work);
>  	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
> =20
>  	qce->async_req_enqueue =3D qce_async_request_enqueue;

[ ... ]

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 68cafd4741ad3..7ec9d72fd690f 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -13,6 +13,8 @@ static void qce_dma_release(void *data)
>  {
>  	struct qce_dma_data *dma =3D data;
> =20
> +	dmaengine_terminate_sync(dma->txchan);
> +	dmaengine_terminate_sync(dma->rxchan);
>  	dma_release_channel(dma->txchan);
>  	dma_release_channel(dma->rxchan);
>  	kfree(dma->result_buf);

[Severity: High]
This is a pre-existing issue, but is it safe to synchronously free the
algorithm templates during unregistration?

In unregistration paths like qce_skcipher_unregister(), the driver calls
crypto_unregister_skcipher() and immediately calls kfree(tmpl).
However, crypto_unregister_skcipher() only drops the algorithm registration
reference; it does not block until all active transform (tfm) instances are
destroyed.

If an application holds a reference to the algorithm (e.g. via an AF_ALG
socket) and the device is unbound, the remove function could execute and
synchronously free the memory.

If the application then continues to submit requests, could it access the
synchronously freed tmpl structure, leading to a use-after-free?

Would it be better to use the alg->cra_destroy callback to dynamically free
the template when the final reference is dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D7

