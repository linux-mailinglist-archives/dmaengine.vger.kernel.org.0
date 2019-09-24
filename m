Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBBBD176
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439740AbfIXSNC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:44098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439705AbfIXSNB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 376C8AC93;
        Tue, 24 Sep 2019 18:12:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 06/11] of: address: use parent OF node in of_dma_get_range()
Date:   Tue, 24 Sep 2019 20:12:37 +0200
Message-Id: <20190924181244.7159-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some devices don't have their own OF node, and are stuck passing their
bus node. Adapt the function for this use case.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/address.c       | 33 +++++++++++++++------------------
 drivers/of/device.c        |  3 ++-
 include/linux/of_address.h |  8 ++++----
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 53666063e938..b7b864b0ac75 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -914,30 +914,21 @@ EXPORT_SYMBOL(of_io_request_and_map);
  * It returns -ENODEV if "dma-ranges" property was not found
  * for this device in DT.
  */
-int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+int of_dma_get_range(struct device_node *parent, u64 *dma_addr,
+		     u64 *paddr, u64 *size)
 {
-	struct device_node *node = of_node_get(np);
+	struct device_node *node = of_node_get(parent);
 	const __be32 *ranges = NULL;
 	int naddr, nsize, pna;
 	int ret = 0;
 	u64 dmaaddr;
 
-	if (!node)
-		return -EINVAL;
-
 	while (1) {
-		struct device_node *parent;
+		struct device_node *tmp;
 		int len;
 
-		naddr = of_n_addr_cells(node);
-		nsize = of_n_size_cells(node);
-
-		parent = __of_get_dma_parent(node);
-		of_node_put(node);
-
-		node = parent;
-		if (!node)
-			break;
+		naddr = __of_n_addr_cells_parent(node);
+		nsize = __of_n_size_cells_parent(node);
 
 		ranges = of_get_property(node, "dma-ranges", &len);
 
@@ -951,10 +942,16 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		 */
 		if (!ranges)
 			break;
+
+		tmp = __of_get_dma_parent(node);
+		of_node_put(node);
+		node = tmp;
+		if (!node)
+			break;
 	}
 
 	if (!ranges) {
-		pr_debug("no dma-ranges found for node(%pOF)\n", np);
+		pr_debug("no dma-ranges found for node(%pOF)\n", node);
 		ret = -ENODEV;
 		goto out;
 	}
@@ -967,10 +964,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	 * size		: nsize cells
 	 */
 	dmaaddr = of_read_number(ranges, naddr);
-	*paddr = of_translate_dma_address(np, ranges);
+	*paddr = of_translate_dma_address_parent(parent, ranges);
 	if (*paddr == OF_BAD_ADDR) {
 		pr_err("translation of DMA address(%pad) to CPU address failed node(%pOF)\n",
-		       dma_addr, np);
+		       dma_addr, parent);
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index da8158392010..267b509df517 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -95,7 +95,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	const struct iommu_ops *iommu;
 	u64 mask;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	ret = of_dma_get_range(__of_get_dma_parent(np), &dma_addr,
+			       &paddr, &size);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 30e40fb6936b..aa1ce0cb59a1 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -55,8 +55,8 @@ extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
-extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				u64 *paddr, u64 *size);
+extern int of_dma_get_range(struct device_node *parent, u64 *dma_addr,
+			    u64 *paddr, u64 *size);
 extern bool of_dma_is_coherent(struct device_node *np);
 #else /* CONFIG_OF_ADDRESS */
 static inline void __iomem *of_io_request_and_map(struct device_node *device,
@@ -104,8 +104,8 @@ static inline struct of_pci_range *of_pci_range_parser_one(
 	return NULL;
 }
 
-static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				u64 *paddr, u64 *size)
+static inline int of_dma_get_range(struct device_node *parent, u64 *dma_addr,
+				   u64 *paddr, u64 *size)
 {
 	return -ENODEV;
 }
-- 
2.23.0

