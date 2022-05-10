Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C4520E95
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiEJHh4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiEJHRt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 03:17:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16262992C1;
        Tue, 10 May 2022 00:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNAbRo1+rSgOuYabRQr/RuQ2rssUOZHJ1TKpQpHDIxlCDprwy1aVecsEccDjMdV4Lbvz3Rebde4+xSgeeQfWAgOw4pXQ7i+ibG03mrnV/AeLUXrlHZzkJvEBuNqFzAH35suZrrz0wn0Sm6lmUACm3yo19GNk4pDJyMIU75colQS8Z43u/ermrm+JfY956Hs0O+fsdf6Z6mKZ6pfquYkf47jaZ5vG3bwIC/guq04APjRpiTT36dCjTBwpv1ITOIQ1V0ePiMtiPByHKqEpRx/hLBWkvLYPzqlhilUs58X4z5RpR/B686C3ghdZ65Oc0f3E34bLkT6cvHulhKakg+smSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en9H3aVtvkx1QAney08pqVctsYN4zFDaIdaPfwaeYIY=;
 b=F5XHW6GXPuQwwyElXkXC3EFjCdjW4CBh1BrPNOi86bzoFeK2IWT1CydVoLbanldZfl/CHXKsMk48XL9EqkuV9GLaEcDcWTieFMwU+k4kYdHnNSoj61z6wsDv4RyWwJCKPC34LekvM0a5zaU098n8pn+OABTx+M4VtNPhav5vztw4xWHP8g1Pc2CAiHZjfdA2yjRW9KNyHFXCw4Y/rQRns0x7wLkHBJPIOTosHZxGfLuvTwsEhihghpnjHQScn8fEhu7TwqRA7TXw456ydNPxFXqhan3aFNhLr5RjFuSTmJIIh7ft9onVL4y2CnZzeML6srekZHnIz1K/1/v6U1z02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en9H3aVtvkx1QAney08pqVctsYN4zFDaIdaPfwaeYIY=;
 b=h5NDJqwOakE+5cvyMKipIJly9E82Ncd2/+5y7qK83mt4oZ+2wtoXsGHIMVzi6KjeB89fAntkeo79+EhBhufTjTL40iR7MJ1nz7PWDQDXHnOGJsinQUU8L1wduOZ7gbYezLhcecLi3BWDsnVPBHDI04Vd6K8k/9I8CiHmUGMy9iA=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 BL0PR02MB4257.namprd02.prod.outlook.com (2603:10b6:208:4b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Tue, 10 May 2022 07:13:50 +0000
Received: from DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8c) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 10 May 2022 07:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT064.mail.protection.outlook.com (10.13.4.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 07:13:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 00:13:26 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 00:13:26 -0700
Envelope-to: git@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=41367 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1noK3g-000CdE-Lg; Tue, 10 May 2022 00:13:25 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id 9B43E6108C; Tue, 10 May 2022 12:42:44 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 3/3] dmaengine: zynqmp_dma: use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
Date:   Tue, 10 May 2022 12:42:42 +0530
Message-ID: <1652166762-18317-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1652166762-18317-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a5503a-2f31-45d7-ea10-08da3254a231
X-MS-TrafficTypeDiagnostic: BL0PR02MB4257:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB4257B3DB1DEC4FC44A294CA8C7C99@BL0PR02MB4257.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZ1/3KJsxnTotL+0Z98ifT67Qtwx5lmmEIyTINOH3AWuzRuEx7L9CUo/aHI0PufFWmJEPDd4L7iXlU7fnSVmxnmK14r2y5XYN69+Q+xReiKHKO03833yGCfX+CGV23asokuNvAfa8SbfE3nP79vaPxGKPyobL1BWjHJ79H6nf0dDGMH11GaTyQYAD2PpSaX2bqbW2zW4qkru8mNcoLoBWi6gAWxdhcfxD9fJWc3PiNhJs/pRBUXWUoBXEW00F54tTEpaNpSKARWQb29tMchvTWIYzLPxMZ3vn9onI4ND7BoDGX4sszEQRBYoBR8tA9on46Gplps3dUbKNMvZv+Qd2GLIr1dSmchKX2vvX272LEDAoK0R845w1BrYaYVH+UUiQwQTPcd0wpoEDFRg9TarjIkpkPCmosZ8jHwIv4ZMskVRV0dHawIqdTEWmih3xXLE4dOnPxgCHyVKxnY7OBpIPIoF+RodVoaDrXrY+0KEtOenoLG0/TwpbV4ETT0mxGeLYzhU6b+bEZ7G067d5LHQ72eHwa/PONQlkRLHvJUL0dQ3eMFL/K0hff2VRl4hnyH/1vgNdfOFQ0hxKRCZ5+d050iVu9CCAYlyEAQDHCX03coHdvFQuQCGYCk/wxeTr89BSzmlJzk/xV1px5KmKmD5cizzushD72QLGgp3BIdPWmKrjF6TTmRf8zoq6VUlJskv32HhVX3mc6Xr5lMWQBZJGA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(42186006)(6916009)(70586007)(70206006)(2906002)(8936002)(54906003)(2616005)(8676002)(4326008)(107886003)(316002)(356005)(7636003)(26005)(6266002)(508600001)(40460700003)(36860700001)(336012)(426003)(47076005)(36756003)(83380400001)(82310400005)(5660300002)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 07:13:50.5230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a5503a-2f31-45d7-ea10-08da3254a231
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4257
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_resume_and_get() automatically handle dev->power.usage_count
decrement on errors, so prefer using it and also implement it's error
handling.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 915dbe6275d4..dc299ab36818 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1078,7 +1078,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(zdev->dev);
 	pm_runtime_enable(zdev->dev);
-	pm_runtime_get_sync(zdev->dev);
+	ret = pm_runtime_resume_and_get(zdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "device wakeup failed.\n");
+		pm_runtime_disable(zdev->dev);
+	}
 	if (!pm_runtime_enabled(zdev->dev)) {
 		ret = zynqmp_dma_runtime_resume(zdev->dev);
 		if (ret)
-- 
2.25.1

