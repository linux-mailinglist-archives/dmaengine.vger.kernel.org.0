Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67AABAA4
	for <lists+dmaengine@lfdr.de>; Fri,  6 Sep 2019 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394362AbfIFOR6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Sep 2019 10:17:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394290AbfIFOR5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Sep 2019 10:17:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x86EHs8R033208;
        Fri, 6 Sep 2019 09:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567779474;
        bh=Q0YSzmtvj7sqG004BV4lez3XreU1ptGoRlCRKi0kkXE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iK2R5BfLmLoYQap6f051TME+qiH2qqg6MAM9FFHgfLpiiMrKzF1qqgB5KaVZrpLbf
         vm81b+vTVeokvamwL1wAiQWWgdZP5WxrwDGxT2z1y1J5iHD2VBIH0Qz3J286oDDRW2
         zDMT/O3VG5LwVPZl9Y+hpoqsfO7k0Uvxqrc0OsZo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x86EHsY8065345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Sep 2019 09:17:54 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 6 Sep
 2019 09:17:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 6 Sep 2019 09:17:54 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x86EHlOf032723;
        Fri, 6 Sep 2019 09:17:52 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [RFC 2/3] dmaengine: of_dma: Function to look up the DMA domain of a client
Date:   Fri, 6 Sep 2019 17:18:15 +0300
Message-ID: <20190906141816.24095-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906141816.24095-1-peter.ujfalusi@ti.com>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Find the DMA domain controller of the client device by iterating up in
device tree looking for the closest 'dma-domain-controller' property.

If the client's node is not provided then check the DT root for the
controller.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/of-dma.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_dma.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index c2d779daa4b5..04b5795cd76b 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -18,6 +18,48 @@
 static LIST_HEAD(of_dma_list);
 static DEFINE_MUTEX(of_dma_lock);
 
+/**
+ * of_find_dma_domain - Get the domain DMA controller
+ * @np:		device node of the client device
+ *
+ * Look up the DMA controller of the domain the client device is part of.
+ * Finds the dma-domain controller the client device belongs to. It is used when
+ * requesting non slave channels (like channel for memcpy) to make sure that the
+ * channel can be request from a DMA controller which can service the given
+ * domain best.
+ *
+ * Returns the device_node pointer of the DMA controller or succes or NULL on
+ * error.
+ */
+struct device_node *of_find_dma_domain(struct device_node *np)
+{
+	struct device_node *dma_domain = NULL;
+	phandle dma_phandle;
+
+	/*
+	 * If no device_node is provided look at the root level for system
+	 * default DMA controller for modules.
+	 */
+	if (!np)
+		np = of_root;
+
+	if (!np || !of_node_get(np))
+		return NULL;
+
+	do {
+		if (of_property_read_u32(np, "dma-domain-controller",
+					 &dma_phandle))
+			np = of_get_next_parent(np);
+		else {
+			dma_domain = of_find_node_by_phandle(dma_phandle);
+			of_node_put(np);
+		}
+	} while (!dma_domain && np);
+
+	return dma_domain;
+}
+EXPORT_SYMBOL_GPL(of_find_dma_domain);
+
 /**
  * of_dma_find_controller - Get a DMA controller in DT DMA helpers list
  * @dma_spec:	pointer to DMA specifier as found in the device tree
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index fd706cdf255c..6eab0a8d3335 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -32,6 +32,8 @@ struct of_dma_filter_info {
 };
 
 #ifdef CONFIG_DMA_OF
+extern struct device_node *of_find_dma_domain(struct device_node *np);
+
 extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
@@ -52,6 +54,11 @@ extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec
 		struct of_dma *ofdma);
 
 #else
+static inline struct device_node *of_find_dma_domain(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

