Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12E424FD1A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHXL7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 07:59:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58550 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXL7e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Aug 2020 07:59:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OBxVVU015659;
        Mon, 24 Aug 2020 06:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598270371;
        bh=9l+98VjatOViQcRX1sObf/5GB1HBUbqh0fSvPKkNUfY=;
        h=From:To:CC:Subject:Date;
        b=Z1DQPcYSMDM/VwIThKVPFj2QCukt3LRqFrz0Rz1XEvUog46suutWu+mMKoBNWNQHh
         n50jsfmQ7cw0rXxS5V+XjfvHAPayBceUCg0owh8tKnuQ5qoY22xGHkKbpCMj4pLxQ/
         NPoNmWCv2921HzRVr+PM0f62EekJQ2EqsMONGVBc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBxVaT013342;
        Mon, 24 Aug 2020 06:59:31 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 06:59:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 06:59:30 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBxTYQ048063;
        Mon, 24 Aug 2020 06:59:29 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix the TR initialization for prep_slave_sg
Date:   Mon, 24 Aug 2020 15:01:08 +0300
Message-ID: <20200824120108.9178-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The TR which needs to be initialized for the next sg entry is indexed by
tr_idx and not by the running i counter.

In case any sub element in the SG needs more than one TR, the code would
corrupt an already configured TR.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c14e6cb105cd..30cb514cee54 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2059,9 +2059,9 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 			return NULL;
 		}
 
-		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
-			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-		cppi5_tr_csf_set(&tr_req[i].flags, CPPI5_TR_CSF_SUPR_EVT);
+		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
+			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
 
 		tr_req[tr_idx].addr = sg_addr;
 		tr_req[tr_idx].icnt0 = tr0_cnt0;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

