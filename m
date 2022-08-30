Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30205A5BBA
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiH3GZl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiH3GZg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 02:25:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3D56BB2;
        Mon, 29 Aug 2022 23:25:32 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGy1X5J8GzHnVd;
        Tue, 30 Aug 2022 14:23:44 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 14:25:30 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 14:25:30 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v5 6/7] dmaengine: hisilicon: Dump regs to debugfs
Date:   Tue, 30 Aug 2022 14:22:50 +0800
Message-ID: <20220830062251.52993-7-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220830062251.52993-1-haijie1@huawei.com>
References: <20220830062251.52993-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This patch adds dump of registers with debugfs for HIP08
and HIP09 DMA driver.

Signed-off-by: Jie Hai <haijie1@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/dma/hisi_dma.c | 238 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index da5e49ee95fa..c1350a36fddd 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -78,6 +78,8 @@
 #define HISI_DMA_POLL_Q_STS_DELAY_US		10
 #define HISI_DMA_POLL_Q_STS_TIME_OUT_US		1000
 
+#define HISI_DMA_MAX_DIR_NAME_LEN		128
+
 /*
  * The HIP08B(HiSilicon IP08) and HIP09A(HiSilicon IP09) are DMA iEPs, they
  * have the same pci device id but different pci revision.
@@ -164,6 +166,123 @@ struct hisi_dma_dev {
 	struct hisi_dma_chan chan[];
 };
 
+#ifdef CONFIG_DEBUG_FS
+
+static const struct debugfs_reg32 hisi_dma_comm_chan_regs[] = {
+	{"DMA_QUEUE_SQ_DEPTH                ", 0x0008ull},
+	{"DMA_QUEUE_SQ_TAIL_PTR             ", 0x000Cull},
+	{"DMA_QUEUE_CQ_DEPTH                ", 0x0018ull},
+	{"DMA_QUEUE_CQ_HEAD_PTR             ", 0x001Cull},
+	{"DMA_QUEUE_CTRL0                   ", 0x0020ull},
+	{"DMA_QUEUE_CTRL1                   ", 0x0024ull},
+	{"DMA_QUEUE_FSM_STS                 ", 0x0030ull},
+	{"DMA_QUEUE_SQ_STS                  ", 0x0034ull},
+	{"DMA_QUEUE_CQ_TAIL_PTR             ", 0x003Cull},
+	{"DMA_QUEUE_INT_STS                 ", 0x0040ull},
+	{"DMA_QUEUE_INT_MSK                 ", 0x0044ull},
+	{"DMA_QUEUE_INT_RO                  ", 0x006Cull},
+};
+
+static const struct debugfs_reg32 hisi_dma_hip08_chan_regs[] = {
+	{"DMA_QUEUE_BYTE_CNT                ", 0x0038ull},
+	{"DMA_ERR_INT_NUM6                  ", 0x0048ull},
+	{"DMA_QUEUE_DESP0                   ", 0x0050ull},
+	{"DMA_QUEUE_DESP1                   ", 0x0054ull},
+	{"DMA_QUEUE_DESP2                   ", 0x0058ull},
+	{"DMA_QUEUE_DESP3                   ", 0x005Cull},
+	{"DMA_QUEUE_DESP4                   ", 0x0074ull},
+	{"DMA_QUEUE_DESP5                   ", 0x0078ull},
+	{"DMA_QUEUE_DESP6                   ", 0x007Cull},
+	{"DMA_QUEUE_DESP7                   ", 0x0080ull},
+	{"DMA_ERR_INT_NUM0                  ", 0x0084ull},
+	{"DMA_ERR_INT_NUM1                  ", 0x0088ull},
+	{"DMA_ERR_INT_NUM2                  ", 0x008Cull},
+	{"DMA_ERR_INT_NUM3                  ", 0x0090ull},
+	{"DMA_ERR_INT_NUM4                  ", 0x0094ull},
+	{"DMA_ERR_INT_NUM5                  ", 0x0098ull},
+	{"DMA_QUEUE_SQ_STS2                 ", 0x00A4ull},
+};
+
+static const struct debugfs_reg32 hisi_dma_hip09_chan_regs[] = {
+	{"DMA_QUEUE_ERR_INT_STS             ", 0x0048ull},
+	{"DMA_QUEUE_ERR_INT_MSK             ", 0x004Cull},
+	{"DFX_SQ_READ_ERR_PTR               ", 0x0068ull},
+	{"DFX_DMA_ERR_INT_NUM0              ", 0x0084ull},
+	{"DFX_DMA_ERR_INT_NUM1              ", 0x0088ull},
+	{"DFX_DMA_ERR_INT_NUM2              ", 0x008Cull},
+	{"DFX_DMA_QUEUE_SQ_STS2             ", 0x00A4ull},
+};
+
+static const struct debugfs_reg32 hisi_dma_hip08_comm_regs[] = {
+	{"DMA_ECC_ERR_ADDR                  ", 0x2004ull},
+	{"DMA_ECC_ECC_CNT                   ", 0x2014ull},
+	{"COMMON_AND_CH_ERR_STS             ", 0x2030ull},
+	{"LOCAL_CPL_ID_STS_0                ", 0x20E0ull},
+	{"LOCAL_CPL_ID_STS_1                ", 0x20E4ull},
+	{"LOCAL_CPL_ID_STS_2                ", 0x20E8ull},
+	{"LOCAL_CPL_ID_STS_3                ", 0x20ECull},
+	{"LOCAL_TLP_NUM                     ", 0x2158ull},
+	{"SQCQ_TLP_NUM                      ", 0x2164ull},
+	{"CPL_NUM                           ", 0x2168ull},
+	{"INF_BACK_PRESS_STS                ", 0x2170ull},
+	{"DMA_CH_RAS_LEVEL                  ", 0x2184ull},
+	{"DMA_CM_RAS_LEVEL                  ", 0x2188ull},
+	{"DMA_CH_ERR_STS                    ", 0x2190ull},
+	{"DMA_CH_DONE_STS                   ", 0x2194ull},
+	{"DMA_SQ_TAG_STS_0                  ", 0x21A0ull},
+	{"DMA_SQ_TAG_STS_1                  ", 0x21A4ull},
+	{"DMA_SQ_TAG_STS_2                  ", 0x21A8ull},
+	{"DMA_SQ_TAG_STS_3                  ", 0x21ACull},
+	{"LOCAL_P_ID_STS_0                  ", 0x21B0ull},
+	{"LOCAL_P_ID_STS_1                  ", 0x21B4ull},
+	{"LOCAL_P_ID_STS_2                  ", 0x21B8ull},
+	{"LOCAL_P_ID_STS_3                  ", 0x21BCull},
+	{"DMA_PREBUFF_INFO_0                ", 0x2200ull},
+	{"DMA_CM_TABLE_INFO_0               ", 0x2220ull},
+	{"DMA_CM_CE_RO                      ", 0x2244ull},
+	{"DMA_CM_NFE_RO                     ", 0x2248ull},
+	{"DMA_CM_FE_RO                      ", 0x224Cull},
+};
+
+static const struct debugfs_reg32 hisi_dma_hip09_comm_regs[] = {
+	{"COMMON_AND_CH_ERR_STS             ", 0x0030ull},
+	{"DMA_PORT_IDLE_STS                 ", 0x0150ull},
+	{"DMA_CH_RAS_LEVEL                  ", 0x0184ull},
+	{"DMA_CM_RAS_LEVEL                  ", 0x0188ull},
+	{"DMA_CM_CE_RO                      ", 0x0244ull},
+	{"DMA_CM_NFE_RO                     ", 0x0248ull},
+	{"DMA_CM_FE_RO                      ", 0x024Cull},
+	{"DFX_INF_BACK_PRESS_STS0           ", 0x1A40ull},
+	{"DFX_INF_BACK_PRESS_STS1           ", 0x1A44ull},
+	{"DFX_INF_BACK_PRESS_STS2           ", 0x1A48ull},
+	{"DFX_DMA_WRR_DISABLE               ", 0x1A4Cull},
+	{"DFX_PA_REQ_TLP_NUM                ", 0x1C00ull},
+	{"DFX_PA_BACK_TLP_NUM               ", 0x1C04ull},
+	{"DFX_PA_RETRY_TLP_NUM              ", 0x1C08ull},
+	{"DFX_LOCAL_NP_TLP_NUM              ", 0x1C0Cull},
+	{"DFX_LOCAL_CPL_HEAD_TLP_NUM        ", 0x1C10ull},
+	{"DFX_LOCAL_CPL_DATA_TLP_NUM        ", 0x1C14ull},
+	{"DFX_LOCAL_CPL_EXT_DATA_TLP_NUM    ", 0x1C18ull},
+	{"DFX_LOCAL_P_HEAD_TLP_NUM          ", 0x1C1Cull},
+	{"DFX_LOCAL_P_ACK_TLP_NUM           ", 0x1C20ull},
+	{"DFX_BUF_ALOC_PORT_REQ_NUM         ", 0x1C24ull},
+	{"DFX_BUF_ALOC_PORT_RESULT_NUM      ", 0x1C28ull},
+	{"DFX_BUF_FAIL_SIZE_NUM             ", 0x1C2Cull},
+	{"DFX_BUF_ALOC_SIZE_NUM             ", 0x1C30ull},
+	{"DFX_BUF_NP_RELEASE_SIZE_NUM       ", 0x1C34ull},
+	{"DFX_BUF_P_RELEASE_SIZE_NUM        ", 0x1C38ull},
+	{"DFX_BUF_PORT_RELEASE_SIZE_NUM     ", 0x1C3Cull},
+	{"DFX_DMA_PREBUF_MEM0_ECC_ERR_ADDR  ", 0x1CA8ull},
+	{"DFX_DMA_PREBUF_MEM0_ECC_CNT       ", 0x1CACull},
+	{"DFX_DMA_LOC_NP_OSTB_ECC_ERR_ADDR  ", 0x1CB0ull},
+	{"DFX_DMA_LOC_NP_OSTB_ECC_CNT       ", 0x1CB4ull},
+	{"DFX_DMA_PREBUF_MEM1_ECC_ERR_ADDR  ", 0x1CC0ull},
+	{"DFX_DMA_PREBUF_MEM1_ECC_CNT       ", 0x1CC4ull},
+	{"DMA_CH_DONE_STS                   ", 0x02E0ull},
+	{"DMA_CH_ERR_STS                    ", 0x0320ull},
+};
+#endif /* CONFIG_DEBUG_FS*/
+
 static enum hisi_dma_reg_layout hisi_dma_get_reg_layout(struct pci_dev *pdev)
 {
 	if (pdev->revision == HISI_DMA_REVISION_HIP08B)
@@ -717,6 +836,117 @@ static void hisi_dma_init_dma_dev(struct hisi_dma_dev *hdma_dev)
 	INIT_LIST_HEAD(&dma_dev->channels);
 }
 
