Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613681168A
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBJ27 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 05:28:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbfEBJ27 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 05:28:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x429RfYS003613;
        Thu, 2 May 2019 11:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=/2dLYwvIGpRkACmfoPj9weHdPWS9z7ga6G0TrZio5Zg=;
 b=cEHI1ThvDIf7BtZcTNb1KQWRBBLMN2s4wvy0fz2+SYlbOxvuPKMHFPOHTO/4n1KkQk91
 2UHnwT5o+SebHhTH0WmQ84HDMGN2A2iOrAxR7Gjsia62lUhqd8O+VzjMzVFfJyi/Y5se
 pfqJouCUspqO9mJ9aBkgGxAtWhX9YM06VG3dC9klxVm2JaJnyNAo3Wi+V6rZyTnKA8WC
 SKS+Libee9r1C9xBRHdqYhxge6ygSlGscELQUaoW7nnEXEqmlzz9NwzbyowyfFBYutH0
 t9R7cFmFAgAW4taTuDidC0qLQDn89CRnn6qSiP1T7Ozwv6DzqAxqfzY+5VutacnooaQp Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s6xgcqjb3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 May 2019 11:28:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D74C3D;
        Thu,  2 May 2019 09:28:50 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 221FC1588;
        Thu,  2 May 2019 09:28:50 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 2 May 2019
 11:28:50 +0200
Received: from localhost (10.48.0.131) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 2 May 2019 11:28:49 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, <arnaud.pouliquen@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: [PATCH v2] dmaengine: stm32-dma: fix residue calculation in stm32-dma
Date:   Thu, 2 May 2019 11:28:42 +0200
Message-ID: <1556789322-7232-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_04:,,
 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In double buffer mode, during residue calculation, the DMA can
automatically switch to the next transfer. Indeed the CT bit that
gives position in the double buffer can has been updated by the
hardware, during calculation.
In this case the SxNDTR register value can not be trusted.
If a transition is detected we consider that the DMA has switched to
the beginning of next sg.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
V1 to V2 update:
Change of the comments to provide better explanation of the race condition.
---
 drivers/dma/stm32-dma.c | 90 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ba239b529fa9..9fcaf882e38d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1042,33 +1042,97 @@ static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
 	return ndtr << width;
 }
 
+/**
+ * stm32_dma_is_current_sg - check that expected sg_req is currently transferred
+ * @chan: dma channel
+ *
+ * This function called when IRQ are disable, checks that the hardware has not
+ * switched on the next transfer in double buffer mode. The test is done by
+ * comparing the next_sg memory address with the hardware related register
+ * (based on CT bit value).
+ *
+ * Returns true if expected current transfer is still running or double
+ * buffer mode is not activated.
+ */
+static bool stm32_dma_is_current_sg(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_sg_req *sg_req;
+	u32 dma_scr, dma_smar, id;
+
+	id = chan->id;
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
+
+	if (!(dma_scr & STM32_DMA_SCR_DBM))
+		return true;
+
+	sg_req = &chan->desc->sg_req[chan->next_sg];
+
+	if (dma_scr & STM32_DMA_SCR_CT) {
+		dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM0AR(id));
+		return (dma_smar == sg_req->chan_reg.dma_sm0ar);
+	}
+
+	dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(id));
+
+	return (dma_smar == sg_req->chan_reg.dma_sm1ar);
+}
+
 static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 				     struct stm32_dma_desc *desc,
 				     u32 next_sg)
 {
 	u32 modulo, burst_size;
-	u32 residue = 0;
+	u32 residue;
+	u32 n_sg = next_sg;
+	struct stm32_dma_sg_req *sg_req = &chan->desc->sg_req[chan->next_sg];
 	int i;
 
 	/*
-	 * In cyclic mode, for the last period, residue = remaining bytes from
-	 * NDTR
+	 * Calculate the residue means compute the descriptors
+	 * information:
+	 * - the sg_req currently transferred
+	 * - the Hardware remaining position in this sg (NDTR bits field).
+	 *
+	 * A race condition may occur if DMA is running in cyclic or double
+	 * buffer mode, since the DMA register are automatically reloaded at end
+	 * of period transfer. The hardware may have switched to the next
+	 * transfer (CT bit updated) just before the position (SxNDTR reg) is
+	 * read.
+	 * In this case the SxNDTR reg could (or not) correspond to the new
+	 * transfer position, and not the expected one.
+	 * The strategy implemented in the stm32 driver is to:
+	 *  - read the SxNDTR register
+	 *  - crosscheck that hardware is still in current transfer.
+	 * In case of switch, we can assume that the DMA is at the beginning of
+	 * the next transfer. So we approximate the residue in consequence, by
+	 * pointing on the beginning of next transfer.
+	 *
+	 * This race condition doesn't apply for none cyclic mode, as double
+	 * buffer is not used. In such situation registers are updated by the
+	 * software.
 	 */
-	if (chan->desc->cyclic && next_sg == 0) {
-		residue = stm32_dma_get_remaining_bytes(chan);
-		goto end;
+
+	residue = stm32_dma_get_remaining_bytes(chan);
+
+	if (!stm32_dma_is_current_sg(chan)) {
+		n_sg++;
+		if (n_sg == chan->desc->num_sgs)
+			n_sg = 0;
+		residue = sg_req->len;
 	}
 
 	/*
-	 * For all other periods in cyclic mode, and in sg mode,
-	 * residue = remaining bytes from NDTR + remaining periods/sg to be
-	 * transferred
+	 * In cyclic mode, for the last period, residue = remaining bytes
+	 * from NDTR,
+	 * else for all other periods in cyclic mode, and in sg mode,
+	 * residue = remaining bytes from NDTR + remaining
+	 * periods/sg to be transferred
 	 */
-	for (i = next_sg; i < desc->num_sgs; i++)
-		residue += desc->sg_req[i].len;
-	residue += stm32_dma_get_remaining_bytes(chan);
+	if (!chan->desc->cyclic || n_sg != 0)
+		for (i = n_sg; i < desc->num_sgs; i++)
+			residue += desc->sg_req[i].len;
 
-end:
 	if (!chan->mem_burst)
 		return residue;
 
-- 
2.7.4

