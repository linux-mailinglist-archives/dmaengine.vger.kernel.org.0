Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4063766E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKXK33 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Nov 2022 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKXK32 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Nov 2022 05:29:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BA8FF8A;
        Thu, 24 Nov 2022 02:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp5qM3a9miyT6YvawcxLz3I7yGLpMt7EYFDaYFEQe5ixjfM0kzVSuM0zQpM+4rKC4IERlr/Wn7g820nr39qeYJTC95mJTM7ZJq8UAWsD4aNeEDGjPDWQuOcnO1yPIYwKIDFeha5Os3JeNZ1ZmSTQPbm38TlQBZGrvDx5P0+sKDXgX8XmDH7JRZT+0LnYJFjaWGCo3e7DUVkwWpYGd8hepQtyOVtGxXgxKXYfOVzWdsKxyUm5KoV4kbx5ZpJ3ORIKrONg1NDyX/5ZPRncymW3c5v8f8hZSoDsdeD6TwVaYl6X+IcgwGGA9kt2sAJQNM1QmD+erKHS5N1oC+DsglgxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSCysilUQC56RcIe4Av10dPkzjno7xwDAjurkqja+Vc=;
 b=SCeOSqOLXqolEC23erHMd7CECCSeUXHc2rV7GHIafX+t3NciIksvOsVtB/UVzruJK6lbnuYm02Xa02SPGoprTG19rggn9LwiGk9AM/mdaVN6bvCnRYh1MpOxLPVoUI5+6oYdAshXuijaG8Hq3+3IDPaPM0/5ovwVrYWRpD78Q9XIwD/4oPD3qepOI0HvCt8JBqyLfMyU7EdfirFjOkQ+gyUt6rOSRZ/95sbXUC1LNL27+Tzn8xbjvLP2GHp/CxPaVJD0BPPunBViHAF2d1IP/NBu5RxxjlK0+FltbVOY5amRov82DKSpW5US3pfDcYn+tuutksl+sFabGuG73inVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSCysilUQC56RcIe4Av10dPkzjno7xwDAjurkqja+Vc=;
 b=2zclkWHRN7a3/7mnDxdqn+8xOOr4dzIk/7Stb5EPWBWuuSO5atgI/Vd4F3XRYYGgwncw7CCs01/pxRhgnnZzWXpGtXNV6HIV+HamwKbcZgexPFEa3sIVgSFhIyX+9wnXREZDRpPLYRUaLxQVHl99Qo7b47wVWyXoCzCjXh4ZHCU=
Received: from BN9PR03CA0886.namprd03.prod.outlook.com (2603:10b6:408:13c::21)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 10:29:24 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f0) by BN9PR03CA0886.outlook.office365.com
 (2603:10b6:408:13c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 10:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 10:29:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 04:28:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 02:28:52 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 04:28:48 -0600
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
Subject: [PATCH V2 4/6] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date:   Thu, 24 Nov 2022 15:57:43 +0530
Message-ID: <20221124102745.2620370-5-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fa867b-ec85-4182-55f0-08dace06c189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTDikF6+vaMj+ygQCXDX2Awj35YHUwgUSWWLBfvd8/OzYXtBE4WBMgXgKrw6in6PvQSLiPZ4eWJbpxJ00is1pdISTNp+PIcB2oV0plXpDFf9Eeo28naV38pv2NmViIjL3NPmEiLNXljYz5LDKXuCk/SCWCsiLqMRRTdvlHESNPtAE2Vd9bBQ+m4k6P4Y+4ePWwM1hNmFtxwhm3CD9dKwNzHQd7YKInINaP8dRRlUBkIlGXrKTCg0+qkfq1bIYnNqb2L5Km0+ornC3BZvLNzz70UMfNnZoQhOc1IXAtzPdV6AS/VqfSav5u4UCnFVGfzH0o433YrM6+HxcjXxIHhSfvID6lSEi+rtgMsFPQgFrs+BMg2IxdxeELdgb8+6Jhozw4kNSlpeSOrVVA03Y2k2eC3HOjxqszrhG11RFLaYIpBFQ4MeUHkLKgUvu5DujV2db5aqBDceESjAX8x5uuW1JzJ3N+cySNE5oVihlnrx1S5EkWLm1kOU7/iGfpT13JeB6M4iGosS3AYAEdwOjbPz20tJg18o+1t9GBuk0oFp+FT/2/Pmv4OQKi+ztiAM7jY08WVI/AjolNLf5DDaL8HspBMQ/9qTY0eoEzdSR/z9Kvz5iDXpZblOfM0wxGZPHtKi4oDE4ZRvFAE6VBv9ROUgTwFGw3A8Dc5jwPPWsPcgxnDbpBJCo1N5eR2bGq18kGMsQOvoSSXDjyEHebvB7SUHiI9cHQ6I9QMIbypsFU67l7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(2906002)(36860700001)(103116003)(36756003)(186003)(41300700001)(1076003)(40480700001)(70206006)(70586007)(2616005)(81166007)(86362001)(40460700003)(356005)(54906003)(82310400005)(110136005)(5660300002)(336012)(4326008)(8936002)(8676002)(4744005)(426003)(316002)(47076005)(478600001)(6666004)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:29:23.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fa867b-ec85-4182-55f0-08dace06c189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index f783ba86cb09..6780b1c21414 100644
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

