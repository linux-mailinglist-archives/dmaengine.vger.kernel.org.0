Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2115624822
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiKJRSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 12:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKJRSn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 12:18:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346864EA;
        Thu, 10 Nov 2022 09:18:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B13nDrTm/hD7NBJbMft4X9HZ4te1LTNtg56e/LDKPVjdAxH2IUH47bxyEJDfjgcEH+6cVUbLAO5RF3eYowKdWF9YTD3MNyBKpzsJDXmuoXs0vpk9TpFk2DBvy/o8PMoEkTekgws8xxqys7hG+/aCr/aX8Hyhpbmt02MuRP/QDuyMO/kLkkVlAX+m6/qsO7R8R2fwRdr3uBpAonPzvrt/8l9eZV/0x+gFpwbP54+DcmpcWfoW5/faILIquFRHW5GmtmQkd3x5NL9lCW1INneD/d90iTLOs3XnPI2eJ0tENSm8d3TJ1sli0tw9lWXC9jU4sv5/y3v4iBsvVq6rgHaFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCJZFODP6DFHQ5IF0TtSH2Dr5BEJmkhRdfwwGd20JYQ=;
 b=NRwz1q9TDgmRbJSYIzmIW2UexdBLuBt7dMFoyN5Lhjy0Pz/Xrr4cT6clNHOwqKvirno1tP33XLmJjeB0F6IP/lUzx5v0D9OgWa804o91TQBiAJuGrYMcs8c0GdtuLbmkXSdPF9QsPIFpNAfyvBrtkeIiNzMvge4UJq1D8r8ObaxZKVo2y6z6Uwvk3yFKQBqGALmzwd7sppyMXn1RdV15A//RKjEwaE59it2BqYzNEo8KbKaxCn5wTVihV0g9YmPhbmLBJR4KutZWMK744u3VTfjPPrMTH0qY/V7ssKSUudkHvRwPnyai2U+L96DOfhTv2kTPJqTDa4DYQg/gYHpDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCJZFODP6DFHQ5IF0TtSH2Dr5BEJmkhRdfwwGd20JYQ=;
 b=AduzH3ODETbIG3blDgYOfCKiLVG9853PhSpzDethCXo9IQyutdZ3znt9AByYGAVm1QPuXlijS5W//HdszKxsq/ytUl63uElnepMFSbbgOWixSWEQY6QlskFwEjfjInJ8l51Yu57+ALoYrxE3BvgSjKVDmmEDUVGzYp9zYWzA3zJrT1zjzUQPD7010AgDaoatcJddTZlu8fRsTLLg3u546C+fKHFHM3KJcESeAViQn4JZ25T+oWzlbD4HN/A1NPKnpxwQJi9jwWsZD3foJQ4TNbaBYAuP0gOVTrN6Ayq2cs/GvgUP1uT2ITbmbwuAhIc6lqW01EI5t7d/igEpssngyQ==
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 17:18:39 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::ca) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:18:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 10 Nov
 2022 09:18:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 10 Nov 2022 09:18:34 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 10 Nov 2022 09:18:30 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Thu, 10 Nov 2022 22:47:48 +0530
