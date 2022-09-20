Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC55BDCAE
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiITFx0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiITFwl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C055B7AA;
        Mon, 19 Sep 2022 22:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX/OwwWjFk3rPgVBF+r7gsRQCTz2ke8h0ePtxoPbnkVjbL0woRD3alYHqtf2bVtF8Blb1zoqMJsfQzOwskGtZdYN3WKB0tDz0Bd9ssjqeZzNV83Udrp/jnumGGM9HpRrmWTYpsGYVmTyAB/VjGHq1S207xu6zN4yOnanLrQlOzU/a0AMAkh2YyXb5TVzz9v2O3BqdxoFeCAlP6mZctjO1MYOtXIjt9ZTbYEKwE2fYBotgJnlRpviOde824sbTKgaJbVeub+wDRhj6XhBOWix/hzFWURihx3P6kEkRvQWIiAlhOkV8S4QexIgchrqZUG6eu4Yobi2h0sawOhMauGLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnpwph5R6qP5xt+g37ou8wG6vU34LAc/PW94akfEYXY=;
 b=Ss041XX/OjI0mSMsCZY4UMF1l8FXic+4v2kaWog9Jzb34RUX96CtrSJ7JtbXsP2KJpLBD7QgPr5V8lti6Hwpv74kW4OMas1j/j9Z0clzODCVPk4SmRUJJZTDnW717U9Iu4oUcQOI1nd/doqoReLYMGle4HkFt9PRub24GOcNS/xfQs6tXQqASZhp/0WSlbHCvlD1Prkp4DlOFu+NmS/cFPyF5h81Uewf5RM9Yq18klS4neao7Z0v4bXFZAkcf+ym0LwpRxITdx3S0vwYFsS497naiRVzTKygZFaBtC8Ir2tJ87/v7+EvlwZ+Wsd0RvmYOsRecns3QWvQpguT2njGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnpwph5R6qP5xt+g37ou8wG6vU34LAc/PW94akfEYXY=;
 b=5u16mFQkMqbl/VnkV0Np18xVD9UZMFU/ocPcNDMAGdLsAj/GCms6UKHKSwNCuBVy2VyHs3HV3aHXgtUsVGc7baMYP44mwg7Qd7hK3F+jCOysPOqmJUgHqV6r97+Oq06lmkgH6VZ97r4YWDQSsnKIHKzE1PMKcX8Dc0PYHl2oCho=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:52:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::41) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:29 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:52:23 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 7/8] dmaengine: xilinx_dma: Program interrupt delay timeout
Date:   Tue, 20 Sep 2022 11:21:18 +0530
Message-ID: <20220920055119.12634-8-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: b289f2fc-def5-45a4-8af8-08da9acc4e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3HkMCITttPEFhvdcH3tAUk2xsDbtFPf2TUlZfCId6qwxagOvVTkBZlyBCy80RUZ7x07bHM7I9MeX5Zp7r6UrJBQkY5CZl73vqudvH+tYEfKJ9JtNqPZQ7U4W37cY4R6lzskVVFCrSyWy58vVVHMB79DAfj17b8PHwVoBcoFCBoc5Un4qxSWYZhU12myHgNirdC3+M9yhO4jBg7Y7KzINBPudfiLm+QQHy1EykYjatqODukP5JeiW5fcBoBsA1ruQjSbJ2z7iSUBljfmACqiVslxhN7pgycMVlnmTxol/43Yy7PSN6yf07C+Uo0yYPpXI65IGb4hLUDqGht990dbBSXEgHF95SP5vYqrAFdlHfEGKx/irPpCBqtFavv57qfoFG2Cr3Q66Bw661cfbqCtpFwi0Yx0ZYw2hgEBlhPcOIJtu0r/80i3JTCxu8Kz26s/BD6E/x/IJjcCg8tOcn8fM/OcGLXafLtwC+RyFtcgknHnbJMmO5wiuA1C+CaPef32T+yiR2ciLQexeJpawys/y1cLvibHa6QPJ6Xhp70qwKyuHEd4i1cHHZWHBTW/2nRFkDjXg5dhIipC12a9yvlDZaWH1zKJ/LYfY09UPzWFcHG6LUzJTfVdqhio6hDvj29S/CBwPHYdNGPjQ/9mrA069Ih0mtu/blTvDk7dcS2cc4V1oL1W4M6kCtOdSapAi5SuCsKPE6MGUhRLo0z2ZCSWenFD99AbjWs7WuHsIQZGdhjG++rSWdETEiwe0y7bn3BScHSLeLYlVAISzISt0Oei2iQuDKHgbdyoJghUunk5tGplq/LQgjBIHgcLWv+WbKSz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(40480700001)(36756003)(2906002)(316002)(426003)(36860700001)(47076005)(8676002)(82740400003)(4326008)(5660300002)(103116003)(70206006)(70586007)(8936002)(86362001)(110136005)(54906003)(336012)(1076003)(186003)(478600001)(2616005)(356005)(81166007)(26005)(6666004)(83380400001)(41300700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:30.4561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b289f2fc-def5-45a4-8af8-08da9acc4e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
the DMA engine to generate an interrupt after the delay time period
has expired. It enables dmaengine to respond in real-time even though
interrupt coalescing is configured. It also remove the placeholder
for delay interrupt and merge it with frame completion interrupt.
Since by default interrupt delay timeout is disabled this feature
addition has no functional impact on VDMA and CDMA IP's.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V3:
- None.

Changes in V2:
- Read irq delay timeout value from DT.
- Merge interrupt processing for frame done and delay interrupt.
---
 drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8126a56980f2..bd8f09837141 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -173,8 +173,10 @@
 #define XILINX_DMA_MAX_TRANS_LEN_MAX	23
 #define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
+#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
+#define XILINX_DMA_CR_DELAY_SHIFT	24
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_BD_COMP_MASK		BIT(31)
@@ -411,6 +413,7 @@ struct xilinx_dma_tx_descriptor {
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
  * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
+ * @irq_delay: Interrupt delay timeout
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -449,6 +452,7 @@ struct xilinx_dma_chan {
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
 	bool has_vflip;
+	u8 irq_delay;
 };
 
 /**
@@ -1561,6 +1565,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->has_sg)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
+	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);
 
@@ -1896,15 +1903,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		}
 	}
 
-	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
-		/*
-		 * Device takes too long to do the transfer when user requires
-		 * responsiveness.
-		 */
-		dev_dbg(chan->dev, "Inter-packet latency too long\n");
-	}
-
-	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
+	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
+		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
 		chan->idle = true;
@@ -2831,6 +2831,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	/* Retrieve the channel properties from the device tree */
 	has_dre = of_property_read_bool(node, "xlnx,include-dre");
 
+	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);
+
 	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
 
 	err = of_property_read_u32(node, "xlnx,datawidth", &value);
-- 
2.25.1

