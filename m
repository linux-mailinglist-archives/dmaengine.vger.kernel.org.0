Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CCBD180
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfIXSNs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439657AbfIXSM7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D66E4AE78;
        Tue, 24 Sep 2019 18:12:56 +0000 (UTC)
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
Subject: [PATCH 05/11] of: expose __of_get_dma_parent() to OF subsystem
Date:   Tue, 24 Sep 2019 20:12:36 +0200
Message-Id: <20190924181244.7159-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function was only available locally to of/address.c, make it
available to the OF subsystem.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 drivers/of/address.c    | 18 ------------------
 drivers/of/base.c       | 25 +++++++++++++++++++++++++
 drivers/of/of_private.h |  2 ++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c9eb4ebcc2e9..53666063e938 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -681,24 +681,6 @@ u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 }
 EXPORT_SYMBOL(of_translate_address);
 
-static struct device_node *__of_get_dma_parent(const struct device_node *np)
-{
-	struct of_phandle_args args;
-	int ret, index;
-
-	index = of_property_match_string(np, "interconnect-names", "dma-mem");
-	if (index < 0)
-		return of_get_parent(np);
-
-	ret = of_parse_phandle_with_args(np, "interconnects",
-					 "#interconnect-cells",
-					 index, &args);
-	if (ret < 0)
-		return of_get_parent(np);
-
-	return of_node_get(args.np);
-}
-
 static u64 of_translate_dma_address_parent(struct device_node *parent,
 					   const __be32 *in_addr)
 {
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 94f83051910c..ec161e6b5222 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -716,6 +716,31 @@ struct device_node *of_get_parent(const struct device_node *node)
 }
 EXPORT_SYMBOL(of_get_parent);
 
+/**
+ *	__of_get_dma_parent - Get a node's dma parent if any
+ *	@node:	Node to get dma parent
+ *
+ *	Returns a node pointer with refcount incremented, use
+ *	of_node_put() on it when done.
+ */
+struct device_node *__of_get_dma_parent(const struct device_node *np)
+{
+	struct of_phandle_args args;
+	int ret, index;
+
+	index = of_property_match_string(np, "interconnect-names", "dma-mem");
+	if (index < 0)
+		return of_get_parent(np);
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells",
+					 index, &args);
+	if (ret < 0)
+		return of_get_parent(np);
+
+	return of_node_get(args.np);
+}
+
 /**
  *	of_get_next_parent - Iterate to a node's parent
  *	@node:	Node to get parent of
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index b528304be244..63bb16cc454c 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -42,6 +42,8 @@ extern struct kset *of_kset;
 int __of_n_addr_cells_parent(struct device_node *parent);
 int __of_n_size_cells_parent(struct device_node *parent);
 
+struct device_node *__of_get_dma_parent(const struct device_node *np);
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
-- 
2.23.0

