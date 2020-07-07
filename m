Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F52168D2
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgGGJJp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:09:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45094 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGGJJp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:09:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06799ft9094812;
        Tue, 7 Jul 2020 04:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594112981;
        bh=Knn8MS+IxPJTYQZE5VMCRUM0NbX02VIMpCObQt4lc6g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W7Z8wrp8pHUsCefyt4J96V0BVfLnDv63pnVOO96oAKMXSHWSIuy6qFAO56HcoFIHi
         VPl0e+ROxoVirH0q9Hs5Lf25P2oxDop8ZSXzEQI5FIDGJBS/xaKryfSh+BSTdX/a1q
         Oq5W6JFsBst6L5cLJrI+K7HQGOlS6nrbRIaoVJno=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06799fbo023170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 04:09:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:09:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:09:40 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799RGp052457;
        Tue, 7 Jul 2020 04:09:39 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH 4/5] dmaengine: ti: k3-udma-private: Use udma_read/write for register access
Date:   Tue, 7 Jul 2020 12:10:30 +0300
Message-ID: <20200707091031.10411-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707091031.10411-1-peter.ujfalusi@ti.com>
References: <20200707091031.10411-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Instead of using higher level wrappers (udma_rchanrt/tchanrt read/write),
use the underlying register access functions directly.

This will allow changes in the higher level wrappers within the DMAengine
driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-private.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 77e8e67d995b..aa24e554f7b4 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -121,13 +121,17 @@ XUDMA_GET_RESOURCE_ID(rflow);
 #define XUDMA_RT_IO_FUNCTIONS(res)					\
 u32 xudma_##res##rt_read(struct udma_##res *p, int reg)			\
 {									\
-	return udma_##res##rt_read(p, reg);				\
+	if (!p)								\
+		return 0;						\
+	return udma_read(p->reg_rt, reg);				\
 }									\
 EXPORT_SYMBOL(xudma_##res##rt_read);					\
 									\
 void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
 {									\
-	udma_##res##rt_write(p, reg, val);				\
+	if (!p)								\
+		return;							\
+	udma_write(p->reg_rt, reg, val);				\
 }									\
 EXPORT_SYMBOL(xudma_##res##rt_write)
 XUDMA_RT_IO_FUNCTIONS(tchan);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

