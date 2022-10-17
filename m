Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CA60132A
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJQQEa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiJQQEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 12:04:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33D6E2E0;
        Mon, 17 Oct 2022 09:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu/UdMaWC7Wc9RtYf3mTz1H+jocykFqtJNV2N02ganIv+Tf+4Lqw/yyOzoTr66HiK8GmdeFAOG2zurGiTALEGgfMK8zPpEZPEAoZC1VAyljhIl7sp9nb6r1p+LyTPsp2gLz51mtk5Tvixwlw6B9kJ7p+EzOfEsFPH3rG7u8X8fQ0v3ZUltDDcUeHYhezlsSIWlKbHRBp1FYuSg7CxDvcfbMwkq3nynN/FJ3eTFjlGWsToPcyR7s6QYj6xBQbcpNSGBpp2sCbNDdld1v9aFuSWqiuhaybJ//FB4wmVnXn0UeeEqq13972LpGmSgx4u9F61SS7cD59jcf7TLbdQ+S9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=664N7wOuvn6e+bqMG60UPws27P8KgZSZf/gw02vHhXk=;
 b=kIu7MgJJZjqgmvXRMiXC5giTx3txrAbx4r8z8zz5LDe74foip7+Tukc7BRqbYldlLWsoKnJ2kALY0htR9xkmpuhH5h9W5AuBuoTbcvtCGr9dZ9gu8kqlHhtLt1bucs7ANXHZLmUAZMj+iLAGwIqOu67l6YnRkss3RFLqVj2PeT4t39N1QKAh2XQFSlkavWICywUDZYJbv5tPF08I1rp9WNYO1c/N6Z7XPY7397Q0+N/Z3qSI0LMTsyu+UJEhGmdtWmDqcPAdXGIK86OaYh5/UCepCSQQ57jliuCADLdLSOJK/eb63R/KrklpoqpekastbtiW4+oXuTH6a+slFW/U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=664N7wOuvn6e+bqMG60UPws27P8KgZSZf/gw02vHhXk=;
 b=RGxGRct+9IQkvIqoze53Qg/FQpGlMXK2e6Qc2ymRqVhCql8yYmjPcpTjbN9oIh8YTtaanMDnhJzveYh7A2ql9kGjZZtypiI6+doUjaReDz2oP/kebTo0DDbmOUhJhVWPZZBmniU/yNpo323xrJaSFIaoFfo/8LATWFnr26/HUvY=
Received: from BN9PR03CA0417.namprd03.prod.outlook.com (2603:10b6:408:111::32)
 by MW4PR02MB7474.namprd02.prod.outlook.com (2603:10b6:303:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 16:03:56 +0000
Received: from BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::79) by BN9PR03CA0417.outlook.office365.com
 (2603:10b6:408:111::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 16:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT063.mail.protection.outlook.com (10.13.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 16:03:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 17 Oct 2022 09:03:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Mon, 17 Oct 2022 09:03:27 -0700
Envelope-to: brian.xu@amd.com,
 larry.liu@amd.com,
 lizhi.hou@amd.com,
 max.zhen@amd.com,
 sonal.santan@amd.com,
 tumic@gpxsee.org,
 vkoul@kernel.org,
 trix@redhat.com,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.74.144] (port=32852 helo=xsjlizhih40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rootmail@Xilinx.com>)
        id 1okSaN-000FWV-Nh; Mon, 17 Oct 2022 09:03:27 -0700
Received: by xsjlizhih40.xilinx.com (Postfix, from userid 0)
        id 95427A93; Mon, 17 Oct 2022 09:03:03 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V8 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Mon, 17 Oct 2022 09:03:01 -0700
Message-ID: <1666022581-27279-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666022581-27279-1-git-send-email-lizhi.hou@amd.com>
References: <1666022581-27279-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1NAM02FT063:EE_|MW4PR02MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af9b157-d564-4849-d57c-08dab05931b7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYh64jJT9ryPDcidG+Cx8CLpIlrTwEUbIMwAmxei5w/IvJAq7AyEPW3OL3z4yleN4IzjAF/QUVyDtTJHSQsvoNhnaBccTFoeBu14dz/8qKcAEV9u+L6FLBzR6EzMhbNVNCHP3iBS3PTFHnvs9rKrumt7wqKYhPwGtk0DWBxIbiyW08F5gHhqhmXsL4QRasEcTewumGeeHdp95hqeqrHw58Pzhu0FC5FAJzezysuBqPqFCslmDshEuGOjwx69UP+y5YFg09lPJ3ViZCHLEjzh6cCermfw2YvjGHBKhVaNy180sgikIhxIyz4bShrHu7RTrnQhEfFuz+hDKlPjTSWSgI7h4k5/TzT7x9pK2aZczzXqP7LDLHlZ05AjUETTKPyDP8oeM8PkboijyZazK/uWBDozYLa5ulTSGLXms1Nf4Z/yo9x9QJb42YlsIhdOHwdCoMSZaminBUHIzIpmW8BwJCoiD1CQNu88S1onYZQS8YNLSY5ukZitCGWL3gdrgEiqPwYxLejsDuIJItNHqBO1gIwsKpXrmRh6s7wXQ6/D4Ltme+znQ+QfK61gtfnWsfP7EAdpaCCrCo/+12T8UTbGDAcOnTOfYLonZoJBrS+H2JdCZyYlz88889C3rrfDUJkuKB9CHdi//UWsWhL68c14MMF+YHj7bl2rcYE94nqHfBue3rT2YGJYqjMx0J0Qwb7/R1xKy9wO0nHeTRLr1nzDBiAXSe8QgaL14JCgixAQjeBNjoNQWQricINcTkSyEpH1t3Tp8ZoB1BGPyhd1gkiUNExQS24KNY1BEldE4EFhaUo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(36756003)(40460700003)(82740400003)(356005)(42186006)(7636003)(83170400001)(316002)(4326008)(8676002)(70206006)(70586007)(110136005)(54906003)(2906002)(44832011)(41300700001)(7416002)(8936002)(5660300002)(47076005)(2616005)(336012)(186003)(83380400001)(42882007)(82310400005)(26005)(6266002)(478600001)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:03:55.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af9b157-d564-4849-d57c-08dab05931b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7474
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
interrupt wires to user logic that generate interrupts to the host.
This patch adds APIs to enable/disable user logic interrupt for a given
interrupt wire index.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Brian Xu <brian.xu@amd.com>
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 87 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 104 insertions(+)
 create mode 100644 include/linux/dma/amd_xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d598c4e23901..eaf6590dda19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22583,6 +22583,7 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/xilinx/xdma-regs.h
 F:	drivers/dma/xilinx/xdma.c
+F:	include/linux/dma/amd_xdma.h
 F:	include/linux/platform_data/amd_xdma.h
 
 XILINX ZYNQMP DPDMA DRIVER
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 85ba306c457e..c3b08b3f131a 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -25,6 +25,7 @@
 #include <linux/dmapool.h>
 #include <linux/regmap.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/amd_xdma.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/amd_xdma.h>
 #include <linux/dma-mapping.h>
@@ -746,6 +747,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -788,6 +790,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
 		goto failed_init_c2h;
 	}
 
