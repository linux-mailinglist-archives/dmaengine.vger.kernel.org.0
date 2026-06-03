Return-Path: <dmaengine+bounces-11137-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VoQ4BSadH2p1nwAAu9opvQ
	(envelope-from <dmaengine+bounces-11137-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:19:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E5633D48
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:19:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DK048NFl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11137-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11137-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5814A30645F3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E383E1718;
	Wed,  3 Jun 2026 03:18:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EA2874F5
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:18:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456733; cv=none; b=qkkj4mJS2CuVd+kI8Ggwut5PrGGW0EBJRS24Vqt6S76VwdgVXUFmGa8ADlih0746M90YTnDDHhZqm+pBbxwmDB+lbMkU9DULh+BgJwoFbAXck8PUGiWiZc8TAF3exkW8ukM1XhnXD9AIRUAOhd7vUQbPVneRtrLtuaNZ1IvIf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456733; c=relaxed/simple;
	bh=BqkAeP6/yYq0qTRJDonw1V2hhIJPqD2h5D8oqKk1BcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ags6Hj7ee5pxKP9KqePwHdgTBH7VuDVuPO8GYaW2JY6D6cOYmW7iNxBA5QQA+j1aKuNQrk9Mp/HfQee0vv/uSvHKYUJdYso4oJ/x2tAsagA4G0myQYdQcgg6c2T31VvvzD5QHn/2cDmMAcEHfeJA3U0moddu8/VVcD2J6BWvFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK048NFl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA481F00898;
	Wed,  3 Jun 2026 03:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780456731;
	bh=9xLjpfOXK+ZdMZiegEdW7EtPpOxmKciZuPe1OPC5kjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DK048NFlUXO9EpPGlly5gPmiSwG9/Sga2kDHtqbBejY16bEVurR5NqKKzbg51yKfS
	 hIbHXHI+0H+9k4jg7JrZX0dHAtuxkRMD7wxJRfP2BcOgrOYxVLTlLgX7zeJHAlyRre
	 gtiGn253vFrX9m1mnwqQy9pOoLIuVpusnVFakVTjKhhpkebkF9a4NVHInQ2PBVo9G9
	 nBSe4fRe1DYuky3NyDCBi5LszDI2FGV/H+Qh1dCVhwposLU3+kSlMkIjIWLtH+fyJI
	 xrdD5lJUmODr8TA/e35AccRoc0JARiQqq0q5aHdwYfNGIRPQpw9yJNQ35vno9oDl33
	 8gCfUBMUbANSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 2/8] dmaengine: ti: omap-dma: synchronize CPU PM
 notifier removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260603030754.288757-3-rosenp@gmail.com>
References: <20260603030754.288757-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 03:18:50 +0000
Message-Id: <20260603031851.4CA481F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11137-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B63E5633D48

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the CPU PM notif=
ier is not unregistered in omap_dma_remove() if the driver is configured wi=
th `needs_busy_check` but not `may_lose_context`, causing a use-after-free.
- [High] This problem wasn't introduced by this patch, but a missing `retur=
n rc;` in the `of_dma_controller_register()` error path causes the CPU PM n=
otifier to be incorrectly registered before returning an error, leading to =
a use-after-free.
- [High] This problem wasn't introduced by this patch, but the hardware IRQ=
 handler is prematurely freed before the DMA device is unregistered and bef=
ore hardware interrupts are properly disabled.
--

commit dc72bbd762c67afa3770b4d714901b84c5498c2f
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: synchronize CPU PM notifier removal

cpu_pm_notify() walks the raw notifier chain under rcu_read_lock(),
while cpu_pm_unregister_notifier() only unlinks the notifier block.
This patch waits for an RCU grace period after unregistering the CPU PM
notifier to prevent concurrent readers from dereferencing a freed block.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..6d1fb39956d7e 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c

[ ... ]

> @@ -1852,8 +1853,10 @@ static void omap_dma_remove(struct platform_device=
 *pdev)
>  	struct omap_dmadev *od =3D platform_get_drvdata(pdev);
>  	int irq;
> =20
> -	if (od->cfg->may_lose_context)
> +	if (od->cfg->may_lose_context) {
>  		cpu_pm_unregister_notifier(&od->nb);
> +		synchronize_rcu();
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the CPU PM=20
notifier if the driver is configured with needs_busy_check but not=20
may_lose_context?

In omap_dma_probe(), the notifier is registered if either needs_busy_check=
=20
or may_lose_context is true:

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
	...
	if (od->cfg->needs_busy_check) {
		od->nb.notifier_call =3D omap_dma_busy_notifier;
		cpu_pm_register_notifier(&od->nb);
	} else if (od->cfg->may_lose_context) {
	...
}

If a platform configuration sets only needs_busy_check, the notifier is=20
never unregistered during remove. Because the od structure is devm-allocate=
d,
will this leave a dangling pointer in the CPU PM notifier chain that causes=
=20
a use-after-free on the next PM event?

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing return=20
statement in the probe error path that could lead to a similar use-after-fr=
ee?

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
	...
		rc =3D of_dma_controller_register(pdev->dev.of_node,
				of_dma_simple_xlate, &omap_dma_info);
		if (rc) {
			pr_warn("OMAP-DMA: failed to register DMA controller\n");
			dma_async_device_unregister(&od->ddev);
			if (od->ll123_supported)
				dma_pool_destroy(od->desc_pool);
			omap_dma_free(od);
		}
	}
=09
	if (od->cfg->needs_busy_check) {
		od->nb.notifier_call =3D omap_dma_busy_notifier;
		cpu_pm_register_notifier(&od->nb);
	...
	return rc;
}

If of_dma_controller_register() fails, execution falls through, potentially
registers the CPU PM notifier using the already-freed od structure, and then
returns the error code.=20

When devres cleans up the failed probe, will the notifier remain registered=
=20
and point to freed memory?

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
during teardown if an interrupt fires after devm_free_irq() is called?

Looking at the rest of omap_dma_remove():

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
	...
	irq =3D platform_get_irq(pdev, 1);
	devm_free_irq(&pdev->dev, irq, od);

	dma_async_device_unregister(&od->ddev);

	if (!omap_dma_legacy(od)) {
		/* Disable all interrupts */
		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
	}
	...
}

Since devm_free_irq() is called before dma_async_device_unregister(), if a=
=20
DMA transfer completes while waiting for device unregistration, will the=20
hardware assert the IRQ line without a handler, causing an unhandled=20
interrupt storm?

Additionally, the teardown logic disables IRQENABLE_L0 instead of=20
IRQENABLE_L1. Could this leave the device capable of firing interrupts=20
even after the driver is unloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603030754.2887=
57-3-rosenp@gmail.com?part=3D1

