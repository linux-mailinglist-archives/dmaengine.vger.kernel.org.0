Return-Path: <dmaengine+bounces-10931-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFPyCf5wFWpbVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10931-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:07:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5A5D3F1C
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA68C3006B03
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359C3D5C05;
	Tue, 26 May 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3SlmK2Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F2399348
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789639; cv=none; b=U9+L3K88b1lI8SwUQaDX2wW/scZoYUrTsEtXtyEwIYMxzFYp9W/RM7HeAET5GzH2GFCiW8HJGtGDSIR6WEoyphJElafM02jm69Qu47/QBiW3ILKwUETS9y8lOGEMYy1Yhr+wziiJYHTVtx9i0h2nINqAJ9UJrMAGhSU2lu3Rwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789639; c=relaxed/simple;
	bh=4Jb9pRxv1Euj0Dwn6ghSAFtZsKytsMVQv7DXpQAN6Ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gTyNRwOQ2DBh5ZgxkisfgQ0fsfNJlrhJY/QdvK8+jI1VTiAIP7pX2Kh/MhPTEcDOHdEIQDSe5ttC8Kndhcb6TmDbI2GucReL1w1d1fMWp93m/Wv/Z+ufuGH3B3dCaQnzZRxb5pHUnrqzdIBgzN4TS6XdY5x7pce6IBBUtJcICzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3SlmK2Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317F61F000E9;
	Tue, 26 May 2026 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789637;
	bh=nadVIG/9NI8YOlmv4HzYxkDOmfOUUNmPC+XbyI0hqxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3SlmK2ZxrAC1nUZCNXwOLA7iPH3Qk76UhcAsWtJS3lmStXF9LFa66eKX2Tb5xXnT
	 uIV43Ch42lOTarz97rSUAKAg8MCiuLgGEkVqry9734qSKImNqvoo5+Ho0wrKDbWV6i
	 mu1Ss+gq5+ygiuhzEazAQSky7wTdTHfwk9CFd+5Tg2MdUEoQ8c1SMhxF81Kt31bGUv
	 mXuqRGmksRalH7mqz4AU4xBO75W6AGFl3KxZQzGSkebGtDHQmIEOq/wiDEoHBwrOer
	 Ec6Q1HivCYKC6p9wX126vBCUjkKPmjykPS/PTx91FiugQnPRb5MKi379o36xROqzii
	 YgOmiMfoCf4KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/18] ASoC: renesas: rz-ssi: Use generic PCM
 dmaengine APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260526084710.3491480-18-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-18-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:00:36 +0000
Message-Id: <20260526100037.317F61F000E9@smtp.kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10931-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 09E5A5D3F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Removal of the `.remove` callback leaves the hardware un-reset and=
 active if the driver is unbound.

Pre-existing issues:
- [Critical] In PIO mode, if both streams share `irq_rt`, concurrent playba=
ck and capture causes an infinite interrupt storm.
- [High] TOCTOU race on `strm->substream` leading to a NULL pointer derefer=
ence in the interrupt handler.
- [High] Hardware error recovery blindly forces paused streams to start, ca=
using interrupt storms.
--

commit 7b32dcd4a1c5c9a1cf65850718c1a5545f3b08a5
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs

This commit reworks the Renesas RZ-SSI driver to use the generic PCM
dmaengine APIs instead of managing DMA directly. It replaces explicit DMA
resource cleanup with devres helpers, removes the driver remove callback,
and increases buffer sizes to prevent software underruns.

> diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
> index d4e1dded3a9c1..9fe8a639c47c1 100644
> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c

[ ... ]

> @@ -606,12 +591,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *d=
ata)
>  	if (irq =3D=3D ssi->irq_int) { /* error or idle */
>  		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
>  					      SSISR_TUIRQ | SSISR_TOIRQ));

[Severity: High]
This is a pre-existing issue, but does this error recovery logic blindly
force paused streams to start?

The is_stopped flag evaluates to true if ANY stream encounters an error.

If one stream is in a paused state (where its substream pointer is still
non-NULL), an error on the opposite stream will spontaneously restart the
paused stream here, which could lead to immediate underruns/overruns and an
interrupt storm.

> -		int i, count;
> -
> -		if (rz_ssi_is_dma_enabled(ssi))
> -			count =3D 4;
> -		else
> -			count =3D 1;
> =20
>  		if (ssi->capture.substream && is_stopped) {
>  			if (ssisr & SSISR_RUIRQ)

[ ... ]

> @@ -631,19 +610,41 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *=
data)

[ ... ]

>  		/* Add/remove more data */
>  		if (ssi->capture.substream && is_stopped) {
> -			for (i =3D 0; i < count; i++)
> +			if (rz_ssi_is_dma_enabled(ssi)) {
> +				if (ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
> +					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
> +			} else {
>  				strm_capture->transfer(ssi, strm_capture);
> +			}
>  		}
> =20
>  		if (ssi->playback.substream && is_stopped) {
> -			for (i =3D 0; i < count; i++)
> +			if (rz_ssi_is_dma_enabled(ssi)) {
> +				if (ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
> +					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
> +			} else {
>  				strm_playback->transfer(ssi, strm_playback);
> +			}
>  		}
> =20
>  		/* Resume */

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race here that could
cause a NULL pointer dereference?

When stopping a stream, rz_ssi_dai_trigger() calls rz_ssi_stop() (which mas=
ks
interrupts at the device level but lacks synchronize_irq()) and then calls
rz_ssi_stream_quit(), which sets strm->substream =3D NULL.

If the interrupt handler is already running concurrently on another CPU, it
could pass the lockless check on the stream's substream pointer, but then
rz_ssi_start() may fetch strm->substream again from memory after it was
nulled by trigger(STOP).

[ ... ]

> @@ -679,153 +680,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void =
*data)
>  	return IRQ_HANDLED;
>  }

[Severity: Critical]
This is a pre-existing issue, but does the irq_rt block in rz_ssi_interrupt=
()
cause an infinite interrupt storm in PIO mode when both streams are active
and share irq_rt?

It checks if the playback substream is valid and services ONLY the playback
stream:

	if (irq =3D=3D ssi->irq_rt) {
		if (ssi->playback.substream) {
			strm_playback->transfer(ssi, &ssi->playback);
		} else {
			strm_capture->transfer(ssi, &ssi->capture);
			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
		}
	}

If both playback and capture are open concurrently, any capture interrupt
(RX FIFO full) will be ignored.

The RX FIFO is never drained, the interrupt condition remains asserted,
and returning IRQ_HANDLED causes an immediate re-entry.

[ ... ]

> @@ -1236,43 +1137,19 @@ static int rz_ssi_probe(struct platform_device *p=
dev)

[ ... ]

> -static void rz_ssi_remove(struct platform_device *pdev)
> -{
> -	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
> -
> -	rz_ssi_release_dma_channels(ssi);
> =20
> -	reset_control_assert(ssi->rstc);
> +	return devm_snd_soc_register_component(dev, component_driver,
> +					       rz_ssi_soc_dai,
> +					       ARRAY_SIZE(rz_ssi_soc_dai));
>  }

[Severity: High]
Does removing the remove callback leave the hardware un-reset and active
if the driver is unbound?

The driver uses devm_reset_control_get_exclusive(), which only registers a
cleanup action to drop the reference (via reset_control_put()), but does not
assert the hardware reset line.

Without the explicit reset_control_assert() call that was removed here,
unloading the driver while the device is active will skip resetting the
hardware, potentially causing a resource leak or instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D17

