Return-Path: <dmaengine+bounces-9978-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCvzA0D32GkYkQgAu9opvQ
	(envelope-from <dmaengine+bounces-9978-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:12:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85703D8016
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02654309D285
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821063C3BE3;
	Fri, 10 Apr 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBtF9eLu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE93BF67A;
	Fri, 10 Apr 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826471; cv=none; b=uUHJA2KVKc+v+NHDWIisiLlOYWcO0EBByBoGABgfI7Th6wR786goK06AUJ7FxvxLu9scY264p6Xa5J7dh1dil+0UER80e0t2PcIBraAZzR4Yxy0uWVepVVjur2tDtwyrp0lEsKtIF7GHLXCXKyF/SECmEvr0uiKSyPO3Dy+BFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826471; c=relaxed/simple;
	bh=G2huuPtM8dkZc7ys3YvCtddLjlcJRsje8S+Ue6LmqbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htgw1IC2PYxvY1lphIMjmqgl38lgf0Py7EFktpC+WlMDi1rAiifyC+9tikXR0AEYwHR5tkLknff1+LL/XnZerOhCuL00wX/jCbMGCCHMThrqWlc43smwipFJX8fmpwQGHBBCfKSkRwEDSQgshXX3s71DnTOIQ6DN6vwYX0Ne5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBtF9eLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0465C2BCAF;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826471;
	bh=G2huuPtM8dkZc7ys3YvCtddLjlcJRsje8S+Ue6LmqbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kBtF9eLuCD+pBYJqjlEY3TzIftzPCZffmAqfpSKPWMt1Vc/DwAL7IHKct4/a85WJD
	 0OAkdWGglJuYnopM2lDK0txfXejmx9KhgOqH6F3G1UBO+wnnxfQP4qzwoPmPYZJDLr
	 GZVKjbxce6ctMb+HgXAAX0UJSQfYW2aCOtACyyoGH8MMkvXBop76KiZDO1tbtN/bRn
	 jRyWsM60zlN31RUVsMtYSA7iSzdoGS6FrZZsKwYcZTYauVeSL2uFBqqxqIepyxdhLj
	 IP4usiJzH4Oh+1D3RyXXV3M6xOPxGwun5IlPRWn4dH1fAZ40Nn083TCJt/d5LNVbH9
	 6mq6g6jCVh6WA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B42F44860;
	Fri, 10 Apr 2026 13:07:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:32 -0500
Subject: [PATCH 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation and
 mapping
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-22-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
In-Reply-To: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=6787;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=+70bvPsXLZ6JtPOvD5LtOSlAhOg3eN58vo6yDBNKJ0s=;
 b=gNZi96Bgh+vS0dBam9zeGmkSaV4mScK2225z7j07aiU5mBGt3DVyCo+TfF8XaM2eeVgWVSM+B
 HwfUKkollP0Bl/f+3MeMuQPwo6ZQeFLagjMRwVaEuCSeylMKU7fXm5o
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9978-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com]
X-Rspamd-Queue-Id: A85703D8016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c |  4 ++++
 drivers/dma/sdxi/pci.c    | 29 +++++++++++++++++++++++-
 drivers/dma/sdxi/sdxi.h   | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index aaff6b15325a..8b11197c5781 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/idr.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
@@ -303,6 +304,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
@@ -323,5 +325,7 @@ void sdxi_unregister(struct device *dev)
 		sdxi_cxt_exit(cxt);
 	xa_destroy(&sdxi->client_cxts);
 
+	ida_destroy(&sdxi->vectors);
+
 	sdxi_dev_stop(sdxi);
 }
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 8e4dfde078ff..99430eaa583d 100644
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
@@ -53,12 +56,36 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 				     "failed to map doorbell region\n");
 	}
 
+	/*
+	 * Allocate the minimum required set of vectors plus one for
+	 * each client context supported by the function.
+	 */
+	cap1_max_cxt = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT,
+				 sdxi_read64(sdxi, SDXI_MMIO_CAP1));
+	vecs = pci_alloc_irq_vectors(pdev, SDXI_MIN_VECTORS,
+				     SDXI_MIN_VECTORS + cap1_max_cxt,
+				     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (vecs < 0) {
+		return dev_err_probe(dev, vecs,
+				     "failed to allocate MSIs (max_cxt=%u)\n",
+				     cap1_max_cxt);
+	}
+
+	sdxi->nr_vectors = vecs;
+	sdxi_dbg(sdxi, "allocated %u vectors\n", sdxi->nr_vectors);
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
index da33719735ab..d4e1236a775e 100644
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
@@ -27,6 +29,21 @@
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
@@ -39,6 +56,10 @@ struct sdxi_bus_ops {
 	 *        function initialization.
 	 */
 	int (*init)(struct sdxi_dev *sdxi);
+	/**
+	 * @get_irq: Map device interrupt index to Linux IRQ number.
+	 */
+	int (*get_irq)(struct sdxi_dev *sdxi, unsigned int index);
 };
 
 struct sdxi_dev {
@@ -61,6 +82,9 @@ struct sdxi_dev {
 	struct dma_pool *cxt_ctl_pool;
 	struct dma_pool *cst_blk_pool;
 
+	unsigned int nr_vectors;
+	struct ida vectors;
+
 	struct sdxi_cxt *admin_cxt;
 	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
@@ -76,6 +100,39 @@ static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
 #define sdxi_info(s, fmt, ...) dev_info(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
 #define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
 
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
2.53.0



