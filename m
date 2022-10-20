Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA66059F9
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJTIej (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJTIe3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:34:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ADC184989;
        Thu, 20 Oct 2022 01:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igT/f3oqo+N6FE3RFwNCgWiD2lLdp7b4wrZQSlnDhcNyToQl1WFyunpvutynPIjpIc8NYr3nbePvjUOWx7xwUVBdeI4TIiX4MhZdWU05Rw8lQIM9oUM9NFLoR/7xulzOt/JI/FlwekbxalIzrckjrK01vnmuO9cqcgsbKqET9PKAjoHNb8DCM8qQd2iUCkmM5kJQbROCS/U55LgB8H5X5K+OAYC3cPJiyelFL1PEJ07b3x9DgPOzQt4G/n/FJXMPZFD6G/62kb3L+k1WY5nIGlPrana+lYzj9hlwgq1QouJ9Yxjkb81rXxyA7WzaifMkB+32L8mmGTiSHDf3gYjzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNwyMeAIYU3rsM0sxRbv5dfLY4ZKhEDZlaw8279Ciz0=;
 b=XOiMH1YvutISHowN88X5+OKVDz7iOjPSGrTi5pBi6CLdQDqmjUSE04Dm4c+S49oMQGt/9sECtrxfInrcsTSzIAxgqsDeK0LATgNZv62w711tiyzP5UnjpTI+kiDv8grBpZzokyEb2Deandj+6qkrGhtkF2U07yeCfBTZoK0P1aAHtF1XS6PRwd1fhBvtu4Dzl80Z3NLCJr5DcbMfQHK9Tme5r0laqucTPQdDt04l22RxaEjSKl4f5RIwXODiwTTIFtjmFfSqCby9kUWN3pipuV9pYGwRwE9xmweLMifXOKqvCM1VFexlU8uIg/GMPFB46RHZg0YuDM6SuVythbwuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNwyMeAIYU3rsM0sxRbv5dfLY4ZKhEDZlaw8279Ciz0=;
 b=Qtk3/hFwr8I92dooADU72pC8gWOzfTe6rXq+XZn9yuYzNsycgCoc1RJJxMyJp7jfmInnUau19ty5Cq24GiAgrR++x2lCY82RlhDwbmkkehwF0YxHOG61drzkvYFjz4OS2b2dWKzAs1jrOh9AhuCRzQAkGsN11uAyahHE6JGie6o3SlPF6gMiq+kLh1pPToBwo5ngT0oJyABPltAEPgwxUJBIkpatwDZE70XHui+o5z8ImkByrhK+FLz7caPfTKSBSbRXEgzEwbxgXRawfYuYg2+M9eRj+g4AbYCM/nweLJqv/Cn7/Luep6m5oPXMgQ0ULJ5lqsMO6le+Gux0LXusCA==
Received: from DM6PR08CA0063.namprd08.prod.outlook.com (2603:10b6:5:1e0::37)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 08:34:15 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::e7) by DM6PR08CA0063.outlook.office365.com
 (2603:10b6:5:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 20 Oct 2022 08:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 08:34:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 20 Oct
 2022 01:34:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 01:34:04 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 20 Oct 2022 01:34:00 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Thu, 20 Oct 2022 14:03:22 +0530
Message-ID: <20221020083322.36431-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020083322.36431-1-akhilrajeev@nvidia.com>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CH2PR12MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 84289e0b-47fe-4bce-2151-08dab275df4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKWRFziNLcYBOhTc9dVeIKdGJtUKyj/qGSlLBeIQgz+uhvxxdeodxKfiRKf3B6h8YZyW35NGttRW/eGLKlKX6a15YHBX33oJQsRe0XxtK6mMtpBplDLwqUiMjdEnqb88BjXgOvGnqNHG5/9EStgr6LYiYprOgVM/6XdXGlPW9XWD4AxSKBrcTYF0tQR+n5P4PYHt5zXHEEDE29aVYzpGidGs4MID4D7a4CDuOycsqFp/x6El/26j4jGTviJSPyxWD+8sov83fjDsXxK8faZVuBIsGzarzaslQuRVO/56wmAaSk5zezpCAZ7bKuQ95mfDUD0qLa9l2uY0mAK7uMky0crUuc3Fs/aDqHL+hTV/XUpfI9E7sENtYE7PekVuf8x+6xfPWQMMVfHvLzXiTVG/HgkL6kxqrIO7NFl8Lf9uD7xQohHuXHGcCFA9uBGmea7gyCyPcn4a+u0bBY6l4Kz7uBu2y82CFUvZ8JgbyPfnWDuqksa6Q9/cBw1o/06r8DpdUztONEFp2DuWqvcrtBlr61cB5HrvWa/+BcWJU8iJeooR/qDjVSbXX6LG8wb0mVvRlCblv6J07XJzZrYuzpf8Tm348vbm8+/NmKn2Rn0UYfnn47j9F6YLEZPPqH2njZx/eGLzA+9kbdMKoCX41AaexveNQsZg2FO778Hka4cTQVCQm4vmsqGsAnjUVgOlLOm19McK3gnifk1wr0G9A3omP7Yr8/0Wpu+qoYf6sNkUqNHAuWOh/zw40zhq/Lqj6KtjOJDMowr4oWbBCKKKTuqZswHOOWtLhIoMVTxkkE2x2Q0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(26005)(7696005)(41300700001)(86362001)(83380400001)(47076005)(36756003)(110136005)(8676002)(4326008)(426003)(70586007)(70206006)(8936002)(336012)(5660300002)(7416002)(107886003)(6666004)(36860700001)(40480700001)(316002)(921005)(2616005)(1076003)(2906002)(7636003)(356005)(186003)(82310400005)(40460700003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:34:15.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84289e0b-47fe-4bce-2151-08dab275df4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
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

