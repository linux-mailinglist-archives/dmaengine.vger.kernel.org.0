Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84F637678
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKXK3w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiKXK3r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:29:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DE14A2C5;
        Thu, 24 Nov 2022 02:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzOpKUI6HH1cyUE7L4XLudkKUVsPEOW5SwF4vuITpy6c+qxsETSPzqvG1qL7HcPJFiIjoU3iA80q/nWFFSCzGa/5qY+aN/onWWlvQkyPKKUqxSH+nBaaX5lF9gw1zNkGbelOyim2TdvKs0Bk7DzvLhhUqoj+/AQJSutwIVjuSfpaQ4+126jf+HbrbDaA+0VcaLMs2Qcd2nhjPoVo17+kHc/9IgfBKHb+h834SHzVOqgjcnbH+M6zAzrmI06LjbwEM3Ugp9Ch/oIUtewopIcv9JfDyfcYSC7Hb1HIhPE56frOjx2cy1oC9w+O7jN+M+62Ybm1zTsRsrJVft/4JDvlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK98sISiu20IUkwpbdgv25SGP2dEfMvoSR5tMNcuguM=;
 b=bKMRBWJhThRyeTzjN7h9YS3Y0JM1CYWPDaDIIbhX0n+nzxejao3g78MMTFUk1BRwTDA3GgNmnevmIqrYQ/EBlE4WmxRxdqtwGqJsObex10NQxc/bRhGtByYYw8og2M2g21Gj4E3bQi9T2MFkFK87uMeADebaZ+8hc25hu8ccxTRwA++mX+a0KJGI9CT6xH7PJSxnpJ3vrrYqLCVZu+cv1PSQCux8mWIMxwbsN+ZOSp7haTu4foVUqxfwVx/ih1rEoqRnmlo3lRba5PUXI6gGJu7wE+FLed5tYPhEnYj1wQtxooFs26nz1dOJxaO9ABlaTw8qnf7Fk5FGHy37phVQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK98sISiu20IUkwpbdgv25SGP2dEfMvoSR5tMNcuguM=;
 b=p9eqCQzRIStCbZbxycmjdFmEDvHNajgvBSeqHqu0QEFAFnd46oL7lKLJRrDrupClGisYhCjgZE8xS4rHub6oKUrjmLEETQMYm9lG9csQPO5d6rL1CuJLiAVdP1A5DSGSd92O5Ji8pXUff/rj4+OTZgXYnsQcChDXmDOcDmLXN1k=
Received: from MW4PR04CA0032.namprd04.prod.outlook.com (2603:10b6:303:6a::7)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 10:29:34 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::ea) by MW4PR04CA0032.outlook.office365.com
 (2603:10b6:303:6a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 10:29:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:29:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:29:00 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:28:57 -0600
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH V2 6/6] dmaengine: xilinx_dma: Program interrupt delay timeout
Date:   Thu, 24 Nov 2022 15:57:45 +0530
Message-ID: <20221124102745.2620370-7-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce5d549-7cc9-43f3-c932-08dace06c7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jols/puiB8QKDCOMujL03pwlp+GKZ7+QUBU9JzB3QNBxXcB9gDVM988cLdocVxOTn5HawUK/VsW0i1miJ2uU1R5foyfqOPb71NLYupot4uU3tyXs5gb8htGSYeKUJ0Pafj+KmLNg+P/7C7Tb1sbBPE4Po5C6KqW+HX/bSbmB8J7mnXbh3hHPMa7pij2CoZw1M5ir7StAh8eIdoVK7W7XHGuRlY+rnbugZLh47NmcsjNLVY2UHcWR7cZ4upzNA20XwgZjLASeVCuwVjkT0IgFY6XrskwMTSnC27BCQAvWAb/n8kbaij0bD+5ZJjUo/oU3uUgfmQcxC3AH/wlaFA0z4oVDbLA9ek0v8NeATQ2OBIhXD7WDjg0vMFlk2Zem44kkeXXZbGxkEL/+9E6ub4ZPHyIr5lQfdDaEsUJtLl2CMz+YOasQqKLVTSaC7YTMaXqErRt1qlW8v5hY4tRnVVuYNBJP4i+NKUl6h6aQmZO7i/HSn18K9i5voGcNRbc3JRGBIIzjW6VNC+kkkeiOC+6x88PoIM/rQ/cKMnagNH56Bf2EAwg5BOxkyHvnlS/X/Z65OQDsalsOk/+EklsZUWf3SHo/99hYMjMkuE46cM+eusWifyuqjYqJJ+P7/Kte1+Fysshc/ar3C/GfNvTZmcrNtzp1u4Sa4C+xXV+NOT2WFl1mfDrwnQMFQkfifG7eLiX19+5J+jIzvSUAnhWBEckpRL4o1d6IDkAqnk3fDLQJ2O4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(426003)(1076003)(186003)(336012)(47076005)(82310400005)(36756003)(5660300002)(8936002)(6666004)(41300700001)(26005)(103116003)(86362001)(316002)(54906003)(110136005)(8676002)(4326008)(40460700003)(478600001)(70586007)(70206006)(36860700001)(2906002)(82740400003)(40480700001)(356005)(81166007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:29:33.9899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5d549-7cc9-43f3-c932-08dace06c7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
 drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ce0c151d8f61..333d68ee3559 100644
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
 #define XILINX_DMA_COALESCE_MAX		255
@@ -410,6 +412,7 @@ struct xilinx_dma_tx_descriptor {
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
  * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
+ * @irq_delay: Interrupt delay timeout
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -448,6 +451,7 @@ struct xilinx_dma_chan {
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
 	bool has_vflip;
+	u8 irq_delay;
 };
 
 /**
@@ -1560,6 +1564,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->has_sg)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
+	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);
 
@@ -1887,15 +1894,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
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
@@ -2822,6 +2822,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	/* Retrieve the channel properties from the device tree */
 	has_dre = of_property_read_bool(node, "xlnx,include-dre");
 
+	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);
+
 	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
 
 	err = of_property_read_u32(node, "xlnx,datawidth", &value);
-- 
2.25.1

