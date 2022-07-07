Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D163569FDC
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiGGK2O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiGGK2N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 06:28:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A92A260;
        Thu,  7 Jul 2022 03:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5TTzbrK7iwvsZgHql1L3gfO0UrEDaL5hMbjNE0N14oj0KEBkJ6q/6Eq8m/ycQrRRMkxX5csJeF0EJiyepGAvtdrRqmDjXRJBvrDYNcQ8W6yTkS7JX4G5fPi0Zw5QR2LUwNGkw+fM9+zH/rzw8zoLrOy5krXxBooE9Lw28AGDkKM3bGave4xiNx+VgUX9Q2Yo9MPekOVpJaIdvV+8bPbm8R6uyh2W32FhLauMF99hvP0su+b+dzF9CPZsEzelFIvnHsuNFmsNTqqFF1KPjErh1yyOCM2Mw8/aQFlNHKEtHoaf4hOhT0q8b1vM9bdnaG7SrwVAfLfniBCWV3YKiVvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfNHvuhbCEj7TOhysphP/5u2RXxBOdzeO8TJKQ4xUQA=;
 b=UFy1Pm+rp7Y2P/AOTaZj8Bp1Y/JXTYfElOr5NfknIdngVWRd8H1e3hR+NkEDCnvuNPQN4J8pg+uSCa7mJUcYmbOyaGSlA5oDYzfsUMah+naVQniho71viG0Ssx4hp7NC8GKpYi/ZbJBFqjy3JPy1P6ms++MJdvxyaZRUboOtXXa4QmtjlEiQNpk1gtAy5UZfjkpCEF2/Ac0ctFtyE4lzvNRou09Gb8Pz70/rOqId6jW53CLRhX0tIar3rOtO0rS4VDZj5Fca2stPcodUUsx6runAiE26HTm5YoSt3/VajCGuqCvX0G1gY//9hEdp8D63Fwvk6lS2q1pOOyehFi7khw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfNHvuhbCEj7TOhysphP/5u2RXxBOdzeO8TJKQ4xUQA=;
 b=Zfe7adR/DWwu3/YUp61tKXVj8Xh4GMj5j3IsPifTm8gf/AF4kmZsS74e4QeCMHYkfjowW3NLABQFa2ZznF8F6Ox8UiFRQ2xU4gInGeycyRhlrvbLE9ilONs0Nowf3lbfEVwOL6xrNHqpWrYk+65uRb7qtbmRDe9w4Gw5P2CuKosdh2LiPSSWiKK5p3lPl6rPlKlyUV8AGyo2hG3iKSXQkjSGH9Uw9CbVlSqz/hhv9A/RbrZuCjwRlKbvtR8YhUuxDHI/uu55IjNkWX7vvAKAwgEs/wWUJnYDBSsvZ8gGKmaTB84C9DY1fx0VhmJfAeFTRFVcSPAWxc1Vcaa/ZGzTUQ==
Received: from MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31)
 by DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 10:28:11 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7b) by MW4P223CA0026.outlook.office365.com
 (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 7 Jul 2022 10:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 10:28:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 10:28:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 03:28:09 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 03:28:06 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 1/2] dmaengine: tegra: Add terminate() for Tegra234
Date:   Thu, 7 Jul 2022 15:57:24 +0530
Message-ID: <20220707102725.41383-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707102725.41383-1-akhilrajeev@nvidia.com>
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90b4186e-f933-4c10-097f-08da60036467
X-MS-TrafficTypeDiagnostic: DM6PR12MB3580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1chxxZJcgvJeiY7tMyupe3A3j/qrBs/RG5x1L0wlvAZXDdxUWk8iiufqMl5epYRpBfofKrwY0l2zyX9DT8vw0arahMNtPJ5pO/sFetLpN5ib+RoOIgCtcormWDqnxsxz53DVV7zXyQnndMQ18u1uXimMkUyMZY/EKFrzlpp0Jxkjd/6xNectOFTHtoNbedvB2jSf6VBRd8xZUo/sfraz3sv7D/pR37q6tIw0nShxrlsS0PKLwJOpZvTbPfu9COnfeFLQzWNs4eKfIQt2T7dQYdlgE3OKOYoz0IOmF4NJifYMuY2b5q7DW4PF8cApqg5sUdM/NWfA7/fqzKArO1JQ3hDiQzaVAJf2S/6EssFO28GwcKr7qMwqBwDs/1pRsLL48jdTSp8y3Zld9BGxZcmxbJM2LJh25fHBNCCagt7rIIT0l4a0txDxtwonDMRi9W/UIWHaE858X5VgBVgg4P9oRYZm2c90At5pvC/cMAR0e4Hzb/eHl+akJjzD1qRJCir82cTkZ6//vfDONmVyFXgllUQqPAB03m0HlQaAv+N+emDPxLB8epGtLp3hitrpb1VM0bTHCvchaiQKIFDYE4Ajlc9cdtKZNWj6/VtOU8ijptoC1x2Op1uVqhABSmd/w6bFgeiGPwle+XrA5RHvPJwOWL45kaB8pI+7gpmZsZedc9eIb7GdiIsfxCiBi2GCey8koHOetPW5GkQap/c/hM3g/tVR0B0fz6y6BFn0nGOUNPzWupPVdyS/d9OlaO+vjLy5ROtJTUJeqYft3EoRwZCqWLTlrJk9v7xIbyKwNM4ZWWNi7sH1z7lBKFmlyxQmmr7aZgVNa/d4zhDwuemoh+SAfEFb4UsiK57eM7VkBser+3KZ6NhxAduUpijzYcfNJosSJUFmHiald1c/Yw28IA4zXP2QSm+loIfhGkupvhcaeE=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(40470700004)(36840700001)(70586007)(8676002)(6666004)(478600001)(81166007)(7696005)(107886003)(1076003)(5660300002)(2906002)(86362001)(4326008)(2616005)(70206006)(356005)(8936002)(82740400003)(921005)(40480700001)(47076005)(36860700001)(41300700001)(316002)(40460700003)(426003)(82310400005)(110136005)(83380400001)(186003)(26005)(36756003)(336012)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 10:28:11.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b4186e-f933-4c10-097f-08da60036467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
dma_pause() and disables the channel.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  5 +++--
 drivers/dma/tegra186-gpc-dma.c           | 26 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..83d1ad7d3c8c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -22,8 +22,9 @@
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
 		gpcdma: dma-controller@2600000 {
-			compatible = "nvidia,tegra194-gpcdma",
-				      "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra234-gpcdma",
+				     "nvidia,tegra194-gpcdma",
+				     "nvidia,tegra186-gpcdma";
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
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

