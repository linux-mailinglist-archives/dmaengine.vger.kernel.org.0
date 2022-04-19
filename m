Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262E0507BD1
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 23:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357949AbiDSVTz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiDSVTx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 17:19:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6DEE3818A;
        Tue, 19 Apr 2022 14:17:07 -0700 (PDT)
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3B2F320E1A93;
        Tue, 19 Apr 2022 14:17:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B2F320E1A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650403027;
        bh=FPtq2gm2h0o5H0RLwRAuUqz6Viil0+iD6kWTF4N41rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jigpWX6WuWbe8WJWOLdWjeDzYiN3o25Jj1bRY1w/CVbO4UzC6kyQtGbrXkURkY8hu
         PIQhCWvL7lor4OKxIztlaqx8Guwifi6RHp1X4YnLxVPyfkoHJdmuRXiUTUA3bzLOML
         7G5PHp1xymqOyzfl1bMgQgABlHMj4vAbHNVFAoyY=
From:   Allen Pais <apais@linux.microsoft.com>
To:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Date:   Tue, 19 Apr 2022 21:16:58 +0000
Message-Id: <20220419211658.11403-2-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220419211658.11403-1-apais@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The tasklet is an old API which will be deprecated, workqueue API
cab be used instead of them.

This patch replaces the tasklet usage in drivers/dma/* with a
simple work.

Github: https://github.com/KSPP/linux/issues/94

Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/dma/altera-msgdma.c                   | 15 ++++----
 drivers/dma/at_hdmac.c                        | 16 ++++-----
 drivers/dma/at_hdmac_regs.h                   |  6 ++--
 drivers/dma/at_xdmac.c                        | 14 ++++----
 drivers/dma/bcm2835-dma.c                     |  2 +-
 drivers/dma/dma-axi-dmac.c                    |  2 +-
 drivers/dma/dma-jz4780.c                      |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  2 +-
 drivers/dma/dw-edma/dw-edma-core.c            |  4 +--
 drivers/dma/dw/core.c                         | 13 +++----
 drivers/dma/dw/regs.h                         |  2 +-
 drivers/dma/ep93xx_dma.c                      | 15 ++++----
 drivers/dma/fsl-edma-common.c                 |  2 +-
 drivers/dma/fsl-qdma.c                        |  2 +-
 drivers/dma/fsl_raid.c                        | 12 ++++---
 drivers/dma/fsl_raid.h                        |  2 +-
 drivers/dma/fsldma.c                          | 15 ++++----
 drivers/dma/fsldma.h                          |  2 +-
 drivers/dma/hisi_dma.c                        |  2 +-
 drivers/dma/hsu/hsu.c                         |  2 +-
 drivers/dma/idma64.c                          |  4 +--
 drivers/dma/img-mdc-dma.c                     |  2 +-
 drivers/dma/imx-dma.c                         | 27 +++++++-------
 drivers/dma/imx-sdma.c                        |  6 ++--
 drivers/dma/ioat/dma.c                        | 19 +++++-----
 drivers/dma/ioat/dma.h                        |  4 +--
 drivers/dma/ioat/init.c                       |  2 +-
 drivers/dma/iop-adma.c                        | 12 +++----
 drivers/dma/ipu/ipu_idmac.c                   | 22 ++++--------
 drivers/dma/ipu/ipu_intern.h                  |  2 +-
 drivers/dma/k3dma.c                           | 19 +++++-----
 drivers/dma/mediatek/mtk-cqdma.c              | 35 ++++++++++---------
 drivers/dma/mediatek/mtk-hsdma.c              |  4 +--
 drivers/dma/mediatek/mtk-uart-apdma.c         |  4 +--
 drivers/dma/mmp_pdma.c                        | 13 +++----
 drivers/dma/mmp_tdma.c                        | 11 +++---
 drivers/dma/mpc512x_dma.c                     | 17 ++++-----
 drivers/dma/mv_xor.c                          | 13 +++----
 drivers/dma/mv_xor.h                          |  4 +--
 drivers/dma/mv_xor_v2.c                       | 23 ++++++------
 drivers/dma/mxs-dma.c                         | 13 +++----
 drivers/dma/nbpfaxi.c                         | 15 ++++----
 drivers/dma/owl-dma.c                         |  2 +-
 drivers/dma/pch_dma.c                         | 17 ++++-----
 drivers/dma/pl330.c                           | 32 +++++++++--------
 drivers/dma/plx_dma.c                         | 13 +++----
 drivers/dma/ppc4xx/adma.c                     | 17 ++++-----
 drivers/dma/ppc4xx/adma.h                     |  4 +--
 drivers/dma/ptdma/ptdma-dev.c                 |  2 +-
 drivers/dma/ptdma/ptdma.h                     |  4 +--
 drivers/dma/pxa_dma.c                         |  2 +-
 drivers/dma/qcom/bam_dma.c                    | 35 ++++++++++---------
 drivers/dma/qcom/gpi.c                        | 18 +++++-----
 drivers/dma/qcom/hidma.c                      | 11 +++---
 drivers/dma/qcom/hidma.h                      |  6 ++--
 drivers/dma/qcom/hidma_ll.c                   | 11 +++---
 drivers/dma/qcom/qcom_adm.c                   |  2 +-
 drivers/dma/s3c24xx-dma.c                     |  2 +-
 drivers/dma/sa11x0-dma.c                      | 27 +++++++-------
 drivers/dma/sf-pdma/sf-pdma.c                 | 24 +++++++------
 drivers/dma/sf-pdma/sf-pdma.h                 |  4 +--
 drivers/dma/sprd-dma.c                        |  2 +-
 drivers/dma/st_fdma.c                         |  2 +-
 drivers/dma/ste_dma40.c                       | 17 ++++-----
 drivers/dma/sun6i-dma.c                       | 33 ++++++++---------
 drivers/dma/tegra20-apb-dma.c                 | 19 +++++-----
 drivers/dma/tegra210-adma.c                   |  2 +-
 drivers/dma/ti/edma.c                         |  2 +-
 drivers/dma/ti/k3-udma.c                      | 11 +++---
 drivers/dma/ti/omap-dma.c                     |  2 +-
 drivers/dma/timb_dma.c                        | 23 ++++++------
 drivers/dma/txx9dmac.c                        | 30 ++++++++--------
 drivers/dma/txx9dmac.h                        |  4 +--
 drivers/dma/virt-dma.c                        |  9 ++---
 drivers/dma/virt-dma.h                        |  8 ++---
 drivers/dma/xgene-dma.c                       | 21 +++++------
 drivers/dma/xilinx/xilinx_dma.c               | 23 ++++++------
 drivers/dma/xilinx/xilinx_dpdma.c             | 19 +++++-----
 drivers/dma/xilinx/zynqmp_dma.c               | 21 +++++------
 include/linux/platform_data/dma-iop32x.h      |  4 +--
 80 files changed, 459 insertions(+), 429 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..a3c73bcd6a1b 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -170,7 +170,7 @@ struct msgdma_sw_desc {
 struct msgdma_device {
 	spinlock_t lock;
 	struct device *dev;
-	struct tasklet_struct irq_tasklet;
+	struct work_struct irq_work;
 	struct list_head pending_list;
 	struct list_head free_list;
 	struct list_head active_list;
@@ -676,12 +676,13 @@ static int msgdma_alloc_chan_resources(struct dma_chan *dchan)
 }
 
 /**
- * msgdma_tasklet - Schedule completion tasklet
+ * msgdma_work - Schedule completion work_queue
  * @t: Pointer to the Altera sSGDMA channel structure
  */
-static void msgdma_tasklet(struct tasklet_struct *t)
+static void msgdma_work(struct work_struct *work)
 {
-	struct msgdma_device *mdev = from_tasklet(mdev, t, irq_tasklet);
+	struct msgdma_device *mdev =
+		container_of(work, struct msgdma_device, irq_work);
 	u32 count;
 	u32 __maybe_unused size;
 	u32 __maybe_unused status;
@@ -740,7 +741,7 @@ static irqreturn_t msgdma_irq_handler(int irq, void *data)
 		spin_unlock(&mdev->lock);
 	}
 
-	tasklet_schedule(&mdev->irq_tasklet);
+	schedule_work(&mdev->irq_work);
 
 	/* Clear interrupt in mSGDMA controller */
 	iowrite32(MSGDMA_CSR_STAT_IRQ, mdev->csr + MSGDMA_CSR_STATUS);
@@ -758,7 +759,7 @@ static void msgdma_dev_remove(struct msgdma_device *mdev)
 		return;
 
 	devm_free_irq(mdev->dev, mdev->irq, mdev);
-	tasklet_kill(&mdev->irq_tasklet);
+	cancel_work_sync(&mdev->irq_work);
 	list_del(&mdev->dmachan.device_node);
 }
 
@@ -844,7 +845,7 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
+	INIT_WORK(&mdev->irq_work, msgdma_work);
 
 	dma_cookie_init(&mdev->dmachan);
 
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1d..ad67021ed842 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -241,7 +241,6 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 			channel_readl(atchan, CTRLB),
 			channel_readl(atchan, DSCR));
 
-		/* The tasklet will hopefully advance the queue... */
 		return;
 	}
 
@@ -615,11 +614,12 @@ static void atc_handle_cyclic(struct at_dma_chan *atchan)
 	dmaengine_desc_get_callback_invoke(txd, NULL);
 }
 
-/*--  IRQ & Tasklet  ---------------------------------------------------*/
+/*--  IRQ & Work Queue  ---------------------------------------------------*/
 
-static void atc_tasklet(struct tasklet_struct *t)
+static void atc_work(struct work_struct *work)
 {
-	struct at_dma_chan *atchan = from_tasklet(atchan, t, tasklet);
+	struct at_dma_chan *atchan =
+		container_of(work, struct at_dma_chan, work);
 
 	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
 		return atc_handle_error(atchan);
@@ -657,10 +657,10 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 					/* Disable channel on AHB error */
 					dma_writel(atdma, CHDR,
 						AT_DMA_RES(i) | atchan->mask);
-					/* Give information to tasklet */
+					/* Give information to workqueue */
 					set_bit(ATC_IS_ERROR, &atchan->status);
 				}
-				tasklet_schedule(&atchan->tasklet);
+				schedule_work(&atchan->work);
 				ret = IRQ_HANDLED;
 			}
 		}
@@ -1911,7 +1911,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&atchan->queue);
 		INIT_LIST_HEAD(&atchan->free_list);
 
-		tasklet_setup(&atchan->tasklet, atc_tasklet);
+		INIT_WORK(&atchan->work, atc_work);
 		atc_enable_chan_irq(atdma, i);
 	}
 
@@ -2019,7 +2019,7 @@ static int at_dma_remove(struct platform_device *pdev)
 		/* Disable interrupts */
 		atc_disable_chan_irq(atdma, chan->chan_id);
 
-		tasklet_kill(&atchan->tasklet);
+		cancel_work_sync(&atchan->work);
 		list_del(&chan->device_node);
 	}
 
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 4d1ebc040031..3f637d396fff 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -254,8 +254,8 @@ enum atc_status {
  * @per_if: peripheral interface
  * @mem_if: memory interface
  * @status: transmit status information from irq/prep* functions
- *                to tasklet (use atomic operations)
- * @tasklet: bottom half to finish transaction work
+ *                to workqueue (use atomic operations)
+ * @work: bottom half to finish transaction work
  * @save_cfg: configuration register that is saved on suspend/resume cycle
  * @save_dscr: for cyclic operations, preserve next descriptor address in
  *             the cyclic list on suspend/resume cycle
@@ -274,7 +274,7 @@ struct at_dma_chan {
 	u8			per_if;
 	u8			mem_if;
 	unsigned long		status;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	u32			save_cfg;
 	u32			save_dscr;
 	struct dma_slave_config dma_sconfig;
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1476156af74b..43c74e5ab6ae 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -226,7 +226,7 @@ struct at_xdmac_chan {
 	u32				save_cndc;
 	u32				irq_status;
 	unsigned long			status;
-	struct tasklet_struct		tasklet;
+	struct work_struct		work;
 	struct dma_slave_config		sconfig;
 
 	spinlock_t			lock;
@@ -1662,9 +1662,10 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 	/* Then continue with usual descriptor management */
 }
 
-static void at_xdmac_tasklet(struct tasklet_struct *t)
+static void at_xdmac_work(struct work_struct *work)
 {
-	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
+	struct at_xdmac_chan	*atchan =
+		container_of(work, struct at_xdmac_work, work);
 	struct at_xdmac_desc	*desc;
 	struct dma_async_tx_descriptor *txd;
 	u32			error_mask;
@@ -1761,7 +1762,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
 				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 
-			tasklet_schedule(&atchan->tasklet);
+			schedule_work(&atchan->work);
 			ret = IRQ_HANDLED;
 		}
 
@@ -2071,7 +2072,6 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		return PTR_ERR(atxdmac->clk);
 	}
 
-	/* Do not use dev res to prevent races with tasklet */
 	ret = request_irq(atxdmac->irq, at_xdmac_interrupt, 0, "at_xdmac", atxdmac);
 	if (ret) {
 		dev_err(&pdev->dev, "can't request irq\n");
@@ -2142,7 +2142,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		spin_lock_init(&atchan->lock);
 		INIT_LIST_HEAD(&atchan->xfers_list);
 		INIT_LIST_HEAD(&atchan->free_descs_list);
-		tasklet_setup(&atchan->tasklet, at_xdmac_tasklet);
+		INIT_WORK(&atchan->work, at_xdmac_work);
 
 		/* Clear pending interrupts. */
 		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
@@ -2194,7 +2194,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
 	for (i = 0; i < atxdmac->dma.chancnt; i++) {
 		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
 
-		tasklet_kill(&atchan->tasklet);
+		cancel_work_sync(&atchan->work);
 		at_xdmac_free_chan_resources(&atchan->chan);
 	}
 
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb01a40..44bc71966896 100644
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
index 5161b73c30c4..2df9d11c071c 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1022,7 +1022,7 @@ static int axi_dmac_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 	free_irq(dmac->irq, dmac);
-	tasklet_kill(&dmac->chan.vchan.task);
+	cancel_work_sync(&dmac->chan.vchan.work);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
 
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index fc513eb2b289..99231791c4c1 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1011,7 +1011,7 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	free_irq(jzdma->irq, jzdma);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
-		tasklet_kill(&jzdma->chan[i].vchan.task);
+		cancel_work_sync(&jzdma->chan[i].vchan.work);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e9c9bcb1f5c2..2ee214604aba 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1528,7 +1528,7 @@ static int dw_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 			vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 	}
 
 	return 0;
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 468d1097a1ec..cdfdd6b087a5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -989,14 +989,14 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	dma_async_device_unregister(&dw->wr_edma);
 	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
 				 vc.chan.device_node) {
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 		list_del(&chan->vc.chan.device_node);
 	}
 
 	dma_async_device_unregister(&dw->rd_edma);
 	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
 				 vc.chan.device_node) {
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 		list_del(&chan->vc.chan.device_node);
 	}
 
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7ab83fe601ed..222b5d0ddc4d 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -184,7 +184,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 			__func__);
 		dwc_dump_chan_regs(dwc);
 
-		/* The tasklet will hopefully advance the queue... */
+		/* The workqueue will hopefully advance ... */
 		return;
 	}
 
@@ -463,9 +463,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_descriptor_complete(dwc, bad_desc, true);
 }
 
-static void dw_dma_tasklet(struct tasklet_struct *t)
+static void dw_dma_work(struct work_struct *work)
 {
-	struct dw_dma *dw = from_tasklet(dw, t, tasklet);
+	struct dw_dma *dw =
+		container_of(work, struct dw_dma, work);
 	struct dw_dma_chan *dwc;
 	u32 status_xfer;
 	u32 status_err;
@@ -529,7 +530,7 @@ static irqreturn_t dw_dma_interrupt(int irq, void *dev_id)
 		channel_clear_bit(dw, MASK.ERROR, (1 << 8) - 1);
 	}
 
-	tasklet_schedule(&dw->tasklet);
+	schedule_work(&dw->work);
 
 	return IRQ_HANDLED;
 }
@@ -1142,7 +1143,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 		goto err_pdata;
 	}
 
-	tasklet_setup(&dw->tasklet, dw_dma_tasklet);
+	INIT_WORK(&dw->work, dw_dma_work);
 
 	err = request_irq(chip->irq, dw_dma_interrupt, IRQF_SHARED,
 			  dw->name, dw);
