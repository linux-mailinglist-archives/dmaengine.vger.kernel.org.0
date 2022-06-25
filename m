Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334E55A7DE
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiFYHpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiFYHo5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 03:44:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A647385;
        Sat, 25 Jun 2022 00:44:53 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LVQwv446RzDsSH;
        Sat, 25 Jun 2022 15:44:15 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:51 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:50 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] dmaengine: hisilicon: Adapt DMA driver to HiSilicon IP09
Date:   Sat, 25 Jun 2022 15:44:19 +0800
Message-ID: <20220625074422.3479591-6-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220625074422.3479591-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The HiSilicon IP08 and HiSilicon IP09 are DMA iEPs, they
have the same pci device id but different pci revision.
Unfortunately, they have different register layouts, so
the origin driver cannot run on HiSilicon IP09 correctly.

This patch enables the driver to adapt to HiSilicon IP09.
HiSilicon IP09 offers 4 channels, each channel has a send
queue, a complete queue and an interrupt to help to do tasks.
This DMA engine can do memory copy between memory blocks.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/hisi_dma.c | 341 +++++++++++++++++++++++++++++++----------
 1 file changed, 263 insertions(+), 78 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index d69a73272467..e1a5390567bd 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2019 HiSilicon Limited. */
+/* Copyright(c) 2019-2022 HiSilicon Limited. */
+
 #include <linux/bitfield.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
@@ -9,35 +10,87 @@
 #include <linux/spinlock.h>
 #include "virt-dma.h"
 
