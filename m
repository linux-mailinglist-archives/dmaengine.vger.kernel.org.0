Return-Path: <dmaengine+bounces-8493-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLGyGFZDd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8493-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:35:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31E870D1
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EA430432E5
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6393321C8;
	Mon, 26 Jan 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oEYv7JU+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510A331A5B
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423537; cv=none; b=saaU4wl+cuy830dVOJPxdYOrPQ6SSO6etdXlNcIyjPxu1Zq7EYKkcR1csFt/psovEEiBnFsai7T6MrSaIsSxH4EkSr4fGWB08nragJNp7ehATnN9Bl/pkbnDvpGwVDxH7KZwCtwTUQ/P2IYG6lJDjBcyLH+i6qsmtltYujep0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423537; c=relaxed/simple;
	bh=/CxE8jUKzLebQaXVhz58X+uWWo9J9kVtaOvO06Vm32Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVh+lkbFKqj3NQmmnrFWIacVJrXxKROajo/SOZwQGMfLcBeAveLRabOrqnsMO5jy6BotIOcceF1nLPs/VvwGrlbBwIBvzSB24hMMdMnXO0/bGAy6zZ6dHit2zgH0Ztt4c5AVjNNhanB2IbTDKXPhpXeftbAsn0+t2Mvs9FrjOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oEYv7JU+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2605106f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769423532; x=1770028332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M5P+3SPmuUnRvbdXyjEmPFP58yjqtAcvMTbATpIr9E=;
        b=oEYv7JU+kWaZKo/HyvDDC8mcvHQHpiBhw0+nekONrYfKFTcBxnr7yipzvFPKdSD/P5
         WSp9Pi3F7M1s/h7m928ku6TPUtF/nGnHXfX93PAcHnnc010lxft5ZB9gkomi/x4QlQYg
         oaRrR63w2aoaQjtxmiRGyNn6Xv3CZDBI0nexInK+RseJFaXJUnLYHjYS9choJqt1CN/v
         wZEooPDdcN/BH5roEubZ4SnW1Ch09auDiXD2v9Cc+znKnu0R/Mi6w8fCIX0dcmmjlLI4
         qz6Bvig68Ys106xGn+1TJHWBfqq5GibxTR8me/wAn55UHDk1E18M1vzVIcf9Gh07l4+6
         48/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423532; x=1770028332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+M5P+3SPmuUnRvbdXyjEmPFP58yjqtAcvMTbATpIr9E=;
        b=HeGGMYqAwEKZd8JyUYfJr18sSTCKZFGKDNqDggT8r5S1SWgM5IxcYF1io8P21nq/qn
         tYrhdkBbTWrGPdtASoN6N9Iey/5C9Ta4wAv0KkeX0Z6LqOLbG8hh3hqxuLxBD06DSUyy
         mlK/UXHPhKZyAjpnV/hUgfEwtWeLX+sgqfs9i6Ktfzxs+4Qa7v6pEOT+Pz5iOGR0kbwy
         hUWEDcIAP0F4RD6AcEPzZYSRztJFEUFof3eCGy9QtPvOizfCFxO7msVimTU4/VkQ5TIK
         Bq0TXbh+9kvwns+Pz37br32D6MW/58VAdOVgMJHkRWDmnx1Wfvbs9ewny9IhRT3CWsGj
         NfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLqPmNR5PpU5BbfaYgLOR6Jdq/uUghCZYUukfH/hIyAKkIz2GeSN/QCLRQ7I511OpKyRfc2BzmCLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIgJMqgqAkPjgPPM8u+B8+wwHUbww51TTNH6FDJo0eUmEuNOs
	6iw7dgk/9ANV5VGaa8BJRFlTeOIKb3RmDf5fWM4nnsV5aY7S1oYMlOCE0vyy0qfTBnY=
