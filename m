Return-Path: <dmaengine+bounces-11862-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IxsJBgBHQmqL3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11862-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3416D8D66
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CTnVQreO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11862-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11862-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F10203025725
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674163F1654;
	Mon, 29 Jun 2026 10:18:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9660C2EA
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728339; cv=none; b=ZBlEAzGKp9Xk5CeLE5K3kWO6ZzhxsCqLGi9aTTrC6yQQT9bopiSS5p0tZ7N5cHs4cZx6wIF/GSq/O5z58L/comqb73Q+BengIOJSV4/IJAOLz9oHp9gaXqhk8ANaqx4EaxJowUGbP+sAM/tjaealJMfH24QIlaU1G6IjfLYpsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728339; c=relaxed/simple;
	bh=lcO8wXlSWbE07gnuXXQuNsVq5JubOqeKES/AdXIbz5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=knDHPO4w3mujvsxpg8rgDitpDqQvuwMTKIwCwcB5mxzglSl1LNcTLqEeb3qu9gHN/wo4hlUd3AgdPf+ubwVL5+7HGO4P3Y436zd/xcoz+5lkou6bIybO+WaXX3CpjJeVPvBBKszN+rNlUAyy5vO1XduabjvkjkaPcW+Vxp1bJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTnVQreO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C361F000E9;
	Mon, 29 Jun 2026 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728337;
	bh=1AW1NjZrkCUGH6ivFnbu6gb7yUghihpc7ht4P84VeDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTnVQreOl77CrzPAq67XxvPtzMoHJ8sUfDGrFvFJ0gm2V09swJCdmnCd9wPMGEIg9
	 mKSscWCQistx5hwyMBL/rxtpDxP8Gi4td1qW0I/1sTMb1rB1pWhERupN+ReXqobGDN
	 KKP2IXyqxm+LkQYP8oJkpgmhQHKGsdhCm4vHLecPDJtE7LlflK1oOtFJZEhz7vppGw
	 peVQ4CnvQ6YODmHc5G8vShjMfA/TLigw71qRKz3i5oK9R0+WPYp1NRIWbgQVcQR2mR
	 mwX9TaxQJ+dlL6DmJ6QloW4vCOv8BMeaj7R3nIroA58RZbdZmT2GwkfMcUE5HAGhc7
	 2orb1ncTsH/Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 02/14] dmaengine: qcom: bam_dma: free interrupt
 before the clock in error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-2-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-2-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:18:57 +0000
Message-Id: <20260629101857.90C361F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11862-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto,qualcomm.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3416D8D66

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Moving `free_irq()` to the start of `bam_dma_remove()` creates an =
interrupt storm window.

Pre-existing issues:
- [Critical] `bam_dma_remove()` performs unconditional unclocked hardware a=
ccesses after `pm_runtime_force_suspend()`, causing a system crash.
- [High] Concurrent execution of the pending async workqueue with `pm_runti=
me_force_suspend()` causes unclocked hardware accesses.
- [High] The interrupt handler `bam_dma_irq()` unconditionally accesses har=
dware registers, causing a crash on spurious interrupts.
--

commit 8349aa20615406eee52bb3c2ccef1b8f57571551
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: free interrupt before the clock in error path

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D2

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1bb26af0405f3..fc155e0d1870c 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1332,8 +1332,7 @@ static int bam_dma_probe(struct platform_device *pd=
ev)
>  	for (i =3D 0; i < bdev->num_channels; i++)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
> =20
> -	ret =3D devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> +	ret =3D request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma=
", bdev);

[Severity: High]
This is a pre-existing issue, but does bam_dma_irq() unconditionally access
hardware registers before enabling the clock?=20

If a spurious interrupt triggers while the device is runtime-suspended,
process_channel_irqs() might read BAM_IRQ_SRCS_EE before pm_runtime_get_syn=
c()
is called to turn the clock on.=20

Could this lead to a synchronous external abort?

[ ... ]

> @@ -1401,6 +1402,8 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	struct bam_device *bdev =3D platform_get_drvdata(pdev);
>  	u32 i;
> =20
> +	free_irq(bdev->irq, bdev);
> +

[Severity: High]
By unregistering the handler here, before hardware interrupts are masked,
could this create a window for an unhandled interrupt storm?=20

If a DMA transaction completes and asserts the level-triggered
IRQF_TRIGGER_HIGH line, there is no software handler to clear it until the
mask is written below. This might force the kernel to permanently disable
the IRQ line.

>  	pm_runtime_force_suspend(&pdev->dev);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does forcing the device to
suspend here in bam_dma_remove() race with pending asynchronous work?=20

If a DMA interrupt schedules the workqueue, the async work might execute
concurrently and acquire a runtime PM reference. Because
pm_runtime_force_suspend() ignores active usage counters, it could forceful=
ly
disable the clock while the workqueue is still writing to BAM registers.

>  	of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&bdev->common);
> =20
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

[Severity: Critical]
This is a pre-existing issue, but does writing to BAM hardware registers he=
re
in bam_dma_remove() cause a crash?=20

The preceding call to pm_runtime_force_suspend() disables the bamclk, so th=
is
writel_relaxed() and subsequent termination calls appear to perform unclock=
ed
hardware accesses, which could trigger a synchronous external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D2

