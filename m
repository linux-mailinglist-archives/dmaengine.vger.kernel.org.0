Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1D368A66
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhDWBbP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:31:15 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:62202 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240012AbhDWBbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Apr 2021 21:31:13 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N0xc89008391;
        Fri, 23 Apr 2021 02:19:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=/aerMdswcBdXUdPtyIELlqG/XmiUKmqfOxvU96nk1H8=;
 b=Xg0NeUxNesgXoivcZSVFA/4wE0w9kntiYSsfA57d65A5cT6uJ/W/wB61eRXAFzwTwHsV
 sheHtDwsf7MYHT/YjW6/bjg/nhh4bf74wQoO6UTw5xiwp9fGAHV/nI/xsGgITnFx3Nfz
 Opmawvqj5kFIjqfdFkyj4sHYYWqreCnoRwl1uzsAhzwQdsXiOWpBHBamruWIETgobFhn
 +EkbCnJzgvqZ042z7G+LRe4EIvb6XT63YIOwaDeWL/w1WYg6/M/bnRWpoFqiRsKaxqL9
 QSGlYvPwZyIKl+mysGWauFNW66zUOfe8WzeegJ7lWDyFW9EF7wDmGLIEyh6EzW+Nm0tr jA== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 382p9395yh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 02:19:27 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 02:19:25 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 1/4] dmaengine: xilinx_dma: Add extended address support in CDMA
Date:   Fri, 23 Apr 2021 02:19:10 +0100
Message-ID: <20210423011913.13122-2-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 96Hukd_AhqfmLXC6B3tQfskW8E-p_rno
X-Proofpoint-ORIG-GUID: 96Hukd_AhqfmLXC6B3tQfskW8E-p_rno
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Not accounting for this means DMA HW descriptors can only be sourced from
the lower 32 bits of the address space. CDMA MSB descriptor registers were
also missing in the driver file, so this change also adds their register
offset definitions, which were taken from Xilpinx 'AXI Central Direct
Memory Access v4.1' LogiCORE IP Product Guide.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..3f859de593dc 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -98,7 +98,9 @@
 #define XILINX_DMA_DMASR_FRAME_COUNT_MASK	GENMASK(23, 16)
 
 #define XILINX_DMA_REG_CURDESC			0x0008
+#define XILINX_DMA_REG_CURDESC_MSB		0x000C
 #define XILINX_DMA_REG_TAILDESC		0x0010
+#define XILINX_DMA_REG_TAILDESC_MSB	0x0014
 #define XILINX_DMA_REG_REG_INDEX		0x0014
 #define XILINX_DMA_REG_FRMSTORE		0x0018
 #define XILINX_DMA_REG_THRESHOLD		0x001c
@@ -184,6 +186,8 @@
 /* AXI CDMA Specific Registers/Offsets */
 #define XILINX_CDMA_REG_SRCADDR		0x18
 #define XILINX_CDMA_REG_DSTADDR		0x20
+#define XILINX_CDMA_REG_MSB_DSTADR	0x0024
+#define XILINX_CDMA_REG_MSB_SRCADDR	0x001C
 
 /* AXI CDMA Specific Masks */
 #define XILINX_CDMA_CR_SGMODE          BIT(3)
@@ -1459,9 +1463,19 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 		dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
 			     XILINX_CDMA_CR_SGMODE);
 
+		if (chan->ext_addr) {
+			xilinx_write(chan, XILINX_DMA_REG_CURDESC_MSB,
+				     upper_32_bits(head_desc->async_tx.phys));
+		}
+
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
 
+		if (chan->ext_addr) {
+			xilinx_write(chan, XILINX_DMA_REG_TAILDESC_MSB,
+				     upper_32_bits(tail_segment->phys));
+		}
+
 		/* Update tail ptr register which will start the transfer */
 		xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
 			     tail_segment->phys);
@@ -1476,11 +1490,16 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
-			     xilinx_prep_dma_addr_t(hw->src_addr));
-		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
-			     xilinx_prep_dma_addr_t(hw->dest_addr));
-
+		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
+		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
+		if (chan->ext_addr) {
+			xilinx_write(chan,
+				     XILINX_CDMA_REG_MSB_SRCADDR,
+				     hw->src_addr_msb);
+			xilinx_write(chan,
+				     XILINX_CDMA_REG_MSB_DSTADR,
+				     hw->dest_addr_msb);
+		}
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
 				hw->control & chan->xdev->max_buffer_len);
-- 
2.17.1

