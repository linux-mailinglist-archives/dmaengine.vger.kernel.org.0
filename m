Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45F5B7728
	for <lists+dmaengine@lfdr.de>; Tue, 13 Sep 2022 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiIMRD7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Sep 2022 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiIMRDi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Sep 2022 13:03:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp20206.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D96717E;
        Tue, 13 Sep 2022 08:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRfRIG8dF5ktne2sxSZqdD5nCXn4cKQLxVvtwhAKhqsoQukzMl1dr/YJ1egISgnbAE5QIhGTeJEK5QxyEg26umg5b9yQLPjE2nTxh+t47lyCB6ONa/FaMoskGVQIKuHPWI31hVCNZBa8fqEOWAyH//etIW3sYZwmUtjE981bVabexXKDCxABYj9jPGWy5yj7xngWUxv4iaaY56AWQVsyeQv60HTM2OsF/oRZK/KYNeww+0pHGIANNHn2OaAJYjNDGaOz4Q2b9JXPhtrUc/xMj+nSzwGUQfqYHxgju5lJP4W6ttA3fRt6Va/XrQ1TedeZ1SRu6TrTESD8lmvi8I+GVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH4Tsa1NdkMZgp5GUZfnfhMhIlpbb6nKtUkkfetNmCw=;
 b=nfDMzIIQaTNuP5Ors/i2wHoRv6/5aBCMxwTAhMrZwa9xI0PWxVB5P2sEjEhhw8QkZxYdUqvHbdY6J7OHBpilJxvTdmHl+G3VcQ+rZLw+uRYZbZo/N/rabflgtcU3/oAQtjLzSIV1aW0ZjMDXdNcTLqXReYfi9iSKG89dsJqDm4OvNbMwAyzqw1TAZfa0Neh6HQDEiSwuDPONbBZMcYegjyCWqn1377cFALrea0QGNFGYdQCysnHfhw5LUih6uk92XnJYyUQKI0qnX98IQgsGZY5JYMcwJ8ub8rxu0OJHww2uLKgiWgw9VzVYdy5ckRq7M6oOxn+jX0sGVWKG4R1dIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH4Tsa1NdkMZgp5GUZfnfhMhIlpbb6nKtUkkfetNmCw=;
 b=Zd6hDAwS0ZA/grz25zer4EXCgA6goqZuLGZa6DL222ZFCADBUqmyOyEIVarpQdViV6LzfDT9cIWu00kq0I5z2BdvzuRmDn05AwGhLmnbSVyAXhkRhE3UYUeT1+ep8gM0qlXw1u7OllfD/tppRx7gFK6od270wir/VQxQx4NM7zlRhraE28bUXTShU6hTf7cMyL3hWF5v66NJnLJPDKzy9nwPdwK7YkqDSJcDnrOlSoS3BpPvlSIJrMnu1XJjBRVD2NHm1oCjyW2Qasea0tgLBhtE1euwlepoRcaKevr3G86aGB+ideH9qAhWnhY4PAhAQpbJATYUVeOaqcx/D6ekTQ==
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:53:24 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::d0) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Tue, 13 Sep 2022 15:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 15:53:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 15:53:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 08:53:23 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 08:53:20 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Tue, 13 Sep 2022 21:22:50 +0530
Message-ID: <20220913155251.59375-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913155251.59375-1-akhilrajeev@nvidia.com>
References: <20220913155251.59375-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abfa4d7-1508-4d5d-85c2-08da95a01767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0CbyniI3EoAKO9tYFrPVHuF6NHlLqJ82SI/MJqYllql9lDyRcayLBya3boa+X98zYSCrYThgHrKpANEHZroe8XYfpnUewKVl9iSPkwsbe3ElhvMj3QAFU1g98Sg4shz9c7GY/vipOm0plV+v0hDYvapJFwBADJY/9fgUxqfASsF0/bd67ESSN3DgBAeNYgtiLrNDT0H4K0EvIR7thi/CZwXXTadiiJUAKIDrxWLPlHSiZ5cvhtB8ycHREqL5DTprIkhqEtDwlqhUMZEYv2HYTd6XidnuR5gFqz7kr4PgmCQv2bKYhjTUUt6KcuxAq0/Ht6UbkLdn0hgCTufi64FokRxatUnT/gpJ6pbLJ/oBTbJPgr3OJxhAetbuDwHL+vi01PfY1+GDx2Ifxn82e31nO788LATOSmKMkO0yWzkzD0Im+l3vIwDlHU9r8EgxFsbqNLsync7WE9hVqsZJ43ollLFy+rK3Fd2B3drIsJXvOuqI6RDjOhUg/6JUnMxTsRE001cLVKantVdHEMzevIkIcc1xB/ymKK48hxvmtbch3q//xb+n7zoMTbQ0PynDs1A5PRENKXxrkGJQKiu3fjoqYmY5Qw1yvrrI8fjauvU7G/vVJ7un1WY7nP7H7JCOX/xttOVyxstSMYGzfaa4op1CY63lhqJAHN802QhxBsJKboaZUhpg6eKvYkU9OAB2eYPLl705ErG23IzSFNKaTTp2oGtF9rcscvaEb4gdmYOw2VSmYHvtFfK05vrvZm6wM5rkK7Y6AEWf9OLf4kAqzfV2YLMOubAqKPMm/laTtOYBlzAOuG6qnKABFcqzdjGxBIH
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(107886003)(426003)(5660300002)(86362001)(6666004)(8676002)(478600001)(81166007)(316002)(26005)(4326008)(356005)(40460700003)(110136005)(40480700001)(82740400003)(186003)(1076003)(70206006)(41300700001)(8936002)(83380400001)(47076005)(70586007)(36756003)(82310400005)(336012)(7696005)(2616005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:53:24.5219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abfa4d7-1508-4d5d-85c2-08da95a01767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

