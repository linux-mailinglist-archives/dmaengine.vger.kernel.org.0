Return-Path: <dmaengine+bounces-10954-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCxSKEalFWqJXAcAu9opvQ
	(envelope-from <dmaengine+bounces-10954-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:51:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706D5D6DB5
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E319E304AE44
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F383F5BF1;
	Tue, 26 May 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ZGQDhV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41129C35A
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803114; cv=none; b=SjxFmQOHfDsuqOjSy00Ywz2bBULhzDbHtwlN2i5r6dQ1TKnm2RXd+MvKfeOEfCyCCRrTiOXjJEUGu8rxAYTSrn2pe85IbgT+R0xyMTs7YozxBSaxqjzoR9X75nbhaSxe8tyyMCu/RdcUmGaQynOSbWNqAXt3Lok4czITO80owGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803114; c=relaxed/simple;
	bh=eUbL61b1rPjDnh9sbdvnI4OmZ/yeln/bSG9q7LhSkrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJpZ3PE74Ly3QFD6fwdVUglKlcgyRQ/gHQVgPfHvarPNCOrmocH6B6ZddjeqVUuNDM7jE/Nj5Jq1zDxWxOhGoWQo0faAXS4KwSAS65VdkmWXTWI1QxSCitkpWvWkvcp7cG9Sn+WRCRfcanlOGgZtdxoJkid3i+ueexxcIxJbT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ZGQDhV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957531F000E9;
	Tue, 26 May 2026 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803112;
	bh=gE3vwqMNLR1o/fV/DbLYAfzv+e1xYw/1O3pqRzbRtTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4ZGQDhVbBRgy6z29yR6yXkpi2GqB6o023MV4BUA08Dlg4nwJ3K+zbehwd71eJ04D
	 S4p9x5wf0Iiq+IVJMtkaZMJUs4Jt+8gxnZToYLoJjDNEtV4PKnMElIhn1jGESmRjJO
	 PZBYPWIIPNV76kfxjRvhIu0JtrdYFyI54OqZS+277EW3Rzlq2+GLodi/jscQntLIer
	 /pt9KvU5VKT1IPIY/a0gHUnaHcKYn7LSMbbfHvbgXGi18bssCehOSst6zGiT+/igpX
	 UQelvmq0NteaD2PKQr1KnJvcTRK+OSllstkuVSP3W2uDblFG1FzNDgZ46re4jRmXAQ
	 Wmj6GXh5ZJoyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/14] dmaengine: qcom: bam_dma: free interrupt
 before the clock in error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-2-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-2-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:45:12 +0000
Message-Id: <20260526134512.957531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10954-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,qualcomm.com:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 1706D5D6DB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Premature `free_irq()` in `bam_dma_remove()` breaks active DMA cli=
ents.

Pre-existing issues:
- [High] MMIO registers are accessed after the peripheral clock is disabled=
, causing synchronous external aborts.
- [High] Hardware access in IRQ handler before ensuring the device is activ=
e.
--

commit 9a4b7f5a6e5a0de12bcd192dd65b74252ada73c2
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: free interrupt before the clock in error path

This commit replaces devres with manual interrupt management in the BAM DMA
driver. It explicitly requests and frees the IRQ to ensure the interrupt is
freed before the clock is disabled in both the probe error path and during
device removal.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D2

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 19116295f8325..b3d36ea799843 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but does the interrupt handler
bam_dma_irq() access hardware registers before ensuring the device is activ=
e?

If the device is in a suspended state (for example, via auto-suspend), its
clock is disabled. If a delayed or stray interrupt fires in this state,
reading from an unclocked MMIO register would result in a synchronous
external abort.

Should the handler use pm_runtime_get_if_active() to ensure the device is
active before touching MMIO registers, rather than risking a crash when the
clock is disabled?

>  	if (ret)
>  		goto err_bam_channel_exit;
> =20

[ ... ]

> @@ -1371,6 +1372,8 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	struct bam_device *bdev =3D platform_get_drvdata(pdev);
>  	u32 i;
> =20
> +	free_irq(bdev->irq, bdev);
> +

[Severity: High]
Does moving this free_irq() to the very beginning of the remove function
introduce a race condition?

If the DMA controller is still registered and active from the subsystem's
perspective, any in-flight DMA transfers will complete in hardware, but
software will never receive their completion interrupts. Could this cause
client drivers to hang indefinitely or time out?

Should the teardown sequence first unregister the dmaengine device to
prevent new requests, terminate all active channels, mask interrupts, and
only then free the IRQ and disable the clock?

>  	pm_runtime_force_suspend(&pdev->dev);
> =20
>  	of_dma_controller_free(pdev->dev.of_node);
> @@ -1379,8 +1382,6 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

[Severity: High]
This is a pre-existing issue, but does calling pm_runtime_force_suspend()
earlier in this function cause synchronous external aborts here?

The runtime suspend callback will disable the BAM device clock, but
immediately following this, the function accesses hardware registers:

bam_dma_remove()
    pm_runtime_force_suspend(&pdev->dev); /* clock disabled */
    ...
    writel_relaxed(0, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));

It also loops over channels calling bam_dma_terminate_all(), which can call
bam_chan_init_hw() and read/write MMIO registers.

Should the device be kept awake until all hardware registers are masked and
channels are terminated?

> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> -
>  	for (i =3D 0; i < bdev->num_channels; i++) {
>  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
>  		tasklet_kill(&bdev->channels[i].vc.task);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D2

