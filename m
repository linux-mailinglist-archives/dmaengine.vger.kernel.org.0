Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121242A5E79
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 08:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKDHBM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 02:01:12 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:27993
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgKDHBL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Nov 2020 02:01:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgJV01AD4zj4v1fLO/0wnl8t0T43xLIeJqlYzb5EDVe9EOLJ7iV8vo7Q9noLhbZDwzkw1f2VR8AHw1IAdadxRTqQZEwlrNSXKa17DiVBFu0Ba/Tsnz6kuUetWghXS6ooX555X1W6KsYOG46feRHmTNf2UeOZ3aI38YqMXTvAjmC1dfO1Of3eaM6TE9A+lFEhdn1wg1yckZxwmeP0/0OUroSZQyluIfzg6OQaIumwSHfOr4zP9yqkKcC2n18sxFf20yUMgMtjx3enFbRkqvy4eNyvSzc8xWsH98pfZSF1sFXh8DpHItR4PIpEHBmun7rd0tgeRWdfKF18ahTXjGYH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoC525EXStlW6ZQuYor/k5PS0xwKwLwSGWkfDEbulJQ=;
 b=bGP2H3nV7OknxFTHDw7mDEefmQAr4xS/8wCT0tzaK+AunuUch1qJYZwtHx47JpddUSvv8BqYkL8kHvUrvUbLobaZjLA4pDdUsdodfI8/jm1kwfMcmJRRR8wE/GlENIlpYnm39MaMdTY/w7hHjs9hyWk40R8u4BXKibNPVGNvOZh4AbGPKFGKMEveMc9axfXxdWbSiIMvVodkQ37cbl6vkJmQSHDU6tqEEPyxXfu0WZHVhHpReLuAHd+RvHZDzXrwUc+xxljttFIJH/5QKShd8LIpWH8hCGJggse58Llt75cSIh8+POkHwKCF19b4fZoUkFDF2lU9HmRa+YBchEjB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoC525EXStlW6ZQuYor/k5PS0xwKwLwSGWkfDEbulJQ=;
 b=CNdsvF07z3eQa7qfRN2Lfvnvz15V3lCP86Pb1tYMpI79Rb08tC2wKH+HcF/rnJzWMm1+y1BEQG345LbJz6h+O1cXeO2VYY8JcekH8naN+oHRTpWIWQ3/UfQC6GhA36pH8HhAK9fh3Bf51m1e3VuyxHPnd0/ZO4DspITtcitLEz8=
Received: from CY4PR21CA0045.namprd21.prod.outlook.com (2603:10b6:903:12b::31)
 by CH2PR02MB6262.namprd02.prod.outlook.com (2603:10b6:610:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32; Wed, 4 Nov
 2020 07:01:07 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::aa) by CY4PR21CA0045.outlook.office365.com
 (2603:10b6:903:12b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Wed, 4 Nov 2020 07:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 07:01:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 23:00:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 3 Nov 2020 23:00:49 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 matthew.murrian@goctsi.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=53877 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kaCmm-0005oA-Lg; Tue, 03 Nov 2020 23:00:48 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 1D50B121463; Wed,  4 Nov 2020 12:30:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Matthew Murrian <matthew.murrian@goctsi.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix SG capability check for MCDMA
Date:   Wed, 4 Nov 2020 12:30:06 +0530
Message-ID: <1604473206-32573-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fff4884d-a3a5-45f4-83f5-08d8808f6731
X-MS-TrafficTypeDiagnostic: CH2PR02MB6262:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6262170781CB0960275B8627C7EF0@CH2PR02MB6262.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQFbT1Q2kFiwzG9flrElDpZtdreUjMCLmRVB3SSbt/3Lm27IISMbqXo8bVHoUZX+crKodMrx5+tXjuoEjvIi1P0BIXD2c1ghq3fS+oJ7rc4Orj9jv4LOaChJezvPgsfgQNfqI5rsfqiJqH4YTre5s2ZXw9uEI9is32k0+HgdB2yN8a376b7G+nIVAxhsHgJbWgEartRDJ03uCct7sPckIk8FW9pu47aqz/94HeqUvg7fnTc6NKwd/x7oQF0EegodAbW5TgtZYnUD8F0TN0cSQviJqlJHsw9ldoPlFH9ziP5+4BNT3J2pdFhd+6rVv7wvgC2sAnK7Sf8zg+0s1iPImAygzcUwLCoY+9eufsSzY2sARA8VZhuHVtkgTCkpb340nJU8jeD8WFSbkhWXPlzUEyT6CVSqf1tPJ2ImcnMYjjVsMIlr1xxJK76nBYBc4J8V
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39850400004)(46966005)(2906002)(6266002)(107886003)(83380400001)(26005)(54906003)(82310400003)(36756003)(110136005)(316002)(42186006)(4326008)(5660300002)(36906005)(186003)(2616005)(336012)(478600001)(426003)(7636003)(47076004)(8936002)(82740400003)(356005)(70586007)(70206006)(8676002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 07:01:07.2202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff4884d-a3a5-45f4-83f5-08d8808f6731
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6262
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Matthew Murrian <matthew.murrian@goctsi.com>

The SG capability is inherently present with Multichannel DMA operation.
The register used to check for this capability with other DMA driver types
is not defined for MCDMA.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Signed-off-by: Matthew Murrian <matthew.murrian@goctsi.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ade4e6e1a5bd..993297d585c0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2875,10 +2875,11 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
-	/* check if SG is enabled (only for AXIDMA and CDMA) */
+	/* check if SG is enabled (only for AXIDMA, AXIMCDMA, and CDMA) */
 	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
-		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
-		    XILINX_DMA_DMASR_SG_MASK)
+		if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA ||
+		    dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+			    XILINX_DMA_DMASR_SG_MASK)
 			chan->has_sg = true;
 		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
 			chan->has_sg ? "enabled" : "disabled");
-- 
2.7.4

