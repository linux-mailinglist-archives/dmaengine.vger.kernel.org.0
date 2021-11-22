Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7A459796
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhKVW0w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 17:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235025AbhKVW0i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 17:26:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E0A061053;
        Mon, 22 Nov 2021 22:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637619811;
        bh=DMxz9rkJwWZ5AqTdDggA8BLDb3DTgP5Oz0VUo2zj6B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2LWKDbatUWolgPnSkaWF6uAmXJr7TRUsffIAYil8ieu9gP8qTxDGTlSSeFslk+FX
         lfasUT+qjAZz4FqvxeQbdvqY7gm+Szg9KN11yNlzJ9GOQaUe2v85AHYKYosrXAMyrE
         83Qo7Vahw/aCxC+KQwYxEhvp5nYKM2xiNPHzZz3mpotZj10zImrNUftev0qcZA03Zn
         NQLipAZpiDTgThm7UHwH21MkyStuMHBgZkt8Z6fmCqVtjxInuWYT3q2YF1Ajj0kiB1
         UMwMelZbEWO8BXX6fob9irbYUtNypouPZRN0P8c65LiXoihCRpce5QwQAS3j6Vkxsv
         uUuI47S8VCEng==
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
Subject: [PATCH v2 09/11] dmaengine: xilinx_dpdma: stop using slave_id field
Date:   Mon, 22 Nov 2021 23:22:01 +0100
Message-Id: <20211122222203.4103644-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122222203.4103644-1-arnd@kernel.org>
References: <20211122222203.4103644-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The display driver wants to pass a custom flag to the DMA engine driver,
which it started doing by using the slave_id field that was traditionally
used for a different purpose.

As there is no longer a correct use for the slave_id field, it should
really be removed, and the remaining users changed over to something
different.

The new mechanism for passing nonstandard settings is using the
.peripheral_config field, so use that to pass a newly defined structure
here, making it clear that this will not work in portable drivers.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/xilinx/xilinx_dpdma.c  | 17 +++++++++++------
 drivers/gpu/drm/xlnx/zynqmp_disp.c |  9 +++++++--
 include/linux/dma/xilinx_dpdma.h   | 11 +++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/dma/xilinx_dpdma.h

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index ce5c66e6897d..b0f4948b00a5 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dma/xilinx_dpdma.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/interrupt.h>
@@ -1273,6 +1274,7 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
 			       struct dma_slave_config *config)
 {
 	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_dpdma_peripheral_config *pconfig;
 	unsigned long flags;
 
 	/*
@@ -1282,15 +1284,18 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
 	 * fixed both on the DPDMA side and on the DP controller side.
 	 */
 
-	spin_lock_irqsave(&chan->lock, flags);
-
 	/*
-	 * Abuse the slave_id to indicate that the channel is part of a video
-	 * group.
+	 * Use the peripheral_config to indicate that the channel is part
+	 * of a video group. This requires matching use of the custom
+	 * structure in each driver.
 	 */
-	if (chan->id <= ZYNQMP_DPDMA_VIDEO2)
-		chan->video_group = config->slave_id != 0;
+	pconfig = config->peripheral_config;
+	if (WARN_ON(pconfig && config->peripheral_size != sizeof(*pconfig)))
+		return -EINVAL;
 
+	spin_lock_irqsave(&chan->lock, flags);
+	if (chan->id <= ZYNQMP_DPDMA_VIDEO2 && pconfig)
+		chan->video_group = pconfig->video_group;
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return 0;
diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index ff2b308d8651..11c409cbc88e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -24,6 +24,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma/xilinx_dpdma.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
@@ -1058,14 +1059,18 @@ static void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
 	zynqmp_disp_avbuf_set_format(layer->disp, layer, layer->disp_fmt);
 
 	/*
-	 * Set slave_id for each DMA channel to indicate they're part of a
+	 * Set pconfig for each DMA channel to indicate they're part of a
 	 * video group.
 	 */
 	for (i = 0; i < info->num_planes; i++) {
 		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
+		struct xilinx_dpdma_peripheral_config pconfig = {
+			.video_group = true,
+		};
 		struct dma_slave_config config = {
 			.direction = DMA_MEM_TO_DEV,
-			.slave_id = 1,
+			.peripheral_config = &pconfig,
+			.peripheral_size = sizeof(pconfig),
 		};
 
 		dmaengine_slave_config(dma->chan, &config);
diff --git a/include/linux/dma/xilinx_dpdma.h b/include/linux/dma/xilinx_dpdma.h
new file mode 100644
index 000000000000..83a1377f03f8
--- /dev/null
+++ b/include/linux/dma/xilinx_dpdma.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __LINUX_DMA_XILINX_DPDMA_H
+#define __LINUX_DMA_XILINX_DPDMA_H
+
+#include <linux/types.h>
+
+struct xilinx_dpdma_peripheral_config {
+	bool video_group;
+};
+
+#endif /* __LINUX_DMA_XILINX_DPDMA_H */
-- 
2.29.2

