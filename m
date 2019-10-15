Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A03D7919
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfJOOtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:49:06 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:42643
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732910AbfJOOsw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBLLf2xOCva7tpSC3KPEiq8eJ2Ou0B7pEQtZrGTTiOEFM1mCGdsinCf5QznGramvELwNwe81zqmNUgMyDVG8nGb9SGqi1oB0NlEvS1bAqk3gNCaJtpIM0JS30GVLB06yXTfia8hrmb/YckRaGWuj6R5NhH0sOADLBVYx0tLKowZcvhmlY3wO1sj4tPsq4s3W/owZqHkzNzVtjqu5V4iJ/Kw8OOPYob/0LwQ157i02OdxKv3j26imlV1j1KE4wBp6+4GZkZeHreCRN7eLDvqmbr7mRvNqql6nsHOo2QpHT5SG6J9zrsm4VvymbjhEnJCSr91B6+AiwEt7JvNglKDKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/GDZoOGTFYcW0RFnnBR93zbGVenL56/HcQzhld0CNo=;
 b=hp9wzhzNiaVtF+K3RTgQQIj0VpKPZxMUFy3Xa3jHaohhj7XSh3VopXu5tfb6AfphBNTOU8NAcVXqOehaJWlpqeLR1J9bVlTdzFvLn2I1qdY2uvUg/3EbZjAHYpi15x7OGTqiExuzKRZ4mcUL/FnSf4vC5Xhh0hofvEZBD3iY/rTl6YCp0tUBQp+oid+gJUts0oRxLz3kLWLKN32Pypq0ATUEZS8F7rEyJjNcu1X27sv63lPipSICpm7zW4oBeYhyFWYI3H7HYsZgdQ2eVwT0fOl82HQTet82RGGI93rDqxylU3IEZlnWxCr7frZVmZ2Pex/BXA0wHQwfnMtsozsuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/GDZoOGTFYcW0RFnnBR93zbGVenL56/HcQzhld0CNo=;
 b=ffCe6XC7HN+6OaZCfva8NA76OT5v3YDJj/gKdlt0mXDw8C6CItt8X+fBYTJEbk6GZf9+1ltbErever4zicfAXQIa/2EGbROISXTAX0FEzPVH/6ttVJotejBpXaoTFotGl1cxsy8nunkh3nvbLK13DqFQdgbt9e3UsqaJA/Lu+1M=
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by SN6PR02MB5678.namprd02.prod.outlook.com (2603:10b6:805:ed::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 14:48:48 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7z-0006Fw-Bh; Tue, 15 Oct 2019 07:48:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002AU-6k; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmfGS014663;
        Tue, 15 Oct 2019 07:48:41 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7s-00029Y-Qc; Tue, 15 Oct 2019 07:48:41 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 10CF710112E; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 4/7] dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue
Date:   Tue, 15 Oct 2019 20:18:21 +0530
Message-Id: <1571150904-3988-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-0.182-7.0-31-1
X-imss-scan-details: No-0.182-7.0-31-1;No-0.182-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(446003)(426003)(5660300002)(186003)(11346002)(2616005)(336012)(76176011)(48376002)(486006)(51416003)(26005)(476003)(126002)(478600001)(107886003)(8936002)(50226002)(6266002)(103686004)(4326008)(2906002)(305945005)(356004)(6666004)(8676002)(316002)(106002)(16586007)(42186006)(47776003)(50466002)(36756003)(70206006)(70586007)(14444005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5678;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bcc0ce-fb7e-4b94-5182-08d7517ec929
X-MS-TrafficTypeDiagnostic: SN6PR02MB5678:
X-Microsoft-Antispam-PRVS: <SN6PR02MB56788CA0D7D648C87E84BADEC7930@SN6PR02MB5678.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99FLAAdk2TROhsr+ELFfk8f55IaupzPy4HmS8zEY1li9hK+tFUvT4DRXcrdlRdJlXt535cM6vtALdPKX9wR0JPV61gyxR9Xlb29IVGfDUBx+1vfNnbe8ruJ3pCO/SYFXHw8mf6HqQw7sv8t5ao/d9MQ4bu3s4sdpOsKyU8MWgNASfYUaOgx/1wQSwy8CkpcuLvM31pk5TZss4S/+Xi4CckdA/508Fu4TTTvBn4H/xAZQADmdHT9st4S2t5q6S9vIl8LEj8/L8ej0QOztAWab0qHZ8Q/03u3/08V2KUV/R1SkXKJltLTLtfzm18uUxebUqTzEd8O0nPC9v+iOSiFVT7wtfAwZRjXtY1ZWtnY9VK2IdTHiIUhS68qSY3fDEpp+ftciCrcpYszSNwUDixvgDnT0p/ONussbPYL/HTV0X2Y=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:47.7380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bcc0ce-fb7e-4b94-5182-08d7517ec929
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5678
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
Changes for v2:
Fix merge failure due to changes in previous patch.
Invoke xilinx_dma_get_residue only for valid combination.
Fix multi-line comment style.
---
 drivers/dma/xilinx/xilinx_dma.c | 71 +++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 809e638..8c10686 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -788,6 +788,44 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
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
@@ -996,8 +1034,6 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
 	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_axidma_tx_segment *segment;
-	struct xilinx_axidma_desc_hw *hw;
 	enum dma_status ret;
 	unsigned long flags;
 	u32 residue = 0;
@@ -1006,22 +1042,20 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
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
+	/*
+	 * VDMA and simple mode do not support residue reporting, so the
+	 * residue field will always be 0.
+	 */
+	if (chan->has_sg && chan->xdev->dma_config->dmatype != XDMA_TYPE_VDMA)
+		residue = xilinx_dma_get_residue(chan, desc);
 
-		dma_set_residue(txstate, residue);
-	}
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	dma_set_residue(txstate, residue);
 
 	return ret;
 }
@@ -2713,12 +2747,15 @@ static int xilinx_dma_probe(struct platform_device *pdev)
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