@@ -1287,7 +1288,7 @@ int do_dma_remove(struct dw_dma_chip *chip)
 	dma_async_device_unregister(&dw->dma);
 
 	free_irq(chip->irq, dw);
-	tasklet_kill(&dw->tasklet);
+	cancel_work_sync(&dw->work);
 
 	list_for_each_entry_safe(dwc, _dwc, &dw->dma.channels,
 			chan.device_node) {
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 76654bd13c1a..b41296156fe0 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -315,7 +315,7 @@ struct dw_dma {
 	char			name[20];
 	void __iomem		*regs;
 	struct dma_pool		*desc_pool;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 
 	/* channels */
 	struct dw_dma_chan	*chan;
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 98f9ee70362e..1455fb612eea 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -136,7 +136,7 @@ struct ep93xx_dma_desc {
  * @regs: memory mapped registers
  * @irq: interrupt number of the channel
  * @clk: clock used by this channel
- * @tasklet: channel specific tasklet used for callbacks
+ * @work: channel specific workqueue used for callbacks
  * @lock: lock protecting the fields following
  * @flags: flags for the channel
  * @buffer: which buffer to use next (0/1)
@@ -167,7 +167,7 @@ struct ep93xx_dma_chan {
 	void __iomem			*regs;
 	int				irq;
 	struct clk			*clk;
-	struct tasklet_struct		tasklet;
+	struct work_struct		work;
 	/* protects the fields following */
 	spinlock_t			lock;
 	unsigned long			flags;
@@ -745,9 +745,10 @@ static void ep93xx_dma_advance_work(struct ep93xx_dma_chan *edmac)
 	spin_unlock_irqrestore(&edmac->lock, flags);
 }
 
-static void ep93xx_dma_tasklet(struct tasklet_struct *t)
+static void ep93xx_dma_work(struct work_struct *work)
 {
-	struct ep93xx_dma_chan *edmac = from_tasklet(edmac, t, tasklet);
+	struct ep93xx_dma_chan *edmac =
+		container_of(work, struct ep93xx_dma_chan, work);
 	struct ep93xx_dma_desc *desc, *d;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(list);
@@ -802,12 +803,12 @@ static irqreturn_t ep93xx_dma_interrupt(int irq, void *dev_id)
 	switch (edmac->edma->hw_interrupt(edmac)) {
 	case INTERRUPT_DONE:
 		desc->complete = true;
-		tasklet_schedule(&edmac->tasklet);
+		schedule_work(&edmac->work);
 		break;
 
 	case INTERRUPT_NEXT_BUFFER:
 		if (test_bit(EP93XX_DMA_IS_CYCLIC, &edmac->flags))
-			tasklet_schedule(&edmac->tasklet);
+			schedule_work(&edmac->work);
 		break;
 
 	default:
@@ -1353,7 +1354,7 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&edmac->active);
 		INIT_LIST_HEAD(&edmac->queue);
 		INIT_LIST_HEAD(&edmac->free_list);
-		tasklet_setup(&edmac->tasklet, ep93xx_dma_tasklet);
+		INIT_WORK(&edmac->work, ep93xx_dma_work);
 
 		list_add_tail(&edmac->chan.device_node,
 			      &dma_dev->channels);
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 3ae05d1446a5..2027b4bc1c9d 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -695,7 +695,7 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(chan, _chan,
 				&dmadev->channels, vchan.chan.device_node) {
 		list_del(&chan->vchan.chan.device_node);
-		tasklet_kill(&chan->vchan.task);
+		cancel_work_sync(&chan->vchan.work);
 	}
 }
 EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 045ead46ec8f..f3fa6beedd84 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1266,7 +1266,7 @@ static void fsl_qdma_cleanup_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(chan, _chan,
 				 &dmadev->channels, vchan.chan.device_node) {
 		list_del(&chan->vchan.chan.device_node);
-		tasklet_kill(&chan->vchan.task);
+		cancel_work_sync(&chan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index fdf3500d96a9..b6039ab275ba 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -154,9 +154,11 @@ static void fsl_re_cleanup_descs(struct fsl_re_chan *re_chan)
 	fsl_re_issue_pending(&re_chan->chan);
 }
 
-static void fsl_re_dequeue(struct tasklet_struct *t)
+static void fsl_re_dequeue(struct work_struct *work)
 {
-	struct fsl_re_chan *re_chan = from_tasklet(re_chan, t, irqtask);
+	struct fsl_re_chan *re_chan =
+	       container_of(work, struct fsl_re_chan, irq_work);
+
 	struct fsl_re_desc *desc, *_desc;
 	struct fsl_re_hw_desc *hwdesc;
 	unsigned long flags;
@@ -223,7 +225,7 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
 	/* Clear interrupt */
 	out_be32(&re_chan->jrregs->jr_interrupt_status, FSL_RE_CLR_INTR);
 
-	tasklet_schedule(&re_chan->irqtask);
+	schedule_work(&re_chan->irq_work);
 
 	return IRQ_HANDLED;
 }
@@ -669,7 +671,7 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 	snprintf(chan->name, sizeof(chan->name), "re_jr%02d", q);
 
 	chandev = &chan_ofdev->dev;
-	tasklet_setup(&chan->irqtask, fsl_re_dequeue);
+	INIT_WORK(&chan->irq_work, fsl_re_dequeue);
 
 	ret = request_irq(chan->irq, fsl_re_isr, 0, chan->name, chandev);
 	if (ret) {
@@ -847,7 +849,7 @@ static int fsl_re_probe(struct platform_device *ofdev)
 
 static void fsl_re_remove_chan(struct fsl_re_chan *chan)
 {
-	tasklet_kill(&chan->irqtask);
+	cancel_work_sync(&chan->irq_work);
 
 	dma_pool_free(chan->re_dev->hw_desc_pool, chan->inb_ring_virt_addr,
 		      chan->inb_phys_addr);
diff --git a/drivers/dma/fsl_raid.h b/drivers/dma/fsl_raid.h
index 69d743c04973..9c5adb1b457e 100644
--- a/drivers/dma/fsl_raid.h
+++ b/drivers/dma/fsl_raid.h
@@ -275,7 +275,7 @@ struct fsl_re_chan {
 	struct dma_chan chan;
 	struct fsl_re_chan_cfg *jrregs;
 	int irq;
-	struct tasklet_struct irqtask;
+	struct work_struct irq_work;
 	u32 alloc_count;
 
 	/* hw descriptor ring for inbound queue*/
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index f8459cc5315d..58d1b28ae857 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -967,20 +967,21 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		chan_err(chan, "irq: unhandled sr 0x%08x\n", stat);
 
 	/*
-	 * Schedule the tasklet to handle all cleanup of the current
+	 * Schedule the work to handle all cleanup of the current
 	 * transaction. It will start a new transaction if there is
 	 * one pending.
 	 */
-	tasklet_schedule(&chan->tasklet);
+	schedule_work(&chan->work);
 	chan_dbg(chan, "irq: Exit\n");
 	return IRQ_HANDLED;
 }
 
-static void dma_do_tasklet(struct tasklet_struct *t)
+static void dma_do_work(struct work_struct *work)
 {
-	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct fsldma_chan *chan =
+		container_of(work, struct fsldma_chan, work);
 
-	chan_dbg(chan, "tasklet entry\n");
+	chan_dbg(chan, "workqueue entry\n");
 
 	spin_lock(&chan->desc_lock);
 
@@ -992,7 +993,7 @@ static void dma_do_tasklet(struct tasklet_struct *t)
 
 	spin_unlock(&chan->desc_lock);
 
-	chan_dbg(chan, "tasklet exit\n");
+	chan_dbg(chan, "workqueue exit\n");
 }
 
 static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
@@ -1151,7 +1152,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_setup(&chan->tasklet, dma_do_tasklet);
+	INIT_WORK(&chan->work, dma_do_work);
 	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
 
 	/* Initialize the channel */
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 308bed0a560a..de5b579a1925 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -172,7 +172,7 @@ struct fsldma_chan {
 	struct device *dev;		/* Channel device */
 	int irq;			/* Channel IRQ */
 	int id;				/* Raw id of this channel */
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	u32 feature;
 	bool idle;			/* DMA controller is idle */
 #ifdef CONFIG_PM
diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 43817ced3a3e..85716baad0c9 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -416,7 +416,7 @@ static void hisi_dma_disable_qps(struct hisi_dma_dev *hdma_dev)
 
 	for (i = 0; i < hdma_dev->chan_num; i++) {
 		hisi_dma_disable_qp(hdma_dev, i);
-		tasklet_kill(&hdma_dev->chan[i].vc.task);
+		cancel_work_sync(&hdma_dev->chan[i].vc.work);
 	}
 }
 
diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 92caae55aece..83b2f2dd67e9 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -492,7 +492,7 @@ int hsu_dma_remove(struct hsu_dma_chip *chip)
 	for (i = 0; i < hsu->nr_channels; i++) {
 		struct hsu_dma_chan *hsuc = &hsu->chan[i];
 
-		tasklet_kill(&hsuc->vchan.task);
+		cancel_work_sync(&hsuc->vchan.work);
 	}
 
 	return 0;
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f4c07ad3be15..a251bf038034 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -609,14 +609,14 @@ static int idma64_remove(struct idma64_chip *chip)
 
 	/*
 	 * Explicitly call devm_request_irq() to avoid the side effects with
-	 * the scheduled tasklets.
+	 * the scheduled workqueue.
 	 */
 	devm_free_irq(chip->dev, chip->irq, idma64);
 
 	for (i = 0; i < idma64->dma.chancnt; i++) {
 		struct idma64_chan *idma64c = &idma64->chan[i];
 
-		tasklet_kill(&idma64c->vchan.task);
+		cancel_work_sync(&idma64c->vchan.work);
 	}
 
 	return 0;
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index e4ea107ce78c..2b1d06c16c2b 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1034,7 +1034,7 @@ static int mdc_dma_remove(struct platform_device *pdev)
 
 		devm_free_irq(&pdev->dev, mchan->irq, mchan);
 
-		tasklet_kill(&mchan->vc.task);
+		cancel_work_sync(&mchan->vc.work);
 	}
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 2ddc31e64db0..13f1dd2bb43e 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -144,7 +144,7 @@ struct imxdma_channel {
 	struct imxdma_engine		*imxdma;
 	unsigned int			channel;
 
-	struct tasklet_struct		dma_tasklet;
+	struct work_struct		dma_work;
 	struct list_head		ld_free;
 	struct list_head		ld_queue;
 	struct list_head		ld_active;
@@ -345,8 +345,8 @@ static void imxdma_watchdog(struct timer_list *t)
 
 	imx_dmav1_writel(imxdma, 0, DMA_CCR(channel));
 
-	/* Tasklet watchdog error handler */
-	tasklet_schedule(&imxdmac->dma_tasklet);
+	/* Workqueue watchdog error handler */
+	schedule_work(&imxdmac->dma_work);
 	dev_dbg(imxdma->dev, "channel %d: watchdog timeout!\n",
 		imxdmac->channel);
 }
@@ -391,8 +391,8 @@ static irqreturn_t imxdma_err_handler(int irq, void *dev_id)
 			imx_dmav1_writel(imxdma, 1 << i, DMA_DBOSR);
 			errcode |= IMX_DMA_ERR_BUFFER;
 		}
-		/* Tasklet error handler */
-		tasklet_schedule(&imxdma->channel[i].dma_tasklet);
+		/* Workqueue error handler */
+		schedule_work(&imxdma->channel[i].dma_work);
 
 		dev_warn(imxdma->dev,
 			 "DMA timeout on channel %d -%s%s%s%s\n", i,
@@ -449,8 +449,8 @@ static void dma_irq_handle_channel(struct imxdma_channel *imxdmac)
 			imx_dmav1_writel(imxdma, tmp, DMA_CCR(chno));
 
 			if (imxdma_chan_is_doing_cyclic(imxdmac))
-				/* Tasklet progression */
-				tasklet_schedule(&imxdmac->dma_tasklet);
+				/* Workqueue progression */
+				schedule_work(&imxdmac->dma_work);
 
 			return;
 		}
@@ -463,8 +463,8 @@ static void dma_irq_handle_channel(struct imxdma_channel *imxdmac)
 
 out:
 	imx_dmav1_writel(imxdma, 0, DMA_CCR(chno));
-	/* Tasklet irq */
-	tasklet_schedule(&imxdmac->dma_tasklet);
+	/* Workqueue irq */
+	schedule_work(&imxdmac->dma_work);
 }
 
 static irqreturn_t dma_irq_handler(int irq, void *dev_id)
@@ -593,9 +593,10 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 	return 0;
 }
 
-static void imxdma_tasklet(struct tasklet_struct *t)
+static void imxdma_work(struct work_struct *work)
 {
-	struct imxdma_channel *imxdmac = from_tasklet(imxdmac, t, dma_tasklet);
+	struct imxdma_channel *imxdmac =
+	       container_of(work, struct imxdma_channel, dma_work);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
@@ -1146,7 +1147,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&imxdmac->ld_free);
 		INIT_LIST_HEAD(&imxdmac->ld_active);
 
-		tasklet_setup(&imxdmac->dma_tasklet, imxdma_tasklet);
+		INIT_WORK(&imxdmac->dma_work, imxdma_work);
 		imxdmac->chan.device = &imxdma->dma_device;
 		dma_cookie_init(&imxdmac->chan);
 		imxdmac->channel = i;
@@ -1215,7 +1216,7 @@ static void imxdma_free_irq(struct platform_device *pdev, struct imxdma_engine *
 		if (!is_imx1_dma(imxdma))
 			disable_irq(imxdmac->irq);
 
-		tasklet_kill(&imxdmac->dma_tasklet);
+		cancel_work_sync(&imxdmac->dma_work);
 	}
 }
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 70c0aa931ddf..3352da8124ed 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -854,7 +854,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		/*
 		 * The callback is called from the interrupt context in order
 		 * to reduce latency and to avoid the risk of altering the
-		 * SDMA transaction status by the time the client tasklet is
+		 * SDMA transaction status by the time the client workqueue is
 		 * executed.
 		 */
 		spin_unlock(&sdmac->vc.lock);
@@ -2252,11 +2252,11 @@ static int sdma_remove(struct platform_device *pdev)
 	kfree(sdma->script_addrs);
 	clk_unprepare(sdma->clk_ahb);
 	clk_unprepare(sdma->clk_ipg);
-	/* Kill the tasklet */
+	/* cancel the workqueue */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->vc.task);
+		cancel_work_sync(&sdmac->vc.work);
 		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 37ff4ec7db76..60d7d9698c08 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -110,7 +110,7 @@ irqreturn_t ioat_dma_do_interrupt(int irq, void *data)
 	for_each_set_bit(bit, &attnstatus, BITS_PER_LONG) {
 		ioat_chan = ioat_chan_by_index(instance, bit);
 		if (test_bit(IOAT_RUN, &ioat_chan->state))
-			tasklet_schedule(&ioat_chan->cleanup_task);
+			schedule_work(&ioat_chan->cleanup_work);
 	}
 
 	writeb(intrctrl, instance->reg_base + IOAT_INTRCTRL_OFFSET);
@@ -127,7 +127,7 @@ irqreturn_t ioat_dma_do_interrupt_msix(int irq, void *data)
 	struct ioatdma_chan *ioat_chan = data;
 
 	if (test_bit(IOAT_RUN, &ioat_chan->state))
-		tasklet_schedule(&ioat_chan->cleanup_task);
+		schedule_work(&ioat_chan->cleanup_work);
 
 	return IRQ_HANDLED;
 }
@@ -139,8 +139,8 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 	int chan_id = chan_num(ioat_chan);
 	struct msix_entry *msix;
 
-	/* 1/ stop irq from firing tasklets
-	 * 2/ stop the tasklet from re-arming irqs
+	/* 1/ stop irq from firing workqueue
+	 * 2/ stop the workqueue from re-arming irqs
 	 */
 	clear_bit(IOAT_RUN, &ioat_chan->state);
 
@@ -161,11 +161,11 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 	/* flush inflight timers */
 	del_timer_sync(&ioat_chan->timer);
 
-	/* flush inflight tasklet runs */
-	tasklet_kill(&ioat_chan->cleanup_task);
+	/* flush inflight workqueue runs */
+	cancel_work_sync(&ioat_chan->cleanup_work);
 
 	/* final cleanup now that everything is quiesced and can't re-arm */
-	ioat_cleanup_event(&ioat_chan->cleanup_task);
+	ioat_cleanup_work(&ioat_chan->cleanup_work);
 }
 
 static void __ioat_issue_pending(struct ioatdma_chan *ioat_chan)
