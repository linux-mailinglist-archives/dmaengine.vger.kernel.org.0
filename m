Return-Path: <dmaengine+bounces-11245-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UiyADeJkI2rrsQEAu9opvQ
	(envelope-from <dmaengine+bounces-11245-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:08:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401664BF56
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=olh+U113;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11245-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11245-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45B8F305A5C9
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE072D9797;
	Sat,  6 Jun 2026 00:02:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003E2BEFE8;
	Sat,  6 Jun 2026 00:02:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704144; cv=none; b=YRQ/HFh+hvYe9MZTGSj6saz5Nhd1ozDgk05IlpR9Q5fRDE71FXsqTwkPxA1YM5cMVPfqcRXxTKcYIOy+P6TowQlLOirBFep6WcDlcBGffp6yuD+SmWmWjHGBEX4fthbuga9K0fUwavmov7x9WzmzhD0Jl0pdYAf1huLNZg82xLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704144; c=relaxed/simple;
	bh=CN0I+xotu9H3/eU6UYvjHZjRPVYXAIfurZFwH5UCUG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkYwSG2pTcBNsAB/wdU16q3xy/M5fdCPfB5n31/NKKxMSRoBZmU4SJWdHJVfz+EQq0uhaCLphD6pEimF0wzK4f4g6wwbk4Pmrp99eG0NoDOLjMcqhj52o6IFudWmxhNgRq8L8w6TzMxxT05M1M2Kr0QG8DGoM7lH5GM05AJ2ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olh+U113; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E52ACC2BCB4;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=CN0I+xotu9H3/eU6UYvjHZjRPVYXAIfurZFwH5UCUG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=olh+U113Hm3X1ZPUtaIcgd1lam7bI/lhYkknzx9J7YBNui6a6WNu4ZtYM0RvIC/AJ
	 R5BTlopZjrys85AGx6b77Esv3Myd/TzxM31a7p1QYWa1PLxah5sd+JFUgspi7yEJGI
	 JIAduFGIj+I4KjtgMqhrLGdB5XsQKmk3hPE4Ohl5nhUnMqTp9ISqSuQpKHQnp5OZ/F
	 XURi87kfkzF6adqEu4GL738T50gktzznDuITDMZtHzrcODEGP+5v2NUTA6YjvQUJor
	 m/93B8e2gRy+uWpyNyDgoFT6+D/N3VP10MZenM/TmhiP0DLcA0m2Iwi9mguVKN0vYc
	 Vx+nCIH2ttdEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB0ECD8C8B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:26 -0500
Subject: [PATCH v3 23/23] dmaengine: sdxi: Add DMA engine provider
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-23-4d38ca2bdffe@amd.com>
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
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=17048;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=F11Z7ijEZLO1+5NUxTgTWxs5O81cPT3FIiv2kCF1Bkg=;
 b=BvxGqrUKZPk/Hw4EzjNM5dw6jjTqbLhs+g1xPzyawD+4j6U1p86mfusIjCJgv5Nv/F0ys2zIC
 LVWpSqhebMvCWXvw7vydSxodJNppVLlnuGGarns/DkgSX3KGxQpTMzT
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
	TAGGED_FROM(0.00)[bounces-11245-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:email,amd.com:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9401664BF56

From: Nathan Lynch <nathan.lynch@amd.com>

Register a DMA engine provider that implements memcpy. The number of
channels per SDXI function can be controlled via a module
parameter (dma_channels). The provider uses the virt-dma library.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Kconfig  |   1 +
 drivers/dma/sdxi/Makefile |   1 +
 drivers/dma/sdxi/device.c |   2 +
 drivers/dma/sdxi/dma.c    | 501 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h    |  11 +
 5 files changed, 516 insertions(+)

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index 314b3e725ccb..85e23608405c 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -4,6 +4,7 @@ config SDXI_CORE
 	# SDXI 1.0 9 MMIO Control Registers.
 	depends on 64BIT
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for Smart Data Accelerator Interface (SDXI)
 	  Platform Data Mover devices. SDXI is a vendor-neutral
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 5218ae2c86ae..d7ea5776191e 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -5,6 +5,7 @@ sdxi-core-y := \
 	context.o     \
 	descriptor.o  \
 	device.o      \
+	dma.o         \
 	ring.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 26be376c9545..d6097a6d8992 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -22,6 +22,7 @@
 #include <linux/xarray.h>
 
 #include "context.h"
+#include "dma.h"
 #include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
@@ -321,6 +322,7 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
+	sdxi_dma_register(sdxi);
 	return 0;
 }
 
diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
new file mode 100644
index 000000000000..01c85cc2763d
--- /dev/null
+++ b/drivers/dma/sdxi/dma.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI dmaengine provider
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/spinlock.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+#include "completion.h"
+#include "context.h"
+#include "descriptor.h"
+#include "dma.h"
+#include "ring.h"
+#include "sdxi.h"
+
+static unsigned short dma_channels = 1;
+module_param(dma_channels, ushort, 0644);
+MODULE_PARM_DESC(dma_channels, "DMA channels per function (default: 1)");
+
+/*
+ * An SDXI context is allocated for each channel configured.
+ *
+ * Each context has a descriptor ring with a minimum of 1K entries.
+ * SDXI supports a variety of primitive operations, e.g. copy,
+ * interrupt, nop. Each Linux virtual DMA descriptor may be composed
+ * of a grouping of SDXI descriptors in the ring. E.g. two SDXI
+ * descriptors (copy, then interrupt) to implement a
+ * dma_async_tx_descriptor for memcpy with DMA_PREP_INTERRUPT flag.
+ *
+ * dma_device->device_prep_dma_* functions reserve space in the
+ * descriptor ring and serialize SDXI descriptors implementing the
+ * operation to the reserved slots, leaving their valid (vl) bits
+ * clear. A single virtual descriptor is added to the allocated list.
+ *
+ * dma_async_tx_descriptor->tx_submit() invokes vchan_tx_submit(),
+ * which merely assigns a cookie and moves the txd to the submitted
+ * list without entering the SDXI provider code.
+ *
+ * dma_device->device_issue_pending() (sdxi_dma_issue_pending()) sets vl
+ * on each SDXI descriptor reachable from the submitted list, then
+ * rings the context doorbell. The submitted txds are moved to the
+ * issued list via vchan_issue_pending().
+ */
+
+struct sdxi_dma_chan {
+	struct virt_dma_chan vchan;
+	struct sdxi_cxt *cxt;
+	unsigned int vector;
+	unsigned int irq;
+	struct sdxi_akey_ent *akey;
+};
+
+struct sdxi_dma_dev {
+	struct dma_device dma_dev;
+	size_t nr_channels;
+	struct sdxi_dma_chan sdchan[] __counted_by(nr_channels);
+};
+
+/*
+ * A virtual descriptor can correspond to a group of SDXI hardware descriptors.
+ */
+struct sdxi_dma_desc {
+	struct virt_dma_desc vdesc;
+	struct sdxi_ring_resv resv;
+	struct sdxi_completion *completion;
+};
+
+static struct sdxi_dma_chan *to_sdxi_dma_chan(const struct dma_chan *dma_chan)
+{
+	const struct virt_dma_chan *vchan;
+
+	vchan = container_of_const(dma_chan, struct virt_dma_chan, chan);
+	return container_of(vchan, struct sdxi_dma_chan, vchan);
+}
+
+static struct sdxi_dma_desc *
+to_sdxi_dma_desc(const struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct sdxi_dma_desc, vdesc);
+}
+
+static void sdxi_tx_desc_free(struct virt_dma_desc *vdesc)
+{
+	struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
+
+	sdxi_completion_free(sddesc->completion);
+	kfree(to_sdxi_dma_desc(vdesc));
+}
+
+static struct sdxi_dma_desc *
+prep_memcpy_intr(struct dma_chan *dma_chan, const struct sdxi_copy *params)
+{
+	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
+	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
+	struct sdxi_desc *copy, *intr;
+
+	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
+	if (!comp)
+		return NULL;
+
+	struct sdxi_dma_desc *sddesc __free(kfree) = kzalloc(sizeof(*sddesc), GFP_NOWAIT);
+	if (!sddesc)
+		return NULL;
+
+	if (sdxi_ring_try_reserve(cxt->ring_state, 2, &sddesc->resv))
+		return NULL;
+
+	copy = sdxi_ring_resv_next(&sddesc->resv);
+	(void)sdxi_encode_copy(copy, params); /* Caller checked validity. */
+	sdxi_desc_set_fence(copy); /* Conservatively fence every descriptor. */
+	sdxi_completion_attach(copy, comp);
+
+	sddesc->completion = no_free_ptr(comp);
+
+	intr = sdxi_ring_resv_next(&sddesc->resv);
+	sdxi_encode_intr(intr, &(const struct sdxi_intr) {
+			.akey = sdxi_akey_index(cxt, akey),
+		});
+	/* Raise the interrupt only after the copy has completed. */
+	sdxi_desc_set_fence(intr);
+	return_ptr(sddesc);
+}
+
+static struct sdxi_dma_desc *
+prep_memcpy_nointr(struct dma_chan *dma_chan, const struct sdxi_copy *params)
+{
+	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
+	struct sdxi_desc *copy;
+
+	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
+	if (!comp)
+		return NULL;
+
+	struct sdxi_dma_desc *sddesc __free(kfree) = kzalloc(sizeof(*sddesc), GFP_NOWAIT);
+	if (!sddesc)
+		return NULL;
+
+	if (sdxi_ring_try_reserve(cxt->ring_state, 1, &sddesc->resv))
+		return NULL;
+
+	copy = sdxi_ring_resv_next(&sddesc->resv);
+	(void)sdxi_encode_copy(copy, params); /* Caller checked validity. */
+	sdxi_completion_attach(copy, comp);
+
+	sddesc->completion = no_free_ptr(comp);
+	return_ptr(sddesc);
+}
+
+static struct dma_async_tx_descriptor *
+sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		     dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
+	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
+	u16 akey_index = sdxi_akey_index(cxt, akey);
+	struct sdxi_dma_desc *sddesc;
+	struct sdxi_copy copy = {
+		.src = src,
+		.dst = dst,
+		.src_akey = akey_index,
+		.dst_akey = akey_index,
+		.len = len,
+	};
+
+	/*
+	 * Perform a trial encode to a dummy descriptor on the stack
+	 * so we can reject bad inputs without touching the ring
+	 * state.
+	 */
+	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
+		return NULL;
+
+	sddesc = (flags & DMA_PREP_INTERRUPT) ?
+		prep_memcpy_intr(dma_chan, &copy) :
+		prep_memcpy_nointr(dma_chan, &copy);
+
+	if (!sddesc)
+		return NULL;
+
+	return vchan_tx_prep(to_virt_chan(dma_chan), &sddesc->vdesc, flags);
+}
+
+static enum dma_status sdxi_tx_status(struct dma_chan *chan,
+				      dma_cookie_t cookie,
+				      struct dma_tx_state *state)
+{
+	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(chan);
+	struct sdxi_dma_desc *sddesc;
+	enum dma_status status;
+	struct virt_dma_desc *vdesc;
+
+	status = dma_cookie_status(chan, cookie, state);
+	if (status == DMA_COMPLETE)
+		return status;
+
+	guard(spinlock_irqsave)(&sdchan->vchan.lock);
+
+	vdesc = vchan_find_desc(&sdchan->vchan, cookie);
+	if (!vdesc)
+		return status;
+
+	sddesc = to_sdxi_dma_desc(vdesc);
+
+	if (WARN_ON_ONCE(!sddesc->completion))
+		return DMA_ERROR;
+
+	if (!sdxi_completion_signaled(sddesc->completion))
+		return DMA_IN_PROGRESS;
+
+	if (sdxi_completion_errored(sddesc->completion))
+		return DMA_ERROR;
+
+	list_del(&vdesc->node);
+	vchan_cookie_complete(vdesc);
+
+	return dma_cookie_status(chan, cookie, state);
+}
+
+static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
+	struct virt_dma_desc *vdesc;
+	u64 dbval = 0;
+
+	scoped_guard(spinlock_irqsave, &vchan->lock) {
+		/*
+		 * This can happen with racing submitters.
+		 */
+		if (list_empty(&vchan->desc_submitted))
+			return;
+
+		list_for_each_entry(vdesc, &vchan->desc_submitted, node) {
+			struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
+			struct sdxi_desc *hwdesc;
+
+			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc)
+				sdxi_desc_make_valid(hwdesc);
+			/*
+			 * The reservations ought to be ordered
+			 * ascending, but use umax() just in case.
+			 */
+			dbval = umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);
+		}
+
+		vchan_issue_pending(vchan);
+	}
+
+	/*
+	 * The implementation is required to handle out-of-order
+	 * doorbell updates; we can do this after dropping the
+	 * lock.
+	 */
+	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
+}
+
+static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
+	u64 dbval = 0;
+
+	/*
+	 * Allocated and submitted txds are in the ring but not valid
+	 * yet. Overwrite them with nops and then set their valid
+	 * bits.
+	 *
+	 * The implementation may start consuming these as soon as the
+	 * valid bits flip. sdxi_dma_synchronize() will ensure they're
+	 * all done.
+	 */
+	scoped_guard(spinlock_irqsave, &vchan->lock) {
+		struct virt_dma_desc *vdesc;
+		LIST_HEAD(head);
+
+		list_splice_tail_init(&vchan->desc_allocated, &head);
+		list_splice_tail_init(&vchan->desc_submitted, &head);
+
+		if (list_empty(&head))
+			return 0;
+
+		list_for_each_entry(vdesc, &head, node) {
+			struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
+			struct sdxi_desc *hwdesc;
+
+			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc) {
+				sdxi_serialize_nop(hwdesc);
+				sdxi_desc_make_valid(hwdesc);
+			}
+
+			dbval = umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);
+		}
+
+		list_splice_tail(&head, &vchan->desc_terminated);
+	}
+
+	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
+
+	return 0;
+}
+
+static void sdxi_dma_synchronize(struct dma_chan *dma_chan)
+{
+	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
+	struct sdxi_ring_resv resv;
+	struct sdxi_desc *nop;
+	int err;
+
+	/* Submit a single nop with fence and wait for it to complete. */
+
+	if (sdxi_ring_reserve(cxt->ring_state, 1, &resv))
+		return;
+
+	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
+	if (!comp)
+		return;
+
+	nop = sdxi_ring_resv_next(&resv);
+	sdxi_serialize_nop(nop);
+	sdxi_completion_attach(nop, comp);
+	sdxi_desc_set_fence(nop);
+	sdxi_desc_make_valid(nop);
+	sdxi_cxt_push_doorbell(cxt, sdxi_ring_resv_dbval(&resv));
+
+	err = sdxi_completion_poll(comp);
+	WARN_ONCE(err, "got %d polling cst_blk", err);
+
+	vchan_synchronize(to_virt_chan(dma_chan));
+}
+
+static irqreturn_t sdxi_dma_cxt_irq(int irq, void *data)
+{
+	struct sdxi_dma_chan *sdchan = data;
+	struct virt_dma_chan *vchan = &sdchan->vchan;
+	struct virt_dma_desc *vdesc;
+	bool completed = false;
+
+	guard(spinlock_irqsave)(&vchan->lock);
+
+	while ((vdesc = vchan_next_desc(vchan))) {
+		struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
+
+		if (!sdxi_completion_signaled(sddesc->completion))
+			break;
+
+		list_del(&vdesc->node);
+		vchan_cookie_complete(&sddesc->vdesc);
+		completed = true;
+	}
+
+	if (completed)
+		sdxi_ring_wake_up(sdchan->cxt->ring_state);
+
+	return IRQ_HANDLED;
+}
+
+static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dma_chan->device->dev);
+	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
+	int vector, irq, err;
+
+	sdchan->cxt = sdxi_cxt_new(sdxi);
+	if (!sdchan->cxt)
+		return -ENOMEM;
+	/*
+	 * This irq and akey setup should perhaps all be pushed into
+	 * the context allocation.
+	 */
+	err = vector = sdxi_alloc_vector(sdxi);
+	if (vector < 0)
+		goto exit_cxt;
+
+	sdchan->vector = vector;
+
+	err = irq = sdxi_vector_to_irq(sdxi, vector);
+	if (irq < 0)
+		goto free_vector;
+
+	sdchan->irq = irq;
+
+	/*
+	 * Note this akey entry is used for both the completion
+	 * interrupt and source and destination access for copies.
+	 */
+	sdchan->akey = sdxi_alloc_akey(sdchan->cxt);
+	if (!sdchan->akey) {
+		err = -ENOMEM;
+		goto free_vector;
+	}
+
+	*sdchan->akey = (typeof(*sdchan->akey)) {
+		.intr_num = cpu_to_le16(FIELD_PREP(SDXI_AKEY_ENT_VL, 1) |
+					FIELD_PREP(SDXI_AKEY_ENT_IV, 1) |
+					FIELD_PREP(SDXI_AKEY_ENT_INTR_NUM,
+						   vector)),
+	};
+
+	err = request_irq(sdchan->irq, sdxi_dma_cxt_irq,
+			  IRQF_TRIGGER_NONE, "SDXI DMAengine", sdchan);
+	if (err)
+		goto free_akey;
+
+	err = sdxi_start_cxt(sdchan->cxt);
+	if (err)
+		goto free_irq;
+
+	return 0;
+free_irq:
+	free_irq(sdchan->irq, sdchan);
+free_akey:
+	sdxi_free_akey(sdchan->cxt, sdchan->akey);
+free_vector:
+	sdxi_free_vector(sdxi, vector);
+exit_cxt:
+	sdxi_cxt_exit(sdchan->cxt);
+	return err;
+}
+
+static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
+
+	sdxi_stop_cxt(sdchan->cxt);
+	free_irq(sdchan->irq, sdchan);
+	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
+	sdxi_free_akey(sdchan->cxt, sdchan->akey);
+	vchan_free_chan_resources(to_virt_chan(dma_chan));
+	sdxi_cxt_exit(sdchan->cxt);
+}
+
+int sdxi_dma_register(struct sdxi_dev *sdxi)
+{
+	struct device *dev = sdxi->dev;
+	struct sdxi_dma_dev *sddev;
+	struct dma_device *dma_dev;
+	int err;
+
+	if (!dma_channels)
+		return 0;
+	/*
+	 * Note that this code assumes the device supports the
+	 * interrupt operation group (IntrGrp), which is optional. See
+	 * SDXI 1.0 Table 6-1 SDXI Operation Groups.
+	 *
+	 * TODO: check sdxi->op_grp_cap for IntrGrp support and error
+	 * out if it's missing.
+	 */
+
+	sddev = devm_kzalloc(dev, struct_size(sddev, sdchan, dma_channels),
+			     GFP_KERNEL);
+	if (!sddev)
+		return -ENOMEM;
+
+	sddev->nr_channels = dma_channels;
+
+	dma_dev = &sddev->dma_dev;
+	*dma_dev = (typeof(*dma_dev)) {
+		.dev                 = dev,
+		.src_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
+		.dst_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
+		.directions          = BIT(DMA_MEM_TO_MEM),
+		.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR,
+
+		.device_alloc_chan_resources = sdxi_dma_alloc_chan_resources,
+		.device_free_chan_resources  = sdxi_dma_free_chan_resources,
+
+		.device_prep_dma_memcpy = sdxi_dma_prep_memcpy,
+
+		.device_terminate_all = sdxi_dma_terminate_all,
+		.device_synchronize = sdxi_dma_synchronize,
+		.device_tx_status = sdxi_tx_status,
+		.device_issue_pending = sdxi_dma_issue_pending,
+	};
+
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	for (size_t i = 0; i < sddev->nr_channels; ++i) {
+		struct sdxi_dma_chan *sdchan = &sddev->sdchan[i];
+
+		sdchan->vchan.desc_free = sdxi_tx_desc_free;
+		vchan_init(&sdchan->vchan, &sddev->dma_dev);
+	}
+
+	err = dmaenginem_async_device_register(dma_dev);
+	if (err)
+		return dev_warn_probe(dev, err, "failed to register dma device\n");
+
+	return 0;
+}
diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
new file mode 100644
index 000000000000..d38870ea7d91
--- /dev/null
+++ b/drivers/dma/sdxi/dma.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+
+#ifndef DMA_SDXI_DMA_H
+#define DMA_SDXI_DMA_H
+
+struct sdxi_dev;
+
+int sdxi_dma_register(struct sdxi_dev *sdxi);
+
+#endif /* DMA_SDXI_DMA_H */

-- 
2.54.0



