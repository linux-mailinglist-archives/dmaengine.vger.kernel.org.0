Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0156A66E
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiGGO7Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiGGO6b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 10:58:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DB13E04;
        Thu,  7 Jul 2022 07:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnFUKv2g6jbEPVg3uOVrB6dV7U1JQ3YM5ntpN4Z/t3XxJyqe/tprC2PL+Ds4YbHOWELx6SpZpTEP3qyWHhv11/Iuk/Nj0dB89PBeG2N2mr+9UY4eMbiYUD6iaX+mEjdJogVlSntwArWnEslcIR2yo1K/7VXo9WOUoVCkqRr8UpNeaCLOz2Yf/RMT9lqRMUiZ+LdZJpNKUfQCRvMJieVbR4Ca0iqLpmSPxo+ZIc7QJXnze/aAMmNd5lLJAiHP6XhVZFtElm1ivruucsAcW2BDYCW179nK7IRP5DgttkcSNT0zEGmJLZvQh7mWWLinhdg7uguqUu7HQ/oMAzM84oecsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyy5P9pysLox7xBkCeFxP2J7UVr1IwCskKwjBfRIjYc=;
 b=eft2lGhAGSH1ojmbQ6o2JzgDW0aHlk8StxD8cDrNZpR3tQWNA8j74JIlZdgQBizEPx4gph9gVtWqR3WH8nu5XmiU94R+P3jEiyPMPWaJGQz6rdjEmCcHViYb86FOUqGDNxyVtiNt4t2L2OjvEP8+Kq9pDamd8HQIR/Ua9AgDuSC1uA32eTdnGN8lnXD298WGuybyvVCYqFfhjiOrVDNAf/VWzdQK9WukarCXYAZ9RHnwR1OLByapjiv/qQcUG36gBbCNgsalS1zAfRo7qK9TI6Vg7VuEj+8iQaYcBd3gQtlAa6aI8K5NfX53YHviU1N/MtjvTrFy1a/gvBvqoddb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyy5P9pysLox7xBkCeFxP2J7UVr1IwCskKwjBfRIjYc=;
 b=JFG4u9+GqUCew9kku0L5LrbYipuc2KFN9XSBd7en1yfnJ2CZ+eLm9F+CIgDqS7hGY6EkyGmO5H024zqiHV/QZxoFtyyAdh1klKLHxG9tSDKeYXqATd9Mc8EEQYYpp/M6LErvHnrcKB/decr2zpbugLdc7cZPn+5/LKZekYHwScgoBUswAQLTGXgieQ0h8BJeiLgCZKL4WqEnBV66YztFbfvvdIkN84WfDoV4EB2HQoaxNTUNQapDTVMIXPsZGkRTLM0/Jj5WYzeTQJHEZn3M2SYOOCi4IDvG9P12a0hXe29vv5BslT6HJKXCCYbCtEO0CgpBfrtEp/OloAEZJVXOEQ==
Received: from MWHPR10CA0049.namprd10.prod.outlook.com (2603:10b6:300:2c::11)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 14:58:09 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::1e) by MWHPR10CA0049.outlook.office365.com
 (2603:10b6:300:2c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Thu, 7 Jul 2022 14:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:58:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 14:58:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 07:58:01 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 07:57:58 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/3] dmaengine: tegra: Add terminate() for Tegra234
Date:   Thu, 7 Jul 2022 20:27:28 +0530
Message-ID: <20220707145729.41876-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707145729.41876-1-akhilrajeev@nvidia.com>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 149d243b-5e5c-45da-a3ab-08da60291a46
X-MS-TrafficTypeDiagnostic: DS0PR12MB6534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11jPY1WMmsoh/A6XVnDQ6dqwhU1zaUWdWWGp6iEwmULCBH1kUgVkVbgpqVBfP4KwHXKZZYHx+62PWpP8HlmuyjP8nic2iiYNEKqnrKDQORQJT/OzddE14ZhqtkLy+rNBru8jYYVmeBmzMw6jc9axgIqaYFzFi5CpD+Ou/XbS1xcEyq1pfno1UXsdxjJBh2tevYUMn8qO+LhHLCALdJFfBOJT8q9yeFwastnrDpZq8nCbVFG7BnP5+rMeRl8dJpJbRjGWTOV3f9VPMtoUMHrLtztBLlPe1vDf2C4AKw4GvVHiGvi88WQWSf2MPOS8gPPI6mqZPXrQiyQqBLVJKKXulObTdM6Fs7T7RuAJaZ7SYgsK7fKyMObMw76OD8t2D60+hj+R9fNoCFbHLkDI+IJCAq8r48PMrRwYG9x29XgT4/VSHYYtLsBCsXl+gTykjM2+f60zuVLcP9G7LSZ4DaqXfYfztHR6pXYCwwHfZo69A0dFz26YZPh5BSZ/OB+KO5yf2GIDgpZgjaVhxfcOGj+ytHor8amsH0/OPXCGa9WxwOQ0FXg/5SFx3P0ciYTr3Ozma5BboL0nkNRYRlidMhjnZZRddBtJ5gY9f3JpZHIKdP7NJll8tNz+9sleDYxf5t7Pm/rEacn6yGC1BJHAqA72/DV5FwD5X8UryhC2bInmJ26oEQ4gDFsQzZQORuxhVmYHlBLXZ95BW6OXL6CtusRI79fub0bVyEYAUtrK2eBPxUBttYnRgxHKUW5WD1jyeFyg5JWNZNsiZ8UhK2xZUxnQXfHFpi4AwcTeK2Ely8WXZXNk9Fco0XlEreAV4UBds8DQ9zwfkW+KLE6sTcesyvGi6mMU6nlDZfp4Wq6nfI7ra6sYgKbtSbukM2Hw6IRH6T34Uefc6RGdDEv2+eH1H55BZOa5R7zF0+G2Aab2Z07maJA=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(82310400005)(186003)(426003)(110136005)(6666004)(41300700001)(7696005)(336012)(83380400001)(26005)(81166007)(316002)(36756003)(47076005)(107886003)(8676002)(921005)(2906002)(1076003)(8936002)(82740400003)(356005)(40480700001)(5660300002)(86362001)(70586007)(2616005)(36860700001)(478600001)(70206006)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:58:07.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149d243b-5e5c-45da-a3ab-08da60291a46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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

