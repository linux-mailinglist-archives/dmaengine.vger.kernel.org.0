Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746F87CBED8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Oct 2023 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjJQJS7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Oct 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjJQJS7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Oct 2023 05:18:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF5F2;
        Tue, 17 Oct 2023 02:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apim58nGopzXemNlz4jD3D3dQQhEnsYdN4K1N/Q4f1WmFqMUbGWRKRY0JqI2sdwyjQQ/stv9p5/rj+xx45OV3Q5P86dDeo4U8aUqCjyDP/wVOvjTat1wOUOad1www54WVCv9nDEHhYzP8Dm0P4AF6ruOjdUOsPs97plH/cKTHLMd5An7qppb/9119ySZWMneigZYIoWOf59sEON8EqaVntosGjZiarSZP9LpJWu4qm9gmfrPy/Gb5JUnph5PYtlWQA4OoDNY98Op+lkYx+CsCXapYrpu1Qw+o58p7/5/vJ/9BtmwuY570Xo4GNsncvmPQ9MoZUcmQuhg0juApx5vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z+D5Hmvmoy3n9rJS4yiygr2B91KtD2uOMgmZPT0JYs=;
 b=Dj/jttZEbdDMen6jmbd0c5k9NDVYI4sb6K1lcFitCsLylN0sNgvv4Yk5L5t3+c1IPB48/q7VaP0SjD7ejvHS1ha9KE5B8iEo4fAq04xHQdg/82bD2nSzTus5feGjOem+FBzY05RwOHgXgOPGUa2R5A9Bh81JO6CgEggOq62Hjul5gMegoqhyn/5RMfu3vcZSquy/qv3W+1aQQ6nGRmP7IoDMUEHjLWDO5x3WVmpocVu2A8I1jU1ItKA9VSNR+rNe2/NbUO2maar5itM/eRnoA2r+W0CEFSpbschcfMM/IWDm+2zcj0x6Favl/XjOy5481UZbvBYqjWWnLIx3vz000g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z+D5Hmvmoy3n9rJS4yiygr2B91KtD2uOMgmZPT0JYs=;
 b=mjMxvcIiL5WJEAejFAHKMOUAUpzoMOFWcrnq5A4f//uAnLHYkoZ/cmXSorf9etcVEcvSJA6KK4V1FFcZSw2IYjCj7+2XCNbBtRGQCaGpJlHAANiandBksLFn16EoZh/IPkHGYstP+RAXxWTS5rzqkjHRXlLIcCMwvvBaw3gtruXOLWc0IEV/74ep8E7htVVq+Y50T+kcYBE7DnVCfqInWDepw+iV54UtFKRd+A8mxVeAD/L+LB/srt8joYrDqw3Gp64wz+7W8Xg4Z+V6sc5e+l9i4MNoW93cdU/7HVqckxrP7RUv+XSDNBY2BM59kWdThXtvtKza/+dMDFu1dMD2BA==
