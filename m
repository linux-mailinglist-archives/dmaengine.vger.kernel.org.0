Return-Path: <dmaengine+bounces-11448-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DUZiIu5WKmq2ngMAu9opvQ
	(envelope-from <dmaengine+bounces-11448-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:34:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98566F0DF
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WN2Cd1cS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11448-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11448-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C865130D9658
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCC360EC9;
	Thu, 11 Jun 2026 06:28:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08735F191
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 06:28:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159334; cv=none; b=iok3e/8eQhlaUBFTDryTS84GxBv6rOK4EVG/pSlowctlL9MJMoxCDweoo8pcDmWCLrgto3LrgfiwjMC2BrJVuQ0NzTY0fnfU4SpmbSJOAGi4d0ocXIZXrOEERb9CwTMNaONM6EkNKQtOW9GEqz5BTgCCpjH17oL73zydB5um1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159334; c=relaxed/simple;
	bh=bBmRBWvCbRQ5teMs75gwLMrUN2d7FWzI8oeYrxjhnR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMzKiayWttWO9OjCHXxSdVFEsZOzZn3wyPSFokhAzSUhJMpLDkqNJGR/kWE3akqFaA7AibGJWt1iCCeK2A8CTBMW1VOmBmkQSlBewo2X69Fv2dMjC9OGKHJwvztvwcPtf67JHTk6kW4NHuRtGmu8npjiNsUz1XIPFhp9IZS9u7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN2Cd1cS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8D01F00893;
	Thu, 11 Jun 2026 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781159319;
	bh=JaHcfjnG+w3u/f2v4LJhmN9eYCUnkWU7PvdAPDN1/co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WN2Cd1cSgUXixeZDTNX8xv7Rb5ljgApOdN7fac5qZnzwfZomMfnfwwNMXf65qTcg9
	 sGw6XoabAol58dLRwbvNu+F/AybMc3wTBguaITM6KFmk8X2KoN0LQr++Vbl2i24P/B
	 OLAaHsQd4nYw+HDPLKwu7HRArH+WmP03h3jrjHS8tv/YDexXfa5xEkWuqGz2sCLyMg
	 yhEfeZ5WEh4YMtg8w25Mro1zdVKmRJa+sPcgEdx3Nx6A6r2lzkUL69nkJOF1k938Jg
	 mosKSsdA5vbZg3Plne3cnO6O8X1YGgPQcqKNGLCraUWYwJY1LqUaTFxmHINKTb3LAW
	 /JDQEnh1b3OxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Defer IRQ trigger type to
 device tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishnu Santhosh" <vishnu.santhosh@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611-qcom-bam-dma-irq-trigger-v1-1-21c216e00b2a@oss.qualcomm.com>
References: <20260611-qcom-bam-dma-irq-trigger-v1-1-21c216e00b2a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:28:38 +0000
Message-Id: <20260611062838.CE8D01F00893@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11448-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vishnu.santhosh@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB98566F0DF

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Allowing edge-triggered interrupts without a polling loop in the h=
andler introduces a race condition that permanently deadlocks the DMA contr=
oller.

Pre-existing issues:
- [High] bam_dma_remove accesses hardware registers after forcing PM runtim=
e suspend, leading to unclocked register accesses and system crash.
- [High] The probe error path cleans up tasklets and disables clocks before=
 freeing the interrupt, leading to a use-after-free and unclocked access ra=
ce condition.
- [High] The interrupt is requested before PM runtime is fully enabled, cau=
sing a permanent interrupt storm if an interrupt fires during probe.
- [High] Failure paths after `pm_runtime_get_sync()` return without decreme=
nting the PM usage counter, causing an unbalanced usage count and leaking D=
MA resources.
- [High] The interrupt handler unconditionally returns IRQ_HANDLED even for=
 spurious interrupts, defeating the kernel's spurious interrupt detection.
--

commit ee883954f4570a653a82ea860b70acc6baa4eada
Author: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date:   Thu Jun 11 06:17:11 2026 +0000

dmaengine: qcom: bam_dma: Defer IRQ trigger type to device tree

This commit changes the hardcoded IRQF_TRIGGER_HIGH flag to=20
IRQF_TRIGGER_NONE when registering the BAM interrupt. This delegates the
trigger type configuration to the device tree, resolving missed DMA
completions on platforms that use edge-triggered interrupts.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 19116295f8325..6c3e2ca8a572f 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1303,7 +1303,7 @@ static int bam_dma_probe(struct platform_device *pd=
ev)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
> =20
>  	ret =3D devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> +			IRQF_TRIGGER_NONE, "bam_dma", bdev);

