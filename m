Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5EAA928
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfIEQhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:35 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:17044
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389084AbfIEQhd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeSbBbASHM3fg7jeuh1/M3xcnyn4ziJGqhyiVrvN8/MiBJv1bM7IhdqeKshuOxds4B0m7nh9FDlTJNI1GLckjlaH5TekwzFvrbSBzlHUdWZKhIAf64SiPO8C+BmNlP4a+AcRCsTjIubOrvkeWpjvz7snfxGY/0JNbNaTA6dnI9G0cgc/E+sVQoPcrp6DKhDWUBbECch9DMlbf8fkdlq/eEV7nmm7N0RKeHF9g55EnV6Z2uxF27QYPV2csiPFRGz+0bmbs53KSOuHCLZ3r2/3XhTiphSJfB2/ZpTxAXg4aaTFFJ/SgxSdUwkSOBntU35P2+RGa/3cqnQiT7urjZnb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n32IkJ61qyKd+whj2ngkMtbGtf4WAxbDeIcsprmpa2g=;
 b=dCECMDIqKzOoAOTGJApPvTqSssVTiDcrfuwYlFFuSO3U0umuPnsJQeZ8k1HQ6SxJPmMUkGUYa5Tgles9WJlj61OZo3Mhu90tzSbpsG2ufHBpn954AR/GNN+CDS6E6BQRNYTjqd/OFu66ygm/MeBEnzDU27Xqwj+zdAseeDpCiKiL3KHoHB+u5Q+5iMQUgNaxpfwD6q5CqUuyXfdsFDK/mrivmHJI8phcSn/lUOiWxbvYZjpn+RsqIYUhC+u64bH3NMOtx6t+YG5SD5DSvMazjLUQkLvnAAm/1bLeUPBaeoVVCdIx27rGLss76wOzlR5F+GayCxPOfKRWpogKBQM9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n32IkJ61qyKd+whj2ngkMtbGtf4WAxbDeIcsprmpa2g=;
 b=ayEZQAsw08yxj8AqGtmngJj98r4gIS/6YttLNaXCcPEswnb4Jo3nGg9HE2J8Gq9ngva9FZ8QSWE+zyrlGw6feEYf1LigHhn1Ij3NWSWnXw2Ub1RYzliCmNgwlvstwrH2yTVYILAaAT9EDwGe93fSCIl27FigaHYR3D0+BREQDPQ=
