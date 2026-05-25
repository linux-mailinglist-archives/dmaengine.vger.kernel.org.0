Return-Path: <dmaengine+bounces-10867-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fj8L6QzFGo/KwcAu9opvQ
	(envelope-from <dmaengine+bounces-10867-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:33:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C635C9F83
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328C1300B479
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFD37DAA0;
	Mon, 25 May 2026 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSjNbcHw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B0335555;
	Mon, 25 May 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708831; cv=none; b=YNI2pbH016fXzzxnDuxJbt0IzPd8smCYDyKiI2jyKJ+V1/poBndm0AZPlSTcn04wXmvlGJSvOMPDvor9nOr3RS6ZxojW+LCo06CYwDpGwJcdOOE9KaNGbHEI3B2pSVlhOwxtUCAvfzV7VeLb8qfc9g4OLPTcL3h5EELDw2BtcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708831; c=relaxed/simple;
	bh=Laov1FUjobcUTu/tQOih70AjqKBWirqKflwXsTQLhlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dZcrCYtqciVFdziOVOG4sBMkmvRjERqh6Sit7uuxI0lQAnfQVLaR4K/MqwkCUuoGF23Yf/uNhIAkoDjzrYFGLT/TWl7vQSCvg/i6ntB3UBOI7+HBEnIZsZ0z8mZmbLqR94/HbsT6onK0k/GS5PH81/qnDEXrhI2k5wyIRBjRyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSjNbcHw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D6E1F00A3D;
	Mon, 25 May 2026 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779708829;
	bh=VCjaGzAn78vEBMsChjUib0AiS3nKSv5EcGC4aMT3l6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PSjNbcHw6OgwTSGOhMKNCRFFfjmL8aXZ9Vab2ek42E5Jyt8iXN8fSU5hwp+KdGgEF
	 RYj/1VkysRA+DEq4Y/Nsj5yvFOsoM4X8Ehx+lrADRo1kiKEoqzY9utqi+1qoiHo5s3
	 hN+3SRoXgIjdg8zCpmQvJy7Zrp2PgJn5DZg3Wvv3JkkP9lEER3k9MBlTOOi4xs1FYM
	 3XeSUYsyVu5GI4EXhcSq4W0d7/VxRK/24sVRF1Xsi/OB2gbQCPSwAifBmT3eaNM7AX
	 THGpaYv//z0tpJFBy7Wk88eGzJyL6DUNvO+aUgt5Y6bgPx1mAf6ekGWGgn3XOeEeZu
	 Tbr4HJCtZbU6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dmaengine: zynqmp_dma: Add per-channel reset
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Golla Nagendra" <nagendra.golla@amd.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260525105042.2249542-3-nagendra.golla@amd.com>
References: <20260525105042.2249542-3-nagendra.golla@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 11:33:49 +0000
Message-Id: <20260525113349.68D6E1F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10867-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 65C635C9F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe error path leaks a runtime PM usage counter reference, p=
ermanently breaking runtime PM and leaving hardware clocks enabled.
- [High] Dropping the spinlock inside `list_for_each_entry_safe` allows con=
current modification of the list, leading to memory corruption.
- [High] Hardware registers are accessed in the IRQ handler without verifyi=
ng if the device is active, risking a kernel panic on spurious interrupts.
--

commit b2d2a678f48614c7188f8d81cbc70143b2bdfc0f
Author: Golla Nagendra <nagendra.golla@amd.com>
Subject: dmaengine: zynqmp_dma: Add per-channel reset support

This commit introduces per-channel reset support for Versal Gen 2 and
Versal Net SoCs. It adds reset handling in the channel probe path using
device_reset_optional() to trigger a reset pulse during initialization.
Platforms without per-channel reset are unaffected.

> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> index f6a812e49ddca..51c831760372c 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
[ ... ]
> @@ -916,6 +917,11 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_d=
evice *zdev,
>  	if (IS_ERR(chan->regs))
>  		return PTR_ERR(chan->regs);
> =20
> +	err =3D device_reset_optional(&pdev->dev);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "failed to reset channel\n");
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak a
runtime PM usage counter reference?

In zynqmp_dma_probe(), pm_runtime_resume_and_get() is called to increment
the runtime PM usage counter and enable the device clocks. If a subsequent
initialization step fails, such as the newly added device_reset_optional()
returning -EPROBE_DEFER, the code jumps to the err_disable_pm label:

zynqmp_dma_probe()
    ...
	ret =3D pm_runtime_resume_and_get(zdev->dev);
    ...
	ret =3D zynqmp_dma_chan_probe(zdev, pdev);
	if (ret) {
		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
		goto err_disable_pm;
	}
    ...
err_disable_pm:
	if (!pm_runtime_enabled(zdev->dev))
		zynqmp_dma_runtime_suspend(zdev->dev);
	pm_runtime_disable(zdev->dev);
	return ret;

Since the device is still runtime PM enabled, it skips
zynqmp_dma_runtime_suspend() and fails to drop the usage counter with
pm_runtime_put_noidle().

Because -EPROBE_DEFER is a normal occurrence during boot, this path can
be hit multiple times. Will this permanently leave the usage counter above
zero, preventing the device from ever entering runtime suspend and leaving
its clocks enabled indefinitely?

>  	chan->bus_width =3D ZYNQMP_DMA_BUS_WIDTH_64;
>  	chan->dst_burst_len =3D ZYNQMP_DMA_MAX_DST_BURST_LEN;

[Severity: High]
This is a pre-existing issue, but does dropping the spinlock inside
list_for_each_entry_safe() in zynqmp_dma_chan_desc_cleanup() allow concurre=
nt
modification of the list, leading to memory corruption?

When zynqmp_dma_chan_desc_cleanup() temporarily drops the lock to invoke
the DMA callback:

zynqmp_dma_chan_desc_cleanup()
    ...
	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
        ...
		if (dmaengine_desc_callback_valid(&cb)) {
			spin_unlock_irqrestore(&chan->lock, irqflags);
			dmaengine_desc_callback_invoke(&cb, NULL);
			spin_lock_irqsave(&chan->lock, irqflags);
		}

A client driver can concurrently invoke dmaengine_terminate_sync(), which
calls zynqmp_dma_device_terminate_all() and executes
zynqmp_dma_free_descriptors(). This moves all remaining elements, including
the prefetched next pointer, from done_list to free_list.

When zynqmp_dma_chan_desc_cleanup() reacquires the lock, won't it continue
iterating using the corrupted next pointer that now resides in free_list,
eventually interpreting the list head &chan->free_list as a struct
zynqmp_dma_desc_sw and resulting in out-of-bounds memory accesses?

[Severity: High]
This is a pre-existing issue, but are hardware registers accessed in the
IRQ handler without verifying if the device is active, risking a kernel
panic on spurious interrupts?

The IRQ handler zynqmp_dma_irq_handler() directly reads the ISR and IMR
hardware registers:

zynqmp_dma_irq_handler()
    ...
	isr =3D readl(chan->regs + ZYNQMP_DMA_ISR);
	imr =3D readl(chan->regs + ZYNQMP_DMA_IMR);

According to the Power Management Subsystem guidelines, IRQ handlers must
use pm_runtime_get_if_active() before accessing hardware registers.

Although this IRQ is not shared, spurious interrupts can still occur. If a
spurious interrupt fires while the device is in a suspended state with its
clocks disabled via zynqmp_dma_runtime_suspend(), could this unprotected
register read lead to a synchronous external abort and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525105042.2249=
542-1-nagendra.golla@amd.com?part=3D2

