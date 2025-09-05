Return-Path: <dmaengine+bounces-6409-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F252AB462A9
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98697B618C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAB27B337;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqvOitLp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA123266EF1;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098130; cv=none; b=uYh293t1ev7x7EB94GK65tPfTNnM4nskBb8TW+T2uzn6C9+Bawdh9t61joC3OBx3XcYJJtNWaA4RY+JNJf2Zse6lPLsDKJGjdpToOjOLY7WahBtE7GD48Y7nD9gzodGvADgE1hlRqdsdWpxsfkyIm2mojO+AoFpVM706HPM4Qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098130; c=relaxed/simple;
	bh=Rw+cTPsK8UY84BYmUMrDlUQJRiodAoy6jQpwhK25JPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmMPxG3D6OvMSViM9DeT5JUf+WM25uDUxiO6AomEKJ4id2o9HdQNkWM5SCKhkZVPdt3R7HCh8RtX5bQbguum1BQYcZBbxjeTQ2jARt7K7CZtzNEO3Sonrgca25RyGe/SFm7EEvTwK3aWIVovt3ZRkvKFmgSV9vEwAdQpC0mlYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqvOitLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FD83C4CEF7;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=Rw+cTPsK8UY84BYmUMrDlUQJRiodAoy6jQpwhK25JPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lqvOitLphJb7KVP3y7zZwHqQFf7hfcak6X3LeqPyva1h3dbcyITyMFXPu3OIeXGTa
	 HWApatfHGkr51P8n4Nyleqd52cQ4WyTl+ydL/hJnA4/reknegOnekVtx7bKnuXpZZz
	 3nrV9tUOOWBGrzBKxVal1vp+AF4YTy7wgE7JS2sXnRV+3y7Fh1EHHQJhFAUa4aW4ti
	 kBIfrjJbU222ClZdCrpkVlT1JmWFne5Ek/+HS/0muMf8cfN7mN2X07gXD89hgWGdgo
	 PlomLc2PA9HUWECZVTEOAscMGth4r76VE0ItKnYn/6nwHOdyqSlnLO0JuaeE4Ob7vq
	 g/b0pQu/MGmCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B9CA1016;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:25 -0500
Subject: [PATCH RFC 02/13] dmaengine: sdxi: Add control structure
 definitions
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-2-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=8206;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=LtALJDsZZcNVuQomuX0ryG8qKKEmQgfZsMY945HU3DI=;
 b=VmhOE7l2pTRn9K5Irjx4OXk1BllKBLscXAZDVayTXJ71gxJU1AwvUwRf2VshAqUaKDoy/g1sG
 8vZtgtr3NQHAquGGB+oQ27rqTvDFsiUkPvWm633XR4m+91DhTf5ay4d
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

SDXI defines a multitude of control structures that reside in system
memory and are shared between software and the implementation.

Add:

* C struct definitions for the SDXI control structures to be used by
  the driver;
* Bitmask constants for accessing fields and subfields of the control
  structures;
* Symbolic constants corresponding to significant values such as
  context states and commands.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/hw.h | 249 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
