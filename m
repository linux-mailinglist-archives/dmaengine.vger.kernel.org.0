Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2257B4A6
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiGTKlm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGTKli (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 06:41:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451D1571D;
        Wed, 20 Jul 2022 03:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQLDEgYS+qb6IKACDw9HVD7XrT6vHskuXATWOhhC19moUq8mXIjBmwhKCaU2ISWSeUpW8cQo54o1xVPDas3ofIMgWRRdaO+xptHU5yWnU3TEoxBHNwochhWNT94qqkC336k1nVCtFaiSjVQWieXL2xfd6TYqfG/MgxGtWKO6b6ysYS3NsAPk66+kdKoqKOn+9n3jX0fIn8XVNl/lA2Utzd5Bo9PXnue3YZiKBZcDL8BX3Vp6Yv/NB/iBkI9MZuLyY1zUyUYTTAMcj9G/viKQDseRl41JQjZNc2hMb/uSyIkSF/MprVne1Ra5E+Xb8qVQre5pcvY5JFEfpz4FQcKDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo58TJkqm0o+eN7GhiDw4rdjxxK9z24/rztq1/YtR/Y=;
 b=hGDKvopLMUdhjT1yi2yDQfRAXAKx1WZe//EyQaqea39idjYa5LRB3g4CLfwfdOIDdV8pwbcOmvYQ+Catns1dt8gghVA4mbMyLWSUoxweIyz4YTanN6k4bqd5olgTqfIoiWpioIt2jegGnaJpW5wphy3JnBLpoLOByP1jk4jSs999wPWpX8KNVuouU3tPlVvskmyIE5xZKENZKf2NLoKfy/w7OOSL1Kx2i7uCQFy6Xo2zp/5LC5L5OX7DTL7jRq+IIoHYSBBnzIkMuA+DDEnmBDOAN5P8QVViwa+WIDrRbX7byHLKTZ57yiU3A3/sPFn4k8Ob6EG3Vm6WnrmtA7CeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo58TJkqm0o+eN7GhiDw4rdjxxK9z24/rztq1/YtR/Y=;
 b=Gra/eeucwQx32lp22hzmEBk6ihcZghsYFTV2SEQM+eM8RexT36cvGkyHapS65+Bg64Zow0F9YovX68c2EHahTT6ZOd60NwlAmtr2AO4aB3Ib8L8+ka3WfN0zsikv4evaEHvOmeneAD8/osERlW4vqTwjJCksAwj5Msb/CkuNnCtNm1FKSvdzULRpTcGvXhSx3iGElHojaLKWZjKy9+dKD9+VefKsjr+K2HJ/phQYRrrzbgVUMSNvvi4hkLwFXX/4WcYoZQ6aPCKNE8aUaLpXA9OIz1EvoMqWKszuLo69CJxGWMZ5JzwJB9X8CZiHhLOg81puOKgAISATQdkysM9L8g==
Received: from BN8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:60::24)
 by BN8PR12MB3235.namprd12.prod.outlook.com (2603:10b6:408:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 10:41:33 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::77) by BN8PR12CA0011.outlook.office365.com
 (2603:10b6:408:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Wed, 20 Jul 2022 10:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 10:41:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 10:41:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 03:41:31 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 03:41:29 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 2/3] dmaengine: tegra: Add terminate() for Tegra234
