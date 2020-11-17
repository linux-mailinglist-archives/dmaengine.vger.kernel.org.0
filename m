Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC2B5D86
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgKQK5B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:57:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgKQK47 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuqfn117397;
        Tue, 17 Nov 2020 04:56:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610612;
        bh=r6BZcfFspKekPk2CsVfLnHhDTFjI4u11uU/6NZJdVNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iu2PLKVnQRaNSmhkyiovnJjARHlRHbE8pdRD8FjXrHFL0PeE4J+w+HEq+caoxPUih
         +46Bmz84oPBRrYMU99ljah3krjhMAda5A9eEyUwx/A/Z0WibHgxJnO8QBvhNtwVH8z
         o/ecDiHgb064244/RrkbRZvaAYghcGtoxESmezRI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAuqd9005553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:52 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6u0087311;
        Tue, 17 Nov 2020 04:56:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 14/19] dmaengine: ti: Add support for k3 event routers
Date:   Tue, 17 Nov 2020 12:56:51 +0200
Message-ID: <20201117105656.5236-15-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In k3 architecture a DMA channel (in TR momde) can be triggered by global
events, origination from different modules.

The events for triggers can be sent from any module which is connected to
PSI-L fabric, but the event number to be sent is DMA channel specific, it
is only known after the channel itself is requested.

The router operation needs to be split up:
- route_allocate: configure the dma_spec for the DMA and store the
  configuration which is needed for the router's input
- set_event: callback used by the DMA driver to set the event number for
  the channel and enable the routing

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dma/k3-event-router.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/linux/dma/k3-event-router.h

diff --git a/include/linux/dma/k3-event-router.h b/include/linux/dma/k3-event-router.h
new file mode 100644
index 000000000000..e3f88b2f87be
--- /dev/null
+++ b/include/linux/dma/k3-event-router.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#ifndef K3_EVENT_ROUTER_
+#define K3_EVENT_ROUTER_
+
+#include <linux/types.h>
+
+struct k3_event_route_data {
+	void *priv;
+	int (*set_event)(void *priv, u32 event);
+};
+
+#endif /* K3_EVENT_ROUTER_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