@@ -690,9 +690,10 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 	spin_unlock_bh(&ioat_chan->cleanup_lock);
 }
 
-void ioat_cleanup_event(struct tasklet_struct *t)
+void ioat_cleanup_work(struct work_struct *work)
 {
-	struct ioatdma_chan *ioat_chan = from_tasklet(ioat_chan, t, cleanup_task);
+	struct ioatdma_chan *ioat_chan =
+	       container_of(work, struct ioatdma_chan, cleanup_work);
 
 	ioat_cleanup(ioat_chan);
 	if (!test_bit(IOAT_RUN, &ioat_chan->state))
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 140cfe3782fb..106f0a582744 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -108,7 +108,7 @@ struct ioatdma_chan {
 	struct ioatdma_device *ioat_dma;
 	dma_addr_t completion_dma;
 	u64 *completion;
-	struct tasklet_struct cleanup_task;
+	struct work_struct cleanup_work;
 	struct kobject kobj;
 
 /* ioat v2 / v3 channel attributes
@@ -393,7 +393,7 @@ int ioat_reset_hw(struct ioatdma_chan *ioat_chan);
 enum dma_status
 ioat_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate);
-void ioat_cleanup_event(struct tasklet_struct *t);
+void ioat_cleanup_work(struct work_struct *work);
 void ioat_timer_event(struct timer_list *t);
 int ioat_check_space_lock(struct ioatdma_chan *ioat_chan, int num_descs);
 void ioat_issue_pending(struct dma_chan *chan);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 5d707ff63554..a7fda96724ad 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -776,7 +776,7 @@ ioat_init_channel(struct ioatdma_device *ioat_dma,
 	list_add_tail(&ioat_chan->dma_chan.device_node, &dma->channels);
 	ioat_dma->idx[idx] = ioat_chan;
 	timer_setup(&ioat_chan->timer, ioat_timer_event, 0);
-	tasklet_setup(&ioat_chan->cleanup_task, ioat_cleanup_event);
+	INIT_WORK(&ioat_chan->cleanup_work, ioat_cleanup_work);
 }
 
 #define IOAT_NUM_SRC_TEST 6 /* must be <= 8 */
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 310b899d581f..61617bd5e768 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -238,10 +238,10 @@ iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 	spin_unlock_bh(&iop_chan->lock);
 }
 
-static void iop_adma_tasklet(struct tasklet_struct *t)
+static void iop_adma_work(struct work_struct *work)
 {
-	struct iop_adma_chan *iop_chan = from_tasklet(iop_chan, t,
-						      irq_tasklet);
+	struct iop_adma_chan *iop_chan =
+	       container_of(work, struct iop_adma_chan, irq_work);
 
 	/* lockdep will flag depedency submissions as potentially
 	 * recursive locking, this is not the case as a dependency
@@ -771,7 +771,7 @@ static irqreturn_t iop_adma_eot_handler(int irq, void *data)
 
 	dev_dbg(chan->device->common.dev, "%s\n", __func__);
 
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_work);
 
 	iop_adma_device_clear_eot_status(chan);
 
@@ -784,7 +784,7 @@ static irqreturn_t iop_adma_eoc_handler(int irq, void *data)
 
 	dev_dbg(chan->device->common.dev, "%s\n", __func__);
 
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_work);
 
 	iop_adma_device_clear_eoc_status(chan);
 
@@ -1351,7 +1351,7 @@ static int iop_adma_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_iop_chan;
 	}
-	tasklet_setup(&iop_chan->irq_tasklet, iop_adma_tasklet);
+	INIT_WORK(&iop_chan->irq_work, iop_adma_work);
 
 	/* clear errors before enabling interrupts */
 	iop_adma_device_clear_err_status(iop_chan);
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index baab1ca9f621..31216efe8531 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -915,9 +915,6 @@ static int idmac_desc_alloc(struct idmac_channel *ichan, int n)
 	if (!desc)
 		return -ENOMEM;
 
-	/* No interrupts, just disable the tasklet for a moment */
-	tasklet_disable(&to_ipu(idmac)->tasklet);
-
 	ichan->n_tx_desc = n;
 	ichan->desc = desc;
 	INIT_LIST_HEAD(&ichan->queue);
@@ -935,8 +932,6 @@ static int idmac_desc_alloc(struct idmac_channel *ichan, int n)
 		desc++;
 	}
 
-	tasklet_enable(&to_ipu(idmac)->tasklet);
-
 	return 0;
 }
 
@@ -1300,9 +1295,10 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void ipu_gc_tasklet(struct tasklet_struct *t)
+static void ipu_gc_work(struct work_struct *work)
 {
-	struct ipu *ipu = from_tasklet(ipu, t, tasklet);
+	struct ipu *ipu =
+		container_of(work, struct ipu, work);
 	int i;
 
 	for (i = 0; i < IPU_CHANNELS_NUM; i++) {
@@ -1369,7 +1365,7 @@ static struct dma_async_tx_descriptor *idmac_prep_slave_sg(struct dma_chan *chan
 
 	mutex_unlock(&ichan->chan_mutex);
 
-	tasklet_schedule(&to_ipu(to_idmac(chan->device))->tasklet);
+	schedule_work(&to_ipu(to_idmac(chan->device))->work);
 
 	return txd;
 }
@@ -1435,8 +1431,6 @@ static int __idmac_terminate_all(struct dma_chan *chan)
 	ipu_disable_channel(idmac, ichan,
 			    ichan->status >= IPU_CHANNEL_ENABLED);
 
-	tasklet_disable(&ipu->tasklet);
-
 	/* ichan->queue is modified in ISR, have to spinlock */
 	spin_lock_irqsave(&ichan->lock, flags);
 	list_splice_init(&ichan->queue, &ichan->free_list);
@@ -1455,8 +1449,6 @@ static int __idmac_terminate_all(struct dma_chan *chan)
 	ichan->sg[1] = NULL;
 	spin_unlock_irqrestore(&ichan->lock, flags);
 
-	tasklet_enable(&ipu->tasklet);
-
 	ichan->status = IPU_CHANNEL_INITIALIZED;
 
 	return 0;
@@ -1597,7 +1589,7 @@ static void idmac_free_chan_resources(struct dma_chan *chan)
 
 	mutex_unlock(&ichan->chan_mutex);
 
-	tasklet_schedule(&to_ipu(idmac)->tasklet);
+	schedule_work(&to_ipu(idmac)->work);
 }
 
 static enum dma_status idmac_tx_status(struct dma_chan *chan,
@@ -1741,7 +1733,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_idmac_init;
 
-	tasklet_setup(&ipu_data.tasklet, ipu_gc_tasklet);
+	INIT_WORK(&ipu_data.work, ipu_gc_work);
 
 	ipu_data.dev = &pdev->dev;
 
@@ -1774,7 +1766,7 @@ static int ipu_remove(struct platform_device *pdev)
 	clk_put(ipu->ipu_clk);
 	iounmap(ipu->reg_ic);
 	iounmap(ipu->reg_ipu);
-	tasklet_kill(&ipu->tasklet);
+	cancel_work_sync(&ipu->work);
 
 	return 0;
 }
diff --git a/drivers/dma/ipu/ipu_intern.h b/drivers/dma/ipu/ipu_intern.h
index e7ec1dec3edf..5bb04d402f71 100644
--- a/drivers/dma/ipu/ipu_intern.h
+++ b/drivers/dma/ipu/ipu_intern.h
@@ -158,7 +158,7 @@ struct ipu {
 	struct device		*dev;
 	struct idmac		idmac;
 	struct idmac_channel	channel[IPU_CHANNELS_NUM];
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 };
 
 #define to_idmac(d) container_of(d, struct idmac, dma)
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index ecdaada95120..0f54a3d67359 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -99,7 +99,7 @@ struct k3_dma_phy {
 struct k3_dma_dev {
 	struct dma_device	slave;
 	void __iomem		*base;
-	struct tasklet_struct	task;
+	struct work_struct	work;
 	spinlock_t		lock;
 	struct list_head	chan_pending;
 	struct k3_dma_phy	*phy;
@@ -253,7 +253,7 @@ static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
 	writel_relaxed(err2, d->base + INT_ERR2_RAW);
 
 	if (irq_chan)
-		tasklet_schedule(&d->task);
+		schedule_work(&d->work);
 
 	if (irq_chan || err1 || err2)
 		return IRQ_HANDLED;
@@ -296,9 +296,10 @@ static int k3_dma_start_txd(struct k3_dma_chan *c)
 	return -EAGAIN;
 }
 
-static void k3_dma_tasklet(struct tasklet_struct *t)
+static void k3_dma_work(struct work_struct *work)
 {
-	struct k3_dma_dev *d = from_tasklet(d, t, task);
+	struct k3_dma_dev *d =
+		container_of(work, struct k3_dma_dev, work);
 	struct k3_dma_phy *p;
 	struct k3_dma_chan *c, *cn;
 	unsigned pch, pch_alloc = 0;
@@ -433,8 +434,8 @@ static void k3_dma_issue_pending(struct dma_chan *chan)
 			if (list_empty(&c->node)) {
 				/* if new channel, add chan_pending */
 				list_add_tail(&c->node, &d->chan_pending);
-				/* check in tasklet */
-				tasklet_schedule(&d->task);
+				/* check in workqueue */
+				schedule_work(&d->work);
 				dev_dbg(d->slave.dev, "vchan %p: issued\n", &c->vc);
 			}
 		}
@@ -961,7 +962,7 @@ static int k3_dma_probe(struct platform_device *op)
 
 	spin_lock_init(&d->lock);
 	INIT_LIST_HEAD(&d->chan_pending);
-	tasklet_setup(&d->task, k3_dma_tasklet);
+	INIT_WORK(&d->work, k3_dma_work);
 	platform_set_drvdata(op, d);
 	dev_info(&op->dev, "initialized\n");
 
@@ -986,9 +987,9 @@ static int k3_dma_remove(struct platform_device *op)
 
 	list_for_each_entry_safe(c, cn, &d->slave.channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
-	tasklet_kill(&d->task);
+	cancel_work_sync(&d->work);
 	clk_disable_unprepare(d->clk);
 	return 0;
 }
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 41ef9f15d3d5..b85fa8a5b4a8 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -95,7 +95,7 @@ struct mtk_cqdma_vdesc {
  * @base:                  The mapped register I/O base of this PC
  * @irq:                   The IRQ that this PC are using
  * @refcnt:                Track how many VCs are using this PC
- * @tasklet:               Tasklet for this PC
+ * @work:                  Workqueue for this PC
  * @lock:                  Lock protect agaisting multiple VCs access PC
  */
 struct mtk_cqdma_pchan {
@@ -105,7 +105,7 @@ struct mtk_cqdma_pchan {
 
 	refcount_t refcnt;
 
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 
 	/* lock to protect PC */
 	spinlock_t lock;
@@ -356,9 +356,10 @@ static struct mtk_cqdma_vdesc
 	return ret;
 }
 
-static void mtk_cqdma_tasklet_cb(struct tasklet_struct *t)
+static void mtk_cqdma_worker_cb(struct work_struct *work)
 {
-	struct mtk_cqdma_pchan *pc = from_tasklet(pc, t, tasklet);
+	struct mtk_cqdma_pchan *pc =
+		container_of(work, struct mtk_cqdma_pchan, work);
 	struct mtk_cqdma_vdesc *cvd = NULL;
 	unsigned long flags;
 
@@ -379,7 +380,7 @@ static void mtk_cqdma_tasklet_cb(struct tasklet_struct *t)
 			kfree(cvd);
 	}
 
-	/* re-enable interrupt before leaving tasklet */
+	/* re-enable interrupt before leaving worker */
 	enable_irq(pc->irq);
 }
 
@@ -387,11 +388,11 @@ static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
 {
 	struct mtk_cqdma_device *cqdma = devid;
 	irqreturn_t ret = IRQ_NONE;
-	bool schedule_tasklet = false;
+	bool sched_work = false;
 	u32 i;
 
 	/* clear interrupt flags for each PC */
-	for (i = 0; i < cqdma->dma_channels; ++i, schedule_tasklet = false) {
+	for (i = 0; i < cqdma->dma_channels; ++i, sched_work = false) {
 		spin_lock(&cqdma->pc[i]->lock);
 		if (mtk_dma_read(cqdma->pc[i],
 				 MTK_CQDMA_INT_FLAG) & MTK_CQDMA_INT_FLAG_BIT) {
@@ -399,17 +400,17 @@ static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
 			mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_FLAG,
 				    MTK_CQDMA_INT_FLAG_BIT);
 
-			schedule_tasklet = true;
+			sched_work = true;
 			ret = IRQ_HANDLED;
 		}
 		spin_unlock(&cqdma->pc[i]->lock);
 
-		if (schedule_tasklet) {
+		if (sched_work) {
 			/* disable interrupt */
 			disable_irq_nosync(cqdma->pc[i]->irq);
 
-			/* schedule the tasklet to handle the transactions */
-			tasklet_schedule(&cqdma->pc[i]->tasklet);
+			/* schedule work to handle the transactions */
+			schedule_work(&cqdma->pc[i]->work);
 		}
 	}
 
@@ -473,7 +474,7 @@ static void mtk_cqdma_issue_pending(struct dma_chan *c)
 	unsigned long pc_flags;
 	unsigned long vc_flags;
 
-	/* acquire PC's lock before VS's lock for lock dependency in tasklet */
+	/* acquire PC's lock before VS's lock for lock dependency in workqueue */
 	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
 	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
 
@@ -876,9 +877,9 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cqdma);
 
-	/* initialize tasklet for each PC */
+	/* initialize workqueue for each PC */
 	for (i = 0; i < cqdma->dma_channels; ++i)
-		tasklet_setup(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb);
+		INIT_WORK(&cqdma->pc[i]->work, mtk_cqdma_worker_cb);
 
 	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
 
@@ -897,12 +898,12 @@ static int mtk_cqdma_remove(struct platform_device *pdev)
 	unsigned long flags;
 	int i;
 
-	/* kill VC task */
+	/* Cancel VC work */
 	for (i = 0; i < cqdma->dma_requests; i++) {
 		vc = &cqdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		cancel_work_sync(&vc->vc.work);
 	}
 
 	/* disable interrupt */
@@ -915,7 +916,7 @@ static int mtk_cqdma_remove(struct platform_device *pdev)
 		/* Waits for any pending IRQ handlers to complete */
 		synchronize_irq(cqdma->pc[i]->irq);
 
-		tasklet_kill(&cqdma->pc[i]->tasklet);
+		cancel_work_sync(&cqdma->pc[i]->work);
 	}
 
 	/* disable hardware */
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 6ad8afbb95f2..a0a93c283961 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1021,12 +1021,12 @@ static int mtk_hsdma_remove(struct platform_device *pdev)
 	struct mtk_hsdma_vchan *vc;
 	int i;
 
-	/* Kill VC task */
+	/* Cancel VC work */
 	for (i = 0; i < hsdma->dma_requests; i++) {
 		vc = &hsdma->vc[i];
 
 		list_del(&vc->vc.chan.device_node);
-		tasklet_kill(&vc->vc.task);
+		cancel_work_sync(&vc->vc.work);
 	}
 
 	/* Disable DMA interrupt */
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 375e7e647df6..e79493f85529 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -310,7 +310,7 @@ static void mtk_uart_apdma_free_chan_resources(struct dma_chan *chan)
 
 	free_irq(c->irq, chan);
 
-	tasklet_kill(&c->vc.task);
+	cancel_work_sync(&c->vc.work);
 
 	vchan_free_chan_resources(&c->vc);
 
@@ -462,7 +462,7 @@ static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
 			struct mtk_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 }
 
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 5a53d7fcef01..15dc9c2e11c3 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -98,7 +98,7 @@ struct mmp_pdma_chan {
 						 * is in cyclic mode */
 
 	/* channel's basic info */
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	u32 dcmd;
 	u32 drcmr;
 	u32 dev_addr;
@@ -205,7 +205,7 @@ static irqreturn_t mmp_pdma_chan_handler(int irq, void *dev_id)
 	if (clear_chan_irq(phy) != 0)
 		return IRQ_NONE;
 
-	tasklet_schedule(&phy->vchan->tasklet);
+	schedule_work(&phy->vchan->work);
 	return IRQ_HANDLED;
 }
 
@@ -862,13 +862,14 @@ static void mmp_pdma_issue_pending(struct dma_chan *dchan)
 }
 
 /*
- * dma_do_tasklet
+ * dma_do_work
  * Do call back
  * Start pending list
  */
-static void dma_do_tasklet(struct tasklet_struct *t)
+static void dma_do_work(struct work_struct *work)
 {
-	struct mmp_pdma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct mmp_pdma_chan *chan =
+		container_of(work, struct mmp_pdma_chan, work);
 	struct mmp_pdma_desc_sw *desc, *_desc;
 	LIST_HEAD(chain_cleanup);
 	unsigned long flags;
@@ -986,7 +987,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	spin_lock_init(&chan->desc_lock);
 	chan->dev = pdev->dev;
 	chan->chan.device = &pdev->device;
-	tasklet_setup(&chan->tasklet, dma_do_tasklet);
+	INIT_WORK(&chan->work, dma_do_work);
 	INIT_LIST_HEAD(&chan->chain_pending);
 	INIT_LIST_HEAD(&chan->chain_running);
 
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc9..13a250ef1fe8 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -102,7 +102,7 @@ struct mmp_tdma_chan {
 	struct device			*dev;
 	struct dma_chan			chan;
 	struct dma_async_tx_descriptor	desc;
-	struct tasklet_struct		tasklet;
+	struct work_struct		work;
 
 	struct mmp_tdma_desc		*desc_arr;
 	dma_addr_t			desc_arr_phys;
@@ -320,7 +320,7 @@ static irqreturn_t mmp_tdma_chan_handler(int irq, void *dev_id)
 	struct mmp_tdma_chan *tdmac = dev_id;
 
 	if (mmp_tdma_clear_chan_irq(tdmac) == 0) {
-		tasklet_schedule(&tdmac->tasklet);
+		schedule_work(&tdmac->work);
 		return IRQ_HANDLED;
 	} else
 		return IRQ_NONE;
@@ -346,9 +346,10 @@ static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
-static void dma_do_tasklet(struct tasklet_struct *t)
+static void dma_do_work(struct work_struct *work)
 {
-	struct mmp_tdma_chan *tdmac = from_tasklet(tdmac, t, tasklet);
+	struct mmp_tdma_chan *tdmac =
+		container_of(work, struct mmp_tdma_chan, work);
 
 	dmaengine_desc_get_callback_invoke(&tdmac->desc, NULL);
 }
@@ -586,7 +587,7 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 	tdmac->pool	   = pool;
 	tdmac->status = DMA_COMPLETE;
 	tdev->tdmac[tdmac->idx] = tdmac;
-	tasklet_setup(&tdmac->tasklet, dma_do_tasklet);
+	INIT_WORK(&tdmac->work, dma_do_work);
 
 	/* add the channel to tdma_chan list */
 	list_add_tail(&tdmac->chan.device_node,
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 4a51fdbf5aa9..5bdeb7316f3c 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -214,7 +214,7 @@ struct mpc_dma_chan {
 
 struct mpc_dma {
 	struct dma_device		dma;
-	struct tasklet_struct		tasklet;
+	struct work_struct		work;
 	struct mpc_dma_chan		channels[MPC_DMA_CHANNELS];
 	struct mpc_dma_regs __iomem	*regs;
 	struct mpc_dma_tcd __iomem	*tcd;
@@ -366,8 +366,8 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
 					in_be32(&mdma->regs->dmaerrl), 0);
 
-	/* Schedule tasklet */
-	tasklet_schedule(&mdma->tasklet);
+	/* schedule work */
+	schedule_work(&mdma->work);
 
 	return IRQ_HANDLED;
 }
@@ -413,10 +413,11 @@ static void mpc_dma_process_completed(struct mpc_dma *mdma)
 	}
 }
 
-/* DMA Tasklet */
-static void mpc_dma_tasklet(struct tasklet_struct *t)
+/* DMA Workqueue */
+static void mpc_dma_work(struct work_struct *work)
 {
-	struct mpc_dma *mdma = from_tasklet(mdma, t, tasklet);
+	struct mpc_dma *mdma =
+		container_of(work, struct mpc_dma, work);
 	unsigned long flags;
 	uint es;
 
@@ -1010,7 +1011,7 @@ static int mpc_dma_probe(struct platform_device *op)
 		list_add_tail(&mchan->chan.device_node, &dma->channels);
 	}
 
-	tasklet_setup(&mdma->tasklet, mpc_dma_tasklet);
+	INIT_WORK(&mdma->work, mpc_dma_work);
 
 	/*
 	 * Configure DMA Engine:
@@ -1098,7 +1099,7 @@ static int mpc_dma_remove(struct platform_device *op)
 	}
 	free_irq(mdma->irq, mdma);
 	irq_dispose_mapping(mdma->irq);
-	tasklet_kill(&mdma->tasklet);
+	cancel_work_sync(&mdma->work);
 
 	return 0;
 }
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..02b93cbef58d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -327,7 +327,7 @@ static void mv_chan_slot_cleanup(struct mv_xor_chan *mv_chan)
 				 * some descriptors are still waiting
 				 * to be cleaned
 				 */
-				tasklet_schedule(&mv_chan->irq_tasklet);
+				schedule_work(&mv_chan->irq_work);
 			}
 		}
 	}
