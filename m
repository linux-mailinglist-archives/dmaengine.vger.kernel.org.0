Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE55B7721
	for <lists+dmaengine@lfdr.de>; Tue, 13 Sep 2022 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIMRDt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Sep 2022 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiIMRDX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Sep 2022 13:03:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF88E0D1;
        Tue, 13 Sep 2022 08:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyR6P/LATYIX9vKSRJEYGt4X1fPn4/CtHCu3crfzbipDoar6XmlkPgj/fMEAqLLV5aSwoiyLD3K7/gDCMlnH50iDq4fDYGnIo8Q+q2stnOX2ovEjQqvUN07g7iWpdj2yb/lWcQ5T3ZpHY+pXz/ziq9JIFFSQ1iptxtqwspKR6h5F9omY7VMpBFsfIPi9ckQmwtT8+dFqFi/RZ3APmMvcWYpabWp157f5LvjrOnKCXNMVJHAL/sKtYE8980zRClx5p6QZYdScw2OIOVDU+WjNfB4se6bNC5UivTX9kPWTOzQNCQs85xtD94cO475STV80/h5uhz5g/KGES56ZlZOZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jy/1eGGdRrI+aJDrGprMHyvr7SjhnUqCWq0Oh3cDzc=;
 b=NJjUqpCCCsUaExmWm2zyHBfZYI/4BagseWp5GXygrdo607kdQ9gyYnSprq1d6frOVd+JeJ3EY6IHsLTE6cLsLkqE3nu67BpIwTPJpMl/oneVB54WUcg65WcGOyZg7vShFGSyt5agSMPWCKRI89D/CZUT3ZCNxkiX1tdm6uAPMJvX+wZFidqgG8yjfAtsP3GjiBrc3zD3FNzmkQpEDSxHOxa0W4LZOwUKzB9M/M5cb5bAzslF0rAJX44S1yxQhhuQ9Z3Iax9UjI3TamUsVg7dRMYgsUtmlTHSKZKpfIguvnnRriS3GrWFVxtAS0WjcdWAtcs0b/+cV4dJOTtTH+QRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jy/1eGGdRrI+aJDrGprMHyvr7SjhnUqCWq0Oh3cDzc=;
 b=r+QGCp9GLoPNIHdwVVaaeEfV5BWI7oDJRciP91TnzIh20xD5/iGHrYwZxS479meoZOjmRa2Q6jpkAa19f4TpvVmFmfwjvdiDJa6t4K3dcV5JrGF5wykxbTocxb38AsDusEWkrImJziU0X0tjmCIAQbDXnAKmApPsD2Dto7SMJPyQmIGWDaXDewQrJr7IpAV1cezojQo+cPjIw2fSmHhPqvfEuE06yQddrAssrSy4zIWH5Ny+/ek8xe7genkm1DNGnknIWakBszZSpAxD2w3A9dC2SyzW+GAmLz4bXZse4hIU3IN9asxA96mNSGMvLBlko6BmPQ8rHIQiB9Hr/r5SUA==
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 15:53:17 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::a5) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 15:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 15:53:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 15:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 08:53:15 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 08:53:13 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Tue, 13 Sep 2022 21:22:49 +0530
Message-ID: <20220913155251.59375-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913155251.59375-1-akhilrajeev@nvidia.com>
References: <20220913155251.59375-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee8e161-9d23-4fe0-74ff-08da95a0133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIArLFGC+WXtK/T6+jncOvm4zQRdija8kdac93MbgBQwyaHG0i/jWpXh5cPEsDhfuwmITIgtx09NnS+OavBkDcJaCNgocVS92Sa2kBimET2MMmEXUAZqeHW8K9vKcaqUZfkSteMaW7RET9GPk/NOSdFX1aRJC0A+IPFpsSO54+Ome3VpX0Ak4X1mfmEGJ4rTfPeRdhKxb1dQRka4Usse7O5bnxO7SByehyV1pRm0SQ1pRjfa7QwPLmy9yiIfRdqvsJaFI6BnrBrvRb4Sd2nPOl/OQrDCOiJO8Wwrhb26R0aPNeILHcD8jgu91AIdKLw4sHB+QihEpyoAGBvdSk/UQar0eiNSD7wA9MhHsYl4CBF4kcg6taW4XQIe4n526cQxnl8INbGJdnNAwRImRzjLxqnlUa9LBwieaxL+lgwhemLAJ2cp5fdjfuJYvMEcHgjc8Ixhb9I5QiMzzT2vyaJbhFEAPXwzyAaEGrTeMr3K3+66ObXVtrz3IYqXMiXwH20V2HovJW5c6mZv5BEQPtfKrQuisCWshZNk2jCHUCyLXUASUGFAOhIjWMhb1IXccP07SInQ7+s+GxM20IEv4B4Oskqz4bXEFwDEaO6VYfdfsHl4WfOTxUyD9Osf38Cx0XevUQMXlSQjC29tlP/yYVVt49vYr3v325FIZUgfMV65W0MMU7qEgFd3QJIki3Aya8k1HZEbZv8Yk3ks1aCTBLYoIzcki9PvmJg6UN7LxmNJAytTKBUaXHgfxNjfb4xKRELZemBVaHFwj85iXIdU0ZMXavlz1l603B0iBWi/zvBUG3MAjWTkrRQdtLa7bw+wL98t
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(47076005)(6666004)(110136005)(186003)(83380400001)(4326008)(426003)(40460700003)(82310400005)(40480700001)(86362001)(356005)(8676002)(2616005)(36756003)(41300700001)(8936002)(36860700001)(70586007)(5660300002)(81166007)(1076003)(70206006)(478600001)(336012)(7696005)(107886003)(316002)(26005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:53:17.4637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee8e161-9d23-4fe0-74ff-08da95a0133e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 7e575296df0c..31724cda074e 100644
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

