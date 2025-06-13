Return-Path: <dmaengine+bounces-5449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3EAD8FA9
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60ED01891AF3
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B401192580;
	Fri, 13 Jun 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOdUH7aO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFE19CD0B;
	Fri, 13 Jun 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825381; cv=none; b=EU4xwe170ZEnemj6ZtmKkLthqafKvCOdVq9TcezlpsXvcm3jyTpI/kFHawFNiystgUxvg46ohEjOwNhJ+3ksBHZRcZvv8ZX0Q+tL5wW+fZkAHDqN/XDqdj+hW2oGTd+iJ7TlkZKlTOO5il3MgBDFL5LA3Oqj7tO5KnY13J9sth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825381; c=relaxed/simple;
	bh=2TJJ/du2XC/Mawcn/HTFb36UPASZiH8gGwOeFOQzamE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW0usKg2csdaUusmIkNCJb5v3cewWqYvpR0t+9gzCsP/cTAcNucpj+8Jfx+SxF+sHaZ9T0qcwTYo4IsPF4iNF3Gr2fHRiNEQcg3bBbokGshIQiOdAa+Rw5qauN5wOOpJ9t1qfRdQDtN30RlKpPzaQCL3JzO4pJOda8uGj/9XFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOdUH7aO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b43cce9efso4686781fa.3;
        Fri, 13 Jun 2025 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749825376; x=1750430176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNGPl379/1esv8rh3VzdhP9Kgdfh1KjpfXteu9guTI0=;
        b=QOdUH7aOIY0/tQL+5us6Wli+sVA82pY/daGGss1KDJg5zlbwjlQ7Ogcu7GdpBHkIGH
         JJjmkJusoowOdR6AZpYPtbX8j2tCq9dAivRFIUVb+Ff2ZJuAx1sPJ9ISHay84SfePQXv
         sE/2dWSMnbNGO6zEvgtLhlCgcCG4CC0hPYoAi5Zqnf1SXr+oFS82h09ZqJ7t5k/HYQTl
         ybpBO9lr3JXnzpi/wM2Xn6E1zjko/wIgSzvQw47ECcFNW1Fz6mKfx/FTHb+VgdlXS2QJ
         45vbyv09tloEYNTyAPCZQpucm9yK4gXB/dVamjdahQ9HSlOUR57r9vmw53V4DimnQ+VV
         BhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749825376; x=1750430176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNGPl379/1esv8rh3VzdhP9Kgdfh1KjpfXteu9guTI0=;
        b=RT+hFZjS4te5rCoypqus4GF64CBxB/EPUlPIXdRcGwHVPU9IuZSGiXsS0ohUE+/fVT
         lL1WjKXuH+tqVUlnZ8zEc6CCJ8ENND4HTWVcAYK6Ns146f0/dQNMSpQwfdS8Hw8tL80q
         6AjunQpynn6gbA1YIFRRYt2BcsBba6BzhnGgF1MM2flU7ICzh6Qf3UcexPleePecu1lu
         0GNV3pzWK6BESiwPTNv9N67+DmmdMEoWw0y+JbT9GxUibpuMx7JLqc/Mg2japY00bwzq
         UXXHJ5/446EMQ6OS+1g6CW5Amv0G3FA8WLx8h5YmZnZeaDorezrWL1EsxYXwxenaKZfm
         8EnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNzgWqQFmLEwLz2YDdNbwrmednrXY8P+JbZ/vQV8oyaxVceClNZ5wBTlXRCgPuslsCBCifyEOpc84=@vger.kernel.org, AJvYcCWyWv5CbmexWierpbiRJ12k94UUPrqHoVzM3Rj/0apSO4cpd9ibguujVCU21JVtf93OmvnOoGXR9cpucMw7@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIXokIc/szWse97VTmRB92dZPBTxd8ZPtfPLNfYvNnPhG2lvK
	pORAoURLYfjHn8TuD2MPfPWgVclCFvzk0UmoJRK6UnVNJoJYQCg8z+Rw