X-Gm-Gg: AZuq6aLgec58Bn7BStKG1JD0rMQHiLFe3pvz7tqRRs7HwYeryaqojk/F/qJMZlhueNO
	4+NomFR1+2aZ3kKfxkT+8BDV4+gothReP7RsLoXpCbOPHuMhoQfzsTE81T9cpSRT99jaXDeEyXY
	lrIDtc+GsIIR/w2LubRwwwwo5YPGqbaGhT96nZoUG4hPJREOaB/68SiI5Lo8bVppqF24XSHTfSR
	v6o7453QrRznWenBHIaJrM9YbT4a1OYmwrYGpwHkYm+3VWAVzD1Bpc6Vh4sMZ5ssrVLSW8ABaco
	7lCL2iU7qUJdMfA0dq4nc4yMZ+S/FxSLN2/0UB6CAxFWRt7E8lfOvgVcVvMhGk/IHI0o4uQjbuY
	eoLBoBaUEck5Bsmhcdl++J64WR8mVetoAeSa86PfnMZiesCRYq9XTZ5+peC6273xZ7ahC2xRISw
	yf6Bp40NnvXTO/RaVRW3bF7zhKx/g1fp83g4Lu0Os=
X-Received: by 2002:a5d:5d0a:0:b0:42f:bb08:d1ef with SMTP id ffacd0b85a97d-435ca145771mr6369076f8f.17.1769423532322;
        Mon, 26 Jan 2026 02:32:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm29715049f8f.10.2026.01.26.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:32:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/7] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
Date: Mon, 26 Jan 2026 12:31:54 +0200
Message-ID: <20260126103155.2644586-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8493-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: ED31E870D1
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
files occasionally contained random spikes when viewed with a profiling
tool such as Audacity. These spikes were also audible as popping noises.

Using cyclic DMA resolves this issue. The driver was reworked to use the
existing support provided by the generic PCM dmaengine APIs. In addition
to eliminating the random spikes, the following issues were addressed:
- blank periods at the beginning of recorded files, which occurred
  intermittently, are no longer present
- no overruns or underruns were observed when continuously recording
  short audio files (e.g. 5 seconds) in a loop
- concurrency issues in the SSI driver when enqueuing DMA requests were
  eliminated; previously, DMA requests could be prepared and submitted
  both from the DMA completion callback and the interrupt handler, which
  led to crashes after several hours of testing
- the SSI driver logic is simplified
- the number of generated interrupts is reduced by approximately 250%

In the SSI platform driver probe function, the following changes were
made:
- the driver-specific DMA configuration was removed in favor of the
  generic PCM dmaengine APIs. As a result, explicit cleanup goto labels
  are no longer required and the driver remove callback was dropped,
  since resource management is now handled via devres helpers
- special handling was added for IP variants operating in half-duplex
  mode, where the DMA channel name in the device tree is "rt"; this DMA
  channel name is taken into account and passed to the generic PCM
  dmaengine configuration data

All code previously responsible for preparing and completing DMA
transfers was removed, as this functionality is now handled entirely by
the generic PCM dmaengine APIs.

Since DMA channels must be paused and resumed during recovery paths
(overruns and underruns), the DMA channel references are stored in
rz_ssi_hw_params().

The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
driver no longer manages DMA transfers directly.

Finally, rz_ssi_stream_is_play() was removed, as it had only a single
remaining user after this rework, and its logic was inlined at the call
site.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 355 ++++++++-----------------------------
 1 file changed, 77 insertions(+), 278 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 39aa865bdca3..d9c88a1975b8 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
@@ -87,8 +89,6 @@ struct rz_ssi_stream {
 	struct rz_ssi_priv *priv;
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
-	int dma_buffer_pos;	/* The address for the next DMA descriptor */
-	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=stopped, 1=running */
@@ -96,8 +96,6 @@ struct rz_ssi_stream {
 	int uerr_num;
 	int oerr_num;
 
-	struct dma_chan *dma_ch;
-
 	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm);
 };
 
@@ -108,7 +106,6 @@ struct rz_ssi_priv {
 	struct clk *sfr_clk;
 	struct clk *clk;
 
-	phys_addr_t phys;
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
@@ -148,9 +145,10 @@ struct rz_ssi_priv {
 		unsigned int sample_width;
 		unsigned int sample_bits;
 	} hw_params_cache;
-};
 
