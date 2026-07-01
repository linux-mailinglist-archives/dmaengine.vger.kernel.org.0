Return-Path: <dmaengine+bounces-11925-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZEjcD43hRGo72goAu9opvQ
	(envelope-from <dmaengine+bounces-11925-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:44:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECE6EBB43
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 11:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QOB69mdI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11925-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11925-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C8EE300C7E8
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF23F44F4;
	Wed,  1 Jul 2026 09:44:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3B3B19BA;
	Wed,  1 Jul 2026 09:44:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899078; cv=none; b=t5cs3DElkOC66NgkSf6YvpuT+a5ovZeNKwYL764ON47I0RH669I3lFyalC925qjo7+KU/ZTKIx/gzVU7U2reXPZwMxXu890nAqn2nTq4nLNZi0E1xpYTbRhc5ZATOgHG/ea/rKVVcjS3WOE21JC2tL4wjUiOP3dH38/VY3ZGkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899078; c=relaxed/simple;
	bh=REubb9+hR5LF5Cm5xP0phK6/yMP+uOZanvzfbCg88wI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvVcLETYkLgJLCYZSuL1u+T2yY1jSXihHP5Bq4lCl7QmD5ez4pSkgXgwgcGqIBVuZdEYjt3KUUnH/POKgkblqM2/18bkTSe4dGGIUssEAxp1XSatAbj1ZBB9YfnEcS13WhyXXsuJTXrs4Q1mK+kH1GY0MnTj/OKfn+A7Vxmz7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOB69mdI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87531F000E9;
	Wed,  1 Jul 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899077;
	bh=1bnuYx82chblFbwsrXe0k9h/DsSFxLoocnAlUcsOv7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOB69mdI9dCccaIGMZtaQ9RnyrLbyXmK/5AgMAr3kNoklJxjIZmjomqJWy+GJUeG6
	 3nJjm60F1IUsPxi+IHGNvA1Hapfk7R1oZDItoFOc148Y4Ne0eplQXWpQXk8bSBvgYZ
	 5q07HGXne0Hirvamuu9jF9kmWVu5RU2MnXyDJvkpRSLrto3OWNd9Rm9LO5xOOlcuUA
	 bOtiHA88UqOknfp7+0qIscJ+Nygs7C3+3Nn/+11xbOFgZpb+W0lXHClBOAJ+icwSJd
	 agqHaW/9++MxldVmxR9OBVWiMr5kNFqTm7EtvYawAEdNP5ivXLU/Hld15smluZUdlU
	 qxNnot5Ad5W+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] dmaengine: fsl-edma: fix use-after-free after
 dev_pm_domain_detach()
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260701-b4-edma-runtime-opt-v6-5-354ff4229c00@oss.nxp.com>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-5-354ff4229c00@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:44:36 +0000
Message-Id: <20260701094436.B87531F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11925-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid];
	FORGED_RECIPIENTS(0.00)[m:joy.zou@oss.nxp.com,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35ECE6EBB43

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The fix moves a meaningless `pm_runtime_set_suspended()` call in=
stead of deleting it, creating dead code and an API misuse.

Pre-existing issues:
- [High] Use-after-free of device link pointer in the probe error path due =
to incorrect devres unroll ordering.
- [High] Missing PM runtime checks in `fsl_edma3_err_handler_per_chan` and =
`fsl_edma3_err_handler_shared` interrupt handlers.
- [High] The `fsl_edma_chan_runtime_suspend()` callback synchronizes the gl=
obal engine IRQs instead of the shared per-channel IRQs.
- [High] Runtime PM usage counter leak on the probe error path.
- [High] Unacknowledged hardware interrupts cause an IRQ storm and system l=
ockup if a channel is suspended.
--

commit be8ea96b6aa69c23219ef38987b11d3332453c91
Author: Joy Zou <joy.zou@nxp.com>

dmaengine: fsl-edma: fix use-after-free after dev_pm_domain_detach()

Remove pm_runtime_set_suspended() call after dev_pm_domain_detach()
to prevent use-after-free. When a power domain is attached via
dev_pm_domain_attach_by_id(), calling dev_pm_domain_detach()
unregisters and frees the underlying virtual device, making
fsl_chan->pd_dev a dangling pointer.

Accessing the freed pointer in pm_runtime_set_suspended() triggers
undefined behavior and potential crashes.

Fixes: ccfa3131d4a0 ("dmaengine: fsl-edma: implement the cleanup path of fs=
l_edma3_attach_pd()")

> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 3518dfb4292d2..266cc082a9f04 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -671,8 +671,8 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engin=
e *fsl_edma)
>  			fsl_chan->pd_dev_link =3D NULL;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does this attempt to delete
a device link that has already been purged and freed by the dmaengine devres
rollback?

If fsl_edma_probe() fails after successfully calling device_link_add(), the
devres unwinding triggers. First, dmaenginem_async_device_unregister()
executes, which unregisters chan_dev.=20

The driver core automatically purges and frees all device links associated
with this device, freeing fsl_chan->pd_dev_link. Next in the devres stack,
devm_fsl_edma3_detach_pd() executes and calls
device_link_del(fsl_chan->pd_dev_link), which could result in a
use-after-free.

>  		if (fsl_chan->pd_dev) {
> -			dev_pm_domain_detach(fsl_chan->pd_dev, false);
>  			pm_runtime_set_suspended(fsl_chan->pd_dev);
> +			dev_pm_domain_detach(fsl_chan->pd_dev, false);

[Severity: Medium]
The commit message states "Remove pm_runtime_set_suspended() call after
dev_pm_domain_detach()", but the call was moved to occur before detach rath=
er
than being completely deleted.

Since fsl_chan->pd_dev is a virtual device with disable_depth =3D=3D 0, doe=
sn't
pm_runtime_set_suspended() immediately return -EAGAIN and do nothing?

Should this call be completely removed to avoid dead code and API misuse?

>  		}
>  	}
>  }

