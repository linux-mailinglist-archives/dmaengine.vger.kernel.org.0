Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A166145B7
	for <lists+dmaengine@lfdr.de>; Tue,  1 Nov 2022 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKAI2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Nov 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKAI2G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Nov 2022 04:28:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC6186D4;
        Tue,  1 Nov 2022 01:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/gz9N6PoDX6slboLJRJlSs0ByozwRKQ1bUDLzttWxIObbhb3DzjYDoUGCNfrGz+GWAQoDgGf32nuec/eT60Dg3pEyhvJ7WuFNpiS7D0R60mBazm3oQSi8RUZXLGn3hbB3oNrq5MH1FIcewqGw9OL7zIeQ1a27cJtZYIG5vp1OSD7gYtSLBpva2H8s+7SOd+WPM5wSEgmmNo0Ej569T/VvMwcW4Fs3RNRsuvB3984XfT3UxtsR+DPFaSMRU1JqkAiS5QCOtExoA/YfPfCRlK3fUr+vM83WpIoDH8LS2sCvJp9lTUVgjxFHOqrFZPSBi1OUKSfSEoVHLOABELqDnAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+uHzrTUVcMR6/CrDAF+yR4q5TShfV+C6mvczLfbUVw=;
 b=Tjl0o216+z5kUh35zAyOvwE6ScNy7tJfs0WtKBfRCphrQGSZrvVP6hrEvZbIjnwZ0H/zOIvsDIz7vAzrgA3NN/izZW5XC+5SCDEDiKZ1OVynmJ5hKW7AbdImZ+cfMti/6SfP0CuvNn5Gy/xM6LVKGJgGnNy/dg2QKKAgCe+l6OxDOWIU9rnTrWLzhlCvVXzA4yTv1S+KP0CMV8e0gTeeR9z9n9djuIejwruH7MBtLXy+To3qeZ8Rzx/Cf2xY1NYD6k79gbGYTK6bgIogs578bFkc50L5GdDAsCwnFpHl+uAqFgHc0Z690Z5S3eOUYgtP7pvv00OyryHfjL3ppPVwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+uHzrTUVcMR6/CrDAF+yR4q5TShfV+C6mvczLfbUVw=;
 b=A+2q764zH8MzWQqJ3ifTUSgheBEV4lUs4YoRkS7S/O2qJV8GINk3P6CBKWd34L6kq11qsBLu3F3EKyewJgqI7Sr22REnu0EcjCCbfOlxiqIGGoDe2jX4hwM65T87aWnYMtFcQhTUtg960sxzPOa1i2X43AzK3D0T0ttiwD15a1zfL1uMR/mfTuTxNIqtGgrY06oVawj3AKPh0A0Msu0LUKLGHCXCLLzJDVfo+HMC4njKadn7a7+QBbxhvxicyYMi169C17/kEjh2JqTUFuhaaRf2ayedLhsJHzaQu1lV4lNa++GMF9k0LWZtxfSgI9pVtQfAixerzWBr/A28OIHC6g==
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 08:28:03 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::25) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Tue, 1 Nov 2022 08:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:28:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 01:27:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 01:27:50 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 01:27:46 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Tue, 1 Nov 2022 13:57:11 +0530
Message-ID: <20221101082712.59263-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101082712.59263-1-akhilrajeev@nvidia.com>
References: <20221101082712.59263-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b84d62a-61a8-457d-c9e0-08dabbe2fec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOJSbOhvrv/Oi19Jd3bmYj+or6j6BI6g0/6cDGxu908sYHwsv1kWkz4ccp7F+vHzVd3TQjfx+d5c3MpSdgXgsTxVrh7fVrdcwc07LwegCFGQFenPQZpAiwYB/gsVS4+t+qxi0uYJN2Ge/4kljhPXYxeQTEjGhhwTog6h2vYic/hb2jaRekxEuDHLYrTnfy4JtaK28b/eQPXQdwR9nYIn42JXQE6U9KfhQ2g5uCpaz1fd9iRz+TW5DyTvQsMhVEwxG1SGKEBQOw05pyO81lsMfnWHLK42E77my2hjJ4aXSIhv9ejrIQ04kT6CTnGmdse30kwuxIJSPRZ8K6+TYofVK+MNRenjH94HY3UWSeF/SbBGICetzPMbiBRDvGqbwgZHBMOPdgUMqd7vddlfR+Q+LYt1OwIJFtDJFW+6eOfqRXnXaqkaYNMgdE5cR5/MO8KubrBAlBTBXapDwDHpdbxdfK3vhh0jLe/10d4pBQ6eBA5nqEMcy13uiF/Owi/Is3+uHZLS0JkP9RxETOkiBxwuPEowXkAbyU1yVRWegi7r0X+S7IdAnohj1dBOdGaUSNLnHgr5ZGEx+Kv3+EwqLWDAjuMPl8/5YzkUe1xkt+hDYkady871n8HXcxHWV9YG8Xn2GubbhsCu92xczZduip8rD9fWOo6c8QWDAB0iPMLcJlyJjIaw+1zQWS2xTE26unoNogFNs2+m7ANMjbVFW6IN56CZxC+AmkOTXRTuzJOQl6JGJwvXYe4HmKjPLJVJqaTyK5W7yFCb1XR4F1QEdXjV2zoO92qVmAOLjjpCzRxkGZU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(8936002)(86362001)(5660300002)(36860700001)(478600001)(47076005)(356005)(83380400001)(921005)(2616005)(426003)(7636003)(82310400005)(110136005)(186003)(36756003)(2906002)(7416002)(336012)(6666004)(1076003)(107886003)(70206006)(8676002)(4326008)(70586007)(40480700001)(41300700001)(26005)(7696005)(316002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:28:03.5900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b84d62a-61a8-457d-c9e0-08dabbe2fec1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA device tree node.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6602fe421ee8..60a2277d7f6c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -112,6 +112,7 @@
 		#dma-cells = <1>;
 		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
 		dma-coherent;
+		dma-channel-mask = <0xfffffffe>;
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 28740c014f1d..88f60442ab3a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -176,6 +176,7 @@
 			#dma-cells = <1>;
 			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
 			dma-coherent;
+			dma-channel-mask = <0xfffffffe>;
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 5d7df32fd159..315539b01149 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -61,6 +61,7 @@
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-channel-mask = <0xfffffffe>;
 			dma-coherent;
 		};
 
-- 
2.17.1

