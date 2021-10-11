Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A534F4289EA
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhJKJpU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 05:45:20 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235614AbhJKJpU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 05:45:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B824qK014133;
        Mon, 11 Oct 2021 11:43:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=k+FUI2/olr8bNkpun0hAvkx43pYCKhp8ezqw9X5l4vE=;
 b=4cPkjy0H768j5aIDb16+uDHojnh3TL7TfDPuAkldrfuvgm1OMIvvXI4lYbWJ+MHDN7Fp
 lPrIpm4vducRfYVVJMMy3DO7nXWeyWUnm9ke37qUkDRUARVg6mE6H8xcaVMzl45Q3Zcs
 6hzPn4R2Onw4XJkoQGvqr0G7Iz9FPPtsJyTdXVhhN7IPAaWExtdyQFras5/65E6QfHuR
 PwgSfxq4SuhRfpswXw11nissj1juRZE9KlEwsLTClFq8ymJaeZ2OJL3BXY6y+xQPT8pg
 F+xtvSTN2Vl8AngCRXjPjVEJwRtEaoIKS/izW8o1TVbdrB4Gfw14I7P0mV/GMFhPchlP qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bmasq2mxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:43:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3346010002A;
        Mon, 11 Oct 2021 11:43:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29C7721B50C;
        Mon, 11 Oct 2021 11:43:08 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 11 Oct 2021 11:43:07
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 2/3] dmaengine: stm32-dma: fix stm32_dma_get_max_width
Date:   Mon, 11 Oct 2021 11:42:58 +0200
Message-ID: <20211011094259.315023-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
References: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

buf_addr parameter of stm32_dma_set_xfer_param function is a dma_addr_t.
We only need to check the remainder of buf_addr/max_width, so, no need to
use do_div and extra u64 addr. Use '%' instead.

Fixes: e0ebdbdcb42a ("dmaengine: stm32-dma: take address into account when computing max width")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index a5ccf3fa95e0..6e4ef44941ef 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -270,7 +270,6 @@ static enum dma_slave_buswidth stm32_dma_get_max_width(u32 buf_len,
 						       u32 threshold)
 {
 	enum dma_slave_buswidth max_width;
-	u64 addr = buf_addr;
 
 	if (threshold == STM32_DMA_FIFO_THRESHOLD_FULL)
 		max_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -281,7 +280,7 @@ static enum dma_slave_buswidth stm32_dma_get_max_width(u32 buf_len,
 	       max_width > DMA_SLAVE_BUSWIDTH_1_BYTE)
 		max_width = max_width >> 1;
 
-	if (do_div(addr, max_width))
+	if (buf_addr % max_width)
 		max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	return max_width;
-- 
2.25.1

