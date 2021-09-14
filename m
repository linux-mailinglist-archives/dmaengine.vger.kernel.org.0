Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B005940A92F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhINIaJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:30:09 -0400
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com ([40.107.95.47]:31137
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230116AbhINI3z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Sep 2021 04:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3SZR/EQCaPEAFdBY5nPEcMUP9hUFg4jVCkiuFqXngnJkV2ILljms1wDrcTfDE2Oqo2zLcVb4wmMdqrb2iTfkMhCR4AzN9xoHhEbpFq8GAyKdlCUAIO0e+wyqxLGYlnIf5wADvFc936O3xG9ovluN4DEoiC28lcLY9q5//+iUKiva0rd50YMMjgZT61oNzUvMQGBIgl8nNHb7yROjx9ix2Vk30caYhxC2saRqrXvTFlt9WTT8ew0mbnejQCTj2CQFPNov3jae5OCiQozLybgbRYGZe1VcYK0BZ6+7bU5OFXvuehMR0cjQUxUhmiCQICFA4/VbILYnr0Mtcons03iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4dbZLk3Ho/PvecpjEqfBcT4ytFxuimA9E8AVIQgheHE=;
 b=FPB4lgGTBVc6AoH8wyb3iCa5cw+SRo69bXLSu4+GfsqTQQsrsyQfVqvpJuXCLWg8Kl1W/uNzLU2cKX2prWXKTOk4zR2OXLvBMcq7Uw1q2m8St18ZjHJ2/3TjS/SV00orw79rxExscztzyZKPiZqK2bCo0He2g+a0eG9ahlQyPkHNXOpPzCSudCAtHwRlmplSeJ2B/i38uVjlhBpdBmEvPLDZ2NVFJ3PMGRQkqbNy30f+NbXBkhGz0qf4islixtyt68pr/RVCXh5/heF2Trd7cf1Zwk234VQ+Ud5zzJbnssHZOZJgnlLLCAVi1SZlQT5w3y8Xmv62ea6bjgus+Ac1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dbZLk3Ho/PvecpjEqfBcT4ytFxuimA9E8AVIQgheHE=;
 b=Oyo42GMiUKL2jD0smo54va8NHpTPxDsq/uIizrk583sr4VmXm+1FXD+XzJ3WCe+lRmg8LsIUF02ILWuCoshV70tPKgnNw5N8F35qWbpLZ2myD6E5ZUksyhexdxDe8soz3Mr6u/Zu2R8Pnmzpou1x1LtZEww2h9sNRvg+tk0P7qE=
Received: from SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49) by
 MWHPR0201MB3561.namprd02.prod.outlook.com (2603:10b6:301:79::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 08:28:33 +0000
Received: from SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::f9) by SN2PR01CA0039.outlook.office365.com
 (2603:10b6:804:2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Tue, 14 Sep 2021 08:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0059.mail.protection.outlook.com (10.97.5.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:28:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 01:28:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Sep 2021 01:28:31 -0700
Envelope-to: vkoul@kernel.org,
 romain.perier@gmail.com,
 allen.lkml@gmail.com,
 yukuai3@huawei.com,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com
Received: from [10.140.6.13] (port=35510 helo=xhdharinik40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1mQ3nr-00094b-86; Tue, 14 Sep 2021 01:28:31 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>
Subject: [PATCH 3/4] dmaengine: zynqmp_dma: Add conditions for return value check
Date:   Tue, 14 Sep 2021 13:58:16 +0530
Message-ID: <20210914082817.22311-4-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914082817.22311-1-harini.katakam@xilinx.com>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf5d2acf-b1d5-4eb5-c095-08d97759a3a7
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3561:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35616385D202F78F21CB4AD0C9DA9@MWHPR0201MB3561.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvwD+b31qnUDcJITFI/qh/Cxzk0RxUsnaH3ML7FsVQCRMVLC7o/UwdHWG+5FAM0DmenCYx2RsP6H7ETc6scUWEKg9xb+zDS5A0Nts9VU/MTd3x7g7JafwhG6cvyY37WgcvqXFJ73jBFLWIbGj5jxUwx4q1WboSr4XjB0GF/gVkIHxPUZrBImRJZPAVBJ+/0+P0AffOMiQE9PcuQXDclEOKpYZcEFa9kSb58GA/fvTcBIHytFmh4e2haUnyYJBsrlYEQlQXg/XnbqXDkTP331Cn6NHR+8EMRlG0+JY4xYmf+Le+nNGqU49xMOL4DDQtHiDsS+75o2kCD/4ezZNBeKnBFkk8rbUf9g2rSV0DAkTnupPg5UU3uhImG7964ksX+Me99qFxBHUF4Z0Rcl6EHYJXJchVrtrLv1J9TzVThSkd+8WkbOj5sCLUizpHcTHDfrblnSVj1TnOD9mJyF4PEtbNSG9eoE6CqdFFrMm5JDZUqMdynR8DPLz6x6R0RJ/q08sIWvWb2i8v7Ne6dY0Z2fWXxWbY58L/5LUH23crx9GTOWxOv62mJK6TYNK6mi0FgfDoEfCGlCeN5htuLxIEWRnYvSSvRf6DYWz4b1DO2mF1l9WTgRPZSKufUYnMB7dFrWymqwLng4+4K36wQOBNBromE+SpA9MvvUcQjKTSVLXwris5Xhhuo0jB2vcArTXfvnHEHPHT7LVmxmtdii/4FUcGXc8x9rOJUk73cc1DLGCZY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(7636003)(478600001)(26005)(82310400003)(36756003)(1076003)(186003)(82740400003)(8936002)(8676002)(356005)(9786002)(107886003)(2906002)(4326008)(36860700001)(44832011)(5660300002)(426003)(6666004)(83380400001)(70586007)(7696005)(54906003)(70206006)(336012)(2616005)(316002)(47076005)(110136005)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:28:33.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5d2acf-b1d5-4eb5-c095-08d97759a3a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3561
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Add condition to check the return value of dma_async_device_register
and pm_runtime_get_sync functions.

Addresses-Coverity: Event check_return.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index d28b9ffb4309..588460e56ab8 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1080,7 +1080,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(zdev->dev);
 	pm_runtime_enable(zdev->dev);
-	pm_runtime_get_sync(zdev->dev);
+	ret = pm_runtime_get_sync(zdev->dev);
+	if (ret < 0) {
+		dev_err(zdev->dev, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(zdev->dev);
+	}
 	if (!pm_runtime_enabled(zdev->dev)) {
 		ret = zynqmp_dma_runtime_resume(zdev->dev);
 		if (ret)
@@ -1096,7 +1100,11 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
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
2.17.1

