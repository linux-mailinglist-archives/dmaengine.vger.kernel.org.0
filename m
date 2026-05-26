Return-Path: <dmaengine+bounces-10955-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGdpFNurFWrgXgcAu9opvQ
	(envelope-from <dmaengine+bounces-10955-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:19:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00705D7537
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4BC300E16F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A893B9935;
	Tue, 26 May 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxotj6Tc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A15358375
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805058; cv=none; b=eNc/s6uNIFzhIaspZaysLwIQACl7zv9c9BQ+u0q0GzaebdwuzGQdCtnf5oSjhgMDNVjgeD0Gx1No0Yu+f0kNh3dzBi12z/0dBul+Eua5WxZBDRKAgj9QbnzFFf6++uIOgMcn+7bfI7SmeRyUB4+j7p18NCF6kdCnat7MZsyE1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805058; c=relaxed/simple;
	bh=2wHs4jj3JzSVuItMJAnIDdMzEmCTB5om4CaqcvWE+0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zq5FvxIUkrjw+9kwmtZHODeJGcY/ZRBVHWpSJnCXeWSvxXLnK5DbsENOB+kNfuolek7itCRzqXEr0n/bjbDzKCGr5IVHI5EM+FyiD0JUzrBLaUFqXWmL09odJA7EDsnKUdLBdkJxuh1T8xCeNnswrukRnV6FDawz3rPlkXzDMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxotj6Tc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071A1F00A3A;
	Tue, 26 May 2026 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805056;
	bh=qbdSIAUSAoy1WIAQuBWJuGX5h+C3yIChmgXUEQyv4j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fxotj6TcEJWa2Vii7r3nJsMpVJNrbv2g9WSbR53/1gtoKoSpDGkZADgo8uwS20+Ei
	 nf7doOlfpV5Q/x18G5j5W6apS47TIYZUW2LmvREyn0r8EJ5LSGYXzxo8MKK0pOm0MU
	 DAvCFzt68EkfF1d/yjXbXdl+rPCSWcbBK83OGbPMwSgwDsoiwwFuonz6EQZtvBfGfF
	 +5Z9sTHe6Ti4E3HNOm/CP/kOG4xSEXRAgEHHgHx8rRC98mAyrz5Os29Mw04q7iHPMu
	 RUQ075CAaY3p/15rmcrd+1maVPAEAfvOA3IjySVImEPCIHASKC7s8AseIyuSO6coFL
	 thK3zyzh5xIuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/14] dmaengine: qcom: bam_dma: convert tasklet to
 a BH workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-3-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-3-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:17:35 +0000
Message-Id: <20260526141736.5071A1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10955-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: C00705D7537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect teardown sequence in `bam_dma_remove` leads to a synchro=
nous external abort (bus fault) when masking interrupts.
- [High] The IRQ handler accesses hardware registers before ensuring the de=
vice clock is enabled, leading to a potential bus fault.
- [High] Failing to clear a level-triggered interrupt when `pm_runtime_get_=
sync` fails causes an interrupt storm and device disablement.
--

commit 6a70ab3d7ea9134c2e9e75e415cbff4d0dd6592a
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue

This commit converts the BAM DMA driver from legacy tasklets to use the
modern high-priority variant of the BH workqueue.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index b3d36ea799843..1c62f845ac0b9 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c

[ ... ]

> @@ -893,9 +894,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
> =20
>  	srcs |=3D process_channel_irqs(bdev);

[Severity: High]
This is a pre-existing issue, but does process_channel_irqs() access
hardware registers before the device clock is guaranteed to be enabled?

In process_channel_irqs(), it immediately reads from BAM_IRQ_SRCS_EE. If a
spurious or delayed interrupt occurs while the device is runtime suspended,
could reading this register with the clock disabled cause a synchronous
external abort?

> =20
> -	/* kick off tasklet to start next dma transfer */
> +	/* kick off the work queue to start next dma transfer */
>  	if (srcs & P_IRQ)
> -		tasklet_schedule(&bdev->task);
> +		queue_work(system_bh_highpri_wq, &bdev->work);
> =20
>  	ret =3D pm_runtime_get_sync(bdev->dev);
>  	if (ret < 0)

[Severity: High]
This is also a pre-existing issue, but if pm_runtime_get_sync() fails,
the handler returns IRQ_NONE immediately without clearing the hardware
interrupt source.

Since the interrupt is registered as level-triggered (IRQF_TRIGGER_HIGH),
will exiting the handler without writing to BAM_IRQ_CLR cause the
interrupt controller to immediately re-assert it? Could this lead to an
interrupt storm that permanently disables the IRQ line?

[ ... ]

> @@ -1394,7 +1394,7 @@ static void bam_dma_remove(struct platform_device *=
pdev)
>  			    bdev->channels[i].fifo_phys);
>  	}
> =20
> -	tasklet_kill(&bdev->task);
> +	cancel_work_sync(&bdev->work);
> =20
>  	clk_disable_unprepare(bdev->bamclk);
>  }

[Severity: High]
This is a pre-existing issue, but earlier in bam_dma_remove(), the device
is forced into suspend:

bam_dma_remove()
    pm_runtime_force_suspend(&pdev->dev);
    ...
    writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

Does pm_runtime_force_suspend() disable the device clock? If so, will the
subsequent writel_relaxed() write to an unclocked register and trigger a
synchronous external abort during driver unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D3

