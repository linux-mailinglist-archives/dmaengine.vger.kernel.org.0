Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5325EEA5D
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiI1X6k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiI1X6i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 19:58:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAE10D0F5;
        Wed, 28 Sep 2022 16:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FslrNVQNCDZbk6y+XR7EWFQ37O/FA0RdsMweWnt61LZwqDDegBEXwZm1NXGE/i2ptrqfMXGWKW8lI5A9ax+rmNhWAy/4JpepfZpoHpv3dnjJXbJNEFsCGzUvFNldz5dAOkbYnBPwG5+Y+0CiBg3ThLHcifplOOdG5BbHYgkzSoMHEy0w5Uok69ES2gBjkR9yW4WN2NLqiDk67O0zDLciZSfQrkBjJGCIh6Z2yK9f2aPxiYBi9dA/NlLeridAgC7jKmDZERmwnmbhX2gjE+NDsLTNdmzncu4fZk6ocru8AeMFOzQqhzL9MGgSozJJ7xJZfIYWIHyPBuBiswGybK+ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E6DQoiTIlpM9CQ02oCMs3RQoaVXGXvUAsTI5P0s5o=;
 b=DMfDz6bodWHvEnbcOzkfhMi81n8welcUzTAqJxIpBZ+dBah13r0WsNZllNxaVT1JJZmQWoAhqMhth/RqMrWzXC8XpkqtN13QztYumY66i+EeNDPgBkQ8AWI7Ih3lyb7f3E7MrTSK0+sDgtBEnRUQo0wGMSKhE2vBt1eD0IJuMnd2LwAGYIFMyiaNIpkmJy8M/YiqwHpJfxxVUPPAtmMs/tP/2qxjaFQIxFdZdhNF4rgmUU10cBJO8dKxla5AVa4PgsF4m0xA6xDd4f3qpZh1tKUBUrziqxR4LWo+f1YNhj+hodEniVeJ+bKZYeCtJIP7RH0ZOg8KzYNOxeaKVoIoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E6DQoiTIlpM9CQ02oCMs3RQoaVXGXvUAsTI5P0s5o=;
 b=aDaqjYCy6tXIFq03I8xdg2s+O/BgaqN7KYymin9I+IKwOaw1MSIp/wJ8jGwYx3YKfVUHFiLG9NcQ7xISDsGMW/BAkP5Tl8VqYe/Q+XUoqzebV64cDOd9xpNyOijr5SYiF/tmpgXAnvi/feNfPP8KFeRJZJaEnPHoBzbJKs5pQok=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 23:58:33 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::44) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 23:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 23:58:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 18:58:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 18:58:32 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 28 Sep 2022 18:58:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <tumic@gpxsee.org>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>
