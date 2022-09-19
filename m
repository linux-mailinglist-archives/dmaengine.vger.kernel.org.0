Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B35BCAB4
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiISL1J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiISL1C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 07:27:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3E1DA7C;
        Mon, 19 Sep 2022 04:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLU8fl484OmCc942RvOZtuTHOY36RTATU7ewBV01wR20/ZeYIMki3D3m8g3RyFWFzlZywkqJSH8GLoiOR5v+U5w2Z7Uvz47R/NYt4WDxHY+jUVEVhBCppDA0yUcQpDEphy0khnc+oKIOK/o8nEk+Mv2SrN0JSTdQTCa+aLbAsertuzf66TnFRxsg9a/pkeb7s1ucSBjKLkPnRt/YUS9PxF/kYugcGUDPZdKHTAW4qyvYM7iNetab4eZWUaKg/UK/+DcgtTQhHfr29q57IM1cVQB3zxgjkCAgYguXfIV56nlPB364WnVunBUlgMaFRPNcH9TYfVa/liow8ljA/VDc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVhhLV9hqxkeJhUweRR36JHUb36jr0NcBdGSM0hIUyA=;
 b=SeECnc9yxC333E5NgrG3bxZR+VuxAFTqPgSiFop7ugp7ZimdJGDkyN5IG/nMzwjSwC208FD5SNgMI8d9dk1uAdMU+N5UrEGW7lB3kBxWQHzaVOHh28+XefpOLXGHtwLvJZTrEt2jGEngQYhwOxYzT4goCMj5M2LNZ76aN9pWtyErASe3p/Q2YG2P6JbsQfpkN1iHmK3dpmK8xp7kPugjVvqoQwHcVJNC07i4Kd3yLarI7I87gRdaxZv4j4I6p5bx0qgmTM4HnKgj1PnH6CaNg7hrP1ov2cmOKe/V5no3Y/N6K4UDk7YniP76wcOAvIe1nPj7IXUVn3lKH+EhU5Qegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVhhLV9hqxkeJhUweRR36JHUb36jr0NcBdGSM0hIUyA=;
 b=pP5RqvL9YJVpECNpy+HBLlGxZyDLq6B/IZ4zZmei+y18XQqJd1grVGwRB1Xs4/4e+Kcy43/ZDS7t/jWHwzUq1M08uqKtp/MJvyJn2CRdl8ynxrfJS6Mt7LLKDzE9uKF1eFe+SrmyFw8O20l4EtJUAvgVHM7dwfZNrVFhcslA9I38Z7xwz1Svy1+q6fkYD54gmaLmY+XmRGRV1NIPUvpq0JRTPCTw1Oti2+pSzWzlW+moAeAjE34R0esUQLK6HuDO6hpZhE8xDSgImfU9KkFjvc1DNTQJP96f/mFuobm/daEoun5+tJ9SH1AGZW70H7NCDpWqImMX8WqCR4tWALk0lg==
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.18; Mon, 19 Sep 2022 11:26:49 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::1d) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 11:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 11:26:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 04:26:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:34 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 04:26:32 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Mon, 19 Sep 2022 16:55:59 +0530
Message-ID: <20220919112559.58195-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919112559.58195-1-akhilrajeev@nvidia.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 41064086-adcb-4d0c-9b33-08da9a31d7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UATFQy9828k3yxKNl6CqaVMDQfgpGCkQ4vThqAzbj5JFqqPQQOKn78bRGsDPT4M6SHSaZW7zU4xwKZoc7Jovpn9vDvl+yRbVXCyOsd5frb+evzlrBMfyGVZw+iFl6LfjMPC+zAFkx8rxZuNh5TjXyfSgHDkQRMrex4sJkLjM9wvTsUunS4nykNeJDUDfsTHodirbmoWXU+z+9pjJU7QNQrCOAUX9X3tbwde1goDlAEAYoezoJTr6XVdN6sWces3r5UrDsWluhcihYQr7JcQjAt4N9MV+eRDS3iQmXfcI8xmA9zhbn7MG1j9zvCrV1CsRxCYb4hJ0MD0Q8OqMuO7q/NI0F3W3RMDfglymTRQWfiFFiNKb7u26go79JvqIkUpzV5OzVazShKiTeIaDYwJzPMONIbPCC7ETD0WwbVjYXVEC3JuHHodfrNb8arOVUbKdcLex+yZomfSTam9rgtCavUQ/dwFGr4JNU45v9YL6469TlEN80ZPdp6OuimE1Lboo7F3zslEIJUn22iR03LKprsVpS4ePgxGBjy5eniZWWcVRZXGRocOXRnAfSnrz1jAFhzFts95XwHFtW45uCFCpzeEYPyyQK+hTnOHk0N8FI+ZaVn4p/P0mIwkZUlyLUH3X3GJ75VgVT1B1d8Q3R1O3gMnUbBwvILsGeo1rhmMpQDN6xSb5GgGvWwefGK1FEH9T/ZrE+T8g90APYd7SCQntxDoaXhBehfjty0tAKEMqwaQSdHV58/eifoFxyQojRG6cn6zzXhhRu4W6ZF0uYvTviQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(2906002)(8936002)(356005)(7636003)(70206006)(86362001)(82740400003)(36860700001)(47076005)(82310400005)(83380400001)(107886003)(7696005)(6666004)(336012)(1076003)(110136005)(186003)(2616005)(40460700003)(426003)(26005)(70586007)(5660300002)(4326008)(478600001)(8676002)(316002)(40480700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:26:48.8583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41064086-adcb-4d0c-9b33-08da9a31d7c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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
was reserved for a firmware. Now, with this change, the driver can
align more to the actual hardware which has 32 channels.

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