@@ -336,9 +336,10 @@ static void mv_chan_slot_cleanup(struct mv_xor_chan *mv_chan)
 		mv_chan->dmachan.completed_cookie = cookie;
 }
 
-static void mv_xor_tasklet(struct tasklet_struct *t)
+static void mv_xor_work(struct work_struct *work)
 {
-	struct mv_xor_chan *chan = from_tasklet(chan, t, irq_tasklet);
+	struct mv_xor_chan *chan =
+		container_of(work, struct mv_xor_chan, irq_work);
 
 	spin_lock(&chan->lock);
 	mv_chan_slot_cleanup(chan);
@@ -372,7 +373,7 @@ mv_chan_alloc_slot(struct mv_xor_chan *mv_chan)
 	spin_unlock_bh(&mv_chan->lock);
 
 	/* try to free some slots if the allocation fails */
-	tasklet_schedule(&mv_chan->irq_tasklet);
+	schedule_work(&mv_chan->irq_work);
 
 	return NULL;
 }
@@ -737,7 +738,7 @@ static irqreturn_t mv_xor_interrupt_handler(int irq, void *data)
 	if (intr_cause & XOR_INTR_ERRORS)
 		mv_chan_err_interrupt_handler(chan, intr_cause);
 
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_work);
 
 	mv_chan_clear_eoc_cause(chan);
 
@@ -1097,7 +1098,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	mv_chan->mmr_base = xordev->xor_base;
 	mv_chan->mmr_high_base = xordev->xor_high_base;
-	tasklet_setup(&mv_chan->irq_tasklet, mv_xor_tasklet);
+	INIT_WORK(&mv_chan->irq_work, mv_xor_work);
 
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index d86086b05b0e..1a84a98de88f 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -98,7 +98,7 @@ struct mv_xor_device {
  * @device: parent device
  * @common: common dmaengine channel object members
  * @slots_allocated: records the actual size of the descriptor slot pool
- * @irq_tasklet: bottom half where mv_xor_slot_cleanup runs
+ * @irq_work: bottom half where mv_xor_slot_cleanup runs
  * @op_in_desc: new mode of driver, each op is writen to descriptor.
  */
 struct mv_xor_chan {
@@ -118,7 +118,7 @@ struct mv_xor_chan {
 	struct dma_device	dmadev;
 	struct dma_chan		dmachan;
 	int			slots_allocated;
-	struct tasklet_struct	irq_tasklet;
+	struct work_struct	irq_work;
 	int                     op_in_desc;
 	char			dummy_src[MV_XOR_MIN_BYTE_COUNT];
 	char			dummy_dst[MV_XOR_MIN_BYTE_COUNT];
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9c8b4084ba2f..b07598149a21 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -139,7 +139,7 @@ struct mv_xor_v2_descriptor {
  * @reg_clk: reference to the 'reg' clock
  * @dma_base: memory mapped DMA register base
  * @glob_base: memory mapped global register base
- * @irq_tasklet: tasklet used for IRQ handling call-backs
+ * @irq_work: workqueue used for IRQ handling call-backs
  * @free_sw_desc: linked list of free SW descriptors
  * @dmadev: dma device
  * @dmachan: dma channel
@@ -158,7 +158,7 @@ struct mv_xor_v2_device {
 	void __iomem *glob_base;
 	struct clk *clk;
 	struct clk *reg_clk;
-	struct tasklet_struct irq_tasklet;
+	struct work_struct irq_work;
 	struct list_head free_sw_desc;
 	struct dma_device dmadev;
 	struct dma_chan	dmachan;
@@ -290,8 +290,8 @@ static irqreturn_t mv_xor_v2_interrupt_handler(int irq, void *data)
 	if (!ndescs)
 		return IRQ_NONE;
 
-	/* schedule a tasklet to handle descriptors callbacks */
-	tasklet_schedule(&xor_dev->irq_tasklet);
+	/* schedule work to handle descriptors callbacks */
+	schedule_work(&xor_dev->irq_work);
 
 	return IRQ_HANDLED;
 }
@@ -346,8 +346,8 @@ mv_xor_v2_prep_sw_desc(struct mv_xor_v2_device *xor_dev)
 
 	if (list_empty(&xor_dev->free_sw_desc)) {
 		spin_unlock_bh(&xor_dev->lock);
-		/* schedule tasklet to free some descriptors */
-		tasklet_schedule(&xor_dev->irq_tasklet);
+		/* schedule work to free some descriptors */
+		schedule_work(&xor_dev->irq_work);
 		return NULL;
 	}
 
@@ -553,10 +553,11 @@ int mv_xor_v2_get_pending_params(struct mv_xor_v2_device *xor_dev,
 /*
  * handle the descriptors after HW process
  */
-static void mv_xor_v2_tasklet(struct tasklet_struct *t)
+static void mv_xor_v2_work(struct work_struct *work)
 {
-	struct mv_xor_v2_device *xor_dev = from_tasklet(xor_dev, t,
-							irq_tasklet);
+	struct mv_xor_v2_device *xor_dev =
+	       container_of(work, struct mv_xor_v2_device, irq_work);
+
 	int pending_ptr, num_of_pending, i;
 	struct mv_xor_v2_sw_desc *next_pending_sw_desc = NULL;
 
@@ -777,7 +778,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_msi_irqs;
 
-	tasklet_setup(&xor_dev->irq_tasklet, mv_xor_v2_tasklet);
+	INIT_WORK(&xor_dev->irq_work, mv_xor_v2_work);
 
 	xor_dev->desc_size = mv_xor_v2_set_desc_size(xor_dev);
 
@@ -890,7 +891,7 @@ static int mv_xor_v2_remove(struct platform_device *pdev)
 
 	platform_msi_domain_free_irqs(&pdev->dev);
 
-	tasklet_kill(&xor_dev->irq_tasklet);
+	cancel_work_sync(&xor_dev->irq_work);
 
 	clk_disable_unprepare(xor_dev->clk);
 
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca4..56169ed29955 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -110,7 +110,7 @@ struct mxs_dma_chan {
 	struct mxs_dma_engine		*mxs_dma;
 	struct dma_chan			chan;
 	struct dma_async_tx_descriptor	desc;
-	struct tasklet_struct		tasklet;
+	struct work_struct		work;
 	unsigned int			chan_irq;
 	struct mxs_dma_ccw		*ccw;
 	dma_addr_t			ccw_phys;
@@ -301,9 +301,10 @@ static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	return dma_cookie_assign(tx);
 }
 
-static void mxs_dma_tasklet(struct tasklet_struct *t)
+static void mxs_dma_work(struct work_struct *work)
 {
-	struct mxs_dma_chan *mxs_chan = from_tasklet(mxs_chan, t, tasklet);
+	struct mxs_dma_chan *mxs_chan =
+		container_of(work, struct mxs_dma_chan, work);
 
 	dmaengine_desc_get_callback_invoke(&mxs_chan->desc, NULL);
 }
@@ -387,8 +388,8 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 		dma_cookie_complete(&mxs_chan->desc);
 	}
 
-	/* schedule tasklet on this channel */
-	tasklet_schedule(&mxs_chan->tasklet);
+	/* schedule work on this channel */
+	schedule_work(&mxs_chan->work);
 
 	return IRQ_HANDLED;
 }
@@ -785,7 +786,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 		mxs_chan->chan.device = &mxs_dma->dma_device;
 		dma_cookie_init(&mxs_chan->chan);
 
-		tasklet_setup(&mxs_chan->tasklet, mxs_dma_tasklet);
+		INIT_WORK(&mxs_chan->work, mxs_dma_work);
 
 
 		/* Add the channel to mxs_chan list */
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 9c52c57919c6..1f245651f34d 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -175,7 +175,7 @@ struct nbpf_desc_page {
 /**
  * struct nbpf_channel - one DMAC channel
  * @dma_chan:	standard dmaengine channel object
- * @tasklet:	channel specific tasklet used for callbacks
+ * @work:	channel specific workqueue used for callbacks
  * @base:	register address base
  * @nbpf:	DMAC
  * @name:	IRQ name
@@ -201,7 +201,7 @@ struct nbpf_desc_page {
  */
 struct nbpf_channel {
 	struct dma_chan dma_chan;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	void __iomem *base;
 	struct nbpf_device *nbpf;
 	char name[16];
@@ -1113,9 +1113,10 @@ static struct dma_chan *nbpf_of_xlate(struct of_phandle_args *dma_spec,
 	return dchan;
 }
 
-static void nbpf_chan_tasklet(struct tasklet_struct *t)
+static void nbpf_chan_work(struct work_struct *work)
 {
-	struct nbpf_channel *chan = from_tasklet(chan, t, tasklet);
+	struct nbpf_channel *chan =
+		container_of(work, struct nbpf_channel, work);
 	struct nbpf_desc *desc, *tmp;
 	struct dmaengine_desc_callback cb;
 
@@ -1216,7 +1217,7 @@ static irqreturn_t nbpf_chan_irq(int irq, void *dev)
 	spin_unlock(&chan->lock);
 
 	if (bh)
-		tasklet_schedule(&chan->tasklet);
+		schedule_work(&chan->work);
 
 	return ret;
 }
@@ -1260,7 +1261,7 @@ static int nbpf_chan_probe(struct nbpf_device *nbpf, int n)
 
 	snprintf(chan->name, sizeof(chan->name), "nbpf %d", n);
 
-	tasklet_setup(&chan->tasklet, nbpf_chan_tasklet);
+	INIT_WORK(&chan->work, nbpf_chan_work);
 	ret = devm_request_irq(dma_dev->dev, chan->irq,
 			nbpf_chan_irq, IRQF_SHARED,
 			chan->name, chan);
@@ -1471,7 +1472,7 @@ static int nbpf_remove(struct platform_device *pdev)
 
 		devm_free_irq(&pdev->dev, chan->irq, chan);
 
-		tasklet_kill(&chan->tasklet);
+		cancel_work_sync(&chan->work);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 1f0bbaed4643..98c17b58df9a 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1054,7 +1054,7 @@ static inline void owl_dma_free(struct owl_dma *od)
 	list_for_each_entry_safe(vchan,
 				 next, &od->dma.channels, vc.chan.device_node) {
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		cancel_work_sync(&vchan->vc.work);
 	}
 }
 
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c359decc07a3..45a8dc1ce35c 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -91,7 +91,7 @@ struct pch_dma_chan {
 	struct dma_chan		chan;
 	void __iomem *membase;
 	enum dma_transfer_direction dir;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	unsigned long		err_status;
 
 	spinlock_t		lock;
@@ -670,14 +670,15 @@ static int pd_device_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void pdc_tasklet(struct tasklet_struct *t)
+static void pdc_work(struct work_struct *work)
 {
-	struct pch_dma_chan *pd_chan = from_tasklet(pd_chan, t, tasklet);
+	struct pch_dma_chan *pd_chan =
+		container_of(work, struct pch_dma_chan, work);
 	unsigned long flags;
 
 	if (!pdc_is_idle(pd_chan)) {
 		dev_err(chan2dev(&pd_chan->chan),
-			"BUG: handle non-idle channel in tasklet\n");
+			"BUG: handle non-idle channel in workqueue\n");
 		return;
 	}
 
@@ -712,7 +713,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
 				if (sts0 & DMA_STATUS0_ERR(i))
 					set_bit(0, &pd_chan->err_status);
 
-				tasklet_schedule(&pd_chan->tasklet);
+				schedule_work(&pd_chan->work);
 				ret0 = IRQ_HANDLED;
 			}
 		} else {
@@ -720,7 +721,7 @@ static irqreturn_t pd_irq(int irq, void *devid)
 				if (sts2 & DMA_STATUS2_ERR(i))
 					set_bit(0, &pd_chan->err_status);
 
-				tasklet_schedule(&pd_chan->tasklet);
+				schedule_work(&pd_chan->work);
 				ret2 = IRQ_HANDLED;
 			}
 		}
@@ -882,7 +883,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		INIT_LIST_HEAD(&pd_chan->queue);
 		INIT_LIST_HEAD(&pd_chan->free_list);
 
-		tasklet_setup(&pd_chan->tasklet, pdc_tasklet);
+		INIT_WORK(&pd_chan->work, pdc_work);
 		list_add_tail(&pd_chan->chan.device_node, &pd->dma.channels);
 	}
 
@@ -935,7 +936,7 @@ static void pch_dma_remove(struct pci_dev *pdev)
 					 device_node) {
 			pd_chan = to_pd_chan(chan);
 
-			tasklet_kill(&pd_chan->tasklet);
+			cancel_work_sync(&pd_chan->work);
 		}
 
 		dma_pool_destroy(pd->pool);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 858400e42ec0..d73c4a510f49 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -360,7 +360,7 @@ struct _pl330_req {
 	struct dma_pl330_desc *desc;
 };
 
-/* ToBeDone for tasklet */
+/* ToBeDone for workqueue */
 struct _pl330_tbd {
 	bool reset_dmac;
 	bool reset_mngr;
@@ -412,7 +412,7 @@ enum desc_status {
 
 struct dma_pl330_chan {
 	/* Schedule desc completion */
-	struct tasklet_struct task;
+	struct work_struct work;
 
 	/* DMA-Engine Channel */
 	struct dma_chan chan;
@@ -484,7 +484,7 @@ struct pl330_dmac {
 	/* Pointer to the MANAGER thread */
 	struct pl330_thread	*manager;
 	/* To handle bad news in interrupt */
-	struct tasklet_struct	tasks;
+	struct work_struct	work;
 	struct _pl330_tbd	dmac_tbd;
 	/* State of DMAC operation */
 	enum pl330_dmac_state	state;
@@ -1568,12 +1568,13 @@ static void dma_pl330_rqcb(struct dma_pl330_desc *desc, enum pl330_op_err err)
 
 	spin_unlock_irqrestore(&pch->lock, flags);
 
-	tasklet_schedule(&pch->task);
+	schedule_work(&pch->work);
 }
 
-static void pl330_dotask(struct tasklet_struct *t)
+static void pl330_dowork(struct work_struct *work)
 {
-	struct pl330_dmac *pl330 = from_tasklet(pl330, t, tasks);
+	struct pl330_dmac *pl330 =
+		container_of(work, struct pl330_dmac, work);
 	unsigned long flags;
 	int i;
 
@@ -1726,7 +1727,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			|| pl330->dmac_tbd.reset_mngr
 			|| pl330->dmac_tbd.reset_chan) {
 		ret = 1;
-		tasklet_schedule(&pl330->tasks);
+		schedule_work(&pl330->work);
 	}
 
 	return ret;
@@ -1977,7 +1978,7 @@ static int pl330_add(struct pl330_dmac *pl330)
 		return ret;
 	}
 
-	tasklet_setup(&pl330->tasks, pl330_dotask);
+	INIT_WORK(&pl330->work, pl330_dowork);
 
 	pl330->state = INIT;
 
@@ -2005,7 +2006,7 @@ static void pl330_del(struct pl330_dmac *pl330)
 {
 	pl330->state = UNINIT;
 
-	tasklet_kill(&pl330->tasks);
+	cancel_work_sync(&pl330->work);
 
 	/* Free DMAC resources */
 	dmac_free_threads(pl330);
@@ -2055,14 +2056,15 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 			desc->status = DONE;
 			dev_err(pch->dmac->ddma.dev, "%s:%d Bad Desc(%d)\n",
 					__func__, __LINE__, desc->txd.cookie);
-			tasklet_schedule(&pch->task);
+			schedule_work(&pch->work);
 		}
 	}
 }
 
-static void pl330_tasklet(struct tasklet_struct *t)
+static void pl330_work(struct work_struct *work)
 {
-	struct dma_pl330_chan *pch = from_tasklet(pch, t, task);
+	struct dma_pl330_chan *pch =
+		container_of(work, struct dma_pl330_chan, work);
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
 	bool power_down = false;
@@ -2170,7 +2172,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 		return -ENOMEM;
 	}
 
-	tasklet_setup(&pch->task, pl330_tasklet);
+	INIT_WORK(&pch->work, pl330_work);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
 
@@ -2348,7 +2350,7 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	struct pl330_dmac *pl330 = pch->dmac;
 	unsigned long flags;
 
-	tasklet_kill(&pch->task);
+	cancel_work_sync(&pch->work);
 
 	pm_runtime_get_sync(pch->dmac->ddma.dev);
 	spin_lock_irqsave(&pl330->lock, flags);
@@ -2482,7 +2484,7 @@ static void pl330_issue_pending(struct dma_chan *chan)
 	list_splice_tail_init(&pch->submitted_list, &pch->work_list);
 	spin_unlock_irqrestore(&pch->lock, flags);
 
-	pl330_tasklet(&pch->task);
+	pl330_work(&pch->work);
 }
 
 /*
diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 1ffcb5ca9788..868f2e6b997c 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -105,7 +105,7 @@ struct plx_dma_dev {
 	struct dma_chan dma_chan;
 	struct pci_dev __rcu *pdev;
 	void __iomem *bar;
-	struct tasklet_struct desc_task;
+	struct work_struct desc_work;
 
 	spinlock_t ring_lock;
 	bool ring_active;
@@ -241,9 +241,10 @@ static void plx_dma_stop(struct plx_dma_dev *plxdev)
 	rcu_read_unlock();
 }
 
-static void plx_dma_desc_task(struct tasklet_struct *t)
+static void plx_dma_desc_work(struct work_struct *work)
 {
-	struct plx_dma_dev *plxdev = from_tasklet(plxdev, t, desc_task);
+	struct plx_dma_dev *plxdev =
+		container_of(work, struct plx_dma_dev, desc_work);
 
 	plx_dma_process_desc(plxdev);
 }
@@ -366,7 +367,7 @@ static irqreturn_t plx_dma_isr(int irq, void *devid)
 		return IRQ_NONE;
 
 	if (status & PLX_REG_INTR_STATUS_DESC_DONE && plxdev->ring_active)
-		tasklet_schedule(&plxdev->desc_task);
+		schedule_work(&plxdev->desc_work);
 
 	writew(status, plxdev->bar + PLX_REG_INTR_STATUS);
 
@@ -472,7 +473,7 @@ static void plx_dma_free_chan_resources(struct dma_chan *chan)
 	if (irq > 0)
 		synchronize_irq(irq);
 
-	tasklet_kill(&plxdev->desc_task);
+	cancel_work_sync(&plxdev->desc_work);
 
 	plx_dma_abort_desc(plxdev);
 
@@ -511,7 +512,7 @@ static int plx_dma_create(struct pci_dev *pdev)
 		goto free_plx;
 
 	spin_lock_init(&plxdev->ring_lock);
-	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
+	INIT_WORK(&plxdev->desc_work, plx_dma_desc_work);
 
 	RCU_INIT_POINTER(plxdev->pdev, pdev);
 	plxdev->bar = pcim_iomap_table(pdev)[0];
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 6b5e91f26afc..8aa9caa70ba8 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1656,11 +1656,12 @@ static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan *chan)
 }
 
 /**
- * ppc440spe_adma_tasklet - clean up watch-dog initiator
+ * ppc440spe_adma_work - clean up watch-dog initiator
  */
