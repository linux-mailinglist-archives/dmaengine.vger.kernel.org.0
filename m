Return-Path: <dmaengine+bounces-9920-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwwKrcK1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9920-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:46:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240A3AF6C1
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30473153438
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A803BFE2E;
	Tue,  7 Apr 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KF44m/fF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C643BE16A
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568959; cv=none; b=Weu5BdMBQ+EQpWMDvea2Q9u0GzHgi0QWCy839Ids3VYhSLSsraH8EfSj4CoKNRRTAkL2QtePKlNt1QfmUPnZigfD0YNtYczZPPiqBApoKJpKkH3JSikWi9WRy0uUlA5Eq+ZaWK7hyftaqK4+2bPDOGkBTlmlgqkP4l5cuPNPRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568959; c=relaxed/simple;
	bh=dEgda6prdyKNrEH9eXlVWw+bPbCo2eiAAIm+eNqZiKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddifAeS7MXeuA8FDHbtst5h/XY/xeyTLhd7MAqUqG5isCRTtuNk/IQIAJRVxU9XyjHc139b6lZEzP93alKSjrVpieeYQ26rkIC6cz9YKXL6hK4WpPIB2+QKp4Ra8YRsPkrtRbwiJlOk40ovqmwfy0TaQNuxSKVDJzs/r0jABoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KF44m/fF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so67622795e9.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568952; x=1776173752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Era3gLvW6UbQrK1SDomZfX1eYyDyN/liTVRV/BvCzPs=;
        b=KF44m/fFSn76SAHkC0TDMEtT3cDY42Irhb6y4Wrf9fznzkf9gzeckZjvNelfBCujNt
         k4U3zr8le06OecpYwdmXlWjcGMdqdjyvem1V1K/DNWRDKE1MSoN6DU4WUk8lylLoHJ5c
         iYA+Z4FTrU6gHJd8wq+vTuAtJV0bPFPX2QdE42DDa23M4W+Cq2UkycnkdoCRoYOIXaUT
         8X9CBvgWAkC6xk5gzEGc/7OLVzisWw61qWlO3Zv8XWABbKlCniRl3zk9cyqbfN3B2YLP
         /nNaY8d8vSXUIHi+2/a/1y1Lyn//HycKymO+e3UVz2AFeb/lbLW3vW2kqZQ4/QT801Lg
         iHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568952; x=1776173752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Era3gLvW6UbQrK1SDomZfX1eYyDyN/liTVRV/BvCzPs=;
        b=ra0Hm3cIPisn0K+cCJ4U9EmfaU6JL+TQMWssTq2rLlDbiZ0kckSpHKHOg85NPdkGkh
         ILrLqkRcOfWQN3Vcgr4ZRrzJvDpadME+PgA89TigmP/dCmibN5vJF+9bckmsr2Soeqqy
         3S2f8QNdCCkW/ovQEQlaIBZbXpFLe4xPvfVXnPk/Vwc9qVcyHWR3Id+Lq7fthfyiOy72
         Rd56LLjlbJ2O6ZZQk2GUNrfS4Bt2+l/EeJKLlZidyBPIyfnV1Fc019yGV3R6CA7G1hgP
         FehpeULcc/C6fYv0b/QYmZClZn1B4bfQBBArHViHmr3X2fZHISk7nLx/j+ATRE7qtt9f
         MM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmdSnu7x+6+JBBtxlbQSGCsl5wQmVISv8Q0VHVE6HuCTfLBcjVHshJFY3QS1onO0btR9cdntiRyPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgX4pyv2Lc9gRg0rHP1jOyUaSiNBUZjsyytgWqemEpS6pFuWib
	cePEte6rZ6mGHFIG9Ox57sHEInEC/8UD4NubqXwTpHUsirdDNG6H4SCECqapbQBnVQo=