Received: from BLAPR03CA0122.namprd03.prod.outlook.com (2603:10b6:208:32e::7)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:18:53 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::f4) by BLAPR03CA0122.outlook.office365.com
 (2603:10b6:208:32e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Tue, 17 Oct 2023 09:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 09:18:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 02:18:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 02:18:46 -0700
Received: from mkumard.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 02:18:43 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V2 2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
Date:   Tue, 17 Oct 2023 14:48:16 +0530
Message-ID: <20231017091816.2490-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017091816.2490-1-mkumard@nvidia.com>
References: <20231017091816.2490-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 992cec91-fcfc-4679-b450-08dbcef2149c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+qI/zBE+NuhuaASyaWAXYyXaSuw7UMMeEB8e5CvkjRr2JPuXuoYfFZKJoOmMrCHo5jCHjuKBcbSlYfY5OwwTYQM4bI1VeDrt1TR7e9DOMaFD/fLJUJTJGFoxf2RZvH0afXzZJkM/kopAmWvCSZpEocBxAWgKtmQuduYO7E3VuzdH57QZagYsgE6fHgtP8VK48mKNQNdR+nVxS/BkYDN9BshU/KdMDBqL62jJUF8IV2e2DvrfTwFcbWEPekFzu6/M8fgqYLkLW+RT+wZqq/bcbDRW91NjdlSQji/W0xXNKh3QJNyDWOuGnO4BVHeZ4xikLAdRb8LhZGahXh01BLTe/bYaNG5xHhrgeccIYq+l2+d1I1t5JHiZBu5ID0P332AwEBhx2j7gPuNPlRwsXnPM5+wTlpqSRRCjL6CUIJf3WhlV1Fsk2QCcNQyfPqSKyPPlgVxkCX9FYPKD9KR0+sto42QjuUT3u/bssO1LzkSA2iQephxuHzT5w1cK8RxPWK01jMY/zC+aB4A3FaCHeCvyFfDZQnlw9bk/vXpUD/SStWE2Sbu6jf8S/AckGSxTwdaUVWsokyz3hCbf6M9WeqoFoY4dpVHflsbVsn3X+EkCihCkQfV+d9//f6p5BYJex3g1mbNEgk38mQmAbLe9ud7jrXOlepn6jcKAEOj3VNz4eH+tOKTWJNN15C8jgsJ3uEM1AfNQVkiLfvzptXkGZD4MxIi/Ppt1skf/K7M5ODTF5zcV/JG1f5xi/tF0roFeAsH
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(40460700003)(70206006)(70586007)(110136005)(316002)(54906003)(86362001)(82740400003)(7636003)(356005)(83380400001)(47076005)(36860700001)(426003)(107886003)(336012)(2616005)(26005)(1076003)(8936002)(6666004)(7696005)(2906002)(478600001)(41300700001)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:18:52.4403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992cec91-fcfc-4679-b450-08dbcef2149c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To support the flexibility to reserve the specific dma channels
add the support of dma-channel-mask property in the tegra210-adma
driver

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 7a0586633bf3..24ad7077c53b 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -153,6 +153,7 @@ struct tegra_adma {
 	void __iomem			*base_addr;
 	struct clk			*ahub_clk;
 	unsigned int			nr_channels;
+	unsigned long			*dma_chan_mask;
 	unsigned long			rx_requests_reserved;
 	unsigned long			tx_requests_reserved;
 
@@ -741,6 +742,10 @@ static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 
 	for (i = 0; i < tdma->nr_channels; i++) {
 		tdc = &tdma->channels[i];
+		/* skip for reserved channels */
+		if (!tdc->tdma)
+			continue;
+
 		ch_reg = &tdc->ch_regs;
 		ch_reg->cmd = tdma_ch_read(tdc, ADMA_CH_CMD);
 		/* skip if channel is not active */
@@ -779,6 +784,9 @@ static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 
 	for (i = 0; i < tdma->nr_channels; i++) {
 		tdc = &tdma->channels[i];
+		/* skip for reserved channels */
+		if (!tdc->tdma)
+			continue;
 		ch_reg = &tdc->ch_regs;
 		/* skip if channel was not active earlier */
 		if (!ch_reg->cmd)
@@ -867,10 +875,31 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		return PTR_ERR(tdma->ahub_clk);
 	}
 
+	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
+					   BITS_TO_LONGS(tdma->nr_channels) * sizeof(unsigned long),
+					   GFP_KERNEL);
+	if (!tdma->dma_chan_mask)
+		return -ENOMEM;
+
+	/* Enable all channels by default */
+	bitmap_fill(tdma->dma_chan_mask, tdma->nr_channels);
+
+	ret = of_property_read_u32_array(pdev->dev.of_node, "dma-channel-mask",
+					 (u32 *)tdma->dma_chan_mask,
+					 BITS_TO_U32(tdma->nr_channels));
+	if (ret < 0 && (ret != -EINVAL)) {
+		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
+		return ret;
+	}
+
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < tdma->nr_channels; i++) {
 		struct tegra_adma_chan *tdc = &tdma->channels[i];
 
+		/* skip for reserved channels */
+		if (!test_bit(i, tdma->dma_chan_mask))
+			continue;
+
 		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
 				 + (cdata->ch_reg_size * i);
 
@@ -957,8 +986,10 @@ static void tegra_adma_remove(struct platform_device *pdev)
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 
-	for (i = 0; i < tdma->nr_channels; ++i)
-		irq_dispose_mapping(tdma->channels[i].irq);
+	for (i = 0; i < tdma->nr_channels; ++i) {
+		if (tdma->channels[i].irq)
+			irq_dispose_mapping(tdma->channels[i].irq);
+	}
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.17.1

