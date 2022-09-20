Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE55BDCA1
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 07:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiITFws (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiITFw3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 01:52:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA295C36A;
        Mon, 19 Sep 2022 22:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/f7xUi7WYfbM+p/+Tn3WoiTTwziyhX2VNTSV191GmRIFs+qIaA0AFM4QbtOqlP1s1AH2/2Q5+j/FbpvTUZNFNe+bcyv1d+rWA4Af8YUspCf9FVgpehucSNqNyoaGPcAzP+xUX4RSp3ClQc7HIo10MyZ/kirclgUNil54iSNccDMD7hnbZwQmb75sfvmPbPg8SlOWdIUsq+5QtZcr9xz0UiLx3IPpXZ6X8j2L1HsKJGCWs0ziHRE56oP3onR60n7u8OVKVorEATVPC1bm7xy+7y2vBbTG6dZoWg/5T8WjRnB9TwrZdjYWlgSg4OeZhRrwSIP3HEL6E73CrHJPywy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L1hnS9Go4bLhQehQ9IwY0iWbv7nxAHNngpfz3PXWz8=;
 b=SgSv3HZOTN3Q0tbWKqYj+VY2/jyZ1lDJhz3SnQ065e36qLbxKM8jDX94LLftXuYKOmySipHkWeKHZ5WF8+vbtHnKoE3Sq6FqGX1qoCPA4ZGyhoh++mueUDX2dosxHXjLc2JqTDhwVeDFEjgXDlbQ09PdI9A0veYjPLpS7xXl8gACjvoZ88dRIS1HWBNKSFaUbD5r1VXsDvEbLzOJzLBWXrqhTGzK/7CHHpxey5baGY1xtOzOeiT1jl2+6LBQGj2/m4K2LXSykFrIv6MFrFMTyGL6eLc5MjJx4+6cJOSIljgvXDhlreFrjKLecqoIH7tcLBVbWwMVtavGbgcf0CQY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L1hnS9Go4bLhQehQ9IwY0iWbv7nxAHNngpfz3PXWz8=;
 b=GVfBUO5ETreIFPaWG2vU8h1uBSD3aP3kHmy5/31/PtujhU43TNKcWheB5TkdWqPqDFnmcCiIa3p5u+9ilL+mjTX+2eFuB7TkFSr2CCEfQbV/G2vdGfVd1qZzialMxuRnNR/Mx44+nXv0ek1/S0vZ0fsrY54/BnAn6pbHs/YeiKE=
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 05:52:09 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::b6) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Tue, 20 Sep 2022 05:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:52:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:52:06 -0500
Received: from xhdswatia40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:52:01 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <adrianml@alumnos.upm.es>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>, <sarath.babu.naidu.gaddam@amd.com>,
        <git@xilinx.com>, <git@amd.com>
Subject: [RFC V3 PATCH 4/8] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date:   Tue, 20 Sep 2022 11:21:15 +0530
Message-ID: <20220920055119.12634-5-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cd9928-706f-4372-9bea-08da9acc4184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBQ4jOII7Mw1MYS4m7Tu70695iouFbMrI6Z0wXeF9ucjSHj2f1DU2x0H6JpCdn7kuRRDLwcYGFAN7s4T9vCS/+DaKDOzqBox1cBsWcYpuegybRFRA+r+4dqRhvOgRsNfZLBWfwRk3eb5EyDx4qrTWELZPntr7gohQ+2wwGYVZGHQxaFTFcL/bzMlD1IRvtzqZfPxSnCVWSRUpp+fXFb58cWMFimIlQqv9hJ0FkMC80lSkwcC64roO2vEaN1SHhBTwNBussIzFEbEuGhVZ1yH0fCkSgcGc/0ybtJLFME6C4hJZRTuRiKEfzuY3ABz/ND2n8ym8S18MlC2Of9o/TQR9WbhHE9yrCTf60XVWgHc89Qiy/HQpxAltBEkRkOj5h0xze6BtcVMNurG0YKNiq8REZBbyT635pxMoChKZeVEJCdEoE9yaKvNeoaCskpa6yaq83bzs56d02482gDAQcEB0+lKih7xy72eXFR+8v9AFssfHH02DqnNYMIwEgwAVOTkRXnbE0CPYfHiawipw5PAecFwQbJhRyBrA+mCTZwLAEZAANd/WTp01wfW6kLJUzlhzqWcSEl11Qv0pxaug1f6qoegi1eAHOi0PxXMO+NqFEHn3UkYUt/oUPsNatBCtun8yX8wB0ipWk2kErk3FulLqFxaCvhGcPJj8Z8kB2qZKiHjOVBCrQoyaDzxxDtMNZFjiqOQvqaVZ2DAD73bekEZVEet5PxGB0ZysFNRuupMQwEnALq56tkOQye5Evrk4t8XAf5kfzwxDSekGvt2Aq/lOvl0kQZIVP+/V/PJJIEqbPmE72urZYpEVYKxBqaLEhoy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(26005)(6666004)(54906003)(82310400005)(4326008)(1076003)(8676002)(5660300002)(70206006)(47076005)(40480700001)(478600001)(81166007)(2906002)(83380400001)(336012)(103116003)(70586007)(40460700003)(4744005)(186003)(36860700001)(41300700001)(110136005)(316002)(2616005)(8936002)(356005)(36756003)(86362001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:52:08.8468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cd9928-706f-4372-9bea-08da9acc4184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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

Increase AXI DMA transaction segments count to ensure that even in
high load we always get a free segment in prepare descriptor for a
DMA_SLAVE transaction.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
Changes in V3 and V2:
- None
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 12b1281b19bf..8c6065cbda79 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -178,7 +178,7 @@
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
-#define XILINX_DMA_NUM_DESCS		255
+#define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* AXI CDMA Specific Registers/Offsets */
-- 
2.25.1

