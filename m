Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031FC596945
	for <lists+dmaengine@lfdr.de>; Wed, 17 Aug 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiHQGLm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Aug 2022 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiHQGLj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 Aug 2022 02:11:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B973F79613;
        Tue, 16 Aug 2022 23:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBekvz9igXUq5fyUkQWK96zNbd/5AgMqgFxci+tE23wNiPZsktAyV1bWI4dte5dvvi729PG7nM6n6gj6OPgsBuFf86lKkagZrNILXLzb/jDTmFWq1gZ2aTY8+v2A0WLsfPOeHRLoOWNRviTRZsbEAMa3qd8EehHSC0M1pkNOcX/Tl4qzria5/wRNvwA9+3j48nmvFsMWWrlbP9txF48yidaYFrJD2qNb/i+omsz73TQDR5EG66Hfm8JAVcMUi8CC+Ins4/mfLP6ctAwaAWLbue7UWqSlFQwqNqhfLVZ0bS8G27xtARd/pmAIMvDLTOMAUFNojOovWIimlfXbA9SKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3EVv2d4aphGOylGW5hVdADiw5bHG25A6kmbLQhrJo0=;
 b=eBxF3we32XKXJoUyuMya4DcPyjLO3QitdFszqEfFQ+RYeumhFt7hBM1p0tOvTwBjbOMBKj9l4PlsQnLDeSo8iRF232ystK+ojS1JJZjluWdwuDAwCEwcPGp0eJjHLdhxcoizAAmGGJMhik0PlRYIAt6I/J+Wh9aDCA9ebcFgM/Va98h1fomLAPoEaa02D+olz1UhXwq9OhC1rroWhQF7R6AByDprcyr23Q6LiljOaTCEBL36kzBbxrIUwGhrtsqcVaqygKXUWmVX+JLe4uucOXcvsX9+VD0UuNtTMJmFNd/Kw9fR4Up3ZLH5+pMieC1TE7cUZht9Wbtoo+jjd0hhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3EVv2d4aphGOylGW5hVdADiw5bHG25A6kmbLQhrJo0=;
 b=iqBAFRxEHiij2Kcb6l2kYcKpkW7Y9I87iT9qZJPmthZ2GPxCFy3ULj8+uy4W1QgYfuBPwYGC/8VzO7FrEYuuAXGMt5Lqqo3TSPWxUY/3rFCJ/36omx8VzXPTz+r8mzAFBOAHnV025HjzNg6SXbBZL/w64PqlSdr/aZbHXpGwzDk=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by BL3PR02MB8985.namprd02.prod.outlook.com (2603:10b6:208:3b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 06:11:35 +0000
Received: from BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::99) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 17 Aug 2022 06:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT058.mail.protection.outlook.com (10.13.2.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:11:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Aug 2022 23:11:34 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Aug 2022 23:11:34 -0700
Envelope-to: vkoul@kernel.org,
 lars@metafoo.de,
 adrianml@alumnos.upm.es,
 libaokun1@huawei.com,
 marex@denx.de,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 swati.agarwal@amd.com,
 harini.katakam@amd.com,
 radhey.shyam.pandey@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.78] (port=46002 helo=xhdswatia40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <swati.agarwal@xilinx.com>)
        id 1oOCH8-000GsX-DL; Tue, 16 Aug 2022 23:11:34 -0700
From:   Swati Agarwal <swati.agarwal@xilinx.com>
To:     <vkoul@kernel.org>, <lars@metafoo.de>, <adrianml@alumnos.upm.es>,
        <libaokun1@huawei.com>, <marex@denx.de>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <swati.agarwal@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <michal.simek@xilinx.com>, <swati.agarwal@amd.com>,
        <harini.katakam@amd.com>, <radhey.shyam.pandey@amd.com>,
        <michal.simek@amd.com>
Subject: [PATCH v2 1/3] dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error handling
Date:   Wed, 17 Aug 2022 11:41:23 +0530
Message-ID: <20220817061125.4720-2-swati.agarwal@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817061125.4720-1-swati.agarwal@xilinx.com>
References: <20220817061125.4720-1-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020ff5cf-0077-4dc3-1bd3-08da801756c1
X-MS-TrafficTypeDiagnostic: BL3PR02MB8985:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bdQTVh7SAGgHBYrEHWlStnrWsKgXzVHHlfEQjKvXWLPldIECUIL/7R+sQk16HeqgcR5sb5mDy5E2lz1iZj4dQ7s1yHF8SeWKJxuMNcBoHsEWyGJAMuIlgIiibrETiCSWqNZcPohqWgmTtfGF7jrSJt7w41f5juYh+/DB4X2VXcePxgWcPiIryzWnRgoX+wnGcOx6O1YZ8NS0gGtPddfQpGejikWtEPXEIt9hRa1XVqcQ7e2nkHH1RM3ld5V3Z7GR0AY51KoQEtrsym9axqFCZq0vW1TMgIeHH3xXnRoq13PA3ftVynI7WXO6IFbIQGDBTpCnNoOaiTvE8N3bFEmRReJaHwJysQQZJ+mUEi7tKXIopxrIIR5hQuhS/haF7rwCeRVIE02Z1CjV5s0y6PYLsqCpZbpUjK7Fus4a/O2u2G5We6SshKrSrkzcxAsPxYVChNKYGgJ9K64DpcyFGneu04exxcph1Ixc07aS0AH+YwhLbB8RwhjSrzUEwkK/+Yx2o3wr1O8ZOkItgeqwHv4F5gvvU6fn0YKlEAwJJLmSNb90zjtOMq8NMb8ZPBeJx4BV4AJvvYqaLeFr57eIK6pGEOJ6EKmcZAwrJSWlZend0bUz5WL8k9xZ3h8/nyn3w3aiHYp78WfH+7F765us4IGldrNBnrwy6v1+hSxYUyKWaXTSwnFbZ9SRMYjut1wHND2vJ2msasi7skMOXwQwlte0vd57yGyCM0BAhW6bAZ0QH4/cQptTlejkxrFpQ3i5gfm6sR+5HL9sBd37EYpAjNhVpDpZ0hCWPzr0SFuaDiYKc5BZGP3TNkjV76WquYCG7P/ZoWsQLO3GoRSoXOQ6mot8A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(83380400001)(356005)(7636003)(36860700001)(44832011)(8936002)(40480700001)(5660300002)(7416002)(9786002)(36756003)(70586007)(70206006)(2906002)(4326008)(316002)(6666004)(426003)(54906003)(26005)(110136005)(186003)(8676002)(1076003)(41300700001)(2616005)(336012)(478600001)(47076005)(40460700003)(82740400003)(82310400005)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:11:35.3039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020ff5cf-0077-4dc3-1bd3-08da801756c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8985
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add missing cleanup in devm_platform_ioremap_resource().
When probe fails remove dma channel resources and disable clocks in
accordance with the order of resources allocated .

Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cd62bbb50e8b..ba0dccaa8cf1 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3160,9 +3160,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Request and map I/O memory */
 	xdev->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xdev->regs))
-		return PTR_ERR(xdev->regs);
-
+	if (IS_ERR(xdev->regs)) {
+		err = PTR_ERR(xdev->regs);
+		goto disable_clks;
+	}
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 	xdev->s2mm_chan_id = xdev->dma_config->max_channels / 2;
@@ -3259,7 +3260,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	for_each_child_of_node(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
 		if (err < 0)
-			goto disable_clks;
+			goto error;
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -3294,12 +3295,12 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
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

