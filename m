Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3420A6145B1
	for <lists+dmaengine@lfdr.de>; Tue,  1 Nov 2022 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKAI2N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Nov 2022 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKAI2K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Nov 2022 04:28:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DB186E6;
        Tue,  1 Nov 2022 01:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve1rSDmJrtH/rsvrU809PVxS/rweTREt2S2OsdsDWyJNIhh8F8kjMCqfWQmVBFk35ufXJ5s19wCkfMNDU8jwTgKqS3yaPk5UAoT/uZHomeY0+VD+bfTMsQ+b+UuGNS9/yqn7arHMtfGTTnv9ifW0M6ACbvsG4gGq5wqE6sWnEkRbE2pS2//0f5G9mCf/6uc6ygEdO7KWIIu5i1m8pvYTd6SOoeMM4WdKrcdrm051hSaxM7QOXLxhnmwLwj089QTlazNnyos/GMKeAm9J6EQOF9TaE+Jj6xAoFhTnru8Rg86CIZ5jCk2z/5QWcWAtECOCgQopnRlsxQX4vElK45TYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ih8fZgTKpRUKfbFDjAki9kXI1hNFYttEYTKJptVy04=;
 b=ANttBSLiE0du5nsLb5Ok7d1ah9dftxNutiX8/XjIXAmdKipeqydMvGQWlF1CiFA0bk7EaVra5PkGEbSReQQIqgacs4rkPSkYckA/bTJ2ZO6w7XitcAc2AXPlAusLx5Tq4FaYJHVczYzPQ8NA0lTf/9Bw5/RlzflrszPnXogooXPXRKe5pnUh0ridpXYTJJe4V/DSNXzaw27VBiu8NVbYe6xtxnBImg7AHKY6eiJPtfhftDB8FkafKBM9ixodCKYSPYQRLpUAB+ssAYXulSAKZsgSgxcTaHaAsHzItExWFJ6aNTrBbHCiEENVXV+72FNoDC7vXlg7iRIg67e3FOj+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ih8fZgTKpRUKfbFDjAki9kXI1hNFYttEYTKJptVy04=;
 b=JrzgiTH5Q63ciC9+1L9vc8/rnWhXxNa+HdYwMQrYTDp0f9URDpNBqp98qUZWhqthVyqblW8hMWjgZEIALY1ha/NRo3p+QnKuZ4rppgaFStTyjMTY7hXL19yV2/QVxrNYkB9fa8In6urMoOU+WstqBHUojG2sYO/iz8ZT0KBgCE/LutaClmsa2bW1AXbB9JDjLQObrQ1qHQUkmJfVaDZ8C6DVUM/1vUC2jZ6ZhVvDPpw6WwuYC/QkP1kHYDQP+B6dnxKnlvxuJwyVahwZb6IjmL69qWD6FEYGJQaPihggwiwjEudDPQ2mpc+tFiUadYG8JhQkDba9TwpHaQyUJY24jg==
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 08:28:07 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::95) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Tue, 1 Nov 2022 08:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:28:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 01:27:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 01:27:57 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 01:27:53 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Tue, 1 Nov 2022 13:57:12 +0530
Message-ID: <20221101082712.59263-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101082712.59263-1-akhilrajeev@nvidia.com>
References: <20221101082712.59263-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a490114-4acc-493e-1dc7-08dabbe300e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECiYB3ussOfvm0pNiOTAnoqoZ3o1DgXgmwSeVSSXmhCXZDbowIAYBydInD1QXyHeuzkgzAQnkJUwvxWN3luQPVyfNey0pBmTRH8c+wel8PvXv4IfS+9taE4yCmaG1WeoJrGqwKRvWGPEpBfFqg0LNEnrOEvk6iF6DmT4ygWRubsSlZMRN1472s7olhsYvG0ULWRBsyN9IQBOX5S7hSEMY1h1sST047qt966ObRrUMjPigajvL57+XikxGFU4MRI4hLsKYJIe9U1QdABz2s477JBbYdjopyec/bhwY8qD3xOWewhhXaSN0CY+TdYLUwN+X/mdmqDUTnhIJiNvuZk1+C2t+4uWCw3uBi8baAwM/ygzEw/zUKgGUTrDUvrWcNEJKn1OqhopukpV80VbpGXIYU8amhoEdklVUuZ3ZWzsBD3RJS+bPsOQjbtygv1DBTYAjwjIVEOiVgi/MsjJF1mXipXSQk2zw4xzHNS0jupm4sKFkR6+Wa8NqCi+oZh9+0T9iuVjen20RjQxke/Yms3RTToIsFYOacjMOh/5wy0JO4oQErJZhMuuVqzoACVS921Zyzz7O9kGNzMszJNeoBwMkTAzcNZpjAoGEoVq0kcLrshrjsBWaKEqhTt9rbs8UDvZu8iyMWKcDIj2ALGjNAEBja7TF85GY87HLOQJfwgT40mrET5nDEMmSdAX3FGbIozfrEPzL+aJ3FhZ3Lj6txOTvtV1x8ZSoxMhbYlIJDY12OnG4A088zLw/smcRP7oH5Mk1BRbcGbYgdE5LCxq8mYCIWg95mBH2NdWYxXxttPPiLE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(83380400001)(47076005)(426003)(36860700001)(82740400003)(478600001)(2906002)(336012)(8676002)(356005)(316002)(82310400005)(4326008)(40480700001)(70206006)(70586007)(7636003)(921005)(2616005)(186003)(7696005)(86362001)(1076003)(6666004)(41300700001)(40460700003)(107886003)(5660300002)(7416002)(26005)(36756003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:28:07.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a490114-4acc-493e-1dc7-08dabbe300e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for dma-channel-mask so that only the specified channels
are used. This helps to reserve some channels for the firmware.

This was initially achieved by limiting the channel number to 31 in
the driver and adjusting the register address to skip channel0 which
was reserved for a firmware. Now, with this change, the driver can
align more to the actual hardware which has 32 channels.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 47 +++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index fa9bda4a2bc6..31c8b46e5bf2 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -161,7 +162,10 @@
 #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
 
 /* Channel base address offset from GPCDMA base address */
-#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
+#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
+
+/* Default channel mask reserving channel0 */
+#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK	0xfffffffe
 
 struct tegra_dma;
 struct tegra_dma_channel;
@@ -246,6 +250,7 @@ struct tegra_dma {
 	const struct tegra_dma_chip_data *chip_data;
 	unsigned long sid_m2d_reserved;
 	unsigned long sid_d2m_reserved;
+	u32 chan_mask;
 	void __iomem *base_addr;
 	struct device *dev;
 	struct dma_device dma_dev;
@@ -1288,7 +1293,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
@@ -1296,7 +1301,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 };
 
 static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1304,7 +1309,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 };
 
 static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1346,7 +1351,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	struct iommu_fwspec *iommu_spec;
 	unsigned int stream_id, i;
 	struct tegra_dma *tdma;
