Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DF57B4AC
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jul 2022 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiGTKl5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jul 2022 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiGTKl4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Jul 2022 06:41:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB166AE8;
        Wed, 20 Jul 2022 03:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYmGYinCytQEt5IhV/TW6LT3RMGxWbjb5X/xd9Sa1ILfOGYNZZkJJ2IuQo3ijBkjNG8f6DX1tv9Ci/mq8E3QqwYI35A5DWjXQqi114NPMpl1ul8CWRZWBBgtOXluB8KPsexw/em1TwfxwUdLo9Qs9LiU6tGfgfMfJTTpVwny4phjKu09GKum3dI+Q/9xKnizve5P9432AC3yHKOUzKq8hI9HwGxJCZjM3+860jhVHcgPd5vjKCV+gM6fmM5FiX0jzf/MgE9DKamD5uske1kpq5VHw50OXe/Dj0G+McgG4fLb6so+bftbw/4czijlTJGIwFQfB1cIMMlKGyqX3i+z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXSL1ZSaYFN7Q5QdKgipcuwlc2H5MAxacFJopm+dCcE=;
 b=CB+uEJ88DE06XkY/70l3GYPYIi2LHaocLBWiFA7CBy5MFhQSXS1PLLR1n5cNDANT2TcdamljyUUQyJ6P1nAqfrOLUuWkptiH/Y4VUbhAFr99mPqNiCXbeb0+k+RcbCFww29FFJ3XBCbRyyEQ8N3yORNeZOcQpomLDNfSoH07FSXp2SAcxt6f79s6I2tnd+s/V1FkeVgTV9rhEMt/6jgGKhmsntGZ+7UtiNcNpQMJD5HGUlS7v6T4Bo7dgnmhqyPatyb4WgoCELNawNwVrfR38T36aJJHSjjOcf0kTNd92nHSrPM7UTBrEaxvCnljQK9GheKgaUJcbNIN/o+WMMxypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXSL1ZSaYFN7Q5QdKgipcuwlc2H5MAxacFJopm+dCcE=;
 b=VD8nZeoiWWIUzcplLZ8tE/gRiBeSrh5YRKPBCOORAhyKMWKSZVO56syCvmOtWI6YTQ2YQOCzhRmF6+XpZNn8WHmfLPzQhNQkqItYc5INxm+FTn8/jSZFbv7l+xpPI3qpYtsSrU7UVEGXIizFDjKvNfJ8Ow1e7rVd9GLihYSGp+Cywo56Rw634peuyxujcKgaiMtp3y6PROWpVXIasG56uPoRVcm2SCRCYblB+k3vc7J7a2R1aqnb/VBW5a6xKw4LdDjjUcIhk0pY2TrUhX5asK1Sg02cCembqFwHdc4bWWTGY+6wmFMKMw1YqckXhKqvYn4WoUWSNvBLg41BVkjErA==
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 10:41:54 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::95) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Wed, 20 Jul 2022 10:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 10:41:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Jul
 2022 10:41:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 20 Jul
 2022 03:41:53 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 20 Jul 2022 03:41:50 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 3/3] arm64: tegra: Update compatible for Tegra234 GPCDMA
Date:   Wed, 20 Jul 2022 16:10:45 +0530
Message-ID: <20220720104045.16099-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720104045.16099-1-akhilrajeev@nvidia.com>
References: <20220720104045.16099-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0848c618-b44e-43bf-f159-08da6a3c7660
X-MS-TrafficTypeDiagnostic: BL0PR12MB4994:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hvqf3Qv2SDjZ3V5AP854VGexZQ8Jd/n9GPH2DaRSNlT4VbU1OStqSQ477j77owb0PQFRxVuNsKBllX050aAedshJyjm+zlb4Jl9Sa6Nr1Is8NyJuAwPx6M73CNVZSDjFoV0vl1RBYFB8i84+rZEDd6qCnwFhq/r43SzcAbT4ZfndAwO1/NV2qe0aLBOh6+w7vsO0gjNtx5wz0G0Mep5Y0lF56bcmy1xq935CDHOs+zgyqmkoGDfvCQYIkKV9KjVTWkXcgY9aw87eWc5owyv/Qd9j7SrvSLMeRs67YOH+pBlFQfmukRImUwViny1jNaJSQb1tdkc3K8D0fUERgtZqBNDGtY1lLSTIKwbjX4b88M+VNXzfdnYNRm4j0AN4ZqnulPf3Ozv5BKSFcnM5Map4lc/mwQZw6tqzQihMbwLaqT3ajdvXMMGJE666GJTgxYvLCDAFFmEGxWWqCYgXSjRQEOLk00Vh3Sp1RfcqQUNTPPbsICn6KcUWP9QTAtxNwESkJZG12HECBTxUp1oKYPEyE/9zdZ3dEJIcxFRiCnBf/Do7/0hUK1zKheOLY7HMvUAOEXcUEVufyW65/XCvg6HrpKiv7aGE6EBJwiv5inA/c4oC2gzVsfD3oShKr3HSoGoAu3HlqPaKEZeNZIMAWCQR1gJLPnDIiDQJ0SNQZ0b6hYvipO31HPEUiaRWWcxkdS6Qc/YRHi2oUf8YkziXRv1A3q3jzFpiCEz0dMZMZQ8K/K8Y65oFLJN3zMENT8uB9tgx9RvF8K68zb1+hX1HLx3un5i5RyDkgTOD883KVkX5BNT5K2og5aKSBrAu8bVMbc7MEnyGCl9QY26gXwLN0qu9Foi8vxgrg7n3mfZOQaX7S2QtZv7c/nGLopzgK+LqaV1govQoUMZCq/MpxGobmGEHOA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(70586007)(70206006)(4744005)(86362001)(2906002)(110136005)(40480700001)(8676002)(36756003)(4326008)(316002)(107886003)(26005)(82740400003)(41300700001)(426003)(82310400005)(7696005)(356005)(6666004)(478600001)(2616005)(1076003)(186003)(921005)(83380400001)(81166007)(40460700003)(47076005)(36860700001)(336012)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 10:41:54.1430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848c618-b44e-43bf-f159-08da6a3c7660
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the compatible specific to Tegra234 for GPCDMA to support
additional features.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..c3d2e48994d1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -22,8 +22,8 @@
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
 		gpcdma: dma-controller@2600000 {
-			compatible = "nvidia,tegra194-gpcdma",
-				      "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra234-gpcdma",
+				     "nvidia,tegra186-gpcdma";
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-- 
2.17.1

