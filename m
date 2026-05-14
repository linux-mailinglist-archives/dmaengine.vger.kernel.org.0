Return-Path: <dmaengine+bounces-10467-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJmqEcJjBWqOVwIAu9opvQ
	(envelope-from <dmaengine+bounces-10467-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:55:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF553E209
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 07:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4E7301E3C1
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32439EB4B;
	Thu, 14 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op+pnWRx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CB30E0CC;
	Thu, 14 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738110; cv=none; b=E1ODzK58sElSvxwyNxdKXYO5kWtLRw5aGAP7zrpnnfjDUVFwxkq9ZhDgqhQVg0eENI11NJvqnn+ce3tFJNOBDdpfSRMolrHVpq/XF6MpUMByPdBKZA6VRFIu9lk/VLKFG/3irE51dvfD8U9qNrQxgJadSwUpNuD3/VqOCrC36lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738110; c=relaxed/simple;
	bh=RAdR8/gNXVMQT+EGlj4+JLWsFJzkqXct04sDr14+dXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qxMG4lstbkoMZ9VFUTx8ZV2tX0WRUG43/EwfrpaBTFEW6dfJCPKgrFLmGQWh9xKQ64BSIQ2KbbLqvycYnTyDksifOVenQLcCcDGB7mhO9/hZdY05jyXG33ZFZeBn8isJnRKU+sLq/Sda9JzF7/ixi757rjZ2e48L6NwKpp9so4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op+pnWRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A379BC2BCB7;
	Thu, 14 May 2026 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778738109;
	bh=RAdR8/gNXVMQT+EGlj4+JLWsFJzkqXct04sDr14+dXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=op+pnWRxbC2gqQ8Aau0NMY/CPkR0jRXsWcS57t+su+gigjQAzjndXOYCPCBTK0G26
	 AA3tNUpoBMmynzz/q5SdX1Rb1uIoJmFFo1Ryk+v1QVc0699kC7bm+ORGAifjCmLDoN
	 mHnA7hG1CFATLjhHH+673iRaxiv6PZxKtd01eCoKancUTleEc6/6Pigs3cX/hXzw+9
	 BGYoMMdT53DGTwcaIkiiofw8z1opDg3uh4PnhCGVMDn/Pxe4YfUKJQH5jtMVwIvwMv
	 7iKkUqO/lmNikaumfUMA4WuqO4gdcdq5UecO7qfLEgkQaGo1ymPhRCSfksbkX+/d4x
	 zKc14NJOvTteg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] dmaengine: fsl-edma: add runtime suspend/resume
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joy Zou" <joy.zou@nxp.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-4-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-4-1e595bfb8423@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:55:09 +0000
Message-Id: <20260514055509.A379BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 97CF553E209
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10467-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Double-free and Use-After-Free in the probe error path if devi=
ce_link_add() fails.
- [Critical] Use-After-Free during driver unbind due to manual device link =
deletion after core purging.
- [Critical] Pre-existing Use-After-Free vulnerability in `fsl_edma3_detach=
_pd`.
- [Critical] Unclocked register access in shared IRQ handlers causing syste=
m crashes.
- [High] Initialization race condition exposing uninitialized DMA channels =
to consumers.
- [High] System hang risk due to enabling channel clocks before their corre=
sponding power domains are resumed.
- [High] Unbalanced clock disable and CCF underflow on driver removal.
- [High] Hardware remains inaccessible, crashing the system if CONFIG_PM is=
 disabled.
- [High] Unclocked register access during system resume (`resume_early`).
--

commit 29a9c658afa0aacc5ffd271f1b4ac1fc006b0536
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: add runtime suspend/resume support

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index c12126ea6552d..9446a0c3bc576 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -629,7 +629,6 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engin=
e *fsl_edma)
>  			device_link_del(fsl_chan->pd_dev_link);

During driver unbind, the devres cleanups are executed in reverse order.
The DMA engine and its channel devices are unregistered first via
dmaenginem_async_device_unregister(), which triggers device_links_purge()
to delete all links where the channel is a consumer.=20

When the devres action later calls fsl_edma3_detach_pd() and reaches this
device_link_del(), will it cause a use-after-free by attempting to delete
a link that has already been purged by the driver core?

>  		if (fsl_chan->pd_dev) {
>  			dev_pm_domain_detach(fsl_chan->pd_dev, false);
> -			pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
>  			pm_runtime_set_suspended(fsl_chan->pd_dev);

This issue pre-dates the patch, but could this cause a use-after-free?

For power domains attached via dev_pm_domain_attach_by_id(), calling
dev_pm_domain_detach() unregisters and frees the underlying virtual device.
Passing fsl_chan->pd_dev to pm_runtime_set_suspended() immediately after
appears to use a freed pointer.

[ ... ]

> @@ -684,6 +668,29 @@ static int fsl_edma3_attach_pd(struct platform_devic=
e *pdev, struct fsl_edma_eng
>  	return -EINVAL;
>  }
> =20
> +/* Per channel dma power domain */
> +static int fsl_edma_chan_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(fsl_chan->clk);
> +
> +	return 0;
> +}

