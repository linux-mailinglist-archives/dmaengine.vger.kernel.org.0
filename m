Return-Path: <dmaengine+bounces-10305-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGv/EjQrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10305-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC01514EEF
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 491AE302AC0F
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66944D2ED7;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuP1iOTG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72F4C8FFB;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=ChDn1pDlNm1IgyRuh2zp3/hV8iS0ZsKHEx6+TWhhqsBt+rTcl0zHkvI/eiwxwbiqVLUV0uWHhqs3fQp409PlL+6RZZNAKO3OjKJy84gXdRBEC4NdJvRppgrpOoBNQlkvQsbQAPt72C0CK7iP2XWdT2COoqmn6rilsbnit16bUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=NSETEZbF09ZJMqFODn4bgLkkeYmfkWydN+/5G/6suvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRkc9NTpT4Jee8m0oVHHZ5FhuKijg8+E3gbaA26HMuTEzI/2OUQroS6ZaFnrEMP45rAuLD/isBG4X1Bxhk6uKDoTwSTqUdS8tx7+mUPpzH0txhYuoDOrnJnTiqQXg8xKH4rWOf4e8X2qQ9NqtYpuzq+zQwZuDmlUHE6YdsMPsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuP1iOTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68BA1C2BD05;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=NSETEZbF09ZJMqFODn4bgLkkeYmfkWydN+/5G/6suvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fuP1iOTG7ErmXA4e3jGFmagNhI5h3wY6Z3YND4z8qVhmeahjQFS8wFApa3iBdg81L
	 9QrEcqYgbQ/e938ahXHOhdUd7w+nRGSI+rPldwTmNGS6xP3XsZ3t+1MPJP9v7C++iy
	 ayTS1bhyre7XBLcp0ic/8KHEjLmtuTT31iTP5qksm25AnTDUlpm2SkOdtGirj7n1mv
	 bN7xddYx8zaHaGw4XHJfqb3ogikFB91ZXxs4UPcjlr3YQuQ7nwYUWblvhfAo1aS9+L
	 szQxP0YdMfaDUOqc2OnQULVDRduI7NEyxBcgBnIBDzJ0NMoHG5d7zf2dcfwprBRHM/
	 ILmN4xI4m3b5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7DDCD4842;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:16 -0500
