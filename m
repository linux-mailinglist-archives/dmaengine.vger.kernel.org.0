Return-Path: <dmaengine+bounces-6408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C3B4629C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BB71CC1AFF
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC7727B323;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuQkjbHn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18326C39E;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098130; cv=none; b=VHTmTJvj1yGQoXmyheEpzHnDmnJz5z66ri4mMazM7cOkeDoZKrDkjn5KWh6XS6y92CGKdOdCaxrDSNfYG+O2yyESB5JnLL/nLhQW53GK55gnmzRahWsl+0hBZ5OfBmaUvMHWV/Wn0wWW8K1wrPA8uvD4/TnslryIdUug+jv9v40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098130; c=relaxed/simple;
	bh=0RsfSk7Z7giYDTRx/TlwUf+aWs1ysuZSuIiQt3xAsKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBxdFd/Wn+vlu48RoBOggI3jSchQUF6b6IVABftU3QHPZEhRPsd8QUjij95Ud/KAO6cpWKNFDNWr9ugyeQ1aR/M/Ze0I4UkffprelSZhoBcB5ghRtT5K2+OQQyD/WPVTwowDAJXuIzLK9mWetWBeaH1S/zp9uWO5CUMgQu3q93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuQkjbHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 876ABC4CEFB;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=0RsfSk7Z7giYDTRx/TlwUf+aWs1ysuZSuIiQt3xAsKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cuQkjbHnGKhjJKAJMFhWZNE33XdOiRrWYzQvVujoMJ9S81Ppm71J0qrT/zBNu6FKE
	 Q4/dVGwvzJtGHyGGWfuYWSKh0+fdDfHBIRlB32zxqTNANFxo3uxz4VnGQ7iG+An5E6
	 I0hLh6YdG6e5V3Koa2/vccY4sj6QxPpS2nyuYBmfur3ikRjb5TodkUJuSeFG5vZR+B
	 E0xUo04JJjoyO5UsI6ELmSIibZ3sNkPMT6SIwqyGRo7Wyeab/IEfxk4TaJDVSlgkPH
	 wFQeUOk13LSIJub+3yXoFGLCK3HT8CVRnsf4MTR48E4Qk3xCWFNrNfrFn7ty/eEo2i
	 qDtIF3yHVzzDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A65CA101F;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:26 -0500
Subject: [PATCH RFC 03/13] dmaengine: sdxi: Add descriptor encoding and
 unit tests
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-3-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=15232;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=UezToU+VmZcS1jraaaN8wx3PC2DeVePS8pHMHmsC5dQ=;
 b=VDFU1hO+cBEzdN0KG639/c4S4BO9U0MkDWKjhXjihFFSVQglPW0F3m7VV75nYmL1zErwvWonP
 L+NkJLEUsZLDsMkM6HgMR6Ns5CP21Vz9Pg73HDL3cZlErBmWf5TOikq
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add support for encoding several types of SDXI descriptors:

* Copy
* Interrupt
* Context start
* Context stop

Each type of descriptor has a corresponding parameter struct which is
an input to its encoder function. E.g. to encode a copy descriptor,
the client initializes a struct sdxi_copy object with the source,
destination, size, etc and passes that to sdxi_encode_copy().

Include unit tests that verify that encoded descriptors have the
expected values and that fallible encode functions fail on invalid
inputs.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/.kunitconfig       |   4 +
 drivers/dma/sdxi/descriptor.c       | 197 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/descriptor.h       | 107 ++++++++++++++++++++
 drivers/dma/sdxi/descriptor_kunit.c | 181 +++++++++++++++++++++++++++++++++
 4 files changed, 489 insertions(+)

diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..a98cf19770f03bce82ef86d378d2a2e34da5154a
--- /dev/null
+++ b/drivers/dma/sdxi/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DMADEVICES=y
+CONFIG_SDXI=y
+CONFIG_SDXI_KUNIT_TEST=y
diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
new file mode 100644
index 0000000000000000000000000000000000000000..6ea5247bf8cdaac19131ca5326ba1640c0b557f8
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <kunit/visibility.h>
+#include <linux/align.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/log2.h>
+#include <linux/packing.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include "hw.h"
+#include "descriptor.h"
+
+enum {
+	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
+};
+
+#define sdxi_desc_field(_high, _low, _member) \
+	PACKED_FIELD(_high, _low, struct sdxi_desc_unpacked, _member)
+#define sdxi_desc_flag(_bit, _member) \
+	sdxi_desc_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 common_descriptor_fields[] = {
+	sdxi_desc_flag(0, vl),
+	sdxi_desc_flag(1, se),
+	sdxi_desc_flag(2, fe),
+	sdxi_desc_flag(3, ch),
+	sdxi_desc_flag(4, csr),
+	sdxi_desc_flag(5, rb),
+	sdxi_desc_field(15, 8, subtype),
+	sdxi_desc_field(26, 16, type),
+	sdxi_desc_flag(448, np),
+	sdxi_desc_field(511, 453, csb_ptr),
+};
+
+void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
+		      const struct sdxi_desc *from)
+{
+	*to = (struct sdxi_desc_unpacked){};
+	unpack_fields(from, sizeof(*from), to, common_descriptor_fields,
+		      SDXI_PACKING_QUIRKS);
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_desc_unpack);
+
+static void desc_clear(struct sdxi_desc *desc)
+{
+	memset(desc, 0, sizeof(*desc));
+}
+
+static __must_check int sdxi_encode_size32(u64 size, __le32 *dest)
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
+	 * TODO: reject overlapping src and dst. Quoting "Memory
+	 * Consistency Model": "Software shall not ... overlap the
+	 * source buffer, destination buffer, Atomic Return Data, or
+	 * completion status block."
+	 */
+
+	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_COPY) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	desc_clear(desc);
+	desc->copy = (struct sdxi_dsc_dmab_copy) {
+		.opcode = cpu_to_le32(opcode),
+		.size = size,
+		.akey0 = cpu_to_le16(params->src_akey),
+		.akey1 = cpu_to_le16(params->dst_akey),
+		.addr0 = cpu_to_le64(params->src),
+		.addr1 = cpu_to_le64(params->dst),
+		.csb_ptr = cpu_to_le64(csb_ptr),
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
+	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_INTR) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_INTR));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	desc_clear(desc);
+	desc->intr = (struct sdxi_dsc_intr) {
+		.opcode = cpu_to_le32(opcode),
+		.akey = cpu_to_le16(params->akey),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_intr);
+
+int sdxi_encode_cxt_start(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_start *params)
+{
+	u16 cxt_start;
+	u16 cxt_end;
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
+		  FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_START_NM) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	cxt_start = params->range.cxt_start;
+	cxt_end = params->range.cxt_end;
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	desc_clear(desc);
+	desc->cxt_start = (struct sdxi_dsc_cxt_start) {
+		.opcode = cpu_to_le32(opcode),
+		.cxt_start = cpu_to_le16(cxt_start),
+		.cxt_end = cpu_to_le16(cxt_end),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_start);
+
+int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_stop *params)
+{
+	u16 cxt_start;
+	u16 cxt_end;
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_VL, 1) |
+		  FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	cxt_start = params->range.cxt_start;
+	cxt_end = params->range.cxt_end;
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	desc_clear(desc);
+	desc->cxt_stop = (struct sdxi_dsc_cxt_stop) {
+		.opcode = cpu_to_le32(opcode),
+		.cxt_start = cpu_to_le16(cxt_start),
+		.cxt_end = cpu_to_le16(cxt_end),
+		.csb_ptr = cpu_to_le64(csb_ptr),
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
new file mode 100644
index 0000000000000000000000000000000000000000..141463dfd56bd4a88b4b3c9d45b13cc8101e1961
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DMA_SDXI_DESCRIPTOR_H
+#define DMA_SDXI_DESCRIPTOR_H
+
+/*
+ * Facilities for encoding SDXI descriptors.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <asm/byteorder.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include "hw.h"
+
+static inline void sdxi_desc_set_csb(struct sdxi_desc *desc,
+				     dma_addr_t addr)
+{
+	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_CSB_PTR, addr >> 5));
+}
+
+struct sdxi_cxt_range {
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+static inline struct sdxi_cxt_range __sdxi_cxt_range(u16 a, u16 b)
+{
+	return (struct sdxi_cxt_range) {
+		.cxt_start = min(a, b),
+		.cxt_end   = max(a, b),
+	};
+}
+
+#define sdxi_cxt_range_1(_id)			\
+	({					\
+		u16 id = (_id);			\
+		__sdxi_cxt_range(id, id);	\
+	})
+
+#define sdxi_cxt_range_2(_id1, _id2) __sdxi_cxt_range(_id1, _id2)
+
+#define _sdxi_cxt_range(_1, _2, _fn, ...) _fn
+
+#define sdxi_cxt_range(...)						\
+	_sdxi_cxt_range(__VA_ARGS__,					\
+			sdxi_cxt_range_2, sdxi_cxt_range_1)(__VA_ARGS__)
+
+struct sdxi_copy {
+	dma_addr_t src;
+	dma_addr_t dst;
+	size_t len;
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
+/*
+ * Fields common to all SDXI descriptors in "unpacked" form, for use
+ * with pack_fields() and unpack_fields().
+ */
+struct sdxi_desc_unpacked {
+	u64 csb_ptr;
+	u16 type;
+	u8 subtype;
+	bool vl;
+	bool se;
+	bool fe;
+	bool ch;
+	bool csr;
+	bool rb;
+	bool np;
+};
+
+void sdxi_desc_unpack(struct sdxi_desc_unpacked *to,
+		      const struct sdxi_desc *from);
+
+#endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
new file mode 100644
index 0000000000000000000000000000000000000000..eb89d5a152cd789fb8cfa66b78bf30e583a1680d
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor_kunit.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding tests.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+#include <kunit/device.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include "descriptor.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void desc_poison(struct sdxi_desc *d)
+{
+	memset(d, 0xff, sizeof(*d));
+}
+
+static void copy(struct kunit *t)
+{
+	struct sdxi_desc_unpacked unpacked;
+	struct sdxi_copy copy = {};
+	struct sdxi_desc desc = {};
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+
+	desc_poison(&desc);
+	copy.len = SZ_4G + 1;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+
+	desc_poison(&desc);
+	copy.len = 1;
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+
+	desc_poison(&desc);
+	copy.len = SZ_4G;
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+	KUNIT_EXPECT_EQ(t, SZ_4G - 1, le32_to_cpu(desc.copy.size));
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_encode_copy(&desc,
+					 &(struct sdxi_copy) {
+						 .src = 0x1000,
+						 .dst = 0x2000,
+						 .len = 0x100,
+						 .src_akey = 1,
+						 .dst_akey = 2,
+					 }));
+	KUNIT_EXPECT_EQ(t, 0x1000, le64_to_cpu(desc.copy.addr0));
+	KUNIT_EXPECT_EQ(t, 0x2000, le64_to_cpu(desc.copy.addr1));
+	KUNIT_EXPECT_EQ(t, 0x100, 1 + le32_to_cpu(desc.copy.size));
+	KUNIT_EXPECT_EQ(t, 1, le16_to_cpu(desc.copy.akey0));
+	KUNIT_EXPECT_EQ(t, 2, le16_to_cpu(desc.copy.akey1));
+
+	sdxi_desc_unpack(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+}
+
+static void intr(struct kunit *t)
+{
+	struct sdxi_desc_unpacked unpacked;
+	struct sdxi_intr intr = {
+		.akey = 1234,
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_intr(&desc, &intr));
+	KUNIT_EXPECT_EQ(t, 1234, le16_to_cpu(desc.intr.akey));
+
+	sdxi_desc_unpack(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+}
+
+static void cxt_start(struct kunit *t)
+{
+	struct sdxi_cxt_start start = {
+		.range = sdxi_cxt_range(1, U16_MAX)
+	};
+	struct sdxi_desc desc = {};
+	struct sdxi_desc_unpacked unpacked;
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_cxt_start(&desc, &start));
+
+	/* Check op-specific fields. */
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vf_num);
+	KUNIT_EXPECT_EQ(t, 1, desc.cxt_start.cxt_start);
+	KUNIT_EXPECT_EQ(t, U16_MAX, desc.cxt_start.cxt_end);
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.db_value);
+
+	/*
+	 * Check generic fields. Some flags have mandatory values
+	 * according to the operation type.
+	 */
+	sdxi_desc_unpack(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_START_NM);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+}
+
+static void cxt_stop(struct kunit *t)
+{
+	struct sdxi_cxt_stop stop = {
+		.range = sdxi_cxt_range(1, U16_MAX)
+	};
+	struct sdxi_desc desc = {};
+	struct sdxi_desc_unpacked unpacked;
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
+
+	/* Check op-specific fields */
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vflags);
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vf_num);
+	KUNIT_EXPECT_EQ(t, 1, desc.cxt_stop.cxt_start);
+	KUNIT_EXPECT_EQ(t, U16_MAX, desc.cxt_stop.cxt_end);
+
+	/*
+	 * Check generic fields. Some flags have mandatory values
+	 * according to the operation type.
+	 */
+	sdxi_desc_unpack(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+}
+
+static struct kunit_case generic_desc_tcs[] = {
+	KUNIT_CASE(copy),
+	KUNIT_CASE(intr),
+	KUNIT_CASE(cxt_start),
+	KUNIT_CASE(cxt_stop),
+	{},
+};
+
+static int generic_desc_setup_device(struct kunit *t)
+{
+	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
+	t->priv = dev;
+	return 0;
+}
+
+static struct kunit_suite generic_desc_ts = {
+	.name = "Generic SDXI descriptor encoding",
+	.test_cases = generic_desc_tcs,
+	.init = generic_desc_setup_device,
+};
+kunit_test_suite(generic_desc_ts);
+
+MODULE_DESCRIPTION("SDXI descriptor encoding tests");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_LICENSE("GPL");

-- 
2.39.5



