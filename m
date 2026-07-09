Return-Path: <dmaengine+bounces-12225-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WADEBCi1T2pMnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12225-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:50:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83673277D
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qq120h62;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12225-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12225-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3B1631A83B2
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB183370FF;
	Thu,  9 Jul 2026 14:30:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55618337699
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607410; cv=none; b=k3ocWlKMcipg3UgiAGT3dhB/2NG0socxJldsB5R4tV2kWKBDVCk5jz4LhEw0m6sZPwKUiQ/qJS6jTYhKum1Ag7Mpa0T1Ff677+Ap/TXxqLWq1hmbrLVqXGd6mEGZR9Gf6bdSQ1KMzmByAS9Jb4qNBYZs/+JFpOvl5n/b9lZ4ZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607410; c=relaxed/simple;
	bh=hsVgxxAsmkmNqLrKcHdatS5xcbPExj5eEy2nMaIp4jM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nNziUFk0tMLjpqpwuzxmhElA3hEw559C8fY8bXxU4uNZblILznX9OzuDogvvSc6gYancYDZ+Ktf8WNratByHRaorjOTZcVqSNE0hAwxQPc8cVxMZKwYteW9stkUmG6ouXS2CXbeiMUMQj2u/u5xXjFYhm5ic9eM2OBuaw2ZgMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq120h62; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F20A1F00A3D;
	Thu,  9 Jul 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607408;
	bh=gFbUVP3gNNUF+iwzgGbr2FbZXX1E5nNfy9Xw0/XGr10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qq120h62zzjFqQQJoqzygHY17QsyZHl3lB+l+W/UCXzkKthq/nqNd280+wWcShp+S
	 K8tjlHdjYymXD0YDmUThzp4ZJP2N5r5MVM3E6TQhlKSWrKiyYQ2//4Mh/PQlznMzE8
	 JYjRLQNBke27reHHXkM9ZDaRbOWygpb1QzZC8gR3Q22ZL9pSAoPtAH2v3Wc9ZXyOgE
	 hZsTS8PmX2TaKdgLCHq80b0t05SC+RuV4OBqBagcvLNia/A6pRg3Uhh9V0X3bkWwQQ
	 dy0W+De7Ofd6YLc1zA1YovVTOJ6ZUE26iI2pdhrshVor0mSyYQdiOjwaeErAbFKbWI
	 DOwFrh32hbCiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/26] dmaengine: st_fdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-18-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-18-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:30:08 +0000
Message-Id: <20260709143008.9F20A1F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12225-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vivo.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A83673277D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ is requested before dependent resources are initialized, a=
nd the probe error path destroys resources before the devm-managed IRQ is d=
isabled, risking NULL pointer dereferences, uninitialized spinlock access, =
and Use-After-Free.
- [High] Mismatch between devm-managed DMA registration and manual resource=
 teardown causes sysfs leaks and use-after-free risks in both probe error a=
nd remove paths.
--

--- Patch [17]: [PATCH 17/26] dmaengine: st_fdma: Remove redundant dev_err(=
)/dev_err_probe() ---
commit 15a299566b3b9735b597a7ab918fd3926002aefe
Author: Pan Chuang <panchuang@vivo.com>
dmaengine: st_fdma: Remove redundant dev_err()/dev_err_probe()

This commit removes driver-specific error logging for devm_request_irq()
failures in st_fdma_probe(), as the core now automatically logs detailed
error messages on failure.

> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index d9547017f3bd6..05a2642601e61 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
> @@ -771,10 +771,8 @@ static int st_fdma_probe(struct platform_device *pde=
v)
> =20
>  	ret =3D devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
>  			       dev_name(&pdev->dev), fdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request irq (%d)\n", ret);
> +	if (ret)
>  		goto err;

[Severity: High]
This is a pre-existing issue, but is it safe to request the IRQ before
allocating fdev->slim_rproc and initializing the channels?

If an interrupt fires immediately after devm_request_irq() is called,
st_fdma_irq_handler() will use fdma_read(), which dereferences
fdev->slim_rproc->peri. Since fdev->slim_rproc is still NULL, would this
cause a crash?

Also, if probe fails later (e.g., during DMA registration), the error
path destroys slim_rproc and kills tasklets:

drivers/dma/st_fdma.c:st_fdma_probe() {
    ...
err_rproc:
	st_fdma_free(fdev);
	st_slim_rproc_put(fdev->slim_rproc);
err:
	return ret;
}

Since the IRQ is managed by devres, it remains active until the devres
cleanup runs. If an interrupt fires during this window, could it access
destroyed resources?

[Severity: High]
This is also a pre-existing issue, but does the error handling in
st_fdma_probe() and the driver remove path create a mismatch with
devm-managed DMA registration?

When probe fails in of_dma_controller_register(), the err_rproc path calls
st_fdma_free() before devres cleanup:

drivers/dma/st_fdma.c:st_fdma_free() {
    ...
	list_del(&fchan->vchan.chan.device_node);
    ...
}

This manual list_del() empties fdev->dma_device.channels. Will this cause
the devres dma_async_device_unregister() to skip unregistering the sysfs
devices, leaving dangling pointers to the freed fdev?

Similarly, in the remove path:

drivers/dma/st_fdma.c:st_fdma_remove() {
	struct st_fdma_dev *fdev =3D platform_get_drvdata(pdev);

	devm_free_irq(&pdev->dev, fdev->irq, fdev);
	st_slim_rproc_put(fdev->slim_rproc);
	of_dma_controller_free(pdev->dev.of_node);
}

st_fdma_remove() does not call st_fdma_free() to kill the tasklets, and it
puts slim_rproc manually. When devres later frees fdev, could any
scheduled but unkilled tasklet trigger a use-after-free, and could concurre=
nt
clients terminating channels trigger a use-after-free on slim_rproc?

> =20
>  	fdev->slim_rproc =3D st_slim_rproc_alloc(pdev, fdev->fw_name);
>  	if (IS_ERR(fdev->slim_rproc)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D17

