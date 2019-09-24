Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5CBD197
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfIXSOC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:14:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388114AbfIXSMz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:12:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1202AF03;
        Tue, 24 Sep 2019 18:12:52 +0000 (UTC)
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
Subject: [PATCH 02/11] of: base: introduce __of_n_*_cells_parent()
Date:   Tue, 24 Sep 2019 20:12:33 +0200
Message-Id: <20190924181244.7159-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Master PCI devices might not appear in the device tree, yet they still
need to get the underlying cells properties in order to calculate the
bus DMA constraints. This conflicts with of_n_*_cells() as it's designed
under the assumption it'll receive a device OF node.

Create __of_n_*_cells_parent() in order to deal with this limitation.
For now, it'll only be available privately to OF code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/base.c       | 44 +++++++++++++++++++++++++++++------------
 drivers/of/of_private.h |  3 +++
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1d667eb730e1..94f83051910c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -86,34 +86,52 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
 	return np && match && type && !strcmp(match, type);
 }
 
-int of_n_addr_cells(struct device_node *np)
+int __of_n_addr_cells_parent(struct device_node *parent)
 {
 	u32 cells;
 
-	do {
-		if (np->parent)
-			np = np->parent;
-		if (!of_property_read_u32(np, "#address-cells", &cells))
+	while (parent) {
+		if (!of_property_read_u32(parent, "#address-cells", &cells))
 			return cells;
-	} while (np->parent);
+
+		parent = parent->parent;
+	}
+
 	/* No #address-cells property for the root node */
 	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
 }
+
+int of_n_addr_cells(struct device_node *np)
+{
+	if (np->parent)
+		np = np->parent;
+
+	return __of_n_addr_cells_parent(np);
+}
 EXPORT_SYMBOL(of_n_addr_cells);
 
-int of_n_size_cells(struct device_node *np)
+int __of_n_size_cells_parent(struct device_node *parent)
 {
 	u32 cells;
 
-	do {
-		if (np->parent)
-			np = np->parent;
-		if (!of_property_read_u32(np, "#size-cells", &cells))
+	while (parent) {
+		if (!of_property_read_u32(parent, "#size-cells", &cells))
 			return cells;
-	} while (np->parent);
-	/* No #size-cells property for the root node */
+
+		parent = parent->parent;
+	}
+
+	/* No #address-cells property for the root node */
 	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
 }
+
+int of_n_size_cells(struct device_node *np)
+{
+	if (np->parent)
+		np = np->parent;
+
+	return __of_n_size_cells_parent(np);
+}
 EXPORT_SYMBOL(of_n_size_cells);
 
 #ifdef CONFIG_NUMA
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 24786818e32e..b528304be244 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -39,6 +39,9 @@ extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+int __of_n_addr_cells_parent(struct device_node *parent);
+int __of_n_size_cells_parent(struct device_node *parent);
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
-- 
2.23.0