X-Gm-Gg: ASbGncs5Xf4lqF+8MQRZfOKwhe4a38UqNUGYDpNjDWqmFbT2mSWU6Gte9GCs8ZMuim8
	zkT+k6CNRsItcxrzSNE7kbfcjYL6RKmAh0mIWFnXHGSyGmQhfbOTufF4FaUGKWxMB4OrUJKrigH
	fUztn2A/ykgeZ4ho0dy/0gSSidU9LBjh7YI5QWlSIWP8d6+YhLBL1MzRdKYevRiqdkDpivJsYBF
	K1J399PRdW66wy/YscQ4Me8U/1NwRgeXarU5Umz4spn6++JeZ1kHyL4AthuChovtZi78qqB/69H
	DvLX/X7XYisEhKZ0ECBwzUDmJk+jznjkUBjL3+UMIgG6m7fsqrFb3pbqCF4FhjZsnW+4YNqj
X-Google-Smtp-Source: AGHT+IGtLE5SA4qRwNYFleWiwm1NXBTc50JNTBYu2gkV1yx/pA7trs66a80187BMqBpammUW4MVTtw==
X-Received: by 2002:a05:651c:1543:b0:32a:61cd:81f6 with SMTP id 38308e7fff4ca-32b3ebb3820mr10730551fa.19.1749825375877;
        Fri, 13 Jun 2025 07:36:15 -0700 (PDT)
Received: from localhost.localdomain ([89.22.142.19])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b331c94ffsm5586411fa.94.2025.06.13.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:36:15 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Alexander Kochetkov <al.kochet@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Subject: [PATCH 1/1] dmaengine: virt-dma: convert tasklet to BH workqueue for callback invocation
Date: Fri, 13 Jun 2025 14:34:44 +0000
Message-ID: <20250613143605.5748-2-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613143605.5748-1-al.kochet@gmail.com>
References: <20250613143605.5748-1-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently DMA callbacks are called from tasklet. However the tasklet is
marked deprecated and must be replaced by BH workqueue. Tasklet callbacks
are executed either in the Soft IRQ context or from ksoftirqd thread. BH
workqueue work items are executed in the BH context. Changing tasklet to
BH workqueue improved DMA callback latencies.

The commit changes virt-dma driver and all of its users:
- tasklet is replaced to work_struct, tasklet callback updated accordingly
- kill_tasklet() is replaced to cancel_work_sync()
- added include of linux/interrupt.h where necessary

Tested on Pine64 (Allwinner A64 ARMv8) with sun6i-dma driver. All other
drivers are changed similarly and tested for compilation.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/dma/amd/qdma/qdma.c                    |  1 +
 drivers/dma/arm-dma350.c                       |  1 +
 drivers/dma/bcm2835-dma.c                      |  2 +-
 drivers/dma/dma-axi-dmac.c                     |  8 ++++----
 drivers/dma/dma-jz4780.c                       |  2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  2 +-
 drivers/dma/dw-edma/dw-edma-core.c             |  2 +-
 drivers/dma/fsl-edma-common.c                  |  2 +-
 drivers/dma/fsl-edma-common.h                  |  1 +
 drivers/dma/fsl-qdma.c                         |  3 ++-
 drivers/dma/hisi_dma.c                         |  2 +-
 drivers/dma/hsu/hsu.c                          |  2 +-
 drivers/dma/idma64.c                           |  3 ++-
 drivers/dma/img-mdc-dma.c                      |  2 +-
 drivers/dma/imx-sdma.c                         |  2 +-
 drivers/dma/k3dma.c                            |  2 +-
 drivers/dma/loongson1-apb-dma.c                |  2 +-
 drivers/dma/mediatek/mtk-cqdma.c               |  2 +-
 drivers/dma/mediatek/mtk-hsdma.c               |  3 ++-
 drivers/dma/mediatek/mtk-uart-apdma.c          |  4 ++--
 drivers/dma/owl-dma.c                          |  2 +-
 drivers/dma/pxa_dma.c                          |  2 +-
 drivers/dma/qcom/bam_dma.c                     |  4 ++--
 drivers/dma/qcom/gpi.c                         |  1 +
 drivers/dma/qcom/qcom_adm.c                    |  2 +-
 drivers/dma/sa11x0-dma.c                       |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c                  |  3 ++-
 drivers/dma/sprd-dma.c                         |  2 +-
 drivers/dma/st_fdma.c                          |  2 +-
 drivers/dma/stm32/stm32-dma.c                  |  1 +
 drivers/dma/stm32/stm32-dma3.c                 |  1 +
 drivers/dma/stm32/stm32-mdma.c                 |  1 +
 drivers/dma/sun6i-dma.c                        |  2 +-
 drivers/dma/tegra186-gpc-dma.c                 |  2 +-
 drivers/dma/tegra210-adma.c                    |  3 ++-
 drivers/dma/ti/edma.c                          |  2 +-
 drivers/dma/ti/k3-udma.c                       | 10 +++++-----
 drivers/dma/ti/omap-dma.c                      |  2 +-
 drivers/dma/uniphier-xdmac.c                   |  1 +
 drivers/dma/virt-dma.c                         |  6 +++---
 drivers/dma/virt-dma.h                         | 10 +++++-----
 41 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index 8fb2d5e1df20..b57f8ebf2446 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/amd_qdma.h>
 #include <linux/regmap.h>
