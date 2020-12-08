Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF42D26E0
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgLHJEn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:04:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34276 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgLHJEn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:04:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B893k4m002581;
        Tue, 8 Dec 2020 03:03:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418226;
        bh=vOyHJcWQgFd/X5VGt8S3nS+qlpjg6sSRGX+cBw76W44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fFkDdCEOaDUf73et7E5jWSD7PxCMneiXeBRLYNRzlbc9pknrPvPa6KveYWQ8FIhWp
         Wfb9nklwFsX+pO6118mNXrdcbr5X016b3m0MZqL/6Vgj5GPIZKn7K+FWb3Sx97zbn2
         D61kTHIDgWB3pxBYO+IdP+KggG54JIOVFpN/F5vU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B893kQE116402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:03:46 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:03:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:03:45 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dc6120112;
        Tue, 8 Dec 2020 03:03:43 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 01/20] dmaengine: ti: k3-udma: Correct normal channel offset when uchan_cnt is not 0
Date:   Tue, 8 Dec 2020 11:04:21 +0200
Message-ID: <20201208090440.31792-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to different sections of the TRM, the hchan_cnt of CAP3 includes
the number of uchan in UDMA, thus the start offset of the normal channels
are hchan_cnt.

Fixes: daf4ad0499aa4 ("dmaengine: ti: k3-udma: Query throughput level information from hardware")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e508280b3d70..0e8426dd18a7 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3199,8 +3199,7 @@ static int udma_setup_resources(struct udma_dev *ud)
 	} else if (UDMA_CAP3_UCHAN_CNT(cap3)) {
 		ud->tpl_levels = 3;
 		ud->tpl_start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
-		ud->tpl_start_idx[0] = ud->tpl_start_idx[1] +
-				       UDMA_CAP3_HCHAN_CNT(cap3);
+		ud->tpl_start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
 	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
 		ud->tpl_levels = 2;
 		ud->tpl_start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

