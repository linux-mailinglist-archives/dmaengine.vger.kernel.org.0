Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237386145AD
	for <lists+dmaengine@lfdr.de>; Tue,  1 Nov 2022 09:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKAI2L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Nov 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKAI2D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Nov 2022 04:28:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3E183B5;
        Tue,  1 Nov 2022 01:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eooEgrP0NIX1rZRDrbevVcArWXwCgQH45uCpF0mb9nd92sTpt9ZCC0ttHuMsn8B6VVL1rwoN7vdSL0XABal8vJEqT2zfmEtrqFbQNJeMCgBmMTt35S5PoXPC23diGm1PCB3F6wmpNA0kE99YniTgLYWbbFpTArl/B/RNAhkEMywOF+bmaKoXd7aPI7HDzSOCIyllihx/AVFzv2Fu1Tvq9ENXGfhrQbxfJ0WK3YVTGlWQ34Csi4jt+kS0oGAF02AirqReCGyRDbujxXkWrlWf8F3gBf/QFk5b1tpyFuuhwt3vqhYBCnYbgcprhB0HbYJIKKwXHJVpSyUBz/E7saU42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzcGmS2v7IjMCUUxOENEB0pOs8CWkaDE0N/4iYS6ClE=;
 b=h6HBF4GzTS6P/9t/NCTBx0Y2IwjKPwFkJX70fELt3Jt+mMqaRdobaLpba2a2HSYmIEuu+C4LDBNou1W2x/bb28I4gNRvBu6BZgkfSOOuqvLNmJlLXSHiaPeDYsqzVz/3XptbmuzZB8jYCxv5cuIunHX76qlTfITwPBtF1kwnYA3fXhtRxw5gVo9Iy7B9q+Q1rP/mupcNnGxEOfIfjTqoj1ZA3cgjqeK0/6KX4OafoonwYogXGnR9Jeqyzjt1vwIkMnmy8oRI23J0y4VRKjtlBxkZJ/vZzYGRW5dmiplPzx5aLX/Cw9iB/vzjUtMO/ZBTgA9lOaI0sCZ1lNH7iIPmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzcGmS2v7IjMCUUxOENEB0pOs8CWkaDE0N/4iYS6ClE=;
 b=ntkEbjW+3SLiKbCxjcVlsXXu7jjALvPk83Nkm21BTkrl2mXGjw7qoqQeS73+/s9acsNAKmNaAEN9TT/TA41AQqkRSfZB6hEAWqm7BVhSP9zl+wvL4BlBarhmassE+LQ0gQnJxS4OLtud110uDMoO7tLAGQUCiwTsatURy0GixnF+DMCfT2nfoRx03lflXlF/ghHgMZn2t1zbbOI7ia+XonOq3a/cQoK1c/7L4kf4rmImSi178snYxn12/Q/HhVZLhWjYvsBIf433MecJApWQuyjfeugvdWu/6JV0aVPhA2GL9EMEuHJtsx20FYnPazXOIa4MkysUQugAvjMuraKALw==
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 08:27:57 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::7d) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 08:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:27:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 01:27:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 01:27:39 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 01:27:35 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v3 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Tue, 1 Nov 2022 13:57:10 +0530
Message-ID: <20221101082712.59263-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101082712.59263-1-akhilrajeev@nvidia.com>
References: <20221101082712.59263-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 288f09f3-1dc6-480a-4ea1-08dabbe2fb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dv92kX3m/SfVCPlBr76Vof4JpS09AUCOf2weVwwLKcAlOCkK8Duv33GVhQx0uwcgE2RTNSC5AYIakb5c8n2hx8z/YydVr0LZANvZVZ+ulae6lfCHT7n61qWEq1PhXCGFmV493Lrf5WsgLiPPrLmN6ntemdnwuRI+/9LyswYN3k8Js6td/aQXnBiE1TvyosIV1VvIRy2sL4IDSYu59HL7KFM462qK4Rjeq49V9qaDnftPPSVAfmePoeajKwr92JJxejGHXA+L5NNBLVcAGo0V3nUN4N223ZkAWfrChDWmsq2aJZc1ofMrDFJ0b3sV7ZBEqtqgEl58AJ3AOBzgHHxQfXaKqo0jBOYlVTJlkby0Lze7FUNsylAlwdIHqfaZ241aE327iAMWc8z3rkx8II7oCsLuTllOFRwHNf0B1gJdUGPvNbxjOL8gxv0Vt//34OMEWDJCGpYfi5cGt/LYrJ8Z5wba7Au/rRZt2y05XyM8y5uUnosuiA//PPOJyC93ldc/+QmP/h/nBlXq0qKqjGdvQpUGGudI633JJCjqLQIRmr4uXY1PsETr1xcLtLrOQFAtTTVoovu5uPnY5T5ZX4a2YZGQkoNgbuCitw1tOWSqqz/47d/dzb2MmBHsSHlykwWBh05D/mOum5gDUyTsYbvE0Yes1bsHk8I9y3ymhseSVp7cXAYed4KWHFArsVkwx/lJmw/+9jXCLNK+zFDC2RsfL2YBPWvF/Ff1DaGAAn6O89LklaFk9V4Ac7X7YA1PM5JoZPNDcRE6J6f/G0ChNyLsusWdY+HCDxMOQ7mLSvYbbIQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(7696005)(107886003)(6666004)(316002)(40480700001)(4326008)(70206006)(110136005)(70586007)(8676002)(921005)(40460700003)(36860700001)(82740400003)(7416002)(8936002)(41300700001)(5660300002)(26005)(36756003)(1076003)(336012)(186003)(2906002)(83380400001)(356005)(7636003)(82310400005)(2616005)(86362001)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:27:57.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288f09f3-1dc6-480a-4ea1-08dabbe2fb1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA document.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
Now since we can list all 32 channels, update the maxItems in
interrupts to 32.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

