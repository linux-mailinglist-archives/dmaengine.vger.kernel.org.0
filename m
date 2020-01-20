Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59458142AEF
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 13:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgATMd6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 07:33:58 -0500
Received: from olimex.com ([184.105.72.32]:40001 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMd6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jan 2020 07:33:58 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <dmaengine@vger.kernel.org>; Mon, 20 Jan 2020 04:33:48 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 2/2] drm: sun4i: hdmi: Add support for sun4i HDMI encoder audio
Date:   Mon, 20 Jan 2020 14:33:26 +0200
Message-Id: <20200120123326.30743-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120123326.30743-1-stefan@olimex.com>
References: <20200120123326.30743-1-stefan@olimex.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add HDMI audio support for the sun4i-hdmi encoder, used on
the older Allwinner chips - A10, A20, A31.

Most of the code is based on the BSP implementation. In it
dditional formats are supported (S20_3LE and S24_LE), however
there where some problems with them and only S16_LE is left.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
Changes for v2:
 - Create a new platform driver instead of using the HDMI encoder
 - Expose a new kcontrol to the userspace holding the ELD data
 - Wrap all macro arguments in parentheses

 drivers/gpu/drm/sun4i/Kconfig            |   1 +
 drivers/gpu/drm/sun4i/Makefile           |   1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi.h       |  28 ++
 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c | 452 +++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c   |  20 +
 5 files changed, 502 insertions(+)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 37e90e42943f..192b732b10cd 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -19,6 +19,7 @@ if DRM_SUN4I
 config DRM_SUN4I_HDMI
        tristate "Allwinner A10 HDMI Controller Support"
        default DRM_SUN4I
+       select SND_PCM_ELD
        help
 	  Choose this option if you have an Allwinner SoC with an HDMI
 	  controller.
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 0d04f2447b01..e2d82b451c36 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -5,6 +5,7 @@ sun4i-frontend-y		+= sun4i_frontend.o
 sun4i-drm-y			+= sun4i_drv.o
 sun4i-drm-y			+= sun4i_framebuffer.o
 
+sun4i-drm-hdmi-y		+= sun4i_hdmi_audio.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_ddc_clk.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_i2c.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index 7ad3f06c127e..a965a97b4814 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -42,7 +42,32 @@
 #define SUN4I_HDMI_VID_TIMING_POL_VSYNC		BIT(1)
 #define SUN4I_HDMI_VID_TIMING_POL_HSYNC		BIT(0)
 
+#define SUN4I_HDMI_AUDIO_CTRL_REG	0x040
+#define SUN4I_HDMI_AUDIO_CTRL_ENABLE		BIT(31)
+#define SUN4I_HDMI_AUDIO_CTRL_RESET		BIT(30)
+
+#define SUN4I_HDMI_AUDIO_FMT_REG	0x048
+#define SUN4I_HDMI_AUDIO_FMT_SRC		BIT(31)
+#define SUN4I_HDMI_AUDIO_FMT_LAYOUT		BIT(3)
+#define SUN4I_HDMI_AUDIO_FMT_CH_CFG(n)		((n) - 1)
+#define SUN4I_HDMI_AUDIO_FMT_CH_CFG_MASK	GENMASK(2, 0)
+
+#define SUN4I_HDMI_AUDIO_PCM_REG	0x4c
+#define SUN4I_HDMI_AUDIO_PCM_CH_MAP(n, m)	(((m) - 1) << ((n) * 4))
+#define SUN4I_HDMI_AUDIO_PCM_CH_MAP_MASK(n)	(GENMASK(2, 0) << ((n) * 4))
+
+#define SUN4I_HDMI_AUDIO_CTS_REG	0x050
+#define SUN4I_HDMI_AUDIO_CTS(n)			((n) & GENMASK(19, 0))
+
+#define SUN4I_HDMI_AUDIO_N_REG		0x054
+#define SUN4I_HDMI_AUDIO_N(n)			((n) & GENMASK(19, 0))
+
+#define SUN4I_HDMI_AUDIO_STAT0_REG	0x58
+#define SUN4I_HDMI_AUDIO_STAT0_FREQ(n)		((n) << 24)
+#define SUN4I_HDMI_AUDIO_STAT0_FREQ_MASK	GENMASK(27, 24)
+
 #define SUN4I_HDMI_AVI_INFOFRAME_REG(n)	(0x080 + (n))
