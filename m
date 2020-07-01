Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66A21094D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgGAKbF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 06:31:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60846 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgGAKbE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 06:31:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061AV0ox014658;
        Wed, 1 Jul 2020 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593599460;
        bh=yKfVZq6Zuvht+S4DgV3ZWYRe+OUNx2gZB7sTXc709u0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZS6rMSyPcXSYsd4xVUuiae2/6+vWdq9oQOI9gQ88Ygdef5ZAkGDHf2UyH+PpuQky2
         cAccFXiEtHmxVBr9Q38W8tzwUKVDr3JgRl19EpK72F5zIZH3oSWi+1u5QS5vhaaz5l
         7H7W1GiDlEOFDWDiPyTcIlT49XrHpEfajeWylU+Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061AV0EP052094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 05:31:00 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:31:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:31:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AUxSo038405;
        Wed, 1 Jul 2020 05:30:59 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 3/6] soc: ti: k3-ringacc: add ring's flags to dump
Date:   Wed, 1 Jul 2020 13:30:27 +0300
Message-ID: <20200701103030.29684-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701103030.29684-1-grygorii.strashko@ti.com>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add struct k3_ring *ring->flags to the ring dump.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
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