+/* --- debugfs implementation --- */
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+static struct debugfs_reg32 *hisi_dma_get_ch_regs(struct hisi_dma_dev *hdma_dev,
+						  u32 *regs_sz)
+{
+	struct device *dev = &hdma_dev->pdev->dev;
+	struct debugfs_reg32 *regs;
+	u32 regs_sz_comm;
+
+	regs_sz_comm = ARRAY_SIZE(hisi_dma_comm_chan_regs);
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
+		*regs_sz = regs_sz_comm + ARRAY_SIZE(hisi_dma_hip08_chan_regs);
+	else
+		*regs_sz = regs_sz_comm + ARRAY_SIZE(hisi_dma_hip09_chan_regs);
+
+	regs = devm_kcalloc(dev, *regs_sz, sizeof(struct debugfs_reg32),
+			    GFP_KERNEL);
+	if (!regs)
+		return NULL;
+	memcpy(regs, hisi_dma_comm_chan_regs, sizeof(hisi_dma_comm_chan_regs));
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08)
+		memcpy(regs + regs_sz_comm, hisi_dma_hip08_chan_regs,
+		       sizeof(hisi_dma_hip08_chan_regs));
+	else
+		memcpy(regs + regs_sz_comm, hisi_dma_hip09_chan_regs,
+		       sizeof(hisi_dma_hip09_chan_regs));
+
+	return regs;
+}
+
+static int hisi_dma_create_chan_dir(struct hisi_dma_dev *hdma_dev)
+{
+	char dir_name[HISI_DMA_MAX_DIR_NAME_LEN];
+	struct debugfs_regset32 *regsets;
+	struct debugfs_reg32 *regs;
+	struct dentry *chan_dir;
+	struct device *dev;
+	u32 regs_sz;
+	int ret;
+	int i;
+
+	dev = &hdma_dev->pdev->dev;
+
+	regsets = devm_kcalloc(dev, hdma_dev->chan_num,
+			       sizeof(*regsets), GFP_KERNEL);
+	if (!regsets)
+		return -ENOMEM;
+
+	regs = hisi_dma_get_ch_regs(hdma_dev, &regs_sz);
+	if (!regs)
+		return -ENOMEM;
+
+	for (i = 0; i < hdma_dev->chan_num; i++) {
+		regsets[i].regs = regs;
+		regsets[i].nregs = regs_sz;
+		regsets[i].base = hdma_dev->queue_base + i * HISI_DMA_Q_OFFSET;
+		regsets[i].dev = dev;
+
+		memset(dir_name, 0, HISI_DMA_MAX_DIR_NAME_LEN);
+		ret = sprintf(dir_name, "channel%d", i);
+		if (ret < 0)
+			return ret;
+
+		chan_dir = debugfs_create_dir(dir_name,
+					      hdma_dev->dma_dev.dbg_dev_root);
+		debugfs_create_regset32("regs", 0444, chan_dir, &regsets[i]);
+	}
+
+	return 0;
+}
+
+static void hisi_dma_create_debugfs(struct hisi_dma_dev *hdma_dev)
+{
+	struct debugfs_regset32 *regset;
+	struct device *dev;
+	int ret;
+
+	dev = &hdma_dev->pdev->dev;
+
+	if (hdma_dev->dma_dev.dbg_dev_root == NULL)
+		return;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	if (hdma_dev->reg_layout == HISI_DMA_REG_LAYOUT_HIP08) {
+		regset->regs = hisi_dma_hip08_comm_regs;
+		regset->nregs = ARRAY_SIZE(hisi_dma_hip08_comm_regs);
+	} else {
+		regset->regs = hisi_dma_hip09_comm_regs;
+		regset->nregs = ARRAY_SIZE(hisi_dma_hip09_comm_regs);
+	}
+	regset->base = hdma_dev->base;
+	regset->dev = dev;
+
+	debugfs_create_regset32("regs", 0444,
+				hdma_dev->dma_dev.dbg_dev_root, regset);
+
+	ret = hisi_dma_create_chan_dir(hdma_dev);
+	if (ret < 0)
+		dev_info(&hdma_dev->pdev->dev, "fail to create debugfs for channels!\n");
+}
+#else
+static void hisi_dma_create_debugfs(struct hisi_dma_dev *hdma_dev) { }
+#endif /* CONFIG_DEBUG_FS*/
+/* --- debugfs implementation --- */
+
 static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	enum hisi_dma_reg_layout reg_layout;
@@ -793,10 +1023,14 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dma_dev = &hdma_dev->dma_dev;
 	ret = dmaenginem_async_device_register(dma_dev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to register device!\n");
+		return ret;
+	}
+
+	hisi_dma_create_debugfs(hdma_dev);
 
-	return ret;
+	return 0;
 }
 
 static const struct pci_device_id hisi_dma_pci_tbl[] = {
-- 
2.33.0

