Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D2617564
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 05:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKCENC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCENB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 00:13:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F313EBD;
        Wed,  2 Nov 2022 21:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPQPZ5GVQ3lgr5FbUqSgEdY9mgLWD1KwlT0qzdDI3OWVP8AsruxEvI3ieRLd7U/IaQiuTQPBaYHB7o7LLKt0vAJ2VqTkvMbb77mtaP60FaFIDQcnRX/76L5HowVz0XTzd4DvV0kjFz6CJJgYi7LK05RQn/9uI8ac11ByYCdQKiv4C6+oiYuEtCyD0twUa2fum/X8mnVTQ6L4bw1rpAdCCgdE2uFuNcpALIDO+SukFr4+79fVZiPfsvIEVoM4/clL3F8BAwlQQOW7mqUuwMVqnMH47lhaZiiWa7MZG5ZEDJ6oqZZIf3zPtGxeBUIVKvaFUGh/Q2+u65wkIXRbZ9UwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6uS0OgCmJSHJbxgdXIZn8WDKLvaqw2uQVhLMv0Gtqo=;
 b=Byi2vfTwr0FfjZJC+XJeU0dxbuDRz/vpQjq0f106NJP66sJ6vp+UP3LB/0ilGZbNJU9BdA1FIzxN+9/FRbR5ddeI0WRF7Q2RgOqlv4iMRpRLGq7s84r/9Syn+W7hZcfgrIJ/s3Fag9/k5c/nIko84n7EDRfXlfzbKCnnbMWx0+0Lbww2v35FPS5FLVNGFv2ilbSs0qdGIq5/x/oAE/4tlD+kgJZNpjodUsRDyL+gFpfua4VrEFAYS4dSZxtW18GwtcH/ryKRbW2A9zWyRovW+W0W1YRe2vG4BDZTiYOV00GVtVjbFTD9JDZYnCTtFrpU95H0dPjii0iRfXe6Kyq4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6uS0OgCmJSHJbxgdXIZn8WDKLvaqw2uQVhLMv0Gtqo=;
 b=puZQJQIH8dRoEA7wcrrOzAy8vQQO2Zam2EpQgd7pB5+15iNmOcC2q73gdTX54WeJILz3kv0vyS6607BEiwZhI0WkXiu3uD1+D8M7NGm2V7VxrAyeOsYjdR3Flio2KSSN9tPh53LP+gV5vfW3gHq7kNBvGs+6RT7ULvnRwOqkXbE=
Received: from SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) by CH2PR02MB6936.namprd02.prod.outlook.com
 (2603:10b6:610:5e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.24; Thu, 3 Nov
 2022 04:12:57 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::a1) by SN6PR2101CA0010.outlook.office365.com
 (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5 via Frontend
 Transport; Thu, 3 Nov 2022 04:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:12:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 2 Nov 2022 21:12:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Wed, 2 Nov 2022 21:12:52 -0700
Envelope-to: git@amd.com,
 harini.katakam@amd.com,
 radhey.shyam.pandey@amd.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 m.tretter@pengutronix.de,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.3] (port=53952 helo=xhdvnc103.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1oqRb1-00028X-RE; Wed, 02 Nov 2022 21:12:52 -0700
Received: by xhdvnc103.xilinx.com (Postfix, from userid 13245)
        id 0EDEB10550D; Thu,  3 Nov 2022 09:42:51 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <michal.simek@xilinx.com>, <m.tretter@pengutronix.de>,
        <harini.katakam@amd.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width required property
Date:   Thu, 3 Nov 2022 09:42:37 +0530
Message-ID: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0021:EE_|CH2PR02MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fff423-3fe4-4634-b402-08dabd51b000
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hP9fJovjK2AyJ/kvdZFCGiShDlGXQSDfDpTWb/lnjcMu1wG1y90XpZ7EOXJY6h3Cu6vRng1Ag3GIM8J3DX6NkjLHBu5E0Yl95sgjuoWINjWKfQWv09QktrKkU2U875bxi/E9CwDyp2LsxaH9c3h6LMmioRlRaDeOKLghUFeAww2Sbjn+WmTfkPuJ5GcT0T0VBnSzDOTk6yGPLMGtlh0jVHHPCJCyDskBYhQ/5QF49Zq/rVUB/mP7E5VYHiHa9BHodqLNLYrCMp1BWsJwyg4HWH48/B27hCjiJOqDZcT0QA6dYv0zenfFlt1i6lNgxBnpe2ZFX5Xq4f/bjugND5E//v6B7DTqAwAWKfe+ayGILCGVSQvtFxxHz6MDGSiR1eUKHkAa5T4PBz8AMKcwlQj5TaCRBc0HImU8e88YWqYBM9wnPD95gwuIG/nSOqgAi3uaVZV7z27GZwVzla5hfs/O8MvR/PpHc5SMF7K4VOlBVXzTNRIuTlbwzkQjtFoOU4fmZdGEvPMVtyg2R+Rg2kNIIUiyHOQvBu82o/VoFmcgTAuaA83p0JMEbCdYJ2RWMbQ69/3OezlXgxmmVMIWr2o1DZVRnoj4OBv2n34aanjeL2SDIdkaKCKT/p4vFQujba+MznjGXnMdwJFuJpXJUY65Vws+zDpvwpUgYfqhoEtVD5OOiLJr4jd4UfSi4jo/8hoFo3Co76prmTc2iqIlHIVtJbhzS6T9HNJH0cXUYpWgo2Of1JHanKOOhF9o4rRjJLPvlHJeyePg4Xs4jYvSy+rRBIDFsPlOGopEG7jKTe8+nII=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(40460700003)(7636003)(356005)(82740400003)(83170400001)(41300700001)(7416002)(8936002)(5660300002)(316002)(8676002)(54906003)(42186006)(70206006)(70586007)(4326008)(82310400005)(2906002)(110136005)(42882007)(336012)(47076005)(2616005)(186003)(40480700001)(83380400001)(478600001)(6266002)(26005)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:12:56.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fff423-3fe4-4634-b402-08dabd51b000
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6936
X-Spam-Status: No, score=0.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

xlnx,bus-width is a required property. In yaml conversion somehow
it got missed out. Bring it back and mention it in required list.
Also add Harini and myself to the maintainer list.

Fixes: 5a04982df8da ("dt-bindings: dmaengine: zynqmp_dma: convert to yaml")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index c0a1408b12ec..a10019d3a650 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -13,6 +13,8 @@ description: |
 
 maintainers:
   - Michael Tretter <m.tretter@pengutronix.de>
+  - Harini Katakam <harini.katakam@amd.com>
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 
 allOf:
   - $ref: "../dma-controller.yaml#"
@@ -65,6 +67,7 @@ required:
   - interrupts
   - clocks
   - clock-names
+  - xlnx,bus-width
 
 additionalProperties: false
 

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.25.1

