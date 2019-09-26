Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87BBF01D
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfIZKvb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 06:51:31 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:4383
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfIZKvU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 06:51:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAkRjbvycf0cvfM29i0tabvZuJpRz5xbslFGW34uzPKWqPyL7/W37whU4+yo9YnJl9R43N502ViGZQx/fN08Iuu1gfOHopCjnViGBMKU1BgihtHKaCPp0uv0KzFG1mEI2KSEmPTHMsNrRbsGgFI+CsU43gtb9OYDF92BQfTxBXij5z0VuTzs9I2UarR5GWqKikvX8EzEJfd+6Hfl+5bShSegEl7Ah2e2hty3pspdr4e2P0Qn6WAiFyFJdsB5yhZz8V6FVG2zTqjbyaAOUbhH29Z6KMDxyrY9yYMb+Y0Iw+h0/wKif+ooHbEUU0kiFV0aaJdE6ZhfXVWTuc5fhJm03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVVzpizLJWIrnuRiJy1CvjLpcuH6Ewd42PllTHP6aPQ=;
 b=WCL0NmIlOSMCS2cAQMx2GlWjCh3S/KoWKzsbb8NmWXB+VfUb2cUzub0m9IVAXvLxmpO/e6Md/vaoH5ZnX31CGMa3yoaRGl2shlrTa1w9deGPyesOCkgv5Ugbze/ggnsATqJV/HwbB988K7Dhqdx/+lxA2DV+zZPBW+5Cx3RDyKp8XxZGGZja7vKXEIiuBeLz4trEG310aXRMNhmUP2yiNi2Ej8o58bqriwT4MpFM8GIoTki7CObxwztdwlTlZ6X+mJd0VqRQxG4mNUbQSMZNjMqGtsYYYCfBY5OyyqCe0Qotd3ADLXuv71ybPdDMb+nQfTU81Ya8EsgXWWiJIV71Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVVzpizLJWIrnuRiJy1CvjLpcuH6Ewd42PllTHP6aPQ=;
 b=pxROX5oOhHMZBiCZdYqxdVNCIde5tvQgtha+EYfeb7yFDNxlP6zbYx9iHm7YSGXFt9O2qttWBOXKEl1TYNYoUVFNRaP//jMSk5+WYeKZ6eXeEs4hG4h7HI5ZXALYzQI3867Q1+DLCC2blSpsLUN8RBV4Q+S3WfwbU2ZEw/jq8DM=
Received: from CY4PR02CA0032.namprd02.prod.outlook.com (2603:10b6:903:117::18)
 by DM6PR02MB4668.namprd02.prod.outlook.com (2603:10b6:5:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Thu, 26 Sep
 2019 10:51:16 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY4PR02CA0032.outlook.office365.com
 (2603:10b6:903:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.16 via Frontend
 Transport; Thu, 26 Sep 2019 10:51:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:51:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47513 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMh-0004oL-F7; Thu, 26 Sep 2019 03:51:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMc-0001k6-BC; Thu, 26 Sep 2019 03:51:10 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QAp9LQ032142;
        Thu, 26 Sep 2019 03:51:09 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iDRMb-0001ja-0l; Thu, 26 Sep 2019 03:51:09 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 3B4D610110A; Thu, 26 Sep 2019 16:21:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 4/4] dmaengine: xilinx_dma: Remove clk_get error message for probe defer
Date:   Thu, 26 Sep 2019 16:21:00 +0530
Message-Id: <1569495060-18117-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.677-7.0-31-1
X-imss-scan-details: No--0.677-7.0-31-1;No--0.677-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(8676002)(70586007)(81166006)(70206006)(81156014)(50226002)(478600001)(47776003)(4326008)(426003)(486006)(8936002)(36756003)(107886003)(6266002)(51416003)(76176011)(336012)(126002)(2906002)(356004)(6666004)(5660300002)(106002)(316002)(15650500001)(305945005)(186003)(2616005)(103686004)(26005)(446003)(11346002)(48376002)(42186006)(476003)(50466002)(16586007)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4668;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a7f563e-0b70-4df0-0690-08d7426f749f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB4668;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4668:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4668D1779CB930FDBE9076FCC7860@DM6PR02MB4668.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sp8CA6XG/CD+1ULp7tXi4UWAYJiZBPnWUCS+yyXp7hdcywbFe/n0/hMbFJwb35t7OzNsr4KgTRSDyAYmtxCS0IKTJe0wSK/F9xG4xzLIq0H5N7E94NbaSYJqboM3Ym4cywhtyLd9Zq3hrqTT7gmUD1XcRNqH1BM7EQ45b+EorxdVXj66TI3LtOTX270y7GuS1inLwOxBKcTb2TfHYU1UPV3TxCQrzUFUbte3LZcd4Mc3KrcANxcnbvhjxihz2iAAy+zKwZrqmuoM02PMjFXRVdKekyokDdrZBoj4qEwy13bLTZWh5N8+zX0LpZPCxBWrq+ulyId0zBG109aKLqIBPeF28pKqzRlwX924zWwnOmPGTSsXx90bq+gKnNZaCHrJOmgMaBWNyD8LvvqUyPir3bhRXvRXklwzQQ6M294T1O0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:51:15.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7f563e-0b70-4df0-0690-08d7426f749f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4668
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In dma probe, the driver checks for devm_clk_get return and print error
message in the failing case. However for -EPROBE_DEFER this message is
confusing so avoid it.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index bc9979d..440f2ce 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2194,7 +2194,9 @@ static int axidma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
 	if (IS_ERR(*axi_clk)) {
 		err = PTR_ERR(*axi_clk);
-		dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n",
+				err);
 		return err;
 	}
 
@@ -2259,14 +2261,18 @@ static int axicdma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
 	if (IS_ERR(*axi_clk)) {
 		err = PTR_ERR(*axi_clk);
-		dev_err(&pdev->dev, "failed to get axi_clk (%d)\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get axi_clk (%d)\n",
+				err);
 		return err;
 	}
 
 	*dev_clk = devm_clk_get(&pdev->dev, "m_axi_aclk");
 	if (IS_ERR(*dev_clk)) {
 		err = PTR_ERR(*dev_clk);
-		dev_err(&pdev->dev, "failed to get dev_clk (%d)\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get dev_clk (%d)\n",
+				err);
 		return err;
 	}
 
@@ -2299,7 +2305,9 @@ static int axivdma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
 	if (IS_ERR(*axi_clk)) {
 		err = PTR_ERR(*axi_clk);
-		dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n",
+				err);
 		return err;
 	}
 
@@ -2321,7 +2329,8 @@ static int axivdma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 
 	err = clk_prepare_enable(*axi_clk);
 	if (err) {
-		dev_err(&pdev->dev, "failed to enable axi_clk (%d)\n", err);
+		dev_err(&pdev->dev, "failed to enable axi_clk (%d)\n",
+			err);
 		return err;
 	}
 
-- 
1.7.1

