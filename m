Return-Path: <dmaengine+bounces-11860-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQRoBd1GQmp83gkAu9opvQ
	(envelope-from <dmaengine+bounces-11860-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1842A6D8D4B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YwIsdN9t;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11860-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11860-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41F9301C974
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD303A2E00;
	Mon, 29 Jun 2026 10:17:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0183FA5EF
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728243; cv=none; b=eK2lhRKiWADoGh6f0USsKxgNqV3uSXqTUlpcGHrkwoL58HUZ+478REKHtANR3h3QlW2QXvjBlK2x9KlE7/q1BwQEZ6tz/hGCdQDZbyZuVFHiW5iyuzf2TIn8rXVH2aSLISTL9BoPk7Dg5VXSUhkm7iPiPNPyqoE7plxlLGn3T+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728243; c=relaxed/simple;
	bh=LZk/t+FtfcQO8SO+JcNbwhOEnWvZxQktgLkFBQDVRp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ddB7i3vwh3/0MZrnOC/ohnrcOZZFQyDnJVj+r4S/BDq1M8Ds5YRIV+L9h5Ioh/P7Iy1wPvF6FpCm5inVqgOrRhaiO0sfohCudCGbJ5eEXg46dTa/2nO7SR/XTpQ2auOmjsSsWAsZ6X2sr+yVD5sM1sOoE3o/6qICblJFrOEFHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwIsdN9t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27B71F00A3A;
	Mon, 29 Jun 2026 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728240;
	bh=dt2Lmz3iblst9+wO2zO9tYRTIo5RGbMCi6ceO+LbJXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwIsdN9t4HwTEom+XwJJVZj+w1INwbwR8iD0v41c8DkKMT0xiE8GsMG4fT2t7Z7Ra
	 s+Vj56eu7xNQhot0FTLT0kbAtvDn6jvnw0mX289sDGFxO7kqRh9tRSuQk5WtaIRY2x
	 it5bR5sD2h8GWIcTJpUZUBC0PwooydKkDOOR80qTpYUdGlREEenSsqErTZgz6V35p0
	 ai0YgPK73/gYx969VG357wb5ouP/76Qy3Grv3OzusQwN/fdjCr4hey2JQs+c/G9IoU
	 ZuDI1CUD3gjhoNraNoeQuPxddggASv46p5KgkGyKVTBFIRXCmzTVmfmOK94yZf7XP/
	 f01NK25CP30+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 03/14] dmaengine: qcom: bam_dma: convert tasklet to
 a BH workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-3-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-3-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:17:18 +0000
Message-Id: <20260629101719.A27B71F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11860-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1842A6D8D4B

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A modulo math mismatch between the ring buffer size and the CI=
RC_SPACE calculation allows the tail pointer to jump over the head pointer.
- [High] Hardware registers are accessed after device clock is disabled dur=
ing removal, due to pm_runtime_force_suspend() being called too early.
- [High] Hardware registers accessed in IRQ handler before device is confir=
med active, risking a bus fault.
- [High] Missing usage counter decrement when pm_runtime_get_sync() fails, =
leading to PM runtime refcount leak.
--

commit 0c2081a4425fb055ae1074f9c27f82d0875546e3
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue

This commit converts the BAM DMA driver to use the high-priority variant
of the BH workqueue instead of legacy tasklets for starting DMA transaction=
s.

> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index fc155e0d1870c..ea3df28e777f9 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c

[ ... ]

> @@ -922,9 +923,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
> =20
>  	srcs |=3D process_channel_irqs(bdev);

[Severity: High]
This is a pre-existing issue, but does process_channel_irqs() read from
hardware registers before the device is confirmed active? If a spurious
interrupt occurs while the device is suspended, could this unprotected
hardware access trigger an unclocked access exception and crash the system?

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
This isn't a bug introduced by this patch, but if pm_runtime_get_sync()
fails here, should we call pm_runtime_put_noidle() before returning?
Without it, the PM runtime usage counter might leak and prevent the device
from entering runtime suspend again.

[ ... ]

> @@ -1120,14 +1121,14 @@ static void bam_start_dma(struct bam_chan *bchan)
>  }

[Severity: Critical]
This is a pre-existing issue, but there appears to be a modulo math mismatch
in bam_start_dma() when evaluating available buffer space:

avail =3D CIRC_SPACE(bchan->tail, bchan->head, MAX_DESCRIPTORS + 1);
...
bchan->tail +=3D async_desc->xfer_len;
bchan->tail %=3D MAX_DESCRIPTORS;

Could this mismatch between CIRC_SPACE assuming a capacity of 4096 and the
explicit modulo using 4095 allow the tail pointer to jump over the head
pointer? When the buffer is full (tail reaches 4094 and wraps to 0), does
CIRC_SPACE calculate the space as 4095, falsely indicating an empty buffer
and allowing the hardware to overwrite active descriptors?

[Severity: High]
Also in bam_start_dma(), as a pre-existing issue, if pm_runtime_get_sync()
fails:

ret =3D pm_runtime_get_sync(bdev->dev);
if (ret < 0)
        return;

Does this early return need a call to pm_runtime_put_noidle() to avoid
leaking the PM runtime usage counter?

[ ... ]

> @@ -1424,7 +1424,7 @@ static void bam_dma_remove(struct platform_device *=
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
This isn't a bug introduced by this patch, but does bam_dma_remove()
access hardware registers after the device clock is disabled?

pm_runtime_force_suspend(&pdev->dev);
...
writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

Since pm_runtime_force_suspend() disables the BAM clock, could accessing
hardware registers immediately after trigger a bus fault and crash during
driver unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D3