While reviewing the file, I noticed a few additional pre-existing issues.

In drivers/dma/fsl-edma-main.c:fsl_edma3_err_handler_per_chan():

	fsl_edma3_err_check(fsl_chan);

[Severity: High]
This is a pre-existing issue, but does the per-channel error handler lack t=
he
necessary pm_runtime_get_if_active() check?

If a shared interrupt triggers or a spurious interrupt fires while the eDMA
hardware is suspended, these handlers invoke fsl_edma3_err_check(), which
performs direct MMIO register reads. Accessing registers on a suspended dev=
ice
with its clock disabled will crash the system.

A similar issue appears in fsl_edma3_err_handler_shared():

		fsl_edma3_err_check(&fsl_edma->chans[ch]);

[Severity: High]
This is a pre-existing issue, but the shared error handler accesses all
channel registers without verifying their PM runtime state.


In drivers/dma/fsl-edma-main.c:fsl_edma_chan_runtime_suspend():

	if (fsl_edma->txirq)
		synchronize_irq(fsl_edma->txirq);

	if (fsl_edma->errirq)
		synchronize_irq(fsl_edma->errirq);

[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback omit the
synchronize_irq() calls for the actual IRQF_SHARED IRQs requested for the
specific channel?

In fsl_edma_alloc_chan_resources(), the driver requests per-channel IRQs
using the IRQF_SHARED flag. However, fsl_edma_chan_runtime_suspend()
synchronizes the global engine IRQs instead of the channel's IRQs. Could a
per-channel IRQ handler execute concurrently while the channel hardware
clock/power is being disabled?


In drivers/dma/fsl-edma-main.c:fsl_edma_probe():

	ret =3D fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
	if (ret)
		return ret;

[Severity: High]
This is a pre-existing issue, but does this early return leak the PM usage
counter of pdev->dev and any already resumed channels?

During probe, the driver calls pm_runtime_resume_and_get(&pdev->dev) and
pm_runtime_resume_and_get(chan_dev), incrementing their usage counters. If =
an
error occurs subsequently, the function returns directly without dropping t=
he
counters, preventing the hardware from suspending upon subsequent unbind or
retry.


In drivers/dma/fsl-edma-main.c:fsl_edma_tx_handler():

		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <=3D 0)
			continue;

		if (intr & (0x1 << ch)) {
			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);

[Severity: High]
This is a pre-existing issue, but if the channel's PM reference cannot be
acquired, does the loop skip clearing the completion interrupt and leave the
hardware IRQ asserted?

If a channel with a pending interrupt is suspended or suspending,
pm_runtime_get_if_active() returns <=3D 0 and the handler skips the channel
using continue. Because the hardware interrupt source is never cleared, but
the handler returns IRQ_HANDLED, the interrupt controller will immediately
re-trigger the ISR, potentially causing an infinite IRQ storm and CPU locku=
p.

This also appears in fsl_edma_err_handler():

		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <=3D 0)
			continue;

		if (err & (0x1 << ch)) {
			fsl_edma_disable_request(&fsl_edma->chans[ch]);
			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);

[Severity: High]
This is a pre-existing issue, but it appears to skip clearing the error
interrupt here under the same conditions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-b4-edma-ru=
ntime-opt-v6-0-354ff4229c00@oss.nxp.com?part=3D5

