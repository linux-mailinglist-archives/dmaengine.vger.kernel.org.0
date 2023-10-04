Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AE7B8423
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjJDPuu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjJDPut (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 11:50:49 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C210BF;
        Wed,  4 Oct 2023 08:50:44 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 394FjWgS013834;
        Wed, 4 Oct 2023 17:50:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=8mC8DzLCJr8pbaqd7TJBf5FL8cBOmE3cRTtig5bDfrw=; b=ys
        Bp+eaOxHzxbvk3wLP1SZXvhYB3XX0meS+GObIPNDLpMIhOqwtE+jSwsiHc33S6W6
        quJU0dG+lhGQR5xtCh5TAZKaxgOt5TEB3EFp0LMz08MJA7463cYFDFWvlBNG5C7K
        AYU4jRwNdeBvIg+TK2ICg60BfW5tN1GYhb1THv3x9VULybubrRmecJLBaZ/e2wyv
        1BL9rriiM/R+NjMzV79uljVbCjMUsBp8QWggqr7L80F+L50vjkVuWk8hiHgHyNHv
        6RuptB7iatfDfD0xnGgY5Gk7RsoFPzazhmWoTJz4jU/fLbCRshQLZKuOl4WDHZQB
        cF8Ss3p9KX/UrFAuDkhg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te93g1xju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 17:50:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3A74100064;
        Wed,  4 Oct 2023 17:50:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CAEE226029A;
        Wed,  4 Oct 2023 17:50:29 +0200 (CEST)
Received: from localhost (10.252.26.61) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 17:50:29 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
CC:     <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: stm32-dma: fix residue in case of MDMA chaining
Date:   Wed, 4 Oct 2023 17:50:24 +0200
Message-ID: <20231004155024.2609531-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004155024.2609531-1-amelie.delaunay@foss.st.com>
References: <20231004155024.2609531-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.26.61]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case of MDMA chaining, DMA is configured in Double-Buffer Mode (DBM)
with two periods, but if transfer has been prepared with _prep_slave_sg(),
the transfer is not marked cyclic (=!chan->desc->cyclic). However, as DBM
is activated for MDMA chaining, residue computation must take into account
cyclic constraints.

With only two periods in MDMA chaining, and no update due to Transfer
Complete interrupt masked, n_sg is always 0. If DMA current memory address
(depending on SxCR.CT and SxM0AR/SxM1AR) does not correspond, it means n_sg
should be increased.
Then, the residue of the current period is the one read from SxNDTR and
should not be overwritten with the full period length.

Fixes: 723795173ce1 ("dmaengine: stm32-dma: add support to trigger STM32 MDMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
---
 drivers/dma/stm32-dma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 7427acc82259..0b30151fb45c 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1389,11 +1389,12 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 
 	residue = stm32_dma_get_remaining_bytes(chan);
 
-	if (chan->desc->cyclic && !stm32_dma_is_current_sg(chan)) {
+	if ((chan->desc->cyclic || chan->trig_mdma) && !stm32_dma_is_current_sg(chan)) {
 		n_sg++;
 		if (n_sg == chan->desc->num_sgs)
 			n_sg = 0;
-		residue = sg_req->len;
+		if (!chan->trig_mdma)
+			residue = sg_req->len;
 	}
 
 	/*
@@ -1403,7 +1404,7 @@ static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 	 * residue = remaining bytes from NDTR + remaining
 	 * periods/sg to be transferred
 	 */
-	if (!chan->desc->cyclic || n_sg != 0)
+	if ((!chan->desc->cyclic && !chan->trig_mdma) || n_sg != 0)
 		for (i = n_sg; i < desc->num_sgs; i++)
 			residue += desc->sg_req[i].len;
 
-- 
2.25.1