+	/* config user IRQ registers if needed */
+	user_irq_start = XDMA_CHAN_NUM(xdev);
+	if (xdev->irq_num > user_irq_start) {
+		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
+					  user_irq_start,
+					  xdev->irq_num - user_irq_start);
+		if (ret) {
+			xdma_err(xdev, "failed to set user vectors: %d", ret);
+			goto failed_init_c2h;
+		}
+	}
+
 	/* enable interrupt */
 	ret = xdma_enable_intr(xdev);
 	if (ret) {
@@ -815,6 +829,79 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
 	return chan_info->dir == xdma_chan->dir;
 }
 
+/**
+ * xdma_disable_user_irq - Disable user interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @irq_num: System IRQ number
+ */
+void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 user_irq_index;
+
+	user_irq_index = irq_num - xdev->irq_start;
+	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
+	    user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return;
+	}
+	user_irq_index -= XDMA_CHAN_NUM(xdev);
+
+	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
+		       (1 << user_irq_index));
+}
+EXPORT_SYMBOL(xdma_disable_user_irq);
+
+/**
+ * xdma_enable_user_irq - Enable user logic interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @irq_num: System IRQ number
+ */
+int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 user_irq_index;
+	int ret;
+
+	user_irq_index = irq_num - xdev->irq_start;
+	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
+	    user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq number");
+		return -EINVAL;
+	}
+	user_irq_index -= XDMA_CHAN_NUM(xdev);
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
+			     (1 << user_irq_index));
+	if (ret) {
+		xdma_err(xdev, "set user irq mask failed, %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(xdma_enable_user_irq);
+
+/**
+ * xdma_get_user_irq - Get system IRQ number
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User logic IRQ wire index
+ *
+ * Return: The system IRQ number allocated for the given wire index.
+ */
+int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+
+	if (XDMA_CHAN_NUM(xdev) + user_irq_index >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return -EINVAL;
+	}
+
+	return xdev->irq_start + XDMA_CHAN_NUM(xdev) + user_irq_index;
+}
+EXPORT_SYMBOL(xdma_get_user_irq);
+
 /**
  * xdma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
new file mode 100644
index 000000000000..ceba69ed7cb4
--- /dev/null
+++ b/include/linux/dma/amd_xdma.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _DMAENGINE_AMD_XDMA_H
+#define _DMAENGINE_AMD_XDMA_H
+
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
+void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
+int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index);
+
+#endif /* _DMAENGINE_AMD_XDMA_H */
-- 
2.27.0

