Return-Path: <dmaengine+bounces-10463-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id givEDgRVBWqAVAIAu9opvQ
	(envelope-from <dmaengine+bounces-10463-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:52:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1B53DC2F
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 984633017EC1
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387613B6347;
	Thu, 14 May 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEp2dsGY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15685376494
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734337; cv=none; b=ZkKvHWQqxZB63zR7uNiRjsGwPpVcMpr8laX/ch1g99iXEJDIef9iiCJTSvWo8jM+EvSkEnM/5bkVtB5o31Hse2JIQVZG93kMtQP+/wi1OyOcHSJsaSkNFV7XSX4YlmBIGqrYCztENkvuq+1xbAODPDzsN/Xj5+RV+tuII7j0KVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734337; c=relaxed/simple;
	bh=vDY155C2jIT9InquXBI+CaaX/9yklT4WX+zSf0g/DHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=raN8U6vrfzIpCvxfaMBTFFy6xm129WvufSLTei7z9bLv5foYF6nvc2dtG3VHEp918QF+FJFZ9XuwhXkGCIf+nbny2DfPdVEg3azTZnavLX/UI9+2kCpZkVt/LwkP9bZVNpiGcFDwC8pO8fLV6AHKGBkPLQP3TDPyZlscFFAquBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEp2dsGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA1C2BCB7;
	Thu, 14 May 2026 04:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734336;
	bh=vDY155C2jIT9InquXBI+CaaX/9yklT4WX+zSf0g/DHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GEp2dsGY8RbYdGHQft+kplMbZbM+keRPTQ3/HiUXk4QDEhp6TmnMeOw7pRMcEoDEI
	 nzQgtj4uz9NryuBXB3H9IFFLe0PgN6mCnw6hI1nsBhnEeNMa9t1WyoA2xwmY2pwfev
	 uQbw/zUd6LAZ2ZFssEZJBU64ugkx9dtAb57u5USvH3hKhlbhUPmQa11Zw/Ski+IQ6K
	 YRfuk7cCjKZG/iSjDOQxu2enLoRf9lXpJ0kA8sN/+zzN4K3P/7RkQ/jK322WkWLmrZ
	 1sjXEhm9kOnvrzuiHdWw5wGYL5hNyr8+1xThh2IQvTR0B8gZeN/93C38KiLqxacY7e
	 RYH9PEEmiYcLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] ASoC: renesas: rz-ssi: Use generic PCM
 dmaengine APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260512121219.216159-17-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-17-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 04:52:15 +0000
Message-Id: <20260514045216.23AA1C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BFD1B53DC2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10463-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,renesas.com:email,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Concurrency data race in rz_ssi_interrupt() leads to NULL poin=
ter dereference.
- [High] Error recovery logic leaves DMA channels permanently paused if a s=
tream is stopped.
- [High] Incomplete state cleanup in full-duplex mode causes permanent hard=
ware stall of active streams.
- [Medium] Deletion of the remove callback causes hardware state and reset =
leak on driver unbind.
- [Medium] dmaengine_resume() is called on unpaused DMA channels during ful=
l-duplex error recovery, violating DMA API contracts.
--

commit 3df78c9407acc2ae86671be88fbd3bf33a9d7d4f
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs

This commit migrates the Renesas RZ/G2L and RZ/G3S SSI driver to use generic
PCM dmaengine APIs instead of custom DMA handling. It also removes the
explicit remove callback, increases buffer sizes to reduce underruns, and
simplifies driver logic.

> diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
> index d4e1dded3a9c1..5406f9a3547f6 100644
> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c
[ ... ]
> @@ -606,12 +591,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *d=
ata)
>  	if (irq =3D=3D ssi->irq_int) { /* error or idle */
>  		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
>  					      SSISR_TUIRQ | SSISR_TOIRQ));
> =20
>  		if (ssi->capture.substream && is_stopped) {
>  			if (ssisr & SSISR_RUIRQ)
>  				strm_capture->uerr_num++;
>  			if (ssisr & SSISR_ROIRQ)
>  				strm_capture->oerr_num++;
> =20
>  			rz_ssi_stop(ssi, strm_capture);
>  		}
> =20
>  		if (ssi->playback.substream && is_stopped) {
>  			if (ssisr & SSISR_TUIRQ)
>  				strm_playback->uerr_num++;
>  			if (ssisr & SSISR_TOIRQ)
>  				strm_playback->oerr_num++;
> =20
>  			rz_ssi_stop(ssi, strm_playback);
>  		}
> =20
> +		if (!rz_ssi_is_stream_running(&ssi->playback) &&
> +		    !rz_ssi_is_stream_running(&ssi->capture) &&
> +		    rz_ssi_is_dma_enabled(ssi)) {
> +			if (ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
> +				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
> +			if (ssi->dmas[SNDRV_PCM_STREAM_CAPTURE] &&
> +			    /* Avoid calling pause twice in case of half duplex. */
> +			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK] !=3D
> +			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
> +				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
> +		}
> +
>  		/* Clear all flags */
>  		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ | SSISR_TUIRQ |
>  				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
> =20
>  		/* Add/remove more data */
>  		if (ssi->capture.substream && is_stopped) {
> -			for (i =3D 0; i < count; i++)
> +			if (rz_ssi_is_dma_enabled(ssi))
> +				dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);

Can this sequence lead to a NULL pointer dereference?

When a stream is stopped and closed, ALSA calls rz_ssi_dai_trigger(STOP)
(which clears the substream pointer) followed by rz_ssi_shutdown(), which
clears ssi->dmas[stream]:

sound/soc/renesas/rz-ssi.c:rz_ssi_shutdown() {
    ...
    ssi->dmas[substream->stream] =3D NULL;
}

If an in-flight interrupt handler is executing concurrently, the driver
disables device-level IRQs but never calls synchronize_irq(). The handler
could observe a non-NULL substream, but by the time it calls
dmaengine_resume(ssi->dmas[stream]), the teardown code on another CPU
could have nullified the pointer.

Can this error recovery logic leave the DMA channel permanently paused?

During an under/overrun error, the code above calls dmaengine_pause() on
both channels if neither stream is running. However, dmaengine_resume()
is only conditionally called if substream is non-NULL.

If one stream was intentionally stopped by the user (meaning its substream
is NULL), its DMA channel is left indefinitely paused. Since the ALSA
generic dmaengine PCM framework caches and reuses DMA channels, the channel
will remain paused on the next trigger(START), resulting in a silent audio
failure.

Does calling dmaengine_resume() here violate the DMA API contract?

In full-duplex mode, if an underrun/overrun occurs on one stream, the check
for !rz_ssi_is_stream_running() for both streams evaluates to false, so
dmaengine_pause() is completely skipped.

However, dmaengine_resume() is unconditionally called for the failing
stream. Calling resume on a channel that is currently active and was never
paused could cause state machine corruption in the DMA controller driver.

>  		}
> =20
>  		if (ssi->playback.substream && is_stopped) {
> -			for (i =3D 0; i < count; i++)
> +			if (rz_ssi_is_dma_enabled(ssi))
> +				dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
>  		}
> =20
>  		/* Resume */
>  		if (ssi->playback.substream && is_stopped)
>  			rz_ssi_start(ssi, &ssi->playback);
>  		if (ssi->capture.substream && is_stopped)
>  			rz_ssi_start(ssi, &ssi->capture);
>  	}

This isn't a bug introduced by this patch, but does the full-duplex error
recovery code cause a permanent hardware stall?

When operating in full-duplex mode, stopping one stream triggers an
underrun/overrun interrupt. The interrupt handler calls rz_ssi_stop() for
the remaining active stream and then rz_ssi_start() to recover it.

Because tx_active and rx_active remain true, rz_ssi_start() enters the
one_stream_triggered branch and sets it to true, without re-enabling the
SSICR_TEN and SSICR_REN hardware bits. The surviving stream is left
permanently stalled in hardware until both streams are closed.

[ ... ]
> -static void rz_ssi_remove(struct platform_device *pdev)
> -{
> -	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
> -
> -	rz_ssi_release_dma_channels(ssi);
> -
> -	reset_control_assert(ssi->rstc);
> -}

Does dropping the remove callback leak the hardware state and reset line on
driver unbind?

The driver relies on devm_pm_runtime_enable() to handle PM cleanup.
However, when the driver unbinds, pm_runtime_disable() cancels any pending
asynchronous suspends but does not force the device into a suspended state
if it was currently RPM_ACTIVE.

Consequently, rz_ssi_runtime_suspend() is bypassed, the reset line is never
asserted, and the PM domain clocks may remain enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D16

