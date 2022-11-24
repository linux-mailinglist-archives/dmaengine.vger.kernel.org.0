Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFEF637665
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKXK2m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKXK2d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:28:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D4C6899;
        Thu, 24 Nov 2022 02:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl7SgcibHX3qr1DePwblNb0IxHZmnBH9p/mUYIh4FfYK6R40AyUU4ZqwNj03KHq9VP4tvw0/PoVqyQiOGXHTVMd/EK4ZlAvMz8UBxXiCfUg3TNkKeGMmzv/izn1WU4CwrVl2kio3RTykxLQJvLJ1bm43Bqbp234Q4eHQnWUoFACdTGTpkHUpgtYI15Jr/NmX8KhmWhfHnqBziMkYLT/GfR+wzH/169C4UOqeeG3BiFjlx/4Nltb/rlD38Em3H2RMCgyta+CKHKH2BjmF6SsHRXl0qhljxez2CIlKshTHaawRJ8kPTeRxB60ezQblNCFt+BUhODagiWZLjAg6Jg0FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0he5SYKDwNrcgnKlPGqkas8E2vgFwGCDnciSWTb2lZ8=;
 b=OXG/J6Fzt3U/eeaO0wMPQH0shLTtDA1+xIJZRQ2BeDiJX9lGwPIKzdtuFd2DLVQgkSMoBuvnVNagwwUZX/dqyCSfXF+dIwIWxG1DMr7snlnI3d3gHTKjZQLzZEvEy7TLJ1GXLKN+VVYsbuAI4fwYnFN7ihQ/jaaxBm17LiQwO/Mkrs+zyvVukanZZc6QscO16XLOvwmUzlfTYXdoXo490PTnbzG/py3CWpbRsG+WOQeLMJk8qkB06XSNyJpCvH8cU+jhKz8ETlU9uvdTed7JULnD+jau83EJQdfR3kSSpllXiBYNMwuMA9owYYyg1gK18JlvjGyp+O98k4ukzklaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0he5SYKDwNrcgnKlPGqkas8E2vgFwGCDnciSWTb2lZ8=;
 b=Vp//KV8Ka7gYLmh0zQIbMa1zGtPMkuM9Yx5zE5nhaxMKObpXaAdSuU6OPF2F6I8BhWmSS+STdi7VZiDXG0lKYY5cWED2GagYe+JRLJy6nvGEjsdFLgo+D3A8Xh4wtY4yYrChiw4PKdfFHbTrxDQjXE29r/+Txt6lNuuWUn6/Iic=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 10:28:31 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::ba) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 10:28:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:02 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:27:58 -0600
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@amd.com>
Subject: [PATCH V2 1/6] dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected property
Date:   Thu, 24 Nov 2022 15:57:40 +0530
Message-ID: <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: a901829d-1aaf-494a-24ad-08dace06a21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vVixQgDV8Nfe0PBksta/USHA1lMDMe7WWjgGO8+ZPc2telhSe4rOONJqiGixOLGGRruiRTYz6Q/fkGyYnCgF5IGyy50HNvbLt2KSrIJTSGZGCL58HuDMv4OCRchnKE4623ylhCuWKeXJ/96wrHXPsr9noSJdyBDmsB7rB7JlPJktowN3tvDGu3CCpULB8YtlMF8u6alCdKb+mKZbJcQTsWpD7yEeVBnEvOu/Pe8o5UDqHsCKGVWazYyFBRTmmQ1s9/nEIce/W/8/ohFzWtvhmfvvh2nR41B33w+nXOkA/PgtJVHYvJIBA8bVYLXsBSp4mfhA+juno1l4LjfjdRnpcc+jYnR2XyDjrniEnrhk6YlWb+KssDhu4sGbfTZIQ7lwM3B1S3Q7taYolYhzGYw7tNz+P6HP99dT1FO4xJ/j2yOxskUFE502f5O3C7arAzfbdrj6MAbikSOhyRzVb0jovJM2V5KKccFK5ocawJaG+zTFRC0w9JpYqL3lXufOPmiNAuD3+BtulSI6anqBTJQefm3O+EwS7HroklA1iV21+lppS01AlGj1+9m+M84QcI+PANFpV2VwqpZ0RWUmpysmTY1m8Nkn5Gw99iGl0wYMhqMUaSgUzEPwN0AcfYownP78GUq/0FPr2VEqntsGiyuTwgfq89617TyUk/4JcmVuUV/CY3KTPFQc2QPmozx1Qp5WA4/4BbHOty/LRepUhBPRlTDNYDjSCp6qvb51KYMPgA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(103116003)(8676002)(110136005)(70206006)(26005)(70586007)(82310400005)(4326008)(86362001)(316002)(2616005)(336012)(47076005)(1076003)(426003)(356005)(81166007)(6666004)(40480700001)(36860700001)(478600001)(82740400003)(186003)(2906002)(5660300002)(8936002)(36756003)(40460700003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:28:06.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a901829d-1aaf-494a-24ad-08dace06a21c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Add an optional AXI DMA property 'xlnx,axistream-connected'. This
can be specified to indicate that DMA is connected to a streaming IP
in the hardware design and dma driver needs to do some additional
handling i.e pass metadata and perform streaming IP specific
configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V2:
1) Moved xlnx,axistream-connected optional property to under AXI DMA.
2) Removed Acked-by: Rob Herring.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index d1700a5c36bf..fea5b09a439d 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -49,6 +49,10 @@ Optional properties for AXI DMA and MCDMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
+
+Optional properties for AXI DMA:
+- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
+
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.25.1

