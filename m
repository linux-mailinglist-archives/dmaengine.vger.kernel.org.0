Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634135A512
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhDIR56 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:58 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:51700
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234306AbhDIR56 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVZuYrfQVqnlkT1RsuqUanMeMdL4SPYbHP9v7MUFUY31/e5hrcNskSetljDpx17aa9FSYldyynpHp9T+KRiJ0BkWOcHN0uATwt8DKgKwUdRi/MUplKx2Dh9EUmvU4tCNwexVFbqFwuHYV63/PbAe5lNH/sed7/de1Ss1CwCgFeIOCFSSyYRo41E6DmrhuOPn40nYIK9ZNO2/3z/rfIte/IkntBLr4xWn8Mb0SoYWrxHZQBMG3nDKPp5Crcvl3nosXu1Hsttu3+gYLs2FLAFASeVbnBu0r0fWuo9vTOf90A7y5g9D6t3JYIJsNcZF4DAaonVq+HHpiaYPYVJ2IUDvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtMsiZ+ALraJUyWsRaHs+LEybanjze9WXQG5xp5yJec=;
 b=b40rELR2utNV80kVT1oplCJKM4sBpBVggkU9dGISYoVAxawUdQNj5k7/KtJwBLLDPi8CuvgOvgmWIfZq33QyobEr08W+HQdlHnHPRP78P8DBsooygmFgoPdgAOgTAC5EU9cnnTBSStUbgff2EkyFzVBHnR/nlAT1GK5A1sXoBglFQd1ra9AyondIgTZY7MNxLxEdqGMWqy6loTByABpED1go62Q9F1HLEnUoVzN9Ou7s6E9AFl6Wq+0gbcKSRjjaqKwYVFeSxPT+hbpIxzvCqoGgegNtFiSROyVC/VX7kR/uQZNXuieroqCKmJPgsuMPPENbsy1wRcM88UuaguMGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtMsiZ+ALraJUyWsRaHs+LEybanjze9WXQG5xp5yJec=;
 b=nKceJ0coRsbyeTSMOxN5tgdClRllES3wJOQC8ZN982/Fzce6qJsflSz3tNL4xq4/8Fd2ckpW9e0+3A6PPETo1ug6t+JBuGtDFd7Yt+BzwcCpsIDrCcaIKJN53ZhXQAxWTmfPKdTSt6lpAdccLQrw90i+7bkZv7uHIKTKIv0aLZo=
Received: from SA9PR13CA0155.namprd13.prod.outlook.com (2603:10b6:806:28::10)
 by SN6PR02MB4798.namprd02.prod.outlook.com (2603:10b6:805:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 17:57:43 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::58) by SA9PR13CA0155.outlook.office365.com
 (2603:10b6:806:28::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:57:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:57:27 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33304 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvNm-0001F3-KL; Fri, 09 Apr 2021 10:57:26 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 45E6B122169; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit
Date:   Fri, 9 Apr 2021 23:26:03 +0530
Message-ID: <1617990965-35337-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51441606-d926-49fc-7289-08d8fb80f985
X-MS-TrafficTypeDiagnostic: SN6PR02MB4798:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4798B8881279EE3104853F63C7739@SN6PR02MB4798.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTnS4pR/KsBmwjfT1e9wG05aMek+wDAAMnzXJEyWuGPklEMDFysDcvnfcbxAlXhcLW4trPmyji5AhHDzbxdVlJ7fOql6MFEgQUrk/bMbaPPxBQH7iyPH8U5/fYlTNQ/S5mWoK0mbOjy1+dmnb3FtGwp5hhfxMyrBctR4jVXBwKHHFy5hlTk2tM/u3tnIomxK5b+vPzoYnaOmMo5qYjeo4RaFaXI9Ot7wteb9hUKzP+VsL6vFob244LEa8/wco3FQv3nPfpyHzxq/kTgeyEwfnbatHIoajXVQ6hkbodenyww1ViWUHpR4iBP58unR+FyWIzB5OPHn9JOUkrKIVIQNaGtxq8OYA2TzBQiGxLP22V1Fs3UqgGyWd9XJ1b32J4JJGEFAhRWKsnWir3hoj1csU/jVB3LH3xi/pa1oHcgyB5oa+x+i1tL0j3uiYaSciemXZZZxTDEtWHTDsmCkbPrDMIdIYjgiCBksHjH9YYAe366uEK5/8SGw4JAUBoamHhho3ptEqARxxZQD1BjR5blFlhXX6M79uM9bR/CHR1lTXEeLbYbaPb3WZpdS7ImOF+bLU2vMY50YuI6ZHtQD1oFuOxR3GdkCro3daZvr2ZObTvmvhaFTJhQraNztRvJFf4UdmqUMq8+tAjq6/o8I6n6EQzRW21D+m39LnIh8xHv5y9QBJ1P4Vs8BQXkjb6IDivQq
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(4326008)(7636003)(70586007)(2906002)(70206006)(316002)(36906005)(110136005)(54906003)(5660300002)(82310400003)(36860700001)(42186006)(478600001)(82740400003)(6636002)(8676002)(6266002)(47076005)(8936002)(83380400001)(107886003)(426003)(2616005)(356005)(186003)(26005)(6666004)(336012)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:43.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51441606-d926-49fc-7289-08d8fb80f985
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4798
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AXIDMA IP in SG mode sets completion bit to 1 when the transfer is
completed. Read this bit to move descriptor from active list to the
done list. This feature is needed when interrupt delay timeout and
IRQThreshold is enabled i.e Dly_IrqEn is triggered w/o completing
interrupt threshold.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
- Check BD completion bit only for SG mode.
- Modify the logic to have early return path.
---
 drivers/dma/xilinx/xilinx_dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 890bf46b36e5..f2305a73cb91 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -177,6 +177,7 @@
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
+#define XILINX_DMA_BD_COMP_MASK		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
@@ -1683,12 +1684,18 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc, *next;
+	struct xilinx_axidma_tx_segment *seg;
 
 	/* This function was invoked with lock held */
 	if (list_empty(&chan->active_list))
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		/* TODO: remove hardcoding for axidma_tx_segment */
+		seg = list_last_entry(&desc->segments,
+				      struct xilinx_axidma_tx_segment, node);
+		if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
+			break;
 		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
 		    XDMA_TYPE_VDMA)
 			desc->residue = xilinx_dma_get_residue(chan, desc);
-- 
2.7.4

