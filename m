Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565563F944F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbhH0GGf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 02:06:35 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:63712
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244254AbhH0GGc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Aug 2021 02:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUjh8iigsk93tkiBWW37jgRl/srbbJ2ZGSO41AQdB5dYCYMGWxLm8HAanyqAGHxmwtjNOP/k9OAAmporZtF9yWHhe/Kukt7mteMyrXbeJ8e67t3G8PwZLE508XEwsF5sFTNf3ajcZNxkuALKJbznof4jdKc6FrQiaXP8k/GO+45Lt2ATTPrhxChVbXM7HNDP2rpeBsqMm7MkNh5UtWiiLShbBDFp/iw7GIFLzzyF91tc564aX/BgCUMs3bPctYJpqq0haUwmPgP6wlOAboNVsH1OvaIZSEPA1k/75FQtRika+bqoWTBjl1KVdVCSAGLJyXW3p/px53KCV/JcP/efCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC1X8J3rFcDu12MiDP4yh7gx+6jjPQUYMyJMyZtQuI0=;
 b=l//aAZ2iRNknA0AZVbJtamvIwQdYc3RBAhpeaxPXa10+uiXmPHnfEVnRoX8RDGeApGy6xz6UzAT55S50Lc3J6GULikJ5+aVv0HOuttAKzVBXzQDJbbuaeDRm3cWYLgIyCoPwppxoow8QmH1hcMVe7qY2AkrNZh8kk9vYyhAV7S0JOrdXjBRUsCBYZD1Dc+SsqHpSwS3PSscOXw5CzJUZTPnqJMqMimpsK8soCoPAhlIRrXAbs+7I4v6/ct3X4PjkTzs6/sW35IdT7AhAnBgZ+FN1aOYBcQMdZQNPC45h19Vg/y9p1CcaP7o/SlLRZ0Rx6cVtrT43pcxXz7wIebCQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC1X8J3rFcDu12MiDP4yh7gx+6jjPQUYMyJMyZtQuI0=;
 b=oMk3xaLyJ6f6MuEVigkFG6qC1fCFoeC8h1/XHVHBw09keElZyotQycYaaZ52eC2nZgF4lbfUi9QfZg4qIoqw7NC9uRp8td9QdqLF6U8TW+8jDgKxwoamFg/JhCYR11xHcmpt9fHhSYQV/5uCLe1PIe5k/n74rRaP/BTOWNNKWzb+Hm2SSDP8l3VDOsT3DHSB3dniTMQtv/7CnPSL+SHek4mW6ushTMdN42XpDt4QoPTv2CaNog2/rikllJ0rvK/kYhgokS1/F2Z0cSOAFWgNWV9SRJcy8l6X4fd4dke/2fxruipeVCLDvm0kyzC+b9I6KornARLl1EwvxDwznHKU2g==
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 06:05:41 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::83) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:05:40 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Aug
 2021 23:05:23 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:19 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: [PATCH v3 2/4] dmaengine: tegra: Add tegra gpcdma driver