-#define HISI_DMA_SQ_BASE_L		0x0
-#define HISI_DMA_SQ_BASE_H		0x4
-#define HISI_DMA_SQ_DEPTH		0x8
-#define HISI_DMA_SQ_TAIL_PTR		0xc
-#define HISI_DMA_CQ_BASE_L		0x10
-#define HISI_DMA_CQ_BASE_H		0x14
-#define HISI_DMA_CQ_DEPTH		0x18
-#define HISI_DMA_CQ_HEAD_PTR		0x1c
-#define HISI_DMA_CTRL0			0x20
-#define HISI_DMA_CTRL0_QUEUE_EN_S	0
-#define HISI_DMA_CTRL0_QUEUE_PAUSE_S	4
-#define HISI_DMA_CTRL1			0x24
-#define HISI_DMA_CTRL1_QUEUE_RESET_S	0
-#define HISI_DMA_Q_FSM_STS		0x30
-#define HISI_DMA_FSM_STS_MASK		GENMASK(3, 0)
-#define HISI_DMA_INT_STS		0x40
-#define HISI_DMA_INT_STS_MASK		GENMASK(12, 0)
-#define HISI_DMA_INT_MSK		0x44
-#define HISI_DMA_MODE			0x217c
-#define HISI_DMA_OFFSET			0x100
-
-#define HISI_DMA_MSI_NUM		32
-#define HISI_DMA_CHAN_NUM		30
-#define HISI_DMA_Q_DEPTH_VAL		1024
-
-#define PCI_BAR_2			2
-
-#define HISI_DMA_POLL_Q_STS_DELAY_US	10
-#define HISI_DMA_POLL_Q_STS_TIME_OUT_US	1000
+/* HiSilicon DMA register common field define */
+#define HISI_DMA_Q_SQ_BASE_L			0x0
+#define HISI_DMA_Q_SQ_BASE_H			0x4
+#define HISI_DMA_Q_SQ_DEPTH			0x8
+#define HISI_DMA_Q_SQ_TAIL_PTR			0xc
+#define HISI_DMA_Q_CQ_BASE_L			0x10
+#define HISI_DMA_Q_CQ_BASE_H			0x14
+#define HISI_DMA_Q_CQ_DEPTH			0x18
+#define HISI_DMA_Q_CQ_HEAD_PTR			0x1c
+#define HISI_DMA_Q_CTRL0			0x20
+#define HISI_DMA_Q_CTRL0_QUEUE_EN		0
+#define HISI_DMA_Q_CTRL0_QUEUE_PAUSE		4
+#define HISI_DMA_Q_CTRL1			0x24
+#define HISI_DMA_Q_CTRL1_QUEUE_RESET		0
+#define HISI_DMA_Q_FSM_STS			0x30
+#define HISI_DMA_Q_FSM_STS_MASK			GENMASK(3, 0)
+#define HISI_DMA_Q_SQ_STS			0x34
+#define HISI_DMA_Q_SQ_HEAD_PTR			GENMASK(15, 0)
+#define HISI_DMA_Q_CQ_TAIL_PTR			0x3c
+#define HISI_DMA_Q_ERR_INT_NUM0			0x84
+#define HISI_DMA_Q_ERR_INT_NUM1			0x88
+#define HISI_DMA_Q_ERR_INT_NUM2			0x8c
+
+/* HiSilicon IP08 DMA register and field define */
+#define HISI_DMA_HIP08_MODE			0x217C
+#define HISI_DMA_HIP08_Q_BASE			0x0
+#define HISI_DMA_HIP08_Q_CTRL0_ERR_ABORT_EN	2
+#define HISI_DMA_HIP08_Q_INT_STS		0x40
+#define HISI_DMA_HIP08_Q_INT_MSK		0x44
+#define HISI_DMA_HIP08_Q_INT_STS_MASK		GENMASK(14, 0)
+#define HISI_DMA_HIP08_Q_ERR_INT_NUM3		0x90
+#define HISI_DMA_HIP08_Q_ERR_INT_NUM4		0x94
+#define HISI_DMA_HIP08_Q_ERR_INT_NUM5		0x98
+#define HISI_DMA_HIP08_Q_ERR_INT_NUM6		0x48
+#define HISI_DMA_HIP08_Q_CTRL0_SQCQ_DRCT	24
+
+/* HiSilicon IP09 DMA register and field define */
+#define HISI_DMA_HIP09_DMA_FLR_DISABLE		0xA00
+#define HISI_DMA_HIP09_DMA_FLR_DISABLE_B	0
+#define HISI_DMA_HIP09_Q_BASE			0x2000
+#define HISI_DMA_HIP09_Q_CTRL0_ERR_ABORT_EN	GENMASK(31, 28)
+#define HISI_DMA_HIP09_Q_CTRL0_SQ_DRCT		26
+#define HISI_DMA_HIP09_Q_CTRL0_CQ_DRCT		27
+#define HISI_DMA_HIP09_Q_CTRL1_VA_ENABLE	2
+#define HISI_DMA_HIP09_Q_INT_STS		0x40
+#define HISI_DMA_HIP09_Q_INT_MSK		0x44
+#define HISI_DMA_HIP09_Q_INT_STS_MASK		0x1
+#define HISI_DMA_HIP09_Q_ERR_INT_STS		0x48
+#define HISI_DMA_HIP09_Q_ERR_INT_MSK		0x4C
+#define HISI_DMA_HIP09_Q_ERR_INT_STS_MASK	GENMASK(18, 1)
+#define HISI_DMA_HIP09_PORT_CFG_REG(port_id)	(0x800 + \
+						(port_id) * 0x20)
+#define HISI_DMA_HIP09_PORT_CFG_LINK_DOWN_MASK_B	16
+
+#define HISI_DMA_HIP09_MAX_PORT_NUM		16
+
+#define HISI_DMA_HIP08_MSI_NUM			32
+#define HISI_DMA_HIP08_CHAN_NUM			30
+#define HISI_DMA_HIP09_MSI_NUM			4
+#define HISI_DMA_HIP09_CHAN_NUM			4
+#define HISI_DMA_REVISION_HIP08B		0x21
+#define HISI_DMA_REVISION_HIP09A		0x30
+
+#define HISI_DMA_Q_OFFSET			0x100
+#define HISI_DMA_Q_DEPTH_VAL			1024
+
+#define PCI_BAR_2				2
+
+#define HISI_DMA_POLL_Q_STS_DELAY_US		10
+#define HISI_DMA_POLL_Q_STS_TIME_OUT_US		1000
+/**
+ * The HIP08B(HiSilicon IP08) and HIP09A(HiSilicon IP09) are DMA iEPs, they
+ * have the same pci device id but different pci revision.
+ * Unfortunately, they have different register layouts, so two layout
+ * enumerations are defined.
+ */
+enum hisi_dma_reg_layout {
+	HISI_DMA_REG_LAYOUT_INVALID = 0,
+	HISI_DMA_REG_LAYOUT_HIP08,
+	HISI_DMA_REG_LAYOUT_HIP09
+};
 
 enum hisi_dma_mode {
 	EP = 0,
@@ -108,6 +161,8 @@ struct hisi_dma_dev {
 	struct dma_device dma_dev;
 	u32 chan_num;
 	u32 chan_depth;
+	enum hisi_dma_reg_layout reg_layout;
+	void __iomem *queue_base; /* queue region start of register */
 	struct hisi_dma_chan chan[];
 };
 
@@ -124,7 +179,7 @@ static inline struct hisi_dma_desc *to_hisi_dma_desc(struct virt_dma_desc *vd)
 static inline void hisi_dma_chan_write(void __iomem *base, u32 reg, u32 index,
 				       u32 val)
 {
-	writel_relaxed(val, base + reg + index * HISI_DMA_OFFSET);
+	writel_relaxed(val, base + reg + index * HISI_DMA_Q_OFFSET);
 }
 
 static inline void hisi_dma_update_bit(void __iomem *addr, u32 pos, bool val)
@@ -139,48 +194,76 @@ static inline void hisi_dma_update_bit(void __iomem *addr, u32 pos, bool val)
 static void hisi_dma_pause_dma(struct hisi_dma_dev *hdma_dev, u32 index,
 			       bool pause)
 {
-	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0 + index *
-			     HISI_DMA_OFFSET;
+	void __iomem *addr;
 
-	hisi_dma_update_bit(addr, HISI_DMA_CTRL0_QUEUE_PAUSE_S, pause);
+	addr = hdma_dev->queue_base + HISI_DMA_Q_CTRL0 +
+	       index * HISI_DMA_Q_OFFSET;
+	hisi_dma_update_bit(addr, HISI_DMA_Q_CTRL0_QUEUE_PAUSE, pause);
 }
 
 static void hisi_dma_enable_dma(struct hisi_dma_dev *hdma_dev, u32 index,
 				bool enable)
 {
-	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0 + index *
-			     HISI_DMA_OFFSET;
+	void __iomem *addr;
 
-	hisi_dma_update_bit(addr, HISI_DMA_CTRL0_QUEUE_EN_S, enable);
+	addr = hdma_dev->queue_base + HISI_DMA_Q_CTRL0 +
+	       index * HISI_DMA_Q_OFFSET;
+	hisi_dma_update_bit(addr, HISI_DMA_Q_CTRL0_QUEUE_EN, enable);
 }
 
 static void hisi_dma_mask_irq(struct hisi_dma_dev *hdma_dev, u32 qp_index)
 {
-	hisi_dma_chan_write(hdma_dev->base, HISI_DMA_INT_MSK, qp_index,
-			    HISI_DMA_INT_STS_MASK);
+	void __iomem *q_base = hdma_dev->queue_base;
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_INT_MSK,
+				    qp_index, HISI_DMA_HIP08_Q_INT_STS_MASK);
+	else {
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_INT_MSK,
+				    qp_index, HISI_DMA_HIP09_Q_INT_STS_MASK);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_ERR_INT_MSK,
+				    qp_index,
+				    HISI_DMA_HIP09_Q_ERR_INT_STS_MASK);
+	}
 }
 
 static void hisi_dma_unmask_irq(struct hisi_dma_dev *hdma_dev, u32 qp_index)
 {
-	void __iomem *base = hdma_dev->base;
-
-	hisi_dma_chan_write(base, HISI_DMA_INT_STS, qp_index,
-			    HISI_DMA_INT_STS_MASK);
-	hisi_dma_chan_write(base, HISI_DMA_INT_MSK, qp_index, 0);
+	void __iomem *q_base = hdma_dev->queue_base;
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08) {
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_INT_STS,
+				    qp_index, HISI_DMA_HIP08_Q_INT_STS_MASK);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_INT_MSK,
+				    qp_index, 0);
+	} else {
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_INT_STS,
+				    qp_index, HISI_DMA_HIP09_Q_INT_STS_MASK);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_ERR_INT_STS,
+				    qp_index,
+				    HISI_DMA_HIP09_Q_ERR_INT_STS_MASK);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_INT_MSK,
+				    qp_index, 0);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP09_Q_ERR_INT_MSK,
+				    qp_index, 0);
+	}
 }
 
 static void hisi_dma_do_reset(struct hisi_dma_dev *hdma_dev, u32 index)
 {
-	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL1 + index *
-			     HISI_DMA_OFFSET;
+	void __iomem *addr;
 
-	hisi_dma_update_bit(addr, HISI_DMA_CTRL1_QUEUE_RESET_S, 1);
+	addr = hdma_dev->queue_base +
+	       HISI_DMA_Q_CTRL1 + index * HISI_DMA_Q_OFFSET;
+	hisi_dma_update_bit(addr, HISI_DMA_Q_CTRL1_QUEUE_RESET, 1);
 }
 
 static void hisi_dma_reset_qp_point(struct hisi_dma_dev *hdma_dev, u32 index)
 {
-	hisi_dma_chan_write(hdma_dev->base, HISI_DMA_SQ_TAIL_PTR, index, 0);
-	hisi_dma_chan_write(hdma_dev->base, HISI_DMA_CQ_HEAD_PTR, index, 0);
+	void __iomem *q_base = hdma_dev->queue_base;
+
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_SQ_TAIL_PTR, index, 0);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR, index, 0);
 }
 
 static void hisi_dma_reset_or_disable_hw_chan(struct hisi_dma_chan *chan,
@@ -195,7 +278,7 @@ static void hisi_dma_reset_or_disable_hw_chan(struct hisi_dma_chan *chan,
 	hisi_dma_enable_dma(hdma_dev, index, false);
 	hisi_dma_mask_irq(hdma_dev, index);
 
-	addr = hdma_dev->base +
+	addr = hdma_dev->queue_base +
 	       HISI_DMA_Q_FSM_STS + index * HISI_DMA_Q_OFFSET;
 
 	ret = readl_relaxed_poll_timeout(addr, tmp,
@@ -300,8 +383,8 @@ static void hisi_dma_start_transfer(struct hisi_dma_chan *chan)
 	chan->sq_tail = (chan->sq_tail + 1) % hdma_dev->chan_depth;
 
 	/* update sq_tail to trigger a new task */
-	hisi_dma_chan_write(hdma_dev->base, HISI_DMA_SQ_TAIL_PTR, chan->qp_num,
-			    chan->sq_tail);
+	hisi_dma_chan_write(hdma_dev->queue_base, HISI_DMA_Q_SQ_TAIL_PTR,
+			    chan->qp_num, chan->sq_tail);
 }
 
 static void hisi_dma_issue_pending(struct dma_chan *c)
@@ -375,26 +458,86 @@ static int hisi_dma_alloc_qps_mem(struct hisi_dma_dev *hdma_dev)
 static void hisi_dma_init_hw_qp(struct hisi_dma_dev *hdma_dev, u32 index)
 {
 	struct hisi_dma_chan *chan = &hdma_dev->chan[index];
+	void __iomem *q_base = hdma_dev->queue_base;
 	u32 hw_depth = hdma_dev->chan_depth - 1;
-	void __iomem *base = hdma_dev->base;
+	void __iomem *addr;
+	u32 tmp;
 
 	/* set sq, cq base */
-	hisi_dma_chan_write(base, HISI_DMA_SQ_BASE_L, index,
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_SQ_BASE_L, index,
 			    lower_32_bits(chan->sq_dma));
-	hisi_dma_chan_write(base, HISI_DMA_SQ_BASE_H, index,
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_SQ_BASE_H, index,
 			    upper_32_bits(chan->sq_dma));
-	hisi_dma_chan_write(base, HISI_DMA_CQ_BASE_L, index,
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_BASE_L, index,
 			    lower_32_bits(chan->cq_dma));
-	hisi_dma_chan_write(base, HISI_DMA_CQ_BASE_H, index,
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_BASE_H, index,
 			    upper_32_bits(chan->cq_dma));
 
 	/* set sq, cq depth */
-	hisi_dma_chan_write(base, HISI_DMA_SQ_DEPTH, index, hw_depth);
-	hisi_dma_chan_write(base, HISI_DMA_CQ_DEPTH, index, hw_depth);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_SQ_DEPTH, index, hw_depth);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_DEPTH, index, hw_depth);
 
 	/* init sq tail and cq head */
-	hisi_dma_chan_write(base, HISI_DMA_SQ_TAIL_PTR, index, 0);
-	hisi_dma_chan_write(base, HISI_DMA_CQ_HEAD_PTR, index, 0);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_SQ_TAIL_PTR, index, 0);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR, index, 0);
+
+	/* init error interrupt stats */
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_ERR_INT_NUM0, index, 0);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_ERR_INT_NUM1, index, 0);
+	hisi_dma_chan_write(q_base, HISI_DMA_Q_ERR_INT_NUM2, index, 0);
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08) {
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_ERR_INT_NUM3,
+				    index, 0);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_ERR_INT_NUM4,
+				    index, 0);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_ERR_INT_NUM5,
+				    index, 0);
+		hisi_dma_chan_write(q_base, HISI_DMA_HIP08_Q_ERR_INT_NUM6,
+				    index, 0);
+		/**
+		 * init SQ/CQ direction selecting register.
+		 * "0" is to local side and "1" is to remote side.
+		 */
+		addr = q_base + HISI_DMA_Q_CTRL0 + index * HISI_DMA_Q_OFFSET;
+		hisi_dma_update_bit(addr, HISI_DMA_HIP08_Q_CTRL0_SQCQ_DRCT, 0);
+
+		/**
+		 * 0 - Continue to next descriptor if error occurs.
+		 * 1 - Abort the DMA queue if error occurs.
+		 */
+		hisi_dma_update_bit(addr,
+				    HISI_DMA_HIP08_Q_CTRL0_ERR_ABORT_EN, 0);
+	} else {
+		addr = q_base + HISI_DMA_Q_CTRL0 + index * HISI_DMA_Q_OFFSET;
+
+		/**
+		 * init SQ/CQ direction selecting register.
+		 * "0" is to local side and "1" is to remote side.
+		 */
+		hisi_dma_update_bit(addr, HISI_DMA_HIP09_Q_CTRL0_SQ_DRCT, 0);
+		hisi_dma_update_bit(addr, HISI_DMA_HIP09_Q_CTRL0_CQ_DRCT, 0);
+
+		/**
+		 * 0 - Continue to next descriptor if error occurs.
+		 * 1 - Abort the DMA queue if error occurs.
+		 */
+
+		tmp = readl_relaxed(addr);
+		tmp &= ~HISI_DMA_HIP09_Q_CTRL0_ERR_ABORT_EN;
+		writel_relaxed(tmp, addr);
+
+		/**
+		 * 0 - dma should process FLR whith CPU.
+		 * 1 - dma not process FLR, only cpu process FLR.
+		 */
+		addr = q_base + HISI_DMA_HIP09_DMA_FLR_DISABLE +
+		       index * HISI_DMA_Q_OFFSET;
+		hisi_dma_update_bit(addr, HISI_DMA_HIP09_DMA_FLR_DISABLE_B, 0);
+
+		addr = q_base + HISI_DMA_Q_CTRL1 + index * HISI_DMA_Q_OFFSET;
+		hisi_dma_update_bit(addr, HISI_DMA_HIP09_Q_CTRL1_VA_ENABLE, 1);
+	}
 }
 
 static void hisi_dma_enable_qp(struct hisi_dma_dev *hdma_dev, u32 qp_index)
