Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3D624819
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiKJRSk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 12:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKJRSg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 12:18:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D16260F;
        Thu, 10 Nov 2022 09:18:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXyKaW+cjYCrjwV7fTHuOB8rNM7hAdw25m4md4adPnEooX1h+yEs4qgPN5Rjty6s0+vx4uXpg42NN9/jwGeKhbQSz0f3VKX4O3OqR8AfXklIc92Xiec8JK6RKMqsdYIHX74rv1TqJw39YYfVbAsoK7P+XJhXKPimsC+WV4LFMmrVGBjKaO5QcpHOvLXpT+UH9+Ao8HAC411y3wTh3WgMh1B/YH7F8ALNZlV0WrlaqMgc5ntr/ihQPutTnAdlYajM7CJH7kHqHTpVFJrFNLupQd4Bj9wOUmRiXES3TcTCOruu1+fABa4cR6hMXCiBRR91xAB8oPhpdfmSBTCONvJD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcNsg0PyKRSv1Zk79CE+WFsFraZQObCbC/s1d368nck=;
 b=QYn+Bt5e4MxI1cEd8f9a7o6NseGGzcCqtM9J0oYP3kwN4rybMNnw0n3rVLc4YYp/fkMw0wYfuzfvby9bFpXSLfA1/aKolPcz70PmfbezHS2vjV7KipuyYU9gKosOosvAAsZc9u+ftRaVp1+VqoGYWf5d856lJuTmszk4TKg8SHBWolykZ7IEMJ5cjcyYGSZtV32JcLut3ZpYa7ISWFZrTZbbI3CUdSMWK7L+rUtV/SgnRMZAqA/EMJbcDtKQDp5Y3il1o52g/MbPMruOUY/0ePBvozv+UDSif4xW3JluOVzbkAK1xOQrnBGtVKLbFgx903MGAW0RIL1TcT+mNX5F+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcNsg0PyKRSv1Zk79CE+WFsFraZQObCbC/s1d368nck=;
 b=jhsDWBcDkkhNIKz8w2w0+xq48pgQ4BeDqEVv0W5cGDeFe75PVFb5LPbFQPLRJkryI21LQQ7zMLZNji2tRngnEo9fc10cKYiymQVtq6TC0g7KpB9iPPb5GHzXNeUzb3diFfrP7DhHXHK7u6w4g7XOdzZOVz2vg6ozVVDW4ogHpmuCKCeJBdRWFKPOI1lqaInfRb6S/YYGiFaC6NPsr+3pBk15tnIpyhERYpwFvY+/QUoIH0efElTPWfc+QN28JwsQ1CXPuL4d9wF1F52fFcFY5xAXbeHz4Z87XLtxrKVcqpnp+UsmT91rCnuMu4mflrjP9TZBexbcz9Q0RA+z/AOvbA==
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.29; Thu, 10 Nov
 2022 17:18:27 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::19) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:18:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 10 Nov
 2022 09:18:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 10 Nov 2022 09:18:15 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 10 Nov 2022 09:18:11 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Thu, 10 Nov 2022 22:47:46 +0530
Message-ID: <20221110171748.40304-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110171748.40304-1-akhilrajeev@nvidia.com>
References: <20221110171748.40304-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: f93ce0d5-ae6b-45a6-028b-08dac33f9499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Nsfnm2BJ93V3KqARB+/FbeYI6YCTntmEu8fn/oMRWvosSvePBUzl8S/axbB6uT5UDlDa4cvJMzjztgVVbumNDxPWI3zaUw7kSn5BWOYy8I7FmqnGzcyZkAzKCghjmlnEFJc6iSy52kIRiOFXVqNWoGlqBKPJ6TFOEV/9MIdh60eDxldN4fJcebWSz8urHNBwwi15Efq5Cb0k2ECQIxMBOgG+IHJYq5fMGCPH/UvLNs3ZNXo5M9pveYzT5F7huLc3W5FDH5bdOvOh2a10eVWWO7cXMwU/8CqybQAeRPb4ktDzPpqIbw1K1fOTps/7vjbqkipcxlSYRzoykwD4rQpQiFenSlTB0AiyUg6NPJ9ADLa/zTKoxGOuKsRiVtg7i63i2ndxyGOARONZHma7jK6C/fnsPgbqInhpGV7kTK0iPuNIbx6ERJ1NApo0wZMSOX4NJ0QohkArdNLUl1uioQRQt3P3RMz0Kdfg08EF1OCgosyM8PlNm6/r2CVa4CrWKNEaopGuFb6kb0a5biToKI3dolrUfuQynezwBJT9dUoHkzRuk8fkMPFGoaaDRGkdiwmzYHXy0iDHP3115jGVUS581wO2+HvCZRL3WAb+U+8tDN/YYgw19F66fH38n0kUEwnyvx3B54xFnBsvh87FJ11mjb+rjrsndMqxR7wT3iHUdJSMrOljcLN/5llna442ty58EELv0Wz+xsfHgHbxgDbxGHyasbRuFgWIp1Z/ympmDotRtwR0WEMcy0U25jWDrSsCHVkV7BVNjwF+jXOHiiTbkhq4uqv0OQwP5sRUouUZL0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(7416002)(2906002)(110136005)(316002)(82310400005)(82740400003)(41300700001)(8936002)(47076005)(36860700001)(70586007)(70206006)(40480700001)(1076003)(8676002)(6666004)(107886003)(186003)(921005)(36756003)(7696005)(7636003)(86362001)(4326008)(336012)(40460700003)(426003)(83380400001)(478600001)(2616005)(356005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:18:26.8351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93ce0d5-ae6b-45a6-028b-08dac33f9499
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA document.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
This is wrong and does not align with the hardware. Correct
this and set the max interrupts to 32.

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

