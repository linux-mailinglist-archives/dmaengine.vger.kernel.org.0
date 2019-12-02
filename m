Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B021D10F190
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2019 21:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLBUbu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Dec 2019 15:31:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48646 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfLBUbs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Dec 2019 15:31:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVY1S116144;
        Mon, 2 Dec 2019 14:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575318694;
        bh=I4zArTwz2+uyo5cLd8GOGGyuu7Ob1n/MUYmaFykEDf0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MOrDhfh9Qab1FfK0q8D3QSJmCj8WSAEX4pWScE4+rTh0ADTkMuBdWERv1hbkfI2NN
         LVuwk5sQyE3eO3ffhdzP95BisKvguwfMq3lvOmrEtM/qFPFdCe14294GQwgU4oIglk
         0GZArIFKa0b56G2vwJVniDgOk7zOjGxqu8jazy5U=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB2KVYZZ116964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Dec 2019 14:31:34 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Dec
 2019 14:31:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Dec 2019 14:31:32 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVOPn106889;
        Mon, 2 Dec 2019 14:31:30 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: [PATCH 2/3] dmaengine: ti: k3-udma: Workaround for stale transfers
Date:   Mon, 2 Dec 2019 22:31:27 +0200
Message-ID: <20191202203128.14348-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202203128.14348-1-peter.ujfalusi@ti.com>
References: <0191128105945.13071-1-peter.ujfalusi@ti.com>
 <20191202203128.14348-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the client does issue_pending between terminte_all+synchronize and
free_chan_resources, we need to make sure that it has been handled and
cleared up.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1b929f7a84d4..3aede5db9604 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2842,6 +2842,10 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 	struct udma_dev *ud = to_udma_dev(chan->device);
 
 	udma_terminate_all(chan);
+	if (uc->terminated_desc) {
+		udma_reset_chan(uc, false);
+		udma_reset_rings(uc);
+	}
 
 	if (uc->irq_num_ring > 0) {
 		free_irq(uc->irq_num_ring, uc);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

