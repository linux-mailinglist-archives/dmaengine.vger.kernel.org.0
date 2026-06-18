Return-Path: <dmaengine+bounces-11604-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gLg+APR9M2rKCgYAu9opvQ
	(envelope-from <dmaengine+bounces-11604-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:11:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6995269DA45
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:11:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mNIdeYWT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11604-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11604-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AAE304B7FA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECC37E300;
	Thu, 18 Jun 2026 05:11:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96637DEAA;
	Thu, 18 Jun 2026 05:11:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759473; cv=none; b=eatXMTcmd8wPzd273x/I7EG0sypkBtzFY5hXEqFSM+7BVpn3RfJj7TvW9CYrpzlj7chHhX9oparcxGu+EFtYp3elZ5eyBfNN9GjMOmksQ11kktJ7CQ94CYMqD2WvAfeIIj3bPMHF1jC2TWzhNOuotMytN3qxPketgEevpOOKnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759473; c=relaxed/simple;
	bh=TMF0pLR1tUNyDuHvJ3t9/PPhBjuvoNWQkS3pIHaJzzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bj0tnph7PI+cNQzMctKt0setBodpIWqiISpF6FCMD38D+gHrr1hDLTxFtbX9rsAsKFabiaB5Z0lGDxpYDFa6i+wz1+Ras8wicgdvc2lx2mR6QJDbKwJ4s45JImTAJ1GpFLGR5HXhW+LTdef3bn2uell/2Lj/CdHwapS198i+8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNIdeYWT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715B41F000E9;
	Thu, 18 Jun 2026 05:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759471;
	bh=EcafC8p6Ak4Dofze3k3WQ4urTBYybz+2V7C98WnSf4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNIdeYWThLmchIyYp4x6zVBW/NNcQRd/MsyoRXaVL7aYnma+jfy6A44ckIyiTATde
	 82VgJjBcEObVw4qNeTINX2ooTZotP22pUT8jP7MXFeMTCSTlUqK3KSxNjY9Uz+m7t5
	 qZ0ncTZzsLw2Aw8ddj8mbKs9G1oVqBacMVpLz3uVx8Vq36nBnFR2w/Z1B45Aj0OKqn
	 mp+PLzYlrVLeW6rxhhFsVq/51FC3JAJKZUj9R1y2uHQUFv+ngUrZFYTjZwcWllQyqi
	 Ra4jW8VyINNq7aZtq4f7z6QSYy8H/r6NxBDrbxFHnz/gIz9/BB6levoQD4MCNH7K+K
	 yYu1u7QsbAvzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] drm/mcde: Use power domain for display power
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org, vkoul@kernel.org, robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-7-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-7-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:11:11 +0000
Message-Id: <20260618051111.715B41F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11604-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6995269DA45

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect return value check for pm_runtime_put_sync_suspend(), tr=
eating success as an error.
- [High] Resource leak of the main clock (mcde_clk) on the probe error path.
--

commit 1e2436e1c266a49af52c126fb77756c71e5e0e91
Author: Linus Walleij <linusw@kernel.org>

drm/mcde: Use power domain for display power
   =20
Replace explicit EPOD regulator handling with runtime PM.
Use the MCDE power domain and drop the regulator dependency.

> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/m=
cde_display.c
> index 257a6e84dd583..52f071bb347c4 100644
> --- a/drivers/gpu/drm/mcde/mcde_display.c
> +++ b/drivers/gpu/drm/mcde/mcde_display.c

[ ... ]

> @@ -1327,9 +1326,9 @@ static void mcde_display_disable(struct drm_simple_=
display_pipe *pipe)
>  		spin_unlock_irq(&crtc->dev->event_lock);
>  	}
> =20
> -	ret =3D regulator_disable(mcde->epod);
> +	ret =3D pm_runtime_put_sync_suspend(mcde->dev);
>  	if (ret)
> -		dev_err(drm->dev, "can't disable EPOD regulator\n");
> +		dev_err(drm->dev, "can't disable MCDE power domain\n");

[Severity: High]
According to the Runtime PM API contract, pm_runtime_put_sync_suspend()
returns 1 when the device is already in the RPM_SUSPENDED state. Is it
intentional to treat a positive return value as an error here? If the device
is already suspended, this will log a false-positive error.

>  	/* Make sure we are powered down (before we may power up again) */
>  	usleep_range(50000, 70000);
> =20
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_=
drv.c
> index 5f2c462bad7e1..3f966cccda5a3 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c

[ ... ]

> @@ -412,14 +392,15 @@ static int mcde_probe(struct platform_device *pdev)
> =20
>  	/*
>  	 * Perform an invasive reset of the MCDE and all blocks by
> -	 * cutting the power to the subsystem, then bring it back up
> +	 * powering down the subsystem, then bring it back up
>  	 * later when we enable the display as a result of
>  	 * component_master_add_with_match().
>  	 */
> -	ret =3D regulator_disable(mcde->epod);
> +	ret =3D pm_runtime_put_sync_suspend(dev);
>  	if (ret) {
> -		dev_err(dev, "can't disable EPOD regulator\n");
> -		return ret;
> +		dev_err(dev, "can't disable MCDE power domain\n");
> +		pm_runtime_get_noresume(dev);
> +		goto clk_disable;
>  	}

[Severity: High]
Does this incorrectly abort the probe sequence if the device is already
suspended?=20

pm_runtime_put_sync_suspend() returns 1 if the device was already in the
RPM_SUSPENDED state, which is a success condition, but the if (ret) check
here treats it as a failure.

>  	/* Wait 50 ms so we are sure we cut the power */
>  	usleep_range(50000, 70000);

[ ... ]

> @@ -428,25 +409,18 @@ static int mcde_probe(struct platform_device *pdev)
>  					      match);
>  	if (ret) {
>  		dev_err(dev, "failed to add component master\n");
> -		/*
> -		 * The EPOD regulator is already disabled at this point so some
> -		 * special errorpath code is needed
> -		 */
> -		clk_disable_unprepare(mcde->mcde_clk);
> -		regulator_disable(mcde->vana);
> -		return ret;
> +		goto clk_disable_pm_disabled;
>  	}
> =20
>  	return 0;
> =20
>  clk_disable:
>  	clk_disable_unprepare(mcde->mcde_clk);
> -regulator_off:
> -	regulator_disable(mcde->vana);
> -regulator_epod_off:
> -	regulator_disable(mcde->epod);
> +pm_runtime_put:
> +	pm_runtime_put_sync_suspend(dev);
> +clk_disable_pm_disabled:
> +	pm_runtime_disable(dev);
>  	return ret;
> -
>  }

[Severity: High]
Does this code leak the main clock when component_master_add_with_match()
fails?=20

The goto clk_disable_pm_disabled jump skips over the clk_disable label, so
clk_disable_unprepare(mcde->mcde_clk) is never called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D7

