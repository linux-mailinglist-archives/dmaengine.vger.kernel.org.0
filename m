Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4EBD18A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439701AbfIXSM6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:12:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439610AbfIXSM6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:12:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CDFFABBD;
        Tue, 24 Sep 2019 18:12:55 +0000 (UTC)
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
Subject: [PATCH 04/11] of: address: introduce of_translate_dma_address_parent()
Date:   Tue, 24 Sep 2019 20:12:35 +0200
Message-Id: <20190924181244.7159-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some devices might not have a DT node of their own, but might still need
to translate DMA addresses based on their bus DT node.

Update of_translate_dma_address() to only depend on the parent DT node.
Rename it to of_translate_dma_address_parent(). The later will be still
available as a wrapper around the new function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/address.c | 60 ++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 9c1e638fa8ea..c9eb4ebcc2e9 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -570,33 +570,32 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * device that had registered logical PIO mapping, and the return code is
  * relative to that node.
  */
-static u64 __of_translate_address(struct device_node *dev,
-				  struct device_node *(*get_parent)(const struct device_node *),
-				  const __be32 *in_addr, const char *rprop,
-				  struct device_node **host)
+static u64 __of_translate_address_parent(struct device_node *parent,
+					 struct device_node *(*get_parent)
+						(const struct device_node *),
+					 const __be32 *in_addr,
+					 const char *rprop,
+					 struct device_node **host)
 {
-	struct device_node *parent = NULL;
+	struct device_node *dev = NULL;
 	struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
 	u64 result = OF_BAD_ADDR;
 
-	pr_debug("** translation for device %pOF **\n", dev);
-
-	/* Increase refcount at current level */
-	of_node_get(dev);
-
 	*host = NULL;
-	/* Get parent & match bus type */
-	parent = get_parent(dev);
-	if (parent == NULL)
+
+	if (!parent)
 		goto bail;
+
+	/* Increase refcount at current level and match bus type */
+	of_node_get(parent);
 	bus = of_match_bus(parent);
 
 	/* Count address cells & copy address locally */
 	bus->count_cells(parent, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
-		pr_debug("Bad cell count for %pOF\n", dev);
+		pr_debug("Bad cell count for %pOF\n", parent);
 		goto bail;
 	}
 	memcpy(addr, in_addr, na * 4);
@@ -610,9 +609,8 @@ static u64 __of_translate_address(struct device_node *dev,
 		struct logic_pio_hwaddr *iorange;
 
 		/* Switch to parent bus */
-		of_node_put(dev);
 		dev = parent;
-		parent = get_parent(dev);
+		parent = get_parent(parent);
 
 		/* If root, we have finished */
 		if (parent == NULL) {
@@ -650,6 +648,8 @@ static u64 __of_translate_address(struct device_node *dev,
 			break;
 
 		/* Complete the move up one level */
+		of_node_put(dev);
+		dev = parent;
 		na = pna;
 		ns = pns;
 		bus = pbus;
@@ -668,8 +668,10 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, of_get_parent,
-				     in_addr, "ranges", &host);
+	pr_debug("** translation for device %pOF **\n", dev);
+
+	ret = __of_translate_address_parent(dev->parent, of_get_parent,
+					    in_addr, "ranges", &host);
 	if (host) {
 		of_node_put(host);
 		return OF_BAD_ADDR;
@@ -697,14 +699,14 @@ static struct device_node *__of_get_dma_parent(const struct device_node *np)
 	return of_node_get(args.np);
 }
 
-u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
+static u64 of_translate_dma_address_parent(struct device_node *parent,
+					   const __be32 *in_addr)
 {
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, __of_get_dma_parent,
-				     in_addr, "dma-ranges", &host);
-
+	ret = __of_translate_address_parent(parent, __of_get_dma_parent, in_addr,
+					    "dma-ranges", &host);
 	if (host) {
 		of_node_put(host);
 		return OF_BAD_ADDR;
@@ -712,6 +714,14 @@ u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 
 	return ret;
 }
+
+u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
+{
+	pr_debug("** translation for device %pOF **\n", dev);
+
+	return of_translate_dma_address_parent(__of_get_dma_parent(dev->parent),
+					       in_addr);
+}
 EXPORT_SYMBOL(of_translate_dma_address);
 
 const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
@@ -759,8 +769,10 @@ static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
 	unsigned long port;
 	struct device_node *host;
 
-	taddr = __of_translate_address(dev, of_get_parent,
-				       in_addr, "ranges", &host);
+	pr_debug("** translation for device %pOF **\n", dev);
+
+	taddr = __of_translate_address_parent(dev->parent, of_get_parent,
+					      in_addr, "ranges", &host);
 	if (host) {
 		/* host-specific port access */
 		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
-- 
2.23.0

