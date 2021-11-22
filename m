Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F282E45975D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhKVWZ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 17:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236554AbhKVWZw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 17:25:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4ED860F51;
        Mon, 22 Nov 2021 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637619765;
        bh=DkH2C/0N1WYbkBTHTcXs+UoiXTHoHZhSHgkMmx0w2Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2Oxdt95V8shdcCR4rf8/SnteVMCqPXu7ONpufFbqQSZlnD5v72OrbusBId0aTBCO
         pP7ckP/ytX0pvpQkWJncqKZTFopWpfw907t6DuIdqszCUJmEH0P8XVWEEcD9/Gc22x
         BsbBGBjcTwnJPUC00tjAyAiRRBB7Q+yLxDG1vNK4N+lQXd5vI+hHx06boyzMJ/jE1f
         5y/7vYtfL+uUibDbJ2SibZOim3YzH9m1BDyOZhEEUVCJq5dBjszMoc2+aYldAVpLgw
         ihYtpESUekvfxtkIZRBiMxX1y99UhIOUT9S4tCllpAW1AaavTuWHc9Nz22S82Orn3v
         7aynnt3oUMzkw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 02/11] ASoC: dai_dma: remove slave_id field
Date:   Mon, 22 Nov 2021 23:21:54 +0100
Message-Id: <20211122222203.4103644-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122222203.4103644-1-arnd@kernel.org>
References: <20211122222203.4103644-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This field is no longer set from any driver now, so remove the
last references as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/dmaengine_pcm.h | 2 --
 sound/core/pcm_dmaengine.c    | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 9144bd547851..7403870c28bd 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -58,7 +58,6 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * @maxburst: Maximum number of words(note: words, as in units of the
  * src_addr_width member, not bytes) that can be send to or received from the
  * DAI in one burst.
- * @slave_id: Slave requester id for the DMA channel.
  * @filter_data: Custom DMA channel filter data, this will usually be used when
  * requesting the DMA channel.
  * @chan_name: Custom channel name to use when requesting DMA channel.
@@ -72,7 +71,6 @@ struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
 	enum dma_slave_buswidth addr_width;
 	u32 maxburst;
-	unsigned int slave_id;
 	void *filter_data;
 	const char *chan_name;
 	unsigned int fifo_size;
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index af08bb4bf578..6762fb2083e1 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -91,8 +91,8 @@ EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
  * @dma_data: DAI DMA data
  * @slave_config: DMA slave configuration
  *
- * Initializes the {dst,src}_addr, {dst,src}_maxburst, {dst,src}_addr_width and
- * slave_id fields of the DMA slave config from the same fields of the DAI DMA
+ * Initializes the {dst,src}_addr, {dst,src}_maxburst, {dst,src}_addr_width
+ * fields of the DMA slave config from the same fields of the DAI DMA
  * data struct. The src and dst fields will be initialized depending on the
  * direction of the substream. If the substream is a playback stream the dst
  * fields will be initialized, if it is a capture stream the src fields will be
@@ -124,7 +124,6 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 			slave_config->src_addr_width = dma_data->addr_width;
 	}
 
-	slave_config->slave_id = dma_data->slave_id;
 	slave_config->peripheral_config = dma_data->peripheral_config;
 	slave_config->peripheral_size = dma_data->peripheral_size;
 }
-- 
2.29.2

