Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B95BD18F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439672AbfIXSM6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:12:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393831AbfIXSM4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:12:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4980AEF8;
        Tue, 24 Sep 2019 18:12:53 +0000 (UTC)
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
Subject: [PATCH 03/11] of: address: use parent DT node in bus->count_cells()
Date:   Tue, 24 Sep 2019 20:12:34 +0200
Message-Id: <20190924181244.7159-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function provides the cell sizes for a specific bus type. Instead of
passing it the device DT node sitting on top of that bus we directly
pass its parent which is the actual node the function will start looking
from.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/address.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 0f898756199d..9c1e638fa8ea 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "of_private.h"
+
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
@@ -42,7 +44,7 @@ struct of_bus {
 	const char	*name;
 	const char	*addresses;
 	int		(*match)(struct device_node *parent);
-	void		(*count_cells)(struct device_node *child,
+	void		(*count_cells)(struct device_node *parent,
 				       int *addrc, int *sizec);
 	u64		(*map)(__be32 *addr, const __be32 *range,
 				int na, int ns, int pna);
@@ -54,13 +56,13 @@ struct of_bus {
  * Default translator (generic bus)
  */
 
-static void of_bus_default_count_cells(struct device_node *dev,
+static void of_bus_default_count_cells(struct device_node *parent,
 				       int *addrc, int *sizec)
 {
 	if (addrc)
-		*addrc = of_n_addr_cells(dev);
+		*addrc = __of_n_addr_cells_parent(parent);
 	if (sizec)
-		*sizec = of_n_size_cells(dev);
+		*sizec = __of_n_size_cells_parent(parent);
 }
 
 static u64 of_bus_default_map(__be32 *addr, const __be32 *range,
@@ -192,7 +194,7 @@ const __be32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
 		of_node_put(parent);
 		return NULL;
 	}
-	bus->count_cells(dev, &na, &ns);
+	bus->count_cells(parent, &na, &ns);
 	of_node_put(parent);
 	if (!OF_CHECK_ADDR_COUNT(na))
 		return NULL;
@@ -592,7 +594,7 @@ static u64 __of_translate_address(struct device_node *dev,
 	bus = of_match_bus(parent);
 
 	/* Count address cells & copy address locally */
-	bus->count_cells(dev, &na, &ns);
+	bus->count_cells(parent, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
 		pr_debug("Bad cell count for %pOF\n", dev);
 		goto bail;
@@ -634,7 +636,7 @@ static u64 __of_translate_address(struct device_node *dev,
 
 		/* Get new parent bus and counts */
 		pbus = of_match_bus(parent);
-		pbus->count_cells(dev, &pna, &pns);
+		pbus->count_cells(parent, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
 			pr_err("Bad cell count for %pOF\n", dev);
 			break;
@@ -726,7 +728,7 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 	if (parent == NULL)
 		return NULL;
 	bus = of_match_bus(parent);
-	bus->count_cells(dev, &na, &ns);
+	bus->count_cells(parent, &na, &ns);
 	of_node_put(parent);
 	if (!OF_CHECK_ADDR_COUNT(na))
 		return NULL;
-- 
2.23.0

