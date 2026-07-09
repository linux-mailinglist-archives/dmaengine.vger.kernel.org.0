Return-Path: <dmaengine+bounces-12227-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sidTGRC2T2qFnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12227-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:54:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC641732815
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X8vpGxB7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12227-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12227-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45CAA3169DB3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5959331A44;
	Thu,  9 Jul 2026 14:32:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9D3002DF
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607579; cv=none; b=iZcGbjYBA7ZMb5JoFaX1mxKUEUa3Gyj0YSouGS7k95JxEN0SEscU1Mx9qIh+g5KPab8yRrz3RoqKNeV8bTKZ47dNDt0dFtq0JKCa7S+D1f1yDDy/nQG5WTjX9ofZVA8bUYARMZXrechJX7E4QS6Nb31qtHnjSEgnAwr7LZs0O7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607579; c=relaxed/simple;
	bh=fX4UK2KhJJj5LeiqOwn+Vqzc9sefvTslS6mq792Kv8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJyAf2bGQh9q866+vmz2DCQMywRTGf1BWwJcsI007lMjC81fiMCjsU+V9rTiQQIfUA2p8rT9CUiFZNN0+0q+y6ZyUmqBTnVqMxbjMsejVbwZkWp30ldDDllDVE8UAAdwu9JIc430m0FdycwXnbhFzkNOylX4z2OSKl4CfgipJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8vpGxB7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5601F000E9;
	Thu,  9 Jul 2026 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607578;
	bh=EI2JnKnnMDrG2w0WF46ssybq3HZrVcVP369er9fSHhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8vpGxB7wvMfwXksumlkp1W1D4ehKxfv0fmPvJO26KpR58WsWmGoeYQgEjTDQPPnU
	 b+2Y7LcGu2c7WmaMU31kPLwcdcA75D3/vNEKe+TENKmibVOzh63GNcvl/U3GnlzEpr
	 5+vHGcsMIDlPH2mOdDYTRV3/BNhIMyIfQyUxd0INDmwY6+LplZYPTiAdqRlo9AOy/h
	 mCKaofVE2pM/TZ4Ds4GRECepQbRKzFGONKLuAlBa/2/YvqIa3a0aNYwXWLDH8qSY7J
	 ETAtvgGB/jcDh1quKwumE/kpVpAMUNPbUyNWAIzFSlWg1DxPV0NTTeOn8ATav8HYUp
	 g/cRKcCXsiH8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/26] dmaengine: stm32-stm32-mdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-21-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-21-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:32:57 +0000
Message-Id: <20260709143258.1F5601F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12227-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC641732815

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `.remove` callback causes resource leaks and use-after-fre=
e on driver unbind.
- [High] Devres leak of DMA pools on channel allocation error path.
- [High] Disabling the clock before freeing the IRQ on the probe error path=
 can cause a synchronous external abort.
--

--- Patch [20]: [PATCH 20/26] dmaengine: stm32-stm32-mdma: Remove redundant=
 dev_err()/dev_err_probe() ---
commit 6440956ea9b4ed6aa697c4eb90a3a35f158a8e26
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: stm32-stm32-mdma: Remove redundant dev_err()/dev_err_probe()

This patch removes redundant dev_err() calls after devm_request_irq()=20
since the core now logs detailed error messages automatically.

> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdm=
a.c
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -1713,10 +1713,8 @@ static int stm32_mdma_probe(struct platform_device=
 *pdev)
> =20
>  	ret =3D devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handle=
r,
>  			       0, dev_name(&pdev->dev), dmadev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +	if (ret)
>  		goto err_clk;

[Severity: High]
This is a pre-existing issue, but does disabling the clock on the error path
before devres frees the IRQ risk a synchronous external abort?

If a spurious interrupt arrives after the goto err_clk path calls
clk_disable_unprepare() but before devres cleans up the IRQ handler,
stm32_mdma_irq_handler() will execute.

Could attempting to read STM32_MDMA_GISR0 while the APB clock is disabled
cause a bus fault and crash the kernel?

> =20
>  	ret =3D dmaenginem_async_device_register(dd);
>  	if (ret)

I also noticed a couple of other pre-existing issues in this file:

drivers/dma/stm32/stm32-mdma.c:stm32_mdma_driver

static struct platform_driver stm32_mdma_driver =3D {
	.probe =3D stm32_mdma_probe,
	.driver =3D {
		.name =3D "stm32-mdma",
...

[Severity: High]
This is a pre-existing issue, but does this platform driver lack a .remove
callback?

Since suppress_bind_attrs is not set, a privileged user can unbind the
driver via sysfs. When devres frees the device memory for dmadev,
of_dma_controller_free() is never called, leaving a dangling pointer
in the global of_dma_list.

Will subsequent DMA requests by other devices dereference this freed
pointer? Also, could scheduled vchan tasklets cause a use-after-free if
they execute during unbind?


drivers/dma/stm32/stm32-mdma.c:stm32_mdma_alloc_chan_resources()

	...
	ret =3D pm_runtime_resume_and_get(dmadev->ddev.dev);
	if (ret < 0)
		return ret;

	ret =3D stm32_mdma_disable_chan(chan);
	if (ret < 0)
		goto err_pm;
	...
err_pm:
	pm_runtime_put(dmadev->ddev.dev);
	return ret;

[Severity: High]
This is a pre-existing issue, but does this error path leak the descriptor
pool?

Earlier in stm32_mdma_alloc_chan_resources(), dmam_pool_create() allocates
a new pool. If a subsequent step like pm_runtime_resume_and_get() or
stm32_mdma_disable_chan() fails, the function returns without destroying
the pool.

Since the DMA engine core does not call the free callback if allocation
fails, could repeated channel requests by userspace continuously accumulate
leaked DMA pools and lead to an out of memory condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D20

