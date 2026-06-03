Return-Path: <dmaengine+bounces-11136-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNQbIiWdH2p0nwAAu9opvQ
	(envelope-from <dmaengine+bounces-11136-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:19:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF93633D42
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kLQdGuQN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11136-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11136-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB73A305FC7C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2A30C164;
	Wed,  3 Jun 2026 03:18:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B830C162
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456732; cv=none; b=jM8Tc+dJRCwsV0nQ8jKoePL8I++WC/yvnyAWx9NDEjByg9jXksS4VkCJWYFYGtlZhIgWB0NYYKW36GtGblQ45nicMqFLLCBI3acYzIU67sFAfOSEFX4vXYSJqwpVkfHSrkyLpXhX6PUauX/0C0w7J+0BVtO8zxpvxN6k6IHo0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456732; c=relaxed/simple;
	bh=RXPWxkJPu94gO5tAXnHMUCZc+mV8cdqbu2BRVfp2JfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXKsXxAQaWQ1GO8R5X0W6Rn+W38KSz6UmmfOi4UNraFP+PyDZ59pVwb/lk76/wzEdSuIq9Jha4l4ZA4zDu7MlYUUclrzpWEQJv6RMU03cZ4Lo2/aO55tKsA2+MFlp8fmIViTMNPiNSPaTa8B9s9mqW0vtDwWpz5IHM5QoxULWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLQdGuQN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1D71F00893;
	Wed,  3 Jun 2026 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780456730;
	bh=p2kiGgFdiN1TgySo7x3kvi6p+UnzUsqc2SH+cxvl9vY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLQdGuQNgggZh8bsJ1JoJo34QxM9/5XhwGcmJuYGuHm69uzVoJtV87avNZ9TTJJaB
	 6DKySXcEAj0N/2XqeDjjlqMVOYYeMgs6nKWeIjQtFxzoVjglEj8mUolG3Mmv7ezuz4
	 /orvAhwMDO+GorOaXLcOzgV+RvXO5Og/oa8ZaJYdyoIfi2kWuv6SJAaMhSHtkpTXn5
	 3LAlTgOtxJ3JkqKxkg+ZoH/qKfO1qiNSP5JosYuVLSqq4GzeEk/bN1RkZ3AGLB8bVH
	 k+Eznx6gP8mfcJIh6p0CDB/nVyk7n5GcaVsYFoJN5MtP47CEXf6L8dfYBH+XeT+PcR
	 m2zPwFGLh3Auw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 1/8] dmaengine: ti: omap-dma: fix missing return in
 probe error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260603030754.288757-2-rosenp@gmail.com>
References: <20260603030754.288757-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 03:18:50 +0000
Message-Id: <20260603031850.8E1D71F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11136-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF93633D42

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message factually misstates the behavior of the bug, =
claiming the probe function 'eventually succeeds' without the return statem=
ent.

Pre-existing issues:
- [High] The CPU PM notifier is registered during probe if `needs_busy_chec=
k` is true, but `omap_dma_remove` only unregisters it if `may_lose_context`=
 is true, causing a resource leak and potential use-after-free.
- [High] `platform_get_irq` returning an error (e.g., `-EPROBE_DEFER`) on n=
on-OMAP1 platforms incorrectly allows the driver to probe without an interr=
upt handler.
- [Medium] Unconditional call to `devm_free_irq` in `omap_dma_remove` can u=
se an invalid or unrequested IRQ if `platform_get_irq` returned an error du=
ring probe.
--

commit d8616fa8712a6dcc8171a1ac6113861b509b7b33
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: fix missing return in probe error path

If of_dma_controller_register() fails, the error path omits the return
statement, causing probe to continue (and eventually succeed) despite
the DMA controller not being registered. Add the missing return rc;.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in er=
ror paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>

> If of_dma_controller_register() fails, the error path omits the return
> statement, causing probe to continue (and eventually succeed) despite
> the DMA controller not being registered. Add the missing return rc;.

[Severity: Medium]
Is this description accurate?

The variable rc retains the non-zero error code returned by
of_dma_controller_register(). Since there are no further assignments to rc =
in
the remainder of omap_dma_probe(), the function ultimately reaches return r=
c;
and fails.=20

The actual impact of the missing return was that the driver erroneously exe=
cuted
subsequent initialization (like registering the CPU PM notifier) and then
failed.

Since the failure path after that point does not unregister the notifier, t=
his
left a dangling pointer and caused an immediate use-after-free when the dev=
ice
structure was freed by devres.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..0f6dd6b0a301f 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *p=
dev)
>  			if (od->ll123_supported)
>  				dma_pool_destroy(od->desc_pool);
>  			omap_dma_free(od);
> +			return rc;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing unregister
for the CPU PM notifier in omap_dma_remove()?

In omap_dma_probe(), the notifier is registered if either needs_busy_check =
or
may_lose_context is true:

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
    ...
	if (od->cfg->needs_busy_check) {
		od->nb.notifier_call =3D omap_dma_busy_notifier;
		cpu_pm_register_notifier(&od->nb);
	} else if (od->cfg->may_lose_context) {
		od->nb.notifier_call =3D omap_dma_context_notifier;
		cpu_pm_register_notifier(&od->nb);
	}
    ...
}

However, omap_dma_remove() strictly guards the unregistration with
may_lose_context:

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
    ...
	if (od->cfg->may_lose_context)
		cpu_pm_unregister_notifier(&od->nb);
    ...
}

For SoC configurations where needs_busy_check is true but may_lose_context =
is
false, the notifier is never unregistered upon module removal, leading to a
use-after-free panic upon the next PM transition when the CPU PM subsystem
calls the freed notifier.

[Severity: High]
This is a pre-existing issue, but does omap_dma_probe() incorrectly ignore
errors from platform_get_irq() on non-OMAP1 platforms?

drivers/dma/ti/omap-dma.c:omap_dma_probe() {
    ...
	irq =3D platform_get_irq(pdev, 1);
	if (irq <=3D 0) {
		dev_info(&pdev->dev, "failed to get L1 IRQ: %d\n", irq);
		od->legacy =3D true;
	} else {
    ...
}

If platform_get_irq() returns an error like -EPROBE_DEFER, the driver sets
legacy mode and continues without an IRQ.

On non-OMAP1 platforms, the legacy macro evaluates to false, causing the dr=
iver
to operate as a modern DMA controller configuring interrupts, but without an
IRQ handler registered.

This results in silent probe success followed by permanently hung DMA trans=
fers.

[Severity: Medium]
This is a pre-existing issue, but can omap_dma_remove() pass an invalid IRQ
number to devm_free_irq()?

drivers/dma/ti/omap-dma.c:omap_dma_remove() {
    ...
	irq =3D platform_get_irq(pdev, 1);
	devm_free_irq(&pdev->dev, irq, od);
    ...
}

If platform_get_irq() returned an error during probe, or returns an error h=
ere
in remove, devm_free_irq() is called with an invalid IRQ.

This causes a warning in devres_release() since the IRQ was never requested=
 via
devres, followed by calling free_irq() with an invalid IRQ number.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603030754.2887=
57-2-rosenp@gmail.com?part=3D1