X-Gm-Gg: AeBDiev8EFfz/DevCQ0LxZmxz8FLlv4HQKck/iWrNUc/FEFW7CeB4YeC7/X9A8q+0gs
	We8HOf4eYGSfYTHsC7T+DAZPVQVaQOQkdAPRpS2jy3ZyhWY4eOjQwQJU5QLY+j354AxVv80jOVz
	FEVm3S0M/gpU+xSBxKEuBDf/zZA2iwC/BOBD/kfEMJTi172PCoM8mspPucuG/0Bg1KK6QbKtgFd
	PbjKY4iKcoo9/5AMtNZ43eFDWDFjhb25jYwSi9eN8bFUoDXKtN+KptNYzCio6gAdhm29FOZYbux
	PCnj58g56/crGiVK47HF6a1enQ31ZeqzF2JM+P+J6j0nJJd0KgQdms0NdpGSqZPTgwy0RoOX1AF
	ly+BYoyx8ZnI1MXm4mGlVnz7fmb89d6JApafeOHPaby6wq4fbfhkqPyPPVM6z8R7/rMJ/Kd0VxU
	M+PqlRwImHH6p5cYae3pOCCs/pTIjFpYf5XB+3Y0RgsH6GjlGNdApW
X-Received: by 2002:a05:600c:4593:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-488997de1c6mr267025665e9.25.1775568951719;
        Tue, 07 Apr 2026 06:35:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 14/15] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
Date: Tue,  7 Apr 2026 16:35:06 +0300
Message-ID: <20260407133507.887404-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-9920-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,bp.renesas.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 0240A3AF6C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
files occasionally contained random spikes when viewed with a tool such
as Audacity. These spikes were also audible as popping noises.

Using cyclic DMA resolves this issue. The driver was reworked to use the
existing support provided by the generic PCM dmaengine APIs. In addition
to eliminating the random spikes, the following issues were addressed:
- blank periods at the beginning of recorded files, which occurred
  intermittently, are no longer present
- no overruns or underruns were observed when continuously recording
  short audio files (e.g. 5 seconds long) in a loop
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
(overruns and underruns reported by the hardware), the DMA channel
references are stored in rz_ssi_hw_params().

The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
driver no longer manages DMA transfers directly.

To avoid software reported underruns (e.g. when running aplay during
consecutive suspend/resume cycles, or when the CPU is nearly 100%
loaded), rz_ssi_pcm_hardware.buffer_bytes_max was increased to 192K.
At the same time, rz_ssi_pcm_hardware.period_bytes_max was set to 48K
to reduce interrupt overhead.

Finally, rz_ssi_stream_is_play() was removed, as it had only a single
remaining user after this rework, and its logic was inlined at the call
site.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- s/CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM/SND_SOC_GENERIC_DMAENGINE_PCM
  in Kconfig
- in rz_ssi_clk_setup(): drop the update of dma_dai->maxburst
- in rz_ssi_interrupt(): pause the DMA channels in case of HW over/underruns
- add different open APIs for rz_ssi_soc_component_pio and
  rz_ssi_soc_component_dma 
- set rz_ssi_pcm_hardware to rz_ssi_dmaengine_pcm_conf.pcm_hardware
  and updated the buffer_bytes_max to avoid underruns detected by
  applications just before suspending; along with it updated
  period_bytes_max for lower interrupt overhead; updated the patch
  description for this; with it updated the snd_pcm_set_managed_buffer_all()
  arguments to use the rz_ssi_pcm_hardware
- added back rz_ssi_soc_component_pio.pcm_new instantiation as the
  PIO mode was broken w/o it
- use specific rz_ssi_soc_component_dma.open implementation for DMA
- updated rz_ssi_dmaengine_pcm_conf.chan_names[].{tx, rx} either if
  there is about full or half duplex instantiation and move the flags
  variable local to the code block that uses it
- check devm_snd_dmaengine_pcm_register() for defer errors

