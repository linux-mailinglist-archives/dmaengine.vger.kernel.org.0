Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920CF6030C6
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJRQ3L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJRQ3K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 12:29:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA0BC466;
        Tue, 18 Oct 2022 09:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnmvB1YgGKcez9BBJQAhAozNS1MUr1znzHUDSnCR9Pai8ZdxGRHCTLiIVUiZy0WUCFUxcpudf5sts30PIaBRVutytvhGOUv/JQLMdo3qJnGcLmlaWZhx2lI5kgVhLPkZB9Pw1pGF+TUrF2KXYyO+OOF+7tdZySH6JDjQyKxz/zXGLUTmzhTiGYgSuqWv63/2zyZ2muLxlSM1+frTk6/s62eBcpFZwsUoIAgjgRLSPs1kPqVa9ZxAVbIkUVx7XJ35Z3v/it0UJga5EWeCNM8WPM9/ENBTJVrV/Y6JpV8SCyaUSUo+FhzDHSNH2GwVgke2k0ZZIV8R97w+xXnu0+nysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNwyMeAIYU3rsM0sxRbv5dfLY4ZKhEDZlaw8279Ciz0=;
 b=ALK3CTObDk0xYwfebJOYj6QfUM38xziP68vSH4u0JjV3c4VtEGNJYFTRrSEbbyvjtHtb8MPxZd0t2FpJZhPIkg3QSm/jru8yELCrpUvRzbZZU91jaPBsXJPd/3yMPtqFExb32dzTXZPgx6R+elqLfAao1OGTUVsuFnrtJFzs5cQmNfV/hemHGiL2Ew+0GnCu5UXPqzLaL7xMKRqeaKSI2iAh53zA8Ecetl++J+qg6yp6UWNt2sFUB7OKgpU+DkkDx8D3Mj1KBSFDelKt/ywnjETp25bcxdUBnx6J+0LQN/6paxsVH8oj1UBVeYxuF9VkWHoEDSCjtCPgwsVLh5B2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNwyMeAIYU3rsM0sxRbv5dfLY4ZKhEDZlaw8279Ciz0=;
 b=XkWHeqW6Qg8+fen5R6dv1r0u2Rajf2+FCBS7KEaE9ca8MvSXATalbxkFVEqtXcuOIGprw6bswLn8290Y9tEEaNLM8ZJWu8BBFNK8qiY3HiztqGhdGJVNbP89SNc0Q/ZWJk+LJeD/Uw2k6NNRUKXvZXaBSwIlr9rd1OzPPcunQFdJ6LfZCn37JHhrbqFD1zDySMhB4hPbNDdckJ6AamQfgXEfqkqNZiRZs+gbjiVh64biNeegE2dfFlscg1Ei4cki/bX3kLwu/w7dOnxwM9fSMA98mH5r47AZjF4Ty4ImcC+klkRL1TTgpBuS7CiigaxDI5N9vH7WUw2rt+qsg8Eqjg==
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 16:29:04 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::f1) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Tue, 18 Oct 2022 16:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 18 Oct 2022 16:29:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 09:28:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 09:28:47 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 09:28:44 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Date:   Tue, 18 Oct 2022 21:58:12 +0530
Message-ID: <20221018162812.69673-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018162812.69673-1-akhilrajeev@nvidia.com>
References: <20221018162812.69673-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 40123605-acf8-414d-3bc5-08dab125def2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZxOWxw930dfHXMEvveriM9BT0cgnXx0plZ8vWQoQNqzeGhAs+8l4ZK/FAXKtDOKOCpdPzYUZhI1gSbVHO/z9JLpnFkUxvfF74fAHjAkAopsq/hzfj77fbGe1mQ/s/9GJu2xwpgz/HJ4Z9Wmargc7F0DqwKzBnzNj663tZmMdVSD7jRL5TQxqzqZeY+9awIWFu39nIV1Xmq21w492urnDH/pA4uQXUvv3XHbvoddKmZXoTWpeKQMZvmqgroBwk+OpXmUd9AP1IAXpA7kUacpdkXBmhfuPutzExHJ+HDuhx4fcR33xxPpZWgQnCcXMk0F5yDyh45la/YbKq2PcOY5m1YYmBrG/bj6jNQWg11CIokTAy65kCxAKbtGAgOpmh7SBGZf9fU6MXah/14Z3dEu+oVeFRScLOuKmM1Qq9vSYTk//3SR8v5CFvTk31iAfFdNTiFrFyrpQE0Grkt6SpXwgyb2ZTxKbboCpBS7/BInAWDO7F22GD50ifMldU9ymdYVaF/arzaz4McA9fXjJ4eo5lDK6wpouq5IxlyOp7l8JdSxzNgC9D7ZNMc8JJYm4DsY7L/J3oOXAUr/Cfnlr4lJjJfhSLic4KNEHde8GyxhGuz5ctVXvLX3ddDrxCTUbxvj6MTDTSfAEyDdsnLga6KEvKbvGMw/cA0ig5DGLytylumTN7c+3ZoiXoHI+MjOiG5/7POF8S99TkpZh8aXKoZHQqHdzWQWb0EuM82kha+hK0w+Alwn9wyTLDDhBBaP1dDlrjINFF45hMlxHlfV/0gfqA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(82310400005)(8936002)(5660300002)(86362001)(4326008)(107886003)(40460700003)(41300700001)(186003)(26005)(2616005)(1076003)(478600001)(336012)(6666004)(8676002)(426003)(47076005)(7636003)(40480700001)(70586007)(356005)(83380400001)(70206006)(7696005)(316002)(82740400003)(110136005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:29:03.6326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40123605-acf8-414d-3bc5-08dab125def2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