Date:   Wed, 20 Jul 2022 16:10:44 +0530
Message-ID: <20220720104045.16099-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720104045.16099-1-akhilrajeev@nvidia.com>
References: <20220720104045.16099-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9783cf6a-b140-4be8-231f-08da6a3c6a24
X-MS-TrafficTypeDiagnostic: BN8PR12MB3235:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmU3zdAq22QX2hNmDxgIimlWW6bDcW2yl+Qbg1ufW+f+3MCJN3w00qZTwCEAoQdwVngOppEzcWOXczU3C0/k5/e1T+67ylqoAnXtTfPYjHlYpMWM4cmqTFpzRnzhBKmiLJTGOM9olBLe0xDH2GiOE+ZEUev2rlYoSfyLmNxvriwkEDomFxRxVbIoD4NgZYzzZ1bOjbikx27nBLmRDY8WxAwfIlkGL0+hdt5xTqWVV35VsaFE1NW/XRMhO4+jsXUTFDesuoDT98giZaDNGTRE7rdnAoiZ4zxCNIfD7p5gMo6/YNd8NdGrrWt5j012um8cKRWbbTSQwxR1PrWRePp4AL6DxuNuXMWgS48WVK544hGOwQmu0ke92YdKezkTjUxy3fGct5Y7JpzP+bvoXeNM4z5KGuLCzMUXF3Qs4ZQYstFv6UH6zN+E2n27XyrVVBUh1oqKQfPcmaNsV4iz0ntoGaPYr8kuCHQ15HOK2w/AQeTgJR1k4wrTSTVJjIzLX/SmN4DcyENROUrT+DEOrpexz94vBjO815lQJUGh5UCNqlcg6SQueEtrJc5JtyYbIDBsvYO7ATMSjOdK0/e7RwUb0DCIsgxg8NGU1zTHGZ7dm9HX5+flaWNK6fwslLCyWQ3FXF7q0vHxidvZoSqBgFm1sxkCjks0fkFwr0bFGLIDezMtXjvaXaCggg1BaF8eJnxRXZRaG4sBTVa6mIi6jBvCZIWKwsfV2GndXBHPausWz4TuI/xHBgiYv8F5xjDRoHXWAw49nfoTGuAmMEdJOnYmPMxtcZ5GZpclZjwQkcMlLivbLLd0hnUAtbsGE0BACGWovGINXEybkfq0zmfgURjhGn+OLyB8PjLUa6MHzgThcqjGLtdod2r3izrFQA8utoFk4pWU3rMlreFDVdjkyA6lNw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(4326008)(110136005)(26005)(6666004)(2616005)(478600001)(41300700001)(2906002)(7696005)(82310400005)(40480700001)(8676002)(316002)(5660300002)(36860700001)(82740400003)(83380400001)(356005)(36756003)(86362001)(1076003)(186003)(8936002)(81166007)(107886003)(426003)(47076005)(40460700003)(336012)(70206006)(70586007)(921005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 10:41:33.5963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9783cf6a-b140-4be8-231f-08da6a3c6a24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3235
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In certain cases where the DMA client bus gets corrupted or if the
end device ceases to send/receive data, DMA can wait indefinitely
for the data to be received/sent. Attempting to terminate the transfer
will put the DMA in pause flush mode and it remains there.

The channel is irrecoverable once this pause times out in Tegra194 and
earlier chips. Whereas, from Tegra234, it can be recovered by disabling
the channel and reprograming it.

Hence add a new terminate() function that ignores the outcome of
dma_pause() so that terminate_all() can proceed to disable the channel.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 05cd451f541d..fa9bda4a2bc6 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -157,8 +157,8 @@
  * If any burst is in flight and DMA paused then this is the time to complete
  * on-flight burst and update DMA status register.
  */
-#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
-#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
+#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	10
+#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5 msec */
 
 /* Channel base address offset from GPCDMA base address */
 #define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
@@ -432,6 +432,17 @@ static int tegra_dma_device_resume(struct dma_chan *dc)
 	return 0;
 }
 
+static inline int tegra_dma_pause_noerr(struct tegra_dma_channel *tdc)
+{
+	/* Return 0 irrespective of PAUSE status.
+	 * This is useful to recover channels that can exit out of flush
+	 * state when the channel is disabled.
+	 */
+
+	tegra_dma_pause(tdc);
+	return 0;
+}
+
 static void tegra_dma_disable(struct tegra_dma_channel *tdc)
 {
 	u32 csr, status;
@@ -1292,6 +1303,14 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
 	.terminate = tegra_dma_pause,
 };
 
+static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
+	.nr_channels = 31,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+	.terminate = tegra_dma_pause_noerr,
+};
+
 static const struct of_device_id tegra_dma_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpcdma",
@@ -1299,6 +1318,9 @@ static const struct of_device_id tegra_dma_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra194-gpcdma",
 		.data = &tegra194_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra234-gpcdma",
+		.data = &tegra234_dma_chip_data,
 	}, {
 	},
 };
-- 
2.17.1

