Return-Path: <dmaengine+bounces-11924-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TF+1FjnhRGou2goAu9opvQ
	(envelope-from <dmaengine+bounces-11924-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:43:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C06EBB22
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=STrTjRhT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11924-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11924-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A1373010930
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07063F86EE;
	Wed,  1 Jul 2026 09:43:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD425DB1A;
	Wed,  1 Jul 2026 09:43:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898994; cv=none; b=cwvgsdUx6TBN6biG9RwYOk+yyFoRl9Up4+jaSyBzbvA2oOUZga8/hp4Kocdf7b9dAuD59XjIoCIUU/GRi1+yEBZIFghniyNvEwK4xOSMXy6QiK2h03amBT/3RclkhAKvUGa+GlTysJbdKgtdwRNWdSEVXJ8cdwtbNISaUE5EQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898994; c=relaxed/simple;
	bh=3oypbR2G0KhTP9X0gIKhXMZ9n3aVt3WkbTCpBsRhYhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZ4/iMOTl7kI1btUa0rIl35lGhVDDjkc3CzIOxTBfmNe9ctkLwa0ww64ul2l/ptO/qf60TSW3CXk7LY3ZcSysJRCUvg3Quzq9Uju0vX4twq7sMcq1Wifyitnx8hb9lXhUncAHaeUK/4uxvG+ZWghnQ+a0xxsm+CyYHcZWFtbHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STrTjRhT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE61F000E9;
	Wed,  1 Jul 2026 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782898993;
	bh=/GMAOeDZ8kmpGBSLIasPqEz6hFSJRea6wWfKGN3FHa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STrTjRhT1ahSDW0JO1rR/ZuCNBJWRgPj/NQ1TWUDOExxyd1LEbebp1Q6+HkJMK9ws
	 b0vxyeh+/X+UjToLUuBRS0FiXL+1O3c0doScKtpeqFAjYezk0rGhvIB/MCUUihnhCv
	 TbZd5iLra90nKzVCh6VChdp9lLSuk//HMnSYG3ekiEtA5XcOlVKll30gG6ZLzd9vkv
	 QJQLmjv0HbVH91E3P1JR1ijfccWsyyEMAilJ5qda1shp+k5zX8VcZLETkOJ7bREUIn
	 IPEJX8Fi0U2gbV3Uvy5ePnX1ugYLux6B999S8CT+9xVcmoZ8Smi8C3IWJQI10OAgin
	 aNfCFnXD202GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] dmaengine: fsl-edma: add runtime suspend/resume
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-4-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-4-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:43:12 +0000
Message-Id: <20260701094312.B0EE61F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11924-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_RECIPIENTS(0.00)[m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D55C06EBB22

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Skipping hardware interrupt acknowledgment for inactive PM channel=
s leads to an unrecoverable infinite IRQ storm.
- [High] The channel runtime suspend callback calls `synchronize_irq()` wit=
h a negative error code and fails to synchronize actual per-channel shared =
IRQs.
- [High] Accessing a freed `device_link` in `fsl_edma3_detach_pd()` due to =
devres teardown order inversion.
- [Medium] The DMA engine and its channels are exposed to clients before th=
eir IRQs and runtime PM domains are fully initialized.
- [Medium] Runtime PM usage counters for the engine device and channel powe=
r domains are permanently leaked on multiple error paths during probe.
--

commit a5800ff547600d938eb443a21684d6291b4658d1
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: add runtime suspend/resume support

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index fe02b68d75fd3..3518dfb4292d2 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -37,15 +37,27 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void =
*dev_id)
>  	unsigned int intr, ch;
>  	struct edma_regs *regs =3D &fsl_edma->regs;
> =20
> +	if (pm_runtime_get_if_active(fsl_edma->dma_dev.dev) <=3D 0)
> +		return IRQ_NONE;
> +
>  	intr =3D edma_readl(fsl_edma, regs->intl);
> -	if (!intr)
> +	if (!intr) {
> +		pm_runtime_put(fsl_edma->dma_dev.dev);
>  		return IRQ_NONE;
> +	}
> =20
> +	pm_runtime_put(fsl_edma->dma_dev.dev);
>  	for (ch =3D 0; ch < fsl_edma->n_chans; ch++) {
> +		struct fsl_edma_chan *fsl_chan =3D &fsl_edma->chans[ch];
> +
> +		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <=3D 0)
> +			continue;
> +
>  		if (intr & (0x1 << ch)) {
>  			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
>  			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
>  		}
> +		pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
>  	}
>  	return IRQ_HANDLED;
>  }

[Severity: High]
If a channel is runtime suspended (e.g., due to a hardware race or a spurio=
us
interrupt), the interrupt bit is never cleared because the loop evaluates
pm_runtime_get_if_active() <=3D 0 and continues to the next iteration.

However, the function ultimately returns IRQ_HANDLED unconditionally.=20
Could returning IRQ_HANDLED without clearing the hardware interrupt flag=20
trick the interrupt controller into thinking the event was serviced,=20
potentially leading to an infinite IRQ storm?

