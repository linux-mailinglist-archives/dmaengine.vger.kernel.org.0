Return-Path: <dmaengine+bounces-11240-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+vqCrNkI2q8sQEAu9opvQ
	(envelope-from <dmaengine+bounces-11240-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:07:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC464BF23
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:07:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=CWSw9CXC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11240-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11240-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5997304ED49
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1E280338;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E9274B37;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=EegwiZ9WbpuTEifNn9H6Nh76w/co7SidIIGSNGdUaMgQ34084KxmOrQ85HmYFLxQ+dXtxhp0dLIh8Snja/HZbUhvvlATusoMx6fdbiWyslQQPqTKwqyOT+EI3fcEflHjEmAnxtef63T5M2hq3F+F6xjtEuJs+ST3jsysFGIODxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=n6txK7bTZ6tY8Uejz+EZK3m2XEL1aibMBM6MtcxdWQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGWLgAuwKF6D+XcnxrI7NNvEJFgx6VR/xydqhYPg+nJigBEY7bJgNp5A5e2m9R+hB4K5gUxEKA5yPwGd4jpu4n+UvuA7kyUlkvZxTGWo6msgJNM1RM2aWFWH/tCU8PdpIecIGiuOL1gRcxVCq0eVvDddzt3wpNBD375/LnyyE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWSw9CXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B20C2BCC6;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=n6txK7bTZ6tY8Uejz+EZK3m2XEL1aibMBM6MtcxdWQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CWSw9CXCJAYnlGD8SwCWUDvygiMfUVzqjDFLkMwKj9KSveB4cnXM1/820A8ZgqqC4
	 U4RJUs1KJ6cesmYpLwAt8c/mJ49gMoQaqfEixZQ+4DvzXTHXv7/t3Pmen1BfhDp/u3
	 mx1yy+ya2dhRiageoTakff54Lx1fAcCs3Pwqp7R3vzzW0/bfXf3uoETr7QVG0c8lL/
	 o5xA6c9LeNiiYaJj3VHTh51bSO2BGuTtJwfh3lkO8aXBd7PMMrhru8xCuTJFr5DkvV
	 niFH0Ca+ZZC/eixwRaKGPZbk0p96Rij6i3rkeQCl3Z8iiiu6GFy1hB6LLIzfeEUvcU
	 wMxuYds+P6j6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F440CD6E7B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:21 -0500
Subject: [PATCH v3 18/23] dmaengine: sdxi: Encode context start, stop, and
 sync descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-18-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=8400;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=ITo1ztXWz4lwv5IFNFhjzv+gOZ9b0rt77cPGs8kLH9g=;
 b=nSRpcvQT4syanFY3qnTP82zLVSHbYHeO1flIlb2xMUP8nUJEK/MViuYAPXTdPyNujKbjkjRYu
 poMp8og4gNFDLmOf40IyTAAiWhpXY9rhLI8aqI/WKV4snaa5lJMaV7x
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
	TAGGED_FROM(0.00)[bounces-11240-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FC464BF23

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
index eacad504a816..9b051eca9af7 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
 sdxi-core-y := \
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
index 5c5bef66f1fb..d340ed7dc061 100644
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
+	} __packed __aligned(64) name_;					\
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
 } __packed __aligned(64);
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



