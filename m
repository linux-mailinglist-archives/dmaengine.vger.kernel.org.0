Return-Path: <dmaengine+bounces-12214-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aLrmLiayT2qjmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12214-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A0B73255B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DJklJbXb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12214-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12214-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 633D330CC33E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144A32E126;
	Thu,  9 Jul 2026 14:16:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019E21E098
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606569; cv=none; b=kxX3c2YhB70QVUOTOYWnoMtG8IBi5zJjr2IojiAzb4lunkaLrtu3x/kNKkAyCeBO+2dfalXM9oLwG/2nYcc3ywNYzR6fjq3ias7g9/bCFUZ0iGyZ/EoaUvKYmcxyuwQW3IICC74duDv45lI04Qt/JRrL02aiOaKWGsCJpvQe+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606569; c=relaxed/simple;
	bh=UErJiczA/QCli4Mo064gv32ZaCe/iQByXEWemaDHdO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EhEsOEhBfGo4ilni5+e4lMoeAxfy9FvHlOEFjDflIZmQzQxJoGE31OJB03a0hXNZcDJeZ+de5sbf8+QONnOtjj4iKvtBE3HBOjWB3W5hpkvPXeKo16gXKiqYeviyk/de4QdkJuFX+txomCkyzdw6gBuS7fvznkh//7x1kjseYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJklJbXb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C001F000E9;
	Thu,  9 Jul 2026 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606568;
	bh=4bc4DEOx2VuhQ9svIong6qHD7yflQWWB79mu2HrB1vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJklJbXb9vOCAuJ98jQLd2DsbM7nmSYTGo6xmmau8n3qZTqCTAWdOM+LwVGlb3dE3
	 ja6ISgK3R4UynKVT5IBRq5Bw9vExjGC6n6KxFUw+v6yoeZjGrDMLVTu8udZFkk+ekb
	 Jh5Vm9rkrXNTc8/OZFtsko+iSAXIP1Z0Un9bzauA1E09alXVNTMGfaygfgbOvsYYbT
	 iO9Unu5lYZyCa6jJwxEW/MS4QtYM/LBrmKU3MPzaXsJpL91cGh6bzPS0isJuLmt2hy
	 3KGE0LK1LwWeG+oAlDBCDd1Fi15e6+PgJGZRoN7LiozvnsyjroZKs1oaovv28UrNas
	 vlyILPONArTTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/26] dmaengine: owl-dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-9-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-9-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:16:07 +0000
Message-Id: <20260709141608.21C001F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12214-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A0B73255B

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver directly passes the signed return value of `platform_ge=
t_irq()` to `devm_request_irq()` without checking for errors, causing negat=
ive error codes like `-EPROBE_DEFER` to be cast to large unsigned integers =
and replaced by `-EINVAL`, permanently breaking probe deferral.
- [High] The IRQ handler is registered before critical data structures (`od=
->pchans`) are allocated and before the hardware clock is enabled (`clk_pre=
pare_enable`), risking a system crash or NULL pointer dereference.
- [High] The return value of `clk_prepare_enable()` is not checked. If the =
clock fails to enable, the driver silently registers the DMA controller, le=
ading to a system crash when clients later attempt to use it.
- [High] During probe error paths, the clock is manually disabled while the=
 devres-managed IRQ remains registered and active, creating a race conditio=
n that can cause a system crash.
--

--- Patch [8]: [PATCH 08/26] dmaengine: owl-dma: Remove redundant dev_err()=
/dev_err_probe() ---
commit 8f8dd83b44c39b0ec6f44933f79e28cff3053a61
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: owl-dma: Remove redundant dev_err()/dev_err_probe()

This commit removes driver-specific error logging around devm_request_irq()
since the core now automatically logs detailed error messages on failure.

> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 7c80572fc71d1..71d0b15968c6d 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -1163,10 +1163,8 @@ static int owl_dma_probe(struct platform_device *p=
dev)
>  	od->irq =3D platform_get_irq(pdev, 0);
>  	ret =3D devm_request_irq(&pdev->dev, od->irq, owl_dma_interrupt, 0,
>  			       dev_name(&pdev->dev), od);

[Severity: High]
This is a pre-existing issue, but is it safe to pass the unchecked return
value of platform_get_irq() directly to devm_request_irq()?

If platform_get_irq() returns a negative error code like -EPROBE_DEFER,
it gets cast to a large unsigned integer. This causes devm_request_irq()
to fail with -EINVAL, which permanently breaks probe deferral.

[Severity: High]
This is a pre-existing issue, but does requesting the IRQ here risk a crash?

The IRQ is unmasked before od->pchans is allocated and before the hardware
clock is enabled. If a spurious interrupt fires immediately,
owl_dma_interrupt() will attempt to access hardware registers and dereferen=
ce
the uninitialized od->pchans pointer:

owl_dma_interrupt() {
	pending =3D dma_readl(od, OWL_DMA_IRQ_PD0);
	...
	for_each_set_bit(i, &pending, od->nr_pchans) {
		pchan =3D &od->pchans[i];
		pchan_update(pchan, OWL_DMAX_INT_STATUS, 0xff, false);
	}
}

> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to request IRQ\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	/* Init physical channel */
>  	od->pchans =3D devm_kcalloc(&pdev->dev, od->nr_pchans,

[Severity: High]
This is a pre-existing issue, but further down in owl_dma_probe(), is it
intended that the return value of clk_prepare_enable() is unchecked?

owl_dma_probe() {
	...
	clk_prepare_enable(od->clk);

	ret =3D dma_async_device_register(&od->dma);
	...
}

If the clock fails to enable, the driver silently registers the DMA
controller, which can lead to a system crash when clients later attempt
to use it and access unclocked hardware.

[Severity: High]
This is a pre-existing issue, but does the error path in owl_dma_probe()
leave a window for a crash?

owl_dma_probe() {
	...
err_pool_free:
	clk_disable_unprepare(od->clk);
	dma_pool_destroy(od->lli_pool);

	return ret;
}

The clock is manually disabled here, but the devres-managed IRQ remains
registered and active until the probe function returns and triggers devres
cleanup. If an interrupt fires during this window, the handler will access
unclocked hardware registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D8

