Return-Path: <dmaengine+bounces-10552-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BnhJExqDGo8hQUAu9opvQ
	(envelope-from <dmaengine+bounces-10552-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:49:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D657FFB4
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D939D301B309
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808C3403F4;
	Tue, 19 May 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/P4EjWB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E012745E
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198484; cv=none; b=aUggfsO6U+sIbyHGCauddDG1OBOu0ZwO9SYDU4vphOTC4Il35pRxbCD6KKeXQ27sHvvGYack6bSlwkcKe3ZzFWgF4sDtl9HcXW8JhRBjKoyi3JuBnvr4akbzg0aGx9V9Dhr6Rjh5fNc7xKpBCTOPnr+IhoKXnVxrtXzKbjPU92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198484; c=relaxed/simple;
	bh=IkQ203RTWP5cyltCCUHa+zw6uku9cbkTsBMRMuGwA4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbuIPeUjo+AKcgqoor2jMnCl28KClIN0or/sr/52vuLd4HYQzrYIddcN1z0nmdaNaJL8qVbUsKcHOKXPoxlaVZ+OR3ogCysK3RQB6Hj3GG4yG93KFI8hDGFzwzbulUIK3G6CXtjbO1EfmrULxCaqwL8NlYUjBUnEFWnqQQQqRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/P4EjWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000F8C2BCC7;
	Tue, 19 May 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198484;
	bh=IkQ203RTWP5cyltCCUHa+zw6uku9cbkTsBMRMuGwA4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N/P4EjWBy9aNxZvZhMqiM05pVTiDa48HItFRMWIGC2hLByqArhxIonl9KHrZiAlHQ
	 JKatky+iXEPAEcOSzLy4QlWoT34yc6q5Zw02/nc2U6qvIhJI9wW+2+51/ENvBU/5gt
	 vuVTG64ZCSQjCoEuyzFb+1dnN44S2UiX/MKMDGsVecPC2KMDvspHbHz0QgqjysLTgQ
	 Zy7NFYlnQpP105BFQTUHsE/Fu1TkTjJl5oAQpa7lvp2b50D6nTz+eQgUHW9QbHH+fA
	 OIO7TZvtvV+CXLXOGKp0XjZnAH/WVD+9RCDlVrzX6kuM1Ue/j/Wgnkz+M9opNRQsiX
	 Q0GddHwfuAMUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/14] dmaengine: qcom: bam_dma: free interrupt
 before the clock in error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-2-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-2-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:48:02 +0000
Message-Id: <20260519134804.000F8C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10552-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 981D657FFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch fails to resolve the unclocked register access bug in `b=
am_dma_remove()`, resulting in a deterministic crash on device removal.
- [High] Race condition in `bam_dma_probe()` can trigger an IRQ storm resul=
ting in a permanently disabled interrupt.
--

commit 39d4da1e9be1c385de4964ad3c6f55d2aea52136
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: free interrupt before the clock in error path

This commit replaces the devres-managed IRQ allocation with manual IRQ
requesting and freeing. It ensures the interrupt is freed before
disabling the clock in the probe error path to prevent unclocked
register accesses if the IRQ fires.

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D2

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 19116295f8325..cea44833201d6 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1302,8 +1302,7 @@ static int bam_dma_probe(struct platform_device *pd=
ev)
>  	for (i =3D 0; i < bdev->num_channels; i++)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
> =20
> -	ret =3D devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> +	ret =3D request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma=
", bdev);
>  	if (ret)
>  		goto err_bam_channel_exit;

This isn't a new regression, but since the goal is to safely manage the BAM
interrupt, could requesting the IRQ here before PM runtime is enabled lead
to an IRQ storm?

If an interrupt asserts after request_irq() but before pm_runtime_enable()
is called later in the probe sequence, bam_dma_irq() will execute and call
pm_runtime_get_sync().

Because PM runtime is disabled, this returns -EACCES. The handler then
returns IRQ_NONE without clearing the hardware interrupt status.

Since the interrupt is level-triggered (IRQF_TRIGGER_HIGH), the hardware
will continuously re-assert it, causing an IRQ storm until the kernel's
spurious IRQ detector permanently disables the interrupt line.

Should PM runtime be enabled and marked active before requesting the IRQ?

[ ... ]

> @@ -1379,7 +1380,7 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
> =20
> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> +	free_irq(bdev->irq, bdev);

The commit message notes that disabling the clock before freeing or masking
the interrupt can lead to unclocked BAM register accesses. Does this same
regression still exist here in bam_dma_remove()?

At the beginning of bam_dma_remove(), pm_runtime_force_suspend() is called:

static void bam_dma_remove(struct platform_device *pdev)
{
	struct bam_device *bdev =3D platform_get_drvdata(pdev);
	u32 i;

	pm_runtime_force_suspend(&pdev->dev);
        ...

This invokes bam_dma_runtime_suspend() which explicitly disables the BAM
clock.

Immediately afterward, the driver executes the writel_relaxed() shown above
to mask interrupts. Writing to BAM hardware registers with the clock gated
will deterministically trigger a synchronous external abort (bus crash) on
Qualcomm platforms. Furthermore, free_irq() is called after the clock is
disabled, leaving the same race condition open.

To safely tear down the device, would it be better to wake the device via
pm_runtime_get_sync(), mask and free the IRQ, terminate DMA, and only then
disable PM runtime and clocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D2

