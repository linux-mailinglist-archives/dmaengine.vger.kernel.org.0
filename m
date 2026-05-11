Return-Path: <dmaengine+bounces-10320-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LR6BjcrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10320-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5D514F0C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F708301DE6B
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9E4D90C6;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVFtu6yD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895124D90A0;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=Iqe65DqcBvZr3nFb58sX5xH8woUF0FTNj6Oynyt8It/NC8oTbq33jnZ66oYwsyQCUZN6K/Vt8BLAtkPQLiCJGLCFKyvFiBKi0si1Ctyd3p0TUZGDXmTJfjF/gkT/kpe4liOgSE0cTeRNgTtf3TWF9ejP7AbuHc49Eam0+PhCoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=lrKmnbwCRdZ0fcO8gKZkDCjleZA/7rgFRaQD3GYezSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxAVNalh03Cy2p5MNLczAzfvwkF5hLhwHejTv9zs6zTvHNim0mmkyBlzp9ZwWjvWrq7gleY+khlM67HkW/uEsDdNoZ3A7FLFFTDBZmCbUD1BRCClBhTPK85bItd1slNa6yiFBS+riOk+TfAA9gXfpCr6lZ4/RFakiLxeESOLLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVFtu6yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62089C4AF19;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=lrKmnbwCRdZ0fcO8gKZkDCjleZA/7rgFRaQD3GYezSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SVFtu6yD0de1X1YK65rsPrD7D/IRDyYFPPi/sg0pwBL4/nUP911tTlj2q5KoSW8h3
	 lSuhxgynggAn4QfoG7s3AvTMVcV/PnFBh++BCuTmeCu7HAGdaeqeRU2MV/R9VVRkBs
	 REb9LGfzZqjpu1eGypiM7zAFfsEbG4nanoEpRDDsPkl6+Vt0+a30UeBpBq899trAxx
	 8NgRGWHnVI3hH7hdGoc0PzypRxW631DSUdxom++jeYYffIIzFrCd5csmD4XyUEH+Yu
	 wTIv6Qr8c+/3MT75a/1AO6nFabkQkNkPk1JRs4DjdVQ+lUV07dHeD8cmwPq7zbSNlE
	 NbEHhVjO+8jpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F3CD4855;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:30 -0500
Subject: [PATCH v2 18/23] dmaengine: sdxi: Encode context start, stop, and
 sync descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-18-889cfed17e3f@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=8361;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=dQwO4BfselYk/3ti1YIOa6wwy+gdrN39N2deDB7oPCU=;
 b=Wfb/KK6lABIgiVXyUno+QM4Vr5LfHKjNWgkUDQV8JkSn8X2Hz0aJod4cm5+Hvm/40nXK8MCxh
 OC5P6dLxRWCAIpS4Ye/A/gWv/Tgp44WwGqtNQ32DzWyjMoGy2NE0N0R
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: DDB5D514F0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10320-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce the low-level support for serializing three operation types
to the descriptor ring of the admin context: context start, context
stop, and sync. Each operation has its own distinct type that overlays
the generic struct sdxi_desc, along with a dedicated encoder function
that accepts an operation-specific parameter struct.

The parameter structs (sdxi_cxt_start, sdxi_cxt_stop, sdxi_sync)
expose only a necessary subset of the available descriptor fields to
callers, i.e. the target context range. These can be expanded over
time as needed.

Each encoder function is intended to 1) set any mandatory field values
for the descriptor type (e.g. SDXI_DSC_FE=1 for context start); and 2)
translate conventional kernel types (dma_addr_t, CPU-endian values)
from the parameter block to the descriptor in memory. While they're
expected to operate directly on descriptor ring memory, they do not
set the descriptor validity bit. That is left to the caller, which may
need to make other modifictions to the descriptor, such as attaching a
completion block, before releasing it to the SDXI implementation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile     |  1 +
 drivers/dma/sdxi/descriptor.c | 91 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/descriptor.h | 46 ++++++++++++++++++++++
 drivers/dma/sdxi/hw.h         | 64 ++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index dd08f4a5f723..08dd73a45dc7 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_SDXI) += sdxi.o
 sdxi-objs += \
 	completion.o  \
 	context.o     \
+	descriptor.o  \
 	device.o      \
 	ring.o
 
diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
new file mode 100644
index 000000000000..be2a9244ce19
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/visibility.h>
+#include <linux/bitfield.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include "hw.h"
+#include "descriptor.h"
+
+int sdxi_encode_cxt_start(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_start *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_START_NM) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.cxt_start = (typeof(desc->cxt_start)) {
+			.opcode = cpu_to_le32(opcode),
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_start);
+
+int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_stop *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.cxt_stop = (typeof(desc->cxt_stop)) {
+			.opcode = cpu_to_le32(opcode),
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
+
+int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+	u8 cflags;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_SYNC) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	cflags = FIELD_PREP(SDXI_DSC_SYNC_FLT, params->filter);
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.sync = (typeof(desc->sync)) {
+			.opcode = cpu_to_le32(opcode),
+			.cflags = cflags,
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_sync);
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
index c0f01b1be726..5b8fd7cbaa03 100644
--- a/drivers/dma/sdxi/descriptor.h
+++ b/drivers/dma/sdxi/descriptor.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/minmax.h>
 #include <linux/ratelimit.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
@@ -61,4 +62,49 @@ static inline void sdxi_desc_set_sequential(struct sdxi_desc *desc)
 	desc->opcode = cpu_to_le32(opcode);
 }
 
+struct sdxi_cxt_range {
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+static inline struct sdxi_cxt_range sdxi_cxt_range(u16 a, u16 b)
+{
+	return (struct sdxi_cxt_range) {
+		.cxt_start = min(a, b),
+		.cxt_end   = max(a, b),
+	};
+}
+
+static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
+{
+	return sdxi_cxt_range(nr, nr);
+}
+
+struct sdxi_cxt_start {
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_cxt_start(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_start *params);
+
+struct sdxi_cxt_stop {
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_stop *params);
+
+struct sdxi_sync {
+	enum sdxi_sync_filter  {
+		SDXI_SYNC_FLT_CXT  = 0x0,
+		SDXI_SYNC_FLT_STOP = 0x1,
+		SDXI_SYNC_FLT_AKEY = 0x2,
+		SDXI_SYNC_FLT_RKEY = 0x3,
+		SDXI_SYNC_FLT_FN   = 0x4,
+	} filter;
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params);
+
 #endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 178161588bd0..4dcd0a3ff0fd 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -146,12 +146,76 @@ struct sdxi_desc {
 #define SDXI_DSC_VL  BIT(0)
 #define SDXI_DSC_SE  BIT(1)
 #define SDXI_DSC_FE  BIT(2)
+#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
+#define SDXI_DSC_TYPE    GENMASK(26, 16)
 
 /* For csb_ptr field */
+#define SDXI_DSC_NP BIT_ULL(0)
 #define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
 
+#define define_sdxi_dsc(tag_, name_, op_body_)				\
+	struct tag_ {							\
+		__le32 opcode;						\
+		op_body_						\
+		__le64 csb_ptr;						\
+	} __packed name_;						\
+	static_assert(sizeof(struct tag_) ==				\
+		      sizeof(struct sdxi_dsc_generic));			\
+	static_assert(offsetof(struct tag_, csb_ptr) ==			\
+		      offsetof(struct sdxi_dsc_generic, csb_ptr))
+
+		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
+			__u8 rsvd_0;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_1[4];
+			__le64 db_value;
+			__u8 rsvd_2[32];
+		);
+
+		/* SDXI 1.0 Table 6-15: DSC_CXT_STOP Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_cxt_stop, cxt_stop,
+			__u8 rsvd_0;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_1[44];
+		);
+
+		/* SDXI 1.0 Table 6-22: DSC_SYNC Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_sync, sync,
+			__u8 cflags;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__le16 key_start;
+			__le16 key_end;
+			__u8 rsvd_0[40];
+		);
+/* For use with sync.cflags */
+#define SDXI_DSC_SYNC_FLT GENMASK(2, 0)
+
+#undef define_sdxi_dsc
 	};
 } __packed;
 static_assert(sizeof(struct sdxi_desc) == 64);
 
+/* SDXI 1.0 Table 6-1: SDXI Operation Groups */
+enum sdxi_dsc_type {
+	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
+};
+
+/* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
+enum sdxi_dsc_subtype {
+	/* Administrative */
+	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
+	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
+	SDXI_DSC_OP_SUBTYPE_SYNC         = 0x06,
+};
+
 #endif /* DMA_SDXI_HW_H */

-- 
2.54.0



