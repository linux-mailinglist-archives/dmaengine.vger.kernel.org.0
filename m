Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D915B7724
	for <lists+dmaengine@lfdr.de>; Tue, 13 Sep 2022 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiIMRD6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Sep 2022 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiIMRDh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Sep 2022 13:03:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26DCC4811;
        Tue, 13 Sep 2022 08:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLOFb56QjKpcdtsD9CA1RI8kN5QtGn15HPPBxbJovQYYxaBCnWemgySvFByecn2MrXblybI2gLQ5M9sS07bwb18TZkNsJPinH2D63hFzZv2hy6OJpGMyp3UsPmOR4YnBCcYCLKmbL0ucJoRjUvz4VeiEvY0TpVaHdZJmzFtKfDFXjQoWioCuktxp0IOQXBiGmPUX2avD4nGB1rZPSOEBg/FaOZl4KWT1kGPvcEZ43ozhlK6uYqCbB/PYSlAPr37v7N/zNTnsFeQUmQINrHZwnQdEYhQyjREmXpp1qTHe7UmkmRTIGAiaREkwWY9JX1hd0HCYvBLwF+vOTk/E4RuZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJscrS+34K0AlOtjWfwpwUew7sSO2SghtKRRlNQMRZQ=;
 b=LipB2blNz9gcMmcaF33A+2dN2WpjGHioKkslTxoLBnW/ixMNFP3Nv9krN6ak4e5tsAiTM4sm/AeWVW9hAQr9IkxGxxuxF10u5yBxJ5IODHu/IooUznQe8MhqBHO44HjsHxeRpc5m0RjUcLfPoEXybw6pusFvT76mka8hL5ieIUC7FvQLz2WsQHh4Rj2iecXZyvHLnSVD5A3jGVepYknc8j0wlAQsjE16NVLyI/P9ySGsY0tR/raDemS/orAJ/m2YrUXYqtX/UkOQTffz0YYWpyQ6jCwLiaLxXpPhpHp34ez9OyHpxI3HimG4vvwA2J3745GY7AZEmM1HzmO0iJnfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJscrS+34K0AlOtjWfwpwUew7sSO2SghtKRRlNQMRZQ=;
 b=QjEDwZWADXA6trYBcL2Lq7ja5eyTHtUFZ31YYmR3YJfBNggN1nPew1e/Dk96oLmhH1osaMXiAUg+60/Lj5ZhQlrToI2Xmgyhzc73C0uMRVKdsFvoZvx4MJKP/KmPtyAr3WdQdgVMV4k8l5IDRKfD0ZLuo2qtDi5RFhutZV6TeRCDGzonQ6bQTBQYdZMpiriYwEZxPjfx4b+aQs1tLnXvANNK83ZEzlNOXA2a+Xq44DT6f4Ok3TKRW/fVJ9JTVMcvA3KIcFeFsDItEWYy4JMcOI10nt0apqgcnDhXEWUfY2j5PAAHOW3oc6kui3ysEXkYs0MJzPp3KuqToCoKWh93Qw==
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 15:53:30 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b3) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 15:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 15:53:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 15:53:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 08:53:28 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 08:53:25 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Tue, 13 Sep 2022 21:22:51 +0530
Message-ID: <20220913155251.59375-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913155251.59375-1-akhilrajeev@nvidia.com>
References: <20220913155251.59375-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c75521-0267-44c0-8d2b-08da95a01aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4E0vIAiADBFQKZeCYxeg0AwzzKHiHEqDvD++fDLGWQLmzn6DIdCpO7q1UVo1ZU+ugUj+AHMk0SJGPIg6t+Sm5OBDx938eBIDomVLQP6IWY5auXlaMTA4IeIbLRv3IJr0b5Al7gYR+Fww861PdUBPtMeb9orKfJVKPglkXUWUuyrqdREfKXdHSAJDm6Rw4K8Njlgn5VDeYWowpDzro+B/slVsjfKPNEjRMAz2L/ZTGiICroQ9YuN1irykm2QSwFtKPFbsuk6z4kRF7Mt1CwEJ7g5ioeyj6ZAIC8JoIchO7SqwRHR07bOyYA088gZJW6sXbC9Z3gkzSStYCV+ns+40BWxlCMRJEBzkrGTQ/8XinQJfSQ0IkrJGCq9C3WsawonduJ0LcfEZhsibsKszW8Bxb+bKiA51nlqlAII/yQddWkVmJXDmUUi9OzgSsc4eBzlVcIwyr51ds69kYw9peG3lV7VNRm17UpN+LG+p0tJwNU1bUXDhh+/j0XkleL8+gR/z0HJBpw/yhbB3or/aC/rVL65Wq/jhSKSkhrDWChV1n8wEp3J10YgdeT/EGsQEnjrA+FuW/RRsADaKQnQHA8x3LuT5wAvTvSfjC7Qw4C3fiGxvK9rVyvSjDkpdDuW2j3qme+7Q+nkmIvBQv6jXqdzch/2pMmCVBPN6Ih4BqCrhMZ1trh2pCGs/IT2qtlF8se3W0+ePQpX0gGG7RO/i/Z4ZUkuJXymGDgvfApvpnly1Hwg0av05320Y1pn5/jgUOJCHNI05n4Vdf7KpF7Mz82dYFRlDwX5hz+PnZ8VkNjOa7g6oT5uHu4RKcVT8AxDSuBH
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(316002)(41300700001)(82310400005)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(107886003)(478600001)(186003)(6666004)(70206006)(8936002)(110136005)(426003)(2906002)(356005)(5660300002)(86362001)(82740400003)(8676002)(47076005)(1076003)(26005)(81166007)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:53:29.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c75521-0267-44c0-8d2b-08da95a01aab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/dma/tegra186-gpc-dma.c | 35 ++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index fa9bda4a2bc6..f69a800c4f80 100644
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
+		if (!((1 << i) & tdma->chan_mask))
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
@@ -1450,7 +1467,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
-		 cdata->nr_channels);
+		 hweight_long(tdma->chan_mask));
 
 	return 0;
 }
@@ -1473,6 +1490,9 @@ static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!((1 << i) & tdma->chan_mask))
+			continue;
+
 		if (tdc->dma_desc) {
 			dev_err(tdma->dev, "channel %u busy\n", i);
 			return -EBUSY;
@@ -1492,6 +1512,9 @@ static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
 	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
+		if (!((1 << i) & tdma->chan_mask))
+			continue;
+
 		tegra_dma_program_sid(tdc, tdc->stream_id);
 	}
 
-- 
2.17.1

