Return-Path: <dmaengine+bounces-11241-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIZHEbZjI2r1sAEAu9opvQ
	(envelope-from <dmaengine+bounces-11241-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:03:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDB64BE6F
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:03:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=pHHOazkR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11241-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11241-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 941303054EB2
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB9288C08;
	Sat,  6 Jun 2026 00:02:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00927FD44;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=psE5nCjfJr1ecWAS8h80s8SSzwdbNS35Tlu5noyq9TY+Kc5n4pvhRjqU73iLYFpPCPV+DdwT/mK1tshn8mnimTZ3VPPhNNI48us2lhbfXBHQrx1qPTJRwcOz0rCQF1Prc//qRjEM4QpweEFN4xx6EKJAmMgZOUvDd3xoxEvhbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=CfhFOUVHuW3ofHeuIzbI6s3yDV2GuJ9tuZ5kbiDPJLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpHqo0ZaKJMr0k+27PXvlTA4Ei5GKG6+i6HNnAKGmmtYYNJGk+eVv5c8pML/yNV6OtoW1nRwxMw+63rqf8xgUtFaS/WWejrwBSOboqIpihrabWZICUhkkvofuE5x4BtLCjJTKA50sh5TUlCEkQvLSqO26adprgPega3gROS8Gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHHOazkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF024C2BCB9;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=CfhFOUVHuW3ofHeuIzbI6s3yDV2GuJ9tuZ5kbiDPJLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pHHOazkR86s08QozvI0+OCkw/JFU+Eg9BDCzbqHz8gnde8ppUCWNOWwqaQnSxbi75
	 uWv576bDLoktMJ3birP8n/aCjTAg8yVs//zPLHELUqAKwz4w7e9QfrPgIsc2xmlp5g
	 CWqtd4RiKRa8efnWYSBceiTXnfNdiHRRi88hyKAfPQyM/6sjJuSmmXql4++7jpgKUo
	 5TZhWYeX5QRc8xEnQGQBwzbeKnMQCZ5TpmW1e798ATlBjzJskXTdxlMOJJG0gbqvqC
	 r8oYkiUpBd7xBnBKm0ftHceFbxggqhymGByR9BfSZDzX4jbhy9vzYByyQ2tQms6C/X
	 S7fshkKnqARfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EDCD8C8B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:23 -0500
Subject: [PATCH v3 20/23] dmaengine: sdxi: Encode nop, copy, and interrupt
 descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-20-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=7417;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=a3ebJiN0ISff/LauBhfxJYv8Eu1uDiFLARue6Sq4bgQ=;
 b=xw7bfXU473M7bwYRtBCXxTQeO80J8zGtOPND3NQ1rI9Av7/XX5oV2HKl5d4eQgeaG9zvjU7gw
 mnznC8N7daPDGFRTSwo5/OJwOwCnJse+Ayo3nycQwt3z3siGN8tWW+q
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
	TAGGED_FROM(0.00)[bounces-11241-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,amd.com:mid,amd.com:email,amd.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBBDB64BE6F

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce low-level support for serializing three operation types to
the descriptor ring of a client context: nop, copy, and interrupt.
As with the administrative descriptor support introduced earlier, each
operation has its own distinct type that overlays the generic struct
sdxi_desc, along with a dedicated encoder function that accepts an
operation-specific parameter struct.

Copy descriptors are used to implement memcpy offload for the DMA
engine provider, and interrupt descriptors are used to signal the
completion of preceding descriptors in the ring. Nops can be used in
error paths where a ring reservation has been obtained and the caller
needs to submit valid descriptors before returning.

Conditionally expose sdxi_encode_size32() for unit testing.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/descriptor.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/descriptor.h |  25 ++++++++++
 drivers/dma/sdxi/hw.h         |  33 +++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
index be2a9244ce19..41019e747528 100644
--- a/drivers/dma/sdxi/descriptor.c
+++ b/drivers/dma/sdxi/descriptor.c
@@ -7,12 +7,119 @@
 
 #include <kunit/visibility.h>
 #include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/range.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
 #include "hw.h"
 #include "descriptor.h"
 
+VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *dest)
+{
+	/*
+	 * sizes are encoded as value - 1:
+	 * value    encoding
+	 *     1           0
+	 *     2           1
+	 *   ...
+	 *    4G  0xffffffff
+	 */
+	if (WARN_ON_ONCE(size > SZ_4G) ||
+	    WARN_ON_ONCE(size == 0))
+		return -EINVAL;
+	size = clamp_val(size, 1, SZ_4G);
+	*dest = cpu_to_le32((u32)(size - 1));
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);
+
+void sdxi_serialize_nop(struct sdxi_desc *desc)
+{
+	u32 opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_NOP) |
+		      FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
+	u64 csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.nop = (typeof(desc->nop)) {
+			.opcode = cpu_to_le32(opcode),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+}
+
+int sdxi_encode_copy(struct sdxi_desc *desc, const struct sdxi_copy *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+	__le32 size;
+	int err;
+
+	err = sdxi_encode_size32(params->len, &size);
+	if (err)
+		return err;
+	/*
+	 * Reject overlapping src and dst. "Software ... shall not
+	 * overlap the source buffer, destination buffer, Atomic
+	 * Return Data, or completion status block." - SDXI 1.0 5.6
+	 * Memory Consistency Model
+	 */
+	if (range_overlaps(&(const struct range) {
+				   .start = params->src,
+				   .end   = params->src + params->len - 1,
+			   },
+			   &(const struct range) {
+				   .start = params->dst,
+				   .end   = params->dst + params->len - 1,
+			   }))
+		return -EINVAL;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_COPY) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.copy = (typeof(desc->copy)) {
+			.opcode = cpu_to_le32(opcode),
+			.size = size,
+			.akey0 = cpu_to_le16(params->src_akey),
+			.akey1 = cpu_to_le16(params->dst_akey),
+			.addr0 = cpu_to_le64(params->src),
+			.addr1 = cpu_to_le64(params->dst),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_copy);
+
+int sdxi_encode_intr(struct sdxi_desc *desc,
+		     const struct sdxi_intr *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_INTR) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_INTR));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.intr = (typeof(desc->intr)) {
+			.opcode = cpu_to_le32(opcode),
+			.akey = cpu_to_le16(params->akey),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_intr);
+
 int sdxi_encode_cxt_start(struct sdxi_desc *desc,
 			  const struct sdxi_cxt_start *params)
 {
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
index 5b8fd7cbaa03..14f92c8dea1d 100644
--- a/drivers/dma/sdxi/descriptor.h
+++ b/drivers/dma/sdxi/descriptor.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/kconfig.h>
 #include <linux/minmax.h>
 #include <linux/ratelimit.h>
 #include <linux/types.h>
@@ -16,6 +17,10 @@
 
 #include "hw.h"
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int __must_check sdxi_encode_size32(u64 size, __le32 *dest);
+#endif
+
 static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
 {
 	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
@@ -80,6 +85,26 @@ static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
 	return sdxi_cxt_range(nr, nr);
 }
 
+void sdxi_serialize_nop(struct sdxi_desc *desc);
+
+struct sdxi_copy {
+	dma_addr_t src;
+	dma_addr_t dst;
+	u64 len;
+	u16 src_akey;
+	u16 dst_akey;
+};
+
+int sdxi_encode_copy(struct sdxi_desc *desc,
+		     const struct sdxi_copy *params);
+
+struct sdxi_intr {
+	u16 akey;
+};
+
+int sdxi_encode_intr(struct sdxi_desc *desc,
+		     const struct sdxi_intr *params);
+
 struct sdxi_cxt_start {
 	struct sdxi_cxt_range range;
 };
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index d340ed7dc061..566bebf3f356 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -164,6 +164,30 @@ struct sdxi_desc {
 	static_assert(offsetof(struct tag_, csb_ptr) ==			\
 		      offsetof(struct sdxi_dsc_generic, csb_ptr))
 
+		/* SDXI 1.0 Table 6-6: DSC_DMAB_NOP Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_dmab_nop, nop,
+			__u8 rsvd_0[52];
+		);
+
+		/* SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_dmab_copy, copy,
+			__le32 size;
+			__u8 attr;
+			__u8 rsvd_0[3];
+			__le16 akey0;
+			__le16 akey1;
+			__le64 addr0;
+			__le64 addr1;
+			__u8 rsvd_1[24];
+		);
+
+		/* SDXI 1.0 Table 6-12: DSC_INTR Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_intr, intr,
+			__u8 rsvd_0[8];
+			__le16 akey;
+			__u8 rsvd_1[42];
+		);
+
 		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
 		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
 			__u8 rsvd_0;
@@ -207,11 +231,20 @@ static_assert(sizeof(struct sdxi_desc) == 64);
 
 /* SDXI 1.0 Table 6-1: SDXI Operation Groups */
 enum sdxi_dsc_type {
+	SDXI_DSC_OP_TYPE_DMAB    = 0x001,
 	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
+	SDXI_DSC_OP_TYPE_INTR    = 0x004,
 };
 
 /* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
 enum sdxi_dsc_subtype {
+	/* DMA Base */
+	SDXI_DSC_OP_SUBTYPE_NOP     = 0x01,
+	SDXI_DSC_OP_SUBTYPE_COPY    = 0x03,
+
+	/* Interrupt */
+	SDXI_DSC_OP_SUBTYPE_INTR = 0x00,
+
 	/* Administrative */
 	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
 	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,

-- 
2.54.0



