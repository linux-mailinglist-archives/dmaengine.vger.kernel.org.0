Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33AEE09F3
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfJVRAu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:00:50 -0400
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:35018
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732905AbfJVRAt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1V4ro69sbx9bfcqXMtYOrsG6bBfwIVVcINP4v1aU6YAshe3CDYIZ0oQm0LedyHt78+g6QqWSP7UuqtKh02R9UP5jIdFcyufT1Dt2E2zwUEH3hfPxGQCcK3eY1tcQr+rdVhCsgB10s9U5inpWWpwrik+uHcFX8Mwt8nE1mOeaKKIhO+h84FdLq0WbvwfP3eeLNvGarM/cB0iXNQUSKty6RbFzJuuRXOs/rneKrrzq0V/V9qoahnazZD2prAKWgse6nELWSrQU60c5AWxW4kNxTrWL+yXSnteJlBsJOr8Ok2QGb5Bl43IudNbdb4SqvYH4EXIwTNXx4X0SYBfKu3CwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STPhDd0jQgFVB0lgoRg+PmMuNGbpy8LPMhupL0SpIik=;
 b=NkmSNQqvlzNSCufS2PWI6/GxzrkyGNrP7R7lvlSuN/zh3WDAKuUIuEBax5RXseJLP+/5tVw4JtIIfV4iY+m8gutgLLKXwxBq58JtXmwRdoPkB9e4Fzs16QJCX7TScDwDAOnuug3Tpop5TiSgtz2kSlHtYbK97Pxe80niEgddo2Lo9ymtYt1s1Rg3JW2Hy7OX+fObN6HV3WhCpwYcUAbodQkNoCxlOCqjoX1TUbIrfG4tybVX2SkQFFrxBoLtgLZ7T4TLPzpSX1Dq88bmeQA2ItEfoB+F+B5aEuW69AW18b8/IU3Q8u+f/kUqtWBl81HEK+xvo/PbqyO3YRtCOlUSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STPhDd0jQgFVB0lgoRg+PmMuNGbpy8LPMhupL0SpIik=;
 b=mmwQ4HHeTY2QkhS1wz6Qt9K2qhy5QjNQPyqKjuD98yylDII8hEd2sZmXqlssWONXTUBGsS9mgaNRqUb4V5IcMT/c40ePC3iRke54tWBPjD3WunJ7WWOB2QKvNzkvF1lABbEbuOmlqrXDGlU+/ZR3Ranl8hHNLoIG6qKywkYUXy8=
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by DM6PR02MB5163.namprd02.prod.outlook.com (2603:10b6:5:51::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Tue, 22 Oct
 2019 17:00:42 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWT-0006An-Gk; Tue, 22 Oct 2019 10:00:41 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWO-0005Eb-8S; Tue, 22 Oct 2019 10:00:36 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0W9A022062;
        Tue, 22 Oct 2019 10:00:33 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWJ-00059l-KQ; Tue, 22 Oct 2019 10:00:32 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id D455B101130; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 4/6] dmaengine: xilinx_dma: Remove axidma multichannel mode support
