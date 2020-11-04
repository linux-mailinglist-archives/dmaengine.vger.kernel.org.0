Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1D2A5E75
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 08:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKDHAz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 02:00:55 -0500
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:60801
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgKDHAz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Nov 2020 02:00:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdgIeS4tduuzxo8x5M8AV1eSqOkvH34mGPWUIdP/Rt3kkpj5foxMDTswdfdNAla/IZeezMXGr3HpM3C6HXS5MAUVaAgmQWHKLbagqJj2EtvptjDeoGedT49Q3bPkIznhkUiMcedWU6EgQ+ThPMmAoxa7RnM9q4GCEDf6zVVEd+07Npoyf4vT7JsIiMepB+4sZYlfkOt8ftFGyVVPhghbfD72ttZ1y6nguw1QWn7bIsBj9ZmOXHXwd2cnQrrnrGqJeVfi0gbMX81o4QxEGWf9CyWX6af/VY4jm18V8gfhT6otGSNFqHr4oWst2xntQK4/CP+D67ddCGpe2g6FPU93bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0p4q7zESNWI1sJ9RKF6dV+L9yYwqyVSRjCh1w3mFvk=;
 b=ZM4lnuPWZyFAStO8KTT+YawpYN856zfEvGPjLlNma1zdtrcpSmZGy0ohZ3FsW750kNGQZUH9MYM4vDl2aVvPijb+vFVbGh0JcJW0hR2pfBuz/07gd7SuCpUTRLbFOGhUjsaTlOr+g75unlydktlpgfWvVQWKpD7fe/ngh7j5Mbqn4PUBJ8J4KP1uH9Jo+hsNpGVPhEKRJUDJYJbXuiONVjxjaZOula1noxO9liivp0zVUKDTEKZlH6aOBcWSUeQpJR5+mAjOLtv6B2wnFrN6+aGmYolUbcgU0AYbx26SKBo4rsqS22RYBaKYDGGwHWmnoDYb+YGirEuIwba4X1/ZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0p4q7zESNWI1sJ9RKF6dV+L9yYwqyVSRjCh1w3mFvk=;
 b=M9B07P81+a9xmAc5cfvYRR1FAk4EyyFh5qXDl24MIQ4TLIWlqlyhiROLN7Oa3OJPsMdqf7adAbBWdChxrinj/BavnWFaoLBKXPyzDnAPKglKnJPY1295rEivbhbLGGxBQxM6YcAeQhAkTzTb63yb6EScZMryFWWqWo5JBoYW7ys=
