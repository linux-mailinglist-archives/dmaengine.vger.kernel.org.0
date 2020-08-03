Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57A23A6EE
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgHCM4D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 08:56:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHCM4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 08:56:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073Ctue3090762;
        Mon, 3 Aug 2020 07:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596459356;
        bh=M7fbrOCkpFwR/FeIsiMk/YC7KZBBAbDACKy28Ayd6xs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NZmQYsuSDDE65PX+LgUrb9qJ2p3JzH0+48F46nUc18YoMwEYFVeZxp6kVh+B2thDM
         ucqmsrgc1U8SevtR/isYoDDKH/PnYKEVkUlV7Fzi6BEmHPKGKASicwOuNdNa1tzxar
         Wv3Y/gAB3wgkfWBJTRljolCEUBnZ+HhXA12YLpWI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073CtuPK054767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 07:55:56 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 07:55:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 07:55:56 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073CtoMi090290;
        Mon, 3 Aug 2020 07:55:53 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dmaengine: ti: k3-psil: Use soc_device_match to get the psil map
Date:   Mon, 3 Aug 2020 15:57:12 +0300
Message-ID: <20200803125713.17829-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803125713.17829-1-peter.ujfalusi@ti.com>
References: <20200803125713.17829-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Instead of separate of_machine_is_compatible() it is better to use
soc_device_match() and soc_device_attribute struct to get the PSI-L map
for the booted device.

By using soc_device_match() it is easier to add support for new devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-psil.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index fb7c8150b0d1..fa106e8bd56b 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -9,11 +9,18 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/sys_soc.h>
 
 #include "k3-psil-priv.h"
 
 static DEFINE_MUTEX(ep_map_mutex);
-static struct psil_ep_map *soc_ep_map;
+static const struct psil_ep_map *soc_ep_map;
+
+static const struct soc_device_attribute k3_soc_devices[] = {
+	{ .family = "AM65X", .data = &am654_ep_map },
+	{ .family = "J721E", .data = &j721e_ep_map },
+	{ /* sentinel */ }
+};
 
 struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 {
@@ -21,10 +28,11 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
 
 	mutex_lock(&ep_map_mutex);
 	if (!soc_ep_map) {
-		if (of_machine_is_compatible("ti,am654")) {
-			soc_ep_map = &am654_ep_map;
-		} else if (of_machine_is_compatible("ti,j721e")) {
-			soc_ep_map = &j721e_ep_map;
+		const struct soc_device_attribute *soc;
+
+		soc = soc_device_match(k3_soc_devices);
+		if (soc) {
+			soc_ep_map = soc->data;
 		} else {
 			pr_err("PSIL: No compatible machine found for map\n");
 			mutex_unlock(&ep_map_mutex);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

