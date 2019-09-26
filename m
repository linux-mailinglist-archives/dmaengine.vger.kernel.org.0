Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B55BF01A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 12:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfIZKvV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 06:51:21 -0400
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:31584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbfIZKvU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 06:51:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEweOsc8io5+K610gtB/a69Cew/k7sLbhxk5RVfAQIj5MZHQWr6EOr9UzVOPtYc3pCajSHuoYhRKf0s3S54vIklIX8AlCSANO0bp6crXZhpZsMz67wxt1BKD1HIZuAPkjVAo7UgpvBNyN7o4DUWvWRV/sLTGPTSWZDJbdTvFejrTkKY9iUNgZlrRosh2Se1cDcBnF4gnbRJ2GBO0PPbOJ0eWL61FY3rh17xoPKPd7E6iErCVP0AU/px5K4pE5ephW8/+kpKAb9ECYdGc5Bay0MN0FQTDGRKMjNvnB0bJ1jTMr6Xx2oSFQOSv/pll9eYavcMj0kl+39VUkL9BdThVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCNe1g/03bHYdTZFujD5+dkbDwnJYvEsIIATWkvPjns=;
 b=NciVEUxPscnc1ve0PRGaSrw18CuOEX/xPKNEmwuIxZdEFcx2b1W+4jcW72CygeHmdqTpJD8t3DUj7hgv4f91EA9ryTCYv6L0gpqQgpE0zVXAqMdqVuYmKRHehb/L3IiVqKZ38VjJlcVOXgVCJZMncHW55SxbqExTdUEDFeqVkv0BUecTegQtytmglepTfjMAIZtneaa03vAAzyW5MhEOdM8RzgV1Biiw6aAmtHU88/06NiQfBy0JVZ6N/MuZ20Cjsxld+qAVqn7eY7fFEeAkjCLpPGimYp18HiMzUidDoF0TvRXJ2pW0QLvBvoW33eNX2LBgmIy+hW6pomTUMH5Zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCNe1g/03bHYdTZFujD5+dkbDwnJYvEsIIATWkvPjns=;
 b=HAMy8SNWeqbJYMPA7jIMbCMbuBMg8EsvHbGKXhHPjIpLs1BII9M0jWypKNoOSDNP5N4usprRUcb0Mac3tXzMsTg/P2KrpXk4jzG1H7Gjv7KXe1o+1yzJD6LUO9BbOnmWKdrECI3f310a7qIES80W6amqUxhMTROiS53bWCXeN/c=
Received: from SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) by BN7PR02MB5169.namprd02.prod.outlook.com
 (2603:10b6:408:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:51:16 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0011.outlook.office365.com
 (2603:10b6:803:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 10:51:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:51:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47501 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMh-0004oI-BU; Thu, 26 Sep 2019 03:51:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMc-0001k5-7A; Thu, 26 Sep 2019 03:51:10 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QAp96n032140;
        Thu, 26 Sep 2019 03:51:09 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iDRMa-0001jY-Vv; Thu, 26 Sep 2019 03:51:09 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 343B5101108; Thu, 26 Sep 2019 16:21:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 3/4] dmaengine: xilinx_dma: use devm_platform_ioremap_resource()
Date:   Thu, 26 Sep 2019 16:20:59 +0530
Message-Id: <1569495060-18117-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--7.073-7.0-31-1
X-imss-scan-details: No--7.073-7.0-31-1;No--7.073-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(81156014)(36756003)(70206006)(316002)(4326008)(42186006)(70586007)(103686004)(6666004)(6266002)(356004)(48376002)(336012)(51416003)(47776003)(50466002)(107886003)(2906002)(426003)(76176011)(14444005)(11346002)(446003)(26005)(305945005)(126002)(5660300002)(2616005)(50226002)(106002)(186003)(478600001)(16586007)(8676002)(81166006)(8936002)(486006)(476003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5169;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1360ab-fa4a-4f84-af08-08d7426f74a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5169;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5169:
X-Microsoft-Antispam-PRVS: <BN7PR02MB516999EA82A8F66AFB673429C7860@BN7PR02MB5169.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IW6ZBaV2XGXNdOy9cNAT0aGVi49KW91KQyS0wTZv5EeO1JHeA7DwPuMpspd18pg1Alov0bc8NT64ePq63ijmQlxSt5rMR6xu0dEEoFF4gBTA7gVthgZCzFtFBjghhsXzVFsFZXbpvGTiU6GPhQcJyaIFlYAdrlzD3jQT09wPjOEBzSupyXez6bLzTvs1PMLDLpa30+dtsjarrwNxkJPPb7cU9v7Ko7XXU1bkAT+ZCLyN95hzsJuL5+ZjaC1rQS1sNk8oYa0u56k3JUDRfidZ+d50GnRQ3kdf1C5HrO8WwdQ5vcE6B5mo92EhFWJYGBKWcyWFM/wE0KHHEjDNOIQ/z/gdmuAoHOdnM2rhJGP3gtOnDhJdpvkCL6jiFDAQZYYK4H1TDkmeK898VMmuKj+8xcURB0BFuT4DdyMMgUybVrQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:51:16.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1360ab-fa4a-4f84-af08-08d7426f74a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5169
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace the chain of platform_get_resource() and devm_ioremap_resource()
with devm_platform_ioremap_resource(). It simplifies the flow and there
is no functional change.

Fixes below cocinelle warning-
WARNING: Use devm_platform_ioremap_resource for xdev -> regs

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5d56f1e..bc9979d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2612,7 +2612,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
-	struct resource *io;
 	u32 num_frames, addr_width, len_width;
 	int i, err;
 
@@ -2638,8 +2637,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return err;
 
 	/* Request and map I/O memory */
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xdev->regs = devm_ioremap_resource(&pdev->dev, io);
+	xdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xdev->regs))
 		return PTR_ERR(xdev->regs);
 
-- 
1.7.1