-static void ppc440spe_adma_tasklet(struct tasklet_struct *t)
+static void ppc440spe_adma_work(struct work_struct *work)
 {
-	struct ppc440spe_adma_chan *chan = from_tasklet(chan, t, irq_tasklet);
+	struct ppc440spe_adma_chan *chan =
+		container_of(work, struct ppc440spe_adma_chan, irq_wq);
 
 	spin_lock_nested(&chan->lock, SINGLE_DEPTH_NESTING);
 	__ppc440spe_adma_slot_cleanup(chan);
@@ -1754,7 +1755,7 @@ static struct ppc440spe_adma_desc_slot *ppc440spe_adma_alloc_slots(
 		goto retry;
 
 	/* try to free some slots if the allocation fails */
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_wq);
 	return NULL;
 }
 
@@ -3596,7 +3597,7 @@ static irqreturn_t ppc440spe_adma_eot_handler(int irq, void *data)
 	dev_dbg(chan->device->common.dev,
 		"ppc440spe adma%d: %s\n", chan->device->id, __func__);
 
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_wq);
 	ppc440spe_adma_device_clear_eot_status(chan);
 
 	return IRQ_HANDLED;
@@ -3613,7 +3614,7 @@ static irqreturn_t ppc440spe_adma_err_handler(int irq, void *data)
 	dev_dbg(chan->device->common.dev,
 		"ppc440spe adma%d: %s\n", chan->device->id, __func__);
 
-	tasklet_schedule(&chan->irq_tasklet);
+	schedule_work(&chan->irq_wq);
 	ppc440spe_adma_device_clear_eot_status(chan);
 
 	return IRQ_HANDLED;
@@ -4138,7 +4139,7 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	chan->common.device = &adev->common;
 	dma_cookie_init(&chan->common);
 	list_add_tail(&chan->common.device_node, &adev->common.channels);
-	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
+	INIT_WORK(&chan->irq_wq, ppc440spe_adma_work);
 
 	/* allocate and map helper pages for async validation or
 	 * async_mult/async_sum_product operations on DMA0/1.
@@ -4248,7 +4249,7 @@ static int ppc440spe_adma_remove(struct platform_device *ofdev)
 				 device_node) {
 		ppc440spe_chan = to_ppc440spe_adma_chan(chan);
 		ppc440spe_adma_release_irqs(adev, ppc440spe_chan);
-		tasklet_kill(&ppc440spe_chan->irq_tasklet);
+		cancel_work_sync(&ppc440spe_chan->irq_wq);
 		if (adev->id != PPC440SPE_XOR_ID) {
 			dma_unmap_page(&ofdev->dev, ppc440spe_chan->pdest,
 					PAGE_SIZE, DMA_BIDIRECTIONAL);
diff --git a/drivers/dma/ppc4xx/adma.h b/drivers/dma/ppc4xx/adma.h
index 26b7a5ed9ac7..6c31f73dd12d 100644
--- a/drivers/dma/ppc4xx/adma.h
+++ b/drivers/dma/ppc4xx/adma.h
@@ -83,7 +83,7 @@ struct ppc440spe_adma_device {
  * @pending: allows batching of hardware operations
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @hw_chain_inited: h/w descriptor chain initialization flag
- * @irq_tasklet: bottom half where ppc440spe_adma_slot_cleanup runs
+ * @irq_wq: bottom half where ppc440spe_adma_slot_cleanup runs
  * @needs_unmap: if buffers should not be unmapped upon final processing
  * @pdest_page: P destination page for async validate operation
  * @qdest_page: Q destination page for async validate operation
@@ -100,7 +100,7 @@ struct ppc440spe_adma_chan {
 	int pending;
 	int slots_allocated;
 	int hw_chain_inited;
-	struct tasklet_struct irq_tasklet;
+	struct work_struct irq_wq;
 	u8 needs_unmap;
 	struct page *pdest_page;
 	struct page *qdest_page;
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index daafea5bc35d..92a307dfb829 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -126,7 +126,7 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
 
 static void pt_do_cmd_complete(unsigned long data)
 {
-	struct pt_tasklet_data *tdata = (struct pt_tasklet_data *)data;
+	struct pt_work_data *tdata = (struct pt_work_data *)data;
 	struct pt_cmd *cmd = tdata->cmd;
 	struct pt_cmd_queue *cmd_q = &cmd->pt->cmd_q;
 	u32 tail;
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index afbf192c9230..417ea68f1d9e 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -115,7 +115,7 @@
 
 struct pt_device;
 
-struct pt_tasklet_data {
+struct pt_work_data {
 	struct completion completion;
 	struct pt_cmd *cmd;
 };
@@ -258,7 +258,7 @@ struct pt_device {
 	/* Device Statistics */
 	unsigned long total_interrupts;
 
-	struct pt_tasklet_data tdata;
+	struct pt_work_data tdata;
 };
 
 /*
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 6078cc81892e..a36cdbafd4dc 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1217,7 +1217,7 @@ static void pxad_free_channels(struct dma_device *dmadev)
 	list_for_each_entry_safe(c, cn, &dmadev->channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 }
 
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 87f6ca1541cf..56d0d3f68432 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -396,8 +396,8 @@ struct bam_device {
 	struct clk *bamclk;
 	int irq;
 
-	/* dma start transaction tasklet */
-	struct tasklet_struct task;
+	/* dma start transaction workqueue */
+	struct work_struct work;
 };
 
 /**
@@ -883,7 +883,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			/*
 			 * if complete, process cookie. Otherwise
 			 * push back to front of desc_issued so that
-			 * it gets restarted by the tasklet
+			 * it gets restarted by the workqueue
 			 */
 			if (!async_desc->num_desc) {
 				vchan_cookie_complete(&async_desc->vd);
@@ -915,9 +915,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 
 	srcs |= process_channel_irqs(bdev);
 
-	/* kick off tasklet to start next dma transfer */
+	/* kick off workqueue to start next dma transfer */
 	if (srcs & P_IRQ)
-		tasklet_schedule(&bdev->task);
+		schedule_work(&bdev->work);
 
 	ret = bam_pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
@@ -1115,14 +1115,15 @@ static void bam_start_dma(struct bam_chan *bchan)
 }
 
 /**
- * dma_tasklet - DMA IRQ tasklet
- * @t: tasklet argument (bam controller structure)
+ * dma_workqueue - DMA IRQ workqueue
+ * @wq: workqueue argument (bam controller structure)
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-static void dma_tasklet(struct tasklet_struct *t)
+static void dma_workqueue(struct work_struct *work)
 {
-	struct bam_device *bdev = from_tasklet(bdev, t, task);
+	struct bam_device *bdev =
+		container_of(work, struct bam_device, work);
 	struct bam_chan *bchan;
 	unsigned long flags;
 	unsigned int i;
@@ -1143,7 +1144,7 @@ static void dma_tasklet(struct tasklet_struct *t)
  * bam_issue_pending - starts pending transactions
  * @chan: dma channel
  *
- * Calls tasklet directly which in turn starts any pending transactions
+ * Calls workqueue directly which in turn starts any pending transactions
  */
 static void bam_issue_pending(struct dma_chan *chan)
 {
@@ -1312,14 +1313,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk;
 
-	tasklet_setup(&bdev->task, dma_tasklet);
+	INIT_WORK(&bdev->work, dma_work);
 
 	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
 				sizeof(*bdev->channels), GFP_KERNEL);
 
 	if (!bdev->channels) {
 		ret = -ENOMEM;
-		goto err_tasklet_kill;
+		goto err_wq_kill;
 	}
 
 	/* allocate and initialize channels */
@@ -1392,9 +1393,9 @@ static int bam_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&bdev->common);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
-		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+		cancel_work_sync(&bdev->channels[i].vc.work);
+err_wq_kill:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1418,7 +1419,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
-		tasklet_kill(&bdev->channels[i].vc.task);
+		cancel_work_sync(&bdev->channels[i].vc.work);
 
 		if (!bdev->channels[i].fifo_virt)
 			continue;
@@ -1428,7 +1429,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 
diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 94f3648f7483..3de9fcd2adad 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -515,7 +515,7 @@ struct gpii {
 	enum gpi_pm_state pm_state;
 	rwlock_t pm_lock;
 	struct gpi_ring ev_ring;
-	struct tasklet_struct ev_task; /* event processing tasklet */
+	struct work_struct ev_work; /* event processing work */
 	struct completion cmd_completion;
 	enum gpi_cmd gpi_cmd;
 	u32 cntxt_type_irq_msk;
@@ -755,7 +755,7 @@ static void gpi_process_ieob(struct gpii *gpii)
 	gpi_write_reg(gpii, gpii->ieob_clr_reg, BIT(0));
 
 	gpi_config_interrupts(gpii, MASK_IEOB_SETTINGS, 0);
-	tasklet_hi_schedule(&gpii->ev_task);
+	schedule_work(&gpii->ev_work);
 }
 
 /* process channel control interrupt */