-static void rz_ssi_dma_complete(void *data);
+	struct snd_dmaengine_dai_dma_data dma_dais[SNDRV_PCM_STREAM_LAST + 1];
+	struct dma_chan *dmas[SNDRV_PCM_STREAM_LAST + 1];
+};
 
 static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32 data)
 {
@@ -172,11 +170,6 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 	writel(val, (priv->base + reg));
 }
 
-static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substream)
-{
-	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-}
-
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *substream)
 {
@@ -185,7 +178,7 @@ rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *substream)
 
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 {
-	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
+	return !ssi->playback.transfer && !ssi->capture.transfer;
 }
 
 static void rz_ssi_set_substream(struct rz_ssi_stream *strm,
@@ -215,8 +208,6 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 			       struct snd_pcm_substream *substream)
 {
 	rz_ssi_set_substream(strm, substream);
-	strm->dma_buffer_pos = 0;
-	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
 
@@ -242,12 +233,13 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 		dev_info(dev, "underrun = %d\n", strm->uerr_num);
 }
 
-static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
-			    unsigned int channels)
+static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, struct snd_pcm_substream *substream,
+			    unsigned int rate, unsigned int channels)
 {
 	static u8 ckdv[] = { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 96 };
 	unsigned int channel_bits = 32;	/* System Word Length */
 	unsigned long bclk_rate = rate * channels * channel_bits;
+	struct snd_dmaengine_dai_dma_data *dma_dai;
 	unsigned int div;
 	unsigned int i;
 	u32 ssicr = 0;
@@ -290,6 +282,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 		return -EINVAL;
 	}
 
+	dma_dai = &ssi->dma_dais[substream->stream];
+
 	/*
 	 * DWL: Data Word Length = {16, 24, 32} bits
 	 * SWL: System Word Length = 32 bits
@@ -298,12 +292,18 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	switch (ssi->hw_params_cache.sample_width) {
 	case 16:
 		ssicr |= SSICR_DWL(1);
+		dma_dai->maxburst = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 24:
 		ssicr |= SSICR_DWL(5) | SSICR_PDTA;
+		dma_dai->maxburst = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case 32:
 		ssicr |= SSICR_DWL(6);
+		dma_dai->maxburst = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
@@ -344,7 +344,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	bool is_play = rz_ssi_stream_is_play(strm->substream);
+	bool is_play = strm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
@@ -423,14 +423,6 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	/* Disable TX/RX */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
-	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi)) {
-		if (ssi->playback.dma_ch)
-			dmaengine_terminate_async(ssi->playback.dma_ch);
-		if (ssi->capture.dma_ch)
-			dmaengine_terminate_async(ssi->capture.dma_ch);
-	}
-
 	rz_ssi_set_idle(ssi);
 
 	return 0;
@@ -458,10 +450,6 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter = current_period;
 	}
-
-	strm->completed_dma_buf_pos += runtime->period_size;
-	if (strm->completed_dma_buf_pos >= runtime->buffer_size)
-		strm->completed_dma_buf_pos = 0;
 }
 
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
@@ -606,12 +594,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 	if (irq == ssi->irq_int) { /* error or idle */
 		bool is_stopped = !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
 					      SSISR_TUIRQ | SSISR_TOIRQ));
-		int i, count;
-
-		if (rz_ssi_is_dma_enabled(ssi))
-			count = 4;
-		else
-			count = 1;
 
 		if (ssi->capture.substream && is_stopped) {
 			if (ssisr & SSISR_RUIRQ)
@@ -619,7 +601,8 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 			if (ssisr & SSISR_ROIRQ)
 				strm_capture->oerr_num++;
 
-			rz_ssi_stop(ssi, strm_capture);
+			if (rz_ssi_is_dma_enabled(ssi))
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
 		}
 
 		if (ssi->playback.substream && is_stopped) {
@@ -628,7 +611,8 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 			if (ssisr & SSISR_TOIRQ)
 				strm_playback->oerr_num++;
 
-			rz_ssi_stop(ssi, strm_playback);
+			if (rz_ssi_is_dma_enabled(ssi))
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
 		}
 
 		/* Clear all flags */