Date:   Fri, 27 Aug 2021 11:34:52 +0530
Message-ID: <1630044294-21169-3-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a680f2-5d18-4519-3c90-08d96920b2cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497AA7A3E965DC347AB0822C0C89@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEJztttPAgb990sgip9hIBPQC08E3tzFcujXpzyETQpiESM2hnIIwCvIkXlUi5mzsA3P9ubfawwncIjrx1w2+naYNpVJY4vRGLyGHw6Sh+DHUSLtDmdPSzMFrY1IiqFhS3MebTQeq5/MqW63W+oRqV8rBdbFDl5knwXQipvdQ8VC7pqwdTQeWKLANBEFn7cncVR3/6vW3MU4yNofMQCiCpkyNDPBJ8N63o8414niH/wKmhbI2aodGRu4XAs2tlMSuk2bnESNB7FczX9nfLJk9SW0iqc7ClXhy/bMYw13WwwPCC229K2LQlaWNDsfFY4d2VtEFcyMZZSro1fEY4mQi3RkdU+jGlFiaKWw1+qb429ytHQTaf6p/94s/KQcJQ2Rp4dxZ/Rj23JvG8Z8WuYU+BsiBYnbk3wy4y/AcrW10Dza1NVcGbgIjRYs4yxe11qdGTIsQxnNdbK96t8f/mHg5H7vnXqHHlWx3aAFS2ZKdaczUOJgMldhYLfUd/tA721s+3SaE+osrbdGXChWVFTDMHVIgp8SQ8YtnDQCPeUuRjAsqr/C0nR7oPPS0ua+0gNCYSh1YhwJ5IbbRd9iQNjTyVGc3KW7ZkClQVgzmlRmjzJKqM6O6LtSaRhVOxkDuDHjFMAu4GrqbXohZAyoJF7SQ6QflY+yRyw5WkU+0fs3sGcnxdXW7o/73YDm5m0fUDgZvuZL7ZlrzqjoCG2cCZ2eVQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(86362001)(70586007)(83380400001)(356005)(47076005)(82740400003)(7636003)(478600001)(316002)(6666004)(336012)(426003)(186003)(82310400003)(36756003)(7696005)(26005)(6862004)(4326008)(36860700001)(8676002)(107886003)(30864003)(8936002)(37006003)(54906003)(2616005)(70206006)(5660300002)(6636002)(2906002)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:05:40.7372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a680f2-5d18-4519-3c90-08d96920b2cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
supports dma transfers between memory to memory, IO peripheral to memory
and memory to IO peripheral.

Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/Kconfig         |   12 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/tegra-gpc-dma.c | 1343 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1356 insertions(+)
 create mode 100644 drivers/dma/tegra-gpc-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 39b5b46..9d1d93d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -632,6 +632,18 @@ config TEGRA210_ADMA
 	  peripheral and vice versa. It does not support memory to
 	  memory data transfer.
 
+config TEGRA_GPC_DMA
+	tristate "NVIDIA Tegra GPC DMA support"
+	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST
+	select DMA_ENGINE
+	help
+	  Support for the NVIDIA Tegra186 and Tegra194 GPC DMA controller
+	  driver. The DMA controller has multiple DMA channels which can
+	  be configured for different peripherals like UART, SPI, etc
+	  which are on APB bus.
+	  This DMA controller transfers data from memory to peripheral FIFO
+	  or vice versa. It also supports memory to memory data transfer.
+
 config TIMB_DMA
 	tristate "Timberdale FPGA DMA support"
 	depends on MFD_TIMBERDALE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index aa69094..943e8d7 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
+obj-$(CONFIG_TEGRA_GPC_DMA) += tegra-gpc-dma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
 obj-$(CONFIG_UNIPHIER_XDMAC) += uniphier-xdmac.o