+#include <linux/interrupt.h>
 
 #include "qdma.h"
 
diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 9efe2ca7d5ec..212c13b4cff8 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -6,6 +6,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 0117bb2e8591..24411d7ac895 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -846,7 +846,7 @@ static void bcm2835_dma_free(struct bcm2835_dmadev *od)
 	list_for_each_entry_safe(c, next, &od->ddev.channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 
 	dma_unmap_page_attrs(od->ddev.dev, od->zero_page, PAGE_SIZE,
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 36943b0c6d60..181ba12b3ad4 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1041,9 +1041,9 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 	return 0;
 }
 
-static void axi_dmac_tasklet_kill(void *task)
+static void axi_dmac_cancel_work_sync(void *work)
 {
-	tasklet_kill(task);
+	cancel_work_sync(work);
 }
 
 static void axi_dmac_free_dma_controller(void *of_node)
@@ -1146,8 +1146,8 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	 * Put the action in here so it get's done before unregistering the DMA
 	 * device.
 	 */
-	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
-				       &dmac->chan.vchan.task);
+	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_cancel_work_sync,
+				       &dmac->chan.vchan.work);
 	if (ret)
 		return ret;
 
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 100057603fd4..90edd8286730 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1019,7 +1019,7 @@ static void jz4780_dma_remove(struct platform_device *pdev)
 	free_irq(jzdma->irq, jzdma);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
