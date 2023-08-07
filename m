Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C37719AF
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHGFxR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjHGFw5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:52:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2B1732;
        Sun,  6 Aug 2023 22:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3dxiXP9z2Wtury/aH6+x0OEj/Lt5CKHSFhnYd0h2fGaSEh9oMau1uuGMEgjg/jnM1bQgL4x4NkBrZH+M9X/lxkfwCVuK3jtt9BC6HUpVjh2g/ImscD8r9eY9SsD0I+7u4rLRAMOwSJt4IH/FcJIVopIwYGa8FMIFYNqmhR5TEQl2sAtN6P2/4VTwEndGOdjTcvDcp7YGlMBlObOzUXxRzMDLuwoaOt45JOlPRh/avRjlhQndgiuuuapqyirofgafvS5GUdDEVEY5ylLQMDg4IbxRzDpxG0NvTAzZi62G62m363dNlyTl+MM6FeA2JTpNyiM/XQtZlwi1W1MkAgzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoT7yjUMcSpDetWkCNKKFM3dm40eVZSUVdW6CNBand4=;
 b=Xp39q7VwUA65wdA1d/pHOZRps96lMHB4CfCTiov2qnp/i8VmiQj395l6JjU05m+8Fv7Joeo15vE9A3qBPMD1aWHCL5jWH7ZGDo7v48pGpQ3riHNT0p7zG4pUiRZSLQ16ohJzOxNnFvHuEgbhLNBKDqZ5x6yFbZ+sC4RL3XWbP/ifC5GcoiO1rnRsQvfRvXHcw0SzP/QmSgJ1WFhbte0q4+P62LkZOOrKJcsqjf5TVUiaKPkSsjIFYjKF5hyHxd8yj3N7iPLgoMhGZREArTLVM8kzZD+owxNEMI/TodkdtGjQrYaiEkLoJprni+V1enRFJQCOtL0y1FTWzQF7GjEnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoT7yjUMcSpDetWkCNKKFM3dm40eVZSUVdW6CNBand4=;
 b=s7L+VmshQHzu2bT6yTrAZ7N70qSyomK9WYXW1Rgj2ggqA+eDdKZo6tXe3srF5ZSEWZ1QDHg66zQQn+/9k66qj1XDE6nrjnC/cGazuH9cLOpd1SGbvLUiyK7BQ0KPE4hSL68zTBcBGKvpv8uPqFs6WWfVQD58e3/+0quOdeWkxq4=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:52:45 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a1) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Mon, 7 Aug 2023 05:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 05:52:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 00:52:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 22:52:41 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 00:52:37 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v5 05/10] dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit
Date:   Mon, 7 Aug 2023 11:21:44 +0530
Message-ID: <1691387509-2113129-6-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: e378a51d-7016-438c-ba99-08db970a8563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coxkfka5XRR62IMPeVO1Y4gIPHqUeW4tPMbqtvgDPxaUHLj9z86FwGi9WMGEPg89GX9H8k3oRh558a1MD0LgK9AgsJy2rOrKF3kH05KtTywYjOzfQXLatikGrQNvAFjeC7Db4gNjCgUlulmD1RpGAxcJzTCnY/ED1Kk52juLqCDPKpxqvGPk4zkz4wbv0DCjXWqRdTRVV9TD/7n+GQkfP0geY2LV++WYZ7BBBl9tYvJ026XxY0ndjDkAjlIn1jzQ68NkKkmoLlUskiq4Uc7ZFUrQwE7uDyX9fVcpsJiZFU8WxdykrHjsory/fNtRX/hs3B1dljBCSLK0jZrlSB0uGkZyldmCrJYLVTBVUBQzHIjdZut/knwpxhJrcuBMBF5OyezhjRKXZECwoki+PEmt44tZQaFX/x3YpAhWrgscu/baknMxvuv+yU8Ut2Q0F+zUcrPmaBXlvARfUrNFQxX7NhMoNjIZnhQ0HjRGm7yl974STYA8lw8P9v5E0NTLOxLWioo9p06N8ATg/nIfNdvFKJLPnMuWusfh8ealpEXtVWxXHqBH8X0O1XZlTGt3xpIBuDSDi3sIp7U+tUJS/0UQT2kfHEp6cUVOLOyeTWI4eJA0czYtaMJz9zqSJf2+pYhDF4t23GpE1WKyqefGHAD+/s2a5b0+1JzjWPoD3OZSrTibclyM4PeCrpg3zY6XmkHrbDyRTK6dPbeTbYuD1AOHxpc0PVCGKvH1XQ+IrB3laNYy/1VxkwwGhjno0mBZwvvHwwv6e5S1NRXgKJf2ZA6A5rkJdq9tqDIddIVc8BQlJiFFrFFQ5c2z91kUy8ITnLPK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(1800799003)(186006)(46966006)(36840700001)(40470700004)(966005)(40480700001)(26005)(40460700003)(36756003)(54906003)(110136005)(5660300002)(7416002)(86362001)(4326008)(2906002)(70206006)(70586007)(41300700001)(8936002)(8676002)(316002)(6666004)(921005)(356005)(478600001)(81166007)(82740400003)(2616005)(47076005)(36860700001)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 05:52:44.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e378a51d-7016-438c-ba99-08db970a8563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AXIDMA IP in SG mode sets completion bit to 1 when the transfer is
completed. Read this bit to move descriptor from active list to the
done list. This feature is needed when interrupt delay timeout and
IRQThreshold is enabled i.e Dly_IrqEn is triggered w/o completing
interrupt threshold.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v5:
- New patch in this series. Just a note that dmaengine series
  was earlier sent as separate series[1] and now it's merged
  with axiethernet series[2].
  [1]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com
  [2]: https://lore.kernel.org/all/20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com
- Switch to amd.com email address.
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 7f3c57fbe1e3..3b721da827e0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -177,6 +177,7 @@
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
+#define XILINX_DMA_BD_COMP_MASK		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
@@ -1708,6 +1709,14 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+			struct xilinx_axidma_tx_segment *seg;
+
+			seg = list_last_entry(&desc->segments,
+					      struct xilinx_axidma_tx_segment, node);
+			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
+				break;
+		}
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
 			desc->residue = xilinx_dma_get_residue(chan, desc);
-- 
2.34.1

