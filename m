Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3982E1BC6
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgLWLW1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 06:22:27 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:58368
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWLWZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Dec 2020 06:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxkAdsm2korOs6+5+HSqTozdYLt7nGqnU42V18Y+pP6xJCXGONcyzI6Hn+3zExZM7IUP3bop//R5e+YL2pHPRdmbCiT2RBWUcSub3sha+KxCjMzuBoHVrin53pNX3gScFe54hXwoyozetNrSEvEdLtMypJ4hrnhP4eXdUOpgC89R9+1DPhA0pYfNJvXDdzATyxODJ76iDhJ3/qDTxxbB+VWkuWMYQLzsoWtLuc4CPjsicVra5Axlg6HvqQY2bHVSBuEDk3Y0Of2eKgqiOwTsjGGvqaPzhmRJK2OwuDrFw2ICAGcyGOKv9Dk1dTvYAIR0m88J0p7hBkkudu5/tKa6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnumlq2tldUnERw2NocAmxRBZahxIHwfXutpmW6Xxc8=;
 b=HNvzcqt3Hnp/4a/7BREWZAtkOAaFfaoyekZ7ea0+wzl3IAYJha2rYeFZinTu1/+Q7J08qS73WXoIQOHIhUaCaqk3xx1cCPahxm7Y+bwtqEuO6kuO5hgvnn3prgSrur9QTmlnOFqNlyxpQYlzZzwlLDHtuofmiNc1eK4xgaOrCQbPKgBxTe7QxEnefo4p7jSurV/mFWKK4hPnbTAppTYn34f6rWCdxAuW+MboEouw5kFjSC87q6FBE8+oD2iHlndEU2/QNYEfe+QOtBK6f6b9GgP29lKRapFuMN9Bdb44fPiPfWgvR/fAbwOnH0sKCrxXgAJQua8HHqgnp9V6bJjroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnumlq2tldUnERw2NocAmxRBZahxIHwfXutpmW6Xxc8=;
 b=I8BMoAwJosBhzncVaPWdcFpg3rS0MqTfZRxRp7IfTzP5qyEbOPwLlT27Wo9hOXlaMtnZdyofozTvnvH81mIrok9t8e+Ant2jnBZVBoVRnae+u7EP5QOYuE7EdiT59GGk8S+Z/3Lo2DhPbWRt2s+V8QnQskdGIhG1X/M9o/kti+g=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 SA2PR02MB7580.namprd02.prod.outlook.com (2603:10b6:806:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Wed, 23 Dec
 2020 11:21:33 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::b7) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Wed, 23 Dec 2020 11:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Wed, 23 Dec 2020 11:21:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Dec 2020 03:21:22 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 23 Dec 2020 03:21:22 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=34637 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1ks2Cn-0007ij-VB; Wed, 23 Dec 2020 03:21:22 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id F0F11121098; Wed, 23 Dec 2020 16:51:07 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 1/3] dmaengine: xilinx_dma: check dma_async_device_register return value
Date:   Wed, 23 Dec 2020 16:51:00 +0530
Message-ID: <1608722462-29519-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a25f50bc-d19b-4c7f-4ab8-08d8a734e740
X-MS-TrafficTypeDiagnostic: SA2PR02MB7580:
X-Microsoft-Antispam-PRVS: <SA2PR02MB75800ECDA9E4A487877F86D9C7DE0@SA2PR02MB7580.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UH4iVDavlVgxTTLuCUN3xg0ueWHnMJvN5oPhzhQ5mhnSgqxYbk5xsecROWNGdpbND95nOkSEL7vPITx1WKnBOLTyfeTFlBac1+Ap/JiS9tmejdYxNnuJ8AQye2kCLiLohywMoz1K6c0eS/ZeotCQXpNEXlk3iH3kw9XXmDqlJELDOwzakjmvofox2G3qRNEnCj4jLASKtzMyPbo6v9IW9IijUaVdMjOPadHqo5WCPaxkV14WEMazYqZe5Vlyag8CXUw2uTLfPso+XIrQ+i+v0MPJLedUBVxtITpnDPotFfcwgIApIL5Dr8AyUDajE65J1SxKt9NfxBD2Pywn6VSYrwFoZI8X9BeKJ1HgmWZBk3OaBnyGwE2sL6JuKkoXjhIzbod57m/NxpNSWHqXumQJwIs+QfXo229sCadaYPRCYh6x+QekypWq15J2cVDsEPuUvx0Fb283X39Ll5BpaM3UIXBQtLDTR/z7xwbgR2q3PunTDfAQDYdy6R4itVl2GIBiL5ln/Y3+hZaR4rq6m7vqvg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(4326008)(42186006)(2616005)(47076005)(82310400003)(70586007)(186003)(70206006)(5660300002)(478600001)(82740400003)(26005)(6666004)(36756003)(6266002)(36906005)(83380400001)(110136005)(2906002)(356005)(336012)(7636003)(54906003)(316002)(107886003)(426003)(8676002)(8936002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 11:21:33.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25f50bc-d19b-4c7f-4ab8-08d8a734e740
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7580
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

dma_async_device_register() can return non-zero error code. Add
condition to check the return value of dma_async_device_register
function and handle the error path.

Addresses-Coverity: Event check_return.
Fixes: 9cd4360de609 ("dma: Add Xilinx AXI Video Direct Memory Access Engine driver support")
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Include fixes tag.
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