@@ -1145,10 +1145,11 @@ static void gpi_process_events(struct gpii *gpii)
 	} while (rp != ev_ring->rp);
 }
 
-/* processing events using tasklet */
-static void gpi_ev_tasklet(unsigned long data)
+/* processing events using workqueue */
+static void gpi_ev_work(struct work_struct *work)
 {
-	struct gpii *gpii = (struct gpii *)data;
+	struct gpii *gpii =
+		container_of(work, struct gpii, ev_work);
 
 	read_lock_bh(&gpii->pm_lock);
 	if (!REG_ACCESS_VALID(gpii->pm_state)) {
@@ -1565,7 +1566,7 @@ static int gpi_pause(struct dma_chan *chan)
 	disable_irq(gpii->irq);
 
 	/* Wait for threads to complete out */
-	tasklet_kill(&gpii->ev_task);
+	cancel_work_sync(&gpii->ev_work);
 
 	write_lock_irq(&gpii->pm_lock);
 	gpii->pm_state = PAUSE_STATE;
@@ -2014,7 +2015,7 @@ static void gpi_free_chan_resources(struct dma_chan *chan)
 	write_unlock_irq(&gpii->pm_lock);
 
 	/* wait for threads to complete out */
-	tasklet_kill(&gpii->ev_task);
+	cancel_work_sync(&gpii->ev_work);
 
 	/* send command to de allocate event ring */
 	if (cur_state == ACTIVE_STATE)
@@ -2230,8 +2231,7 @@ static int gpi_probe(struct platform_device *pdev)
 		}
 		mutex_init(&gpii->ctrl_lock);
 		rwlock_init(&gpii->pm_lock);
-		tasklet_init(&gpii->ev_task, gpi_ev_tasklet,
-			     (unsigned long)gpii);
+		INIT_WORK(&gpii->ev_work, gpi_ev_work);
 		init_completion(&gpii->cmd_completion);
 		gpii->gpii_id = i;
 		gpii->regs = gpi_dev->ee_base;
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 51587cf8196b..884b82394ec6 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -218,9 +218,10 @@ static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
 	return 0;
 }
 
-static void hidma_issue_task(struct tasklet_struct *t)
+static void hidma_issue_work(struct work_struct *work)
 {
-	struct hidma_dev *dmadev = from_tasklet(dmadev, t, task);
+	struct hidma_dev *dmadev =
+	       container_of(work, struct hidma_dev, work);
 
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	hidma_ll_start(dmadev->lldev);
@@ -251,7 +252,7 @@ static void hidma_issue_pending(struct dma_chan *dmach)
 	/* PM will be released in hidma_callback function. */
 	status = pm_runtime_get(dmadev->ddev.dev);
 	if (status < 0)
-		tasklet_schedule(&dmadev->task);
+		schedule_work(&dmadev->work);
 	else
 		hidma_ll_start(dmadev->lldev);
 }
@@ -871,7 +872,7 @@ static int hidma_probe(struct platform_device *pdev)
 		goto uninit;
 
 	dmadev->irq = chirq;
-	tasklet_setup(&dmadev->task, hidma_issue_task);
+	INIT_WORK(&dmadev->work, hidma_issue_work);
 	hidma_debug_init(dmadev);
 	hidma_sysfs_init(dmadev);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
@@ -918,7 +919,7 @@ static int hidma_remove(struct platform_device *pdev)
 	else
 		hidma_free_msis(dmadev);
 
-	tasklet_kill(&dmadev->task);
+	cancel_work_sync(&dmadev->work);
 	hidma_sysfs_uninit(dmadev);
 	hidma_debug_uninit(dmadev);
 	hidma_ll_uninit(dmadev->lldev);
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index f212466744f3..8cd0b44b67d2 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -69,7 +69,7 @@ struct hidma_lldev {
 	u32 evre_processed_off;		/* last processed EVRE		   */
 
 	u32 tre_write_offset;           /* TRE write location              */
-	struct tasklet_struct task;	/* task delivering notifications   */
+	struct work_struct work;	/* work delivering notifications   */
 	DECLARE_KFIFO_PTR(handoff_fifo,
 		struct hidma_tre *);    /* pending TREs FIFO               */
 };
@@ -128,8 +128,8 @@ struct hidma_dev {
 	/* sysfs entry for the channel id */
 	struct device_attribute		*chid_attrs;
 
-	/* Task delivering issue_pending */
-	struct tasklet_struct		task;
+	/* Workqueue delivering issue_pending */
+	struct work_struct		work;
 };
 
 int hidma_ll_request(struct hidma_lldev *llhndl, u32 dev_id,
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 53244e0e34a3..25d241cadca4 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -173,9 +173,10 @@ int hidma_ll_request(struct hidma_lldev *lldev, u32 sig, const char *dev_name,
 /*
  * Multiple TREs may be queued and waiting in the pending queue.
  */
-static void hidma_ll_tre_complete(struct tasklet_struct *t)
+static void hidma_ll_tre_complete(struct work_struct *work)
 {
-	struct hidma_lldev *lldev = from_tasklet(lldev, t, task);
+	struct hidma_lldev *lldev =
+		container_of(work, struct hidma_lldev, work);
 	struct hidma_tre *tre;
 
 	while (kfifo_out(&lldev->handoff_fifo, &tre, 1)) {
@@ -223,7 +224,7 @@ static int hidma_post_completed(struct hidma_lldev *lldev, u8 err_info,
 	tre->queued = 0;
 
 	kfifo_put(&lldev->handoff_fifo, tre);
-	tasklet_schedule(&lldev->task);
+	schedule_work(&lldev->work);
 
 	return 0;
 }
@@ -792,7 +793,7 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 		return NULL;
 
 	spin_lock_init(&lldev->lock);
-	tasklet_setup(&lldev->task, hidma_ll_tre_complete);
+	INIT_WORK(&lldev->work, hidma_ll_tre_complete);
 	lldev->initialized = 1;
 	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
 	return lldev;
@@ -813,7 +814,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
 	lldev->initialized = 0;
 
 	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
-	tasklet_kill(&lldev->task);
+	cancel_work_sync(&lldev->work);
 	memset(lldev->trepool, 0, required_bytes);
 	lldev->trepool = NULL;
 	atomic_set(&lldev->pending_tre_count, 0);
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index facdacf8aede..f32484f296af 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -913,7 +913,7 @@ static int adm_dma_remove(struct platform_device *pdev)
 		/* mask IRQs for this channel/EE pair */
 		writel(0, adev->regs + ADM_CH_RSLT_CONF(achan->id, adev->ee));
 
-		tasklet_kill(&adev->channels[i].vc.task);
+		cancel_work_sync(&adev->channels[i].vc.work);
 		adm_terminate_all(&adev->channels[i].vc.chan);
 	}
 
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..0d2d1416fb08 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1137,7 +1137,7 @@ static void s3c24xx_dma_free_virtual_channels(struct dma_device *dmadev)
 	list_for_each_entry_safe(chan,
 				 next, &dmadev->channels, vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
-		tasklet_kill(&chan->vc.task);
+		cancel_work_sync(&chan->vc.work);
 	}
 }
 
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index a29c13cae716..4a4fcf4ec66b 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -118,7 +118,7 @@ struct sa11x0_dma_dev {
 	struct dma_device	slave;
 	void __iomem		*base;
 	spinlock_t		lock;
-	struct tasklet_struct	task;
+	struct work_struct	work;
 	struct list_head	chan_pending;
 	struct sa11x0_dma_phy	phy[NR_PHY_CHAN];
 };
@@ -232,7 +232,7 @@ static void noinline sa11x0_dma_complete(struct sa11x0_dma_phy *p,
 			p->txd_done = p->txd_load;
 
 			if (!p->txd_done)
-				tasklet_schedule(&p->dev->task);
+				schedule_work(&p->dev->work);
 		} else {
 			if ((p->sg_done % txd->period) == 0)
 				vchan_cyclic_callback(&txd->vd);
@@ -323,14 +323,15 @@ static void sa11x0_dma_start_txd(struct sa11x0_dma_chan *c)
 	}
 }
 
-static void sa11x0_dma_tasklet(struct tasklet_struct *t)
+static void sa11x0_dma_work(struct work_struct *work)
 {
-	struct sa11x0_dma_dev *d = from_tasklet(d, t, task);
+	struct sa11x0_dma_dev *d =
+		container_of(work, struct sa11x0_dma_dev, work);
 	struct sa11x0_dma_phy *p;
 	struct sa11x0_dma_chan *c;
 	unsigned pch, pch_alloc = 0;
 
-	dev_dbg(d->slave.dev, "tasklet enter\n");
+	dev_dbg(d->slave.dev, "Workqueue enter\n");
 
 	list_for_each_entry(c, &d->slave.channels, vc.chan.device_node) {
 		spin_lock_irq(&c->vc.lock);
@@ -381,7 +382,7 @@ static void sa11x0_dma_tasklet(struct tasklet_struct *t)
 		}
 	}
 
-	dev_dbg(d->slave.dev, "tasklet exit\n");
+	dev_dbg(d->slave.dev, "Workqueue exit\n");
 }
 
 
@@ -495,7 +496,7 @@ static enum dma_status sa11x0_dma_tx_status(struct dma_chan *chan,
 /*
  * Move pending txds to the issued list, and re-init pending list.
  * If not already pending, add this channel to the list of pending
- * channels and trigger the tasklet to run.
+ * channels and trigger the workqueue to run.
  */
 static void sa11x0_dma_issue_pending(struct dma_chan *chan)
 {
@@ -509,7 +510,7 @@ static void sa11x0_dma_issue_pending(struct dma_chan *chan)
 			spin_lock(&d->lock);
 			if (list_empty(&c->node)) {
 				list_add_tail(&c->node, &d->chan_pending);
-				tasklet_schedule(&d->task);
+				schedule_work(&d->work);
 				dev_dbg(d->slave.dev, "vchan %p: issued\n", &c->vc);
 			}
 			spin_unlock(&d->lock);
@@ -784,7 +785,7 @@ static int sa11x0_dma_device_terminate_all(struct dma_chan *chan)
 		spin_lock(&d->lock);
 		p->vchan = NULL;
 		spin_unlock(&d->lock);
-		tasklet_schedule(&d->task);
+		schedule_work(&d->work);
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 	vchan_dma_desc_free_list(&c->vc, &head);
@@ -893,7 +894,7 @@ static void sa11x0_dma_free_channels(struct dma_device *dmadev)
 
 	list_for_each_entry_safe(c, cn, &dmadev->channels, vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 		kfree(c);
 	}
 }
@@ -928,7 +929,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	tasklet_setup(&d->task, sa11x0_dma_tasklet);
+	INIT_WORK(&d->work, sa11x0_dma_work);
 
 	for (i = 0; i < NR_PHY_CHAN; i++) {
 		struct sa11x0_dma_phy *p = &d->phy[i];
@@ -976,7 +977,7 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < NR_PHY_CHAN; i++)
 		sa11x0_dma_free_irq(pdev, i, &d->phy[i]);
  err_irq:
-	tasklet_kill(&d->task);
+	cancel_work_sync(&d->work);
 	iounmap(d->base);
  err_ioremap:
 	kfree(d);
@@ -994,7 +995,7 @@ static int sa11x0_dma_remove(struct platform_device *pdev)
 	sa11x0_dma_free_channels(&d->slave);
 	for (pch = 0; pch < NR_PHY_CHAN; pch++)
 		sa11x0_dma_free_irq(pdev, pch, &d->phy[pch]);
-	tasklet_kill(&d->task);
+	cancel_work_sync(&d->work);
 	iounmap(d->base);
 	kfree(d);
 
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..11af8cecbc50 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -282,9 +282,10 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 	desc->in_use = false;
 }
 
