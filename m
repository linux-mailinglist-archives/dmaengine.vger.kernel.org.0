Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF94F670D87
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 00:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAQXcH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Jan 2023 18:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAQXba (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Jan 2023 18:31:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8D68418;
        Tue, 17 Jan 2023 12:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgazXv7xNzgss8qoflF2r5TN4dM1FW86TAPGSp2dLbYZLS6ScShdbFhFQY2uH/UiRJ4mAUAteuY47nIAl/H68jE+DEhcu/p20ogWnAJ+KSvHEC89TEMdMueHBY5eomSeKfKnhXwepGpxp1DHbuJSj0WFMDdpRAur49p+9+kgCdClivPnh93hI0ERSWP1peP6UloBzaJOS8D6oMrsG0dj7kLP+zT8zqTaZCAKnkcH1z6iABG4v/x4VCJ46Gh+WfCdr3UZ09Yv9uxnYJe50XmiXSlfpG1iY6EcxwbYXaCxCHkq3yZ9Lg/Zr704yuvG1Ha1SJveRP8XuDXjzD2Au/JpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAzsiTpdL0SBjzJLE5CDWwht36IIvxDx+Yrel2ix04A=;
 b=SnCyZZfoda51lUXzrTpKfB+zCOR4v3cs1OLvhEuTSMSPlWlbMfPYZiGm2WztIqNwKZQHev59ZLwwoQUpUQKb63LV4b9t8gxTVWQepEd5xsUJO6kquD4H+mz/UVLoz5z3vP8PMZyQGQAMK9Nu1wbnNIGAqwyNtuCBv1yysVC4GDmB2vnrlLboKue4zpvX2gc/9E1AvTYaVA9pFNm9WMYJPp3CXlgr/x6l5hLEdm+ANWQr8IFlcLjzylq3f55H02a4+SWksL5Mykl3Kh1MXOIRsePGjwmpQhH3JGiREmR0W+1RSfca1Ppjaz5ywY6BVl8sVxKQwWZYgsDnehp3hPFkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAzsiTpdL0SBjzJLE5CDWwht36IIvxDx+Yrel2ix04A=;
 b=upCXqMSYIUr9gFsZqqMBEGeyy/n9aR6jP3oCyNuA/OvM4JABTcVLeQvX5T8p57kqIeQ7Kr/hZLfRByqk3Sq0u+NlFzgHgBWtUubq5HTBjZbvt3Y0k+ffY9kMgTXwd7smnKerBLKGcP/D6eUb0z80YNyvzEnzzZXel3H+fAq/owk=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:54:19 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::14) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:54:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:54:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:54:18 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 14:54:18 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <tumic@gpxsee.org>
Subject: [RESEND PATCH V11 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic interrupt support
Date:   Tue, 17 Jan 2023 12:54:02 -0800
Message-ID: <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160f7cd-c2fd-4459-3e0a-08daf8cd011d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwV/h4m0R+laqyiFxabreAOD098B3LgHWGUYpync0ceYTFF5xxg9YRqRzcAfYSbutGHEckrfqV8QGBZ0wW0OUZbifTpuPzK/5BoupKfN6QnDoAAQ71rBoSoyC9Qk51NvH4hy2WBM5V9/mPNf0lG5yzbIxevUroLbraS9wcpNes5zkXAkSF7s6VdOl6ahB1kIJrcZyFDTil69jlyyx6tqXwFIGqlW3Tv+GwVyAmmyLVh8qYK5HAuTJ+BwcMUqICfiTC1DCELcX8aO8KSCjcgsCLZ6r9TCVlL/gcjNFol7PcbBztdkaqrLhmK6WOI6mhNArV9G2s7CuBxiGEEoHYIhh7fJrrP8+L3apDkZKdxUJWPvMOZtqggHMlixhk2DT119XUQTaafYlnGmIv9WSLrNGfffyKMdv+446btrPNA//JhdCfl4GJEUOs2fBG9FTvl6Y3aOi1I4Ea78qu88B51KqKTcWI4wmZ0tMqWQq3UDfwwH9VoFMxt7U/uZlac9C+6mqQy4x2y4bZMl5rxPY6Kmh9nMCPeqY4Zo4jrNNRSkgjalGtIt0vJnGlTpiuC14cZ6x9Dv5Lheci/7vTfYaOxD3KnExrNACXTGbhVVT4u0d4M4OCviwHbk2j1hNYvkJIEvG/VSRKKEUXlj4X+cUb5t8xvNXXvqPLg2l5Pn5LDFHqGj/cQUFJdjF2CvwIWoxx2Z/yExMpf4HHc8fvaTH+IwnrzTgm3OadPoqSlgf8qxOYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82310400005)(8676002)(186003)(2616005)(4326008)(70586007)(426003)(47076005)(70206006)(41300700001)(26005)(40480700001)(83380400001)(316002)(54906003)(110136005)(478600001)(6666004)(40460700003)(44832011)(356005)(2906002)(81166007)(8936002)(36860700001)(336012)(5660300002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:54:19.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160f7cd-c2fd-4459-3e0a-08daf8cd011d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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
Tested-by: Martin Tuma <tumic@gpxsee.org>
---
 MAINTAINERS                  |  1 +
 drivers/dma/xilinx/xdma.c    | 85 ++++++++++++++++++++++++++++++++++++
 include/linux/dma/amd_xdma.h | 16 +++++++
 3 files changed, 102 insertions(+)
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
index 118528295fb7..846f10317bba 100644
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
@@ -713,6 +714,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
 static int xdma_irq_init(struct xdma_device *xdev)
 {
 	u32 irq = xdev->irq_start;
+	u32 user_irq_start;
 	int i, j, ret;
 
 	/* return failure if there are not enough IRQs */
@@ -755,6 +757,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
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
 	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
 	if (ret)
@@ -780,6 +794,77 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
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
+	if (ret)
+		return ret;
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