diff --git a/drivers/dma/tegra-gpc-dma.c b/drivers/dma/tegra-gpc-dma.c
new file mode 100644
index 0000000..d990121
--- /dev/null
+++ b/drivers/dma/tegra-gpc-dma.c
@@ -0,0 +1,1343 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DMA driver for Nvidia's Tegra186 and Tegra194 GPC DMA controller.
+ *
+ * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
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
+					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 0)
+#define TEGRA_GPCDMA_CSR_FC_MODE_ONE_MMIO	\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 1)
+#define TEGRA_GPCDMA_CSR_FC_MODE_TWO_MMIO	\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 2)
+#define TEGRA_GPCDMA_CSR_FC_MODE_FOUR_MMIO	\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_FC_MODE, 3)
+
+#define TEGRA_GPCDMA_CSR_DMA			GENMASK(23, 21)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_NO_FC	\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 0)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 1)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_NO_FC	\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 2)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 3)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2MEM		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 4)
+#define TEGRA_GPCDMA_CSR_DMA_FIXED_PAT		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_DMA, 6)
+
+#define TEGRA_GPCDMA_CSR_REQ_SEL_MASK		GENMASK(20, 16)
+#define TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED		\
+					FIELD_PREP(TEGRA_GPCDMA_CSR_REQ_SEL_MASK, 4)
+#define TEGRA_GPCDMA_CSR_IRQ_MASK			BIT(15)
+#define TEGRA_GPCDMA_CSR_WEIGHT				GENMASK(13, 10)
+
+/* STATUS register */
+#define TEGRA_GPCDMA_CHAN_STATUS			0x004
+#define TEGRA_GPCDMA_STATUS_BUSY			BIT(31)
+#define TEGRA_GPCDMA_STATUS_ISE_EOC			BIT(30)
+#define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
+#define TEGRA_GPCDMA_STATUS_DMA_ACTIVITY	BIT(27)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_PAUSE	BIT(26)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_RX		BIT(25)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_TX		BIT(24)
+#define TEGRA_GPCDMA_STATUS_IRQ_INTR_STA	BIT(23)
+#define TEGRA_GPCDMA_STATUS_IRQ_STA			BIT(21)
+#define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
+
+#define TEGRA_GPCDMA_CHAN_CSRE				0x008
+#define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
+
+/* Source address */
+#define TEGRA_GPCDMA_CHAN_SRC_PTR			0x00C
+
+/* Destination address */
+#define TEGRA_GPCDMA_CHAN_DST_PTR			0x010
+
+/* High address pointer */
+#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR		0x014
+#define TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR		GENMASK(7, 0)
+#define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR		GENMASK(23, 16)
+
+/* MC sequence register */
+#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
+#define TEGRA_GPCDMA_MCSEQ_DATA_SWAP	BIT(31)
+#define TEGRA_GPCDMA_MCSEQ_REQ_COUNT	GENMASK(30, 25)
+#define TEGRA_GPCDMA_MCSEQ_BURST		GENMASK(24, 23)
+#define TEGRA_GPCDMA_MCSEQ_BURST_2		\
+					FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 0)
+#define TEGRA_GPCDMA_MCSEQ_BURST_16		\
+					FIELD_PREP(TEGRA_GPCDMA_MCSEQ_BURST, 3)
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
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 0)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16	\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 1)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32	\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH, 2)
+#define TEGRA_GPCDMA_MMIOSEQ_DATA_SWAP		BIT(27)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST			GENMASK(26, 23)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_1		\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BURST, 0)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_2		\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BURST, 1)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_4		\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BURST, 3)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_8		\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BURST, 7)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_16		\
+					FIELD_PREP(TEGRA_GPCDMA_MMIOSEQ_BURST, 15)
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
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	(8)
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	(0xF)
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
+		((err) >> TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT) &	\
+		TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK)
+#define TEGRA_DMA_BM_FIFO_FULL_ERR		(0xF)
+#define TEGRA_DMA_PERIPH_FIFO_FULL_ERR		(0xE)
+#define TEGRA_DMA_PERIPH_ID_ERR			(0xD)
+#define TEGRA_DMA_STREAM_ID_ERR			(0xC)
+#define TEGRA_DMA_MC_SLAVE_ERR			(0xB)
+#define TEGRA_DMA_MMIO_SLAVE_ERR		(0xA)
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
+#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x10000
+
+struct tegra_dma;
+
+/*
+ * tegra_dma_chip_data Tegra chip specific DMA data
+ * @nr_channels: Number of channels available in the controller.
+ * @channel_reg_size: Channel register size.
+ * @max_dma_count: Maximum DMA transfer count supported by DMA controller.
+ * @hw_support_pause: DMA HW engine support pause of the channel.
+ */
+struct tegra_dma_chip_data {
+	int nr_channels;
+	int channel_reg_size;
+	int max_dma_count;
+	bool hw_support_pause;
+};
+
+/* DMA channel registers */
+struct tegra_dma_channel_regs {
+	unsigned long csr;
+	unsigned long src_ptr;
+	unsigned long dst_ptr;
+	unsigned long high_addr_ptr;
+	unsigned long mc_seq;
+	unsigned long mmio_seq;
+	unsigned long wcount;
+	unsigned long fixed_pattern;
+};
+
+/*
+ * tegra_dma_desc: Tegra DMA descriptors which uses virt_dma_desc to
+ * manage client request and keep track of transfer status, callbacks
+ * and request counts etc.
+ */
+struct tegra_dma_desc {
+	struct virt_dma_desc vd;
+	int bytes_requested;
+	int bytes_transferred;
+	struct tegra_dma_channel *tdc;
+	struct tegra_dma_channel_regs ch_regs;
+};
+
+struct tegra_dma_channel;
+
+typedef void (*dma_isr_handler)(struct tegra_dma_channel *tdc,
+				bool to_terminate);
+
+/*
+ * tegra_dma_channel: Channel specific information
+ */
+struct tegra_dma_channel {
+	struct virt_dma_chan vc;
+	struct tegra_dma_desc *dma_desc;
+	char name[30];
+	bool config_init;
+	int id;
+	int irq;
+	unsigned int stream_id;
+	unsigned long chan_base_offset;
+	raw_spinlock_t lock;
+	bool busy;
+	bool is_pending;
+	struct tegra_dma *tdma;
+	dma_isr_handler isr_handler;
+	int slave_id;
+	struct dma_slave_config dma_sconfig;
+};
+
+/*
+ * tegra_dma: Tegra DMA specific information
+ */
+struct tegra_dma {
+	struct dma_device dma_dev;
+	struct device *dev;
+	void __iomem *base_addr;
+	const struct tegra_dma_chip_data *chip_data;
+	struct reset_control *rst;
+	struct tegra_dma_channel channels[0];
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
+static void tegra_dma_desc_free(struct virt_dma_desc *vd)
+{
+	struct tegra_dma_desc *dma_desc = vd_to_tegra_dma_desc(vd);
+	struct tegra_dma_channel *tdc = dma_desc->tdc;
+	unsigned long flags;
+
+	if (dma_desc) {
+		raw_spin_lock_irqsave(&tdc->lock, flags);
+		kfree(dma_desc);
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+	}
+}
+
+static int tegra_dma_slave_config(struct dma_chan *dc,
+				  struct dma_slave_config *sconfig)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	if (tdc->dma_desc) {
+		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
+		return -EBUSY;
+	}
+
+	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
+	if (tdc->slave_id == -1)
+		tdc->slave_id = sconfig->slave_id;
+	tdc->config_init = true;
+	return 0;
+}
+
+static int tegra_dma_pause(struct tegra_dma_channel *tdc)
+{
+	u32 val;
+	int ret;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, TEGRA_GPCDMA_CHAN_CSRE_PAUSE);
+
+	/* Wait until busy bit is de-asserted */
+	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			val,
+			!(val & TEGRA_GPCDMA_STATUS_BUSY),
+			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
+			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
+
+	if (ret)
+		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
+
+	return ret;
+}
+
+static void tegra_dma_stop(struct tegra_dma_channel *tdc)
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
+	tdc->busy = false;
+}
+
+static void tegra_dma_start(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_channel_regs *ch_regs = &tdc->dma_desc->ch_regs;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, 0);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
+
+	/* Start DMA */
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
+		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+}
+
+static void tdc_start_head_req(struct tegra_dma_channel *tdc)
+{
+	struct virt_dma_desc *vdesc;
+
+	if (tdc->is_pending)
+		return;
+
+	vdesc = vchan_next_desc(&tdc->vc);
+	if (!vdesc)
+		return;
+
+	tdc->dma_desc = vd_to_tegra_dma_desc(vdesc);
+	if (!tdc->dma_desc)
+		return;
+
+	list_del(&vdesc->node);
+
+	tdc->is_pending = true;
+	tdc->dma_desc->tdc = tdc;
+	tegra_dma_start(tdc);
+	tdc->busy = true;
+}
+
+static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
+{
+	kfree(tdc->dma_desc);
+	tdc->isr_handler = NULL;
+}
+
+static void handle_once_dma_done(struct tegra_dma_channel *tdc,
+				 bool to_terminate)
+{
+	struct tegra_dma_desc *dma_desc;
+
+	tdc->busy = false;
+	dma_desc = tdc->dma_desc;
+	dma_desc->bytes_transferred += dma_desc->bytes_requested;
+
+	vchan_cookie_complete(&tdc->dma_desc->vd);
+	tdc->is_pending = false;
+	kfree(tdc->dma_desc);
+
+	if (to_terminate)
+		return;
+
+	tdc_start_head_req(tdc);
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
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int err_status;
+	unsigned long status;
+
+	raw_spin_lock(&tdc->lock);
+
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	err_status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
+
+	if (err_status) {
+		tegra_dma_chan_decode_error(tdc, err_status);
+		tegra_dma_dump_chan_regs(tdc);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
+	}
+
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
+			  TEGRA_GPCDMA_STATUS_ISE_EOC);
+		if (tdc->isr_handler) {
+			tdc->isr_handler(tdc, false);
+		} else {
+			dev_err(tdc->tdma->dev,
+				"GPCDMA CH%d: status %lx ISR handler absent!\n",
+				tdc->id, status);
+			tegra_dma_dump_chan_regs(tdc);
+		}
+		ret = IRQ_HANDLED;
+	}
+
+	raw_spin_unlock(&tdc->lock);
+	return ret;
+}
+
+static void tegra_dma_issue_pending(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+
+	if (!tdc->busy)
+		if (vchan_issue_pending(&tdc->vc))
+			tdc_start_head_req(tdc);
+
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+}
+
+static void tegra_dma_reset_client(struct tegra_dma_channel *tdc)
+{
+	u32 csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+
+	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
+	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+}
+
+static int tegra_dma_terminate_all(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long wcount = 0;
+	unsigned long status;
+	unsigned long flags;
+	bool was_busy;
+	int err;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+
+	if (!tdc->dma_desc) {
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+		return 0;
+	}
+
+	if (!tdc->busy)
+		goto skip_dma_stop;
+
+	if (tdc->tdma->chip_data->hw_support_pause) {
+		err = tegra_dma_pause(tdc);
+		if (err) {
+			raw_spin_unlock_irqrestore(&tdc->lock, flags);
+			return err;
+		}
+	} else {
+		/* Before Reading DMA status to figure out number
+		 * of bytes transferred by DMA channel:
+		 * Change the client associated with the DMA channel
+		 * to stop DMA engine from starting any more bursts for
+		 * the given client and wait for in flight bursts to complete
+		 */
+		tegra_dma_reset_client(tdc);
+
+		/* Wait for in flight data transfer to finish */
+		udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
+
+		/* If TX/RX path is still active wait till it becomes
+		 * inactive
+		 */
+
+		if (readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+				tdc->chan_base_offset +
+				TEGRA_GPCDMA_CHAN_STATUS,
+				status,
+				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
+				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
+				5,
+				TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT)) {
+			dev_dbg(tdc2dev(tdc), "Timeout waiting for DMA burst completion!\n");
+			tegra_dma_dump_chan_regs(tdc);
+		}
+	}
+
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
+		tdc->isr_handler(tdc, true);
+		status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+		wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	}
+
+	was_busy = tdc->busy;
+
+	tegra_dma_stop(tdc);
+	if (tdc->dma_desc && was_busy)
+		tdc->dma_desc->bytes_transferred +=
+			tdc->dma_desc->bytes_requested - (wcount * 4);
+
+skip_dma_stop:
+	tegra_dma_abort_all(tdc);
+	vchan_free_chan_resources(&tdc->vc);
+	if (tdc->is_pending) {
+		tdc->is_pending = false;
+		kfree(tdc->dma_desc);
+	}
+
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+	return 0;
+}
+
+static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
+					   dma_cookie_t cookie,
+					   struct dma_tx_state *txstate)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc = NULL;
+	struct virt_dma_desc *vd;
+	unsigned int residual;
+	enum dma_status ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+
+	ret = dma_cookie_status(dc, cookie, txstate);
+	if (ret == DMA_COMPLETE) {
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+		return ret;
+	}
+
+	vd = vchan_find_desc(&tdc->vc, cookie);
+	if (vd)
+		dma_desc = vd_to_tegra_dma_desc(vd);
+
+	if (dma_desc) {
+		residual =  dma_desc->bytes_requested -
+					(dma_desc->bytes_transferred %
+					dma_desc->bytes_requested);
+		dma_set_residue(txstate, residual);
+		kfree(dma_desc);
+	} else {
+		dev_err(tdc2dev(tdc), "cookie %d is not found\n", cookie);
+	}
+
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
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
+		dev_err(tdc2dev(tdc), "given slave bw is not supported\n");
+		return -EINVAL;
+	}
+}
+
+static inline int get_burst_size_by_len(int len)
+{
+	int ret;
+
+	switch (len) {
+	case BIT(0) ... BIT(2):
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
+		break;
+	case BIT(3):
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
+		break;
+	case BIT(4):
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
+		break;
+	case BIT(5):
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_8;
+		break;
+	default:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_16;
+		break;
+	}
+
+	return ret;
+}
+
+static inline int get_burst_size(struct tegra_dma_channel *tdc,
+				 u32 burst_size,
+				 enum dma_slave_buswidth slave_bw,
+				 int len)
+{
+	int burst_mmio_width, burst_byte, ret;
+
+	/*
+	 * burst_size from client is in terms of the bus_width.
+	 * convert that into words.
+	 */
+	burst_byte = burst_size * slave_bw;
+	burst_mmio_width = burst_byte / 4;
+
+	switch (burst_mmio_width) {
+	case 0:
+		ret = get_burst_size_by_len(len);
+		break;
+	case 1:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_1;
+		break;
+	case 2 ... 3:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_2;
+		break;
+	case 4 ... 7:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_4;
+		break;
+	case 8 ... 15:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_8;
+		break;
+	default:
+		ret = TEGRA_GPCDMA_MMIOSEQ_BURST_16;
+		break;
+	}
+
+	return ret;
+}
+
+static int get_transfer_param(struct tegra_dma_channel *tdc,
+			      enum dma_transfer_direction direction,
+				  unsigned long *apb_addr,
+			      unsigned long *mmio_seq,
+				  unsigned long *csr,
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
+
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
+		dev_err(tdc2dev(tdc), "Dma direction is not supported\n");
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
+			  size_t len, unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc;
+	unsigned long csr, mc_seq;
+
+	/* Set dma mode to fixed pattern */
+	csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the dma interrupt */
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
+	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	if ((len & 3) || (dest & 3) ||
+	    len > tdc->tdma->chip_data->max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"Dma length/memory address is not supported\n");
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	dma_desc->bytes_requested += len;
+	dma_desc->ch_regs.src_ptr = 0;
+	dma_desc->ch_regs.dst_ptr = dest;
+	dma_desc->ch_regs.high_addr_ptr =
+			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	dma_desc->ch_regs.fixed_pattern = value;
+	/* Word count reg takes value as (N +1) words */
+	dma_desc->ch_regs.wcount = ((len - 4) >> 2);
+	dma_desc->ch_regs.csr = csr;
+	dma_desc->ch_regs.mmio_seq = 0;
+	dma_desc->ch_regs.mc_seq = mc_seq;
+
+	tdc->dma_desc = dma_desc;
+
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
+			  dma_addr_t src,	size_t len, unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc;
+	unsigned long csr, mc_seq;
+
+	/* Set dma mode to memory to memory transfer */
+	csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the dma interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+	/* Configure default priority weight for the channel */
+	csr |= FIELD_PREP(TEGRA_GPCDMA_CSR_WEIGHT, 1);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID0_MASK) |
+				(TEGRA_GPCDMA_MCSEQ_STREAM_ID1_MASK);
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
+	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	if ((len & 3) || (src & 3) || (dest & 3) ||
+	    len > tdc->tdma->chip_data->max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"Dma length/memory address is not supported\n");
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	dma_desc->bytes_requested += len;
+	dma_desc->ch_regs.src_ptr = src;
+	dma_desc->ch_regs.dst_ptr = dest;
+	dma_desc->ch_regs.high_addr_ptr =
+		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
+	dma_desc->ch_regs.high_addr_ptr |=
+		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
+	/* Word count reg takes value as (N +1) words */
+	dma_desc->ch_regs.wcount = ((len - 4) >> 2);
+	dma_desc->ch_regs.csr = csr;
+	dma_desc->ch_regs.mmio_seq = 0;
+	dma_desc->ch_regs.mc_seq = mc_seq;
+
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	enum dma_slave_buswidth slave_bw;
+	struct tegra_dma_desc *dma_desc;
+	struct scatterlist *sg;
+	u32 burst_size;
+	unsigned int i;
+	int ret;
+
+	if (!tdc->config_init) {
+		dev_err(tdc2dev(tdc), "dma channel is not configured\n");
+		return NULL;
+	}
+	if (sg_len < 1) {
+		dev_err(tdc2dev(tdc), "Invalid segment length %d\n", sg_len);
+		return NULL;
+	}
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
+	/* Enable the dma interrupt */
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
+							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
+	mc_seq |= FIELD_PREP(TEGRA_GPCDMA_MCSEQ_WRAP1,
+							TEGRA_GPCDMA_MCSEQ_WRAP_NONE);
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
+	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	/* Make transfer requests */
+	for_each_sg(sgl, sg, sg_len, i) {
+		u32 len;
+		dma_addr_t mem;
+
+		mem = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		if ((len & 3) || (mem & 3) ||
+		    len > tdc->tdma->chip_data->max_dma_count) {
+			dev_err(tdc2dev(tdc),
+				"Dma length/memory address is not supported\n");
+			kfree(dma_desc);
+			return NULL;
+		}
+
+		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
+		dma_desc->bytes_requested += len;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			dma_desc->ch_regs.src_ptr = mem;
+			dma_desc->ch_regs.dst_ptr = apb_ptr;
+			dma_desc->ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
+		} else if (direction == DMA_DEV_TO_MEM) {
+			dma_desc->ch_regs.src_ptr = apb_ptr;
+			dma_desc->ch_regs.dst_ptr = mem;
+			dma_desc->ch_regs.high_addr_ptr =
+				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
+		}
+
+		/*
+		 * Word count register takes input in words. Writing a value
+		 * of N into word count register means a req of (N+1) words.
+		 */
+		dma_desc->ch_regs.wcount = ((len - 4) >> 2);
+		dma_desc->ch_regs.csr = csr;
+		dma_desc->ch_regs.mmio_seq = mmio_seq;
+		dma_desc->ch_regs.mc_seq = mc_seq;
+		tdc->dma_desc = dma_desc;
+	}
+
+	/*
+	 * Make sure that mode should not be conflicting with currently
+	 * configured mode.
+	 */
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
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
+	vchan_synchronize(&tdc->vc);
+}
+
+static void tegra_dma_free_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+
+	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
+
+	if (tdc->busy)
+		tegra_dma_terminate_all(dc);
+
+	tegra_dma_chan_synchronize(dc);
+
+	tasklet_kill(&tdc->vc.task);
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+	tdc->config_init = false;
+	tdc->isr_handler = NULL;
+	tdc->slave_id = -1;
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
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
+};
+
+static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
+	.nr_channels = 31,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
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
+static int tegra_dma_program_sid(struct tegra_dma_channel *tdc,
+				 int chan, int stream_id)
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
+	const unsigned int start_chan_idx = 1;
+	unsigned int stream_id, i;
+	struct tegra_dma *tdma;
+	struct resource	*res;
+	int ret;
+
+	cdata = of_device_get_match_data(&pdev->dev);
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   "nvidia,stream-id", &stream_id);
+	if (ret)
+		stream_id = TEGRA186_SID_GPCDMA_0;
+
+	tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
+			sizeof(struct tegra_dma_channel), GFP_KERNEL);
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
+		if (!(PTR_ERR(tdma->rst) == -EPROBE_DEFER))
+			dev_err(&pdev->dev, "Missing controller reset\n");
+		return PTR_ERR(tdma->rst);
+	}
+	reset_control_reset(tdma->rst);
+
+	tdma->dma_dev.dev = &pdev->dev;
+
+	INIT_LIST_HEAD(&tdma->dma_dev.channels);
+	for (i = 0; i < cdata->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
+					start_chan_idx * cdata->channel_reg_size +
+					i * cdata->channel_reg_size;
+		res = platform_get_resource(pdev, IORESOURCE_IRQ,
+					    start_chan_idx + i);
+		if (!res) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
+			goto err_irq;
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
+		raw_spin_lock_init(&tdc->lock);
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, i, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
+	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMSET, tdma->dma_dev.cap_mask);
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
+	tdma->dma_dev.device_config = tegra_dma_slave_config;
+	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
+	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
+	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
+	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
+	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	/* Register DMA channel interrupt handlers after everything is setup */
+	for (i = 0; i < cdata->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		ret = devm_request_irq(&pdev->dev, tdc->irq,
+				       tegra_dma_isr, 0, tdc->name, tdc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"request_irq failed with err %d channel %d\n",
+				i, ret);
+			goto err_irq;
+		}
+	}
+
+	ret = dma_async_device_register(&tdma->dma_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"GPC DMA driver registration failed %d\n", ret);
+		goto err_irq;
+	}
+
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 tegra_dma_of_xlate, tdma);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"GPC DMA OF registration failed %d\n", ret);
+		goto err_unregister_dma_dev;
+	}
+
+	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
+		 cdata->nr_channels);
+
+	return 0;
+
+err_unregister_dma_dev:
+	dma_async_device_unregister(&tdma->dma_dev);
+err_irq:
+	return ret;
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
+/*
+ * Save and restore csr and channel register on pm_suspend
+ * and pm_resume respectively
+ */
+static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int i;
+	bool busy;
+
+	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		raw_spin_lock_irqsave(&tdc->lock, flags);
+		busy = tdc->busy;
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+
+		if (busy) {
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
+		tegra_dma_program_sid(tdc, i, tdc->stream_id);
+	}
+
+	return 0;
+}
+
+static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
+};
+
+static struct platform_driver tegra_dmac_driver = {
+	.driver = {
+		.name	= "tegra-gpcdma",
+		.owner = THIS_MODULE,
+		.pm	= &tegra_dma_dev_pm_ops,
+		.of_match_table = tegra_dma_of_match,
+	},
+	.probe		= tegra_dma_probe,
+	.remove		= tegra_dma_remove,
+};
+
+module_platform_driver(tegra_dmac_driver);
+
+MODULE_ALIAS("platform:tegra-gpc-dma");
+MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
+MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
+MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