Subject: [PATCH v2 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
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
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=9720;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=UerzXmANCQghuCKVRb8KJTaQjaWDLFbt4QR8TfflFw0=;
 b=yNIZTNRQWqRiMzRKaFfWw2OLHpcHxJ5Rxk98afEI029+fju9Zv0PwSGxPs9lREo8GzbVwGcOb
 MLdhQEsRaWeC6FGI9qqivwsJnqcCnVZOYgJVPK25/pbfHR7ZSw2syyJ
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: DFC01514EEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10305-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Discover via the capability registers the doorbell region stride, the
maximum supported context ID, the operation groups implemented, and
limits on buffer and control structure sizes. The driver has the
option of writing more conservative limits to the ctl2 register, but
it uses those supplied by the implementation for now.

Introduce device register definitions and associated masks via mmio.h.

Add convenience wrappers which are first used here:
- sdxi_read64()
- sdxi_write64()

Report the version of the standard to which the device conforms, e.g.

  sdxi 0000:00:03.0: SDXI 1.0 device found

After bus-specific initialization, force the SDXI function to stopped
state. This is the expected state from reset, but kexec or driver bugs
can leave a function in other states from which the initialization
code must be able to recover.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 172 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/mmio.h   |  51 ++++++++++++++
 drivers/dma/sdxi/sdxi.h   |  19 +++++
 3 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index b718ce04afa0..f9a9944ad892 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -5,14 +5,180 @@
  * Copyright Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
+#include <linux/time.h>
 
+#include "mmio.h"
 #include "sdxi.h"
 
+enum sdxi_fn_gsv {
+	SDXI_GSV_STOP     = 0,
+	SDXI_GSV_INIT     = 1,
+	SDXI_GSV_ACTIVE   = 2,
+	SDXI_GSV_STOPG_SF = 3,
+	SDXI_GSV_STOPG_HD = 4,
+	SDXI_GSV_ERROR    = 5,
+};
+
+static const char *const gsv_strings[] = {
+	[SDXI_GSV_STOP]     = "stopped",
+	[SDXI_GSV_INIT]     = "initializing",
+	[SDXI_GSV_ACTIVE]   = "active",
+	[SDXI_GSV_STOPG_SF] = "soft stopping",
+	[SDXI_GSV_STOPG_HD] = "hard stopping",
+	[SDXI_GSV_ERROR]    = "error",
+};
+
+static const char *gsv_str(enum sdxi_fn_gsv gsv)
+{
+	if ((size_t)gsv < ARRAY_SIZE(gsv_strings))
+		return gsv_strings[(size_t)gsv];
+
+	WARN_ONCE(1, "unexpected gsv %u\n", gsv);
+
+	return "unknown";
+}
+
+enum sdxi_fn_gsr {
+	SDXI_GSRV_RESET   = 0,
+	SDXI_GSRV_STOP_SF = 1,
+	SDXI_GSRV_STOP_HD = 2,
+	SDXI_GSRV_ACTIVE  = 3,
+};
+
+static enum sdxi_fn_gsv sdxi_dev_gsv(const struct sdxi_dev *sdxi)
+{
+	u64 sts0 = sdxi_read64(sdxi, SDXI_MMIO_STS0);
+	enum sdxi_fn_gsv gsv = FIELD_GET(SDXI_MMIO_STS0_FN_GSV, sts0);
+
+	switch (gsv) {
+	case SDXI_GSV_STOP ... SDXI_GSV_ERROR:
+		break;
+	default:
+		dev_warn_ratelimited(sdxi->dev, "unknown gsv %u\n", gsv);
+		break;
+	}
+
+	return gsv;
+}
+
+static const unsigned long gsv_poll_interval_us = USEC_PER_MSEC;
+static const unsigned long gsv_transition_timeout_us = USEC_PER_SEC;
+
+#define sdxi_dev_gsv_poll(sdxi, val, cond)				\
+	read_poll_timeout(sdxi_dev_gsv, val, cond, gsv_poll_interval_us, \
+			  gsv_transition_timeout_us, false, sdxi)
+
+static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
+{
+	u64 ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, cmd);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+}
+
+/* Get the device to the GSV_STOP state. */
+static int sdxi_dev_stop(struct sdxi_dev *sdxi)
+{
+	enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
+	int ret;
+
+	dev_dbg(sdxi->dev, "attempting stop, current state: %s\n",
+		gsv_str(status));
+
+	switch (status) {
+	case SDXI_GSV_INIT:
+	case SDXI_GSV_ACTIVE:
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
+		break;
+	case SDXI_GSV_STOPG_SF:
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
+		break;
+	case SDXI_GSV_STOPG_HD:
+	case SDXI_GSV_ERROR:
+		/*
+		 * If hard-stopping, there's nothing to do but wait.
+		 * If in error state, the reset is issued below.
+		 */
+		break;
+	default:
+		/* Unrecognized state; try a reset. */
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
+		break;
+	}
+
+	/* Wait for transition to either stop or error state. */
+	ret = sdxi_dev_gsv_poll(sdxi, status,
+				status == SDXI_GSV_STOP ||
+				status == SDXI_GSV_ERROR);
+
+	if (ret == 0 && status == SDXI_GSV_ERROR) {
+		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
+		ret = sdxi_dev_gsv_poll(sdxi, status, status == SDXI_GSV_STOP);
+	}
+
+	if (ret) {
+		dev_err(sdxi->dev, "stop timed out, current state: %s\n",
+			gsv_str(status));
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * See SDXI 1.0 4.1.8 Activation of the SDXI Function by Software.
+ */
+static int sdxi_fn_activate(struct sdxi_dev *sdxi)
+{
+	u64 version, cap0, cap1, ctl2;
+	int err;
+
+	/*
+	 * Clear any existing configuration from MMIO_CTL0 and ensure
+	 * the function is in GSV_STOP state.
+	 */
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
+	err = sdxi_dev_stop(sdxi);
+	if (err)
+		return err;
+
+	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
+	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
+		  FIELD_GET(SDXI_MMIO_VERSION_MAJOR, version),
+		  FIELD_GET(SDXI_MMIO_VERSION_MINOR, version));
+
+	/* Read capabilities and features. */
+	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
+	sdxi->db_stride = SZ_4K;
+	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
+
+	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
+	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
+	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
+
+	/* Apply our configuration. */
+	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_BUFFER,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_AKEY_SZ,
+			   FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1));
+	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_OPB_000_AVL,
+			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
+	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
+	int err;
 
 	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
 	if (!sdxi)
