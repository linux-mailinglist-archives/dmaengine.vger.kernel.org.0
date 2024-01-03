Return-Path: <dmaengine+bounces-674-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC188229EE
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jan 2024 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986552852F8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jan 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEA182A9;
	Wed,  3 Jan 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kdM5o09q"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACD182A7;
	Wed,  3 Jan 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403984bN067220;
	Wed, 3 Jan 2024 03:08:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704272884;
	bh=w0QBRm3/8yaQBn/wB8ETNAL7dddIFLvJPYTPCbzX2bQ=;
	h=From:Date:Subject:To:CC;
	b=kdM5o09qBgnNMCe3+mhQjRxj6D19cob29fxrjnsFIhL5X3W/fglA5EXyYHZkuFDTc
	 zRzYJl+1+Z8zxxZnqrVopVWN+qmU8xNqmgSoR6gvPwZXPQER7/BVbFmlsXI+o6MlEd
	 Ppu7H9qbL5P6efoN6B3pE+xzOgspWHbpO6/sd3+o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403984Fl025848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jan 2024 03:08:04 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 03:08:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 03:08:04 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403982n8120137;
	Wed, 3 Jan 2024 03:08:03 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Wed, 3 Jan 2024 14:37:55 +0530
Subject: [PATCH] dmaengine: ti: k3-udma: Report short packet errors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240103-tr_resp_err-v1-1-2fdf6d48ab92@ti.com>
X-B4-Tracking: v=1; b=H4sIAOojlWUC/x3MQQqAIBBG4avIrBPM2tRVIiL1r2ZjMkYE0t2Tl
 t/ivUIZwsg0qkKCmzOfsaJtFPljjTs0h2qyxvamNZ2+ZBHktEBED1sPOBd86BzVIgk2fv7bNL/
 vB/2CV39dAAAA
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Jai
 Luthra" <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=2AVnLjehw7HkRBinGMaBfSJvm7yeh/nzWX7+v+Aisr8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBllSPwBGsElHUyHxcgvVJEbnyNiqHk7MdD9z/EF
 9Ug8Kxrhx6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZZUj8AAKCRBD3pH5JJpx
 RU8/D/sGhHwULpAycpqNnPdathnLCeOH59HTXwTDrRIZ9d1O00nSjXMC1uDG65ktOm6M3YuYrMu
 g8q/EHwGwTWGEyGvHBg3n2x7VICbLvCsQ3FAofJlfOJRHFSFMg4v3EVniNSZX48Z9HUIy1nJv6P
 v/jzoG1BPdlYv2cIZ785lA7f+lf34kgOckqi0p+JBiFfAP9Gtpzt3neBIWMCd7SkHy2Z4Ps6mw1
 9+QdScOvM4lRcDxRdcpv3K1wKE+lYHEebpNHk3Wqn5PJmbjZ6W+yj210dPptVsOC9rrRxhtDDSP
 /qza89eESNu2aEB+DC7/6dzNJRhvPAOKPY7MRUxD+FXSf9B7GMEUIzDmL7Ro6OkeHIqD657Pnr1
 Y8COPQJjEf67o/rTfhhhtzJ4bz8e06Lk4qNt9PRu+SuXA6mxGOpvUpLIE+uc6i+UMb0LFPCtv4T
 yZEqBnrM+T/jpRvH8j/LTxv5yW2+eW3zW0JLyoo1CK2xVrEJ9BOlrtFHpy5cDnpMn/OUXaWAYG1
 CcGBCguk4gR7MDHf2YUXM7Qa7710KA0ZdZ/v4Uzivvlo9mcI/qeOUe7MLYQ/VfRL8hDeROfRSEO
 JiPR0iIQ3Zt6mc09WeaO8ccatd17DEH05xyozpyEe5fIa9O1ji+FAbiQhKjFUBPdxou+gcspddm
 B2udgsD7/ap5l0w==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Propagate the TR response status to the device using BCDMA
split-channels. For example CSI-RX driver should be able to check if a
frame was not transferred completely (short packet) and needs to be
discarded.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/dma/ti/k3-udma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30fd2f386f36..037f1408e798 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3968,6 +3968,7 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 {
 	struct udma_chan *uc = to_udma_chan(&vc->chan);
 	struct udma_desc *d;
+	u8 status;
 
 	if (!vd)
 		return;
@@ -3977,12 +3978,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 	if (d->metadata_size)
 		udma_fetch_epib(uc, d);
 
-	/* Provide residue information for the client */
 	if (result) {
 		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
 
 		if (cppi5_desc_get_type(desc_vaddr) ==
 		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
+			/* Provide residue information for the client */
 			result->residue = d->residue -
 					  cppi5_hdesc_get_pktlen(desc_vaddr);
 			if (result->residue)
@@ -3991,7 +3992,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 				result->result = DMA_TRANS_NOERROR;
 		} else {
 			result->residue = 0;
-			result->result = DMA_TRANS_NOERROR;
+			/* Propagate TR Response errors to the client */
+			status = d->hwdesc[0].tr_resp_base->status;
+			if (status)
+				result->result = DMA_TRANS_ABORTED;
+			else
+				result->result = DMA_TRANS_NOERROR;
 		}
 	}
 }

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240103-tr_resp_err-9f4eebbdcd3b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