-	int ret;
+	int ret, chan_count = 0;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 
@@ -1380,15 +1385,34 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	}
 	stream_id = iommu_spec->ids[0] & 0xffff;
 
+	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
+				       &tdma->chan_mask);
+	if (ret) {
+		dev_warn(&pdev->dev,
+			 "Missing dma-channel-mask property, using default channel mask %#x\n",
+			 TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK);
+		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
+	}
+
+	if (of_irq_count(pdev->dev.of_node) != hweight_long(tdma->chan_mask)) {
+		dev_err(&pdev->dev, "IRQ count mismatch with channels\n");
+		return -EINVAL;
+	}
+
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
-		tdc->irq = platform_get_irq(pdev, i);
+		/* Check for channel mask */
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
+		tdc->irq = platform_get_irq(pdev, chan_count);
 		if (tdc->irq < 0)
 			return tdc->irq;
 
-		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
+		chan_count++;
+		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
 					i * cdata->channel_reg_size;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
 		tdc->tdma = tdma;
@@ -1449,8 +1473,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
-		 cdata->nr_channels);
+	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n", chan_count);
 
 	return 0;
 }
@@ -1473,6 +1496,9 @@ static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
 		if (tdc->dma_desc) {
 			dev_err(tdma->dev, "channel %u busy\n", i);
 			return -EBUSY;
@@ -1492,6 +1518,9 @@ static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
 		tegra_dma_program_sid(tdc, tdc->stream_id);
 	}
 
-- 
2.17.1

