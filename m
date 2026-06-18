Return-Path: <dmaengine+bounces-11608-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vrdZBf9+M2pfCwYAu9opvQ
	(envelope-from <dmaengine+bounces-11608-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:15:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103669DA8E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:15:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AAzWPlzp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11608-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11608-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B633011BF0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81723164B7;
	Thu, 18 Jun 2026 05:15:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FF19CCF7;
	Thu, 18 Jun 2026 05:15:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759740; cv=none; b=VcrQNiEfGyERpRAOvlVFE/PWnNOtDnh/1fg77+lwR6U0GMKcHavX3llbDahwYoPjeIjxqC7/Lqkfv/BBxPbHZ+ecQ0FLuMRpBZkw+FVRpjHZQ4na8AJ9VIM9r+tf9ECrFnNJZdxacRndZapOGjLCOR5AGP3VcvAUhSqXbwrO2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759740; c=relaxed/simple;
	bh=1dql+1NBcciyB4fpIH/XnREL4KReC+ZMZr0VPJmzZAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfvHq4/7wCHr7uXrD+O55GfWgLNbstH0A/3Waayh03ss1smCuneFuyIL8stbxLDwMAqvzExDQ8aJStLcd2YkqY/LPzfkr5P4+JllGos65atJq2fq082Du88HC2ZbQMG4peQvO4+nzKvjr5hBZosI+Lg0MjW3Pm7EsDFuSY14eiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAzWPlzp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E201F000E9;
	Thu, 18 Jun 2026 05:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759739;
	bh=EoDhGw5hYz5uzEpnZ1qEuuthHJrqmByqGvq9V1ZlYPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAzWPlzpT3652QT3dKZzhU9qXsjy7kdJKZzAnejKzk9i5PFrf2EOposKmJhfoiqbH
	 yiuSRK1BWgGl9bj7kmisg+srLtLLEqL6I0NxhQO6ICfyQw3ViR0ImQlJWnM8U3vLVI
	 f6Sqqz8eYmcEqwtjhLvnDiEjuDy2l+CZkEuvNm6SRvDHGd8fG2XktChqpQ55zvp3zF
	 msaznbAbCXRv9gxfoiG35mATEdDp1lQsVtRS3Rxdv2lqSIYfs0hS3l2pwGGPtAmlu0
	 ymZyezMm+y/huzlNiAkmh8GyCD62H9WJe0xftOES73bWDGem+3A5rtV5i7oVgxcFaS
	 oh5KazAmx/txw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: Frank.Li@kernel.org, robh@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:15:38 +0000
Message-Id: <20260618051539.15E201F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11608-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8103669DA8E

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Calling synchronous runtime PM functions on a non-IRQ-safe device =
from atomic context.
- [High] Forcing immediate synchronous suspend of the SRAM PM domain defeat=
s the DMA controller's autosuspend design and causes severe performance deg=
radation.
- [High] The consumer driver forcefully enables runtime PM on a supplier de=
vice, risking unbalanced PM states.
- [High] Missing device link between the DMA controller and the external LC=
LA SRAM device, leading to system suspend ordering races.

Pre-existing issues:
- [Critical] Validation logic incorrectly bounds `dev_type`, leading to a c=
ritical out-of-bounds pointer write in `lookup_log_chans`.
- [High] An early probe failure unconditionally calls `pm_runtime_disable(b=
ase->dev)`, permanently disabling runtime PM on subsequent probe retries.
- [High] Missing `free_irq()` in the error paths of `d40_probe()`.
- [High] Unchecked return value of `d40_queue_start()` leaks runtime PM ref=
erence and permanently hangs the channel.
--

commit ee86cbf896c47f035fc9bd6d0f30e49d8a83841a
Author: Linus Walleij <linusw@kernel.org>

dmaengine: ste_dma40: Use power domain for LCLA SRAM

This patch replaces the LCLA ESRAM regulator with runtime PM support.
It fetches the SRAM device for the ESRAM34 power domain from the device tre=
e.
The driver then holds a runtime PM reference on this domain while DMA
transfers are active.

> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9b803c0aec254..6ca67ec446dc5 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
[ ... ]
> @@ -628,6 +630,22 @@ static struct device *chan2dev(struct d40_chan *d40c)
>  	return &d40c->chan.dev->device;
>  }
> =20
> +static void d40_transfer_runtime_get(struct d40_base *base)
> +{
> +	if (base->lcla_dev)
> +		pm_runtime_get_sync(base->lcla_dev);

[Severity: High]
Does this code call a blocking runtime PM function on an external SRAM devi=
ce
from an atomic context?

d40_transfer_runtime_get() and d40_transfer_runtime_put() are called from
d40_queue_start() and dma_tc_handle(). Both of these execute under the
d40c->lock spinlock, and dma_tc_handle() runs from the hardirq handler.

Because base->lcla_dev is an external SRAM device whose PM domain requires
sleeping locks to power on or off, it is not IRQ-safe. Calling synchronous
PM operations on it in an atomic context might trigger a might_sleep() warn=
ing
and a scheduling-while-atomic kernel panic.

> +
> +	pm_runtime_get_sync(base->dev);
> +}
> +
> +static void d40_transfer_runtime_put(struct d40_base *base)
> +{
> +	pm_runtime_put_autosuspend(base->dev);
> +
> +	if (base->lcla_dev)
> +		pm_runtime_put_sync_suspend(base->lcla_dev);

[Severity: High]
Could forcing an immediate synchronous suspend of the SRAM PM domain defeat
the DMA controller's autosuspend design and cause performance degradation?

By using pm_runtime_put_sync_suspend() here, the external SRAM device is
forced to power down immediately as soon as a single DMA transfer completes.
The DMA controller itself uses pm_runtime_put_autosuspend() to handle bursty
transfers efficiently.

Suspending the shared SRAM immediately and synchronously might cause every
subsequent DMA transfer to block while the PM domain wakes up, which could
introduce significant latency.

> +}
[ ... ]
> @@ -1516,7 +1534,7 @@ static struct d40_desc *d40_queue_start(struct d40_=
chan *d40c)
>  	if (d40d !=3D NULL) {
>  		if (!d40c->busy) {
>  			d40c->busy =3D true;
> -			pm_runtime_get_sync(d40c->base->dev);
> +			d40_transfer_runtime_get(d40c->base);
>  		}
> =20
>  		/* Remove from queue */

[Severity: High]
This is a pre-existing issue, but does d40_queue_start() leak a runtime PM
reference and hang the channel if the hardware start fails?

If d40_start(d40c) fails later in this function, it returns NULL without
reverting d40c->busy or dropping the PM reference:

    err =3D d40_start(d40c);
    if (err)
        return NULL;

Callers like d40_issue_pending() ignore this return value. The channel then
remains permanently marked as busy, preventing future transfers, and the
leaked PM reference prevents the device from suspending.

[ ... ]
> @@ -3590,23 +3593,32 @@ static int __init d40_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	if (base->plat_data->use_esram_lcla) {
> +		np_lcla =3D of_parse_phandle(np, "sram", 1);
> +		if (!np_lcla) {
> +			dev_err(dev, "no LCLA SRAM node\n");
> +			ret =3D -EINVAL;
> +			goto destroy_cache;
> +		}
> =20
> -		base->lcpa_regulator =3D regulator_get(base->dev, "lcla_esram");
> -		if (IS_ERR(base->lcpa_regulator)) {
> -			d40_err(dev, "Failed to get lcpa_regulator\n");
> -			ret =3D PTR_ERR(base->lcpa_regulator);
> -			base->lcpa_regulator =3D NULL;
> +		np_lcla_parent =3D of_get_parent(np_lcla);
> +		of_node_put(np_lcla);
> +		if (!np_lcla_parent) {
> +			dev_err(dev, "no LCLA SRAM parent node\n");
> +			ret =3D -EINVAL;
>  			goto destroy_cache;
>  		}
> =20
> -		ret =3D regulator_enable(base->lcpa_regulator);
> -		if (ret) {
> -			d40_err(dev,
> -				"Failed to enable lcpa_regulator\n");
> -			regulator_put(base->lcpa_regulator);
> -			base->lcpa_regulator =3D NULL;
> +		lcla_pdev =3D of_find_device_by_node(np_lcla_parent);
> +		of_node_put(np_lcla_parent);
> +		if (!lcla_pdev) {
> +			ret =3D -EPROBE_DEFER;
>  			goto destroy_cache;
>  		}
> +		base->lcla_dev =3D &lcla_pdev->dev;

[Severity: High]
Is a device link missing between the DMA controller and the external LCLA
SRAM device?

The driver relies on the runtime PM of lcla_dev, but it doesn't appear to
call device_link_add() to inform the PM core that base->dev depends on
base->lcla_dev.

During a system sleep transition, the PM core might suspend devices in
parallel or based on standard device tree hierarchy, potentially suspending
lcla_dev before the DMA controller. This could physically power off the SRAM
while active DMA transfers are still running.

> +		if (!pm_runtime_enabled(base->lcla_dev)) {
> +			pm_runtime_enable(base->lcla_dev);

[Severity: High]
Is it safe for a consumer driver to forcefully alter the core runtime PM
state of an external supplier device?

A consumer driver generally shouldn't manually manipulate the enable/disable
state of a supplier device it does not own.

If the supplier SRAM driver probes concurrently or manages its own state,
its call to pm_runtime_enable() will find disable_depth already at 0,
which could trigger an "Unbalanced pm_runtime_enable!" warning and
corrupt the device's internal power state machine.

> +			base->lcla_pm_enabled =3D true;
> +		}
>  	}
> =20
>  	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
[ ... ]
> @@ -3642,16 +3654,17 @@ static int __init d40_probe(struct platform_devic=
e *pdev)
>  				 SZ_1K * base->num_phy_chans,
>  				 DMA_TO_DEVICE);
> =20
> -	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
> +	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
> +	    base->lcla_pool.pages)
>  		free_pages((unsigned long)base->lcla_pool.base,
>  			   base->lcla_pool.pages);
> =20
>  	kfree(base->lcla_pool.base_unaligned);
> =20
> -	if (base->lcpa_regulator) {
> -		regulator_disable(base->lcpa_regulator);
> -		regulator_put(base->lcpa_regulator);
> -	}
> +	if (base->lcla_pm_enabled)
> +		pm_runtime_disable(base->lcla_dev);
> +	if (base->lcla_dev)
> +		put_device(base->lcla_dev);
>  	pm_runtime_disable(base->dev);

[Severity: High]
This is a pre-existing issue, but might this error path permanently disable
runtime PM on subsequent probe retries?

If d40_probe() encounters an error before pm_runtime_enable(base->dev) is
executed (for example, when lcla_pdev is not found and returns -EPROBE_DEFE=
R),
it jumps to destroy_cache.

This unconditionally calls pm_runtime_disable(base->dev), incrementing
disable_depth from 1 to 2. When the probe is retried and succeeds,
pm_runtime_enable() will only decrement the depth to 1, leaving the device
permanently disabled for runtime PM.

[Severity: High]
This is a pre-existing issue, but could the destroy_cache error path leak
the registered IRQ?

Earlier in d40_probe(), request_irq() is called to register the hardware
interrupt handler:

    ret =3D request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);

If a subsequent step fails, the function jumps to destroy_cache, which clea=
ns
up memory and DMA mappings but does not call free_irq().

The interrupt handler remains registered for a device whose driver data and
resources have been freed. If the hardware asserts an interrupt, the kernel
might execute the handler using freed memory.

> =20
>   report_failure:

[Severity: Critical]
This is a pre-existing issue, but does the validation logic for dev_type
allow an out-of-bounds write during channel allocation?

In d40_validate_conf(), conf->dev_type is validated against num_log_chans:

    if ((is_log && conf->dev_type > d40c->base->num_log_chans)

However, in d40_allocate_channel(), log_num is calculated as either
2 * dev_type or 2 * dev_type + 1. This allows log_num to reach up to
2 * 256 + 1 =3D 513.

The driver then writes to the lookup array:

    d40c->base->lookup_log_chans[d40c->log_num] =3D d40c;

Since lookup_log_chans is only sized to hold num_log_chans elements,
this results in a write past the end of the array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D8