@@ -637,12 +621,16 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 
 		/* Add/remove more data */
 		if (ssi->capture.substream && is_stopped) {
-			for (i = 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi))
+				dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+			else
 				strm_capture->transfer(ssi, strm_capture);
 		}
 
 		if (ssi->playback.substream && is_stopped) {
-			for (i = 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi))
+				dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			else
 				strm_playback->transfer(ssi, strm_playback);
 		}
 
@@ -679,153 +667,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
-				   struct dma_chan *dma_ch, bool is_play)
-{
-	struct dma_slave_config cfg;
-
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.direction = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.dst_addr = ssi->phys + SSIFTDR;
-	cfg.src_addr = ssi->phys + SSIFRDR;
-	if (ssi->hw_params_cache.sample_width == 16) {
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-	} else {
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	}
-
-	return dmaengine_slave_config(dma_ch, &cfg);
-}
-
-static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
-			       struct rz_ssi_stream *strm)
-{
-	struct snd_pcm_substream *substream = strm->substream;
-	struct dma_async_tx_descriptor *desc;
-	struct snd_pcm_runtime *runtime;
-	enum dma_transfer_direction dir;
-	u32 dma_paddr, dma_size;
-	int amount;
-
-	if (!rz_ssi_stream_is_valid(ssi, strm))
-		return -EINVAL;
-
-	runtime = substream->runtime;
-	if (runtime->state == SNDRV_PCM_STATE_DRAINING)
-		/*
-		 * Stream is ending, so do not queue up any more DMA
-		 * transfers otherwise we play partial sound clips
-		 * because we can't shut off the DMA quick enough.
-		 */
-		return 0;
-
-	dir = rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-
-	/* Always transfer 1 period */
-	amount = runtime->period_size;
-
-	/* DMA physical address and size */
-	dma_paddr = runtime->dma_addr + frames_to_bytes(runtime,
-							strm->dma_buffer_pos);
-	dma_size = frames_to_bytes(runtime, amount);
-	desc = dmaengine_prep_slave_single(strm->dma_ch, dma_paddr, dma_size,
-					   dir,
-					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc) {
-		dev_err(ssi->dev, "dmaengine_prep_slave_single() fail\n");
-		return -ENOMEM;
-	}
-
-	desc->callback = rz_ssi_dma_complete;
-	desc->callback_param = strm;
-
-	if (dmaengine_submit(desc) < 0) {
-		dev_err(ssi->dev, "dmaengine_submit() fail\n");
-		return -EIO;
-	}
-
-	/* Update DMA pointer */
-	strm->dma_buffer_pos += amount;
-	if (strm->dma_buffer_pos >= runtime->buffer_size)
-		strm->dma_buffer_pos = 0;
-
-	/* Start DMA */
-	dma_async_issue_pending(strm->dma_ch);
-
-	return 0;
-}
-
-static void rz_ssi_dma_complete(void *data)
-{
-	struct rz_ssi_stream *strm = (struct rz_ssi_stream *)data;
-
-	if (!strm->running || !strm->substream || !strm->substream->runtime)
-		return;
-
-	/* Note that next DMA transaction has probably already started */
-	rz_ssi_pointer_update(strm, strm->substream->runtime->period_size);
-
-	/* Queue up another DMA transaction */
-	rz_ssi_dma_transfer(strm->priv, strm);
-}
-
-static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
-{
-	if (ssi->playback.dma_ch) {
-		dma_release_channel(ssi->playback.dma_ch);
-		ssi->playback.dma_ch = NULL;
-		if (ssi->dma_rt)
-			ssi->dma_rt = false;
-	}
-
-	if (ssi->capture.dma_ch) {
-		dma_release_channel(ssi->capture.dma_ch);
-		ssi->capture.dma_ch = NULL;
-	}
-}
-
-static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
-{
-	ssi->playback.dma_ch = dma_request_chan(dev, "tx");
-	if (IS_ERR(ssi->playback.dma_ch))
-		ssi->playback.dma_ch = NULL;
-
-	ssi->capture.dma_ch = dma_request_chan(dev, "rx");
-	if (IS_ERR(ssi->capture.dma_ch))
-		ssi->capture.dma_ch = NULL;
-
-	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
-		ssi->playback.dma_ch = dma_request_chan(dev, "rt");
-		if (IS_ERR(ssi->playback.dma_ch)) {
-			ssi->playback.dma_ch = NULL;
-			goto no_dma;
-		}
-
-		ssi->dma_rt = true;
-	}
-
-	if (!rz_ssi_is_dma_enabled(ssi))
-		goto no_dma;
-
-	return 0;
-
-no_dma:
-	rz_ssi_release_dma_channels(ssi);
-
-	return -ENODEV;
-}
-
 static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	struct snd_pcm_substream *substream = strm->substream;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