-		tasklet_kill(&jzdma->chan[i].vchan.task);
+		cancel_work_sync(&jzdma->chan[i].vchan.work);
 }
 
 static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..3acf095c3994 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1649,7 +1649,7 @@ static void dw_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 			vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2b88cc99e5d..a613b2c64e8a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1005,7 +1005,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	dma_async_device_unregister(&dw->dma);
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 				 vc.chan.device_node) {
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 		list_del(&chan->vc.chan.device_node);
 	}
 
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde080..9a498c14471a 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -894,7 +894,7 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(chan, _chan,
 				&dmadev->channels, vchan.chan.device_node) {
 		list_del(&chan->vchan.chan.device_node);
-		tasklet_kill(&chan->vchan.task);
+		cancel_work_sync(&chan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..44617aa66f0c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include "virt-dma.h"
 
 #define EDMA_CR_EDBG		BIT(1)
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 823f5c6bc2e1..9d920ebd5ebb 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -17,6 +17,7 @@
 #include <linux/of_dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 
 #include "virt-dma.h"
 #include "fsldma.h"
@@ -1261,7 +1262,7 @@ static void fsl_qdma_cleanup_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(chan, _chan,
 				 &dmadev->channels, vchan.chan.device_node) {
 		list_del(&chan->vchan.chan.device_node);
-		tasklet_kill(&chan->vchan.task);
+		cancel_work_sync(&chan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 25a4134be36b..0cddb4949051 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -720,7 +720,7 @@ static void hisi_dma_disable_qps(struct hisi_dma_dev *hdma_dev)
 
 	for (i = 0; i < hdma_dev->chan_num; i++) {
 		hisi_dma_disable_qp(hdma_dev, i);
-		tasklet_kill(&hdma_dev->chan[i].vc.task);
+		cancel_work_sync(&hdma_dev->chan[i].vc.work);
 	}
 }
 
diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index af5a2e252c25..4ea3f18a20ac 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -500,7 +500,7 @@ int hsu_dma_remove(struct hsu_dma_chip *chip)
 	for (i = 0; i < hsu->nr_channels; i++) {
 		struct hsu_dma_chan *hsuc = &hsu->chan[i];
 
-		tasklet_kill(&hsuc->vchan.task);
+		cancel_work_sync(&hsuc->vchan.work);
 	}
 
 	return 0;
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index d147353d47ab..fed2198a7f5a 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include <linux/dma/idma64.h>
 
@@ -624,7 +625,7 @@ static void idma64_remove(struct idma64_chip *chip)
 	for (i = 0; i < idma64->dma.chancnt; i++) {
 		struct idma64_chan *idma64c = &idma64->chan[i];
 
-		tasklet_kill(&idma64c->vchan.task);
+		cancel_work_sync(&idma64c->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index fd55bcd060ab..4fea332497a8 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1031,7 +1031,7 @@ static void mdc_dma_remove(struct platform_device *pdev)
 
 		devm_free_irq(&pdev->dev, mchan->irq, mchan);
 
-		tasklet_kill(&mchan->vc.task);
+		cancel_work_sync(&mchan->vc.work);
 	}
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 02a85d6f1bea..37a3b60a7b3f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2427,7 +2427,7 @@ static void sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->vc.task);
+		cancel_work_sync(&sdmac->vc.work);
 		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index acc2983e28e0..6ff3dd252aa2 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -981,7 +981,7 @@ static void k3_dma_remove(struct platform_device *op)
 
 	list_for_each_entry_safe(c, cn, &d->slave.channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 	tasklet_kill(&d->task);
 	clk_disable_unprepare(d->clk);
diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
index 255fe7eca212..f5a1c3efad62 100644
--- a/drivers/dma/loongson1-apb-dma.c
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -552,7 +552,7 @@ static void ls1x_dma_chan_remove(struct ls1x_dma *dma)
 
 		if (chan->vc.chan.device == &dma->ddev) {
 			list_del(&chan->vc.chan.device_node);
-			tasklet_kill(&chan->vc.task);
+			cancel_work_sync(&chan->vc.work);
 		}
 	}
 }
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 47c8adfdc155..a659484a4ecc 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -895,7 +895,7 @@ static void mtk_cqdma_remove(struct platform_device *pdev)
 		vc = &cqdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		cancel_work_sync(&vc->vc.work);
 	}
 
 	/* disable interrupt */
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index fa77bb24a430..8acec2fe944a 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -22,6 +22,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "../virt-dma.h"
 
@@ -1020,7 +1021,7 @@ static void mtk_hsdma_remove(struct platform_device *pdev)
 		vc = &hsdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		cancel_work_sync(&vc->vc.work);
 	}
 
 	/* Disable DMA interrupt */
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 08e15177427b..2e8e8c698fe3 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -312,7 +312,7 @@ static void mtk_uart_apdma_free_chan_resources(struct dma_chan *chan)
 
 	free_irq(c->irq, chan);
 
-	tasklet_kill(&c->vc.task);
+	cancel_work_sync(&c->vc.work);
 
 	vchan_free_chan_resources(&c->vc);
 
