Return-Path: <dmaengine+bounces-12391-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ekzHOrTmVGoygwAAu9opvQ
	(envelope-from <dmaengine+bounces-12391-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557074B859
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IChDAeI1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12391-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12391-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB2FA309D863
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22C41F7EA;
	Mon, 13 Jul 2026 13:14:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63B41930C
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:14:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948490; cv=none; b=juhSqN8/ksXYcoWGwo8p0rhhc6pTOPr9/rr9psMMkABgVQrfsBbsHjXWTTNlLUL9wtZw3jDLrLcNkCYdwWsK71LZYTKz3DyCrMrgqbAXQPoCXaCaLxSNx5GHZSu0xULxkg4etY1AGYAzeghHouuN/PEXZ3/9kUXTz8Do5uf7R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948490; c=relaxed/simple;
	bh=1/5OhpZd46I5ix3oVf6inJxzWeZ7OZkuNNcryeyjsTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qM6IoN3+lPrRShVTX9bLPdNFYFoqP531awHBzRCRglX7LSWy1yt2YwZ62OGam4AcBumQRInF2kNzbmTJDf+0TqiVlFfxEorNTSM87CCUEU9HNomXubMjUBCCBu/PKDt595ZRtUAjUWscZTkxXGYcD/Es/d+5qhfyqvz768IEw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IChDAeI1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1821F00A3A;
	Mon, 13 Jul 2026 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783948489;
	bh=qOPLBpEjGy+hv8KeHgwPwVZS9gJEaX4pHusFoA5x+FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IChDAeI1MBlTxxeq+5aHEKnpHHOQoP9K+tbg5CHKv3Snd4AkjUplIAYOmify97gb5
	 7vpWbkIv4Z1kZg6AQ0NyMA2NfeitxDzhOvwvyaKxXBPHbhRm8UmkIL3XAO4AYxB6C+
	 yE2GDifyNUb/mW8WySo4euvAJwvg5LeJ6hPnTtYz89jkBQp+BrowwZzco9o26DmjhM
	 oFsjRArZLwPc5uwx1MQYxF1aVmn+9Qfbv0VWg1whBU3ERP5UB3rkQTP1hnjbFiD7rS
	 hWdPbLilfgaLPsNXxuT/9noqJeg7xrF/ufKpvi35T2tmi10BcEksmohr9pc0TZFokb
	 7I6XsoU2snTBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 02/14] dmaengine: qcom: bam_dma: free interrupt
 before the clock in error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-2-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
 <20260713-qcom-qce-cmd-descr-v21-2-bc2583e18475@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:14:48 +0000
Message-Id: <20260713131448.ED1821F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12391-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4557074B859

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unclocked hardware register access in `bam_dma_remove()` leadi=
ng to a synchronous external abort (system crash).
- [High] Unsafe hardware access in the IRQ handler before acquiring a Runti=
me PM reference.
- [High] Concurrency race allowing tasklets to execute unclocked hardware a=
ccesses during device removal.
- [High] Clock enable count underflow during device removal.
- [High] Runtime PM usage counter leak in the IRQ handler on failure path.
--

--- Patch [2]: [PATCH v21 02/14] dmaengine: qcom: bam_dma: free interrupt b=
efore the clock in error path ---
commit 9ca369a6aae9bb2fa96d12a2fd87eaad7821b59b
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: free interrupt before the clock in error path

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled. Stop using devres for interrupts as we free it in
remove() manually anyway.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D2

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
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
This is a pre-existing issue, but I have a question about the interrupt
handler bam_dma_irq() being requested here.

Does the interrupt handler read hardware registers before guaranteeing
the clock is enabled?

In drivers/dma/qcom/bam_dma.c:bam_dma_irq():
    srcs |=3D process_channel_irqs(bdev);
    ...
    ret =3D pm_runtime_get_sync(bdev->dev);

process_channel_irqs() executes a readl_relaxed() on BAM_IRQ_SRCS_EE.
If a spurious interrupt fires or races with an auto-suspend transition,
could this read occur while the device is suspended and its clock is
off, causing a synchronous external abort?

[Severity: High]
This is also a pre-existing issue, but looking further into the error
path of bam_dma_irq():

In drivers/dma/qcom/bam_dma.c:bam_dma_irq():
    ret =3D pm_runtime_get_sync(bdev->dev);
    if (ret < 0)
        return IRQ_NONE;

If pm_runtime_get_sync() fails, it returns without dropping the reference.
Does this leak the usage counter and permanently prevent the device from
entering lower power states?

>  	if (ret)
>  		goto err_bam_channel_exit;

[ ... ]

> @@ -1401,6 +1402,8 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	struct bam_device *bdev =3D platform_get_drvdata(pdev);
>  	u32 i;
> =20
> +	free_irq(bdev->irq, bdev);
> +
>  	pm_runtime_force_suspend(&pdev->dev);
> =20
>  	of_dma_controller_free(pdev->dev.of_node);
> @@ -1409,8 +1412,6 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

[Severity: Critical]
This isn't a bug introduced by this patch, but does this sequence cause
unclocked hardware register accesses?

In drivers/dma/qcom/bam_dma.c:bam_dma_remove(), the clock is forced off
unconditionally by pm_runtime_force_suspend(&pdev->dev). Immediately
afterward, the code writes to BAM registers:

    pm_runtime_force_suspend(&pdev->dev);
    ...
    writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

It then calls bam_dma_terminate_all(), which performs more register
accesses in bam_chan_init_hw(). Can accessing these registers with the
clock off lead to a system crash (SError)?

> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> -
>  	for (i =3D 0; i < bdev->num_channels; i++) {
>  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
>  		tasklet_kill(&bdev->channels[i].vc.task);

[Severity: High]
This is a pre-existing issue, but does killing the tasklets after
pm_runtime_force_suspend() leave a race window?

If a scheduled tasklet is concurrently executing bam_start_dma() (having
already incremented the usage count via pm_runtime_get_sync()),
pm_runtime_force_suspend() will ignore the usage counter and disable
the clock anyway.

Could the racing tasklet then access BAM registers with the clock off,
causing a system crash?

[Severity: High]
This isn't a bug introduced by this patch, but does bam_dma_remove()
underflow the clock enable count?

pm_runtime_force_suspend() invokes the runtime suspend callback which
calls clk_disable(). Later in bam_dma_remove(), the driver calls
clk_disable_unprepare(bdev->bamclk) unconditionally.

Does this result in an unbalanced second call to clk_disable() that
underflows the enable count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-qce-c=
md-descr-v21-0-bc2583e18475@oss.qualcomm.com?part=3D2