-	strm->dma_buffer_pos = strm->completed_dma_buf_pos + runtime->period_size;
-
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture))
 		return 0;
@@ -834,7 +680,7 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *
 	if (ret)
 		return ret;
 
-	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+	return rz_ssi_clk_setup(ssi, substream, ssi->hw_params_cache.rate,
 				ssi->hw_params_cache.channels);
 }
 
@@ -843,7 +689,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
-	int ret = 0, i, num_transfer = 1;
+	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -857,28 +703,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (cmd == SNDRV_PCM_TRIGGER_START)
 			rz_ssi_stream_init(strm, substream);
 
-		if (rz_ssi_is_dma_enabled(ssi)) {
-			bool is_playback = rz_ssi_stream_is_play(substream);
-
-			if (ssi->dma_rt)
-				ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
-							      is_playback);
-			else
-				ret = rz_ssi_dma_slave_config(ssi, strm->dma_ch,
-							      is_playback);
-
-			/* Fallback to pio */
-			if (ret < 0) {
-				ssi->playback.transfer = rz_ssi_pio_send;
-				ssi->capture.transfer = rz_ssi_pio_recv;
-				rz_ssi_release_dma_channels(ssi);
-			} else {
-				/* For DMA, queue up multiple DMA descriptors */
-				num_transfer = 4;
-			}
-		}
-
-		for (i = 0; i < num_transfer; i++) {
+		if (!rz_ssi_is_dma_enabled(ssi)) {
 			ret = strm->transfer(ssi, strm);
 			if (ret)
 				return ret;
@@ -1024,6 +849,9 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Save the DMA channels for recovery. */
+	ssi->dmas[substream->stream] = snd_dmaengine_pcm_get_chan(substream);
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
 		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
@@ -1039,10 +867,21 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	return rz_ssi_clk_setup(ssi, rate, channels);
+	return rz_ssi_clk_setup(ssi, substream, rate, channels);
+}
+
+static int rz_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK],
+				  &ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE]);
+
+	return 0;
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.probe		= rz_ssi_dai_probe,
 	.startup	= rz_ssi_startup,
 	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
@@ -1054,7 +893,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
 				  SNDRV_PCM_INFO_MMAP_VALID	|
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME		|
+				  SNDRV_PCM_INFO_PAUSE,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -1074,26 +914,6 @@ static int rz_ssi_pcm_open(struct snd_soc_component *component,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 }
 
