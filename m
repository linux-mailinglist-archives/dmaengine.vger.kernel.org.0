Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5544C4612
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 14:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiBYNWn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiBYNWm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 08:22:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313C7194157;
        Fri, 25 Feb 2022 05:22:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzpK2E9n0VsSB87v+bzL5obQqETQEiZrL0iaeK3Cd6nzmDIq5plL/jGge6pkAV9RbQs5Z8H9rh6Hc5assIlb/HGvbGzTZLjzhbLemkspTtGLvZ1kG6cGhSHhfsvEIG+5IEgKwMpH+Z4VxcYOMGhIrRR7+aszUupsINCAhK8gI6V7AIsAYNCpWblMqe6YOMmDRoGt+AveK75/CSSn3+7QX3c4WJf0/vfwPZBN8tu4ILbWrYsv+hvrVoSPROC3GQwJdDMjRopqGvzgIs8nU1KcJXXLT4BGjeBTXWeg3Fucff3ZUeMiD6NzVK+eLDTR1eYcrJEOn2xAUNMnwYwmm1Zwaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0sQMpJlYD5+WbItnLtgXTknLO1NC6d9aOQv3LcwybM=;
 b=H8aJZstC9K5W5ZgshVhb+ytargoDYvPlw8TNniX7SM3krmUH1US7mzCpzbFona36IYjAj1A4RxNFgWpfKdtaI3lScdaxtCo+d6HUwzT3m5enyl29BfYfc0RIPLEFNBhwH40csLPT+ScWeuQOpcYErQXQhUhHM2vF9BMv2P5MmtSJGIbro9dF6I7aS8cOImSyAsPg0XP/5m+pR+BvGUOLF7mINqdwYJZOjJPb2RpgMZPTS1LRx8okiFZ60MdfDExr7utGTiEfhTBkK6zCG4komRqKY+AKo213lgwkP0N8+FDhHNgtQ7C3WUkxpn19UNZ8mJJ2tA0rtYws0XJ+BID9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0sQMpJlYD5+WbItnLtgXTknLO1NC6d9aOQv3LcwybM=;
 b=SdopO29f1XOWjCZCUzprxSHUNgxugWPnyO/xQc3FvjKCaQ6izAU4eOmtPnD1lGFaRIBkGW385Gy6q1MriRS8lcxtCl9ZncXCU0UExWoqkr/lmpzoM2yjkFT93LlRQNNHzPVkInXAdIdIStmvfM1gP9Mfpn+4eDs8JOe8jGohRPCrWhA+em+lsXHijCLJH1f6yN1ymkpMiYWJX7qtoLj6jRgjM/dXV7kfkdd96M6zH16rSVoF6xuzncmHv++SY8zDDxIEnYikTeH3heVmlTFf/n3/CJW/b21iHu++LV5CWRzNzWw7nxZtDwisLfaXIgSpcspOQKJU0EKYH9gKR6Epiw==