Subject: [PATCH V5 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Wed, 28 Sep 2022 16:58:27 -0700
Message-ID: <1664409507-64079-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: acccfecb-04b4-4621-e367-08daa1ad59e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeMUVbNfVp9gN9P0ozDECF1H/sus+/71FEIpJmxTveDnN7jh8hwTjXjcbMyrkqJ3wzWjCEVUXKq4y+piF6EZur0FleUJoPlHabPCcg/5K1YOaRXJHsB6+8DAuYJVpGavT89qIgRNaXU3xsUMZi1h4V7oBiu0eOWOWPYB9IrCrv5klG4o694uw2bT81CzTEKVojWKIKberJo4NJN/2oHqN6DwrlVBrsAuABXIrWhn20eXx0aq6s/AFwSTs4YD8HiA2b4g/0yef5wa8+ynbl72LMC9eoeRDBCMMm3//qfThOW9hLGOnebobEUMmTUCjp3r4bTy/N5Y/6ussayGUd99WBg6AQhyNgvrm1rzxXGh+OucUdomx93wOaVVwrvirIub13jvG/uBDMzGt2PTfZu+8M1mjNkSMDd/CgQRnaiPiBkyKIWNhdBcvzBgmWPdW5JCKR9ASArAOkciVyBbWq0BQ96sdKxyguQd9TLRGh9yOUoCAwkSWAl5vAZZV+J4LHFTZtL7n1+8/j7XBGgB661UlZgQqPktRK6J89Utf1ZQTdmdVDUmaIzSrd7f8VRFW7UyicmOKGAHBl9OpXK1BOlwglSIXlMZb3rHIudDe9eTHq8uf8TxNQhweILiZ6tn/Qmbn8L2Vo3NikX9uIuugS0viBOPvua0phbBWpkUyD0mlJye4BXMocnVZyJU6PNXfbm7hD4qrXFxtyAezDbKwL5hGlIUbUgdQkzez4PkBm/ACmljFY46YL2JVy4b15p2bnFE28OgEdZ4umtLFbNdGUChJtWVi0wMlet2FGUQlJzZ1GsX2O8iBaZp2ARGf+GbLofw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(82740400003)(86362001)(82310400005)(81166007)(36860700001)(478600001)(356005)(8936002)(426003)(83380400001)(110136005)(5660300002)(40460700003)(26005)(316002)(6666004)(2906002)(336012)(47076005)(41300700001)(8676002)(36756003)(54906003)(44832011)(40480700001)(4326008)(186003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:58:33.5636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acccfecb-04b4-4621-e367-08daa1ad59e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 drivers/dma/xilinx/xdma.c    | 65 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 include/linux/dma/amd_xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c1be0b2e378a..019d84b2b086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21691,6 +21691,7 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/xilinx/xdma-regs.h
 F:	drivers/dma/xilinx/xdma.c
+F:	include/linux/dma/amd_xdma.h
 F:	include/linux/platform_data/amd_xdma.h
 
 XILINX ZYNQMP DPDMA DRIVER
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 58a57e03bef5..13f627445c4a 100644
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
@@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
 		goto failed;
 	}
 
+	/* config user IRQ registers if needed */
+	user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
+	if (xdev->irq_num > user_irq_start) {
+		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
+					  user_irq_start,
+					  xdev->irq_num - user_irq_start);
+		if (ret) {
+			xdma_err(xdev, "failed to set user vectors: %d", ret);
+			goto failed;
+		}
+	}
+
 	/* enable interrupt */
 	ret = xdma_enable_intr(xdev);
 	if (ret) {
@@ -816,6 +830,57 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
 	return true;
 }
 
+/**
+ * xdma_disable_user_irq - Disable user interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User IRQ index
+ */
+void xdma_disable_user_irq(struct platform_device *pdev, u32 user_irq_index)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+
+	if (xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index >=
+	    xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return;
+	}
+
+	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
+		       (1 << user_irq_index));
+}
+EXPORT_SYMBOL(xdma_disable_user_irq);
+
+/**
+ * xdma_enable_user_irq - Enable user logic interrupt
+ * @pdev: Pointer to the platform_device structure
+ * @user_irq_index: User logic IRQ wire index
+ * @irq: Pointer to returning system IRQ number
+ */
+int xdma_enable_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			 u32 *irq)
+{
+	struct xdma_device *xdev = platform_get_drvdata(pdev);
+	u32 user_irq;
+	int ret;
+
+	user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index;
+	if (user_irq >= xdev->irq_num) {
+		xdma_err(xdev, "invalid user irq index");
+		return -EINVAL;
+	}
+
+	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
+			     (1 << user_irq_index));
+	if (ret) {
+		xdma_err(xdev, "set user irq mask failed, %d", ret);
+		return ret;
+	}
+	*irq = user_irq + xdev->irq_start;
+
+	return 0;
+}
+EXPORT_SYMBOL(xdma_enable_user_irq);
+
 /**
  * xdma_remove - Driver remove function
  * @pdev: Pointer to the platform_device structure
diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
new file mode 100644
index 000000000000..91fb02ff93a7
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
+int xdma_enable_user_irq(struct platform_device *pdev, u32 user_irq_index,
+			 u32 *irq);
+void xdma_disable_user_irq(struct platform_device *pdev, u32 user_irq_index);
+
+#endif /* _DMAENGINE_AMD_XDMA_H */
-- 
2.27.0

