Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BA570776
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiGKPqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiGKPql (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 11:46:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73168DC9;
        Mon, 11 Jul 2022 08:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2K+rHhBmPXeJOFV5XOZNBVlBfoOsl1i6x6Ay4/0Ea3grhetDR9bU0HmZfknkLLUEkY+hoOGelMJsh3coQKqcZbPaF/hzd6Fph1dBmexwsJG/hdBM4l2C+XX8Xo1noMjcIqOfIGPEDeRc5O68Rkmox//vV0jh1AyvBSBdVzcQ01dw1qzpByWgEvYnnXxmW9aajaTa4Kbijj5Xsj+aonjKQnhI+WC4zVJAP3Jy6McCUovdYeESRwaXgkHd4V2JpDLvHdw1FQARkPOvtTJw9dQT2NNZ+uyzowqF4bKaAV3tQwupkblBnGFoIpBLa/tqW+6uOFRt7aUSpn4GH1/uFVdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyy5P9pysLox7xBkCeFxP2J7UVr1IwCskKwjBfRIjYc=;
 b=k15NVEUlTGhTWaiqVQx7LlIBAGMMessnhTDoLlBV3PUO0HtgoFfqJ4HRXAfYXYu4/14QuHCTg0/Kc2fNPF2D3EBeQpSJbCVO6h0kXDakX/D9e1CS1GqACfNxjzwILdY0tNtgCOXEIGwtMQFJfgSAz0UgaiFjpmsdIYUK8qu+Zro09FmAxUvWnsd9m8jKtMz3Yaa+DAPM+eIGStox5cxd3a2CKTTrVaJei34bYVne3MOvn/HHopVJXXSWRJ/OV3qpm5yLNLH9HzdWuJi6gaakcjxSdhqolnP36I/btB0s9h22NHaJx3Yc28AN8kjY3SOR/XUNmWUjw+ZL2QIU4ktRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyy5P9pysLox7xBkCeFxP2J7UVr1IwCskKwjBfRIjYc=;
 b=UewX8y123mKgdZmjVMvt86DfjXTVfHVid2r3D9QMn3tzuatwCftJamXC0CdVZpTuJeeSidPF4FW00IUZDIqUT+Non+yeEAw49+MVsVU6Fq2RNTjf2uZ73/Y68s0Pn0e+1dTUbhOYWFO8NNvKXHjTG1t1ncMp0yf0XD8zryP636NN8IXhOR5lfLsQzh/WzwJXdWcsKUm/7B83JMY0ZVuKh/Qffctroc5KL95Tyk04vD8e6wEKzpuT8j8W/2JPwWzMV+61PKtGMukztwzzeiQIb443vW8xZ1TgZm+WpzlZs7n37x93DSmh6I1tgeiW+zEYo+nWjbxkBay0ZOkkYK6xzw==
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 15:46:39 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::ad) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Mon, 11 Jul 2022 15:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 15:46:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Jul
 2022 15:46:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 08:46:37 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 11 Jul 2022 08:46:34 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 2/3] dmaengine: tegra: Add terminate() for Tegra234
Date:   Mon, 11 Jul 2022 21:15:35 +0530
Message-ID: <20220711154536.41736-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711154536.41736-1-akhilrajeev@nvidia.com>
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae72d1c-ed26-483f-d318-08da63548b3c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3578:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRrJWDstz2LNKMESFE2wrJjvT0KpR0kyDCKvvsxhcEcKFHyBOPplS0P9Rib+S1xAi2fOi8t0XxFPV/Vc0jIeTZ/oJIlNnaMr+EJ/l/EQfWoLY+iw+6Gcw+DhbRA5eBDMHj875BC6eG7lMCdvbglv4N2xzECwE65QipiboPyhXBshFll7WoguZtxLUD5V2d559cRkkGOWTnI2tejKsNvSJ0WDAiZCGzuhWQeqiGsNJTstUxtY30UaSvctwwmqSYdetTqBOuA1/MMzDhUpDEAJ4B34/QWFa3HxjcUVNWREoRfeboBgYEZ6aq0ADm/TR5mqedK8Smrz2LjPN5ou77WEm/8SEC2IrnydVWG+itmfXEj3NsBUVSQ8GVYua/fWipRwubKkK10cuH5YV14WfBKCpWKRJWEIT9i5/5pyRtuYxoz4bB9lP/evSyGOYJxh9XfVBfglVhL0p2rgXbDSzhdysiTDGZSvCKca1aChfvRGOvTgDR4SJI4QAHALt//7gQ3wh0upjuVBakaqUBEmV+4f1x2CcgM/GEGSeVLlpKRdfya/qpuV+FpYnxYu2HpmnW/+N/9kaXHKL+jPSjj3IcGKQJLC+YdkQbVY06dpenMdwDp27u6HxMWShrzZ/60FzbQ08Ne6eUfDCobxSpiqRXzHWCgYBdjIkYFCzQd9ORfIP4bbgblu6Yv5/Ila4Pn1I21z6y5Qi2BMp3yQE+CjHXhENwVsYJlDI7VtU/aqR1mW7aJ53/UWp4AHe2klis8I2DIMLTcFQ6zkJFiBoTbORcPJpHNimJ9fp2bpa4dj7QRR5AAI2wJ5LrVKizHSDOyjsouTYMNc0AHVIfj30eVlEtdx0QmhwI3Nt6Gcik4eUgSF+s7vUDe8IgfJj/sD/JYXJbxHsmEHXupa+DqcXp+r4zHj1yWXtwi7ZqkQBEVsOMH59cg=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(81166007)(7696005)(82740400003)(921005)(86362001)(36860700001)(82310400005)(356005)(5660300002)(8936002)(36756003)(316002)(2906002)(478600001)(110136005)(4326008)(186003)(47076005)(70586007)(8676002)(336012)(70206006)(2616005)(1076003)(26005)(426003)(41300700001)(107886003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 15:46:38.9674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae72d1c-ed26-483f-d318-08da63548b3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

