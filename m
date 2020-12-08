Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124382D26F2
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgLHJFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:05:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgLHJFh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B894gnS130535;
        Tue, 8 Dec 2020 03:04:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418282;
        bh=r6BZcfFspKekPk2CsVfLnHhDTFjI4u11uU/6NZJdVNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tCg29i+B8UJwV3Pfq2s0qvVYpTkxPJEGk5ifz25EHCOxFMzmyiyjpXSirFejLLuty
         qSpmK1QiKBYleYnjYb2aY/7bAK4qG8BXSwCoCx8rhv8m6eiVEK9lhlbUO2woDTBehf
         SFVdYfBPkAMbMiANtfxWRXlRh/p3TZtvb8pYVxG8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B894gO1057170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:42 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:41 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcK120112;
        Tue, 8 Dec 2020 03:04:38 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 15/20] dmaengine: ti: Add support for k3 event routers
Date:   Tue, 8 Dec 2020 11:04:35 +0200
Message-ID: <20201208090440.31792-16-peter.ujfalusi@ti.com>
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