-static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
+static void sf_pdma_donebh_work(struct work_struct *work)
 {
-	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
+	struct sf_pdma_chan *chan =
+		container_of(work, struct sf_pdma_chan, done_wq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
@@ -301,9 +302,10 @@ static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
-static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
+static void sf_pdma_errbh_work(struct work_struct *work)
 {
-	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
+	struct sf_pdma_chan *chan =
+		container_of(work, struct sf_pdma_chan, err_wq);
 	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
@@ -334,7 +336,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 	residue = readq(regs->residue);
 
 	if (!residue) {
-		tasklet_hi_schedule(&chan->done_tasklet);
+		schedule_work(&chan->done_wq);
 	} else {
 		/* submit next trascatioin if possible */
 		struct sf_pdma_desc *desc = chan->desc;
@@ -360,7 +362,7 @@ static irqreturn_t sf_pdma_err_isr(int irq, void *dev_id)
 	writel((readl(regs->ctrl)) & ~PDMA_ERR_STATUS_MASK, regs->ctrl);
 	spin_unlock(&chan->lock);
 
-	tasklet_schedule(&chan->err_tasklet);
+	schedule_work(&chan->err_wq);
 
 	return IRQ_HANDLED;
 }
@@ -474,8 +476,8 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 
 		writel(PDMA_CLEAR_CTRL, chan->regs.ctrl);
 
-		tasklet_setup(&chan->done_tasklet, sf_pdma_donebh_tasklet);
-		tasklet_setup(&chan->err_tasklet, sf_pdma_errbh_tasklet);
+		INIT_WORK(&chan->done_wq, sf_pdma_donebh_work);
+		INIT_WORK(&chan->err_wq, sf_pdma_errbh_work);
 	}
 }
 
@@ -562,9 +564,9 @@ static int sf_pdma_remove(struct platform_device *pdev)
 		devm_free_irq(&pdev->dev, ch->txirq, ch);
 		devm_free_irq(&pdev->dev, ch->errirq, ch);
 		list_del(&ch->vchan.chan.device_node);
-		tasklet_kill(&ch->vchan.task);
-		tasklet_kill(&ch->done_tasklet);
-		tasklet_kill(&ch->err_tasklet);
+		cancel_work_sync(&ch->vchan.work);
+		cancel_work_sync(&ch->done_wq);
+		cancel_work_sync(&ch->err_wq);
 	}
 
 	dma_async_device_unregister(&pdma->dma_dev);
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 0c20167b097d..af49c8c916dd 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -103,8 +103,8 @@ struct sf_pdma_chan {
 	u32				attr;
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
-	struct tasklet_struct		done_tasklet;
-	struct tasklet_struct		err_tasklet;
+	struct work_struct		done_wq;
+	struct work_struct		err_wq;
 	struct pdma_regs		regs;
 	spinlock_t			lock; /* protect chan data */
 	bool				xfer_err;
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 7f158ef5672d..ce655a31bbfe 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1246,7 +1246,7 @@ static int sprd_dma_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(c, cn, &sdev->dma_dev.channels,
 				 vc.chan.device_node) {
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 	}
 
 	of_dma_controller_free(pdev->dev.of_node);
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d95c421877fb..9bae104ca414 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -732,7 +732,7 @@ static void st_fdma_free(struct st_fdma_dev *fdev)
 	for (i = 0; i < fdev->nr_channels; i++) {
 		fchan = &fdev->chans[i];
 		list_del(&fchan->vchan.chan.device_node);
-		tasklet_kill(&fchan->vchan.task);
+		cancel_work_sync(&fchan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e1827393143f..57601ce66b1f 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -429,12 +429,12 @@ struct d40_base;
  * @lock: A spinlock to protect this struct.
  * @log_num: The logical number, if any of this channel.
  * @pending_tx: The number of pending transfers. Used between interrupt handler
- * and tasklet.
+ * and workqueue.
  * @busy: Set to true when transfer is ongoing on this channel.
  * @phy_chan: Pointer to physical channel which this instance runs on. If this
  * point is NULL, then the channel is not allocated.
  * @chan: DMA engine handle.
- * @tasklet: Tasklet that gets scheduled from interrupt context to complete a
+ * @work: Workqueue that gets scheduled from interrupt context to complete a
  * transfer and call client callback.
  * @client: Cliented owned descriptor list.
  * @pending_queue: Submitted jobs, to be issued by issue_pending()
@@ -462,7 +462,7 @@ struct d40_chan {
 	bool				 busy;
 	struct d40_phy_res		*phy_chan;
 	struct dma_chan			 chan;
-	struct tasklet_struct		 tasklet;
+	struct work_struct		 work;
 	struct list_head		 client;
 	struct list_head		 pending_queue;
 	struct list_head		 active;
@@ -1567,13 +1567,14 @@ static void dma_tc_handle(struct d40_chan *d40c)
 	}
 
 	d40c->pending_tx++;
-	tasklet_schedule(&d40c->tasklet);
+	schedule_work(&d40c->work);
 
 }
 
-static void dma_tasklet(struct tasklet_struct *t)
+static void dma_work(struct work_struct *work)
 {
-	struct d40_chan *d40c = from_tasklet(d40c, t, tasklet);
+	struct d40_chan *d40c =
+		container_of(work, struct d40_chan, work);
 	struct d40_desc *d40d;
 	unsigned long flags;
 	bool callback_active;
@@ -1621,7 +1622,7 @@ static void dma_tasklet(struct tasklet_struct *t)
 	d40c->pending_tx--;
 
 	if (d40c->pending_tx)
-		tasklet_schedule(&d40c->tasklet);
+		schedule_work(&d40c->work);
 
 	spin_unlock_irqrestore(&d40c->lock, flags);
 
@@ -2803,7 +2804,7 @@ static void __init d40_chan_init(struct d40_base *base, struct dma_device *dma,
 		INIT_LIST_HEAD(&d40c->client);
 		INIT_LIST_HEAD(&d40c->prepare_queue);
 
-		tasklet_setup(&d40c->tasklet, dma_tasklet);
+		INIT_WORK(&d40c->work, dma_work);
 
 		list_add_tail(&d40c->chan.device_node,
 			      &dma->channels);
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5cadd4d2b824..6fe513da0792 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -190,8 +190,8 @@ struct sun6i_dma_dev {
 	int			irq;
 	spinlock_t		lock;
 	struct reset_control	*rstc;
-	struct tasklet_struct	task;
-	atomic_t		tasklet_shutdown;
+	struct work_struct	work;
+	atomic_t		wq_shutdown;
 	struct list_head	pending;
 	struct dma_pool		*pool;
 	struct sun6i_pchan	*pchans;
@@ -467,9 +467,10 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 	return 0;
 }
 
-static void sun6i_dma_tasklet(struct tasklet_struct *t)
+static void sun6i_dma_work(struct work_struct *work)
 {
-	struct sun6i_dma_dev *sdev = from_tasklet(sdev, t, task);
+	struct sun6i_dma_dev *sdev =
+		container_of(work, struct sun6i_dma_dev, work);
 	struct sun6i_vchan *vchan;
 	struct sun6i_pchan *pchan;
 	unsigned int pchan_alloc = 0;
@@ -567,8 +568,8 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 			status = status >> DMA_IRQ_CHAN_WIDTH;
 		}
 
-		if (!atomic_read(&sdev->tasklet_shutdown))
-			tasklet_schedule(&sdev->task);
+		if (!atomic_read(&sdev->wq_shutdown))
+			schedule_work(&sdev->work);
 		ret = IRQ_HANDLED;
 	}
 
@@ -975,7 +976,7 @@ static void sun6i_dma_issue_pending(struct dma_chan *chan)
 
 		if (!vchan->phy && list_empty(&vchan->node)) {
 			list_add_tail(&vchan->node, &sdev->pending);
-			tasklet_schedule(&sdev->task);
+			schedule_work(&sdev->work);
 			dev_dbg(chan2dev(chan), "vchan %p: issued\n",
 				&vchan->vc);
 		}
@@ -1023,20 +1024,20 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
-static inline void sun6i_kill_tasklet(struct sun6i_dma_dev *sdev)
+static inline void sun6i_kill_work(struct sun6i_dma_dev *sdev)
 {
 	/* Disable all interrupts from DMA */
 	writel(0, sdev->base + DMA_IRQ_EN(0));
 	writel(0, sdev->base + DMA_IRQ_EN(1));
 
-	/* Prevent spurious interrupts from scheduling the tasklet */
-	atomic_inc(&sdev->tasklet_shutdown);
+	/* Prevent spurious interrupts from scheduling the workqueue */
+	atomic_inc(&sdev->wq_shutdown);
 
 	/* Make sure we won't have any further interrupts */
 	devm_free_irq(sdev->slave.dev, sdev->irq, sdev);
 
-	/* Actually prevent the tasklet from being scheduled */
-	tasklet_kill(&sdev->task);
+	/* Actually prevent the workqueue from being scheduled */
+	cancel_work_sync(&sdev->work);
 }
 
 static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
@@ -1047,7 +1048,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
-		tasklet_kill(&vchan->vc.task);
+		cancel_work_sync(&vchan->vc.work);
 	}
 }
 
@@ -1368,7 +1369,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	if (!sdc->vchans)
 		return -ENOMEM;
 
-	tasklet_setup(&sdc->task, sun6i_dma_tasklet);
+	INIT_WORK(&sdc->work, sun6i_dma_work);
 
 	for (i = 0; i < sdc->num_pchans; i++) {
 		struct sun6i_pchan *pchan = &sdc->pchans[i];
@@ -1433,7 +1434,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 err_dma_unregister:
 	dma_async_device_unregister(&sdc->slave);
 err_irq_disable:
-	sun6i_kill_tasklet(sdc);
+	sun6i_kill_work(sdc);
 err_mbus_clk_disable:
 	clk_disable_unprepare(sdc->clk_mbus);
 err_clk_disable:
@@ -1452,7 +1453,7 @@ static int sun6i_dma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&sdc->slave);
 
-	sun6i_kill_tasklet(sdc);
+	sun6i_kill_work(sdc);
 
 	clk_disable_unprepare(sdc->clk_mbus);
 	clk_disable_unprepare(sdc->clk);
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index eaafcbe4ca94..10a4bced6196 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -195,9 +195,9 @@ struct tegra_dma_channel {
 	struct list_head	free_dma_desc;
 	struct list_head	cb_desc;
 
-	/* ISR handler and tasklet for bottom half of isr handling */
+	/* ISR handler and workqueue for bottom half of isr handling */
 	dma_isr_handler		isr_handler;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 
 	/* Channel-slave specific configuration */
 	unsigned int slave_id;
@@ -638,9 +638,10 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 	}
 }
 
-static void tegra_dma_tasklet(struct tasklet_struct *t)
+static void tegra_dma_work(struct work_struct *work)
 {
-	struct tegra_dma_channel *tdc = from_tasklet(tdc, t, tasklet);
+	struct tegra_dma_channel *tdc =
+		container_of(work, struct tegra_dma_channel, work);
 	struct dmaengine_desc_callback cb;
 	struct tegra_dma_desc *dma_desc;
 	unsigned int cb_count;
@@ -676,7 +677,7 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
 	if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
 		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
 		tdc->isr_handler(tdc, false);
-		tasklet_schedule(&tdc->tasklet);
+		schedule_work(&tdc->work);
 		wake_up_all(&tdc->wq);
 		spin_unlock(&tdc->lock);
 		return IRQ_HANDLED;
@@ -825,7 +826,7 @@ static void tegra_dma_synchronize(struct dma_chan *dc)
 	 */
 	wait_event(tdc->wq, tegra_dma_eoc_interrupt_deasserted(tdc));
 
-	tasklet_kill(&tdc->tasklet);
+	cancel_work_sync(&tdc->work);
 
 	pm_runtime_put(tdc->tdma->dev);
 }
@@ -1323,7 +1324,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
 	tegra_dma_terminate_all(dc);
-	tasklet_kill(&tdc->tasklet);
+	cancel_work_sync(&tdc->work);
 
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
 	list_splice_init(&tdc->free_sg_req, &sg_req_list);
@@ -1517,7 +1518,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdc->id = i;
 		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 
-		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
+		INIT_WORK(&tdc->work, tegra_dma_work);
 		spin_lock_init(&tdc->lock);
 		init_waitqueue_head(&tdc->wq);
 
@@ -1625,7 +1626,7 @@ static int __maybe_unused tegra_dma_dev_suspend(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
-		tasklet_kill(&tdc->tasklet);
+		cancel_work_sync(&tdc->work);
 
 		spin_lock_irqsave(&tdc->lock, flags);
 		busy = tdc->busy;
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ae39b52012b2..935150142329 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -691,7 +691,7 @@ static void tegra_adma_free_chan_resources(struct dma_chan *dc)
 
 	tegra_adma_terminate_all(dc);
 	vchan_free_chan_resources(&tdc->vc);
-	tasklet_kill(&tdc->vc.task);
+	cancel_work_sync(&tdc->vc.work);
 	free_irq(tdc->irq, tdc);
 	pm_runtime_put(tdc2dev(tdc));
 
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ea8ef7f57df..8b517bd3968d 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2603,7 +2603,7 @@ static void edma_cleanupp_vchan(struct dma_device *dmadev)
 	list_for_each_entry_safe(echan, _echan,
 			&dmadev->channels, vchan.chan.device_node) {
 		list_del(&echan->vchan.chan.device_node);
-		tasklet_kill(&echan->vchan.task);
+		cancel_work_sync(&echan->vchan.work);
 	}
 }
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2f0d2c68c93c..6da9d57143e4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3974,12 +3974,13 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 }
 
 /*
- * This tasklet handles the completion of a DMA descriptor by
+ * This workqueue handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void udma_vchan_complete(struct tasklet_struct *t)
+static void udma_vchan_complete(struct work_struct *work)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc =
+		container_of(work, struct virt_dma_chan, work);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -4044,7 +4045,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	vchan_free_chan_resources(&uc->vc);
-	tasklet_kill(&uc->vc.task);
+	cancel_work_sync(&uc->vc.task);
 
 	bcdma_free_bchan_resources(uc);
 	udma_free_tx_resources(uc);
@@ -5461,7 +5462,7 @@ static int udma_probe(struct platform_device *pdev)
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-		tasklet_setup(&uc->vc.task, udma_vchan_complete);
+		INIT_WORK(&uc->vc.work, udma_vchan_complete);
 		init_completion(&uc->teardown_completed);
 		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 8e52a0dc1f78..44638426bd2a 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1517,7 +1517,7 @@ static void omap_dma_free(struct omap_dmadev *od)
 			struct omap_chan, vc.chan.device_node);
 
 		list_del(&c->vc.chan.device_node);
-		tasklet_kill(&c->vc.task);
+		cancel_work_sync(&c->vc.work);
 		kfree(c);
 	}
 }
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 3f524be69efb..a57e20fcdcad 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -72,7 +72,7 @@ struct timb_dma_chan {
 	void __iomem		*membase;
 	spinlock_t		lock; /* Used to protect data structures,
 					especially the lists and descriptors,
-					from races between the tasklet and calls
+					from races between the workqueue and calls
 					from above */
 	bool			ongoing;
 	struct list_head	active_list;
@@ -87,7 +87,7 @@ struct timb_dma_chan {
 struct timb_dma {
 	struct dma_device	dma;
 	void __iomem		*membase;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	struct timb_dma_chan	channels[];
 };
 
@@ -563,9 +563,10 @@ static int td_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void td_tasklet(struct tasklet_struct *t)
+static void td_work(struct work_struct *work)
 {
-	struct timb_dma *td = from_tasklet(td, t, tasklet);
+	struct timb_dma *td =
+		container_of(work, struct timb_dma, work);
 	u32 isr;
 	u32 ipr;
 	u32 ier;
@@ -598,10 +599,10 @@ static irqreturn_t td_irq(int irq, void *devid)
 	u32 ipr = ioread32(td->membase + TIMBDMA_IPR);
 
 	if (ipr) {
-		/* disable interrupts, will be re-enabled in tasklet */
+		/* disable interrupts, will be re-enabled in workqueue */
 		iowrite32(0, td->membase + TIMBDMA_IER);
 
-		tasklet_schedule(&td->tasklet);
+		schedule_work(&td->work);
 
 		return IRQ_HANDLED;
 	} else
@@ -658,12 +659,12 @@ static int td_probe(struct platform_device *pdev)
 	iowrite32(0x0, td->membase + TIMBDMA_IER);
 	iowrite32(0xFFFFFFFF, td->membase + TIMBDMA_ISR);
 
-	tasklet_setup(&td->tasklet, td_tasklet);
+	INIT_WORK(&td->work, td_work);
 
 	err = request_irq(irq, td_irq, IRQF_SHARED, DRIVER_NAME, td);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to request IRQ\n");
-		goto err_tasklet_kill;
+		goto err_cancel_work;
 	}
 
 	td->dma.device_alloc_chan_resources	= td_alloc_chan_resources;
@@ -728,8 +729,8 @@ static int td_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(irq, td);
-err_tasklet_kill:
-	tasklet_kill(&td->tasklet);
+err_cancel_work:
+	cancel_work_sync(&td->work);
 	iounmap(td->membase);
 err_free_mem:
 	kfree(td);
@@ -748,7 +749,7 @@ static int td_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&td->dma);
 	free_irq(irq, td);
-	tasklet_kill(&td->tasklet);
+	cancel_work_sync(&td->work);
 	iounmap(td->membase);
 	kfree(td);
 	release_mem_region(iomem->start, resource_size(iomem));
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 5b6b375a257e..6d02d5b9884c 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -340,7 +340,6 @@ static void txx9dmac_dostart(struct txx9dmac_chan *dc,
 		dev_err(chan2dev(&dc->chan),
 			"BUG: Attempted to start non-idle channel\n");
 		txx9dmac_dump_regs(dc);
-		/* The tasklet will hopefully advance the queue... */
 		return;
 	}
 
@@ -601,15 +600,15 @@ static void txx9dmac_scan_descriptors(struct txx9dmac_chan *dc)
 	}
 }
 