Changes in v2:
- fixed typos in patch description
- select CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM for rz-ssi driver
- in rz_ssi_dai_hw_params() check if DMA is enabled before calling
  snd_dmaengine_pcm_get_chan() to avoid failures for PIO mode
- do not drop rz_ssi_pcm_pointer() and rz_ssi_pcm_new() as these
  are necessary for PIO mode
- added 2 struct snd_soc_component_driver, one for PIO mode, one for
  DMA and updated probe() to register the proper
  snd_soc_component_driver based on the working mode

 sound/soc/renesas/Kconfig  |   1 +
 sound/soc/renesas/rz-ssi.c | 370 +++++++++++--------------------------
 2 files changed, 112 insertions(+), 259 deletions(-)

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index 11c2027c88a7..6520217e7407 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -56,6 +56,7 @@ config SND_SOC_MSIOF
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  This option enables RZ/G2L SSIF-2 sound support.
 
diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index d4e1dded3a9c..400e79054ef3 100644
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
@@ -298,12 +292,15 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	switch (ssi->hw_params_cache.sample_width) {
 	case 16:
 		ssicr |= SSICR_DWL(1);
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 24:
 		ssicr |= SSICR_DWL(5) | SSICR_PDTA;
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case 32:
 		ssicr |= SSICR_DWL(6);
+		dma_dai->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
@@ -344,7 +341,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	bool is_play = rz_ssi_stream_is_play(strm->substream);
+	bool is_play = strm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
@@ -423,14 +420,6 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -458,10 +447,6 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter = current_period;
 	}
-
-	strm->completed_dma_buf_pos += runtime->period_size;
-	if (strm->completed_dma_buf_pos >= runtime->buffer_size)
-		strm->completed_dma_buf_pos = 0;
 }
 
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
@@ -606,12 +591,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
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
@@ -631,18 +610,29 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 			rz_ssi_stop(ssi, strm_playback);
 		}
 
+		if (!rz_ssi_is_stream_running(&ssi->playback) &&
+		    !rz_ssi_is_stream_running(&ssi->capture) &&
+		    rz_ssi_is_dma_enabled(ssi)) {
+			dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+		}
+
 		/* Clear all flags */
 		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ | SSISR_TUIRQ |
 				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
 
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
 
@@ -679,153 +669,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
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
@@ -834,7 +682,7 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *
 	if (ret)
 		return ret;
 
-	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+	return rz_ssi_clk_setup(ssi, substream, ssi->hw_params_cache.rate,
 				ssi->hw_params_cache.channels);
 }
 
@@ -843,7 +691,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
-	int ret = 0, i, num_transfer = 1;
+	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -858,28 +706,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -1026,6 +853,10 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Save the DMA channels for recovery. */
+	if (rz_ssi_is_dma_enabled(ssi))
+		ssi->dmas[substream->stream] = snd_dmaengine_pcm_get_chan(substream);
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
 		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
@@ -1041,10 +872,21 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
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
@@ -1058,9 +900,9 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 				  SNDRV_PCM_INFO_MMAP_VALID	|
 				  SNDRV_PCM_INFO_RESUME		|
 				  SNDRV_PCM_INFO_PAUSE,
-	.buffer_bytes_max	= PREALLOC_BUFFER,
+	.buffer_bytes_max	= 192 * 1024,
 	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192,
+	.period_bytes_max	= 48 * 1024,
 	.channels_min		= SSI_CHAN_MIN,
 	.channels_max		= SSI_CHAN_MAX,
 	.periods_min		= 1,
@@ -1068,8 +910,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.fifo_size		= 32 * 2,
 };
 
-static int rz_ssi_pcm_open(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
+static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
 {
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
 
@@ -1077,6 +919,13 @@ static int rz_ssi_pcm_open(struct snd_soc_component *component,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 }
 
+static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_integer(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_PERIODS);
+}
+
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
 					    struct snd_pcm_substream *substream)
 {
@@ -1093,7 +942,8 @@ static int rz_ssi_pcm_new(struct snd_soc_component *component,
 {
 	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
 				       rtd->card->snd_card->dev,
-				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+				       rz_ssi_pcm_hardware.buffer_bytes_max,
+				       rz_ssi_pcm_hardware.buffer_bytes_max);
 	return 0;
 }
 
@@ -1116,16 +966,29 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] = {
 	},
 };
 