Received: from DM5PR21CA0055.namprd21.prod.outlook.com (2603:10b6:3:129::17)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 13:22:04 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::16) by DM5PR21CA0055.outlook.office365.com
 (2603:10b6:3:129::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.11 via Frontend
 Transport; Fri, 25 Feb 2022 13:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 13:22:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 13:22:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 05:22:01 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 05:21:57 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>, Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: [PATCH v22 2/2] dmaengine: tegra: Add tegra gpcdma driver
Date:   Fri, 25 Feb 2022 18:50:44 +0530
Message-ID: <20220225132044.14478-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225132044.14478-1-akhilrajeev@nvidia.com>
References: <20220225132044.14478-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9836a87f-5174-4d5a-40b2-08d9f861d0c3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3766:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB376693DD3BEFF0A8B159DCF4C03E9@CH2PR12MB3766.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlLiqienxiImgeLxh/0+17wFRk9yQmAOAoR+6f4/y9V5hnS1tVFRfD3jukVtVoispBQO7I0g+TAh5zWELCQjmRv5mCWS9FQ5Q15wSVmEe6WN/khzCm03p+d2cSXE6GznfTeWOXzMC/DkISbSd8yZfiTcj0CmAh7aVq29MPhrkpFz6kOfsryZdy8wXcEmgxMm+Q2G99Mr25H6VL/E55cu5G1jgJwVTBUKRBvljA9PrPX5VOyW4i7+vE1dNoUeEdrrexxLPcofi31lXZ1zc2Wu8OIT7fiyBfjaON0pXGS+iOrvta5WvCDp4hTa5mX4dIA1/vr1yzia3e2WC2uhuUXe/LMqnaNl5tBvZN+q2z219+4aDr8JDnxd1sqjgrdbQQi3daxj4TTNW0Tu1hv6Bc5txLpE/bc1FsETab4pHNJQ5cyy6SIoOwtyOexdMuhmwUIiy2yb/cfKjr5klX6kknh2pGGNRxZALLd/63depHoZhAzcUr1weFL03/GpDS4n5M+s/QOfC6erK0/tHKSp8l5k6tdX/RqgZcDDY6+3Tv7Bc7rVNjklWr4nYwG+AO9QOiIIvxImjZeNg0kCUsJiosT5NsENGhlsJ4fc8n5cxYYihMy+/oAQwzNST92j+r45ROyBHG+XZzkeK1Bodx/DxffCIfEBZ3upLflYUv+DLi8CgvDxqxJAcFyK0t72k02+o44G5xqsWK3YUYaUw138rCh5Uo38GSZ0T/NolU1JpPpWyrUaYH8AUtlJ8kPS7D6G5KnljxqaCey0fe/NuKjtLAPaXQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(508600001)(36756003)(5660300002)(40460700003)(921005)(81166007)(30864003)(82310400004)(356005)(86362001)(316002)(8936002)(2616005)(4326008)(8676002)(70206006)(70586007)(107886003)(83380400001)(336012)(6666004)(426003)(186003)(2906002)(7696005)(110136005)(1076003)(26005)(54906003)(47076005)(36900700001)(83996005)(2101003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:22:04.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9836a87f-5174-4d5a-40b2-08d9f861d0c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adding GPC DMA controller driver for Tegra. The driver supports dma
transfers between memory to memory, IO peripheral to memory and
memory to IO peripheral.

Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/dma/Kconfig            |   11 +
 drivers/dma/Makefile           |    1 +
 drivers/dma/tegra186-gpc-dma.c | 1507 ++++++++++++++++++++++++++++++++
 3 files changed, 1519 insertions(+)
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6bcdb4e6a0d1..cd0ef54a7124 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -629,6 +629,17 @@ config TXX9_DMAC
 	  Support the TXx9 SoC internal DMA controller.  This can be
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
+config TEGRA186_GPC_DMA
+	tristate "NVIDIA Tegra GPC DMA support"
+	depends on (ARCH_TEGRA || COMPILE_TEST) && ARCH_DMA_ADDR_T_64BIT
+	select DMA_ENGINE
+	help
+	  Support for the NVIDIA Tegra General Purpose Central DMA controller.
+	  The DMA controller has multiple DMA channels which can be configured
+	  for different peripherals like UART, SPI, etc which are on APB bus.
+	  This DMA controller transfers data from memory to peripheral FIFO
+	  or vice versa. It also supports memory to memory data transfer.
+
 config TEGRA20_APB_DMA
 	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 616d926cf2a5..2f1b87ffd7ab 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_STM32_MDMA) += stm32-mdma.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
 obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
+obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
new file mode 100644
index 000000000000..f12327732041
--- /dev/null
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -0,0 +1,1507 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DMA driver for NVIDIA Tegra GPC DMA controller.
+ *
+ * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <dt-bindings/memory/tegra186-mc.h>
+#include "virt-dma.h"
+
+/* CSR register */
+#define TEGRA_GPCDMA_CHAN_CSR			0x00
+#define TEGRA_GPCDMA_CSR_ENB			BIT(31)
+#define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
+#define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
+
+#define TEGRA_GPCDMA_CSR_FC_MODE		GENMASK(25, 24)
+#define TEGRA_GPCDMA_CSR_FC_MODE_NO_MMIO	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 0)
+#define TEGRA_GPCDMA_CSR_FC_MODE_ONE_MMIO	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 1)
+#define TEGRA_GPCDMA_CSR_FC_MODE_TWO_MMIO	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 2)
+#define TEGRA_GPCDMA_CSR_FC_MODE_FOUR_MMIO	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 3)
+
+#define TEGRA_GPCDMA_CSR_DMA			GENMASK(23, 21)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_NO_FC	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 0)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC		\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 1)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_NO_FC	\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 2)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC		\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 3)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2MEM		\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 4)
+#define TEGRA_GPCDMA_CSR_DMA_FIXED_PAT		\
+		FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 6)
+
+#define TEGRA_GPCDMA_CSR_REQ_SEL_MASK		GENMASK(20, 16)
+#define TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, 4)
+#define TEGRA_GPCDMA_CSR_IRQ_MASK		BIT(15)
+#define TEGRA_GPCDMA_CSR_WEIGHT			GENMASK(13, 10)
+
+/* STATUS register */
+#define TEGRA_GPCDMA_CHAN_STATUS		0x004
+#define TEGRA_GPCDMA_STATUS_BUSY		BIT(31)
+#define TEGRA_GPCDMA_STATUS_ISE_EOC		BIT(30)
+#define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
+#define TEGRA_GPCDMA_STATUS_DMA_ACTIVITY	BIT(27)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_PAUSE	BIT(26)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_RX		BIT(25)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_TX		BIT(24)
+#define TEGRA_GPCDMA_STATUS_IRQ_INTR_STA	BIT(23)
+#define TEGRA_GPCDMA_STATUS_IRQ_STA		BIT(21)
+#define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
+
+#define TEGRA_GPCDMA_CHAN_CSRE			0x008
+#define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
+
+/* Source address */
+#define TEGRA_GPCDMA_CHAN_SRC_PTR		0x00C
+
+/* Destination address */
+#define TEGRA_GPCDMA_CHAN_DST_PTR		0x010
+
+/* High address pointer */
+#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
+#define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
+#define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
+
+/* MC sequence register */
+#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
+#define TEGRA_GPCDMA_MCSEQ_DATA_SWAP		BIT(31)
+#define TEGRA_GPCDMA_MCSEQ_REQ_COUNT		GENMASK(30, 25)
+#define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
+#define TEGRA_GPCDMA_MCSEQ_BURST_2		\
+		FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 0)
+#define TEGRA_GPCDMA_MCSEQ_BURST_16		\
+		FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 3)
+#define TEGRA_GPCDMA_MCSEQ_WRAP1		GENMASK(22, 20)
+#define TEGRA_GPCDMA_MCSEQ_WRAP0		GENMASK(19, 17)
+#define TEGRA_GPCDMA_MCSEQ_WRAP_NONE		0
+
+#define TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK	GENMASK(13, 7)
+#define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK	GENMASK(6, 0)
+
+/* MMIO sequence register */
+#define TEGRA_GPCDMA_CHAN_MMIOSEQ			0x01c
+#define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH		GENMASK(30, 28)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	\
+		FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 0)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16	\
+		FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 1)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32	\
+		FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 2)
+#define TEGRA_GPCDMA_MMIOSEQ_DATA_SWAP		BIT(27)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_SHIFT	23
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_MIN		2U
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_MAX		32U
+#define TEGRA_GPCDMA_MMIOSEQ_BURST(bs)	\
+		(GENMASK((fls(bs) - 2), 0) << TEGRA_GPCDMA_MMIOSEQ_BURST_SHIFT)
+#define TEGRA_GPCDMA_MMIOSEQ_MASTER_ID		GENMASK(22, 19)
+#define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD		GENMASK(18, 16)
+#define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT		GENMASK(8, 7)
+
+/* Channel WCOUNT */
+#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
+
+/* Transfer count */
+#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
+
+/* DMA byte count status */
+#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
+
+/* Error Status Register */
+#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	8
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	0xF
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
+		((err) >> TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT) &	\
+		TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK)
+#define TEGRA_DMA_BM_FIFO_FULL_ERR		0xF
+#define TEGRA_DMA_PERIPH_FIFO_FULL_ERR		0xE
+#define TEGRA_DMA_PERIPH_ID_ERR			0xD
+#define TEGRA_DMA_STREAM_ID_ERR			0xC
+#define TEGRA_DMA_MC_SLAVE_ERR			0xB
+#define TEGRA_DMA_MMIO_SLAVE_ERR		0xA
+
+/* Fixed Pattern */
+#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
+
+#define TEGRA_GPCDMA_CHAN_TZ			0x38
+#define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
+#define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
+
+#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
+#define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
+
+/*
+ * If any burst is in flight and DMA paused then this is the time to complete
+ * on-flight burst and update DMA status register.
+ */
+#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
+#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
+
+/* Channel base address offset from GPCDMA base address */
+#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
+
+struct tegra_dma;
+struct tegra_dma_channel;
+
+/*
+ * tegra_dma_chip_data Tegra chip specific DMA data
+ * @nr_channels: Number of channels available in the controller.
+ * @channel_reg_size: Channel register size.
+ * @max_dma_count: Maximum DMA transfer count supported by DMA controller.
+ * @hw_support_pause: DMA HW engine support pause of the channel.
+ */
+struct tegra_dma_chip_data {
+	bool hw_support_pause;
+	unsigned int nr_channels;
+	unsigned int channel_reg_size;
+	unsigned int max_dma_count;
+	int (*terminate)(struct tegra_dma_channel *tdc);
+};
+
+/* DMA channel registers */
+struct tegra_dma_channel_regs {
+	u32 csr;
+	u32 src_ptr;
+	u32 dst_ptr;
+	u32 high_addr_ptr;
+	u32 mc_seq;
+	u32 mmio_seq;
+	u32 wcount;
+	u32 fixed_pattern;
+};
+
+/*
+ * tegra_dma_sg_req: DMA request details to configure hardware. This
+ * contains the details for one transfer to configure DMA hw.
+ * The client's request for data transfer can be broken into multiple
+ * sub-transfer as per requester details and hw support. This sub transfer
+ * get added as an array in Tegra DMA desc which manages the transfer details.
+ */
+struct tegra_dma_sg_req {
+	unsigned int len;
+	struct tegra_dma_channel_regs ch_regs;
+};
+
+/*
+ * tegra_dma_desc: Tegra DMA descriptors which uses virt_dma_desc to
+ * manage client request and keep track of transfer status, callbacks
+ * and request counts etc.
+ */
+struct tegra_dma_desc {
+	bool cyclic;
+	unsigned int bytes_req;
+	unsigned int bytes_xfer;
+	unsigned int sg_idx;
+	unsigned int sg_count;
+	struct virt_dma_desc vd;
+	struct tegra_dma_channel *tdc;
+	struct tegra_dma_sg_req sg_req[];
+};
+
+/*
+ * tegra_dma_channel: Channel specific information
+ */
+struct tegra_dma_channel {
+	bool config_init;
+	char name[30];
+	enum dma_transfer_direction sid_dir;
+	int id;
+	int irq;
+	int slave_id;
+	struct tegra_dma *tdma;
+	struct virt_dma_chan vc;
+	struct tegra_dma_desc *dma_desc;
+	struct dma_slave_config dma_sconfig;
+	unsigned int stream_id;
+	unsigned long chan_base_offset;
+};
+
+/*
+ * tegra_dma: Tegra DMA specific information
+ */
+struct tegra_dma {
+	const struct tegra_dma_chip_data *chip_data;
+	unsigned long sid_m2d_reserved;
+	unsigned long sid_d2m_reserved;
+	void __iomem *base_addr;
+	struct device *dev;
+	struct dma_device dma_dev;
+	struct reset_control *rst;
+	struct tegra_dma_channel channels[];
+};
+
+static inline void tdc_write(struct tegra_dma_channel *tdc,
+			     u32 reg, u32 val)
+{
+	writel_relaxed(val, tdc->tdma->base_addr + tdc->chan_base_offset + reg);
+}
+
+static inline u32 tdc_read(struct tegra_dma_channel *tdc, u32 reg)
+{
+	return readl_relaxed(tdc->tdma->base_addr + tdc->chan_base_offset + reg);
+}
+
+static inline struct tegra_dma_channel *to_tegra_dma_chan(struct dma_chan *dc)
+{
+	return container_of(dc, struct tegra_dma_channel, vc.chan);
+}
+
+static inline struct tegra_dma_desc *vd_to_tegra_dma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct tegra_dma_desc, vd);
+}
+
+static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
+{
+	return tdc->vc.chan.device->dev;
+}
+
+static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
+{
+	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
+		tdc->id, tdc->name);
+	dev_dbg(tdc2dev(tdc), "CSR %x STA %x CSRE %x SRC %x DST %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
+	);
+	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
+	);
+	dev_dbg(tdc2dev(tdc), "DMA ERR_STA %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
+}
+
+static int tegra_dma_sid_reserve(struct tegra_dma_channel *tdc,
+				 enum dma_transfer_direction direction)
+{
+	struct tegra_dma *tdma = tdc->tdma;
+	int sid = tdc->slave_id;
+
+	if (!is_slave_direction(direction))
+		return 0;
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		if (test_and_set_bit(sid, &tdma->sid_m2d_reserved)) {
+			dev_err(tdma->dev, "slave id already in use\n");
+			return -EINVAL;
+		}
+		break;
+	case DMA_DEV_TO_MEM:
+		if (test_and_set_bit(sid, &tdma->sid_d2m_reserved)) {
+			dev_err(tdma->dev, "slave id already in use\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		break;
+	}
+
+	tdc->sid_dir = direction;
+
+	return 0;
+}
+
+static void tegra_dma_sid_free(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma *tdma = tdc->tdma;
+	int sid = tdc->slave_id;
+
+	switch (tdc->sid_dir) {
+	case DMA_MEM_TO_DEV:
+		clear_bit(sid,  &tdma->sid_m2d_reserved);
+		break;
+	case DMA_DEV_TO_MEM:
+		clear_bit(sid,  &tdma->sid_d2m_reserved);
+		break;
+	default:
+		break;
+	}
+
+	tdc->sid_dir = DMA_TRANS_NONE;
+}
+
+static void tegra_dma_desc_free(struct virt_dma_desc *vd)
+{
+	kfree(container_of(vd, struct tegra_dma_desc, vd));
+}
+
+static int tegra_dma_slave_config(struct dma_chan *dc,
+				  struct dma_slave_config *sconfig)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
+	tdc->config_init = true;
+
+	return 0;
+}
+
+static int tegra_dma_pause(struct tegra_dma_channel *tdc)
+{
+	int ret;
+	u32 val;
+
+	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val |= TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+
+	/* Wait until busy bit is de-asserted */
+	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			val,
+			!(val & TEGRA_GPCDMA_STATUS_BUSY),
+			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
+			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
+
+	if (ret) {
+		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
+		tegra_dma_dump_chan_regs(tdc);
+	}
+
+	return ret;
+}
+
+static int tegra_dma_device_pause(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+	int ret;
+
+	if (!tdc->tdma->chip_data->hw_support_pause)
+		return -ENOSYS;
+
+	spin_lock_irqsave(&tdc->vc.lock, flags);
+	ret = tegra_dma_pause(tdc);
+	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+
+	return ret;
+}
+
+static void tegra_dma_resume(struct tegra_dma_channel *tdc)
+{
+	u32 val;
+
+	val = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE);
+	val &= ~TEGRA_GPCDMA_CHAN_CSRE_PAUSE;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, val);
+}
+
+static int tegra_dma_device_resume(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+
+	if (!tdc->tdma->chip_data->hw_support_pause)
+		return -ENOSYS;
+
+	spin_lock_irqsave(&tdc->vc.lock, flags);
+	tegra_dma_resume(tdc);
+	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+
+	return 0;
+}
+
+static void tegra_dma_disable(struct tegra_dma_channel *tdc)
+{
+	u32 csr, status;
+
+	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+
+	/* Disable interrupts */
+	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
+
+	/* Disable DMA */
+	csr &= ~TEGRA_GPCDMA_CSR_ENB;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+
+	/* Clear interrupt status if it is there */
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
+	}
+}
+
+static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
+	struct tegra_dma_channel_regs *ch_regs;
+	int ret;
+	u32 val;
+
+	dma_desc->sg_idx++;
+
+	/* Reset the sg index for cyclic transfers */
+	if (dma_desc->sg_idx == dma_desc->sg_count)
+		dma_desc->sg_idx = 0;
+
+	/* Configure next transfer immediately after DMA is busy */
+	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			val,
+			(val & TEGRA_GPCDMA_STATUS_BUSY), 0,
+			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
+	if (ret)
+		return;
+
+	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+
+	/* Start DMA */
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
+		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+}
+
+static void tegra_dma_start(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
+	struct tegra_dma_channel_regs *ch_regs;
+	struct virt_dma_desc *vdesc;
+
+	if (!dma_desc) {
+		vdesc = vchan_next_desc(&tdc->vc);
+		if (!vdesc)
+			return;
+
+		dma_desc = vd_to_tegra_dma_desc(vdesc);
+		list_del(&vdesc->node);
+		dma_desc->tdc = tdc;
+		tdc->dma_desc = dma_desc;
+
+		tegra_dma_resume(tdc);
+	}
+
+	ch_regs = &dma_desc->sg_req[dma_desc->sg_idx].ch_regs;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
+
+	/* Start DMA */
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
+		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+}
+
+static void tegra_dma_xfer_complete(struct tegra_dma_channel *tdc)
+{
+	vchan_cookie_complete(&tdc->dma_desc->vd);
+
+	tegra_dma_sid_free(tdc);
+	tdc->dma_desc = NULL;
+}
+
+static void tegra_dma_chan_decode_error(struct tegra_dma_channel *tdc,
+					unsigned int err_status)
+{
+	switch (TEGRA_GPCDMA_CHAN_ERR_TYPE(err_status)) {
+	case TEGRA_DMA_BM_FIFO_FULL_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d bm fifo full\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_PERIPH_FIFO_FULL_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d peripheral fifo full\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_PERIPH_ID_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d illegal peripheral id\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_STREAM_ID_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d illegal stream id\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_MC_SLAVE_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d mc slave error\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_MMIO_SLAVE_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d mmio slave error\n", tdc->id);
+		break;
+
+	default:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d security violation %x\n", tdc->id,
+			err_status);
+	}
+}
+
+static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
+{
+	struct tegra_dma_channel *tdc = dev_id;
+	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
+	struct tegra_dma_sg_req *sg_req;
+	u32 status;
+
+	/* Check channel error status register */
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
+	if (status) {
+		tegra_dma_chan_decode_error(tdc, status);
+		tegra_dma_dump_chan_regs(tdc);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
+	}
+
+	spin_lock(&tdc->vc.lock);
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
+		goto irq_done;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
+		  TEGRA_GPCDMA_STATUS_ISE_EOC);
+
+	if (!dma_desc)
+		goto irq_done;
+
+	sg_req = dma_desc->sg_req;
+	dma_desc->bytes_xfer += sg_req[dma_desc->sg_idx].len;
+
+	if (dma_desc->cyclic) {
+		vchan_cyclic_callback(&dma_desc->vd);
+		tegra_dma_configure_next_sg(tdc);
+	} else {
+		dma_desc->sg_idx++;
+		if (dma_desc->sg_idx == dma_desc->sg_count)
+			tegra_dma_xfer_complete(tdc);
+		else
+			tegra_dma_start(tdc);
+	}
+
+irq_done:
+	spin_unlock(&tdc->vc.lock);
+	return IRQ_HANDLED;
+}
+
+static void tegra_dma_issue_pending(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+
+	if (tdc->dma_desc)
+		return;
+
+	spin_lock_irqsave(&tdc->vc.lock, flags);
+	if (vchan_issue_pending(&tdc->vc))
+		tegra_dma_start(tdc);
+
+	/*
+	 * For cyclic DMA transfers, program the second
+	 * transfer parameters as soon as the first DMA
+	 * transfer is started inorder for the DMA
+	 * controller to trigger the second transfer
+	 * with the correct parameters.
+	 */
+	if (tdc->dma_desc && tdc->dma_desc->cyclic)
+		tegra_dma_configure_next_sg(tdc);
+
+	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+}
+
+static int tegra_dma_stop_client(struct tegra_dma_channel *tdc)
+{
+	int ret;
+	u32 status, csr;
+
+	/*
+	 * Change the client associated with the DMA channel
+	 * to stop DMA engine from starting any more bursts for
+	 * the given client and wait for in flight bursts to complete
+	 */
+	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
+	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+
+	/* Wait for in flight data transfer to finish */
+	udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
+
+	/* If TX/RX path is still active wait till it becomes
+	 * inactive
+	 */
+
+	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+				tdc->chan_base_offset +
+				TEGRA_GPCDMA_CHAN_STATUS,
+				status,
+				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
+				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
+				5,
+				TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
+	if (ret) {
+		dev_err(tdc2dev(tdc), "Timeout waiting for DMA burst completion!\n");
+		tegra_dma_dump_chan_regs(tdc);
+	}
+
+	return ret;
+}
+
+static int tegra_dma_terminate_all(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+	LIST_HEAD(head);
+	int err;
+
+	spin_lock_irqsave(&tdc->vc.lock, flags);
+
+	if (tdc->dma_desc) {
+		err = tdc->tdma->chip_data->terminate(tdc);
+		if (err) {
+			spin_unlock_irqrestore(&tdc->vc.lock, flags);
+			return err;
+		}
+
+		tegra_dma_disable(tdc);
+		tdc->dma_desc = NULL;
+	}
+
+	tegra_dma_sid_free(tdc);
+	vchan_get_all_descriptors(&tdc->vc, &head);
+	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&tdc->vc, &head);
+
+	return 0;
+}
+
+static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
+	struct tegra_dma_sg_req *sg_req = dma_desc->sg_req;
+	unsigned int bytes_xfer, residual;
+	u32 wcount = 0, status;
+
+	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+
+	/*
+	 * Set wcount = 0 if EOC bit is set. The transfer would have
+	 * already completed and the CHAN_XFER_COUNT could have updated
+	 * for the next transfer, specifically in case of cyclic transfers.
+	 */
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC)
+		wcount = 0;
+
+	bytes_xfer = dma_desc->bytes_xfer +
+		     sg_req[dma_desc->sg_idx].len - (wcount * 4);
+
+	residual = dma_desc->bytes_req - (bytes_xfer % dma_desc->bytes_req);
+
+	return residual;
+}
+
+static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
+					   dma_cookie_t cookie,
+					   struct dma_tx_state *txstate)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc;
+	struct virt_dma_desc *vd;
+	unsigned int residual;
+	unsigned long flags;
+	enum dma_status ret;
+
+	ret = dma_cookie_status(dc, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	spin_lock_irqsave(&tdc->vc.lock, flags);
+	vd = vchan_find_desc(&tdc->vc, cookie);
+	if (vd) {
+		dma_desc = vd_to_tegra_dma_desc(vd);
+		residual = dma_desc->bytes_req;
+		dma_set_residue(txstate, residual);
+	} else if (tdc->dma_desc && tdc->dma_desc->vd.tx.cookie == cookie) {
+		residual =  tegra_dma_get_residual(tdc);
+		dma_set_residue(txstate, residual);
+	} else {
+		dev_err(tdc2dev(tdc), "cookie %d is not found\n", cookie);
+	}
+	spin_unlock_irqrestore(&tdc->vc.lock, flags);
+
+	return ret;
+}
+
+static inline int get_bus_width(struct tegra_dma_channel *tdc,
+				enum dma_slave_buswidth slave_bw)
+{
+	switch (slave_bw) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;
+	default:
+		dev_err(tdc2dev(tdc), "given slave bus width is not supported\n");
+		return -EINVAL;
+	}
+}
+
+static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
+				   u32 burst_size, enum dma_slave_buswidth slave_bw,
+				   int len)
+{
+	unsigned int burst_mmio_width, burst_byte;
+
+	/*
+	 * burst_size from client is in terms of the bus_width.
+	 * convert that into words.
+	 * If burst_size is not specified from client, then use
+	 * len to calculate the optimum burst size
+	 */
+	burst_byte = burst_size ? burst_size * slave_bw : len;
+	burst_mmio_width = burst_byte / 4;
+
+	if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
+		return 0;
+
+	burst_mmio_width = min(burst_mmio_width, TEGRA_GPCDMA_MMIOSEQ_BURST_MAX);
+
+	return TEGRA_GPCDMA_MMIOSEQ_BURST(burst_mmio_width);
+}
+
+static int get_transfer_param(struct tegra_dma_channel *tdc,
+			      enum dma_transfer_direction direction,
+			      u32 *apb_addr,
+			      u32 *mmio_seq,
+			      u32 *csr,
+			      unsigned int *burst_size,
+			      enum dma_slave_buswidth *slave_bw)
+{
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		*apb_addr = tdc->dma_sconfig.dst_addr;
+		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.dst_addr_width);
+		*burst_size = tdc->dma_sconfig.dst_maxburst;
+		*slave_bw = tdc->dma_sconfig.dst_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC;
+		return 0;
+	case DMA_DEV_TO_MEM:
+		*apb_addr = tdc->dma_sconfig.src_addr;
+		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.src_addr_width);
+		*burst_size = tdc->dma_sconfig.src_maxburst;
+		*slave_bw = tdc->dma_sconfig.src_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
+		return 0;
+	case DMA_MEM_TO_MEM:
+		*burst_size = tdc->dma_sconfig.src_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
+		return 0;
+	default:
+		dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
+	}
+
+	return -EINVAL;
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
+			  size_t len, unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	struct tegra_dma_sg_req *sg_req;
+	struct tegra_dma_desc *dma_desc;
+	u32 csr, mc_seq;
+
+	if ((len & 3) || (dest & 3) || len > max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"DMA length/memory address is not supported\n");
+		return NULL;
+	}
+
+	/* Set DMA mode to fixed pattern */
+	csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the DMA interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+	/* Configure default priority weight for the channel */
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
+
+	/* Set the address wrapping */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
+						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
+						TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+
+	/* Program outstanding MC requests */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
+	/* Set burst size */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+
+	dma_desc = kzalloc(struct_size(dma_desc, sg_req, 1), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_req = len;
+	dma_desc->sg_count = 1;
+	sg_req = dma_desc->sg_req;
+
+	sg_req[0].ch_regs.src_ptr = 0;
+	sg_req[0].ch_regs.dst_ptr = dest;
+	sg_req[0].ch_regs.high_addr_ptr =
+			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	sg_req[0].ch_regs.fixed_pattern = value;
+	/* Word count reg takes value as (N +1) words */
+	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
+	sg_req[0].ch_regs.csr = csr;
+	sg_req[0].ch_regs.mmio_seq = 0;
+	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].len = len;
+
+	dma_desc->cyclic = false;
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
+			  dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_sg_req *sg_req;
+	struct tegra_dma_desc *dma_desc;
+	unsigned int max_dma_count;
+	u32 csr, mc_seq;
+
+	max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	if ((len & 3) || (src & 3) || (dest & 3) || len > max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"DMA length/memory address is not supported\n");
+		return NULL;
+	}
+
+	/* Set DMA mode to memory to memory transfer */
+	csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the DMA interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+	/* Configure default priority weight for the channel */
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
+		  (TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
+
+	/* Set the address wrapping */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+
+	/* Program outstanding MC requests */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
+	/* Set burst size */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+
+	dma_desc = kzalloc(struct_size(dma_desc, sg_req, 1), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_req = len;
+	dma_desc->sg_count = 1;
+	sg_req = dma_desc->sg_req;
+
+	sg_req[0].ch_regs.src_ptr = src;
+	sg_req[0].ch_regs.dst_ptr = dest;
+	sg_req[0].ch_regs.high_addr_ptr =
+		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
+	sg_req[0].ch_regs.high_addr_ptr |=
+		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	/* Word count reg takes value as (N +1) words */
+	sg_req[0].ch_regs.wcount = ((len - 4) >> 2);
+	sg_req[0].ch_regs.csr = csr;
+	sg_req[0].ch_regs.mmio_seq = 0;
+	sg_req[0].ch_regs.mc_seq = mc_seq;
+	sg_req[0].len = len;
+
+	dma_desc->cyclic = false;
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction direction,
+			unsigned long flags, void *context)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	enum dma_slave_buswidth slave_bw;
+	struct tegra_dma_sg_req *sg_req;
+	struct tegra_dma_desc *dma_desc;
+	struct scatterlist *sg;
+	u32 burst_size;
+	unsigned int i;
+	int ret;
+
+	if (!tdc->config_init) {
+		dev_err(tdc2dev(tdc), "DMA channel is not configured\n");
+		return NULL;
+	}
+	if (sg_len < 1) {
+		dev_err(tdc2dev(tdc), "Invalid segment length %d\n", sg_len);
+		return NULL;
+	}
+
+	ret = tegra_dma_sid_reserve(tdc, direction);
+	if (ret)
+		return NULL;
+
+	ret = get_transfer_param(tdc, direction, &apb_ptr, &mmio_seq, &csr,
+				 &burst_size, &slave_bw);
+	if (ret < 0)
+		return NULL;
+
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Program the slave id in requestor select */
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, tdc->slave_id);
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Configure default priority weight for the channel*/
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
+
+	/* Enable the DMA interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
+
+	/* Set the address wrapping on both MC and MMIO side */
+
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
+
+	/* Program 2 MC outstanding requests by default. */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
+
+	/* Setting MC burst size depending on MMIO burst size */
+	if (burst_size == 64)
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+	else
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_2;
+
+	dma_desc = kzalloc(struct_size(dma_desc, sg_req, sg_len), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->sg_count = sg_len;
+	sg_req = dma_desc->sg_req;
+
+	/* Make transfer requests */
+	for_each_sg(sgl, sg, sg_len, i) {
+		u32 len;
+		dma_addr_t mem;
+
+		mem = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		if ((len & 3) || (mem & 3) || len > max_dma_count) {
+			dev_err(tdc2dev(tdc),
+				"DMA length/memory address is not supported\n");
+			kfree(dma_desc);
+			return NULL;
+		}
+
+		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
+		dma_desc->bytes_req += len;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			sg_req[i].ch_regs.src_ptr = mem;
+			sg_req[i].ch_regs.dst_ptr = apb_ptr;
+			sg_req[i].ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
+		} else if (direction == DMA_DEV_TO_MEM) {
+			sg_req[i].ch_regs.src_ptr = apb_ptr;
+			sg_req[i].ch_regs.dst_ptr = mem;
+			sg_req[i].ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
+		}
+
+		/*
+		 * Word count register takes input in words. Writing a value
+		 * of N into word count register means a req of (N+1) words.
+		 */
+		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
+		sg_req[i].ch_regs.csr = csr;
+		sg_req[i].ch_regs.mmio_seq = mmio_seq;
+		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].len = len;
+	}
+
+	dma_desc->cyclic = false;
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_len,
+			  size_t period_len, enum dma_transfer_direction direction,
+			  unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc;
+	struct tegra_dma_sg_req *sg_req;
+	enum dma_slave_buswidth slave_bw;
+	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
+	unsigned int max_dma_count, len, period_count, i;
+	dma_addr_t mem = buf_addr;
+	int ret;
+
+	if (!buf_len || !period_len) {
+		dev_err(tdc2dev(tdc), "Invalid buffer/period len\n");
+		return NULL;
+	}
+
+	if (!tdc->config_init) {
+		dev_err(tdc2dev(tdc), "DMA slave is not configured\n");
+		return NULL;
+	}
+
+	ret = tegra_dma_sid_reserve(tdc, direction);
+	if (ret)
+		return NULL;
+
+	/*
+	 * We only support cycle transfer when buf_len is multiple of
+	 * period_len.
+	 */
+	if (buf_len % period_len) {
+		dev_err(tdc2dev(tdc), "buf_len is not multiple of period_len\n");
+		return NULL;
+	}
+
+	len = period_len;
+	max_dma_count = tdc->tdma->chip_data->max_dma_count;
+	if ((len & 3) || (buf_addr & 3) || len > max_dma_count) {
+		dev_err(tdc2dev(tdc), "Req len/mem address is not correct\n");
+		return NULL;
+	}
+
+	ret = get_transfer_param(tdc, direction, &apb_ptr, &mmio_seq, &csr,
+				 &burst_size, &slave_bw);
+	if (ret < 0)
+		return NULL;
+
+	/* Enable once or continuous mode */
+	csr &= ~TEGRA_GPCDMA_CSR_ONCE;
+	/* Program the slave id in requestor select */
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, tdc->slave_id);
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Configure default priority weight for the channel*/
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
+
+	/* Enable the DMA interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+
+	mmio_seq |= FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD, 1);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK;
+
+	/* Set the address wrapping on both MC and MMIO side */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP0,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
+			     TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+
+	/* Program 2 MC outstanding requests by default. */
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_REQ_COUNT, 1);
+	/* Setting MC burst size depending on MMIO burst size */
+	if (burst_size == 64)
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+	else
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_2;
+
+	period_count = buf_len / period_len;
+	dma_desc = kzalloc(struct_size(dma_desc, sg_req, period_count),
+			   GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_req = buf_len;
+	dma_desc->sg_count = period_count;
+	sg_req = dma_desc->sg_req;
+
+	/* Split transfer equal to period size */
+	for (i = 0; i < period_count; i++) {
+		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
+		if (direction == DMA_MEM_TO_DEV) {
+			sg_req[i].ch_regs.src_ptr = mem;
+			sg_req[i].ch_regs.dst_ptr = apb_ptr;
+			sg_req[i].ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
+		} else if (direction == DMA_DEV_TO_MEM) {
+			sg_req[i].ch_regs.src_ptr = apb_ptr;
+			sg_req[i].ch_regs.dst_ptr = mem;
+			sg_req[i].ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
+		}
+		/*
+		 * Word count register takes input in words. Writing a value
+		 * of N into word count register means a req of (N+1) words.
+		 */
+		sg_req[i].ch_regs.wcount = ((len - 4) >> 2);
+		sg_req[i].ch_regs.csr = csr;
+		sg_req[i].ch_regs.mmio_seq = mmio_seq;
+		sg_req[i].ch_regs.mc_seq = mc_seq;
+		sg_req[i].len = len;
+
+		mem += len;
+	}
+
+	dma_desc->cyclic = true;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	int ret;
+
+	ret = request_irq(tdc->irq, tegra_dma_isr, 0, tdc->name, tdc);
+	if (ret) {
+		dev_err(tdc2dev(tdc), "request_irq failed for %s\n", tdc->name);
+		return ret;
+	}
+
+	dma_cookie_init(&tdc->vc.chan);
+	tdc->config_init = false;
+	return 0;
+}
+
+static void tegra_dma_chan_synchronize(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	synchronize_irq(tdc->irq);
+	vchan_synchronize(&tdc->vc);
+}
+
+static void tegra_dma_free_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
+
+	tegra_dma_terminate_all(dc);
+	synchronize_irq(tdc->irq);
+
+	tasklet_kill(&tdc->vc.task);
+	tdc->config_init = false;
+	tdc->slave_id = -1;
+	tdc->sid_dir = DMA_TRANS_NONE;
+	free_irq(tdc->irq, tdc);
+
+	vchan_free_chan_resources(&tdc->vc);
+}
+
+static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
+					   struct of_dma *ofdma)
+{
+	struct tegra_dma *tdma = ofdma->of_dma_data;
+	struct tegra_dma_channel *tdc;
+	struct dma_chan *chan;
+
+	chan = dma_get_any_slave_channel(&tdma->dma_dev);
+	if (!chan)
+		return NULL;
+
+	tdc = to_tegra_dma_chan(chan);
+	tdc->slave_id = dma_spec->args[0];
+
+	return chan;
+}
+
+static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
+	.nr_channels = 31,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = false,
+	.terminate = tegra_dma_stop_client,
+};
+
+static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
+	.nr_channels = 31,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.terminate = tegra_dma_pause,
+};
+
+static const struct of_device_id tegra_dma_of_match[] = {
+	{
+		.compatible = "nvidia,tegra186-gpcdma",
+		.data = &tegra186_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra194-gpcdma",
+		.data = &tegra194_dma_chip_data,
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
+
+static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
+{
+	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+
+	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK);
+	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
+
+	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK, stream_id);
+	reg_val |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK, stream_id);
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
+	return 0;
+}
+
+static int tegra_dma_probe(struct platform_device *pdev)
+{
+	const struct tegra_dma_chip_data *cdata = NULL;
+	struct iommu_fwspec *iommu_spec;
+	unsigned int stream_id, i;
+	struct tegra_dma *tdma;
+	struct resource	*res;
+	int ret;
+
+	cdata = of_device_get_match_data(&pdev->dev);
+
+	tdma = devm_kzalloc(&pdev->dev,
+			    struct_size(tdma, channels, cdata->nr_channels),
+			    GFP_KERNEL);
+	if (!tdma)
+		return -ENOMEM;
+
+	tdma->dev = &pdev->dev;
+	tdma->chip_data = cdata;
+	platform_set_drvdata(pdev, tdma);
+
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tdma->base_addr))
+		return PTR_ERR(tdma->base_addr);
+
+	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	if (IS_ERR(tdma->rst)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
+			      "Missing controller reset\n");
+	}
+	reset_control_reset(tdma->rst);
+
+	tdma->dma_dev.dev = &pdev->dev;
+
+	iommu_spec = dev_iommu_fwspec_get(&pdev->dev);
+	if (!iommu_spec) {
+		dev_err(&pdev->dev, "Missing iommu stream-id\n");
+		return -EINVAL;
+	}
+	stream_id = iommu_spec->ids[0] & 0xffff;
+
+	INIT_LIST_HEAD(&tdma->dma_dev.channels);
+	for (i = 0; i < cdata->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
+					i * cdata->channel_reg_size;
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res) {
+			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
+			return -EINVAL;
+		}
+		tdc->irq = res->start;
+		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
+
+		tdc->tdma = tdma;
+		tdc->id = i;
+		tdc->slave_id = -1;
+
+		vchan_init(&tdc->vc, &tdma->dma_dev);
+		tdc->vc.desc_free = tegra_dma_desc_free;
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
+	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMSET, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, tdma->dma_dev.cap_mask);
+
+	/*
+	 * Only word aligned transfers are supported. Set the copy
+	 * alignment shift.
+	 */
+	tdma->dma_dev.copy_align = 2;
+	tdma->dma_dev.fill_align = 2;
+	tdma->dma_dev.device_alloc_chan_resources =
+					tegra_dma_alloc_chan_resources;
+	tdma->dma_dev.device_free_chan_resources =
+					tegra_dma_free_chan_resources;
+	tdma->dma_dev.device_prep_slave_sg = tegra_dma_prep_slave_sg;
+	tdma->dma_dev.device_prep_dma_memcpy = tegra_dma_prep_dma_memcpy;
+	tdma->dma_dev.device_prep_dma_memset = tegra_dma_prep_dma_memset;
+	tdma->dma_dev.device_prep_dma_cyclic = tegra_dma_prep_dma_cyclic;
+	tdma->dma_dev.device_config = tegra_dma_slave_config;
+	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
+	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
+	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
+	tdma->dma_dev.device_pause = tegra_dma_device_pause;
+	tdma->dma_dev.device_resume = tegra_dma_device_resume;
+	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
+	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	ret = dma_async_device_register(&tdma->dma_dev);
+	if (ret < 0) {
+		dev_err_probe(&pdev->dev, ret,
+			      "GPC DMA driver registration failed\n");
+		return ret;
+	}
+
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 tegra_dma_of_xlate, tdma);
+	if (ret < 0) {
+		dev_err_probe(&pdev->dev, ret,
+			      "GPC DMA OF registration failed\n");
+
+		dma_async_device_unregister(&tdma->dma_dev);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
+		 cdata->nr_channels);
+
+	return 0;
+}
+
+static int tegra_dma_remove(struct platform_device *pdev)
+{
+	struct tegra_dma *tdma = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&tdma->dma_dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	unsigned int i;
+
+	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		if (tdc->dma_desc) {
+			dev_err(tdma->dev, "channel %u busy\n", i);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	unsigned int i;
+
+	reset_control_reset(tdma->rst);
+
+	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		tegra_dma_program_sid(tdc, tdc->stream_id);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_dma_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
+};
+
+static struct platform_driver tegra_dma_driver = {
+	.driver = {
+		.name	= "tegra-gpcdma",
+		.pm	= &tegra_dma_dev_pm_ops,
+		.of_match_table = tegra_dma_of_match,
+	},
+	.probe		= tegra_dma_probe,
+	.remove		= tegra_dma_remove,
+};
+
+module_platform_driver(tegra_dma_driver);
+
+MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
+MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
+MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