@@ -463,7 +463,7 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
 			struct mtk_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 }
 
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 57cec757d8f5..36e5a7c1d993 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1055,7 +1055,7 @@ static inline void owl_dma_free(struct owl_dma *od)
 	list_for_each_entry_safe(vchan,
 				 next, &od->dma.channels, vc.chan.device_node) {
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		cancel_work_sync(&vchan->vc.work);
 	}
 }
 
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 249296389771..0db0ad5296e7 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1218,7 +1218,7 @@ static void pxad_free_channels(struct dma_device *dmadev)
 	list_for_each_entry_safe(c, cn, &dmadev->channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 }
 
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index bbc3276992bb..b45fa2e6910a 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1373,7 +1373,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&bdev->common);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
-		tasklet_kill(&bdev->channels[i].vc.task);
+		cancel_work_sync(&bdev->channels[i].vc.work);
 err_tasklet_kill:
 	tasklet_kill(&bdev->task);
 err_disable_clk:
@@ -1399,7 +1399,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-		tasklet_kill(&bdev->channels[i].vc.task);
+		cancel_work_sync(&bdev->channels[i].vc.work);
 
 		if (!bdev->channels[i].fifo_virt)
 			continue;
diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index b1f0001cc99c..91f922a26e57 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -14,6 +14,7 @@
 #include <linux/dma/qcom-gpi-dma.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 6be54fddcee1..c60a5bc17d99 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -919,7 +919,7 @@ static void adm_dma_remove(struct platform_device *pdev)
 		/* mask IRQs for this channel/EE pair */
 		writel(0, adev->regs + ADM_CH_RSLT_CONF(achan->id, adev->ee));
 
-		tasklet_kill(&adev->channels[i].vc.task);
+		cancel_work_sync(&adev->channels[i].vc.work);
 		adm_terminate_all(&adev->channels[i].vc.chan);
 	}
 
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index dc1a9a05252e..619430fcb2f4 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -893,7 +893,7 @@ static void sa11x0_dma_free_channels(struct dma_device *dmadev)
 
 	list_for_each_entry_safe(c, cn, &dmadev->channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 		kfree(c);
 	}
 }
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 7ad3c29be146..a44eb73313a6 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "sf-pdma.h"
 
@@ -603,7 +604,7 @@ static void sf_pdma_remove(struct platform_device *pdev)
 		devm_free_irq(&pdev->dev, ch->txirq, ch);
 		devm_free_irq(&pdev->dev, ch->errirq, ch);
 		list_del(&ch->vchan.chan.device_node);
