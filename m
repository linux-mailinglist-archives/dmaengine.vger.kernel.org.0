Return-Path: <dmaengine+bounces-10323-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D4hAcIrAmq/ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10323-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:19:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAB515043
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A170306FC1C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0344D90DB;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ4dacy1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1524D90BB;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=MIbwCVUhawrkgsZnCTDwwZPmwHu6U0gvqf0sXpLJ5toQkG9K1hWsc+p6bEb5RsZtkw7/ii8GwQ2MxLQ5Xv6bNbW/bJ/bDxFQXSMfn+dT05a8++PDYFuWsbq0WizXcDkQG6tbV0kU+ZqrNXx8jaliGgBlobkG6pZfLqMdQ2PAvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=hEeYfinNyQBYdk2VH8i2CTElFO6SDWvfoQCs8ehVBUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpkIo/yqWStm0SXOH1ONRJFKS2PFIiMxFuVqvxmux5sJ1wtUWqaz5Ef7qqoitRbr1rYnn+0PviFvM7W8BTyh+cX99RwLENPt5Cm6xkSkHKwv8Hg/NbNwd5KNptQG1O1VqnXNza7BF25Qg92GIlEsv8j/vQS6LT4IkWsX9IujEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ4dacy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED09C2BCFA;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=hEeYfinNyQBYdk2VH8i2CTElFO6SDWvfoQCs8ehVBUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AQ4dacy17bSJu+TbFEwa+jiJL5P0Xe3gwaXvh2Us1xXLpk3yIIZehGOT4/MAX4DUS
	 OnjuY2GVmcHYvxmfX5mxx4YMAFPE/u7Wu3Pl6+8R+LCh6FsCUaOd6hdkNCt5vAxvg3
	 W3h3a172KGN4MFfXWyv1towcKMFwRDwkbxLnlxvTQmRhDzbySpBrums/WWNz9lAwz2
	 E7/wCHnwSBkMSGQuhNlwpNpms1zuIpC5dEa5vAVQc3hKJ86VbDm7TDOQ1/Omq6cJdn
	 SAwV0aKqlE+VXLSVnd/i2w2ENTjuQ9ODJ4T9tSEL600N8yliu+WhDUtgIO+YikViFN
	 qMdxoG8XNIE9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA0CD37BE;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:34 -0500
Subject: [PATCH v2 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation and
 mapping
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-22-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=6672;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=6O3p3s6+RtRiIcmrttkpN8oREXHdyOgSYCkur7b4yoY=;
 b=Jk0qdHlmA0BqYoKllpupS5/dYlfarw39FIgXJJMpFsCrXhsHkEliZnWs96YH/r0eqAuqrC0gK
 pyojg9hrsoaCEd3gbYu7SXYtZMKdUrdSBMOjkD3kGHk5NISxofS1e3d
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 65CAB515043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10323-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

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
index cc289b271ae2..79bd77639479 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/idr.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/log2.h>
@@ -327,6 +328,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
@@ -347,5 +349,7 @@ void sdxi_unregister(struct device *dev)
 		sdxi_cxt_exit(cxt);
 	xa_destroy(&sdxi->client_cxts);
 
+	ida_destroy(&sdxi->vectors);
+
 	sdxi_dev_stop(sdxi);
 }
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 0f72cd359cf5..67e28b8d7f94 100644
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
index 1786da7642cc..11773162c023 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -8,8 +8,10 @@
 #ifndef DMA_SDXI_H
 #define DMA_SDXI_H
 
+#include <linux/bug.h>
 #include <linux/compiler_types.h>
 #include <linux/dev_printk.h>
+#include <linux/idr.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
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
+	return ida_alloc_max(&sdxi->vectors, sdxi->nr_vectors - 1,
+			     GFP_KERNEL);
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