-static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
-					    struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
-	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
-
-	return strm->buffer_pos;
-}
-
-static int rz_ssi_pcm_new(struct snd_soc_component *component,
-			  struct snd_soc_pcm_runtime *rtd)
-{
-	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-				       rtd->card->snd_card->dev,
-				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
-	return 0;
-}
-
 static struct snd_soc_dai_driver rz_ssi_soc_dai[] = {
 	{
 		.name			= "rz-ssi-dai",
@@ -1116,15 +936,19 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] = {
 static const struct snd_soc_component_driver rz_ssi_soc_component = {
 	.name			= "rz-ssi",
 	.open			= rz_ssi_pcm_open,
-	.pointer		= rz_ssi_pcm_pointer,
-	.pcm_construct		= rz_ssi_pcm_new,
 	.legacy_dai_naming	= 1,
 };
 
+static struct snd_dmaengine_pcm_config rz_ssi_dmaegine_pcm_conf = {
+	.prepare_slave_config	= snd_dmaengine_pcm_prepare_slave_config,
+};
+
 static int rz_ssi_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct rz_ssi_priv *ssi;
+	unsigned int flags = 0;
 	struct clk *audio_clk;
 	struct resource *res;
 	int ret;
@@ -1138,7 +962,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
 
-	ssi->phys = res->start;
 	ssi->clk = devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -1162,16 +985,21 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-	/* Detect DMA support */
-	ret = rz_ssi_dma_request(ssi, dev);
-	if (ret < 0) {
-		dev_warn(dev, "DMA not available, using PIO\n");
+	ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK].addr = (dma_addr_t)res->start + SSIFTDR;
+	ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE].addr =  (dma_addr_t)res->start + SSIFRDR;
+
+	if (of_property_match_string(np, "dma-names", "rt") == 0) {
+		flags = SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+		rz_ssi_dmaegine_pcm_conf.chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "rt";
+	}
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, &rz_ssi_dmaegine_pcm_conf, flags);
+	if (ret) {
+		dev_warn(dev, "DMA not available, using PIO!\n");
 		ssi->playback.transfer = rz_ssi_pio_send;
 		ssi->capture.transfer = rz_ssi_pio_recv;
 	} else {
-		dev_info(dev, "DMA enabled");
-		ssi->playback.transfer = rz_ssi_dma_transfer;
-		ssi->capture.transfer = rz_ssi_dma_transfer;
+		dev_info(dev, "DMA enabled\n");
 	}
 
 	ssi->playback.priv = ssi;
@@ -1182,17 +1010,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
-	if (ssi->irq_int < 0) {
-		ret = ssi->irq_int;
-		goto err_release_dma_chs;
-	}
+	if (ssi->irq_int < 0)
+		return ssi->irq_int;
 
 	ret = devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "irq request error (int_req)\n");
-		goto err_release_dma_chs;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
@@ -1233,43 +1057,19 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(ssi->rstc)) {
-		ret = PTR_ERR(ssi->rstc);
-		goto err_release_dma_chs;
-	}
+	if (IS_ERR(ssi->rstc))
+		return dev_err_probe(dev, PTR_ERR(ssi->rstc), "Failed to get reset\n");
 
 	/* Default 0 for power saving. Can be overridden via sysfs. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable runtime PM!\n");
-		goto err_release_dma_chs;
-	}
-
-	ret = devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
-					      rz_ssi_soc_dai,
-					      ARRAY_SIZE(rz_ssi_soc_dai));
-	if (ret < 0) {
-		dev_err(dev, "failed to register snd component\n");
-		goto err_release_dma_chs;
-	}
-
-	return 0;
-
-err_release_dma_chs:
-	rz_ssi_release_dma_channels(ssi);
-
-	return ret;
-}
-
-static void rz_ssi_remove(struct platform_device *pdev)
-{
-	struct rz_ssi_priv *ssi = dev_get_drvdata(&pdev->dev);
-
-	rz_ssi_release_dma_channels(ssi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
 
-	reset_control_assert(ssi->rstc);
+	return devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
+					       rz_ssi_soc_dai,
+					       ARRAY_SIZE(rz_ssi_soc_dai));
 }
 
 static const struct of_device_id rz_ssi_of_match[] = {
@@ -1304,7 +1104,6 @@ static struct platform_driver rz_ssi_driver = {
 		.pm = pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		= rz_ssi_probe,
-	.remove		= rz_ssi_remove,
 };
 
 module_platform_driver(rz_ssi_driver);
-- 
2.43.0


