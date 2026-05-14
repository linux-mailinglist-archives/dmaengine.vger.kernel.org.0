Return-Path: <dmaengine+bounces-10461-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDoeINA7BWpNTgIAu9opvQ
	(envelope-from <dmaengine+bounces-10461-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:04:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5353D3E0
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 039F23019031
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD42D876B;
	Thu, 14 May 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLmUr1Y5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAD2D7D2E
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778727885; cv=none; b=gesJbml9izrdFCkjLCZqTptbZ8GwfVw/fHyBaoawVTeBloVAAY119Rf56cpo0bXF8omLR40S6uwulLmc12hEb+v6zZquHWfNZpcrrg5BUG7ed+j1vbLZ3TD0nphxfBWayiVJ51Em4Ud3zoRpbWzfTS9HHc2+eZJz1fe9ZDC6oTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778727885; c=relaxed/simple;
	bh=Iz83t2HlLaPce0fnJL7xhIPSZlLfPtvzppyZtRcX0CM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lq8fRkXcGrHR+CJVEqw03u3ryNWZPOYbels/LI3lm0tGL8JaPnOaW0DV/vd6ATZGcq2FycK+Mu5OAnWEY1QCjbPcgosR4Edn1Y3iM33dJrZJi9DhNsyUywnY+JpwbLFE9tR23ZGeCy6Ze395xpTzjjzT8tvWJGYWrQf44sa47rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLmUr1Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB202C19425;
	Thu, 14 May 2026 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778727885;
	bh=Iz83t2HlLaPce0fnJL7xhIPSZlLfPtvzppyZtRcX0CM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kLmUr1Y5dgtHs9Gdokil5uc6SreTQ3Yzq6m76NHAoyzYj2cdrHkbqiZVyI1IyFYjw
	 TGZJTeKdDUQNDwShr+BPQiPY1udWckwgGX9TBNatjYQgfZoU5sjuNXGkAR1cCqZsyY
	 zr2u7kFlIhBLMHc0dkHTGGpMJ0wgTsSyXGMpNKeRXHsLQqGVb9e444533Dy7gtBZie
	 iFpBvAplMIEyO2GsiYZakD57U6+Ik4HAIsrLjt5V4HNpLciZAcowhCgkNylw1t/cH7
	 0IaMHuWsmlk4h3wCAAVymPSiXOJITy2PB6W4su24AEnaTdFi3A/XoGl0noVVoCbgqs
	 YsVpcKyLjlkdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260512121219.216159-15-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-15-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:04:44 +0000
Message-Id: <20260514030444.EB202C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 22E5353D3E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10461-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Returning -EAGAIN from `prepare` callback causes PM core busy-wait=
 livelock
- [High] Race condition with non-cyclic channels during system suspend
- [High] Spurious timeouts on resume for short non-cyclic DMA transfers
- [High] Data loss for cyclic channels due to incomplete context restoration
- [Low] Cleanup framework violation by mixing goto-based error handling and=
 scope-based guard()
- [Low] PM callback conditional compilation subsystem guide violation
--

commit 536ec6e9c07fa47423de7d20ebc829e45cbcedfb
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: dmaengine: sh: rz-dmac: Add suspend to RAM support

This commit adds suspend to RAM support for the Renesas RZ/G3S SoC by
saving and restoring the DMA IP registers. It adds specific suspend and
resume handling for cyclic channels, and waits for non-cyclic channels
to finish before suspending.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index df91657fd5e3d..b0a8590f4a9da 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
[ ... ]
> @@ -1002,20 +1008,57 @@ static int rz_dmac_device_pause(struct dma_chan *=
chan)
>  	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED=
));
>  }
> =20
[ ... ]
>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  				     unsigned long clear_bitmask)
>  {
> -	int ret =3D 0;
>  	u32 val;
> +	int ret;
> =20
>  	lockdep_assert_held(&channel->vc.lock);
> =20
[ ... ]
> +	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
> =20
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>  	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> +				       ((val & (CHSTAT_SUS | CHSTAT_EN)) =3D=3D CHSTAT_EN),
> +				       1, 1024, false, channel, CHSTAT, 1);

