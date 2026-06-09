Return-Path: <dmaengine+bounces-11375-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vq/RNqGUKGoGGgMAu9opvQ
	(envelope-from <dmaengine+bounces-11375-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:33:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F266498F
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:33:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I0MlBvBR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11375-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11375-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88E98301A4E6
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E73749F4;
	Tue,  9 Jun 2026 22:29:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE6282F30
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:29:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044155; cv=none; b=mka3bX2dWXaiGPstOtTvSnB9tiZGsZuKDsZdIAcjQyhu8Chn5O3vbqlcn2YhgB4WLCLYHj6/EqU+ZKS40uFSlx543SX3kafVo43UGxUD4AHlWrA58sOBn+oEF+2IJVClEIFDsiAgVm3fzV2mZvXmCO6WNGBvFPLFnMwlaCmiCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044155; c=relaxed/simple;
	bh=GmpNT2Q5mJibp3ZeHvOJsHTyarR3nxkRSpJyzYER+6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgZuug7kolGcygPzxXtJ2T/VCyzt6P3KfcAkPt4w3aDIrNFms/DpPgg7ppy4bPAxKTvOEa2TMsmFSKJtN6rb/r+O5Gdm4Wfl9Go6F+A/Ir6L9fmkNEFZBePlOwvLgcIRJBoqJzdRKXx4/JDEKZvCLj2luDdwinWfPX8bpoJMp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0MlBvBR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E006F1F00898;
	Tue,  9 Jun 2026 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044154;
	bh=+XRiV9Hdx3FTA14RIeNZZQX9dCahVpVOcbCacL0v+wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I0MlBvBRubaujDQRWg2kGPnXuntZRMA3+DOsJ3d/D7UYm13f+hJcqgJQuU+wFU7CW
	 1Tq2KrlECabhetzJYZ5AR2lD0UymmipiSOORV1dqDQYIR3HUc8s4GtKQ/sltlAljHJ
	 oCipAM3XJARTDEApJ2xXoVXCyPFTRACQ8FcsGHlcssqyPk4FWdywiBasYuN4PP6kA0
	 XbxbmXnUFExcFi314qXftuai/Ef1rJHSEf07QQRxEIOjDnaAgvjqe8gUniSxmEUXfr
	 /vkZx6VGflCzXvGeTM6y7bjcs97I7VXV8mrwSeM4PU208my8G5iAg6obmmDvMBGDAd
	 bTKEE+105DD5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 04/15] dmaengine: fsldma: provide device_release
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260609221926.35538-5-rosenp@gmail.com>
References: <20260609221926.35538-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:29:13 +0000
Message-Id: <20260609222913.E006F1F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11375-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D60F266498F

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a double-free of `fdev` and multiple use-=
after-free (UAF) vulnerabilities during device teardown by leaving explicit=
 cleanup operations in `fsldma_of_remove` after the device might have been =
freed.

Pre-existing issues:
- [High] Individual DMA channel structures (`struct fsldma_chan`) are uncon=
ditionally destroyed in `fsldma_of_remove()`, causing use-after-free and in=
valid hardware access if dmaengine clients still hold references.
- [High] The driver frees the DMA channel structure without ensuring its as=
sociated tasklet is killed, which can lead to a use-after-free if the taskl=
et executes after the channel is freed.
--

commit f8012bef1fb7e396bca2eeb8a77b04e6cdee7e7c
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: provide device_release callback

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped. This patch allocates fdev with kzalloc_obj, provides the
device_release callback, and saves channel pointers to avoid UAF during
removal.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..06a6996a53229 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1211,6 +1211,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan =
*chan)
>  	kfree(chan);

[Severity: High]
This isn't a bug introduced by this patch, but does this code free the DMA
channel structure without ensuring its associated tasklet is stopped?

While fsldma_free_irqs() prevents new hardware interrupts, an interrupt
that fired previously could have scheduled the tasklet. If the tasklet is
pending in the softirq queue, it will execute dma_do_tasklet() after chan
has been freed, resulting in a use-after-free.

Would it make sense to call tasklet_kill(&chan->tasklet) before freeing
the channel?

>  }
> =20

[ ... ]

> @@ -1308,19 +1311,33 @@ static int fsldma_of_probe(struct platform_device=
 *op)
>  	return err;
>  }
> =20
> +static void fsldma_device_release(struct dma_device *dma_dev)
> +{
> +	struct fsldma_device *fdev =3D container_of(dma_dev, struct fsldma_devi=
ce,
> +						  common);
> +	kfree(fdev);
> +}
> +
>  static void fsldma_of_remove(struct platform_device *op)
>  {
> -	struct fsldma_device *fdev;
> +	struct fsldma_device *fdev =3D platform_get_drvdata(op);
> +	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
>  	unsigned int i;
> =20
> -	fdev =3D platform_get_drvdata(op);
> -	dma_async_device_unregister(&fdev->common);
> +	for (i =3D 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
> +		chans[i] =3D fdev->chan[i];
> =20
>  	fsldma_free_irqs(fdev);
> =20
> +	/*
> +	 * fdev may be freed by fsldma_device_release inside this call;
> +	 * use saved copies of the channel pointers afterwards.
> +	 */
> +	dma_async_device_unregister(&fdev->common);
> +
>  	for (i =3D 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
> -		if (fdev->chan[i])
> -			fsl_dma_chan_remove(fdev->chan[i]);
> +		if (chans[i])
> +			fsl_dma_chan_remove(chans[i]);

[Severity: Critical]
If dma_async_device_unregister() drops the last reference and triggers
fsldma_device_release() to free fdev, does fsl_dma_chan_remove() cause
a use-after-free?

Inside fsl_dma_chan_remove(), list_del(&chan->common.device_node) modifies
the list head linked to fdev->common.channels, which belongs to the newly
freed fdev.

[Severity: High]
This is a pre-existing issue, but does destroying the channel structures
synchronously in fsldma_of_remove() lead to invalid hardware access and
use-after-free if dmaengine clients still hold references?

Since the channel lifetime needs to match the DMA device container, memory
is freed and I/O mapped registers are unmapped here while clients might
still have active references. Could the channel teardown be moved to the
fsldma_device_release() callback instead?

>  	}
>  	irq_dispose_mapping(fdev->irq);

[Severity: Critical]
Does accessing fdev->irq here cause a use-after-free if fdev was already
freed by dma_async_device_unregister() earlier in this function?

The unquoted code immediately following this in fsldma_of_remove() also
proceeds to call iounmap(fdev->regs) and kfree(fdev), which appears to
cause a double-free if the release callback already ran.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-5-rosenp@gmail.com?part=3D1

