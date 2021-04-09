Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54F35A519
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhDIR6P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:58:15 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:55093
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234049AbhDIR6N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAD7JYvMopR+ubY3hMPnONvUHmSAni+7zuA27IwVt7rThT3Hq0uVAnlNA1HlLTkJAtT7glV0XXLW+4CSXk9FkEspsiTadfl2VbBUdOafIiSY2DewtqbhxK6EfD63SJMAy+53ZvjIGhJedMYRk/bqfKtP+jRasykBrta11YaPkHzSx3JgsCrGtTKq1PrdTeFPMDWIixk0G8pdF3Q2uaARhPN3V4xmOZsI7hVk8Jpk2mdP7sgkQoocUsUFpDA5ov3JxQSCfF0tNCZ5mIwQI4Jr4XJXJNF47GVp3xXKAPpzdeuTAsSme2wbChpwtM9eyNQWqyMSC1xmhI25tGePXoRjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8g41CQUAOmh7rO0zH0feFYWQcRN6WBfSkt+e9nQxhQ=;
 b=UvvlV6TfjSMDHxQrNR5uATfCRQb+FvsNm7sKo2CwrE2Tq0HVx/AnXC6tnway7RxkppnOuObVWO+pQSopgOa4fhi7hMYkQR8JLZUyfcgGk+dDCKtBEi1fj9cKWr+L+Gcl8NvKOVFS7gyGh+xaqd7houm1R8k9+FVmkXHWw+J/zLPMCubk2NbTJt1Sg1X6I39Vz53yawainbmRUwwJXrV0XjakcTXb5h6rWSDZuLVy4Q/iCT316PwbQBD6K4S+bo7ZNc4cpMvYyMkkiZ4yQ9bZh+Qi9p/p4fapyuDwKLN37WlfUzoyd/BW4uvpSbLbp2T+wBqIrGQSErYh26rqRiXKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8g41CQUAOmh7rO0zH0feFYWQcRN6WBfSkt+e9nQxhQ=;
 b=CaWwCfa+eBvd7qOknbpsxLuwZ2gMfWnWYbSRf/TCP9sEBM+ryL1+E5586XJJd4bRNS6xpQypVnHIBIKr7HouwLkqtRCyJ0UGqjZOknz792rSzLeWCaIOCIdDCXD8h3i7lUBe9tQw1QvNv+QKeRJ+zmmCbl6eVrFmmhyNdFIf4gc=
Received: from SA0PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:d3::30)
 by DM5PR02MB3893.namprd02.prod.outlook.com (2603:10b6:4:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 17:57:56 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::c6) by SA0PR11CA0025.outlook.office365.com
 (2603:10b6:806:d3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:57:54 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:57:54 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33309 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvOC-0001G2-R4; Fri, 09 Apr 2021 10:57:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 515AF122175; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 7/7] dmaengine: xilinx_dma: Program interrupt delay timeout
Date:   Fri, 9 Apr 2021 23:26:05 +0530
Message-ID: <1617990965-35337-8-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8d2f01-ffd0-41d6-8b2e-08d8fb81017e
X-MS-TrafficTypeDiagnostic: DM5PR02MB3893:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3893818964277178D3A72FEFC7739@DM5PR02MB3893.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9anQK7beaxR+P8HCETZ4OKMxQQQPhGQhmPF9lqIcCOW7JzVw4ZeGaYCuwyEaOpBnrcc3hdULrLaKj+IPrnjo9P7eTemwtD2O+1qH3oYVAq2ELfyaa3yczyU+tr6yYfLwCJ/WiOjbcJvlx8MdjKm266y8t3Q3phQjex+PkwjZkHngWjcraZ67eGmeW8UMY5A5yez6as0U6TnBhazsmZm6TcyJ5OfN2H+plIEZs+xY4AA1U20351hH7lL/jdytGtJ9+MxkO6qPrB7uj78BjMjb7uO566DT3BoZZK9kIKSonCwX0XQUJaj3VZu90f+etqpimRnJ0OlZOG6kocWZUbJUyRuxhOQyOo13JGZpi3/exkC/6MRJO+nZXnlHAdhjDlN+9eVYsknQi34O1qCyBRd/TYO0tWS1GuNGWUa3KQ70W15DDbzoD4hJ5eKkvsjHtJjZOYtinVvyMfQ+K5RZvUswk+JwArf6jWUYaQV3SgBKewUln42xvVpsj0cbJM2dcwqnWmOLELlL8RIchQ0bvBWlXBZwLbF5poBur40qFcYHftCJaYzHVyypSthAYeiwxqtUX0Z+47/hu2egXkdFcDpkv5FLeOMExCJ8c0wSewj0Af/tBpYXEIMogu8x6f5EdM8dPQDCpo+rKObrC59W96tIXfH1kchQwzFQSas6qXuVoAP7Yy2cA3PoBB5fMjC4CCix
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(36840700001)(46966006)(316002)(36906005)(478600001)(42186006)(54906003)(82310400003)(110136005)(2616005)(4326008)(426003)(186003)(336012)(47076005)(36756003)(83380400001)(5660300002)(8676002)(8936002)(6666004)(26005)(2906002)(6266002)(6636002)(107886003)(7636003)(70206006)(36860700001)(70586007)(356005)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:56.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d2f01-ffd0-41d6-8b2e-08d8fb81017e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3893
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
the DMA engine to generate an interrupt after the delay time period
has expired. It enables dmaengine to respond in real-time even though
interrupt coalescing is configured. It also remove the placeholder
for delay interrupt and merge it with frame completion interrupt.
Since by default interrupt delay timeout is disabled this feature
addition has no functional impact on VDMA and CDMA IP's.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Read irq delay timeout value from DT.
- Merge interrupt processing for frame done and delay interrupt.
---
 drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a2ea2d649332..0c0dc9882a01 100644
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
@@ -410,6 +412,7 @@ struct xilinx_dma_tx_descriptor {
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
  * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
+ * @irq_delay: Interrupt delay timeout
  */
 struct xilinx_dma_chan {
 	struct xilinx_dma_device *xdev;
@@ -447,6 +450,7 @@ struct xilinx_dma_chan {
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
 	bool has_vflip;
+	u8 irq_delay;
 };
 
 /**
@@ -1555,6 +1559,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->has_sg)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
+	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);
 
@@ -1877,15 +1884,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
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
@@ -2802,6 +2802,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	/* Retrieve the channel properties from the device tree */
 	has_dre = of_property_read_bool(node, "xlnx,include-dre");
 
+	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);
+
 	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
 
 	err = of_property_read_u32(node, "xlnx,datawidth", &value);
-- 
2.7.4

