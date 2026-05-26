Return-Path: <dmaengine+bounces-10928-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL0lOwpuFWo2VAcAu9opvQ
	(envelope-from <dmaengine+bounces-10928-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:55:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 582715D3C55
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A663029750
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE183D88F1;
	Tue, 26 May 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFS/NXZv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5323D9686
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788812; cv=none; b=VR/UyGZuRdY4jZv4erYo28PVxq3RfXBfOg7mlNJjwBQPQNcIN23EV0JD3dwm7N8hpBuu3FDoNCT5UZpEQqp6uApCNcEyO80BHRUgh4/A3GWRh99dW4JG2ZEwt7FJFsvgvlZW2ft9bMUB/p3QPijaAoPhRti+Wiyv3r45qTeOc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788812; c=relaxed/simple;
	bh=Z5n1EokKj2tXthuqQvGZ5Cd7p7iKhLgR2g/CuaqYyS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DpSyQ2dLvzNyhMScybVHg+5xi9PKbG8KIVZECxv/Gai/UE1hM/q4baN8Q7I38NiAI08TbhWZoDRXeQMjyySGbjMoVm7VZTysGI3BODsHsTsZX5ZUN6UYehN9xt3uWg81xUyPgL1+8Ho1+czrFMW6P5Rv90gPEJYUOHLKwCf6kzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFS/NXZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE291F00A3C;
	Tue, 26 May 2026 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788809;
	bh=hbxPkevKMRcERFGS3Qcq0aqZ7jT3TmetwosgPvBnU0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFS/NXZvEMznrlZRBYwrBzYFe9/eK1YKFbdc8Nl9+kU6L/PzB3mhidL0Ou0JWiHMr
	 gMZymRMRwPslIQPL03x5nXJPQn6ptLLjZ1Dl8d2oFCW9kMT5rF2GL2a1sv/hcD6zCW
	 j/TnSB/8KHy25u3IvUNMAKTjbdurlV8CVbhbIsfWjVONLpOkMGapd2i2gZgx6L0TMF
	 kHjknXeYnYsgB9r9fVn1mmVOFyg0J9gqlle/P4Thq/OAYeTTQ6/2W0Gfjq7XB1QZ7U
	 3SjKkzBXyw1aooJITV4JtIj5I6l8xTckQ3YKUlgwc4LGZYP+CMwYEkuXOCK2m2JFc9
	 vM0mBUo0sE6cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/18] ASoC: renesas: rz-ssi: Add pause support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260526084710.3491480-17-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-17-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:46:48 +0000
Message-Id: <20260526094648.DAE291F00A3C@smtp.kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,renesas.com:email,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10928-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 582715D3C55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The pause/resume implementation terminates the DMA channel and rec=
alculates pointers to period boundaries, violating ALSA's lossless pause se=
mantics and causing permanent audio data loss.
- [High] In full-duplex mode, PAUSE_PUSH fails to pause the hardware or DMA=
, leading to hardware starvation, auto-restart loops, and DMA queue explosi=
on on PAUSE_RELEASE.
--

commit 7d75d5203513e23a4244ea8798db8bc41af3f70c
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ASoC: renesas: rz-ssi: Add pause support

This commit adds ALSA pause support (PAUSE_PUSH and PAUSE_RELEASE) to the
rz-ssi driver as a preparatory step for switching to PCM dmaengine APIs.

> diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
> index 71e434cfe07b9..d4e1dded3a9c1 100644
> --- a/sound/soc/renesas/rz-ssi.c
> +++ b/sound/soc/renesas/rz-ssi.c
[ ... ]
> @@ -888,6 +889,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
>  		break;
> =20
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		rz_ssi_stop(ssi, strm);
>  		break;

[Severity: High]
When PAUSE_PUSH is issued in half-duplex mode, rz_ssi_stop() calls
dmaengine_terminate_async(), which discards all in-flight DMA progress.

On PAUSE_RELEASE, rz_ssi_trigger_resume() recalculates the DMA pointer:

static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi,
                                 struct rz_ssi_stream *strm)
{
        ...
        strm->dma_buffer_pos =3D strm->completed_dma_buf_pos +
                               runtime->period_size;
        ...
}

Does this effectively snap to the next period boundary and permanently skip
the partially transferred period, violating ALSA's lossless pause semantics?

Additionally, calling dmaengine_terminate_async() without
dmaengine_synchronize() before submitting new descriptors can expose race
conditions. I notice this is fixed later in the series in commit
7b32dcd4a1c5c ("ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs").

[Severity: High]
During full-duplex operation, if PAUSE_PUSH is issued to one stream while
the other runs, rz_ssi_stop() returns early without disabling the hardware
or terminating the DMA channel:

static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
{
        strm->running =3D 0;

        if (rz_ssi_is_stream_running(&ssi->playback) ||
            rz_ssi_is_stream_running(&ssi->capture))
                return 0;
        ...
}

Because the stream is marked as stopped but the hardware keeps running,
the DMA callbacks will stop queuing new descriptors. Will this starve the
hardware FIFO and trigger an under/overrun interrupt?

If the interrupt handler rz_ssi_interrupt() detects the error, will it
force the stream back into a running state via rz_ssi_start() because
strm->substream is not cleared during a pause?

When PAUSE_RELEASE is subsequently issued, the driver falls through to
SNDRV_PCM_TRIGGER_START and queues 4 additional descriptors onto the
already-running DMA channel. Can this corrupt the state and risk queue
exhaustion?

I see this is also fixed later in the series in commit 7b32dcd4a1c5c
("ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D16