Received: from CY4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:903:18::29)
 by DM6PR02MB5323.namprd02.prod.outlook.com (2603:10b6:5:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16; Thu, 5 Sep
 2019 16:37:30 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR02CA0019.outlook.office365.com
 (2603:10b6:903:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59454 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fT-9p; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul7-0006wo-V0; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbKFB015557;
        Thu, 5 Sep 2019 09:37:20 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul6-0006wH-18; Thu, 05 Sep 2019 09:37:20 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 444A110106F; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue
Date:   Thu,  5 Sep 2019 22:06:59 +0530
Message-Id: <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.631-7.0-31-1
X-imss-scan-details: No--0.631-7.0-31-1;No--0.631-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(316002)(2906002)(53936002)(4326008)(6266002)(52956003)(81166006)(14444005)(81156014)(8676002)(103686004)(36756003)(107886003)(5660300002)(76176011)(70206006)(6666004)(51416003)(186003)(356004)(47776003)(70586007)(50466002)(305945005)(478600001)(50226002)(16586007)(106002)(42186006)(8936002)(486006)(11346002)(126002)(476003)(2616005)(26005)(446003)(48376002)(336012)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5fd3562-d740-42c6-d031-08d7321f5738
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5323;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5323:
X-Microsoft-Antispam-PRVS: <DM6PR02MB53231713E01FF2D478A007DDC7BB0@DM6PR02MB5323.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 83jc8wJAT4F9PuyauBRXB39Ci0//b/OFwyvW7jRIxDo1AC208QZlHqfFL9U8AE4MSQrOaSPSYDXC8uuL7D+0fzA4t7sTU1F0UfYjb0KboH00Dv6sVHjPqVUWe69XpS6keIstoUsrePIi3x04C1rVy3Igj+TZ9a8+iPkiFx0CDzU8VUSy/PeH0O4ca3kZxcAhTGLCnaWKKJ/NFC/wen6F50fT0XdlTZkIQN9NW/jB8K3O3IE06GGrts4FcR5+n/6T++zIPbu95quuMyykTT8y3/kq2yJxiDGEdewKpYHPR8fV7NcGUQmNy0LtQefJAeX+NfKvJgHR0KtIk1vxmEoPKXHF4b2Ar1NspoLnaBV9Y1743v/EepRkcEHNUNeDA+eY7OOceh7LOm5oU8SvKQCup9sj830XoIQH0ThyRAyXCc0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fd3562-d740-42c6-d031-08d7321f5738
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5323
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

Introduce a function that can calculate residues for IPs that support it:
AXI DMA and CDMA.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 75 ++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 9909bfb..4094adb 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -787,6 +787,51 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 }
 
 /**
+ * xilinx_dma_get_residue - Compute residue for a given descriptor
+ * @chan: Driver specific dma channel
+ * @desc: dma transaction descriptor
+ *
+ * Return: The number of residue bytes for the descriptor.
+ */
+static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
+				  struct xilinx_dma_tx_descriptor *desc)
+{
+	struct xilinx_cdma_tx_segment *cdma_seg;
+	struct xilinx_axidma_tx_segment *axidma_seg;
+	struct xilinx_cdma_desc_hw *cdma_hw;
+	struct xilinx_axidma_desc_hw *axidma_hw;
+	struct list_head *entry;
+	u32 residue = 0;
+
+	/**
+	 * VDMA and simple mode do not support residue reporting, so the
+	 * residue field will always be 0.
+	 */
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_VDMA || !chan->has_sg)
+		return residue;
+
+	list_for_each(entry, &desc->segments) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
+			cdma_seg = list_entry(entry,
+					      struct xilinx_cdma_tx_segment,
+					      node);
+			cdma_hw = &cdma_seg->hw;
+			residue += (cdma_hw->control - cdma_hw->status) &
+				   chan->xdev->max_buffer_len;
+		} else {
+			axidma_seg = list_entry(entry,
+						struct xilinx_axidma_tx_segment,
+						node);
+			axidma_hw = &axidma_seg->hw;
+			residue += (axidma_hw->control - axidma_hw->status) &
+				   chan->xdev->max_buffer_len;
+		}
+	}
+
+	return residue;
+}
+
+/**
  * xilinx_dma_chan_handle_cyclic - Cyclic dma callback
  * @chan: Driver specific dma channel
  * @desc: dma transaction descriptor
@@ -995,33 +1040,22 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
 	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_axidma_tx_segment *segment;
-	struct xilinx_axidma_desc_hw *hw;
 	enum dma_status ret;
 	unsigned long flags;
-	u32 residue = 0;
 
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		spin_lock_irqsave(&chan->lock, flags);
+	spin_lock_irqsave(&chan->lock, flags);
 
-		desc = list_last_entry(&chan->active_list,
-				       struct xilinx_dma_tx_descriptor, node);
-		if (chan->has_sg) {
-			list_for_each_entry(segment, &desc->segments, node) {
-				hw = &segment->hw;
-				residue += (hw->control - hw->status) &
-					   chan->xdev->max_buffer_len;
-			}
-		}
-		spin_unlock_irqrestore(&chan->lock, flags);
+	desc = list_last_entry(&chan->active_list,
+			       struct xilinx_dma_tx_descriptor, node);
+	chan->residue = xilinx_dma_get_residue(chan, desc);
 
-		chan->residue = residue;
-		dma_set_residue(txstate, chan->residue);
-	}
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	dma_set_residue(txstate, chan->residue);
 
 	return ret;
 }
@@ -2701,12 +2735,15 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					  xilinx_dma_prep_dma_cyclic;
 		xdev->common.device_prep_interleaved_dma =
 					xilinx_dma_prep_interleaved;
-		/* Residue calculation is supported by only AXI DMA */
+		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+		/* Residue calculation is supported by only AXI DMA and CDMA */
+		xdev->common.residue_granularity =
+					DMA_RESIDUE_GRANULARITY_SEGMENT;
 	} else {
 		xdev->common.device_prep_interleaved_dma =
 				xilinx_vdma_dma_prep_interleaved;
-- 
2.7.4

