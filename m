Return-Path: <dmaengine+bounces-10322-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGKDBzsrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10322-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D57514F22
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8F9F300D557
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E794D90D4;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf7LzTZY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45B4D90B5;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=b5iaopquj/DSz1jT3nAt0+aEtQQEUQU7IE0/XIrn/X8agxbRrrkodqzxK5V9p8eEdROu8TCLB/CWqlPPkJpDTuol89+i7FkrG+GvPLifXj5bBXH9LxvI9h0kuklp2inyWWKKy2zz/tDKC3YXMpQHrKH8nj3KQJMl/gTzcQHlSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=KPiBzZOL6V8f9vDwbdZdld94e6GeHrPEVyOksi7b6Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNPfK2uEVl+/1xbbh1Klk4XFe/rsUTWVD6ddDCc6ELeSHgUDkQ1UbdwQcR25ND/rCsNOQKH3s6w0cwNWIqZ7eQWJeDACWZpSGG9XkImorHmuIrmlBkxdgZ4VokRGnJIYglrhyiTjAOrHKqa+R3VkvtLMATXUjoIWWhx6LbvVjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf7LzTZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88A9AC2BCB0;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=KPiBzZOL6V8f9vDwbdZdld94e6GeHrPEVyOksi7b6Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pf7LzTZY+zLPzeymXBJov3LqfT+FDuemhi4XBaudOdPUeO4ZbyBEy7Y9JLMSrwZaP
	 7PEo6FjNvD4YpZsjEvWeoqbDO/eyzO44WApQ6KJeG4GX+PLsG/n2BKK3eiGv1LYybv
	 epngyz3fkP+1nUvx//q6UmQJL/hcxVleEJkMB6djC7ywYVwjwoXZybe1chsWeJXCQT
	 a+A5Wdt01lYyoD58zXuo/0PsjmEBqQdfn76ZE9zF/wDgHUa7ndstmW5BGDxCXsU7t+
	 hTKa0cT+Bj57IwQLslXzSxIlQeTZwApxHov7HjmkVNdqa6eIDzcJoC4haV8xFJhq5l
	 kU3K9pbehz7YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8068CCD4855;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:33 -0500
Subject: [PATCH v2 21/23] dmaengine: sdxi: Add unit tests for descriptor
 encoding
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-21-889cfed17e3f@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=16274;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=xjVQQVgXFjtEQA33NLEQrx1A36xx2uty85FEqt9TvzM=;
 b=IFWMmyq6SidbpI4J4B+N6pQ2umo+mn9G3yUOKxWjkZa8u3tMkhVy6v/1inxG8ZgahvXwcLQmj
 LWL6ydgZGuJBNBbg3VMdZ8BRIqbfRbNTX+VWwbMgp6GllNzDGCfjtcu
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 32D57514F22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10322-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Test the encoder function for each descriptor type currently used by
the driver.

The production code uses the GENMASK()/BIT() family of macros to
support encoding descriptors. The tests for that code use the packing
API to decode descriptors produced by that code without relying on
those bitmask definitions.

By limiting what's shared between the real code and the tests we gain
confidence in both. If both the driver code and the tests rely on the
bitfield macros, and then upon adding a new descriptor field the
author mistranslates the bit numbering from the spec, that error is
more likely to propagate to the tests undetected than if the test code
relies on a separate mechanism for decoding descriptors.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Kconfig            |   1 +
 drivers/dma/sdxi/Makefile           |   1 +
 drivers/dma/sdxi/descriptor_kunit.c | 484 ++++++++++++++++++++++++++++++++++++
 3 files changed, 486 insertions(+)

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index e616d3e323bc..39343eb85614 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -11,6 +11,7 @@ config SDXI_KUNIT_TEST
 	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
 	depends on SDXI && KUNIT
 	default KUNIT_ALL_TESTS
+	select PACKING
 	help
 	  KUnit tests for parts of the SDXI driver. Does not require
 	  SDXI hardware.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 08dd73a45dc7..419c71c2ef6a 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -11,4 +11,5 @@ sdxi-objs += \
 sdxi-$(CONFIG_PCI_MSI) += pci.o
 
 obj-$(CONFIG_SDXI_KUNIT_TEST) += \
+	descriptor_kunit.o    \
 	ring_kunit.o
diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
new file mode 100644
index 000000000000..1f3c2e7ab2dd
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor_kunit.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding tests.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ *
+ * While the driver code uses bitfield macros (BIT, GENMASK) to encode
+ * descriptors, these tests use the packing API to decode them.
+ * Capturing the descriptor layout using PACKED_FIELD() is basically a
+ * copy-paste exercise since SDXI defines control structure fields in
+ * terms of bit offsets. Eschewing the bitfield constants such as
+ * SDXI_DSC_VL in the test code makes it possible for the tests to
+ * detect any mistakes in defining them.
+ *
+ * Note that the checks in unpack_fields() can be quite time-consuming
+ * at build time. Uncomment '#define SKIP_PACKING_CHECKS' below if
+ * that's too annoying when working on this code.
+ */
+#include <kunit/device.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/packing.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+
+#include "descriptor.h"
+
+/* #define SKIP_PACKING_CHECKS */
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+enum {
+	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
+};
+
+
+#define desc_field(_high, _low, _target_struct, _member) \
+	PACKED_FIELD(_high, _low, _target_struct, _member)
+#define desc_flag(_bit, _target_struct, _member) \
+	desc_field(_bit, _bit, _target_struct, _member)
+
+/* DMAB_COPY */
+struct unpacked__copy {
+	u32 size;
+	u8 attr_src;
+	u8 attr_dst;
+	u16 akey0;
+	u16 akey1;
+	u64 addr0;
+	u64 addr1;
+};
+
+#define copy_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__copy, _member)
+
+static const struct packed_field_u16 copy_subfields[] = {
+	copy_field(63, 32, size),
+	copy_field(67, 64, attr_src),
+	copy_field(71, 68, attr_dst),
+	copy_field(111, 96, akey0),
+	copy_field(127, 112, akey1),
+	copy_field(191, 128, addr0),
+	copy_field(255, 192, addr1),
+};
+
+/* DSC_INTR */
+struct unpacked__intr {
+	u16 akey;
+};
+
+#define intr_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__intr, _member)
+
+static const struct packed_field_u16 intr_subfields[] = {
+	intr_field(111, 96, akey),
+};
+
+/* DSC_SYNC */
+struct unpacked__sync {
+	u8 flt;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+	u16 key_start;
+	u16 key_end;
+};
+
+#define sync_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__sync, _member)
+#define sync_flag(_bit, _member) sync_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 sync_subfields[] = {
+	sync_field(34, 32, flt),
+	sync_flag(47, vf),
+	sync_field(63, 48, vf_num),
+	sync_field(79, 64, cxt_start),
+	sync_field(95, 80, cxt_end),
+	sync_field(111, 96, key_start),
+	sync_field(127, 112, key_end),
+};
+
+/* DSC_CXT_START */
+struct unpacked__cxt_start {
+	bool dv;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+	u64 db_value;
+};
+
+#define cxt_start_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__cxt_start, _member)
+#define cxt_start_flag(_bit, _member) cxt_start_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 cxt_start_subfields[] = {
+	cxt_start_flag(46, dv),
+	cxt_start_flag(47, vf),
+	cxt_start_field(63, 48, vf_num),
+	cxt_start_field(79, 64, cxt_start),
+	cxt_start_field(95, 80, cxt_end),
+	cxt_start_field(191, 128, db_value),
+};
+
+/* DSC_CXT_STOP */
+struct unpacked__cxt_stop {
+	bool hs;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+#define cxt_stop_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__cxt_stop, _member)
+#define cxt_stop_flag(_bit, _member) cxt_stop_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 cxt_stop_subfields[] = {
+	cxt_stop_flag(45, hs),
+	cxt_stop_flag(47, vf),
+	cxt_stop_field(63, 48, vf_num),
+	cxt_stop_field(79, 64, cxt_start),
+	cxt_stop_field(95, 80, cxt_end),
+};
+
+/* DSC_GENERIC */
+struct unpacked_desc {
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
+	union {
+		struct unpacked__copy copy;
+		struct unpacked__intr intr;
+		struct unpacked__sync sync;
+		struct unpacked__cxt_start cxt_start;
+		struct unpacked__cxt_stop cxt_stop;
+	};
+};
+
+#define generic_field(_high, _low, _member)			\
+	desc_field(_high, _low, struct unpacked_desc, _member)
+#define generic_flag(_bit, _member) generic_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 generic_subfields[] = {
+	generic_flag(0, vl),
+	generic_flag(1, se),
+	generic_flag(2, fe),
+	generic_flag(3, ch),
+	generic_flag(4, csr),
+	generic_flag(5, rb),
+	generic_field(15, 8, subtype),
+	generic_field(26, 16, type),
+	generic_flag(448, np),
+	generic_field(511, 453, csb_ptr),
+};
+
+#ifndef SKIP_PACKING_CHECKS
+#define define_unpack_fn(_T)						\
+	static void unpack_ ## _T(struct unpacked_desc *to,		\
+				  const struct sdxi_desc *from)		\
+	{								\
+		unpack_fields(from, sizeof(*from), to,	\
+			      generic_subfields, SDXI_PACKING_QUIRKS);	\
+		unpack_fields(from, sizeof(*from), &to->_T,		\
+			      _T ## _subfields, SDXI_PACKING_QUIRKS);	\
+	}
+#else
+#define define_unpack_fn(_T)						\
+	static void unpack_ ## _T(struct unpacked_desc *to,		\
+				  const struct sdxi_desc *from)		\
+	{								\
+		unpack_fields_u16(from, sizeof(*from), to,		\
+				  generic_subfields,			\
+				  ARRAY_SIZE(generic_subfields),	\
+				  SDXI_PACKING_QUIRKS);			\
+		unpack_fields_u16(from, sizeof(*from), &to->_T,		\
+				  _T ## _subfields,			\
+				  ARRAY_SIZE(_T ## _subfields),		\
+				  SDXI_PACKING_QUIRKS);			\
+	}
+#endif	/* SKIP_PACKING_CHECKS */
+
+define_unpack_fn(intr)
+define_unpack_fn(copy)
+define_unpack_fn(sync)
+define_unpack_fn(cxt_start)
+define_unpack_fn(cxt_stop)
+
+static void desc_poison(struct sdxi_desc *d)
+{
+	memset(d, 0xff, sizeof(*d));
+}
+
+static void encode_size32(struct kunit *t)
+{
+	__le32 res = cpu_to_le32(U32_MAX);
+
+	/* Valid sizes. */
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(1, &res));
+	KUNIT_EXPECT_EQ(t, 0, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4K, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4K - 1, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4M, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4M - 1, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G - 1, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4G - 2, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4G - 1, le32_to_cpu(res));
+
+	/* Invalid sizes. Ensure the out parameter is unmodified. */
+#define RES_VAL 0x843829
+	res = cpu_to_le32(RES_VAL);
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(0, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_4G + 1, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_8G, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(U64_MAX, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+#undef RES_VAL
+}
+
+static void copy(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_desc desc = {};
+	struct sdxi_copy copy = {
+		.src = 0x1000,
+		.dst = 0x2000,
+		.len = 4096,
+		.src_akey = 0,
+		.dst_akey = 0,
+	};
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
+
+	/* Zero isn't a valid size. */
+	desc_poison(&desc);
+	copy.len = 0;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+
+	/* But 1 is. */
+	desc_poison(&desc);
+	copy.len = 1;
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
+
+	/* SDXI forbids overlapping source and destination. */
+	desc_poison(&desc);
+	copy.len = 4097;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+	copy = (typeof(copy)) {
+		.src = 0x4000,
+		.dst = 0x4000,
+		.len = 1,
+		.src_akey = 0,
+		.dst_akey = 0,
+	};
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
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
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, 0x100 - 1);
+}
+
+static void intr(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_intr intr = {
+		.akey = 1234,
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_intr(&desc, &intr));
+
+	unpack_intr(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.intr.akey, 1234);
+}
+
+static void cxt_start(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_cxt_start start = {
+		.range = sdxi_cxt_range_single(2),
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_start(&desc, &start));
+
+	unpack_cxt_start(&unpacked, &desc);
+
+	/* Check op-specific fields. */
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);
+
+	/*
+	 * Check generic fields. Some flags have mandatory values
+	 * according to the operation type.
+	 */
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_START_NM);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.dv);
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.vf);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_start, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_end, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.vf_num, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.db_value, 0);
+}
+
+static void cxt_stop(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_cxt_stop stop = {
+		.range = sdxi_cxt_range_single(2),
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
+
+	unpack_cxt_stop(&unpacked, &desc);
+
+	/* Check op-specific fields. */
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);
+
+	/*
+	 * Check generic fields. Some flags have mandatory values
+	 * according to the operation type.
+	 */
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.hs);
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.vf);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_start, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_end, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.vf_num, 0);
+}
+
+static void sync(struct kunit *t)
+{
+	struct sdxi_sync sync = {
+		.filter = SDXI_SYNC_FLT_STOP,
+		.range = sdxi_cxt_range(1, U16_MAX),
+	};
+	struct sdxi_desc desc;
+	struct unpacked_desc unpacked;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_sync(&desc, &sync));
+	unpack_sync(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_SYNC);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.flt, SDXI_SYNC_FLT_STOP);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_start, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_end, U16_MAX);
+}
+
+static struct kunit_case generic_desc_tcs[] = {
+	KUNIT_CASE(encode_size32),
+	KUNIT_CASE(copy),
+	KUNIT_CASE(intr),
+	KUNIT_CASE(cxt_start),
+	KUNIT_CASE(cxt_stop),
+	KUNIT_CASE(sync),
+	{}
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
2.54.0



