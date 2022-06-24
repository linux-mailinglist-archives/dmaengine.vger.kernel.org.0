Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81555938F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jun 2022 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiFXGgU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jun 2022 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFXGgT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jun 2022 02:36:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628E609E2;
        Thu, 23 Jun 2022 23:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3RLCueMGoppulPNMxFoJ+i8XkTZDrMrmvjvyKrT3sTgdCQExG+5EvKDELDXl8JxixSTIcghSsilpW2GVxOdJCKCx1uQy2mSpeGpHfXUy/TVYTtYknQfr9qswvcjJmdYpKkN0hGR97RzqMTTbD17PsKhILw26UdO/i1i5wQD55opOqqY65iL3JL68zILTiGJ2znIP/HeddHix/ptGIIoiXfPuoDmeZdGKp4LcaA15lMDc2K6VeBIz3uePYrzEkKTx0/qXR7SrvOTWl//JGzXRiJUAq1w1tdwpplMm9tQ4L5P3Iygx3j9o1O+Z4sEVatKdTJU0hG1qj4faq27geT/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbLbId8SMRxBB0uvgZqacyjm1tiuB6I/NHCjVGy+qwE=;
 b=KzNFDpKXB0lX7ekWA497mk2YRvzK1euTR7XEaA4co2pMbTWhBPRCoPKcWtGY3R3oQoB3SWQ0jIcHZF5t3RwT9oMR/Q3SCfawppZsu9Zp6SMqvZ5TxOfSIn1GUoJSJd4oSQ5/Pxdq7EF/yIbuGBMsxyO8akECdGiPr4kdDbPMhjJeR0F6Ytfd+6C8+aLZpwlFpErkGwa8ETQzMCg+4kQDGPzP0aJCNjfg9Yz4Hi2WAoFZsyp2bnRhD2HcXgOZb1hx3ja8G2ecIOr5iwr8rS18tpGTkBiufdTjEgyelbzcqkaSphCNjdOTM3BYwUz41plmqX5eljCuT7DI0WhYsHRG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbLbId8SMRxBB0uvgZqacyjm1tiuB6I/NHCjVGy+qwE=;
 b=fDAptPIhWHkoCal9wmvHJPKUFSmLIKJo0xRU7ChE9NAnu62yP6klk51IF6IuQ/M1ltbMaQCVCk6rKRVURjSU4s+6DOL8U/flXELXeMFG0UefDfhcfaXU98Xy+bbInfkFkrLWsehHoTsOAwCeivQjoqZYfE3Mp69aKCLqrWLiXfc=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by DM4PR02MB9030.namprd02.prod.outlook.com (2603:10b6:8:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 06:36:17 +0000
Received: from DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::d4) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Fri, 24 Jun 2022 06:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT048.mail.protection.outlook.com (10.13.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 06:36:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Jun 2022 23:36:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Jun 2022 23:36:12 -0700
Envelope-to: vkoul@kernel.org,
 lars@metafoo.de,
 adrianml@alumnos.upm.es,
 libaokun1@huawei.com,
 marex@denx.de,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.78] (port=39188 helo=xhdswatia40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <swati.agarwal@xilinx.com>)
        id 1o4cuw-000FW1-PH; Thu, 23 Jun 2022 23:35:47 -0700
From:   Swati Agarwal <swati.agarwal@xilinx.com>
To:     <vkoul@kernel.org>, <lars@metafoo.de>, <adrianml@alumnos.upm.es>,
        <libaokun1@huawei.com>, <marex@denx.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <swati.agarwal@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <michal.simek@xilinx.com>
Subject: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
Date:   Fri, 24 Jun 2022 12:05:38 +0530
Message-ID: <20220624063539.18657-2-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220624063539.18657-1-swati.agarwal@xilinx.com>
References: <20220624063539.18657-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a5c5b5-504a-49bd-5134-08da55abd78a
X-MS-TrafficTypeDiagnostic: DM4PR02MB9030:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tyq3WFgNH+HA18RMgSpUBngPmApiF97yCMN/ZhZcaCri94XIBwIOrMeJvtDQ6CkZtQsKwm9h0o4VHknjOJsfSLV8e7l5ii9tq4Mp3ioa3ogMarL5v+KLTXsuUnBgbjE/lISwsISGMTegUxXrLmz8SN+Cv1IcH1QMm+5wGdjNnzUG8507XolUXnql6mLTtGFrlaHbX6UlPwiSaOPFWopPnObkpk8YU0eymdSIwKzq2uxJ0E/lXbVPGHg4AIrPSPYxQJn/asOw1GECAYM4aTJWV82agyeNMXRVdqlYZHBwCgaX0U5gKeui61J0CtMnYAio17Wu73ubhuw4sp3jKMu9Tx9BlPd9TeRlVgcW2F/o50lNtqdkLwS34+lTWbPLT+73jQG/FIykGRjG6dp5IsbLrSnaB9EQD1tf+00UErLdPSKb6zDQWIWCJ+8x5jAm1Det9zGCeU9M+2tmQB0cer+dw2+NRbc7B9/ReacneQ0HJM0EFzrG4H0UNtMInOFL15AC6LdJcQMazR4jdLOzmbtE/Fbp+iiLzo2gX7iULkHqMAJPh29jArpavMKg7TMSEP05UrgTvATINNv0HvY9hpI1auL6VsE05NbqWEJ3LyJZaGX9iFGhreoKb4SqPfSg/a/BC4OAKXAdgllm9Ze1Djhr0ODNj01AMr2vkL/eH4hKOXmJtrCWYHzi0K7pWRL1ufobg9FHDC+0Vce2L/m6hIgqQjcvLtInyXL2edCs7EfdmORipzMZ7BDS5oIqApIjI4b4rzpAzvMYoA4DgTnORx68r5+9KoUvDCpYdyRAzVX5qvGfdcSCUn2jDnaT0/Ta7x64WzpbhNuU5a1gwQJBSvhOA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(36756003)(6666004)(54906003)(110136005)(316002)(7636003)(26005)(426003)(2906002)(44832011)(356005)(47076005)(336012)(107886003)(82740400003)(82310400005)(7696005)(41300700001)(36860700001)(40460700003)(8936002)(478600001)(9786002)(5660300002)(1076003)(8676002)(186003)(2616005)(83380400001)(40480700001)(70586007)(70206006)(4326008)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 06:36:16.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5c5b5-504a-49bd-5134-08da55abd78a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When probe fails remove dma channel resources and disable clocks in
accordance with the order of resources allocated .

Add missing cleanup in devm_platform_ioremap_resource(), xlnx,num-fstores
property.

Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cd62bbb50e8b..fbf341e8c36f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3160,8 +3160,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Request and map I/O memory */
 	xdev->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xdev->regs))
-		return PTR_ERR(xdev->regs);
+	if (IS_ERR(xdev->regs)) {
+		err = PTR_ERR(xdev->regs);
+		goto disable_clks;
+	}
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
@@ -3190,7 +3192,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		if (err < 0) {
 			dev_err(xdev->dev,
 				"missing xlnx,num-fstores property\n");
-			return err;
+			goto disable_clks;
 		}
 
 		err = of_property_read_u32(node, "xlnx,flush-fsync",
@@ -3259,7 +3261,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	for_each_child_of_node(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
 		if (err < 0)
-			goto disable_clks;
+			goto error;
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -3294,12 +3296,12 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_clks:
-	xdma_disable_allclks(xdev);
 error:
 	for (i = 0; i < xdev->dma_config->max_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
+disable_clks:
+	xdma_disable_allclks(xdev);
 
 	return err;
 }
-- 
2.17.1

