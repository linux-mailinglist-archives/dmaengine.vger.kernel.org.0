Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD312DD7EA
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgLQSNi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 13:13:38 -0500
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:15681
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731350AbgLQSNh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 13:13:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLsEsinl4jnMmMNpDQP1qDcNQkcCErkWdLAHexqpk1UC8UsbVQ9+Yors6ZJFTGVUJD99jGQItqLTy/oTqLORCCM9ryu+91f1iUAeHaWW6EBCnhzByTUeMFGZ3DgBe8oXZlxSIfTxt5glWW3RoiUK3jefa3QiffcmMPlay/BJ3lgJYrKBeQmMA2ENHiATVXP6B0Q7uV3BPsdQcW3Lks8SRg3j/B0PwFjoTjX/VKFOLDIwsxFMsQf9L+EAzeRsHE7jzsVyz8C5LIlNskoA4c8GdmOJniDCXM8ajrHjG5t0vC9UZWPgx9MMcoAXURZ9KyGeCpZJgxoBHLEEinp6tdhxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBTxI0H0rd0ytUGoR+2N3Nw6tlj8RwPC+P2QiYDsjpo=;
 b=FPO8VpFb3+Ux0AMRa3ReKs//muQKxqPOuYH2AInamXllFS7lGeH2n/K9IJjGst7zAUM6J9xAit3ovl6rKCnMWFENrlv9qGJrr+V+bY8jkN+REp1BX7cqRsqP9hzmE75m6r9QnRFLGRwn36U9oqp0dB93UPOQfj2gjdbqH3+SnS1UQCcFs6WB9/P0rRP2NC1FsFIlJb0IXSME4xqGxV9pfBw3XHTD3ThTqzCdS1xLHEjuAjdwiDrJPScRTt7J8sW0IAOPVVX1/l0i45zAuXlEdxCcUBY8b9qA+qr3D43w0lML4cGPoLAX+RQgYuCTfevi65V17HZ8926D+QbkhAvJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBTxI0H0rd0ytUGoR+2N3Nw6tlj8RwPC+P2QiYDsjpo=;
 b=l3TGPsdLWI38YeqbIcNeX0iNR3/MJBl6kR0RZSMefXE5sVGHbpqeOvO7SKJYSi1mdQJLCOT0Yfs4L5NMwZxIwG4CeomquvmNRD3E9s6DibcTXvVVGZyhCGO/qBpAaOdR/StmRXOYO4IH2G5ckj+KK7otmgs+tiHxC4WFU3pCLy4=
Received: from CY4PR06CA0060.namprd06.prod.outlook.com (2603:10b6:903:13d::22)
 by DM6PR02MB5324.namprd02.prod.outlook.com (2603:10b6:5:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 17 Dec
 2020 18:12:44 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::e1) by CY4PR06CA0060.outlook.office365.com
 (2603:10b6:903:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 18:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Thu, 17 Dec 2020 18:12:44 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 17 Dec 2020 10:11:43 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 17 Dec 2020 10:11:43 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 dan.j.williams@intel.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=52438 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kpxkc-0004oa-BH; Thu, 17 Dec 2020 10:11:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 6118012108E; Thu, 17 Dec 2020 23:41:28 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 1/3] dmaengine: xilinx_dma: check dma_async_device_register return value
Date:   Thu, 17 Dec 2020 23:40:13 +0530
Message-ID: <1608228615-7413-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa735f9-6b9d-4e70-6278-08d8a2b759df
X-MS-TrafficTypeDiagnostic: DM6PR02MB5324:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5324AB3122082085AEE7C040C7C40@DM6PR02MB5324.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVlEauUjPZwlCU39y9c7wODAi+ZeUEapSpIOFl6AuLBQoJPsY1YcvLf7BwT7DXaKis27PWPQKUKfc0ADFLYJT+GJ49ghCvMbxM2T7OZYZ51STrtZU7yTGmpmow+SbvoLEQ8l8DlhRvMdoZkh8aQUI1eHJvglMzlBbrSydEjurAVxMaF44/ZaZIECS3XI0tIqhMV6XyZ8LXx+ccTcNewUNZYSqcwosPLCvuZuaj4Fdl080N/mQ8Dec4RvlqfYSuW8iZjPY1xhNRWjIOqal2pegTc3KAaZrQXqqVNRX7V8F/U1LaTO2bd3V0Y1Dt0MCtafIAo/3GeJh28QxpF+3hxPdYZUOY6X8gN0JTv2NHX9U9sU/orazosvIbN4gGAPK0jArNZhCuRE1UMHHYddxC61XJkqnbs1henol+732ak7xYtTEek5oguDVfbtckwIGG8/uUPqnsYh7wZ+8dOJ/R2Gtg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(6266002)(2906002)(186003)(426003)(6636002)(8676002)(2616005)(4326008)(70206006)(70586007)(82740400003)(6666004)(36756003)(82310400003)(336012)(356005)(42186006)(7636003)(47076004)(316002)(478600001)(26005)(107886003)(8936002)(83380400001)(54906003)(110136005)(5660300002)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 18:12:44.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa735f9-6b9d-4e70-6278-08d8a2b759df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5324
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

dma_async_device_register() can return non-zero error code. Add
condition to check the return value of dma_async_device_register
function and handle the error path.

Addresses-Coverity: Event check_return.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 993297d585c0..e41435be5b79 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3133,7 +3133,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Register the DMA engine with the core */
-	dma_async_device_register(&xdev->common);
+	err = dma_async_device_register(&xdev->common);
+	if (err) {
+		dev_err(xdev->dev, "failed to register the dma device\n");
+		goto error;
+	}
 
 	err = of_dma_controller_register(node, of_dma_xilinx_xlate,
 					 xdev);
-- 
2.7.4

