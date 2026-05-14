Return-Path: <dmaengine+bounces-10462-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFJ3E3RHBWpDUAIAu9opvQ
	(envelope-from <dmaengine+bounces-10462-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:54:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA253D6AB
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 05:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B09030376A7
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244532EC54C;
	Thu, 14 May 2026 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7pCOv46"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEE2989B5
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730865; cv=none; b=MErkLHXWb72RGAW5TtA0EbSoGeRjnktTMLS+Quxdej3rd9pG96g276kxZ2OY7K3u1UBh7tKfr9AoaCsQz11+SLakbGDBVn5ID4XTK9qbA3TFJgZpa+4+JHlZRXwjyKybGmegBJnP0ChYchMWZLKHBXWYN79wCR2l4kMYvh3jZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730865; c=relaxed/simple;
	bh=1Oi1iAfbiWNRqeqFUW7jrzpmrb/U+yZNqObUSAG7oKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7jVswdYAGKzOAUU7PnFxNMDNF6ZiPxs4+t5F1WyPcnVVglvPqAkNmfatTwu7TrqLLU0GJvXHbGYbt+BAxm/Id/AHgX1YMnNZxUB1pku1Hh3+vl87tK/rhrrQ87BWZ+XQWV3TkasPxUPGTEBisezogvASf5M9k/FmiegcFDMrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7pCOv46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE65C2BCB7;
	Thu, 14 May 2026 03:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778730864;
	bh=1Oi1iAfbiWNRqeqFUW7jrzpmrb/U+yZNqObUSAG7oKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G7pCOv46WNGECZawQ67cBORiIJeMbdLi9t+oaWos3LRPJ/afUiE9QytQ9xvs25V3Z
	 ees5DBAJszmP8emFTaDv1Wkptc2fKHNe1py0goSrXlgyIHa3vGK15b5+RMbty8DYTB
	 pth82QumLINM56vSnMjeQ7i3qtwuurzquWVhy+DIZFk11kdsk4ez9ReEvZBOnMqrAh
	 l/BGw1bDgIT9ESz7CbLtwWr7gjO1pfC9O7wGSWOawRKtRZUhl5MLLRLmY5NhB6SYxI
	 l49P3BFrRr7nIQTbwee3yoG+vLlUON4iL3MCXk3V/Ty0BQf1QcrKO8rTTa9ZAAyAIw
	 6cvYmDU0cUojA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] ASoC: renesas: rz-ssi: Add pause support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: wsa+renesas@sang-engineering.com, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512121219.216159-16-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-16-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:54:23 +0000
Message-Id: <20260514035424.5AE65C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A2FA253D6AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10462-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,renesas.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Out-of-bounds DMA Access on Resume due to missing bounds check
- [Critical] Catastrophic DMA release on active channels during PAUSE_RELEA=
SE failure
- [Critical] Use-After-Free during STOP/PAUSE in Full-Duplex mode
- [High] Full-Duplex Auto-Restart Loop on Pause
- [High] Data Loss on Resume due to skipped period
- [High] Race condition on asynchronous DMA termination
- [High] Hardware registers modified without lock protection
--

commit e6b2a93963fa9285cbb11812697caca72ab79258
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ASoC: renesas: rz-ssi: Add pause support

Add pause support as a preparatory step to switch to PCM dmaengine APIs.

> diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
> index 71e434cfe07b9..d4e1dded3a9c1 100644
> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c
> @@ -847,6 +847,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
> =20
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		ret =3D rz_ssi_trigger_resume(ssi, strm);

If a pause is triggered right when strm->completed_dma_buf_pos is at
runtime->buffer_size - runtime->period_size, could rz_ssi_trigger_resume()
set strm->dma_buffer_pos exactly to runtime->buffer_size?

rz_ssi_trigger_resume() sets:
    strm->dma_buffer_pos =3D strm->completed_dma_buf_pos + runtime->period_=
size;

If this happens, will the next DMA transfer read or write out of bounds past
the end of the allocated ALSA ring buffer?

Also, in half-duplex mode where PAUSE_PUSH successfully aborts the current
period, does adding runtime->period_size here permanently discard the
unplayed/uncaptured period and create a gap in the audio data?

Both of these regressions are noted as fixed later in the series by
commit "ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs".

Since rz_ssi_stop() returns early in full-duplex mode without terminating
the active DMA channel, what happens if PAUSE_RELEASE is issued before the
active descriptors complete?

Execution will fall through to the SNDRV_PCM_TRIGGER_START case and call
rz_ssi_dma_slave_config() on the still-active DMA channel. If the dmaengine
driver rejects this configuration and returns -EBUSY, the fallback to PIO
will call rz_ssi_release_dma_channels(ssi).

Since rz_ssi_release_dma_channels() unconditionally releases both playback
and capture DMA channels, could this cause a use-after-free or panic if the
opposite stream is actively mid-transfer?

This regression is also fixed later in the series by commit "ASoC: renesas:
rz-ssi: Use generic PCM dmaengine APIs".

In half-duplex mode, PAUSE_PUSH terminates the DMA via
dmaengine_terminate_async(). During PAUSE_RELEASE, is there a
synchronization point (like dmaengine_synchronize()) to ensure the
termination has completed before new descriptors are queued?

If the asynchronous termination is still executing when the new descriptors
are queued, could they be inadvertently purged?

This is noted as fixed later in the series by commit "ASoC: renesas: rz-ssi:
Use generic PCM dmaengine APIs".

>  		if (ret)
>  			return ret;

[ ... ]

> @@ -888,6 +889,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
>  		break;
> =20
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		rz_ssi_stop(ssi, strm);

This isn't a bug introduced by this patch, but adding PAUSE exposes it
further. In rz_ssi_stop(), if one stream is halted but the other is still
running (full-duplex), the function returns early without calling
dmaengine_terminate_async().

If the ALSA subsystem subsequently closes the stream and frees the ring
buffer while the DMA channel continues executing already-queued descriptors,
could this lead to a use-after-free?

This is fixed later in the series by commit "ASoC: renesas: rz-ssi: Use
generic PCM dmaengine APIs".

In full-duplex mode, pausing one stream skips disabling the hardware and do=
es
not terminate the DMA channel. When the DMA channel eventually starves the
hardware FIFO, it triggers an underflow/overflow interrupt.

Since the interrupt handler unconditionally queues new descriptors and calls
rz_ssi_start() (which sets strm->running =3D 1), will this completely overr=
ide
the ALSA PAUSE state and allow the stream to continue processing buffers in
an endless interrupt storm?

This logic flaw survives the next patch "ASoC: renesas: rz-ssi: Use generic
PCM dmaengine APIs".

Also not a bug introduced by this patch, but adding PAUSE exposes more paths
invoking these functions. rz_ssi_start() and rz_ssi_stop() perform non-atom=
ic
read-modify-write operations on shared hardware registers (SSICR and SSIFCR)
without acquiring ssi->lock.

If playback and capture triggers happen simultaneously on different CPUs,
could race conditions cause both CPUs to read stale state and fail to enable
SSICR_TEN | SSICR_REN?

This race condition survives the next commit "ASoC: renesas: rz-ssi: Use
generic PCM dmaengine APIs".

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D15