Message-ID: <20221110171748.40304-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110171748.40304-1-akhilrajeev@nvidia.com>
References: <20221110171748.40304-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: df145f6f-a34f-4b1a-cc32-08dac33f9bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwg2EboKOEOtq2GrQOWAbXXLkj/a2trV3PveWPQLapqAEvf41CfWy+SyVgzZKG8iCZLuTXid7S3kwkY3hTizmG0J7fJYR9UbImKiN3RpNczZhHatEcr5BXdEvGjlqWVV0S5r2V+MP9Emdjvjlhsh7v1Au3mmL9aTNb+3H6rl76o0kGw7+iZYGOxDS87red97ZKxMKkhTvCy9TNay0UIm0hr2xoG6tomcuO0+xHQSF3FxVJw9R9Jc0/1GPjMUZFcsbI1PWnrv+SR6uNPbQra5AlOA4pxVZIvqS0+7XluBq5pW58dZ3Yc4XyqoCgSIVroJOFBo3SSupOglyGt/AYqSHbS2856ie4sGA0zNHCWZFlqVZuktzwH1f3kSQDgmUW6FoQFWZFjnI7FzSoec+eVg54Q9//ky8o78Hnism11zacoHScEFlZBFHKPpiVKc5hI7Vv8q9fsNzVJIW/vSwoesbHzNj/cOkiXZTyAA7voxlNfp5jgPJ0tNkzcGsf4Ektez6hKZmZUWBgVBrflJLLoL8jXnhKn1D6MugdtEN0dEd2+87wepQdi7aqgvKM95QnFnMlYWtU6YaopOy632s5H5y4vtWnh/tlGWAT/Y9lYY9m8adkXgy4R20WnXPIAg5akBEe9PbOwo4XhN82v3DnmN/sXyOmswNs2GW/27KNvmOtZsCiucuy9+TeNEpkLelbLQ4ZR7m0sWmZUKkYvROJhlH92+2do0jfHooVmFHuGOdB9aondkthRhSGMueffORn5gadO4Bj5VNMkZbUuXaMcJF/09dhQ90JQTOeUf5tqnxEbQhU7NdeC5z2NzWJg6QdPx9SELYjQpOt485OFQRiwCvrb1kgr89dJsnjFy9Eu7Cq0U1srIOamtRnhUXkb1FylI
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(47076005)(2906002)(336012)(4326008)(316002)(7636003)(356005)(70206006)(7696005)(83380400001)(107886003)(8676002)(6666004)(426003)(966005)(2616005)(40480700001)(478600001)(26005)(186003)(921005)(40460700003)(86362001)(1076003)(110136005)(36756003)(7416002)(5660300002)(8936002)(36860700001)(41300700001)(82740400003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:18:39.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df145f6f-a34f-4b1a-cc32-08dac33f9bf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for dma-channel-mask so that only the specified channels
are used. This helps to reserve some channels for the firmware.

This was initially achieved by limiting the channel number to 31 in
the driver and adjusting the register address to skip channel0 which
was reserved for a firmware. This is wrong and does not align with
the hardware.

Now, with this change, the driver can align more to the actual hardware
which has 32 channels. But this implies that there will be a break in the
ABI and the device tree need to be updated along with this change for the
driver to pickup the right interrupt corresponding to the channel

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/all/Y2EFoG1H9YpfxRjs@orome/
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index fa9bda4a2bc6..1d1180db6d4e 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -161,7 +161,10 @@
 #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
 
 /* Channel base address offset from GPCDMA base address */
-#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
+#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET	0x10000
+
+/* Default channel mask reserving channel0 */
+#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK	0xfffffffe
 
 struct tegra_dma;
 struct tegra_dma_channel;
@@ -246,6 +249,7 @@ struct tegra_dma {
 	const struct tegra_dma_chip_data *chip_data;
 	unsigned long sid_m2d_reserved;
 	unsigned long sid_d2m_reserved;
+	u32 chan_mask;
 	void __iomem *base_addr;
 	struct device *dev;
 	struct dma_device dma_dev;
@@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = false,
@@ -1296,7 +1300,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
 };
 
 static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1304,7 +1308,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 };
 
 static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
-	.nr_channels = 31,
+	.nr_channels = 32,
 	.channel_reg_size = SZ_64K,
 	.max_dma_count = SZ_1G,
 	.hw_support_pause = true,
@@ -1380,15 +1384,28 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		/* Check for channel mask */
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
 		tdc->irq = platform_get_irq(pdev, i);
 		if (tdc->irq < 0)
 			return tdc->irq;
 
-		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
+		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
 					i * cdata->channel_reg_size;
 		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
 		tdc->tdma = tdma;
@@ -1449,8 +1466,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
-		 cdata->nr_channels);
+	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
+		 hweight_long(tdma->chan_mask));
 
 	return 0;
 }
@@ -1473,6 +1490,9 @@ static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
 		if (tdc->dma_desc) {
 			dev_err(tdma->dev, "channel %u busy\n", i);
 			return -EBUSY;
@@ -1492,6 +1512,9 @@ static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!(tdma->chan_mask & BIT(i)))
+			continue;
+
 		tegra_dma_program_sid(tdc, tdc->stream_id);
 	}
 
-- 
2.17.1