-static const struct snd_soc_component_driver rz_ssi_soc_component = {
+static const struct snd_soc_component_driver rz_ssi_soc_component_pio = {
 	.name			= "rz-ssi",
-	.open			= rz_ssi_pcm_open,
+	.open			= rz_ssi_pcm_open_pio,
 	.pointer		= rz_ssi_pcm_pointer,
 	.pcm_new		= rz_ssi_pcm_new,
 	.legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver rz_ssi_soc_component_dma = {
+	.name			= "rz-ssi",
+	.open			= rz_ssi_pcm_open_dma,
+	.legacy_dai_naming	= 1,
+};
+
+static struct snd_dmaengine_pcm_config rz_ssi_dmaengine_pcm_conf = {
+	.pcm_hardware		= &rz_ssi_pcm_hardware,
+	.prepare_slave_config	= snd_dmaengine_pcm_prepare_slave_config,
+};
+
 static int rz_ssi_probe(struct platform_device *pdev)
 {
+	const struct snd_soc_component_driver *component_driver;
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct rz_ssi_priv *ssi;
 	struct clk *audio_clk;
@@ -1141,7 +1004,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
 
-	ssi->phys = res->start;
 	ssi->clk = devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -1165,16 +1027,35 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-	/* Detect DMA support */
-	ret = rz_ssi_dma_request(ssi, dev);
-	if (ret < 0) {
+	ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK].addr = (dma_addr_t)res->start + SSIFTDR;
+	ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE].addr =  (dma_addr_t)res->start + SSIFRDR;
+
+	if (of_property_present(np, "dma-names")) {
+		unsigned int flags = 0;
+
+		if (of_property_match_string(np, "dma-names", "rt") == 0) {
+			flags = SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+			rz_ssi_dmaengine_pcm_conf.chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "rt";
+		} else {
+			rz_ssi_dmaengine_pcm_conf.chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "tx";
+			rz_ssi_dmaengine_pcm_conf.chan_names[SNDRV_PCM_STREAM_CAPTURE] = "rx";
+		}
+		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, &rz_ssi_dmaengine_pcm_conf,
+						      flags);
+	} else {
+		ret = -ENODEV;
+	}
+
+	if (ret == -EPROBE_DEFER) {
+		return ret;
+	} else if (ret) {
 		dev_warn(dev, "DMA not available, using PIO\n");
 		ssi->playback.transfer = rz_ssi_pio_send;
 		ssi->capture.transfer = rz_ssi_pio_recv;
+		component_driver = &rz_ssi_soc_component_pio;
 	} else {
-		dev_info(dev, "DMA enabled");
-		ssi->playback.transfer = rz_ssi_dma_transfer;
-		ssi->capture.transfer = rz_ssi_dma_transfer;
+		dev_info(dev, "DMA enabled\n");
+		component_driver = &rz_ssi_soc_component_dma;
 	}
 
 	ssi->playback.priv = ssi;
@@ -1185,17 +1066,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
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
@@ -1236,43 +1113,19 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
+	return devm_snd_soc_register_component(dev, component_driver,
+					       rz_ssi_soc_dai,
+					       ARRAY_SIZE(rz_ssi_soc_dai));
 }
 
 static const struct of_device_id rz_ssi_of_match[] = {
@@ -1307,7 +1160,6 @@ static struct platform_driver rz_ssi_driver = {
 		.pm = pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		= rz_ssi_probe,
-	.remove		= rz_ssi_remove,
 };
 
 module_platform_driver(rz_ssi_driver);
-- 
2.43.0


