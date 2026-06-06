Return-Path: <dmaengine+bounces-11225-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YIjIMJNjI2rVsAEAu9opvQ
	(envelope-from <dmaengine+bounces-11225-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:02:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB564BE48
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:02:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=eDJbyknj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11225-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11225-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21A2B301FB21
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F139417A31C;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46F3A1B5;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704142; cv=none; b=lXuiCK7kYIm0row9C7WOH54MoYjdHvWQIzG33NUh8sPfw4TFb5v5vQZOe4m2GUdzwXRfr+nURLLXzSR6G00JLnafTt2a5HHYehYc0/qdNRDvkfI+W4N8ojBVhlW7j+jXdXoeO7HHfleOQtE0xeQ8igjPcad4dUleJ94pxZGuOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704142; c=relaxed/simple;
	bh=foTVdj1xR36i1v4eaSphs78f9nNYMPQaV23iQF8PWZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6rwyu/YOjGQHOqxyz+wx+QkyXUZu+aAol9R/yVm7PduTywKRIH6qF/m81EWp45GKovr0246JCnY6AY6tF6ZViaUJJVJ/xt/UrVLBXhUh5Gtc7AOPKux4oULkBk148GAzZSSFotryQ+nS7l0W6FAeSp0byOq9Wv4UrE9twix6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDJbyknj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6D7C2BCFD;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=foTVdj1xR36i1v4eaSphs78f9nNYMPQaV23iQF8PWZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eDJbyknjwtvck0LgyJ9xnB8Xpg8t8oj+bdjDFK5kz+32nLyg+yWswu7bwRHzm6kHt
	 X+WoDnokmaziZpinNHQQPsw6RlHTXP8jbS4hD2DZG1gyAhx4kIZpDdVffVQ6EsRgq3
	 v+h0C8ZMnmMQQZjnUcQOFGbnOgtSroWnsQMwwyxI2BkydaqaLRoZqqifaE4/QKslHK
	 VJjY3XVqG1+Wk6nj9AeXWgAbGqXbEluKJ6wWdily4Frlq1bYQisOHsqB3bpIiu2znE
	 hwtGrscTGg+dGwf3HFiwqZ7bPyaEocZwK8H82/FFYe/3kxtXoEgKECmJMGF+BlIjpo
	 GHUBBZZJ5Igag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75188CD8C87;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:07 -0500
Subject: [PATCH v3 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-4-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=10221;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=Y+e5uc6mpl40amHjM2bcjORW4MJ8LG/xiu061nroTCg=;
 b=79DYquEvcvKl0HuU0FpiwfRuASwzlqFkU+RtzH4TrFVc5qjA24st9Ns0yG0+XuXn5zmUFoeQk
 8BZXM2Ub9O0DBMKriQnQvZUqg7RbmfoB0AlsxZTz21SHYR7wo0WV2vr
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11225-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18AB564BE48

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
 drivers/dma/sdxi/device.c | 178 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/mmio.h   |  54 ++++++++++++++
 drivers/dma/sdxi/sdxi.h   |  19 +++++
 3 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 0974a83bb45c..7c6652f9c3c0 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -5,15 +5,187 @@
  * Copyright Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
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
+	u64 version, cap0, cap1, ctl0, ctl2;
+	int err;
+
+	/*
+	 * Ensure the function is in GSV_STOP state, then clear ctl0's
+	 * pasid and error interrupt configuration while preserving
+	 * any assigned group ID (fn_grp_id).
+	 */
+	err = sdxi_dev_stop(sdxi);
+	if (err)
+		return err;
+
+	ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &ctl0, 0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID_VL, &ctl0, 0);
+	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID, &ctl0, 0);
+	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
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
@@ -23,7 +195,11 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	sdxi->bus_ops = ops;
 	dev_set_drvdata(dev, sdxi);
 
-	return sdxi->bus_ops->init(sdxi);
+	err = sdxi->bus_ops->init(sdxi);
+	if (err)
+		return err;
+
+	return sdxi_fn_activate(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
new file mode 100644
index 000000000000..f07e857691b9
--- /dev/null
+++ b/drivers/dma/sdxi/mmio.h
@@ -0,0 +1,54 @@
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
+#define SDXI_MMIO_CTL0_FN_PASID_VL    BIT_ULL(2)
+#define SDXI_MMIO_CTL0_FN_ERR_INTR_EN BIT_ULL(4)
+#define SDXI_MMIO_CTL0_FN_PASID       GENMASK_ULL(27, 8)
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
index d4c61ca2f875..721abf7556d1 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -9,8 +9,12 @@
 #define DMA_SDXI_H
 
 #include <linux/compiler_types.h>
+#include <linux/dev_printk.h>
+#include <linux/io.h>
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
+	return readq(sdxi->ctrl_regs + reg);
+}
+
+static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
+{
+	writeq(val, sdxi->ctrl_regs + reg);
+}
+
 #endif /* DMA_SDXI_H */

-- 
2.54.0