@@ -438,11 +581,13 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
 	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
 	struct hisi_dma_desc *desc;
 	struct hisi_dma_cqe *cqe;
+	void __iomem *q_base;
 
 	spin_lock(&chan->vc.lock);
 
 	desc = chan->desc;
 	cqe = chan->cq + chan->cq_head;
+	q_base = hdma_dev->queue_base;
 	if (desc) {
 		chan->cq_head = (chan->cq_head + 1) %
 				hdma_dev->chan_depth;
@@ -507,16 +652,58 @@ static void hisi_dma_disable_hw_channels(void *data)
 static void hisi_dma_set_mode(struct hisi_dma_dev *hdma_dev,
 			      enum hisi_dma_mode mode)
 {
-	writel_relaxed(mode == RC ? 1 : 0, hdma_dev->base + HISI_DMA_MODE);
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
+		writel_relaxed(mode == RC ? 1 : 0,
+			       hdma_dev->base + HISI_DMA_HIP08_MODE);
+}
+
+static void hisi_dma_init_hw(struct hisi_dma_dev *hdma_dev)
+{
+	void __iomem *addr;
+	int i;
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP09) {
+		for (i = 0; i < HISI_DMA_HIP09_MAX_PORT_NUM; i++) {
+			addr = hdma_dev->base + HISI_DMA_HIP09_PORT_CFG_REG(i);
+			hisi_dma_update_bit(addr,
+				HISI_DMA_HIP09_PORT_CFG_LINK_DOWN_MASK_B, 1);
+		}
+	}
+}
+
+static void hisi_dma_init_dma_dev(struct hisi_dma_dev *hdma_dev)
+{
+	struct dma_device *dma_dev;
+
+	dma_dev = &hdma_dev->dma_dev;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_dev->device_free_chan_resources = hisi_dma_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = hisi_dma_prep_dma_memcpy;
+	dma_dev->device_tx_status = hisi_dma_tx_status;
+	dma_dev->device_issue_pending = hisi_dma_issue_pending;
+	dma_dev->device_terminate_all = hisi_dma_terminate_all;
+	dma_dev->device_synchronize = hisi_dma_synchronize;
+	dma_dev->directions = BIT(DMA_MEM_TO_MEM);
+	dma_dev->dev = &hdma_dev->pdev->dev;
+	INIT_LIST_HEAD(&dma_dev->channels);
 }
 
 static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	enum hisi_dma_reg_layout reg_layout;
 	struct device *dev = &pdev->dev;
 	struct hisi_dma_dev *hdma_dev;
 	struct dma_device *dma_dev;
