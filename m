Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7CC5BCAAA
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISL0h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiISL0c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 07:26:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABF1EC70;
        Mon, 19 Sep 2022 04:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDVkiI/Ohkbmo54qqTID8iE62pbWoYRDmWPmEL2pgWILu/W/V3njTOqhJs2qqbirw+NvBrSmkRYrzi7ybWYo77FJh50DhB5wUdwCq8aIlzFjlUdJz/cvYxojplyYJ4ib/YBrOP4ejg6dcVv9s637mboVIB7jpBmfebfJzLmZG3niv6UGBBTUM2u2gX2muN7heaWiHHFOc7EUrY3urVt8I9nvRdrWXhx+zILmwJsI8EiTSltlbdVj34Es31UphZYIZOty7amIj3nU3972WnBe3uVoQeg9MXZbaQPPAfRXeeatCa5kP42cdwTvPfCWMab5hE0hwS7y31mLgmQS5Vc47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jy/1eGGdRrI+aJDrGprMHyvr7SjhnUqCWq0Oh3cDzc=;
 b=FtGZ01cl69tXupOqsIpqNXLXRhLVLkBEnAEasQ4g/Db9HjiLHbGnXk3SkLnLHwqQKH+VbVq2+qfVW1zYFhR5urM9be8GFADMhzPf20KbKCyZTlI+b95Tyo6RQVMIu8CFgte7GA75SJ7TIQbFPQx7cEGXDAHc31LMbEQAQpfJJ0t8HcH1PvCpD1wEefahAMQAgg9NPKR7LfsCBYwxmoVeLAX2NAMRQonuBbhzayT2ti3Gxr0+K6yrQ2TCFWIoNzJHfcj0BKplYCKnNUEMLOGXBHwAjGGt9wWjcfNoXdltYoe423CIKCAtJnaIrC96DmIUuxZFewUNixO5UBS5jmTcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jy/1eGGdRrI+aJDrGprMHyvr7SjhnUqCWq0Oh3cDzc=;
 b=t8f8Fuvugftx0HvGlKfBhQr5Oo48cNRsN8cznYUwFSOl6ohcgGxMI/1RGjauUQSPL2jMfzrFj7avXYSMc/utSqqbDPYVKWPbVXJcYzWrM7MtSAueh4B0h4b4E3Qp3twnTg6Oq7UtcMIfx0bQRyGnuAg03qYxOmGKwKSnkyTiKdpZpGg+NqhfVuEp+xIiC5Ug1mt0+h94kttgBxvYJthns0gv7gJlrPi0FCGFhjkGGwES1/OOrmAO0KGw6Udu4JJlPa9dMubJjbMlhq04rsA2qPxtgsxuxiQ95Ma/fuJyzruaYIQKZrcOyiCBC5xLtTrfqYIKoR2d21vVF/rLUHwOIQ==
Received: from DM6PR06CA0069.namprd06.prod.outlook.com (2603:10b6:5:54::46) by
 BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 11:26:29 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::12) by DM6PR06CA0069.outlook.office365.com
 (2603:10b6:5:54::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 11:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 11:26:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 04:26:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 rnnvmail204.nvidia.com (10.129.68.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 04:26:18 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 04:26:16 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: Add dma-channel-mask to Tegra GPCDMA
Date:   Mon, 19 Sep 2022 16:55:57 +0530
Message-ID: <20220919112559.58195-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919112559.58195-1-akhilrajeev@nvidia.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 619d9aa0-087f-4c84-6039-08da9a31cbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRNZNDWUuGo7XbZ/Aiqe6q+EEncdYm3nwRASMCcPmtFVjCzo4DXdQrqK5WjBt7aXQBzGAIB0eJAlRFSmOGLyWwXH3NvxJ3z/cJKvhgTCal/iNbmFuXSTPjNYaxHGHcaDiAljayz5QDKYaNNYD7mdmC4OI/x3Gwhc5N4E5Ewxj5OiTHOZvsqHVAranrcI4vtkSrjdPOvXFgos8mfRFE22GMwWZWCjgmb0YJscmBJbfk6vSF1mQuG7Kx9B6oOgQRwDAmS1X3677i6JD/6wnU+HF+UZ7SEjbeUf6+jt9TX3Zj3FOR7aKTs5ac2FCGVbVPi9W0UYSDozkJQ1B6bieKtgCkPNN5PC9rSUcG9egIC8+luSQA7D2B38uei8+uwx3xb4u4bb/YUIrjPpyj1+Zgz4txG8iCnuQxGPdpG2Bk7T2cUm4ZmgrRRrspidi/Fbofl7LzHhgauUQTu5Mmvt/EDSXj5JMrvJyuLeHMfP8ru0Rj1aUnoSLgx6pLQZadyGEDC2X8XdHf32DujLTZ511oSxr8bUhLMfxdgPavJ+4z7hW7EgliebBv+6b5oASpmBUblg8A9Ly2lkrWs/KqYpHgtpRTIE+ib5NlKWG7I0ya9cwWxE93udTS4Gv7Ohq+KHhTD4vaAEsH7dbRa+LNLOS+kDVZ4++PbW5XTueOf7rxGJtAC8NYzVWOTrerLt2+vdSNiYZKVorEF/9Eu5HxTvCtAGxioR1YMCYYfRw1P9IC95T9DaWE+qGtBwrbgow6w9ovb/TbpLIcOKljFUkrI96C4jKQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(356005)(8936002)(107886003)(426003)(5660300002)(2906002)(47076005)(6666004)(478600001)(40460700003)(336012)(1076003)(186003)(40480700001)(26005)(36756003)(82310400005)(7636003)(7696005)(36860700001)(82740400003)(86362001)(83380400001)(2616005)(110136005)(316002)(8676002)(4326008)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:26:28.7478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619d9aa0-087f-4c84-6039-08da9a31cbc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

