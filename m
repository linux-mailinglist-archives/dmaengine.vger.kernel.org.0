Return-Path: <dmaengine+bounces-11429-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OuzbDWAzKmrjjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11429-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:02:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633666E1C0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 06:02:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ds0hNMCF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11429-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11429-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A9FB3006926
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB01D86FF;
	Thu, 11 Jun 2026 04:02:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F640D573
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 04:02:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150553; cv=none; b=bQOMPkEMLcwySR20cuh+RQryKk0uBjC1DWFWT7m357VOSV+2wTp0X8THW9h8QS5uaOoHOyyFh9El68ECBtq5AcUGyA8eY04Id2ahzT6pB4TOXTyr3ZfXw5cwwaeZPtZvcnOAeCqhAR2IwnT+da3bLgaqbjs/L1NhtPcev6VX9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150553; c=relaxed/simple;
	bh=AIeuXQNC//+bQzfQFKJukTn+ya4F452qxFtxSLU9w2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2WBIUXwpcA0zAfTxx+KvecVfqnc2vRG8AN2Ujli1lZWfDiPHi6iPnSJ+cz/6lkCNX1iLI8b0+6eUYlRjGpyBtAb4YQ76m0s3fJI+lpZuJYC7JSF5GAJ1gmSyE2Fblq1waY0ldUQmnEVKaXtJJEVLcoziAqfBRWh16hYvNSbWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds0hNMCF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23F1F00893;
	Thu, 11 Jun 2026 04:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781150552;
	bh=Gp2Ve/zH5iRiTDsJFqarGX8iFc3j5dst0PzcCEoqCGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ds0hNMCFA+0riSWauLuYIXIqdl7Z1oz2LVjcZeyESpaY7nbIFfva1UujH5YowuFGz
	 eqLCuZ3jpjZZdcELcGh7ICUxkTZhMcP8VdrYw1vNvMigIEz1Cqrbwv9bdwkNAGsTkD
	 aCGDQHl7+3kB5XILbppLNKmHpt9rIFgU2ur09AaIg/ZAP2PdfTRY0ZkSXucZlZVlZB
	 fEXp0JTSZDKEopuyyMFmxHgQ20vvJrxVl4q/elYv7vlq24PJrzbj6g3GTso/sFNIc6
	 bidFpaZAhlWpAYuNwQI/Yjo3L7Z+e0CNjLlV7RetKlcOz0zTPTdZHmF3hyYdHWutdT
	 7nKFpjt5RwAmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 04/15] dmaengine: fsldma: provide device_release
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611035245.13439-5-rosenp@gmail.com>
References: <20260611035245.13439-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:02:31 +0000
Message-Id: <20260611040231.EB23F1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11429-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2633666E1C0

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Use-After-Free (Read/Write) and Double-Free of `fdev` during d=
evice removal.
- [High] Teardown reordering causes a race condition leading to hung transf=
ers.

Pre-existing issues:
- [Critical] Invoking client callbacks with the descriptor spinlock held ca=
uses a recursive deadlock.
- [High] DMA channels are unconditionally destroyed leading to potential Us=
e-After-Free by active clients.
- [High] Missing tasklet cancellation leads to a Use-After-Free of the chan=
nel structure.
- [High] The error rollback path in fsldma_suspend_late() double-unlocks sp=
inlocks.
--

commit dc56cbc463b043a9535d2906ead690c87f19ad18
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: provide device_release callback

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped (see the comment above dma_async_device_register()).

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..06a6996a53229 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1211,6 +1211,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan =
*chan)
>  	kfree(chan);
>  }

[Severity: High]
This is a pre-existing issue, but does this unconditionally destroy the
channel even if clients are still using it?

Since dma_async_device_unregister() doesn't enforce that clients drop all
channel references before it returns, clients might still hold pointers to
the freed chan structure.=20

If they try to use it later, couldn't this cause a use-after-free?

[Severity: High]
This is also a pre-existing issue, but is it safe to free the channel witho=
ut
killing the tasklet first?

The code frees the IRQ but does not call tasklet_kill(&chan->tasklet).=20

If an interrupt fires and schedules a tasklet just before the IRQ is
disabled, the tasklet could execute concurrently or later and dereference
the freed chan structure in dma_do_tasklet().

> =20
> +static void fsldma_device_release(struct dma_device *dma_dev);
> +

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

[Severity: High]
Does this reordering open a race condition that could hang transfers?

By calling fsldma_free_irqs(fdev) before dma_async_device_unregister(),
there is a window where the DMA device is still fully active and accepting
new transfers, but its interrupts have been disabled and freed.=20

If a transaction completes during this window, will the completion interrupt
never fire?

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
>  	}
>  	irq_dispose_mapping(fdev->irq);
> =20

[Severity: Critical]
Does this sequence result in a use-after-free and double-free of fdev?

If dma_async_device_unregister() drops the final reference and triggers
fsldma_device_release(), fdev is freed.=20

However, the function then continues to access fdev indirectly by calling
fsl_dma_chan_remove(chans[i]), which modifies the list. It also reads
fdev->irq here to perform unmapping, and eventually explicitly calls
kfree(fdev) at the end of the function.

[Severity: High]
This is a pre-existing issue, but does fsldma_suspend_late() double-unlock
spinlocks in the error rollback path?

In fsldma_suspend_late(), the forward iteration acquires the descriptor
spinlock, updates the state, and then unlocks it on success. If it
encounters a busy channel, it jumps to the out label to roll back.=20

However, the rollback loop unconditionally calls
spin_unlock_bh(&chan->desc_lock) for all previously processed channels,
even though their locks had already been successfully released in the
forward loop.

[Severity: Critical]
This is a pre-existing issue, but does invoking client callbacks with the
descriptor spinlock held cause a recursive deadlock?

fsldma_cleanup_descriptors() is called with chan->desc_lock held. It then
calls fsldma_run_tx_complete_actions(), which synchronously invokes the
client's completion callback.=20

If the client submits a new DMA transaction from within this callback:

fsldma_run_tx_complete_actions()
   dmaengine_desc_get_callback_invoke()
      client_callback()
         fsl_dma_tx_submit()

Will fsl_dma_tx_submit() attempt to acquire the exact same chan->desc_lock
and result in an immediate deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611035245.1343=
9-5-rosenp@gmail.com?part=3D1