@@ -22,5 +188,9 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	sdxi->bus_ops = ops;
 	dev_set_drvdata(dev, sdxi);
 
-	return sdxi->bus_ops->init(sdxi);
+	err = sdxi->bus_ops->init(sdxi);
+	if (err)
+		return err;
+
+	return sdxi_fn_activate(sdxi);
 }
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
new file mode 100644
index 000000000000..c9a11c3f2f76
--- /dev/null
+++ b/drivers/dma/sdxi/mmio.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * SDXI MMIO register offsets and layouts.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_MMIO_H
+#define DMA_SDXI_MMIO_H
+
+#include <linux/bits.h>
+
+enum sdxi_reg {
+	/* SDXI 1.0 9.1 General Control and Status Registers */
+	SDXI_MMIO_CTL0       = 0x00000,
+	SDXI_MMIO_CTL2       = 0x00010,
+	SDXI_MMIO_STS0       = 0x00100,
+	SDXI_MMIO_CAP0       = 0x00200,
+	SDXI_MMIO_CAP1       = 0x00208,
+	SDXI_MMIO_VERSION    = 0x00210,
+};
+
+/* SDXI 1.0 Table 9-2: MMIO_CTL0 */
+#define SDXI_MMIO_CTL0_FN_GSR         GENMASK_ULL(1, 0)
+
+/* SDXI 1.0 Table 9-4: MMIO_CTL2 */
+#define SDXI_MMIO_CTL2_MAX_BUFFER  GENMASK_ULL(3, 0)
+#define SDXI_MMIO_CTL2_MAX_AKEY_SZ GENMASK_ULL(15, 12)
+#define SDXI_MMIO_CTL2_MAX_CXT     GENMASK_ULL(31, 16)
+#define SDXI_MMIO_CTL2_OPB_000_AVL GENMASK_ULL(63, 32)
+
+/* SDXI 1.0 Table 9-5: MMIO_STS0 */
+#define SDXI_MMIO_STS0_FN_GSV GENMASK_ULL(2, 0)
+
+/* SDXI 1.0 Table 9-6: MMIO_CAP0 */
+#define SDXI_MMIO_CAP0_SFUNC          GENMASK_ULL(15, 0)
+#define SDXI_MMIO_CAP0_DB_STRIDE      GENMASK_ULL(22, 20)
+#define SDXI_MMIO_CAP0_MAX_DS_RING_SZ GENMASK_ULL(28, 24)
+
+/* SDXI 1.0 Table 9-7: MMIO_CAP1 */
+#define SDXI_MMIO_CAP1_MAX_BUFFER    GENMASK_ULL(3, 0)
+#define SDXI_MMIO_CAP1_MAX_AKEY_SZ   GENMASK_ULL(15, 12)
+#define SDXI_MMIO_CAP1_MAX_CXT       GENMASK_ULL(31, 16)
+#define SDXI_MMIO_CAP1_OPB_000_CAP   GENMASK_ULL(63, 32)
+
+/* SDXI 1.0 Table 9-8: MMIO_VERSION */
+#define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
+#define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
+
+#endif  /* DMA_SDXI_MMIO_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index d4c61ca2f875..84b87066f438 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -9,8 +9,12 @@
 #define DMA_SDXI_H
 
 #include <linux/compiler_types.h>
+#include <linux/dev_printk.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
+#include "mmio.h"
+
 struct sdxi_dev;
 
 /**
@@ -30,9 +34,24 @@ struct sdxi_dev {
 	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
 	void __iomem *dbs;		/* virt addr of doorbells */
 
+	/* hardware capabilities (from cap0 & cap1) */
+	u32 db_stride;			/* doorbell stride in bytes */
+	u16 max_cxtid;			/* Maximum context ID allowed. */
+	u32 op_grp_cap;			/* supported operation group cap */
+
 	const struct sdxi_bus_ops *bus_ops;
 };
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
 
+static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
+{
+	return ioread64(sdxi->ctrl_regs + reg);
+}
+
+static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
+{
+	iowrite64(val, sdxi->ctrl_regs + reg);
+}
+
 #endif /* DMA_SDXI_H */

-- 
2.54.0