[Severity: High]
This delegates the trigger type to the device tree and allows edge-triggered
interrupts.=20

Does this regression introduce a potential deadlock if the hardware asserts
a new completion before the previous interrupt is cleared?

If bam_dma_irq() only reads the BAM status registers once per invocation,
and a new completion arrives after the status register is read, the
overall interrupt line might remain asserted.=20

Because there is no new edge, the interrupt controller would never fire
again.=20

Should we add a loop to drain all pending events until the status register
reads zero?

[Severity: High]
This is a pre-existing issue, but requesting the IRQ here before
pm_runtime_enable() and pm_runtime_set_active() completes might cause an
interrupt storm.

If an early interrupt fires while the device's PM runtime status is still
suspended:

drivers/dma/qcom/bam_dma.c:bam_dma_irq() {
    ...
    ret =3D pm_runtime_get_sync(bdev->dev);
    if (ret < 0)
        return IRQ_NONE;
    ...
}

Will pm_runtime_get_sync() fail and return IRQ_NONE without clearing the
hardware interrupt, keeping the interrupt line asserted permanently?

>  	if (ret)
>  		goto err_bam_channel_exit;

[Severity: High]
This is a pre-existing issue, but does this error path create a
use-after-free and unclocked access race condition?

If a failure occurs later in probe, the error path manually kills tasklets
and disables the clock:

drivers/dma/qcom/bam_dma.c:bam_dma_probe() {
    ...
err_bam_channel_exit:
    for (i =3D 0; i < bdev->num_channels; i++)
        tasklet_kill(&bdev->channels[i].vc.task);
err_tasklet_kill:
    tasklet_kill(&bdev->task);
err_disable_clk:
    clk_disable_unprepare(bdev->bamclk);

    return ret;
}

Since devm_request_irq() was used, the interrupt remains active until devres
cleanup.=20

If an interrupt fires in this window, will bam_dma_irq() access unclocked
BAM registers and schedule a killed tasklet?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does bam_dma_remove() access hardware
registers after they have been unclocked?

During driver unbinding, pm_runtime_force_suspend() disables the BAM clock.

Immediately after, the code writes to the registers:

drivers/dma/qcom/bam_dma.c:bam_dma_remove() {
    ...
    pm_runtime_force_suspend(&pdev->dev);

    of_dma_controller_free(pdev->dev.of_node);
    dma_async_device_unregister(&bdev->common);

    /* mask all interrupts for this execution environment */
    writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
    ...
}

Will accessing these unclocked peripheral registers generate an asynchronous
bus fault and crash the system?

[Severity: High]
This is a pre-existing issue, but does bam_free_chan() leak the PM usage
counter and DMA resources on failure?

When pm_runtime_get_sync() returns an error, it still increments the PM
usage counter.=20

The failure path returns immediately:

drivers/dma/qcom/bam_dma.c:bam_free_chan() {
    ...
    ret =3D pm_runtime_get_sync(bdev->dev);
    if (ret < 0)
        return;

    vchan_free_chan_resources(to_virt_chan(chan));
    ...
}

Does returning here without calling pm_runtime_put_noidle() permanently
prevent the device from suspending, and skip freeing the channel resources
leading to a memory leak?

[Severity: High]
This is a pre-existing issue, but does bam_dma_irq() incorrectly return
IRQ_HANDLED for spurious interrupts?

If no channel interrupts are found and the global BAM interrupt is not set,
the handler falls through:

drivers/dma/qcom/bam_dma.c:bam_dma_irq() {
    ...
    pm_runtime_mark_last_busy(bdev->dev);
    pm_runtime_put_autosuspend(bdev->dev);

    return IRQ_HANDLED;
}

Does this unconditionally return IRQ_HANDLED even for spurious interrupts,
defeating the kernel's spurious interrupt detection and potentially causing
an infinite interrupt loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-qcom-bam-d=
ma-irq-trigger-v1-1-21c216e00b2a@oss.qualcomm.com?part=3D1

