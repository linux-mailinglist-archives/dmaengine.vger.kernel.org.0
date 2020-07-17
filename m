Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C5223C3F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgGQNUj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 09:20:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56490 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgGQNUh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 09:20:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKXsl052617;
        Fri, 17 Jul 2020 08:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992033;
        bh=2EiIXb5zilfyGEMEK9FZOAk62YE9dIIHJnevmZ9b4YU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XeLQqn05QEYYIVmuFTizVxmSDGN9+tJUT4lFv17xM+ok8sNFOyXscSyR19DKLMWHA
         siFcEKa9W2WMjfQusZKIUffLTyzaQcVi8KNEdgRKNIdFIOBMo6CDV3eCZRKvx1PrxR
         /r0yryQPAtoD2wRe0hXjnZQOybKwqTFTE5jtii9k=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKXbC060371;
        Fri, 17 Jul 2020 08:20:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKWrh107217;
        Fri, 17 Jul 2020 08:20:32 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 3/6] soc: ti: k3-ringacc: add ring's flags to dump
Date:   Fri, 17 Jul 2020 16:20:16 +0300
Message-ID: <20200717132019.20427-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add struct k3_ring *ring->flags to the ring dump.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index d2dc9c144a89..8a8f31d59e24 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -253,6 +253,7 @@ static void k3_ringacc_ring_dump(struct k3_ring *ring)
 		&ring->ring_mem_dma);
 	dev_dbg(dev, "dump elmsize %d, size %d, mode %d, proxy_id %d\n",
 		ring->elm_size, ring->size, ring->mode, ring->proxy_id);
+	dev_dbg(dev, "dump flags %08X\n", ring->flags);
 
 	dev_dbg(dev, "dump ring_rt_regs: db%08x\n", readl(&ring->rt->db));
 	dev_dbg(dev, "dump occ%08x\n", readl(&ring->rt->occ));
-- 
2.17.1

