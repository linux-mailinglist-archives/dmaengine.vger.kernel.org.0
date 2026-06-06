Return-Path: <dmaengine+bounces-11244-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IJ3NItZkI2rbsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11244-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:07:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEC64BF4E
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oWtfupyS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11244-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11244-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ECF83057E2C
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268492D1303;
	Sat,  6 Jun 2026 00:02:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA028641E;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704144; cv=none; b=mY+Q3tE/HhTTEHO3g4hSEBeyFmt4o3FhrY/PH8gVCD1L7hW4mNAzXyYrkWz65dp4JeND+34WFHI5Q6HUAxGi0uYt1ElZ1g2fI8Qsfj3Q9JXtrxnFk/t3QQU+Fj4kwx6sPiMCxeQEolDfDCCMfAfMjuzmt0+dIuth2CTQ8K8dnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704144; c=relaxed/simple;
	bh=4rQ7SHuShPecsqwQ8fZplFGBmiR2B3O2AZi5n7+SMAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErX5uXfxGA10fZ9K0aSPjQh/IyZ3AhkSQtg92wsiSLjCu72xkOqRX8URNy8rwbWQHgYSnsSJckfF5JhLqSPsmnkjavf1lJvDHpfRrynUFi5NArlz4/labdywwtZ6r8bnI5DOOW+4i2QxDKjS/yGs/t+6ez89YbGDm3Ce9yPPmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWtfupyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFD31C2BCF5;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=4rQ7SHuShPecsqwQ8fZplFGBmiR2B3O2AZi5n7+SMAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oWtfupyS0bIkJqiHYdjjdse4vh97sxZh06bDri37HYpDdtfH2k11jknUCMpHh8Hak
	 ZD3EyZVdkO6pxq3G3NkJv6fG/Ovwx4bcYpypm/w7Q3n4qg5YYNOHpT+w9HxYC7N10O
	 AjQdtduiA8/yqWOoT8LsmdhGeB7sVBVEk+f6GxrZe/Z/X8aX53A5yVEJp4xM5EIGhx
	 I/S11C9NT+bzaFu7Ki0m8Zj5W5lqkyGQe2VlyqG77zzoT8i/AY9STWarD81wncpVmq
	 lD+ZJASwQhCxuM/7Ts+B2YZa0/1RVmKXkc42QrogT2zYa+QI6UlbRDeaMidLlU69QW
	 j6Q5xhjXoLUEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7835CD6E7B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:25 -0500