+	u32 chan_num;
+	u32 msi_num;
 	int ret;
 
+	reg_layout = hisi_dma_get_reg_layout(pdev);
+	if (reg_layout == HISI_DMA_REG_LAYOUT_INVALID) {
+		dev_err(dev, "unsupported device!\n");
+		return -EINVAL;
+	}
+
 	ret = pcim_enable_device(pdev);
 	if (ret) {
 		dev_err(dev, "failed to enable device mem!\n");
@@ -533,40 +720,37 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, HISI_DMA_CHAN_NUM), GFP_KERNEL);
+	chan_num = hisi_dma_get_chan_num(pdev);
+	hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, chan_num),
+				GFP_KERNEL);
 	if (!hdma_dev)
 		return -EINVAL;
 
 	hdma_dev->base = pcim_iomap_table(pdev)[PCI_BAR_2];
 	hdma_dev->pdev = pdev;
-	hdma_dev->chan_num = HISI_DMA_CHAN_NUM;
 	hdma_dev->chan_depth = HISI_DMA_Q_DEPTH_VAL;
+	hdma_dev->chan_num = chan_num;
+	hdma_dev->reg_layout = reg_layout;
+	hdma_dev->queue_base = hdma_dev->base + hisi_dma_get_queue_base(pdev);
 
 	pci_set_drvdata(pdev, hdma_dev);
 	pci_set_master(pdev);
 
