Return-Path: <dmaengine+bounces-10930-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLoyFXZwFWpbVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10930-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:05:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C85D3E96
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A5B30488DD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71923C4B87;
	Tue, 26 May 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZBpzkmO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D93D8907
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789475; cv=none; b=l91U6v5UWtbrtkRnCi/8sB46gaEqiAU+WE8RYu643OLjIlcD7a6Z3PRyYxroF8dUv6rNAbIYI2Umo3F39XuEYxYf+yxAAMA3kBE11+E2/lZOEFP5biPUv7gTqk/v7zRit/AXM4NRPyDsdcXUL1+iF6QY6+5eQCcpFqnFH1fEWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789475; c=relaxed/simple;
	bh=FQMEb8+DaNCzCEIQH9SwSRf/hxyx7Na1mtkTgETinF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZDhy3ebfFmPXPJWypHLsKT/toVVnk1MiFEAm2sIZb6tHLUHUKAfcX2jRLLSLYchWpIPcczzGPR1z2ld66A/8nr/qyep22XHv4KwK1qIZ7nexzG7hEMSlKMwN2xPsefl7JdQDHyv6fiaByCXlvxBB5HOCnJdbHzgd31wbLIwyWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZBpzkmO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CF51F000E9;
	Tue, 26 May 2026 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789473;
	bh=/1e0/MSgdxT31wrDbdmrMOUBV8yaI/kXifFySqPRqOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZBpzkmOZF/LiZwExVz5IV6LY0Nzy/hGgoXDWv5pcJ3dd6xX38+eLkIQRfOj5co/k
	 aCi/wylDZCaSXQGpSPPEnffPaQ8DoerB4PRDg2UXn0PJTCuHIbw3qb+yQvxudrfSGI
	 a6SCKeCNbUEos4ah3CY5H8ZMFxkB8RmcZIXV9hEIeCmaNUpciE0S0GEMSTdBBVhaVM
	 pavxDiJlKzZXhR97+i6luO390a5B2W0LfOHabZFvPT5XcaRlEtsjDfIiG8ql4s8OQ/
	 sEy+t9k+UwwBFV3wCE4cDPxUwUl2uNEPKURDJFPoxfIXnYElMvl31viyeA7r600zhc
	 6RK/YG4afUF7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/18] dmaengine: sh: rz-dmac: Add runtime PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, dmaengine@vger.kernel.org
In-Reply-To: <20260526084710.3491480-15-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-15-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:57:53 +0000
Message-Id: <20260526095753.A5CF51F000E9@smtp.kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,renesas.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10930-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: BD7C85D3E96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Early return on PM resume failure in rz_dmac_issue_pending() leave=
s descriptors in the submitted list, causing incorrect residue reporting.
- [Low] Misplaced exclamation mark in error message formatting (\n!).

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() immediately followed by pm_runtime_d=
isable() leaves hardware in an incorrect state.
- [High] IRQ handlers access hardware registers without verifying that the =
device is runtime active.
- [High] Race condition between devm-managed IRQs and device removal leads =
to hardware register access while the device is in reset or suspended.
--

commit 1bdb517f551fc047d57449a7201275740a491091
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: dmaengine: sh: rz-dmac: Add runtime PM support

This patch protects exposed APIs with runtime PM calls before accessing
hardware registers. It also marks the DMA device as pm_runtime_irq_safe()
to support APIs called from atomic context. Error handling paths in
termination and cleanup functions are updated to skip hardware access if
RPM resume fails.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 93394b9934c89..bd4ca8e939f17 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -549,12 +549,22 @@ static void rz_dmac_free_chan_resources(struct dma_=
chan *chan)
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	struct rz_dmac_desc *desc, *_desc;
>  	unsigned long flags;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret) {
> +		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=3D%d\n!",
> +			dma_chan_name(chan), ret);
> +	}

[Severity: Low]
Does this error message format string place the exclamation mark correctly?

The "\n!" sequence places the exclamation mark at the beginning of the next
line instead of the end of the sentence, breaking the intended log output.

[ ... ]

> @@ -716,13 +737,20 @@ static int rz_dmac_terminate_all(struct dma_chan *c=
han)
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);
>  	vchan_dma_desc_free_list(&channel->vc, &head);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static void rz_dmac_issue_pending(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	unsigned long flags;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;

[Severity: High]
If this returns early on failure, does it leave newly submitted descriptors
stuck in the vc.desc_submitted list?

If vchan_issue_pending() is skipped, descriptors are never moved to the
vc.desc_issued list. Later, if a client calls dmaengine_tx_status(),
rz_dmac_chan_get_residue() will use vchan_find_desc() which only checks
the desc_issued list:

drivers/dma/virt-dma.c:vchan_find_desc() {
	list_for_each_entry(vd, &vc->desc_issued, node)
		if (vd->tx.cookie =3D=3D cookie)
			return vd;
}

This will fail to find the pending descriptor, causing
rz_dmac_chan_get_residue() to incorrectly return 0 for the residue.

This could mislead the client into thinking the transfer has fully completed
while the status remains DMA_IN_PROGRESS. Should vchan_issue_pending()
still be called to update the software state correctly?

[ ... ]

> @@ -1274,6 +1327,7 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
>  				     "failed to get resets\n");
> =20
> +	pm_runtime_irq_safe(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but does adding pm_runtime_irq_safe() expose
the interrupt handlers to accessing powered-down hardware?

The IRQ handler rz_dmac_irq_handle_channel() directly reads hardware
registers like rz_dmac_ch_readl().

If a spurious or delayed interrupt occurs while the device is runtime
suspended (e.g., after a failed system suspend or during driver teardown),
it will access hardware without verifying it is powered, resulting in a
kernel crash.

Should IRQ handlers use pm_runtime_get_if_active() to verify the device is
powered before touching registers?

[Severity: High]
This is also a pre-existing issue, but is there a race condition between
the devm-managed IRQs and device removal?

The driver requests channel IRQs using devm_request_threaded_irq(). During
module removal in rz_dmac_remove(), it asserts the hardware reset and
suspends the device:

drivers/dma/sh/rz-dmac.c:rz_dmac_remove() {
	...
	reset_control_assert(dmac->rstc);
	pm_runtime_put(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
}

Because devm-managed resources are freed only after the remove() function
returns, an in-flight interrupt can execute concurrently with or immediately
after the reset assertion and suspension.

The interrupt handler will attempt to read hardware registers while the
controller is held in reset or suspended, leading to a system hang or
synchronous abort.

Should synchronize_irq() be called, or the IRQs manually freed, before
asserting the hardware reset and disabling runtime PM?

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
rz_dmac_probe() and rz_dmac_remove() leave the hardware in an incorrect sta=
te?

In rz_dmac_probe() error paths and rz_dmac_remove(), the driver calls
pm_runtime_put() immediately followed by pm_runtime_disable():

drivers/dma/sh/rz-dmac.c:rz_dmac_probe() {
	...
err_pm_runtime_put:
	pm_runtime_put(&pdev->dev);
err_pm_disable:
	pm_runtime_disable(&pdev->dev);
}

Calling pm_runtime_put() queues an async idle notification, but
pm_runtime_disable() invokes __pm_runtime_barrier() which cancels any
pending asynchronous requests. This causes the device to never enter the
runtime suspended state, leaving hardware resources powered on.

Should pm_runtime_put_sync() be used instead?

>  	pm_runtime_enable(&pdev->dev);
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D14

