Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E615BCAB6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiISL1L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiISL0s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 07:26:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B4122B27;
        Mon, 19 Sep 2022 04:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJynoAN5mt/B+xGJjnw4DeSsZmedg9CQ76pmlTPKCZ/I3ElhUO3sV+XMM8TA6KsDiSiMqtao7N2BnIlIEe/JrKmrTHDWfqRN5xNOXD2pO99N2uPw7ERiSlIYVpvBKe2SX0/cYMZrr9DIo6B1nj7TglxG5FxFGBQueHcsvGH3qIVH4TDFQKUpDFuhRjGXTJKu7MUeTLhRSJ/4bYijWZlwiHaUYKpRGQ/XwinpEBdXh5z2uogPP7sE94KGBoL81aUIS+1dWHb9D0vQFlWF5KjcOfLUnHVbMcy1DhhoML0axKtawj6l+2lAHxwjNuldIlHUeFZSqMMpBr0pNEnv1H+z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH4Tsa1NdkMZgp5GUZfnfhMhIlpbb6nKtUkkfetNmCw=;
 b=GJF6DnPayLeyUd889GKDpizy514EstjsAg2PwpodMyw8ew4AjNCdiFRxoV+w1nOv4mkECTQJuIABLf5ry5tOhlfg8dirVayGZ07syfhiSd2IrWzWIFN26PdKNXHtZ6nNsomxKZVv/7V99QjNps0XLJZ/2REQjq2vve9LbYzW4OBHApY2rS+I8USSZEREjISBFoztjeoRQSGDINrB60bsQ0/qOvVDnKARdfMRqrsfO1C+rRnStsFR3aYnT05fWexfPlGHO0mIMNIRGn7rjnzn/aSVd78Ypf8cAd4fOsupoEkmUZKcIN7zpeoIZsFwC89PqSpK24zuewp/KmbyekGPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH4Tsa1NdkMZgp5GUZfnfhMhIlpbb6nKtUkkfetNmCw=;
 b=Yl8bDXHjMEIYUCHYxL0hrSdTP7N5+MUQ1oV8UJ1ODN9amM9gMODqET3EGj6+n1CxZ8XqQnn50+NgwHw351KXimM+jJSwF00hlf6E1ap7ciIJA0qJIM2BT6zF5mi3WmKfnLKhBv3X0uiUFX478NCvCAcCYVnpLXjouayyNBTGr1dKVjDfVLXT2E1AqHsBswB7/z1JQhOQIqNUOGNJYm6EKtY1lO8SJU6pIMRxd4f3ACFnD6YbjTjubjHVA7nH2xi7gCoPdnqLJwQcoFCE4MLsQr41aQPHne6hWoVpvYelNMW2RK49DdXsUXMg0ugurhvs8diYQWn6sJuBYmfheX7dHQ==
Received: from DS7PR03CA0278.namprd03.prod.outlook.com (2603:10b6:5:3ad::13)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 11:26:38 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::4c) by DS7PR03CA0278.outlook.office365.com
 (2603:10b6:5:3ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 11:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 11:26:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 04:26:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:27 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 04:26:25 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Mon, 19 Sep 2022 16:55:58 +0530
Message-ID: <20220919112559.58195-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919112559.58195-1-akhilrajeev@nvidia.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a470f4-2595-45a3-0aad-08da9a31d148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOIxRykAqTlTE97gA+VDkRN3zMko6BiYJZ0SXOulknxv3G+Wxr5/H/8TIq8Fvp2B6kdXNqRHzV5/aLB9t9k5T2bKIuk+3vUZKe2ALLmYkhgOlTyiCLkWs3Zy8LrrhuwYPL3oKicviGvJjDyInnPE/L50m3Qvzyk5aW2qb59Ltn9U4WY7fBX7NYHrjy/OsC3nN739J6ujQlp6xdDCXtDwPg9xWuNwr+SKZSBJN7xz7+kLvjPj5l55UXh4MdzbsscFN4iQ+vMSy1pEqM+te2MtEQHE8ONVbyfrnrq/YFR6uu6Y+77BnbTINEFT1BvBNSpw97rvBa5DwjDWRDK8lbgf/dslNEhQR495HV5jTjMkfVDgwAUpx43g9jvxzSBgc/psupcUk4fWtOzQJfUqAQx3p4UnqOo/PhxjzkMPnMy7fS7l+BMqGS5JKLmYzpJ7H4AvSAa6N7LHIqh7wHzfvkE6f8386KkaTPl2EWAmgttSZjQ+XKt9iIikbw9qu5Dky8zm2DwudBb51x0QvYuGiM5WDNhiqbl7m89FVf1xxakUZ9rN8y73xTaF4KAPBNA4gHXwUp9BtDapGrCgOXP76l8wJuh7/J8NqSMMS20A8GkA9ygwGKs9V0wmQjc0Ckq9vAJKVuwzw8DBTWLhq0ZplxzPtRRKjMYg9FBRwlUOLQBAFckHFLsPbCupUuqtSkqLdZBgW/mEqNDUPzhI1gW2BJDWGFJS3oxcOjYp6VneF4bivLDH7GlHMFYlZFvjdaz3qf7uJIUthLmgn10N/9ODDufN1A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(7696005)(41300700001)(356005)(36860700001)(82310400005)(6666004)(107886003)(40480700001)(4326008)(8676002)(70586007)(70206006)(83380400001)(110136005)(316002)(336012)(40460700003)(426003)(1076003)(5660300002)(36756003)(47076005)(186003)(8936002)(86362001)(478600001)(26005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:26:38.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a470f4-2595-45a3-0aad-08da9a31d148
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 3580fbf99091..13a84e34e094 100644
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
index 9176c4b27133..593fbf22b34f 100644
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
index 5852e765ad90..afd90b72cdea 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -28,7 +28,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -61,6 +62,7 @@
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-channel-mask = <0xfffffffe>;
 			dma-coherent;
 		};
 
-- 
2.17.1

