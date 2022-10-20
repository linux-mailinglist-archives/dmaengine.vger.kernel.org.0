Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB96059EB
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJTIeV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiJTIeS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:34:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98418C422;
        Thu, 20 Oct 2022 01:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em9cXqkNRltyFa+Zm+GwLhWppwpt0J9odiUovm5DlZzCK2JCyeNa1laZlUSFicUZLSSXH0HOMZHQMqhUtiKjK8mc60adjlH631trQDzGQup5TrBHLPK9JCeXGlqEYkoT4vl5bF2bQkQVP6DmWawFwCc1VaSE4ecd46l83P9yveoCUdHnz1LsXIGNr634qrVKzbylop6QSOm7vEQNJLlccmOeOZRhwaCa3jPfMJSvYTtMkvQWOjR/BskxNwqdXTi9/00lhd5QxQ1S6ETwis9Q8hXleG1SWRCNyCIc3lvOq2F4g3lDzIlCn7O/8e5VNZyuKfql6Zc5xtTpWRfsnMI98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQzIWFZ5aH2Zm8fCIT34AMMeWZtJUsHhyL2NPV5hoqc=;
 b=ehpL+I+XqvlZ4nlRaYeJJwEUDcsfVmrMs0UnX+eEAO2vpNCfG401zBcATrzK/ugSK7S1nvKk/SYDnUoeMez8Qo3+e4So6160eyxZ2LEaXS1DrVCwv0z/O7vlnDIVKz8S5kfS6gHTcd1UPzhUG3skEbtFURimaPAWWLwQBcbfKIHHs2PRjWXz8B4UYlqea+pHaOUutJtnpAXOO+OXJyJCKvaqOLf6yXKuJ38xveVTmzwn7jBBA5RrrrR9RpoetqzZki23tDxeFK9M/mCSz3TjwWTpt3vKTRpVUsWGVqtDiduI8LegiqRG1fjjdoZDWuErQ8Zled+7KW7YKUNuMVei+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQzIWFZ5aH2Zm8fCIT34AMMeWZtJUsHhyL2NPV5hoqc=;
 b=E2H3V3pQgn0h7j/QevfvlxirkMOt5YZ8mH+MS1xeMmcSBcMqdxHBYC2+rZi3n/qQv7gUFbTBi3pwMU2eh2WAWgqi3z0xZd/GxxAitTr+yTN5JPSW2G3NmMkRybMm8ey8Zki2+dO6KNYGssgrEv1AqvCJ+AtMGC1XoevcNn2CQJMpxMaX6lSKHgFnk/ZD64IqyInP1p++p3p0cF8TLCs4iuduEuntyFbau3cAJZ2vgaCdsCTAqLhMFU2WVhGu6W0xvCRtsbeqYU3oMrrRDNWYsCUNvWXLR1pPzkfWHLSjLr7eI7LVteStWlhT50OQbqzkiTbc1QUZvekp8z/sOH7Pbw==
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 08:34:07 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::1c) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 20 Oct 2022 08:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 08:34:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 20 Oct
 2022 01:33:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 01:33:57 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 20 Oct 2022 01:33:53 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Thu, 20 Oct 2022 14:03:21 +0530
Message-ID: <20221020083322.36431-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020083322.36431-1-akhilrajeev@nvidia.com>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: df049db7-560a-4926-7397-08dab275da4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCIxq7JTsCq58aNL7ZiYaBc6dEy4ncI2jHJjF0SJFt1TWGV8oWCavRy3QqUs0FlmK7iU+S1LVLCLOynDbtr8uwtGyCRcrohtzo7fh+2REzXN6x9gmJ7eKOJkpd5kWRu4cRqPRh7tD4g9P1WgvRFwBD1BOGFi8UbDwfIB9Vsw/kfsOrRUpX7Oni1FV8M96KleiTL5EOBzxtVa+umWkzbpb1o77WiGb/y/twybRJNcEnoBhoWdhx8QzAJ7TDyw1uF0K9takkPTjK9y9dOmUBgldSl0FFrGYU16lhlZXi57C31oBC7EUyq7IY6b1D0GarLF8QnPqFOzDfpNDqM215sI2eN7f1qx3fG1/4Qj9pt8fcdcLDTJO//odIvidrz2Lf2XM+xzHkBBb/73Ec4yvzVpTj03EX3G33Im6iUMxGaXr31CXtZgRy+T+iW8/d3gYb2FUDZ4OQF0Hp3QZ0khB9kFBHHyH9DnCwWA4A1H+jhnePi6Xdzynj5bPXJ8cq/w4jfwCMBLqeHablPxF6a4TvYj46uD079c+BsB1tQHXon8n0TMPI7XGLZO8pgFcwCxpkXYxilgtXwkoGBsJQWqrtMZRfOxZBy/IZP0wxqHHkkKJwmbE/WFdD4uFKPJk6U7KCDqQkRP6fKev6rBLo8nsnhowB4TioXltw6HMKL2kiJh/YAsl2zZdihqvhInCU6s1+VSQyrR2+TnqiijjPoiZvETyULXn3mD1Q6rxp/5WR3KP25yKA1fCvnbSJFYSM98c/7KZ3mYxUnquDZtqRX6JDDxXV5qCgQcGlJMtYF/tSxnjTk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(921005)(107886003)(6666004)(8936002)(4326008)(478600001)(70586007)(70206006)(8676002)(110136005)(36756003)(36860700001)(41300700001)(7696005)(426003)(40480700001)(40460700003)(186003)(1076003)(82310400005)(26005)(2616005)(86362001)(336012)(356005)(83380400001)(82740400003)(7636003)(47076005)(316002)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:34:06.8210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df049db7-560a-4926-7397-08dab275da4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA device tree node.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
Now since we can list all 32 channels, update the interrupts
property as well to list all 32 interrupts.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6602fe421ee8..db479064ff72 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -78,7 +78,8 @@
 		reg = <0x0 0x2600000 0x0 0x210000>;
 		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
 		reset-names = "gpcdma";
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -112,6 +113,7 @@
 		#dma-cells = <1>;
 		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
 		dma-coherent;
+		dma-channel-mask = <0xfffffffe>;
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 41f3a7e188d0..b009f8145016 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -142,7 +142,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -176,6 +177,7 @@
 			#dma-cells = <1>;
 			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
 			dma-coherent;
+			dma-channel-mask = <0xfffffffe>;
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..ccc1a4bd094d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -27,7 +27,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -60,6 +61,7 @@
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-channel-mask = <0xfffffffe>;
 			dma-coherent;
 		};
 
-- 
2.17.1