-		tasklet_kill(&ch->vchan.task);
+		cancel_work_sync(&ch->vchan.work);
 		tasklet_kill(&ch->done_tasklet);
 		tasklet_kill(&ch->err_tasklet);
 	}
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 187a090463ce..ac8fd7dd63eb 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1253,7 +1253,7 @@ static void sprd_dma_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(c, cn, &sdev->dma_dev.channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index c65ee0c7bfbd..ccedcb744dc5 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -733,7 +733,7 @@ static void st_fdma_free(struct st_fdma_dev *fdev)
 	for (i = 0; i < fdev->nr_channels; i++) {
 		fchan = &fdev->chans[i];
 		list_del(&fchan->vchan.chan.device_node);
-		tasklet_kill(&fchan->vchan.task);
+		cancel_work_sync(&fchan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index 917f8e922373..68ea199839bf 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -27,6 +27,7 @@
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "../virt-dma.h"
 
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 0c6c4258b195..d91686bda867 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "../virt-dma.h"
 
diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index e6d525901de7..a13bfbab20f8 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -29,6 +29,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "../virt-dma.h"
 
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 2215ff877bf7..3f7cb334feb2 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1073,7 +1073,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		cancel_work_sync(&vchan->vc.work);
 	}
 }
 
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 4d6fe0efa76e..9b98966444fa 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1279,7 +1279,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	tegra_dma_terminate_all(dc);
 	synchronize_irq(tdc->irq);
 
-	tasklet_kill(&tdc->vc.task);
+	cancel_work_sync(&tdc->vc.work);
 	tdc->config_init = false;
 	tdc->slave_id = -1;
 	tdc->sid_dir = DMA_TRANS_NONE;
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index fad896ff29a2..71e0d6d86219 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "virt-dma.h"
 
@@ -793,7 +794,7 @@ static void tegra_adma_free_chan_resources(struct dma_chan *dc)
 
 	tegra_adma_terminate_all(dc);
 	vchan_free_chan_resources(&tdc->vc);
-	tasklet_kill(&tdc->vc.task);
+	cancel_work_sync(&tdc->vc.work);
 	free_irq(tdc->irq, tdc);
 	pm_runtime_put(tdc2dev(tdc));
 
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ed406f08c44..43b59af82753 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2560,7 +2560,7 @@ static void edma_cleanupp_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(echan, _echan,
 			&dmadev->channels, vchan.chan.device_node) {
 		list_del(&echan->vchan.chan.device_node);
-		tasklet_kill(&echan->vchan.task);
+		cancel_work_sync(&echan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f..d08766e08182 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4042,12 +4042,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 }
 
 /*
- * This tasklet handles the completion of a DMA descriptor by
+ * This workqueue handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void udma_vchan_complete(struct tasklet_struct *t)
+static void udma_vchan_complete(struct work_struct *w)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc = from_work(vc, w, work);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -4112,7 +4112,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	vchan_free_chan_resources(&uc->vc);
-	tasklet_kill(&uc->vc.task);
+	cancel_work_sync(&uc->vc.work);
 
 	bcdma_free_bchan_resources(uc);
 	udma_free_tx_resources(uc);
@@ -5628,7 +5628,7 @@ static int udma_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-		tasklet_setup(&uc->vc.task, udma_vchan_complete);
+		INIT_WORK(&uc->vc.work, udma_vchan_complete);
 		init_completion(&uc->teardown_completed);
 		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8c023c6e623a..ad80cd5e1820 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1521,7 +1521,7 @@ static void omap_dma_free(struct omap_dmadev *od)
 			struct omap_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 		kfree(c);
 	}
 }
diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index ceeb6171c9d1..2e5ab9077b42 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -13,6 +13,7 @@
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 7961172a780d..a4ef01a1e155 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -80,9 +80,9 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void vchan_complete(struct tasklet_struct *t)
+static void vchan_complete(struct work_struct *work)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc = from_work(vc, work, work);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_completed);
 	INIT_LIST_HEAD(&vc->desc_terminated);
 
-	tasklet_setup(&vc->task, vchan_complete);
+	INIT_WORK(&vc->work, vchan_complete);
 
 	vc->chan.device = dmadev;
 	list_add_tail(&vc->chan.device_node, &dmadev->channels);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b67..d44ca74d8b7f 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -8,7 +8,7 @@
 #define VIRT_DMA_H
 
 #include <linux/dmaengine.h>
-#include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "dmaengine.h"
 
@@ -21,7 +21,7 @@ struct virt_dma_desc {
 
 struct virt_dma_chan {
 	struct dma_chan	chan;
-	struct tasklet_struct task;
+	struct work_struct work;
 	void (*desc_free)(struct virt_dma_desc *);
 
 	spinlock_t lock;
@@ -106,7 +106,7 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 		 vd, cookie);
 	list_add_tail(&vd->node, &vc->desc_completed);
 
-	tasklet_schedule(&vc->task);
+	queue_work(system_bh_wq, &vc->work);
 }
 
 /**
@@ -137,7 +137,7 @@ static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
 	vc->cyclic = vd;
-	tasklet_schedule(&vc->task);
+	queue_work(system_bh_wq, &vc->work);
 }
 
 /**
@@ -223,7 +223,7 @@ static inline void vchan_synchronize(struct virt_dma_chan *vc)
 	LIST_HEAD(head);
 	unsigned long flags;
 
-	tasklet_kill(&vc->task);
+	cancel_work_sync(&vc->work);
 
 	spin_lock_irqsave(&vc->lock, flags);
 
-- 
2.43.0