new file mode 100644
index 0000000000000000000000000000000000000000..4ac0e200773b0646e84a65794e02cdf9e583db6d
--- /dev/null
+++ b/drivers/dma/sdxi/hw.h
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+
+/*
+ * Control structures and constants defined in the SDXI specification,
+ * with low-level accessors. The ordering of the structures here
+ * follows the order of their definitions in the SDXI spec.
+ *
+ * Names of structures, members, and subfields (bit ranges within
+ * members) are written to match the spec, generally. E.g. struct
+ * sdxi_cxt_l2_ent corresponds to CXT_L2_ENT in the spec.
+ *
+ * Note: a member can have a subfield whose name is identical to the
+ * member's name. E.g. CXT_L2_ENT's lv01_ptr.
+ *
+ * All reserved fields and bits (usually named "rsvd" or some
+ * variation) must be set to zero by the driver unless otherwise
+ * specified.
+ */
+
+#ifndef LINUX_SDXI_HW_H
+#define LINUX_SDXI_HW_H
+
+#include <asm/byteorder.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/log2.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+/* Context Level 2 Table Entry (CXT_L2_ENT) */
+struct sdxi_cxt_l2_ent {
+	__le64 lv01_ptr;
+#define SDXI_CXT_L2_ENT_LV01_PTR GENMASK_ULL(63, 12)
+#define SDXI_CXT_L2_ENT_VL       BIT_ULL(0)
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_l2_ent) == 8);
+
+/*
+ * The level 2 table is 4KB and has 512 level 1 pointer entries.
+ */
+#define SDXI_L2_TABLE_ENTRIES 512
+struct sdxi_cxt_l2_table {
+	struct sdxi_cxt_l2_ent entry[SDXI_L2_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_l2_table) == 4096);
+
+/* Context level 1 table entry (CXT_L1_ENT) */
+struct sdxi_cxt_l1_ent {
+	__le64 cxt_ctl_ptr;
+#define SDXI_CXT_L1_ENT_VL             BIT_ULL(0)
+#define SDXI_CXT_L1_ENT_KA             BIT_ULL(1)
+#define SDXI_CXT_L1_ENT_PV             BIT_ULL(2)
+#define SDXI_CXT_L1_ENT_CXT_CTL_PTR    GENMASK_ULL(63, 6)
+	__le64 akey_ptr;
+#define SDXI_CXT_L1_ENT_AKEY_SZ        GENMASK_ULL(3, 0)
+#define SDXI_CXT_L1_ENT_AKEY_PTR       GENMASK_ULL(63, 12)
+	__le32 misc0;
+#define SDXI_CXT_L1_ENT_PASID          GENMASK(19, 0)
+#define SDXI_CXT_L1_ENT_MAX_BUFFER     GENMASK(23, 20)
+	__le32 opb_000_enb;
+	__u8 rsvd_0[8];
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_l1_ent) == 32);
+
+#define SDXI_L1_TABLE_ENTRIES 128
+struct sdxi_cxt_l1_table {
+	struct sdxi_cxt_l1_ent entry[SDXI_L1_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_l1_table) == 4096);
+
+/* Context control block (CXT_CTL) */
+struct sdxi_cxt_ctl {
+	__le64 ds_ring_ptr;
+#define SDXI_CXT_CTL_VL             BIT_ULL(0)
+#define SDXI_CXT_CTL_QOS            GENMASK_ULL(3, 2)
+#define SDXI_CXT_CTL_SE             BIT_ULL(4)
+#define SDXI_CXT_CTL_CSA            BIT_ULL(5)
+#define SDXI_CXT_CTL_DS_RING_PTR    GENMASK_ULL(63, 6)
+	__le32 ds_ring_sz;
+	__u8 rsvd_0[4];
+	__le64 cxt_sts_ptr;
+#define SDXI_CXT_CTL_CXT_STS_PTR    GENMASK_ULL(63, 4)
+	__le64 write_index_ptr;
+#define SDXI_CXT_CTL_WRITE_INDEX_PTR GENMASK_ULL(63, 3)
+	__u8 rsvd_1[32];
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
+
+/* Context Status (CXT_STS) */
+struct sdxi_cxt_sts {
+	__u8 state;
+#define SDXI_CXT_STS_STATE GENMASK(3, 0)
+	__u8 misc0;
+	__u8 rsvd_0[6];
+	__le64 read_index;
+} __packed;
+static_assert(sizeof(struct sdxi_cxt_sts) == 16);
+
+/* Valid values for FIELD_GET(SDXI_CXT_STS_STATE, sdxi_cxt_sts.state) */
+enum cxt_sts_state {
+	CXTV_STOP_SW  = 0x0,
+	CXTV_RUN      = 0x1,
+	CXTV_STOPG_SW = 0x2,
+	CXTV_STOP_FN  = 0x4,
+	CXTV_STOPG_FN = 0x6,
+	CXTV_ERR_FN   = 0xf,
+};
+
+static inline enum cxt_sts_state sdxi_cxt_sts_state(const struct sdxi_cxt_sts *sts)
+{
+	return FIELD_GET(SDXI_CXT_STS_STATE, READ_ONCE(sts->state));
+}
+
+/* Access key entry (AKEY_ENT) */
+struct sdxi_akey_ent {
+	__le16 intr_num;
+#define SDXI_AKEY_ENT_VL BIT(0)
+#define SDXI_AKEY_ENT_PV BIT(2)
+	__le16 tgt_sfunc;
+	__le32 pasid;
+#define SDXI_AKEY_ENT_PASID GENMASK(19, 0)
+	__le16 stag;
+	__u8   rsvd_0[2];
+	__le16 rkey;
+	__u8   rsvd_1[2];
+} __packed;
+static_assert(sizeof(struct sdxi_akey_ent) == 16);
+
+/* Error Log Header Entry (ERRLOG_HD_ENT) */
+struct sdxi_errlog_hd_ent {
+	__le32 opcode;
+	__le16 misc0;
+	__le16 cxt_num;
+	__le64 dsc_index;
+	__u8   rsvd_0[28];
+	__le16 err_class;
+	__u8   rsvd_1[2];
+	__le32 vendor[4];
+} __packed;
+static_assert(sizeof(struct sdxi_errlog_hd_ent) == 64);
+
+/* Completion status block (CST_BLK) */
+struct sdxi_cst_blk {
+	__le64 signal;
+	__le32 flags;
+#define SDXI_CST_BLK_ER_BIT BIT(31)
+	__u8 rsvd_0[20];
+} __packed;
+static_assert(sizeof(struct sdxi_cst_blk) == 32);
+
+/*
+ * Size of the "body" of each descriptor between the common opcode and
+ * csb_ptr fields.
+ */
+#define DSC_OPERATION_BYTES 52
+
+#define define_sdxi_dsc(tag_, name_, op_body_)				\
+	struct tag_ {							\
+		__le32 opcode;						\
+		op_body_						\
+		__le64 csb_ptr;						\
+	} name_;							\
+	static_assert(sizeof(struct tag_) ==				\
+		      sizeof(struct sdxi_dsc_generic));			\
+	static_assert(offsetof(struct tag_, csb_ptr) ==			\
+		      offsetof(struct sdxi_dsc_generic, csb_ptr))
+
+struct sdxi_desc {
+	union {
+		__le64 qw[8];
+
+		/* DSC_GENERIC - common header and footer */
+		struct_group_tagged(sdxi_dsc_generic, generic,
+			__le32 opcode;
+#define SDXI_DSC_VL  BIT(0)
+#define SDXI_DSC_SE  BIT(1)
+#define SDXI_DSC_FE  BIT(2)
+#define SDXI_DSC_CH  BIT(3)
+#define SDXI_DSC_CSR BIT(4)
+#define SDXI_DSC_RB  BIT(5)
+#define SDXI_DSC_FLAGS   GENMASK(5, 0)
+#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
+#define SDXI_DSC_TYPE    GENMASK(26, 16)
+			__u8 operation[DSC_OPERATION_BYTES];
+			__le64 csb_ptr;
+#define SDXI_DSC_NP BIT_ULL(0)
+#define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
+		);
+
+		/* DmaBaseGrp: DSC_DMAB_NOP */
+		define_sdxi_dsc(sdxi_dsc_dmab_nop, nop,
+			__u8 rsvd_0[DSC_OPERATION_BYTES];
+		);
+
+#define SDXI_DSC_OP_TYPE_DMAB 0x001
+#define SDXI_DSC_OP_SUBTYPE_COPY 0x03
+		/* DmaBaseGrp: DSC_DMAB_COPY */
+		define_sdxi_dsc(sdxi_dsc_dmab_copy, copy,
+				__le32 size;
+				__u8 attr;
+				__u8 rsvd_0[3];
+				__le16 akey0;
+				__le16 akey1;
+				__le64 addr0;
+				__le64 addr1;
+				__u8 rsvd_1[24];
+				);
+
+#define SDXI_DSC_OP_TYPE_INTR 0x004
+#define SDXI_DSC_OP_SUBTYPE_INTR 0x00
+		/* IntrGrp: DSC_INTR */
+		define_sdxi_dsc(sdxi_dsc_intr, intr,
+			__u8 rsvd_0[8];
+			__le16 akey;
+			__u8 rsvd_1[42];
+		);
+
+#define SDXI_DSC_OP_TYPE_ADMIN 0x002
+#define SDXI_DSC_OP_SUBTYPE_CXT_START_NM 0x03
+#define SDXI_DSC_OP_SUBTYPE_CXT_START_RS 0x08
+		/* AdminGrp: DSC_CXT_START */
+		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
+				__u8 rsvd_0;
+				__u8 vflags;
+				__le16 vf_num;
+				__le16 cxt_start;
+				__le16 cxt_end;
+				__u8 rsvd_1[4];
+				__le64 db_value;
+				__u8 rsvd_2[32];
+				);
+
+#define SDXI_DSC_OP_SUBTYPE_CXT_STOP     0x04
+		/* AdminGrp: DSC_CXT_STOP */
+		define_sdxi_dsc(sdxi_dsc_cxt_stop, cxt_stop,
+			__u8 rsvd_0;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_1[44];
+		);
+	};
+};
+static_assert(sizeof(struct sdxi_desc) == 64);
+
+#endif /* LINUX_SDXI_HW_H */

-- 
2.39.5



