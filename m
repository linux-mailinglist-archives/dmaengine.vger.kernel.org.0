Return-Path: <dmaengine+bounces-10920-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCZpErJnFWqVUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10920-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:28:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E55D34EC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4A4E3046350
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170834AAE9;
	Tue, 26 May 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORB1WfDM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBE3AB274
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787262; cv=none; b=W0oHCz/w6+TzN66Vimze/TwfTHnQf7JHMA8hHN3pgTIJ8mJA6Iwrfa4v5ttee557EZL/+GZUGJ8ZNDtyXWIPUf4HxefevojezTttLVKlOQnd4/Quzlzm8YyAx0Jqs+HbO0Wp85C1zmE3q+jqKmce0T0obo4MtTpgB4W2BlA+gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787262; c=relaxed/simple;
	bh=mKIXjM8TV4lhqVxDnTC/F9ONeFF++WN+DL687a3fN3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuYtnNxecy/moh+0RXupHtRi7YmtGsEGw43YKjVWuWgRT0Njg42QCA1HyHU06fwciZlRLubjoJGRVtZ5fVApp9KA51dzAZjAMzOWUwJ7oK2VqckjpPPK32h8A1Zzn8wwCMymT4Nh0egHt1o5RCxPW3meyVzSmr+CIyR9NX+d85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORB1WfDM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F01F000E9;
	Tue, 26 May 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787260;
	bh=Nrmn5jtjfu3c7tg9/5kYTB/SESYKdNSUQn574nSvGQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORB1WfDMPF4FUg7EO8kHm7riipOIYDemAX63fCxd4fSLC7Gp/N7w2eJq8ZEHpG6qa
	 2EVgGrimkw/Kjh7/m2GyssyKSvg5d7tyR1gg3AsZQaDZfYsvQMCFbVEDQwQzhZZOFl
	 03iqIESJ5+0Kd2w3SR9sWDiKnyhCIscK+TgWkNRy7bD30bXniDkKZIbQHNgX03ahyd
	 csUre/NpvpxAoCg1uMXVZCY6QuXr5EayxFVXVfkEoZlREKSqRRPhJ6b0oZPg4qKxJE
	 qvly/g8nQhvm0xjwlUweX7wn20pj8zYUjfX8vRIn1+psTh8nnG9hT07rNVLSU556fX
	 jUJg7JhyZ6uiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260526084710.3491480-2-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:20:59 +0000
Message-Id: <20260526092100.857F01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,renesas.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10920-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 641E55D34EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect use of asynchronous pm_runtime_put() immediately followe=
d by pm_runtime_disable() in the removal and error paths.
- [High] Pending vchan tasklets are not killed or synchronized during devic=
e removal or probe failure, leading to a potential Use-After-Free.
- [High] The DMAERR error interrupt handler unconditionally returns IRQ_HAN=
DLED without acknowledging or clearing the hardware error status.
- [High] Devres-managed IRQs remain active while the hardware is reset and =
suspended during teardown, risking synchronous bus faults.
--

commit de8a17ea38f0c9f4203f815d7c5b435480aba456
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
   =20
This patch moves the channel interrupt request to the end of the channel
probe, and uses dmam_alloc_coherent() to simplify the error paths. This
fixes a potential issue where the interrupt handler might run before the
channel base address is initialized.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 625ff29024de0..9f206a33dcc6b 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  			goto err;
>  	}
> =20
> +	/* Register interrupt handler for error */
> +	irq =3D platform_get_irq_byname_optional(pdev, irqname);
> +	if (irq > 0) {
> +		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +				       irqname, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does this error interrupt
handler cause an interrupt storm?

The global error interrupt is requested with dev_id set to NULL. When the
error interrupt triggers, rz_dmac_irq_handler() receives this NULL pointer,
bypasses the channel handling logic, and unconditionally returns IRQ_HANDLED
without interacting with any hardware registers.

Returning IRQ_HANDLED defeats the kernel's spurious interrupt detector, and
because SoC error interrupts are typically level-triggered, failing to clear
the source condition at the hardware level can cause an unrecoverable
interrupt storm that locks up the CPU.

> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +				irq, ret);
> +			goto err;
> +		}
> +	}
> +

[ ... ]

> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but does using the asynchronous
pm_runtime_put() here prevent the device from entering a lower power state?

Calling pm_runtime_put() immediately followed by pm_runtime_disable()
cancels the pending suspend operation via __pm_runtime_barrier(). This
leaves the device permanently in an active (RPM_ACTIVE) power state after a
probe failure. Could this use the synchronous pm_runtime_put_sync() instead
to ensure the hardware is properly suspended before teardown?

[Severity: High]
This is a pre-existing issue, but could there be a use-after-free here if a
tasklet is still pending?

The driver initializes a tasklet for each channel via vchan_init(), yet
never calls tasklet_kill() in the probe error path or rz_dmac_remove().
Because the dmac structure is managed by devres, its memory is freed shortly
after remove or probe failure returns. If a pending interrupt schedules the
tasklet during teardown, the tasklet will execute after its backing memory
has been freed.

[ ... ]

> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  static void rz_dmac_remove(struct platform_device *pdev)
>  {
>  	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
> =20
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown sequence
risk synchronous bus faults?

The driver synchronously asserts hardware reset (reset_control_assert) and
initiates suspend before devres unregisters the IRQs. If a pending or
spurious interrupt fires during this window, the handler will attempt to
read the CHSTAT register while the IP is in reset or unclocked.

Since the IRQ handler lacks a pm_runtime_get_if_active() check, accessing
unclocked or reset hardware registers could trigger a synchronous external
abort or bus fault, leading to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D1

