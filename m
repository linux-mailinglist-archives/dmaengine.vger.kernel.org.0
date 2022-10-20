Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26046059F2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJTIeW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJTIeM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:34:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849918BE2C;
        Thu, 20 Oct 2022 01:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnMqsHRDU3w5GPMDD2xroh+fSK/hXtLN4Xhb9vWGBpSWQzS2jyKxNbHayM1ImMPvMPI4LSFA7c+x5kRYEUGWybjX7pOOLOVl5lM0Lo+Fjj4ty4OKohiJkxX6ubDd46zHUw60/TmyvW1vQZIYiuQGCoerUyXN39oqeojt6nM7igq0DgHdLSUtHGkaCCETu6VG2soDfgON9w2qgVEo2ZuwGgaFVs9NA3J8zlygG9oKwHOuW1tMsJFPE4lHUVmfolNtP+F+k8uNO038Pu5pYkcuiBhUiF5aHR0CFyoD669oH0u6UAVV63HBe2+aJbDmQS1rZK5JAH9CyRhwk9LKMO3G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chAtKV5D7aE+UDykF9wh79CnPg93VUJ/Yjcm53OMFFM=;
 b=WnvWyPTJKFTgyGE0zy/Hhz8m9CfaPZW4I9jTZvqjDLUynMp4dl2zl/8Vy6/Bla5UYCWmRBp1TDVFpfnYvWx+YVwL7j5Y7MAzKg3tQVV3fu6OFq0uCX2dcpy2i7Ih6fFBH59NfPTeoxNJYovnPfCyHvkeJZpBYHwqnsBmNg5l/Gm+UysXcus6rw8ObW1O+xVxCaSNjAO0BHYRDibUpFOBUE2MB23MKYCr1UcJUva+BtQC8WN4Xb8x7ApbaQzelvym/KlY0cRaYxVg75vhTUxmmZNNyzPhFgE5rbhuIsoQCprKgaEBMGbMc+6bVq6yYC76VmSVDSxb9OTjyRhoMQh/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chAtKV5D7aE+UDykF9wh79CnPg93VUJ/Yjcm53OMFFM=;
 b=Aaft7DI9/p2DiwRjXor+ulP92JlWDHVe61JzrizocSb8hm9rbQ77M4eKPek/xXaN+1eQiTtiplPb++bD+3UoR9iuIEFIv/GHYAuYmwMZemJhT7Y1e85lPDZllW84q+jAGWB4yRmjvhlsH/x+0227+smDnTnVKMA2G9WSjA6EBZUqXZdtQ1iTILVBz1UqBi420jdgZpkilMy056jO8twnMi5czYjfKsG01OereFn5G5vlHBox8KB/BRaaRvky6/zj8mGEd0TtJdQCWRgk+ZtRLPmbyBFCpbVQTC62FnnRZKA+bvsvJ6My6OyGvTZNWV0SfvrcphAiT9IWA8A3JxETqw==
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Thu, 20 Oct 2022 08:34:01 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::92) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 08:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 08:34:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 20 Oct
 2022 01:33:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 01:33:49 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 20 Oct 2022 01:33:45 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Thu, 20 Oct 2022 14:03:20 +0530
Message-ID: <20221020083322.36431-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020083322.36431-1-akhilrajeev@nvidia.com>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: a693e34f-cc4d-40c3-5816-08dab275d718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B74K/VoAkzLrYYbhqFChvXotw/zVnab3S2uiVAWkWXKdlC/ucBvlpswasXWQJPDSGlvHUCItwLNFebPlv4Okk1mYbOXRrE3Cf1AvuPr380lzBKU7MX9Kl4f6ak0//F5/wkPqWNrM7sGDz8A9TRC3C4RXDIFXkoU3yF0L2Rx7ErGQ9lCizL1WNxsLtIQGmjhtvMR9OLiKB+wI5JDefCMUeFwpAUuIDlatV3CcckLkZKF6T8ikJHMYLlzVdOSFxAS76esUsrBhyNpAxOfsZXJOQimmLM9po7tAumJxICm7IjzmqxJAta7gucBZEMHfpH0jHVDUILQlMAUq+ZxLZ5fTFJ1puH1MM1nq3M1hUdAiwzQTlcWqgXqvd8zDO9kqS4w3MIww7vyQTeh7WA9tvJXyVO7U7/0k3Ab7T6Otmqoef4FMHCKAok789xQWV3U5iep9uscLCrGOkSy6vdJLQ1IpeKs1vrgAMHIq2gdu4I8tarxlRhoR7suRkimnrNPsPmLngus8Nh2ckP9Tlc96RaoUf6jWe6wGVwd66ZXVbnZaF87OAoTWdH46E6SC7R60WC8kWrHwXXxIf1WBy4rtxZvXDfghG43if6zxkyI05yF+zcmRmZTpGJ9FJMMkagBGK+P0frLxScUHQjMXDEDTT8ytvZtzceJmYPkuaqGK7DQyJ9jQfJ1BY5ktAlGaGDifazhDducovZ1C/QGn6j6BBcWgUBZ9mRYBlUkovXaDQgTkAVKYCgWS2P/8WpyIOWarRfuqwbwAgOLbeGuBPxdFifcsVoMKGL/ntNme8zVJXB5f5h0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(110136005)(8676002)(336012)(70206006)(4326008)(107886003)(70586007)(6666004)(316002)(186003)(2616005)(1076003)(36756003)(86362001)(83380400001)(426003)(40480700001)(2906002)(47076005)(36860700001)(41300700001)(5660300002)(7696005)(26005)(40460700003)(7416002)(8936002)(356005)(478600001)(7636003)(82740400003)(921005)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:34:01.4086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a693e34f-cc4d-40c3-5816-08dab275d718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA document.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
Now since we can list all 32 channels, update the interrupts
property as well to list all 32 interrupts.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index c8894476b6ab..851bd50ee67f 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -39,7 +39,7 @@ properties:
       Should contain all of the per-channel DMA interrupts in
       ascending order with respect to the DMA channel index.
     minItems: 1
-    maxItems: 31
+    maxItems: 32
 
   resets:
     maxItems: 1
@@ -52,6 +52,9 @@ properties:
 
   dma-coherent: true
 
+  dma-channel-mask:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -60,6 +63,7 @@ required:
   - reset-names
   - "#dma-cells"
   - iommus
+  - dma-channel-mask
 
 additionalProperties: false
 
@@ -108,5 +112,6 @@ examples:
         #dma-cells = <1>;
         iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
         dma-coherent;
+        dma-channel-mask = <0xfffffffe>;
     };
 ...
-- 
2.17.1