+#define SUN4I_HDMI_AUDIO_INFOFRAME_REG(n)	(0x0a0 + (n))
 
 #define SUN4I_HDMI_PAD_CTRL0_REG	0x200
 #define SUN4I_HDMI_PAD_CTRL0_BIASEN		BIT(31)
@@ -286,9 +311,12 @@ struct sun4i_hdmi {
 	struct sun4i_drv	*drv;
 
 	bool			hdmi_monitor;
+	bool			hdmi_audio;
+
 	struct cec_adapter	*cec_adap;
 
 	const struct sun4i_hdmi_variant	*variant;
+	struct platform_device *audio;
 };
 
 int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c
new file mode 100644
index 000000000000..fbfe59459633
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_audio.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Olimex Ltd.
+ *   Author: Stefan Mavrodiev <stefan@olimex.com>
+ */
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_print.h>
+
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm_drm_eld.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "sun4i_hdmi.h"
+
+#define DRIVER_NAME "sun4i-hdmi-audio"
+
+struct sun4i_hdmi_audio {
+	struct device		*hdmi;
+	u8			audio_channels;
+};
+
+static int sun4i_hdmi_audio_ctl_eld_info(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = MAX_ELD_BYTES;
+	return 0;
+}
+
+static int sun4i_hdmi_audio_ctl_eld_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_soc_component_get_drvdata(component);
+	struct sun4i_hdmi_audio *priv = snd_soc_card_get_drvdata(card);
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+
+	memcpy(ucontrol->value.bytes.data,
+	       hdmi->connector.eld,
+	       MAX_ELD_BYTES);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new sun4i_hdmi_audio_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "ELD",
+		.info = sun4i_hdmi_audio_ctl_eld_info,
+		.get = sun4i_hdmi_audio_ctl_eld_get,
+	},
+};
+
+static const struct snd_soc_dapm_widget sun4i_hdmi_audio_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TX"),
+};
+
+static const struct snd_soc_dapm_route sun4i_hdmi_audio_routes[] = {
+	{ "TX", NULL, "Playback" },
+};
+
+static const struct snd_soc_component_driver sun4i_hdmi_audio_component = {
+	.controls               = sun4i_hdmi_audio_controls,
+	.num_controls           = ARRAY_SIZE(sun4i_hdmi_audio_controls),
+	.dapm_widgets		= sun4i_hdmi_audio_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_hdmi_audio_widgets),
+	.dapm_routes		= sun4i_hdmi_audio_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_hdmi_audio_routes),
+};
+
+static int sun4i_hdmi_audio_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = snd_soc_dai_get_drvdata(dai);
+	struct sun4i_hdmi_audio *priv = snd_soc_card_get_drvdata(card);
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+	u32 reg;
+	int ret;
+
+	regmap_write(hdmi->regmap, SUN4I_HDMI_AUDIO_CTRL_REG, 0);
+	regmap_write(hdmi->regmap,
+		     SUN4I_HDMI_AUDIO_CTRL_REG,
+		     SUN4I_HDMI_AUDIO_CTRL_RESET);
+	ret = regmap_read_poll_timeout(hdmi->regmap,
+				       SUN4I_HDMI_AUDIO_CTRL_REG,
+				       reg, !reg, 100, 50000);
+	if (ret < 0) {
+		DRM_ERROR("Failed to reset HDMI Audio\n");
+		return ret;
+	}
+
+	regmap_write(hdmi->regmap,
+		     SUN4I_HDMI_AUDIO_CTRL_REG,
+		     SUN4I_HDMI_AUDIO_CTRL_ENABLE);
+
+	return snd_pcm_hw_constraint_eld(substream->runtime,
+					 hdmi->connector.eld);
+}
+
+static void sun4i_hdmi_audio_shutdown(struct snd_pcm_substream *substream,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = snd_soc_dai_get_drvdata(dai);
+	struct sun4i_hdmi_audio *priv = snd_soc_card_get_drvdata(card);
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+
+	regmap_write(hdmi->regmap, SUN4I_HDMI_AUDIO_CTRL_REG, 0);
+}
+
+static int sun4i_hdmi_setup_audio_infoframes(struct sun4i_hdmi_audio *priv)
+{
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+	union hdmi_infoframe frame;
+	u8 buffer[14];
+	int i, ret;
+
+	ret = hdmi_audio_infoframe_init(&frame.audio);
+	if (ret < 0) {
+		DRM_ERROR("Failed to init HDMI audio infoframe\n");
+		return ret;
+	}
+
+	frame.audio.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
+	frame.audio.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
+	frame.audio.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
+	frame.audio.channels = priv->audio_channels;
+
+	ret = hdmi_infoframe_pack(&frame, buffer, sizeof(buffer));
+	if (ret < 0) {
+		DRM_ERROR("Failed to pack HDMI audio infoframe\n");
+		return ret;
+	}
+
+	for (i = 0; i < sizeof(buffer); i++)
+		writeb(buffer[i],
+		       hdmi->base + SUN4I_HDMI_AUDIO_INFOFRAME_REG(i));
+
+	return 0;
+}
+
+static void sun4i_hdmi_audio_set_cts_n(struct sun4i_hdmi_audio *priv,
+				       struct snd_pcm_hw_params *params)
+{
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+	struct drm_encoder *encoder = &hdmi->encoder;
+	struct drm_crtc *crtc = encoder->crtc;
+	const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+	u32 rate = params_rate(params);
+	u32 n, cts;
+	u64 tmp;
+
+	/**
+	 * Calculate Cycle Time Stamp (CTS) and Numerator (N):
+	 *
+	 * N = 128 * Samplerate / 1000
+	 * CTS = (Ftdms * N) / (128 * Samplerate)
+	 */
+
+	n = 128 * rate / 1000;
+	tmp = (u64)(mode->clock * 1000) * n;
+	do_div(tmp, 128 * rate);
+	cts = tmp;
+
+	regmap_write(hdmi->regmap,
+		     SUN4I_HDMI_AUDIO_CTS_REG,
+		     SUN4I_HDMI_AUDIO_CTS(cts));
+
+	regmap_write(hdmi->regmap,
+		     SUN4I_HDMI_AUDIO_N_REG,
+		     SUN4I_HDMI_AUDIO_N(n));
+}
+
+static int sun4i_hdmi_audio_set_hw_rate(struct sun4i_hdmi_audio *priv,
+					struct snd_pcm_hw_params *params)
+{
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+	u32 rate = params_rate(params);
+	u32 val;
+
+	switch (rate) {
+	case 44100:
+		val = 0x0;
+		break;
+	case 48000:
+		val = 0x2;
+		break;
+	case 32000:
+		val = 0x3;
+		break;
+	case 88200:
+		val = 0x8;
+		break;
+	case 96000:
+		val = 0x9;
+		break;
+	case 176400:
+		val = 0xc;
+		break;
+	case 192000:
+		val = 0xe;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(hdmi->regmap,
+			   SUN4I_HDMI_AUDIO_STAT0_REG,
+			   SUN4I_HDMI_AUDIO_STAT0_FREQ_MASK,
+			   SUN4I_HDMI_AUDIO_STAT0_FREQ(val));
+
+	return 0;
+}
+
+static int sun4i_hdmi_audio_set_hw_channels(struct sun4i_hdmi_audio *priv,
+					    struct snd_pcm_hw_params *params)
+{
+	struct sun4i_hdmi *hdmi = dev_get_drvdata(priv->hdmi);
+	u32 channels = params_channels(params);
+
+	if (channels > 8)
+		return -EINVAL;
+
+	priv->audio_channels = channels;
+
+	regmap_update_bits(hdmi->regmap,
+			   SUN4I_HDMI_AUDIO_FMT_REG,
+			   SUN4I_HDMI_AUDIO_FMT_LAYOUT,
+			   (channels > 2) ? SUN4I_HDMI_AUDIO_FMT_LAYOUT : 0);
+
+	regmap_update_bits(hdmi->regmap,
+			   SUN4I_HDMI_AUDIO_FMT_REG,
+			   SUN4I_HDMI_AUDIO_FMT_CH_CFG_MASK,
+			   SUN4I_HDMI_AUDIO_FMT_CH_CFG(channels));
+
+	regmap_write(hdmi->regmap, SUN4I_HDMI_AUDIO_PCM_REG, 0x76543210);
+
+	/**
+	 * If only one channel is required, send the same sample
+	 * to the sink device as a left and right channel.
+	 */
+	if (channels == 1)
+		regmap_update_bits(hdmi->regmap,
+				   SUN4I_HDMI_AUDIO_PCM_REG,
+				   SUN4I_HDMI_AUDIO_PCM_CH_MAP_MASK(1),
+				   SUN4I_HDMI_AUDIO_PCM_CH_MAP(1, 1));
+
+	return 0;
+}
+
+static int sun4i_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = snd_soc_dai_get_drvdata(dai);
+	struct sun4i_hdmi_audio *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = sun4i_hdmi_audio_set_hw_rate(priv, params);
+	if (ret)
+		return ret;
+
+	ret = sun4i_hdmi_audio_set_hw_channels(priv, params);
+	if (ret)
+		return ret;
+
+	sun4i_hdmi_audio_set_cts_n(priv, params);
+
+	return 0;
+}
+
+static int sun4i_hdmi_audio_trigger(struct snd_pcm_substream *substream,
+				    int cmd,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = snd_soc_dai_get_drvdata(dai);
+	struct sun4i_hdmi_audio *priv = snd_soc_card_get_drvdata(card);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		ret = sun4i_hdmi_setup_audio_infoframes(priv);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops sun4i_hdmi_audio_dai_ops = {
+	.startup = sun4i_hdmi_audio_startup,
+	.shutdown = sun4i_hdmi_audio_shutdown,
+	.hw_params = sun4i_hdmi_audio_hw_params,
+	.trigger = sun4i_hdmi_audio_trigger,
+};
+
+static int sun4i_hdmi_audio_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	dma_data = devm_kzalloc(dai->dev, sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
+		return -ENOMEM;
+
+	dma_data->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma_data->maxburst = 8;
+
+	snd_soc_dai_init_dma_data(dai, dma_data, NULL);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver sun4i_hdmi_audio_dai = {
+	.name = "HDMI",
+	.ops = &sun4i_hdmi_audio_dai_ops,
+	.probe = sun4i_hdmi_audio_dai_probe,
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= 8,
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+		.rates		= SNDRV_PCM_RATE_8000_192000,
+	},
+};
+
+static const struct snd_pcm_hardware sun4i_hdmi_audio_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				  SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE |
+				  SNDRV_PCM_INFO_RESUME,
+	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
+	.rates                  = SNDRV_PCM_RATE_8000_192000,
+	.rate_min               = 8000,
+	.rate_max               = 192000,
+	.channels_min           = 1,
+	.channels_max           = 8,
+	.buffer_bytes_max	= 128 * 1024,
+	.period_bytes_min	= 4 * 1024,
+	.period_bytes_max	= 32 * 1024,
+	.periods_min		= 2,
+	.periods_max		= 8,
+	.fifo_size		= 128,
+};
+
+static const struct snd_dmaengine_pcm_config sun4i_hdmi_audio_pcm_config = {
+	.chan_names[SNDRV_PCM_STREAM_PLAYBACK] = "audio-tx",
+	.pcm_hardware = &sun4i_hdmi_audio_pcm_hardware,
+	.prealloc_buffer_size = 128 * 1024,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+};
+
+struct snd_soc_card sun4i_hdmi_audio_card = {
+	.name = "sun4i-hdmi",
+};
+
+static int sun4i_hdmi_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &sun4i_hdmi_audio_card;
+	struct snd_soc_dai_link_component *comp;
+	struct snd_soc_dai_link *link;
+	struct device *dev = &pdev->dev;
+	struct sun4i_hdmi_audio *priv;
+	int ret;
+
+	ret = devm_snd_dmaengine_pcm_register(dev,
+					      &sun4i_hdmi_audio_pcm_config, 0);
+	if (ret) {
+		dev_err(dev, "Failed registering PCM DMA component\n");
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(dev,
+					      &sun4i_hdmi_audio_component,
+					      &sun4i_hdmi_audio_dai, 1);
+	if (ret) {
+		dev_err(dev, "Failed registering DAI component\n");
+		return ret;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->hdmi = dev->parent;
+	dev->of_node = dev->parent->of_node;
+
+	link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	comp = devm_kzalloc(dev, sizeof(*comp) * 3, GFP_KERNEL);
+	if (!comp)
+		return -ENOMEM;
+
+	link->cpus = &comp[0];
+	link->codecs = &comp[1];
+	link->platforms = &comp[2];
+
+	link->num_cpus = 1;
+	link->num_codecs = 1;
+	link->num_platforms = 1;
+
+	link->playback_only = 1;
+
+	link->name = "SUN4I-HDMI";
+	link->stream_name = "SUN4I-HDMI PCM";
+
+	link->codecs->name = dev_name(dev);
+	link->codecs->dai_name	= sun4i_hdmi_audio_dai.name;
+
+	link->cpus->dai_name = dev_name(dev);
+
+	link->platforms->name = dev_name(dev);
+
+	link->dai_fmt = SND_SOC_DAIFMT_I2S;
+
+	card->dai_link = link;
+	card->num_links = 1;
+	card->dev = dev;
+
+	snd_soc_card_set_drvdata(card, priv);
+	return devm_snd_soc_register_card(dev, card);
+}
+
+static int sun4i_hdmi_audio_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver sun4i_hdmi_audio_driver = {
+	.probe	= sun4i_hdmi_audio_probe,
+	.remove	= sun4i_hdmi_audio_remove,
+	.driver	= {
+		.name = DRIVER_NAME,
+	},
+};
+module_platform_driver(sun4i_hdmi_audio_driver);
+
+MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com");
+MODULE_DESCRIPTION("Allwinner A10 HDMI Audio driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 68d4644ac2dc..ec598b5a1d3a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -92,6 +92,11 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 
 	clk_disable_unprepare(hdmi->tmds_clk);
+
+	if (hdmi->audio) {
+		platform_device_unregister(hdmi->audio);
+		hdmi->audio = NULL;
+	}
 }
 
 static void sun4i_hdmi_enable(struct drm_encoder *encoder)
@@ -114,6 +119,20 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
+
+	if (hdmi->hdmi_audio) {
+		struct platform_device_info pdevinfo;
+
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		pdevinfo.name = "sun4i-hdmi-audio";
+		pdevinfo.parent = hdmi->dev;
+		pdevinfo.id = PLATFORM_DEVID_AUTO;
+		hdmi->audio = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(hdmi->audio)) {
+			DRM_ERROR("Couldn't create the HDMI audio adapter\n");
+			hdmi->audio = NULL;
+		}
+	}
 }
 
 static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
@@ -218,6 +237,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	if (!edid)
 		return 0;
 
+	hdmi->hdmi_audio = drm_detect_monitor_audio(edid);
 	hdmi->hdmi_monitor = drm_detect_hdmi_monitor(edid);
 	DRM_DEBUG_DRIVER("Monitor is %s monitor\n",
 			 hdmi->hdmi_monitor ? "an HDMI" : "a DVI");
-- 
2.17.1
