Return-Path: <dmaengine+bounces-10360-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIECG3kbA2pt0gEAu9opvQ
	(envelope-from <dmaengine+bounces-10360-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:22:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E09505200B1
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0F7F30D2965
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C74E3765;
	Tue, 12 May 2026 12:13:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1944E053;
	Tue, 12 May 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588022; cv=none; b=a8HUFtyoJ8am3In2gXmc7XPsAv8wuW+EMJd3th0F+H4W4Hbmq3DjgP+psRGF+qjm8tmFq8+DKd6/dx8MOLmpP3/vPIWYPo9qS36D472p6AWj1wO0GTNNtpwF/1XprPF4JTUucNQISrdEs3emSnE+jQWM3i4vGPPCXnNgLy9srg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588022; c=relaxed/simple;
	bh=e1AEbLalrnVih0/xHMEY1am+HimQCNOVLnpMxWNljjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBLY5SPCtDg5B1MeyUzizfqcVfZJ+x9GWXOUQp+PuATH5FFIUolj8LJ6QWBgGhKH05POVCtmwXUtgtXLSF2ywQWjK7JRVlKnGqkV7bP7uZxssGxEhmMvBS1OL1FjLyeiSM6Ow/ENfqTBhcdm7nIM0VPggzE7S7dcITZy2q+v/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B3CC2BCF5;
	Tue, 12 May 2026 12:13:37 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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
	fabrizio.castro.jz@renesas.com,
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 16/17] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
Date: Tue, 12 May 2026 15:12:17 +0300
Message-ID: <20260512121219.216159-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E09505200B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10360-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	NEURAL_SPAM(0.00)[0.581];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea.uj@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,rz_ssi_soc_component_dma.open:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Action: no action

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

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- in rz_ssi_interrupt(): check if playback and capture dmas are the same
  to avoid calling dmaengine_pause() twice, on the same DMA channel
- in rz_ssi_shutdown(): set ssi->dmas[i] = NULL
- still preserved the Mark's Ack

Changes in v4:
- collected tags
- in rz_ssi_interrupt() checked the dma channel is valid before
  calling dmaengine_pause(); at the same time initialized the
  rz_ssi->dmas[] with NULL in case the DMA is not available in
  rz_ssi_dai_hw_params()
- set rz_ssi_dmaengine_pcm_conf.prealloc_buffer_size
- dinamically allocate the object of type snd_dmaengine_pcm_config passed
  to devm_snd_dmaengine_pcm_register() to avoid issues when the driver
  is instantiated for more than one HW instance
- I considered keeping the ack was still OK; Mark, please let me know if
  you consider otherwise

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
 sound/soc/renesas/rz-ssi.c | 388 ++++++++++++-------------------------
 2 files changed, 130 insertions(+), 259 deletions(-)

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
index d4e1dded3a9c..5406f9a3547f 100644
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
@@ -631,18 +610,34 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 			rz_ssi_stop(ssi, strm_playback);
 		}
 
+		if (!rz_ssi_is_stream_running(&ssi->playback) &&
+		    !rz_ssi_is_stream_running(&ssi->capture) &&
+		    rz_ssi_is_dma_enabled(ssi)) {
+			if (ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			if (ssi->dmas[SNDRV_PCM_STREAM_CAPTURE] &&
+			    /* Avoid calling pause twice in case of half duplex. */
+			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK] !=
+			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
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
 
@@ -679,153 +674,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
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
@@ -834,7 +687,7 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *
 	if (ret)
 		return ret;
 
-	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+	return rz_ssi_clk_setup(ssi, substream, ssi->hw_params_cache.rate,
 				ssi->hw_params_cache.channels);
 }
 
@@ -843,7 +696,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
-	int ret = 0, i, num_transfer = 1;
+	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -858,28 +711,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -975,6 +807,8 @@ static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
 		ssi->dup.tx_active = false;
 	else
 		ssi->dup.rx_active = false;
+
+	ssi->dmas[substream->stream] = NULL;
 }
 
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
@@ -1026,6 +860,12 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Save the DMA channels for recovery. */
+	if (rz_ssi_is_dma_enabled(ssi))
+		ssi->dmas[substream->stream] = snd_dmaengine_pcm_get_chan(substream);
+	else
+		ssi->dmas[substream->stream] = NULL;
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
 		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
@@ -1041,10 +881,21 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
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
@@ -1058,9 +909,9 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
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
@@ -1068,8 +919,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.fifo_size		= 32 * 2,
 };
 
-static int rz_ssi_pcm_open(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
+static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
 {
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
 
@@ -1077,6 +928,13 @@ static int rz_ssi_pcm_open(struct snd_soc_component *component,
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
@@ -1093,7 +951,8 @@ static int rz_ssi_pcm_new(struct snd_soc_component *component,
 {
 	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
 				       rtd->card->snd_card->dev,
-				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+				       rz_ssi_pcm_hardware.buffer_bytes_max,
+				       rz_ssi_pcm_hardware.buffer_bytes_max);
 	return 0;
 }
 
@@ -1116,16 +975,30 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] = {
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
+static const struct snd_dmaengine_pcm_config rz_ssi_dmaengine_pcm_conf = {
+	.pcm_hardware		= &rz_ssi_pcm_hardware,
+	.prealloc_buffer_size	= 192 * 1024,
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
@@ -1141,7 +1014,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
 
-	ssi->phys = res->start;
 	ssi->clk = devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -1165,16 +1037,43 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-	/* Detect DMA support */
-	ret = rz_ssi_dma_request(ssi, dev);
-	if (ret < 0) {
+	ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK].addr = (dma_addr_t)res->start + SSIFTDR;
+	ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE].addr =  (dma_addr_t)res->start + SSIFRDR;
+
+	if (of_property_present(np, "dma-names")) {
+		struct snd_dmaengine_pcm_config *config;
+		unsigned int flags = 0;
+
+		config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+
+		config->pcm_hardware = rz_ssi_dmaengine_pcm_conf.pcm_hardware;
+		config->prealloc_buffer_size = rz_ssi_dmaengine_pcm_conf.prealloc_buffer_size;
+		config->prepare_slave_config = rz_ssi_dmaengine_pcm_conf.prepare_slave_config;
+
+		if (of_property_match_string(np, "dma-names", "rt") == 0) {
+			flags = SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "rt";
+		} else {
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "tx";
+			config->chan_names[SNDRV_PCM_STREAM_CAPTURE] = "rx";
+		}
+		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, config, flags);
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
@@ -1185,17 +1084,13 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
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
@@ -1236,43 +1131,19 @@ static int rz_ssi_probe(struct platform_device *pdev)
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
@@ -1307,7 +1178,6 @@ static struct platform_driver rz_ssi_driver = {
 		.pm = pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		= rz_ssi_probe,
-	.remove		= rz_ssi_remove,
 };
 
 module_platform_driver(rz_ssi_driver);
-- 
2.43.0