Does this function need to call synchronize_irq() before disabling the cloc=
k?

Since the driver uses shared interrupts (IRQF_SHARED), if another device on
the same IRQ line triggers an interrupt while the channel is suspended,
the eDMA interrupt handler might attempt to read hardware registers while t=
he
clock is disabled.

Should the interrupt handlers (like fsl_edma3_tx_handler) also use
pm_runtime_get_if_active() to ensure the device is powered before checking
status registers?

[ ... ]

> @@ -869,6 +872,51 @@ static int fsl_edma_probe(struct platform_device *pd=
ev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "Can't register Freescale eDMA engine.\n");

Is there a race condition here?

By calling dmaenginem_async_device_register() before setting up the runtime
PM domains and hardware registers below, clients can immediately request a
channel.

If a client allocates a channel concurrently, it could call
fsl_edma_alloc_chan_resources() before devm_pm_runtime_enable() is called,
or race with the unconditional clk_disable_unprepare() and edma_write_tcdre=
g()
in the loop below, potentially corrupting hardware state.

> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Can't enable eDMA engine PM run=
time!");
> +
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
> +				fsl_edma3_detach_pd(fsl_edma);
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "Failed to add device_link to %d\n", i);

If device_link_add() fails, fsl_edma3_detach_pd() is called manually to det=
ach
domains and delete links, but it doesn't clear the pointers.

Since devm_fsl_edma3_detach_pd() was already registered as a devres action
earlier in probe, returning an error here will cause the devres framework to
call fsl_edma3_detach_pd() a second time. Could this lead to a double-free
of the device link and double-detach of the PM domain?

> +			}
> +		}
> +		ret =3D devm_pm_runtime_enable(chan_dev);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Can't enable eDMA channel PM runtime!");
> +
> +		if (fsl_chan->pd_dev) {
> +			ret =3D pm_runtime_resume_and_get(fsl_chan->pd_dev);

Since the earlier loop in probe acquires the channel clocks with
devm_clk_get_optional_enabled(), the clocks are already enabled before we
reach this point.

Because the previous DL_FLAG_RPM_ACTIVE flag was removed from the device li=
nk,
does enabling the channel clock before its parent power domain is resumed
risk an asynchronous external abort on NXP SoCs?

> +			if (ret)
> +				return dev_err_probe(&pdev->dev, ret,
> +						     "Failed to power on eDMA channel %d\n",
> +						     fsl_chan->vchan.chan.chan_id);
> +		}
> +
> +		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
> +		fsl_edma_chan_mux(fsl_chan, 0, false);
> +		clk_disable_unprepare(fsl_chan->clk);

If the kernel is compiled with CONFIG_PM=3Dn, pm_runtime_resume_and_get()
evaluates to 1 (success) but does not call the runtime PM resume callbacks.

By unconditionally disabling the clocks here, do they remain permanently
disabled when CONFIG_PM=3Dn, leading to bus faults on subsequent DMA reques=
ts?

> +		if (fsl_chan->pd_dev)
> +			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
> +	}
> +
>  	ret =3D devm_of_dma_controller_register(&pdev->dev, np,
>  			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
>  			fsl_edma);
> @@ -880,6 +928,9 @@ static int fsl_edma_probe(struct platform_device *pde=
v)
>  	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
>  		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> =20
> +	clk_disable_unprepare(fsl_edma->dmaclk);
> +	clk_bulk_disable_unprepare(fsl_edma->drvdata->dmamuxs, fsl_edma->muxclk=
);

These clocks were acquired using devm_clk_get_optional_enabled() earlier in
probe.

If they are manually disabled here, and the device is suspended during
driver unbind, won't the devres cleanup attempt to disable them again,
causing a Common Clock Framework underflow warning?

Similarly, if CONFIG_PM=3Dn, these engine clocks will never be re-enabled.

[ ... ]

> @@ -928,6 +992,13 @@ static int fsl_edma_resume_early(struct device *dev)
>  		fsl_chan =3D &fsl_edma->chans[i];
>  		if (fsl_edma->chan_masked & BIT(i))
>  			continue;
> +
> +		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
> +		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
> +		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
> +		     !fsl_chan->srcid))
> +			continue;
> +
>  		fsl_chan->pm_state =3D RUNNING;
>  		edma_write_tcdreg(fsl_chan, 0, csr);
>  		if (fsl_chan->srcid !=3D 0)
> @@ -940,6 +1011,35 @@ static int fsl_edma_resume_early(struct device *dev)
>  	return 0;
>  }

Before returning, fsl_edma_resume_early() writes to regs->cr:

    if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
        edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);

If all channels were idle prior to system suspend, the eDMA engine is in a
runtime-suspended state and dmaclk is gated. Since the PM core doesn't
automatically wake runtime-suspended devices during resume_early, could
writing to regs->cr while dmaclk is gated trigger a bus fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-b4-b4-edma=
-runtime-opt-v5-0-1e595bfb8423@nxp.com?part=3D4