+	msi_num = hisi_dma_get_msi_num(pdev);
+
 	/* This will be freed by 'pcim_release()'. See 'pcim_enable_device()' */
-	ret = pci_alloc_irq_vectors(pdev, HISI_DMA_MSI_NUM, HISI_DMA_MSI_NUM,
-				    PCI_IRQ_MSI);
+	ret = pci_alloc_irq_vectors(pdev, msi_num, msi_num, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(dev, "Failed to allocate MSI vectors!\n");
 		return ret;
 	}
 
-	dma_dev = &hdma_dev->dma_dev;
-	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
-	dma_dev->device_free_chan_resources = hisi_dma_free_chan_resources;
-	dma_dev->device_prep_dma_memcpy = hisi_dma_prep_dma_memcpy;
-	dma_dev->device_tx_status = hisi_dma_tx_status;
-	dma_dev->device_issue_pending = hisi_dma_issue_pending;
-	dma_dev->device_terminate_all = hisi_dma_terminate_all;
-	dma_dev->device_synchronize = hisi_dma_synchronize;
-	dma_dev->directions = BIT(DMA_MEM_TO_MEM);
-	dma_dev->dev = dev;
-	INIT_LIST_HEAD(&dma_dev->channels);
+	hisi_dma_init_dma_dev(hdma_dev);
 
 	hisi_dma_set_mode(hdma_dev, RC);
 
+	hisi_dma_init_hw(hdma_dev);
+
 	ret = hisi_dma_enable_hw_channels(hdma_dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable hw channel!\n");
@@ -578,8 +762,9 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	dma_dev = &hdma_dev->dma_dev;
 	ret = dmaenginem_async_device_register(dma_dev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to register device!\n");
 
 	return ret;
-- 
2.33.0

