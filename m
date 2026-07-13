Return-Path: <dmaengine+bounces-12396-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P+SfJ97mVGpUgwAAu9opvQ
	(envelope-from <dmaengine+bounces-12396-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92074B87D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VpSUDTMm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12396-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12396-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0435C3025FE5
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B8421EE4;
	Mon, 13 Jul 2026 13:17:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994B423A66
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:17:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948659; cv=none; b=YoF6gJlCoNK9GaUbwhfMC2BvZy++pp5kzJ0/J6jwIhcSck7wJ5c1jHwgvw7rJszsav6pqVi9qP/gFOU/vDLzMB3/kjNCP0odQ7pJOas2LhjZITAEgtw46urphid+RtSBXuYngVbRiUCtb28RFQlWfArEfXY9Gqf7A/6NCRCBh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948659; c=relaxed/simple;
	bh=sgnte0IsXnb+PwmUyBAFnkE+OFCU6jIJrnF2FDYJz5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cynyEc0Pk+RmgTedCd5UxclhXHTAjfbCbYKFwjbBLV2gO1TvwtuwqFdGVpGw3OhkAAQg3wdbvzLgXU7goLqD2uPMDvCdTrYwu6svjClPANTCXKcSJ1aN39S1P7MDY+V+77pIy6G9GNmorBPgKHedvHyYPEpQPPyoxHp4StqIKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpSUDTMm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5F1F00A3D;
	Mon, 13 Jul 2026 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948657;
	bh=kqPVRtoPEK7Tb53mcgk+hJb42VUYYRQ4rZMj9EzNZdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpSUDTMmBjlCv3V7EUKz4Wm58lQ+kootAsiud/cfTjfG7mHFnSTkodaxlT3Un1PTL
	 Ga3fGqUgWiPt0RC3OFr1g62S/rtClb28Ha3ey0KZNntoiBQVa+XfrzI5OPWVPvA98K
	 0Tsie9nxIVNkQjLCAkMuQita4Iauh4U7D6wkAer2E+K4+k2aKUR1R53q/g59V6reXq
	 3fwf5ZMGkIpoww6TnMae5VHcTko9cI0+1NeKJfbqOzywMpf8WJOJYcoV74HOglRHx/
	 zl+xaMUVfOZsFVJIomGxycqjzHoKjyCwAD2ra+bfpEQpxcNYFCX5xXFF4LeVzc5d2K
	 eu9IdFxP46Ffw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 03/14] dmaengine: qcom: bam_dma: convert tasklet to
 a BH workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-3-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-3-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:17:37 +0000
Message-Id: <20260713131737.AAB5F1F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12396-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,qualcomm.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B92074B87D

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Driver removal forcefully suspends the device before hardware =
teardown and workqueue cancellation, causing system crashes and Use-After-F=
ree.
- [High] The IRQ handler accesses hardware registers before ensuring the de=
vice is active, leading to a potential system crash on spurious interrupts.
- [High] Error paths for `pm_runtime_get_sync()` fail to decrement the PM u=
sage counter, permanently preventing the device from runtime suspending.
- [High] DMA controller is exposed to clients before runtime PM is enabled,=
 dropping transactions.
- [Medium] Missing pm_runtime_disable() in driver removal.
--

--- Patch [3]: [PATCH v21 03/14] dmaengine: qcom: bam_dma: convert tasklet =
to a BH workqueue ---
commit 69bb6ec401a63dcf8f8b7e2ec728a8a983774e1a
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue

This patch replaces the legacy tasklet implementation in the BAM DMA driver
with a high-priority BH workqueue. It updates the probe, remove, irq, and
execution paths to use workqueue APIs.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index fc155e0d1870c..ea3df28e777f9 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c

[ ... ]

> @@ -922,9 +923,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
> =20
>  	srcs |=3D process_channel_irqs(bdev);
> =20
> -	/* kick off tasklet to start next dma transfer */
> +	/* kick off the work queue to start next dma transfer */
>  	if (srcs & P_IRQ)
> -		tasklet_schedule(&bdev->task);
> +		queue_work(system_bh_highpri_wq, &bdev->work);
> =20
>  	ret =3D pm_runtime_get_sync(bdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but does process_channel_irqs()
read hardware registers before pm_runtime_get_sync() ensures the clock is
enabled?

If a spurious interrupt arrives while the controller is in runtime suspend
(clocks disabled), could reading the register cause a synchronous external
abort and crash the system?

>  	if (ret < 0)
> -		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but if pm_runtime_get_sync() fails, it still
increments the usage counter.

Does this early return fail to drop the PM usage counter (e.g., via
pm_runtime_put_noidle()), permanently skewing the reference count and
preventing the hardware from entering low-power states?

It looks like this same error handling pattern is also present in
bam_start_dma() and bam_resume().

[ ... ]

> @@ -1316,14 +1316,14 @@ static int bam_dma_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto err_disable_clk;
> =20
> -	tasklet_setup(&bdev->task, dma_tasklet);
> +	INIT_WORK(&bdev->work, bam_dma_work);
> =20
>  	bdev->channels =3D devm_kcalloc(bdev->dev, bdev->num_channels,
>  				sizeof(*bdev->channels), GFP_KERNEL);
> =20
>  	if (!bdev->channels) {
>  		ret =3D -ENOMEM;
> -		goto err_tasklet_kill;
> +		goto err_workqueue_cancel;
>  	}

[Severity: High]
This is a pre-existing issue, but it looks like bam_dma_probe() registers
the DMA controller with the subsystem before runtime PM is enabled.

If a consumer device instantly requests a channel and submits a transaction,
could pm_runtime_get_sync() return -EACCES and silently abort the transfer
because PM runtime is not yet active?

[ ... ]

> @@ -1424,7 +1424,7 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  			    bdev->channels[i].fifo_phys);
>  	}
> =20
> -	tasklet_kill(&bdev->task);
> +	cancel_work_sync(&bdev->work);

[Severity: Critical]
This is a pre-existing issue, but does workqueue cancellation happen after
channel FIFOs have been freed by dma_free_wc() earlier in this function?

Could a concurrently running bam_dma_work execute bam_start_dma() and
access the freed fifo_virt memory, leading to a use-after-free?

[Severity: Critical]
This is also a pre-existing issue, but bam_dma_remove() calls
pm_runtime_force_suspend() early on, which disables the hardware clocks.

Does the driver then perform unclocked register accesses (e.g., by writing
to the BAM_IRQ_SRCS_MSK_EE register and calling bam_dma_terminate_all())
before reaching this point, potentially causing a kernel panic?

> =20
>  	clk_disable_unprepare(bdev->bamclk);
>  }

[Severity: Medium]
This is a pre-existing issue, but the function exits without calling
pm_runtime_disable().

Does this leave the PM core's runtime PM state active for this device after
the driver is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D3