Received: from CY4PR1101CA0003.namprd11.prod.outlook.com
 (2603:10b6:910:15::13) by BN6PR02MB3313.namprd02.prod.outlook.com
 (2603:10b6:405:6c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 07:00:51 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::de) by CY4PR1101CA0003.outlook.office365.com
 (2603:10b6:910:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 07:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 07:00:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 23:00:36 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 3 Nov 2020 23:00:36 -0800
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
Received: from [172.23.64.106] (port=53860 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kaCmZ-0005kM-9Z; Tue, 03 Nov 2020 23:00:35 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 17C7D1213FA; Wed,  4 Nov 2020 12:30:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Matthew Murrian <matthew.murrian@goctsi.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/3] dmaengine: xilinx_dma: Fix usage of xilinx_aximcdma_tx_segment
Date:   Wed, 4 Nov 2020 12:30:05 +0530
Message-ID: <1604473206-32573-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1604473206-32573-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 739ab775-5736-4b83-8d95-08d8808f5d6d
X-MS-TrafficTypeDiagnostic: BN6PR02MB3313:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3313F8EE482B25884B19466FC7EF0@BN6PR02MB3313.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OqSa+C/HFvQpr7X9qusqU1GfAZouaT3bZux2T79TGy00PQdBi9AYI6LeUoj+pyb07afZ3slZYVAfwfpOYcIVJ+r7WB7rT48OqXKt+SuPrKiDv+RuCTAX6FQfX4rjRFVnsDoau6k+5O+9JbH8em8EM4/nARuZPTXpS2JyAWc4bCIwlbZKv78Lcc5Q1pUVdAlPaJuPlpOdF7KdplT+p1C/txC+8sEeC5TYe7fC+y6KVXkPLmrjTQ6plJ4O2efOsa9tvD6vzNdXwsm5F2dxdMwYTJ6lBX8Jy+RKDnJyNZTsuQ6ER2KfCvFLgqw68LZIUhAoo96KN9uFu4BvZOZIp2Jmbd4Lwszd6YhvAQrmK1sOJhZneWDxmh6QGd9nYx2pDTYMbNdJUunSnuuzGKCfFoGGyASxQ8dshHogzDI9/TAKtqnnuZptHpxWEMwNyFdPvKm
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966005)(356005)(7636003)(82740400003)(6666004)(5660300002)(36906005)(2906002)(36756003)(316002)(42186006)(70586007)(54906003)(70206006)(336012)(8936002)(110136005)(2616005)(426003)(6266002)(107886003)(26005)(478600001)(186003)(47076004)(83380400001)(4326008)(8676002)(82310400003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 07:00:50.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739ab775-5736-4b83-8d95-08d8808f5d6d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3313
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Matthew Murrian <matthew.murrian@goctsi.com>

Several code sections incorrectly use struct xilinx_axidma_tx_segment
instead of struct xilinx_aximcdma_tx_segment when operating as
Multichannel DMA. As their structures are similar, this just works.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Signed-off-by: Matthew Murrian <matthew.murrian@goctsi.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 9c747b08bb0f..ade4e6e1a5bd 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -948,8 +948,10 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 {
 	struct xilinx_cdma_tx_segment *cdma_seg;
 	struct xilinx_axidma_tx_segment *axidma_seg;
+	struct xilinx_aximcdma_tx_segment *aximcdma_seg;
 	struct xilinx_cdma_desc_hw *cdma_hw;
 	struct xilinx_axidma_desc_hw *axidma_hw;
+	struct xilinx_aximcdma_desc_hw *aximcdma_hw;
 	struct list_head *entry;
 	u32 residue = 0;
 
@@ -961,13 +963,23 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 			cdma_hw = &cdma_seg->hw;
 			residue += (cdma_hw->control - cdma_hw->status) &
 				   chan->xdev->max_buffer_len;
-		} else {
+		} else if (chan->xdev->dma_config->dmatype ==
+			   XDMA_TYPE_AXIDMA) {
 			axidma_seg = list_entry(entry,
 						struct xilinx_axidma_tx_segment,
 						node);
 			axidma_hw = &axidma_seg->hw;
 			residue += (axidma_hw->control - axidma_hw->status) &
 				   chan->xdev->max_buffer_len;
+		} else {
+			aximcdma_seg =
+				list_entry(entry,
+					   struct xilinx_aximcdma_tx_segment,
+					   node);
+			aximcdma_hw = &aximcdma_seg->hw;
+			residue +=
+				(aximcdma_hw->control - aximcdma_hw->status) &
+				chan->xdev->max_buffer_len;
 		}
 	}
 
@@ -1135,7 +1147,7 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
 				((i + 1) % XILINX_DMA_NUM_DESCS));
 			chan->seg_mv[i].phys = chan->seg_p +
-				sizeof(*chan->seg_v) * i;
+				sizeof(*chan->seg_mv) * i;
 			list_add_tail(&chan->seg_mv[i].node,
 				      &chan->free_seg_list);
 		}
@@ -1560,7 +1572,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
-	struct xilinx_axidma_tx_segment *tail_segment;
+	struct xilinx_aximcdma_tx_segment *tail_segment;
 	u32 reg;
 
 	/*
@@ -1582,7 +1594,7 @@ static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_desc = list_last_entry(&chan->pending_list,
 				    struct xilinx_dma_tx_descriptor, node);
 	tail_segment = list_last_entry(&tail_desc->segments,
-				       struct xilinx_axidma_tx_segment, node);
+				       struct xilinx_aximcdma_tx_segment, node);
 
 	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest));
 
@@ -1864,6 +1876,7 @@ static void append_desc_queue(struct xilinx_dma_chan *chan,
 	struct xilinx_vdma_tx_segment *tail_segment;
 	struct xilinx_dma_tx_descriptor *tail_desc;
 	struct xilinx_axidma_tx_segment *axidma_tail_segment;
+	struct xilinx_aximcdma_tx_segment *aximcdma_tail_segment;
 	struct xilinx_cdma_tx_segment *cdma_tail_segment;
 
 	if (list_empty(&chan->pending_list))
@@ -1885,11 +1898,17 @@ static void append_desc_queue(struct xilinx_dma_chan *chan,
 						struct xilinx_cdma_tx_segment,
 						node);
 		cdma_tail_segment->hw.next_desc = (u32)desc->async_tx.phys;
-	} else {
+	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		axidma_tail_segment = list_last_entry(&tail_desc->segments,
 					       struct xilinx_axidma_tx_segment,
 					       node);
 		axidma_tail_segment->hw.next_desc = (u32)desc->async_tx.phys;
+	} else {
+		aximcdma_tail_segment =
+			list_last_entry(&tail_desc->segments,
+					struct xilinx_aximcdma_tx_segment,
+					node);
+		aximcdma_tail_segment->hw.next_desc = (u32)desc->async_tx.phys;
 	}
 
 	/*
-- 
2.7.4

