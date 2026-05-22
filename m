Return-Path: <dmaengine+bounces-10746-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEaBKQRoEGpJXAYAu9opvQ
	(envelope-from <dmaengine+bounces-10746-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:28:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A95B625F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B37B30789C2
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BC44B690;
	Fri, 22 May 2026 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8gJ6MZx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AD425CD1
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459466; cv=none; b=SvxpM7f6RfKpYJK+ZaSOBzsbedMM60ZpsD2WitvRLSME7xSIlapAMSV56yTJ1wL5MvSgHoVhmcpZhRVhz1jQdFIUMV0IfyunKTaGw5lr1LmORLHxq8rTgtZ9Fl7AdQbL/MY0b3phFOFtQYDLQpT3tON6g5/f3JYcIw0pGYhmClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459466; c=relaxed/simple;
	bh=DIB8L5DX0jbev/2d6bZO1GHhStTZjZoW4upe+3smuZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5nJACglUgQXA4vd7g6Gz83MfMas7iCcqQQ2cLLKI3THUt9GeACL8ORwWzyeb4npJa+MnpZyDAXAlBzZZxY8a+Fe0mwiPf9KDrGeJ7jNntTDOnfzjaHbLp6feCt3tGsywEpeAjN5dC+3F9bMSsdvjeFVg22DYZ3AfmMIpwaBBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8gJ6MZx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEB31F000E9;
	Fri, 22 May 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459459;
	bh=DPthxOLtEzxZw0RC60f7hF0d+DGxOjRvY9v+KhkDmiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8gJ6MZx5OOzskV8QkZ8nxocGIPlxUa0g4EtS8VdJchI4D22No8IjgulgNHH9W0RD
	 /yrhbNCdZeh2NUKeNRrcjxUa4rlfYG/UQ0q/Tdi3ewB2MfOhJaLorOOhRBSXQuRIrY
	 K6mWkWtAt128tsxxjjP7Qaib7btV2Y/nRsEsEtyPXW43ODcoy2ZeVSXTws7rKkWlF3
	 pui9CJHSUzN3H9CH8+ltS2WtSD0bTz/Va1YNanTG1H8rPS9AKZZzpcWqa0Q7bKDmpS
	 UXTaVqO0wcDsuTdXnzEr/3IzVdd/R0TBxGSMmD5gClAbZXaJR2qrPGGCHoojLDVwlt
	 q07dVb1nh2Abg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 02/14] dmaengine: qcom: bam_dma: free interrupt
 before the clock in error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-2-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-2-99103926bafc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 14:17:39 +0000
Message-Id: <20260522141739.9FEB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10746-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 447A95B625F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Calling free_irq() before unregistering the DMA controller creates=
 a window where active DMA clients will hang forever.

Pre-existing issues:
- [Critical] Hardware registers are accessed after the device clock is disa=
bled, causing a synchronous external abort.
- [Critical] The IRQ handler accesses hardware registers before verifying t=
he device is active and its clocks are enabled.
- [High] The DMA device state is freed via devres while clients may still h=
old references to channels, leading to a Use-After-Free.
- [High] Requesting the IRQ before enabling runtime PM can cause an unhandl=
ed interrupt storm.
--

commit cdad268a047eb3aecf63c558b2efa1d316fbeb49
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: free interrupt before the clock in error path

This commit stops using devres for the BAM interrupt and manually frees
it in the error path and in remove() before disabling the clock.
This prevents the interrupt from firing while the clock is disabled.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D2

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
[ ... ]
> @@ -1302,8 +1302,7 @@ static int bam_dma_probe(struct platform_device *pd=
ev)
>  	for (i =3D 0; i < bdev->num_channels; i++)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
> =20
> -	ret =3D devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> +	ret =3D request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma=
", bdev);

[Severity: High]
This is a pre-existing issue, but does requesting the IRQ with
IRQF_TRIGGER_HIGH before pm_runtime_enable() is called risk an unhandled
interrupt storm?

If the interrupt line is already asserted at probe time, the handler will r=
un
immediately. Because runtime PM is not yet enabled, pm_runtime_get_sync()
will fail in the handler, potentially causing it to return IRQ_NONE without
clearing the hardware interrupt.

[Severity: Critical]
This is also a pre-existing issue, but does the IRQ handler read hardware
registers (like BAM_IRQ_SRCS_EE) before using Runtime PM APIs to guarantee
the device is awake and its clocks are enabled?

If a spurious interrupt fires while the device is in runtime autosuspend,
could an unclocked hardware read trigger a synchronous external abort and
crash the system?

[ ... ]
> @@ -1371,6 +1372,8 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	struct bam_device *bdev =3D platform_get_drvdata(pdev);
>  	u32 i;
> =20
> +	free_irq(bdev->irq, bdev);
> +

[Severity: High]
Does freeing the IRQ here before calling dma_async_device_unregister() crea=
te
a window where active DMA clients will hang forever?

The interrupt handler is unregistered while the DMA controller is still ful=
ly
active and channels haven't been terminated. If any active transactions
complete or new ones are issued by a client during this window, wouldn't th=
ey
never receive an interrupt completion?

>  	pm_runtime_force_suspend(&pdev->dev);
> =20
>  	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&bdev->common);

[Severity: High]
This isn't a bug introduced by this patch, but does allocating the bam_devi=
ce
state with devm_kzalloc() lead to a use-after-free when this function
returns?

While dma_async_device_unregister() prevents new channel allocations, clien=
ts
may still hold references to existing channels. Because devres frees the
memory immediately upon remove() returning, couldn't clients using DMA APIs
or scheduled tasklets access freed memory?

>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

[Severity: Critical]
This is a pre-existing issue, but does calling writel_relaxed() here access
hardware registers after pm_runtime_force_suspend() has already disabled the
bamclk?

Accessing peripheral registers when the module clock is disabled causes a
synchronous external abort on these platforms. Shouldn't this register
access occur before the device is suspended?

> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> -
>  	for (i =3D 0; i < bdev->num_channels; i++) {
>  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-qcom-qce-c=
md-descr-v18-0-99103926bafc@oss.qualcomm.com?part=3D2

