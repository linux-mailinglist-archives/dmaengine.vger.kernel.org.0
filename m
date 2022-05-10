Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38E520EAC
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiEJHiE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 03:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbiEJHRt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 03:17:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790B2992C3;
        Tue, 10 May 2022 00:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx70/WcheeXf6mpJknxn5X++HT/xeRF+873UVyl6lELwbS0VcGM20lVa1DDpNUjXj4X+4lOaPDtbreVOH4Z54S3bByI1tz16AYuOf4nlL0cWjN/OGBaxlAL9ROJPA1WQko3KsvFZ2GvvInRQkKN87bA10sFhINL7gt/D+Zg7VJsQ4T46nwliH0GJLTeDPNmakeT/sq8Jp4vuorn8rgltSptik+Cn7cKB4pcCYv/t2GeEXL4tgZKO/m4A1Z/MMUu3b1tewlM4wMiZ8kakxxiXLWL23VCJJxRBQABOnJ1cInQSXQiHdxz2sYkh4U3+YVk77hCNg8Yztlfry0iQpZKTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj6VaFGOxX2wvlNQK1WAGRfAy5glVjX2XrpAkbq0RkI=;
 b=djD/XKTVt8UkpaLirh9lxpvfNtNjbwwprSdsFaEvOcVLAhu2s33OlPeJkfBM0CWruTk9Xy6CUFy3u3KDYQralRscPDUb3nCaopUOCNIpWTv86hsXj8xGd8zUh7yBqOZRgXa/bomOVgyRlZlDQVus+8pfxNMTkn8yP/RLrv0Hibob78WvPUvuIogkEqsjLTMPVWUmvoQw4khZCugkfmlHGIr7hfu93iltmoyackygFufSnXKJ0Eq0j0995RPgizVxV6panO8B35PvPd4OK1f+7IkYr0pYCxsug1vBEzxcaRCc/4s56ufV9UaY/ey33o1Ny+2OVK74np7oTrPEj0dC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj6VaFGOxX2wvlNQK1WAGRfAy5glVjX2XrpAkbq0RkI=;
 b=bzZTH9g/AqIGce+JP1Wvr0JZpElgQvsF3MG67jB484suqLrHCET/wXf5yLCrrvN7nXXxY0GX8bXjRf8KSAlNKBM01Cb0cTopC4PiaEmsT2C+7lyWre0cxQFI6Oqr/AYku7UnE4vrZU1BS5uKRdmsWdHlXYCACBXQRSoN/FdaDfs=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by BYAPR02MB5207.namprd02.prod.outlook.com (2603:10b6:a03:69::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 07:13:13 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::6a) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 07:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 07:13:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 00:13:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 00:13:11 -0700
Envelope-to: git@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=41366 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1noK3T-0006sq-IL; Tue, 10 May 2022 00:13:11 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id 95B596106F; Tue, 10 May 2022 12:42:44 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Shravya Kumbham <shravya.kumbham@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/3] dmaengine: zynqmp_dma: check dma_async_device_register return value
Date:   Tue, 10 May 2022 12:42:41 +0530
Message-ID: <1652166762-18317-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504718b8-444d-4192-3d49-08da32548be9
X-MS-TrafficTypeDiagnostic: BYAPR02MB5207:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB52079D44C6B3CB33A598EA49C7C99@BYAPR02MB5207.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yfa47a92xL9hFfc4pFONUvKVRc/F1ZE8GOPpkm/twkJTvt60xti76+qaYSKMb1tVvJXpk1NIrjZjDTPHHua4474qhoZV/eJKzXNS3VIt1dr3SpkmN+FkN9SxQ5qOYkBiUjSXC3qWrkzikCl+ArPuS5fx0+Z5PjajdWinMqvazY2PIRk/ilUT1sL3rREy8a0SIV+jtvF8xelm6qC4dhvkLrSrG24EEunvyc6m+VJKd/y8RDprqgkC+iI7WSl2qrUQ/L1qwwFxfAdTcQyQVjkfCXlXRo+sAaPsBHRSh9UFVmL4jEN2o20/uIyS4SXW+kUKVq/tJjzMU/FBrsuv+wYMRLwVRQZPwDRXA/0FId4982oYNNiv7XQ14eqrSN0Svb4y1yPc9hw+le5mfrERdIrNKYojd/0c5hmA4M0deHdRC1x0/vFgPcyAj27UXaxdviguXoZrSSef8wY8YL5fvwtpQbd2d8mgVmeNVeIbellaba+jRM164HfrgQSseyHy2GHc6BCteGcPS+skRN17lk+CejoaJu49Mi/NF2XD3IEobN5VBd0DaagS+rTJlHNS4ewizWRMyv6lVUtUgmTM1aYv8onSCcNZ5T8AsQLCRHziGwpFcKKsmX8K6CQFaoEuQQz3/iELpKwCPgF8/dPJAsXIqLhB1UTjR+1HsGtPYdBld0HSoyFR17pja+0MAPbHzOPKZ0VdHXvZh5FK+kYwvXi+ow==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(186003)(6666004)(47076005)(336012)(426003)(508600001)(6266002)(26005)(2616005)(107886003)(40460700003)(5660300002)(8936002)(7636003)(70206006)(70586007)(36860700001)(6916009)(83380400001)(8676002)(4326008)(54906003)(82310400005)(42186006)(316002)(36756003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 07:13:13.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504718b8-444d-4192-3d49-08da32548be9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5207
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Add condition to check the return value of dma_async_device_register
and implement its error handling.

Addresses-Coverity: Event check_return.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 3ffa7f37c701..915dbe6275d4 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1094,7 +1094,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
 	p->src_addr_widths = BIT(zdev->chan->bus_width / 8);
 
-	dma_async_device_register(&zdev->common);
+	ret = dma_async_device_register(&zdev->common);
+	if (ret) {
+		dev_err(zdev->dev, "failed to register the dma device\n");
+		goto free_chan_resources;
+	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 					 of_zynqmp_dma_xlate, zdev);
-- 
2.25.1