Date:   Tue, 22 Oct 2019 22:30:20 +0530
Message-Id: <1571763622-29281-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.138-7.0-31-1
X-imss-scan-details: No--4.138-7.0-31-1;No--4.138-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(47776003)(50226002)(478600001)(2906002)(48376002)(50466002)(8936002)(103686004)(6266002)(107886003)(356004)(7416002)(106002)(16586007)(486006)(70206006)(42186006)(316002)(336012)(5660300002)(81156014)(305945005)(14444005)(6666004)(36756003)(186003)(51416003)(426003)(26005)(70586007)(11346002)(76176011)(476003)(4326008)(81166006)(2616005)(8676002)(446003)(126002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5163;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a455a5fa-fcd4-4e38-e5f7-08d757115f4c
X-MS-TrafficTypeDiagnostic: DM6PR02MB5163:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5163EC460EF36693C8EE742AC7680@DM6PR02MB5163.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SyB+nnOQY/5VkwwdENdf7M/F8JmhhWfVufKU2WmEaJxIxll2SNZJy1AD5XETytoIl9WCZBl8XicB7XV9h/qiq75UoL01kONlMFCOr16sU/yAMyrfzO+p7E1wP+KdEhCbU9YOKPKt5aiMo/AqKqbMjHKQ5Ji9NhUmKXntoVTi6TffTXFN31cUykYzYFr0HoOGoiRTp+OV/U9AdB1zNrsYMGIpo0Oc85IoZcZZop4zNyidSHfsZ6xFGVjxIgbdlHGICm+T91oKtez3NDz708bGY2eJ6DpACM0BwWbcqnuGKvQmzHgYoDKdjx9nQ40Oa427/mCTf5qRG6P03YGyPX5lSjzFdE4YE98XSvJThlEgyZaJlKG49rCep/xElpBRA2Oez89MT+Kq0gSlAayW5EkDoCGy/4coxewwlMAQU9Rkzr8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:41.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a455a5fa-fcd4-4e38-e5f7-08d757115f4c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5163
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The AXI DMA multichannel support is deprecated in the IP and it is no
longer actively supported. For multichannel support, refer to the AXI
multichannel direct memory access IP product guide(PG228) and MCDMA
driver. So inline with it remove axidma multichannel support from
from the driver.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes since RFC:
New patch.
---
 drivers/dma/xilinx/xilinx_dma.c | 155 +++-------------------------------------
 1 file changed, 8 insertions(+), 147 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 41189b6..6d45865 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -116,7 +116,7 @@
 #define XILINX_VDMA_ENABLE_VERTICAL_FLIP	BIT(0)
 
 /* HW specific definitions */
-#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
+#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x2
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -170,18 +170,6 @@
 #define XILINX_DMA_NUM_DESCS		255
 #define XILINX_DMA_NUM_APP_WORDS	5
 
-/* Multi-Channel DMA Descriptor offsets*/
-#define XILINX_DMA_MCRX_CDESC(x)	(0x40 + (x-1) * 0x20)
-#define XILINX_DMA_MCRX_TDESC(x)	(0x48 + (x-1) * 0x20)
-
-/* Multi-Channel DMA Masks/Shifts */
-#define XILINX_DMA_BD_HSIZE_MASK	GENMASK(15, 0)
-#define XILINX_DMA_BD_STRIDE_MASK	GENMASK(15, 0)
-#define XILINX_DMA_BD_VSIZE_MASK	GENMASK(31, 19)
-#define XILINX_DMA_BD_TDEST_MASK	GENMASK(4, 0)
-#define XILINX_DMA_BD_STRIDE_SHIFT	0
-#define XILINX_DMA_BD_VSIZE_SHIFT	19
-
 /* AXI CDMA Specific Registers/Offsets */
 #define XILINX_CDMA_REG_SRCADDR		0x18
 #define XILINX_CDMA_REG_DSTADDR		0x20
@@ -218,8 +206,8 @@ struct xilinx_vdma_desc_hw {
  * @next_desc_msb: MSB of Next Descriptor Pointer @0x04
  * @buf_addr: Buffer address @0x08
  * @buf_addr_msb: MSB of Buffer address @0x0C
- * @mcdma_control: Control field for mcdma @0x10
- * @vsize_stride: Vsize and Stride field for mcdma @0x14
+ * @reserved1: Reserved @0x10
+ * @reserved2: Reserved @0x14
  * @control: Control field @0x18
  * @status: Status field @0x1C
  * @app: APP Fields @0x20 - 0x30
@@ -229,8 +217,8 @@ struct xilinx_axidma_desc_hw {
 	u32 next_desc_msb;
 	u32 buf_addr;
 	u32 buf_addr_msb;
-	u32 mcdma_control;
-	u32 vsize_stride;
+	u32 reserved1;
+	u32 reserved2;
 	u32 control;
 	u32 status;
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
@@ -346,7 +334,6 @@ struct xilinx_dma_tx_descriptor {
  * @cyclic_seg_p: Physical allocated segments base for cyclic dma
  * @start_transfer: Differentiate b/w DMA IP's transfer
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
- * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
  */
 struct xilinx_dma_chan {
@@ -382,7 +369,6 @@ struct xilinx_dma_chan {
 	dma_addr_t cyclic_seg_p;
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
-	u16 tdest;
 	bool has_vflip;
 };
 
@@ -413,7 +399,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
  * @pdev: Platform device structure pointer
@@ -432,7 +417,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
 	struct platform_device  *pdev;
@@ -1344,53 +1328,23 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
-	if (chan->has_sg && !chan->xdev->mcdma)
+	if (chan->has_sg)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 
-	if (chan->has_sg && chan->xdev->mcdma) {
-		if (chan->direction == DMA_MEM_TO_DEV) {
-			dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
-				       head_desc->async_tx.phys);
-		} else {
-			if (!chan->tdest) {
-				dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
-				       head_desc->async_tx.phys);
-			} else {
-				dma_ctrl_write(chan,
-					XILINX_DMA_MCRX_CDESC(chan->tdest),
-				       head_desc->async_tx.phys);
-			}
-		}
-	}
-
 	xilinx_dma_start(chan);
 
 	if (chan->err)
 		return;
 
 	/* Start the transfer */
-	if (chan->has_sg && !chan->xdev->mcdma) {
+	if (chan->has_sg) {
 		if (chan->cyclic)
 			xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
 				     chan->cyclic_seg_v->phys);
 		else
 			xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
 				     tail_segment->phys);
-	} else if (chan->has_sg && chan->xdev->mcdma) {
-		if (chan->direction == DMA_MEM_TO_DEV) {
-			dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-			       tail_segment->phys);
-		} else {
-			if (!chan->tdest) {
-				dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-					       tail_segment->phys);
-			} else {
-				dma_ctrl_write(chan,
-					XILINX_DMA_MCRX_TDESC(chan->tdest),
-					tail_segment->phys);
-			}
-		}
 	} else {
 		struct xilinx_axidma_tx_segment *segment;
 		struct xilinx_axidma_desc_hw *hw;
@@ -2017,90 +1971,6 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 }
 
 /**
- * xilinx_dma_prep_interleaved - prepare a descriptor for a
- *	DMA_SLAVE transaction
- * @dchan: DMA channel
- * @xt: Interleaved template pointer
- * @flags: transfer ack flags
- *
- * Return: Async transaction descriptor on success and NULL on failure
- */
-static struct dma_async_tx_descriptor *
-xilinx_dma_prep_interleaved(struct dma_chan *dchan,
-				 struct dma_interleaved_template *xt,
-				 unsigned long flags)
-{
-	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
-	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_axidma_tx_segment *segment;
-	struct xilinx_axidma_desc_hw *hw;
-
-	if (!is_slave_direction(xt->dir))
-		return NULL;
-
-	if (!xt->numf || !xt->sgl[0].size)
-		return NULL;
-
-	if (xt->frame_size != 1)
-		return NULL;
-
-	/* Allocate a transaction descriptor. */
-	desc = xilinx_dma_alloc_tx_descriptor(chan);
-	if (!desc)
-		return NULL;
-
-	chan->direction = xt->dir;
-	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
-	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
-
-	/* Get a free segment */
-	segment = xilinx_axidma_alloc_tx_segment(chan);
-	if (!segment)
-		goto error;
-
-	hw = &segment->hw;
-
-	/* Fill in the descriptor */
-	if (xt->dir != DMA_MEM_TO_DEV)
-		hw->buf_addr = xt->dst_start;
-	else
-		hw->buf_addr = xt->src_start;
-
-	hw->mcdma_control = chan->tdest & XILINX_DMA_BD_TDEST_MASK;
-	hw->vsize_stride = (xt->numf << XILINX_DMA_BD_VSIZE_SHIFT) &
-			    XILINX_DMA_BD_VSIZE_MASK;
-	hw->vsize_stride |= (xt->sgl[0].icg + xt->sgl[0].size) &
-			    XILINX_DMA_BD_STRIDE_MASK;
-	hw->control = xt->sgl[0].size & XILINX_DMA_BD_HSIZE_MASK;
-
-	/*
-	 * Insert the segment into the descriptor segments
-	 * list.
-	 */
-	list_add_tail(&segment->node, &desc->segments);
-
-
-	segment = list_first_entry(&desc->segments,
-				   struct xilinx_axidma_tx_segment, node);
-	desc->async_tx.phys = segment->phys;
-
-	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
-	if (xt->dir == DMA_MEM_TO_DEV) {
-		segment->hw.control |= XILINX_DMA_BD_SOP;
-		segment = list_last_entry(&desc->segments,
-					  struct xilinx_axidma_tx_segment,
-					  node);
-		segment->hw.control |= XILINX_DMA_BD_EOP;
-	}
-
-	return &desc->async_tx;
-
-error:
-	xilinx_dma_free_tx_descriptor(chan, desc);
-	return NULL;
-}
-
-/**
  * xilinx_dma_terminate_all - Halt the channel and free descriptors
  * @dchan: Driver specific DMA Channel pointer
  *
@@ -2492,7 +2362,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
 		chan->id = chan_id;
-		chan->tdest = chan_id;
 
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2509,7 +2378,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 					   "xlnx,axi-dma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
-		chan->tdest = chan_id - xdev->nr_channels;
 		chan->has_vflip = of_property_read_bool(node,
 					"xlnx,enable-vert-flip");
 		if (chan->has_vflip) {
@@ -2597,11 +2465,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 				    struct device_node *node)
 {
-	int ret, i, nr_channels = 1;
-
-	ret = of_property_read_u32(node, "dma-channels", &nr_channels);
-	if ((ret < 0) && xdev->mcdma)
-		dev_warn(xdev->dev, "missing dma-channels property\n");
+	int i, nr_channels = 1;
 
 	for (i = 0; i < nr_channels; i++)
 		xilinx_dma_chan_probe(xdev, node, xdev->chan_id++);
@@ -2700,7 +2564,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
 		if (!of_property_read_u32(node, "xlnx,sg-length-width",
 					  &len_width)) {
 			if (len_width < XILINX_DMA_MAX_TRANS_LEN_MIN ||
@@ -2765,8 +2628,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
 		xdev->common.device_prep_dma_cyclic =
 					  xilinx_dma_prep_dma_cyclic;
-		xdev->common.device_prep_interleaved_dma =
-					xilinx_dma_prep_interleaved;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
-- 
2.7.4