This same pattern appears in fsl_edma_err_handler() and=20
fsl_edma3_or_err_handler().

[ ... ]

> @@ -691,6 +711,36 @@ static int fsl_edma3_attach_pd(struct platform_devic=
e *pdev, struct fsl_edma_eng
>  	return -EINVAL;
>  }
> =20
> +/* Per channel dma power domain */
> +static int fsl_edma_chan_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan =3D dev_get_drvdata(dev);
> +	struct fsl_edma_engine *fsl_edma =3D fsl_chan->edma;
> +
> +	if (fsl_edma->txirq)
> +		synchronize_irq(fsl_edma->txirq);
> +
> +	if (fsl_edma->errirq)
> +		synchronize_irq(fsl_edma->errirq);
> +
> +	clk_disable_unprepare(fsl_chan->clk);
> +
> +	return 0;
> +}

[Severity: High]
Are we synchronizing the correct IRQs before disabling the channel clock?

During probe, global IRQs like fsl_edma->txirq are initialized to -EINVAL=20
for SoCs using per-channel IRQs. This check evaluates to true because -EINV=
AL
is non-zero, causing a negative error code to be passed to synchronize_irq(=
).

Additionally, this code doesn't synchronize the channel-specific shared=20
IRQ (fsl_chan->txirq). Could this allow a shared IRQ handler to execute=20
and access hardware after the clock is disabled?

[ ... ]

> @@ -891,6 +917,64 @@ static int fsl_edma_probe(struct platform_device *pd=
ev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Can't register Freescale eDMA engine.\n");
> =20
> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Can't enable eDMA engine PM run=
time!\n");
> +
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to resume eDMA engine!\n=
");
> +
> +	ret =3D fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> +	if (ret)
> +		return ret;

[Severity: Medium]
By calling dmaenginem_async_device_register() just prior to enabling=20
runtime PM and setting up IRQs, do we expose the channels to clients=20
prematurely?

If a client allocates a channel concurrently before runtime PM is enabled,=
=20
fsl_edma_alloc_chan_resources() will invoke pm_runtime_resume_and_get(),=20
which could fail with -EINVAL.

[Severity: Medium]
If fsl_edma->drvdata->setup_irq() fails here, we return the error code=20
directly. Does this leave the pdev->dev usage counter permanently=20
incremented from the pm_runtime_resume_and_get() call just above?

> +	for (i =3D 0; i < fsl_edma->n_chans; i++) {
> +		struct fsl_edma_chan *fsl_chan =3D &fsl_edma->chans[i];
> +		struct device *chan_dev;
> +
> +		if (fsl_edma->chan_masked & BIT(i))
> +			continue;
> +
> +		chan_dev =3D &fsl_chan->vchan.chan.dev->device;
> +		dev_set_drvdata(chan_dev, fsl_chan);
> +		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
> +
> +		if (fsl_chan->pd_dev) {
> +			fsl_chan->pd_dev_link =3D device_link_add(chan_dev, fsl_chan->pd_dev,
> +								DL_FLAG_STATELESS |
> +								DL_FLAG_PM_RUNTIME);
> +			if (!fsl_chan->pd_dev_link) {
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "Failed to add device_link to %d!\n", i);
> +			}
> +		}

[Severity: High]
Could the teardown order of these stateless device links result in a=20
use-after-free on probe failure or driver unbind?

Earlier in probe, devm_fsl_edma3_detach_pd is registered as a devres=20
cleanup action before the DMA engine is registered.=20

However, the stateless device link is added here with the channel device=20
(chan_dev) as the consumer. On unbind or probe failure, devres actions=20
execute in reverse order:

1. The DMA engine unregisters, destroying chan_dev.
2. The driver core automatically purges and frees all device links attached=
=20
   to the deleted device.
3. devm_fsl_edma3_detach_pd executes and calls device_link_del() on the=20
   now-freed fsl_chan->pd_dev_link.

> +		ret =3D devm_pm_runtime_enable(chan_dev);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Can't enable eDMA channel PM runtime!\n");
> +
> +		if (fsl_chan->pd_dev) {
> +			ret =3D pm_runtime_resume_and_get(fsl_chan->pd_dev);
> +			if (ret)
> +				return dev_err_probe(&pdev->dev, ret,
> +						     "Failed to power on eDMA channel %d!\n",
> +						     fsl_chan->vchan.chan.chan_id);
> +		}
> +
> +		ret =3D pm_runtime_resume_and_get(chan_dev);
> +		if (ret < 0) {
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to resume eDMA channel %d!\n",
> +					     fsl_chan->vchan.chan.chan_id);
> +		}

[Severity: Medium]
If pm_runtime_resume_and_get(chan_dev) fails here, we return directly.
Does this leak both the engine's usage counter (pdev->dev) and the channel=
=20
power domain's usage counter (fsl_chan->pd_dev) acquired earlier in this=20
function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-edma-ru=
ntime-opt-v6-0-354ff4229c00@oss.nxp.com?part=3D4

