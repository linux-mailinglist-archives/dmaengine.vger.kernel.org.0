Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFA6030C3
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRQ3I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJRQ3A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 12:29:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE6BC61A;
        Tue, 18 Oct 2022 09:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3tKIEJmjVU2DkUxnm9cMBQ9KFhccz1XY9n7KNIEDLsrJ1jiYEUMSABRBbMVpivmXjYihukpQoB+fZQDzBEYlGcJPS29yjRnMHQkxGfq6RLpdVh/CToBv1l6SBtVtnxn6FLlpV3EhOU8OtDp1CxmhRMxtbFaRVx4PjsL/iFhDIbWHCN6NCEBeQaFd3cE3kU4hyszuo7PfBCxRbwOXKYv/BezA0PJ+bMiz2kj4igT53LHU/k5iIJx7qEo9a8gWfC4vGVojDTYZLGb6t6lHZ0gGtynCaZ/c+hQCpsKrTqSSklZEgkhiwwwZRUSGl4igAspC+jCN3Aqokzfltd3NUGvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chAtKV5D7aE+UDykF9wh79CnPg93VUJ/Yjcm53OMFFM=;
 b=YzwNaanmMaCtMxYUn0ZK6nyHh4TBK4+q2oOyjFTpew4OO0a3se/7nFL3w32XV/Yt4ttmO80N0BVKn4PE+9JF48+q9VMBzFpUSLybj+1Ii5wppVtePA6GZM4R60lWLlGOj6yfU72tsmSp7IrVuFJPnv6JhedQCuz92Qi0OTAX8u8W5hGUXe9Bnj0krzgiuooIVyUttIVVZ9tyZXpbGsS3f1GE5cgS5FXAiq/4YZ+TgI6h1MrmLmspoJTFS8OdEbn7iknySlaf8Vtk58Zw3s5ZIJgsC1qr5zarAUoYSWfC2gHZ+6t+oSqnIP9WHP7XLLrqKllaWZbo2Q4TKOoJUGpNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chAtKV5D7aE+UDykF9wh79CnPg93VUJ/Yjcm53OMFFM=;
 b=Jj/3e3TQSpppBRfbSa2OgYwWtEV8h7kx0DvbJKRtN92TpdHJQIn0sqp5r77S+A2GzaE/ZvlHn7oAM4yuvP6smoO2Ygstg6c0xeW7V8PmDQ1AClsCMECQqSZiKQlHj+yydSE/OjtFeWqnVkXHG2OEx76P+GKaiFsMEm+l9F3JbcdQqmGfEyQmOQ755En/pPa6wlGcp4Tphca3EuWkdxx7sgq46LKvqFtHzmLplQd0svtB3vtOdi9K4HXd1WMipK9T87E4aGQ481QAeYfwOlCdJz4idWAjDcuEDH2y/sKJ88LPfqbvBDaAzwZvi5HUOLTXLHBM6FdKBgw81/KHL2rurQ==
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 16:28:49 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::a1) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 16:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 16:28:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 09:28:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 09:28:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 09:28:32 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Tue, 18 Oct 2022 21:58:10 +0530
Message-ID: <20221018162812.69673-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018162812.69673-1-akhilrajeev@nvidia.com>
References: <20221018162812.69673-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: e3975ff4-ee76-40f2-8aea-08dab125d636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oks7N8ldAqCmQIAd88prKkm102GY0g6/a+vD8NXPZeA4pmGnXdk+XSK7xST8LZVQbAFe3i63T2mctIbboTxkRvWkiqyUcm0BLhz3bZSUD7BDnjaq4EgkoqtroD4Nwn1kYYIWvUyCIBCUZK2bmtJKMfIKBSb9zS3pH9btiRF9SqRv3W8CGmBo5HAx5/UyBSgGIZdTi/8cvP+yG6lIrYLKdZsX0QHihjh/xcYeyCE5d9MqSeJvhfndl8usY0LgSPAUY7HTR+1rNV9avrcrS7Ie/08I0SPQfuZbLh0gNWtgB/gXHmbI0tIqB2qNxMyuvaPlJB1/1kfuRVRnG0DI01/26BP7+SQQaiaOT2QcQCGmqN/gEPE6oyY8FEV+tlp4cTBTJhwzbesz8aKqFfHiMfYHFZVufHezXYkQXKXa2OcfnG1nt1sChPuZVn1WCZ6ydoEHRt8GWjr9piFTd3wwZhZYAY/jnBvif/t9Z2GjtRO4ZuResLJ1Q1A2AbdrK/WRhPNh7y7vTfeQMdqPV+DEDkocbJRIyM+Ui2xjOw9soIkihmk14HTdRMfRJ6AY7WvB+XuLtkMc0M8XHcJzr1DDxADoAZ0UHTS4d9JcqKJ3I1TKvXpen9BxQkxkYNaZO3h8eRYQ7hcc3ZJ/21eljhqWGWgt4W6Ka8XJcwhDG67erVgLrIV7pRXtUt2vPgEA6AREfLCRRBW/8Rd7sIxDAb8D32YkJ5cfQwQCTCc9Z13zO9GgRQYFbwWbdbv38XO/9ARaUXfVeLrzNfjuGlrLsKMsMMHVwQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(82310400005)(7636003)(356005)(478600001)(7696005)(36756003)(336012)(41300700001)(2906002)(186003)(1076003)(2616005)(316002)(47076005)(86362001)(4326008)(6666004)(8676002)(40480700001)(107886003)(426003)(70206006)(70586007)(110136005)(40460700003)(8936002)(5660300002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:28:49.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3975ff4-ee76-40f2-8aea-08dab125d636
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

