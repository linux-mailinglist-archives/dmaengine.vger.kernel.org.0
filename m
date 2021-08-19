Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3E3F15EC
	for <lists+dmaengine@lfdr.de>; Thu, 19 Aug 2021 11:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSJNx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Aug 2021 05:13:53 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:18497
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235239AbhHSJNw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Aug 2021 05:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKxEJS+Bh7eYUTffQYQUXfh24EK0elbFraWi5Ir2IfDCcDhsTxaiYxlQ8yvNG2gYE6vZeMhGYS0q2On7IRXxhXw8ERk0jKFwvjnCnNc18IRfrVRZGPwN+jXkpQqPSDhLIlAt4jKWtZvtM6HN8sjKhorUfoe4pX0ZaLbIHl34hsClGUS9QNilwbnhwcqU6EwjLENycaBs/VFXx/Pqa1gU1VilEKaRjxFSVWFqWTVKazClJZGYvcvIhJcKNVR4BbHdpWzUFsM0Mxf47+HqfHsDFGq/wNQ/piSLay2RZNemKaLlzRk7Xi7fqSkSyi6og7DGEpa36xkHG+qn6ub6Zwtr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPgRCIRAeKYU17bwuGbAgGsF5OKhSvbXPdbe2U/8Yu8=;
 b=ia1lYuGwEcEzWnp6FW5zmXN0fZOJMUrkLyTjj3XY+3FJtCHzswz20B/GuPNF2bUqup/KaymAvwZANa16zg0RKWIjT4HyKhcaF8ecrqg+29jp5Gvxd6VoWFWGA2Vb5FEiO4IzKhIRtnV+8sTUBJbaz/hdSoqbqcafsSKRLghZ5nekZdprYGV/NAppozi9c81ZwRZVAgmnXXfLUXDiOUmV+WPKXn/f4/QKHKnmch0UQK2TJnYr9cPlwjQgov3ZgCGdgbtatFFvr/OVBgLRHXbn3n9jwkLGF1WpH0kAscIvLjEQZqoZJXNETtFsJTqHyU5YtcolTF94qDwuRzVJLu4nAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPgRCIRAeKYU17bwuGbAgGsF5OKhSvbXPdbe2U/8Yu8=;
 b=bmHUoueVByNXHxl3HLIjHHvpNNXaXm4J+47nKDGMqgg1HMUDwdCZzQZsmtsboLlZ21ztf+jJ+iv44SCyKV47e0lzoAL+8xgE861f3E6H7xea3yeh69vcpqrfxluEUZm64MJkeeuSWUzn/ZJHnWT4MS4sMCQEGm16wyBQkekaX+c=
Received: from SN2PR01CA0070.prod.exchangelabs.com (2603:10b6:800::38) by
 BN7PR02MB5186.namprd02.prod.outlook.com (2603:10b6:408:21::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 09:13:14 +0000
Received: from SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::4c) by SN2PR01CA0070.outlook.office365.com
 (2603:10b6:800::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Thu, 19 Aug 2021 09:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0005.mail.protection.outlook.com (10.97.4.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 09:13:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 19 Aug 2021 02:13:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 19 Aug 2021 02:13:12 -0700
Envelope-to: git@xilinx.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.5] (port=35264 helo=xhdvnc105.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1mGe6p-0005cj-Gl; Thu, 19 Aug 2021 02:13:11 -0700
Received: by xhdvnc105.xilinx.com (Postfix, from userid 13245)
        id B63F76109A; Thu, 19 Aug 2021 14:43:10 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH] dmaengine: xilinx_dma: Set DMA mask for coherent APIs
Date:   Thu, 19 Aug 2021 14:39:33 +0530
Message-ID: <1629364173-408-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeac7645-8879-4c44-c426-08d962f192d3
X-MS-TrafficTypeDiagnostic: BN7PR02MB5186:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5186B4609408C3A34032FE46C7C09@BN7PR02MB5186.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCg1VxqPYr60eIqsR+A502FN8isMSANM11KN2OVM9iML2/xWHCAOKVrXeGD3m2Osh1gaxI8ZaPBgPYJRBHvXHhoAVPRXMJNf6mYrs/ics89xT54NBMEH59xpwl1d14rUgJP8ycpS72APBqtFKli0S4gA1JjoiVV3O85oSjebTbHORvuKh+6Tw392XQoyDrFb2sIpi4PWUD4cLzu0sAkepnrVOjRXHFu0ixzAxLR0XkduIBCASl7YWDEAKs2QmoJR0TrE2vXL9Gpe0CXgxoFPtofBG6kTKpUazduMPLYQKqISff7+rZUK2lWRy2wXJrcsctyrctcFkEM4XBWuR6oR39r1XgT2U1Z6SRQ2eBuZGOISHpsw/UjjSdCtsEgtwOiZFi359soylzrATtly1C9NGuStGJrERfhX1RxweORzkPTjcWDgfVJ3N1Xw6Hocm7iv6Lj3Nz/wGe17lerEB92otu4ymS18rioMpo2nbAtWlcUuaLpwXFJPe3gKZx/GQAnetYetsaFsL7wfcgRuO3Y7uQQ/TfExHMTu5cHYluy/cOHfapIBylUZ5kZx09fAjQYiTPRN5ljaXE4XNFPHCUSiFSYGjeVsmb1KZ6jjsHWeyirfWuPSKbXapX2SCNfuz6iPgL3pQuIyB9ZfaoS6RwhiVd860K3MOXY7s+iBp+044+TAmej0+XOWX1sLoYa1QUYbKCkLv8mY3mideocanDmRObG7OJtfZYWQp0qvpPxXmCQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(6266002)(478600001)(186003)(2616005)(336012)(70586007)(316002)(4326008)(5660300002)(26005)(83380400001)(47076005)(6666004)(82310400003)(426003)(70206006)(36860700001)(2906002)(36756003)(8936002)(356005)(54906003)(36906005)(107886003)(110136005)(8676002)(7636003)(82740400003)(6636002)(42186006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 09:13:13.8818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeac7645-8879-4c44-c426-08d962f192d3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5186
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The xilinx dma driver uses the consistent allocations, so for correct
operation also set the DMA mask for coherent APIs. It fixes the below
kernel crash with dmatest client when DMA IP is configured with 64-bit
address width and linux is booted from high (>4GB) memory.

Call trace:
[  489.531257]  dma_alloc_from_pool+0x8c/0x1c0
[  489.535431]  dma_direct_alloc+0x284/0x330
[  489.539432]  dma_alloc_attrs+0x80/0xf0
[  489.543174]  dma_pool_alloc+0x160/0x2c0
[  489.547003]  xilinx_cdma_prep_memcpy+0xa4/0x180
[  489.551524]  dmatest_func+0x3cc/0x114c
[  489.555266]  kthread+0x124/0x130
[  489.558486]  ret_from_fork+0x10/0x3c
[  489.562051] ---[ end trace 248625b2d596a90a ]---

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 75c0b8e904e5..ca59e02758c5 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3065,7 +3065,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->ext_addr = false;
 
 	/* Set the dma mask bits */
-	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
+	dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
 
 	/* Initialize the DMA engine */
 	xdev->common.dev = &pdev->dev;
-- 
2.7.4