Subject: [PATCH v3 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation and
 mapping
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-22-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=6724;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=55V3Gi65dyKbTVEytbitSLn8sTX3+Q0lnJO/cdnFbfo=;
 b=h8JqKAtK7xHYtj1OcazHbQJC/0YkmSP8WP63ExLXaqD6GFo2p0T6KP4vZNw0iaXvoqkGl6nMf
 Q1H5ULGr8obC0izw4dicptDYrzR9i67VBMSrNfOMsBmhXOlYfsekjSx
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11244-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@nxp.com,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3CEC64BF4E

From: Nathan Lynch <nathan.lynch@amd.com>

During PCI probe, allocate a vector per context supported by the
function as reported by the capability register, plus one for the
error log interrupt, which is always vector 0. The rest of the vector
range is available for use with interrupt-generating descriptors.

Introduce sdxi_alloc_vector() and sdxi_free_vector() which are thin
wrappers around the IDA that tracks the allocated vector range.

Introduce sdxi_vector_to_irq() which invokes a new get_irq() bus op to
translate the device-relative index to the Linux IRQ number for use
with request_irq() etc. For PCI this dispatches to pci_irq_vector().

Code such as the DMA engine provider that intends to submit interrupt
descriptors should prepare by using sdxi_alloc_vector() and
sdxi_vector_to_irq(), and clean up by using sdxi_free_vector().

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c |  4 ++++
 drivers/dma/sdxi/pci.c    | 28 ++++++++++++++++++++++-
 drivers/dma/sdxi/sdxi.h   | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index d3d1ad2f2eff..26be376c9545 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/log2.h>
@@ -334,6 +335,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
@@ -355,6 +357,8 @@ void sdxi_unregister(struct device *dev)
 		sdxi_cxt_exit(cxt);
 	xa_destroy(&sdxi->client_cxts);
 
+	ida_destroy(&sdxi->vectors);
+
 	sdxi_dev_stop(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 4d7d6812da6d..4f981e843138 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -5,6 +5,7 @@
  * Copyright Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -13,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "mmio.h"
 #include "sdxi.h"
 
 enum sdxi_mmio_bars {
@@ -29,7 +31,8 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 {
 	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
 	struct device *dev = &pdev->dev;
-	int ret;
+	unsigned int cap1_max_cxt;
+	int vecs, ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -49,12 +52,35 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
 				     "failed to map doorbell region\n");
 
+	/*
+	 * Allocate the minimum required set of vectors plus one for
+	 * each client context supported by the function.
+	 */
+	cap1_max_cxt = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
+				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
+	vecs = pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
+				     SDXI_MIN_VECTORS + cap1_max_cxt,
+				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (vecs < 0)
+		return dev_err_probe(dev, vecs,
+				     "failed to allocate MSIs (max_cxt=%u)\n",
+				     cap1_max_cxt);
+
+	sdxi->nr_vectors = vecs;
+	dev_dbg(sdxi->dev, "allocated %u vectors\n", sdxi->nr_vectors);
+
 	pci_set_master(pdev);
 	return 0;
 }
 
+static int sdxi_pci_get_irq(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	return pci_irq_vector(sdxi_to_pci_dev(sdxi), nr);
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.init = sdxi_pci_init,
+	.get_irq = sdxi_pci_get_irq,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 4e29d1f90dae..72482d7c301e 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -8,8 +8,10 @@
 #ifndef DMA_SDXI_H
 #define DMA_SDXI_H
 
+#include <linux/bug.h>
 #include <linux/compiler_types.h>
 #include <linux/dev_printk.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -25,6 +27,21 @@
 #define L1_CXT_CTRL_PTR_SHIFT		6
 #define L1_CXT_AKEY_PTR_SHIFT		12
 
+enum {
+	/*
+	 * Per SDXI 1.0 3.4 Error Log, the error log interrupt is
+	 * always vector 0.
+	 */
+	SDXI_ERROR_VECTOR = 0,
+
+	/*
+	 * Request at least one vector to account for the error log
+	 * interrupt. Increment this if the driver gains more
+	 * dedicated interrupts (e.g. one for the admin context).
+	 */
+	SDXI_MIN_VECTORS = 1,
+};
+
 struct sdxi_dev;
 
 /**
@@ -37,6 +54,10 @@ struct sdxi_bus_ops {
 	 *        function initialization.
 	 */
 	int (*init)(struct sdxi_dev *sdxi);
+	/**
+	 * @get_irq: Map device interrupt index to Linux IRQ number.
+	 */
+	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
 };
 
 struct sdxi_dev {
@@ -59,12 +80,48 @@ struct sdxi_dev {
 	struct dma_pool *cxt_ctl_pool;
 	struct dma_pool *cst_blk_pool;
 
+	unsigned int nr_vectors;
+	struct ida vectors;
+
 	struct sdxi_cxt *admin_cxt;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
 	const struct sdxi_bus_ops *bus_ops;
 };
 
+/**
+ * sdxi_alloc_vector() - Allocate an interrupt vector.
+ *
+ * A vector that will have the same lifetime as the device does not
+ * need to be released explicitly. Otherwise the vector must be
+ * released with sdxi_free_vector().
+ */
+static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
+{
+	return ida_alloc_range(&sdxi->vectors, SDXI_MIN_VECTORS,
+			       sdxi->nr_vectors - 1, GFP_KERNEL);
+}
+
+/**
+ * sdxi_free_vector() - Release a previously allocated index.
+ */
+static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	ida_free(&sdxi->vectors, nr);
+}
+
+/**
+ * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
+ *                        Linux IRQ number suitable for passing to
+ *                        request_irq() et al.
+ */
+static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
+{
+	/* Moan if the index isn't currently allocated. */
+	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
+	return sdxi->bus_ops->get_irq(sdxi, nr);
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 void sdxi_unregister(struct device *dev);
 

-- 
2.54.0