Can this condition time out spuriously for short non-cyclic DMA transfers? =
If
a transfer finishes successfully before the first poll read, the hardware
would clear CHSTAT_EN to 0. The polling condition would then evaluate to
false, causing the macro to incorrectly return -ETIMEDOUT.

> =20
>  	channel->status &=3D ~clear_bitmask;
> =20
[ ... ]
> @@ -1406,6 +1459,151 @@ static void rz_dmac_remove(struct platform_device=
 *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
> =20
> +static int rz_dmac_suspend_prepare(struct device *dev)
> +{
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		/* Wait for transfer completion, except in cyclic case. */
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
> +			continue;
> +
> +		if (rz_dmac_chan_is_enabled(channel))
> +			return -EAGAIN;

Could returning -EAGAIN here cause a CPU livelock? In dpm_prepare(), an
-EAGAIN error is cleared and retried continuously in a while
(!list_empty(&dpm_list)) loop. Since the device is not advanced on error,
the PM core might loop infinitely without any backoff until the transfer
completes.

Also, is there a race condition with non-cyclic channels after this callback
returns 0? Since the DMA controller's prepare callback runs before consumer
peripherals, an active consumer could immediately submit new non-cyclic
transfers before the actual suspend phase begins.

> +	}
> +
> +	return 0;
> +}
> +
[ ... ]
> +static int rz_dmac_suspend(struct device *dev)
> +{
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);

This isn't a bug, but does this function mix scope-based guard() cleanup
with goto-based error handling? The cleanup guidelines suggest that
functions should either convert all resources to scope-based cleanup or
convert none of them to avoid confusing ownership semantics.

> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		ret =3D rz_dmac_device_pause_internal(channel);
> +		if (ret) {
> +			dev_err(dev, "Failed to suspend channel %s\n",
> +				dma_chan_name(&channel->vc.chan));
> +			break;
> +		}
> +
> +		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);

Does saving only the NXLA register result in data loss for cyclic channels?
When a cyclic channel is paused, it stops at its current descriptor. Without
saving and restoring the Current Link Address and Current Transfer Byte
count, resuming the channel might force it to skip the remaining bytes of t=
he
interrupted descriptor and start fetching the next one.

> +	}
> +
> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret =3D reset_control_assert(dmac->rstc);

Since non-cyclic channels are unconditionally skipped in the loop above and
the hardware reset is asserted here, could newly queued non-cyclic requests
from consumers be violently interrupted mid-transfer?

> +	if (ret)
> +		goto suspend_recover;
> +
> +	ret =3D pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		goto reset_deassert;
> +
> +	return 0;
> +
> +reset_deassert:
> +	reset_control_deassert(dmac->rstc);
> +suspend_recover:
> +	rz_dmac_suspend_recover(dmac);
> +	return ret;
> +}
> +
[ ... ]
> +static const struct dev_pm_ops rz_dmac_pm_ops =3D {
> +	.prepare =3D rz_dmac_suspend_prepare,

This isn't a bug, but should rz_dmac_suspend_prepare be wrapped in
pm_sleep_ptr() here? The power management subsystem guidelines recommend
using pm_sleep_ptr() for individual callbacks within the ops structure to
prevent dead code and unused variable warnings when CONFIG_PM_SLEEP is
disabled.

> +	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
> +};
> +
>  static const struct rz_dmac_info rz_dmac_v2h_info =3D {
>  	.icu_register_dma_req =3D rzv2h_icu_register_dma_req,
>  	.default_dma_req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> @@ -1432,6 +1630,7 @@ static struct platform_driver rz_dmac_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "rz-dmac",
>  		.of_match_table =3D of_rz_dmac_match,
> +		.pm	=3D pm_sleep_ptr(&rz_dmac_pm_ops),

This isn't a bug, but should pm_ptr() be used for the dev_pm_ops structure
pointer instead of pm_sleep_ptr()? The power management guidelines recommend
using pm_ptr() for the structure pointer, while reserving pm_sleep_ptr() for
the individual sleep callbacks inside the structure.

>  	},
>  	.probe		=3D rz_dmac_probe,
>  	.remove		=3D rz_dmac_remove,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D14