-static void txx9dmac_chan_tasklet(struct tasklet_struct *t)
+static void txx9dmac_chan_work(struct work_struct *work)
 {
 	int irq;
 	u32 csr;
-	struct txx9dmac_chan *dc;
+	struct txx9dmac_chan *dc =
+		container_of(work, struct txx9dmac, work);
 
-	dc = from_tasklet(dc, t, tasklet);
 	csr = channel_readl(dc, CSR);
-	dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n", csr);
+	dev_vdbg(chan2dev(&dc->chan), "workqueue: status=%x\n", csr);
 
 	spin_lock(&dc->lock);
 	if (csr & (TXX9_DMA_CSR_ABCHC | TXX9_DMA_CSR_NCHNC |
@@ -628,7 +627,7 @@ static irqreturn_t txx9dmac_chan_interrupt(int irq, void *dev_id)
 	dev_vdbg(chan2dev(&dc->chan), "interrupt: status=%#x\n",
 			channel_readl(dc, CSR));
 
-	tasklet_schedule(&dc->tasklet);
+	schedule_work(&dc->work);
 	/*
 	 * Just disable the interrupts. We'll turn them back on in the
 	 * softirq handler.
@@ -638,23 +637,24 @@ static irqreturn_t txx9dmac_chan_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void txx9dmac_tasklet(struct tasklet_struct *t)
+static void txx9dmac_work(struct work_struct *work)
 {
 	int irq;
 	u32 csr;
 	struct txx9dmac_chan *dc;
 
-	struct txx9dmac_dev *ddev = from_tasklet(ddev, t, tasklet);
+	struct txx9dmac_dev *ddev =
+		container_of(work, struct txx9dmac_dev, work);
 	u32 mcr;
 	int i;
 
 	mcr = dma_readl(ddev, MCR);
-	dev_vdbg(ddev->chan[0]->dma.dev, "tasklet: mcr=%x\n", mcr);
+	dev_vdbg(ddev->chan[0]->dma.dev, "workqueue: mcr=%x\n", mcr);
 	for (i = 0; i < TXX9_DMA_MAX_NR_CHANNELS; i++) {
 		if ((mcr >> (24 + i)) & 0x11) {
 			dc = ddev->chan[i];
 			csr = channel_readl(dc, CSR);
-			dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n",
+			dev_vdbg(chan2dev(&dc->chan), "workqueue: status=%x\n",
 				 csr);
 			spin_lock(&dc->lock);
 			if (csr & (TXX9_DMA_CSR_ABCHC | TXX9_DMA_CSR_NCHNC |
@@ -675,7 +675,7 @@ static irqreturn_t txx9dmac_interrupt(int irq, void *dev_id)
 	dev_vdbg(ddev->chan[0]->dma.dev, "interrupt: status=%#x\n",
 			dma_readl(ddev, MCR));
 
-	tasklet_schedule(&ddev->tasklet);
+	schedule_work(&ddev->work);
 	/*
 	 * Just disable the interrupts. We'll turn them back on in the
 	 * softirq handler.
@@ -1113,7 +1113,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0)
 			return irq;
-		tasklet_setup(&dc->tasklet, txx9dmac_chan_tasklet);
+		INIT_WORK(&dc->work, txx9dmac_chan_work);
 		dc->irq = irq;
 		err = devm_request_irq(&pdev->dev, dc->irq,
 			txx9dmac_chan_interrupt, 0, dev_name(&pdev->dev), dc);
@@ -1159,7 +1159,7 @@ static int txx9dmac_chan_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&dc->dma);
 	if (dc->irq >= 0) {
 		devm_free_irq(&pdev->dev, dc->irq, dc);
-		tasklet_kill(&dc->tasklet);
+		cancel_work_sync(&dc->work);
 	}
 	dc->ddev->chan[pdev->id % TXX9_DMA_MAX_NR_CHANNELS] = NULL;
 	return 0;
@@ -1199,7 +1199,7 @@ static int __init txx9dmac_probe(struct platform_device *pdev)
 
 	ddev->irq = platform_get_irq(pdev, 0);
 	if (ddev->irq >= 0) {
-		tasklet_setup(&ddev->tasklet, txx9dmac_tasklet);
+		INIT_WORK(&ddev->work, txx9dmac_work);
 		err = devm_request_irq(&pdev->dev, ddev->irq,
 			txx9dmac_interrupt, 0, dev_name(&pdev->dev), ddev);
 		if (err)
@@ -1222,7 +1222,7 @@ static int txx9dmac_remove(struct platform_device *pdev)
 	txx9dmac_off(ddev);
 	if (ddev->irq >= 0) {
 		devm_free_irq(&pdev->dev, ddev->irq, ddev);
-		tasklet_kill(&ddev->tasklet);
+		cancel_work_sync(&ddev->work);
 	}
 	return 0;
 }
diff --git a/drivers/dma/txx9dmac.h b/drivers/dma/txx9dmac.h
index aa53eafb1519..95644372ac2d 100644
--- a/drivers/dma/txx9dmac.h
+++ b/drivers/dma/txx9dmac.h
@@ -162,7 +162,7 @@ struct txx9dmac_chan {
 	struct dma_device	dma;
 	struct txx9dmac_dev	*ddev;
 	void __iomem		*ch_regs;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	int			irq;
 	u32			ccr;
 
@@ -178,7 +178,7 @@ struct txx9dmac_chan {
 
 struct txx9dmac_dev {
 	void __iomem		*regs;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	int			irq;
 	struct txx9dmac_chan	*chan[TXX9_DMA_MAX_NR_CHANNELS];
 	bool			have_64bit_regs;
diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index a6f4265be0c9..0e2e39a2e1f8 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -77,12 +77,13 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *vc,
 EXPORT_SYMBOL_GPL(vchan_find_desc);
 
 /*
- * This tasklet handles the completion of a DMA descriptor by
+ * This workqueue handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void vchan_complete(struct tasklet_struct *t)
+static void vchan_complete(struct work_struct *work)
 {
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_chan *vc =
+		container_of(work, struct virt_dma_chan, work);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -131,7 +132,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_completed);
 	INIT_LIST_HEAD(&vc->desc_terminated);
 
-	tasklet_setup(&vc->task, vchan_complete);
+	INIT_WORK(&vc->work, vchan_complete);
 
 	vc->chan.device = dmadev;
 	list_add_tail(&vc->chan.device_node, &dmadev->channels);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index e9f5250fbe4d..cb4550335e99 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -21,7 +21,7 @@ struct virt_dma_desc {
 
 struct virt_dma_chan {
 	struct dma_chan	chan;
-	struct tasklet_struct task;
+	struct work_struct work;
 	void (*desc_free)(struct virt_dma_desc *);
 
 	spinlock_t lock;
@@ -102,7 +102,7 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 		 vd, cookie);
 	list_add_tail(&vd->node, &vc->desc_completed);
 
-	tasklet_schedule(&vc->task);
+	schedule_work(&vc->work);
 }
 
 /**
@@ -133,7 +133,7 @@ static inline void vchan_cyclic_callback(struct virt_dma_desc *vd)
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
 	vc->cyclic = vd;
-	tasklet_schedule(&vc->task);
+	schedule_work(&vc->work);
 }
 
 /**
@@ -213,7 +213,7 @@ static inline void vchan_synchronize(struct virt_dma_chan *vc)
 	LIST_HEAD(head);
 	unsigned long flags;
 
-	tasklet_kill(&vc->task);
+	cancel_work_sync(&vc->work);
 
 	spin_lock_irqsave(&vc->lock, flags);
 
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 3589b4ef50b8..9db5eb4d634a 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -260,7 +260,7 @@ struct xgene_dma_desc_sw {
  *	These descriptors have already had their cleanup actions run. They
  *	are waiting for the ACK bit to be set by the async tx API.
  * @desc_pool: descriptor pool for DMA operations
- * @tasklet: bottom half where all completed descriptors cleans
+ * @work: bottom half where all completed descriptors cleans
  * @tx_ring: transmit ring descriptor that we use to prepare actual
  *	descriptors for further executions
  * @rx_ring: receive ring descriptor that we use to get completed DMA
@@ -280,7 +280,7 @@ struct xgene_dma_chan {
 	struct list_head ld_running;
 	struct list_head ld_completed;
 	struct dma_pool *desc_pool;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	struct xgene_dma_ring tx_ring;
 	struct xgene_dma_ring rx_ring;
 };
@@ -975,9 +975,10 @@ static enum dma_status xgene_dma_tx_status(struct dma_chan *dchan,
 	return dma_cookie_status(dchan, cookie, txstate);
 }
 
-static void xgene_dma_tasklet_cb(struct tasklet_struct *t)
+static void xgene_dma_work_cb(struct work_struct *work)
 {
-	struct xgene_dma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct xgene_dma_chan *chan =
+		container_of(work, struct xgene_dma_chan, work);
 
 	/* Run all cleanup for descriptors which have been completed */
 	xgene_dma_cleanup_descriptors(chan);
@@ -999,11 +1000,11 @@ static irqreturn_t xgene_dma_chan_ring_isr(int irq, void *id)
 	disable_irq_nosync(chan->rx_irq);
 
 	/*
-	 * Schedule the tasklet to handle all cleanup of the current
+	 * Queue the work to handle all cleanup of the current
 	 * transaction. It will start a new transaction if there is
 	 * one pending.
 	 */
-	tasklet_schedule(&chan->tasklet);
+	schedule_work(&chan->work);
 
 	return IRQ_HANDLED;
 }
@@ -1539,7 +1540,7 @@ static int xgene_dma_async_register(struct xgene_dma *pdma, int id)
 	INIT_LIST_HEAD(&chan->ld_pending);
 	INIT_LIST_HEAD(&chan->ld_running);
 	INIT_LIST_HEAD(&chan->ld_completed);
-	tasklet_setup(&chan->tasklet, xgene_dma_tasklet_cb);
+	INIT_WORK(&chan->work, xgene_dma_work_cb);
 
 	chan->pending = 0;
 	chan->desc_pool = NULL;
@@ -1556,7 +1557,7 @@ static int xgene_dma_async_register(struct xgene_dma *pdma, int id)
 	ret = dma_async_device_register(dma_dev);
 	if (ret) {
 		chan_err(chan, "Failed to register async device %d", ret);
-		tasklet_kill(&chan->tasklet);
+		cancel_work_sync(&chan->work);
 
 		return ret;
 	}
@@ -1579,7 +1580,7 @@ static int xgene_dma_init_async(struct xgene_dma *pdma)
 		if (ret) {
 			for (j = 0; j < i; j++) {
 				dma_async_device_unregister(&pdma->dma_dev[j]);
-				tasklet_kill(&pdma->chan[j].tasklet);
+				cancel_work_sync(&pdma->chan[j].work);
 			}
 
 			return ret;
@@ -1790,7 +1791,7 @@ static int xgene_dma_remove(struct platform_device *pdev)
 
 	for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
 		chan = &pdma->chan[i];
-		tasklet_kill(&chan->tasklet);
+		cancel_work_sync(&chan->work);
 		xgene_dma_delete_chan_rings(chan);
 	}
 
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cd62bbb50e8b..63cd238798a5 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -395,7 +395,7 @@ struct xilinx_dma_tx_descriptor {
  * @err: Channel has errors
  * @idle: Check for channel idle
  * @terminating: Check for channel being synchronized by user
- * @tasklet: Cleanup work after irq
+ * @work: Cleanup work after irq
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
  * @desc_pendingcount: Descriptor pending count
@@ -433,7 +433,7 @@ struct xilinx_dma_chan {
 	bool err;
 	bool idle;
 	bool terminating;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
 	u32 desc_pendingcount;
@@ -1062,12 +1062,13 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 }
 
 /**
- * xilinx_dma_do_tasklet - Schedule completion tasklet
+ * xilinx_dma_do_work - Schedule workqueue
  * @t: Pointer to the Xilinx DMA channel structure
  */
-static void xilinx_dma_do_tasklet(struct tasklet_struct *t)
+static void xilinx_dma_do_work(struct work_struct *work)
 {
-	struct xilinx_dma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct xilinx_dma_chan *chan =
+		container_of(work, struct xilinx_dma_chan, work);
 
 	xilinx_dma_chan_desc_cleanup(chan);
 }
@@ -1814,7 +1815,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	schedule_work(&chan->work);
 	return IRQ_HANDLED;
 }
 
@@ -1878,7 +1879,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	schedule_work(&chan->work);
 	return IRQ_HANDLED;
 }
 
@@ -2597,7 +2598,7 @@ static void xilinx_dma_synchronize(struct dma_chan *dchan)
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
 
-	tasklet_kill(&chan->tasklet);
+	cancel_work_sync(&chan->work);
 }
 
 /**
@@ -2688,7 +2689,7 @@ static void xilinx_dma_chan_remove(struct xilinx_dma_chan *chan)
 	if (chan->irq > 0)
 		free_irq(chan->irq, chan);
 
-	tasklet_kill(&chan->tasklet);
+	cancel_work_sync(&chan->work);
 
 	list_del(&chan->common.device_node);
 }
@@ -3014,8 +3015,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 			chan->has_sg ? "enabled" : "disabled");
 	}
 
-	/* Initialize the tasklet */
-	tasklet_setup(&chan->tasklet, xilinx_dma_do_tasklet);
+	/* Initialize the workqueue */
+	INIT_WORK(&chan->work, xilinx_dma_do_work);
 
 	/*
 	 * Initialize the DMA channel and add it to the DMA engine channels
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b0f4948b00a5..b059387a6753 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -234,7 +234,7 @@ struct xilinx_dpdma_chan {
 
 	spinlock_t lock; /* lock to access struct xilinx_dpdma_chan */
 	struct dma_pool *desc_pool;
-	struct tasklet_struct err_task;
+	struct work_struct err_work;
 
 	struct {
 		struct xilinx_dpdma_tx_desc *pending;
@@ -1443,7 +1443,7 @@ static void xilinx_dpdma_handle_err_irq(struct xilinx_dpdma_device *xdev,
 
 	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
 		if (err || xilinx_dpdma_chan_err(xdev->chan[i], isr, eisr))
-			tasklet_schedule(&xdev->chan[i]->err_task);
+			schedule_work(&xdev->chan[i]->err_work);
 }
 
 /**
@@ -1471,16 +1471,17 @@ static void xilinx_dpdma_disable_irq(struct xilinx_dpdma_device *xdev)
 }
 
 /**
- * xilinx_dpdma_chan_err_task - Per channel tasklet for error handling
- * @t: pointer to the tasklet associated with this handler
+ * xilinx_dpdma_chan_err_work - Per channel workqueue for error handling
+ * @wq: pointer to the workqueue associated with this handler
  *
- * Per channel error handling tasklet. This function waits for the outstanding
+ * Per channel error handling workqueue. This function waits for the outstanding
  * transaction to complete and triggers error handling. After error handling,
  * re-enable channel error interrupts, and restart the channel if needed.
  */
-static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
+static void xilinx_dpdma_chan_err_work(struct work_struct *work)
 {
-	struct xilinx_dpdma_chan *chan = from_tasklet(chan, t, err_task);
+	struct xilinx_dpdma_chan *chan =
+		container_of(work, struct xilinx_dpdma_chan, err_work);
 	struct xilinx_dpdma_device *xdev = chan->xdev;
 	unsigned long flags;
 
@@ -1569,7 +1570,7 @@ static int xilinx_dpdma_chan_init(struct xilinx_dpdma_device *xdev,
 	spin_lock_init(&chan->lock);
 	init_waitqueue_head(&chan->wait_to_stop);
 
-	tasklet_setup(&chan->err_task, xilinx_dpdma_chan_err_task);
+	INIT_WORK(&chan->err_work, xilinx_dpdma_chan_err_work);
 
 	chan->vchan.desc_free = xilinx_dpdma_chan_free_tx_desc;
 	vchan_init(&chan->vchan, &xdev->common);
@@ -1584,7 +1585,7 @@ static void xilinx_dpdma_chan_remove(struct xilinx_dpdma_chan *chan)
 	if (!chan)
 		return;
 
-	tasklet_kill(&chan->err_task);
+	cancel_work_sync(&chan->err_work);
 	list_del(&chan->vchan.chan.device_node);
 }
 
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 7aa63b652027..248cf3f94c5d 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -203,7 +203,7 @@ struct zynqmp_dma_desc_sw {
  * @dev: The dma device
  * @irq: Channel IRQ
  * @is_dmacoherent: Tells whether dma operations are coherent or not
- * @tasklet: Cleanup work after irq
+ * @work: Cleanup work after irq
  * @idle : Channel status;
  * @desc_size: Size of the low level descriptor
  * @err: Channel has errors
@@ -227,7 +227,7 @@ struct zynqmp_dma_chan {
 	struct device *dev;
 	int irq;
 	bool is_dmacoherent;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	bool idle;
 	u32 desc_size;
 	bool err;
@@ -722,7 +722,7 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 
 	writel(isr, chan->regs + ZYNQMP_DMA_ISR);
 	if (status & ZYNQMP_DMA_INT_DONE) {
-		tasklet_schedule(&chan->tasklet);
+		schedule_work(&chan->work);
 		ret = IRQ_HANDLED;
 	}
 
@@ -731,7 +731,7 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 
 	if (status & ZYNQMP_DMA_INT_ERR) {
 		chan->err = true;
-		tasklet_schedule(&chan->tasklet);
+		schedule_work(&chan->work);
 		dev_err(chan->dev, "Channel %p has errors\n", chan);
 		ret = IRQ_HANDLED;
 	}
@@ -746,12 +746,13 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 }
 
 /**
- * zynqmp_dma_do_tasklet - Schedule completion tasklet
- * @t: Pointer to the ZynqMP DMA channel structure
+ * zynqmp_dma_do_work - Schedule completion workqueue
+ * @wq: Pointer to the ZynqMP DMA channel structure
  */
-static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
+static void zynqmp_dma_do_work(struct work_struct *work)
 {
-	struct zynqmp_dma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct zynqmp_dma_chan *chan =
+		container_of(work, struct zynqmp_dma_chan, work);
 	u32 count;
 	unsigned long irqflags;
 
@@ -863,7 +864,7 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_chan *chan)
 
 	if (chan->irq)
 		devm_free_irq(chan->zdev->dev, chan->irq, chan);
-	tasklet_kill(&chan->tasklet);
+	cancel_work_sync(&chan->work);
 	list_del(&chan->common.device_node);
 }
 
@@ -910,7 +911,7 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
-	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
+	INIT_WORK(&chan->work, zynqmp_dma_do_work);
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->active_list);
 	INIT_LIST_HEAD(&chan->pending_list);
diff --git a/include/linux/platform_data/dma-iop32x.h b/include/linux/platform_data/dma-iop32x.h
index ac83cff89549..76f70806695f 100644
--- a/include/linux/platform_data/dma-iop32x.h
+++ b/include/linux/platform_data/dma-iop32x.h
@@ -48,7 +48,7 @@ struct iop_adma_device {
  * @last_used: place holder for allocation to continue from where it left off
  * @all_slots: complete domain of slots usable by the channel
  * @slots_allocated: records the actual size of the descriptor slot pool
- * @irq_tasklet: bottom half where iop_adma_slot_cleanup runs
+ * @irq_work: bottom half where iop_adma_slot_cleanup runs
  */
 struct iop_adma_chan {
 	int pending;
@@ -60,7 +60,7 @@ struct iop_adma_chan {
 	struct iop_adma_desc_slot *last_used;
 	struct list_head all_slots;
 	int slots_allocated;
-	struct tasklet_struct irq_tasklet;
+	struct work_struct irq_work;
 };
 
 /**
-- 
2.17.1

