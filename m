Return-Path: <dmaengine+bounces-10315-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFlgCIwrAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10315-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF3514FE1
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC63D3059920
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821DB4D8DBB;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVxDf8aC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556744D8D9E;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526998; cv=none; b=h5rAfZX438DbhqMqn0qAZKVvpjQI2sGSKZ43yOEH+ZP0owCnYyRe6l27GQYKI8+CjtnIryzvBi3d6LyNxkHCNAYzfcOTk8K9WMB7eyA9ZcGETnMGB0iE38teDWOOAK7bEnU7ZPPBPiXdR1uVSszOVJ7Z084kqc+BSz7G22Ra8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526998; c=relaxed/simple;
	bh=Hk3pnE2NQWqwdbyzJmBvEdl46M8iH8HLuqpjBhV4E00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFgc6Pnv7HbYJ6/VJbKOSXtpD37f+H3GR0HF4UCY43IUDlhzjqSqaksaay+p/6ZzRx4NQkmEDxi8rdHkb0VDMSITE1arlqgCNbICiW7V4DZViSGvtmKazxAAx0Nte6TxRNNJoYCJF7PIe6CzEfepD++Hed4BSfZbTNvtbNJhIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVxDf8aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165BDC4AF49;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526998;
	bh=Hk3pnE2NQWqwdbyzJmBvEdl46M8iH8HLuqpjBhV4E00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OVxDf8aCm4Zru4IvgzwXkQRrLAaI4sdpl28yIak7IQelqOpeLhzj7xMVpWhdnIb4h
	 TQpRcY6F9zxDbdKG5i3vWCNfGv5L5BnRxY2bXQp5tpdKJpo3SO+5m0gB6lNtExitv9
	 NLV6Bh1OJnoPqO7BiVrj7ad5SHzweN9tSKj2xizt6Kugm/viIF9ETUrPiysLbRy8Gg
	 PyxDWRe7ohByqtvObHJqj2TENJQuuqQwJ+ZtFK4IL8uCasNq5vpdr1CgnJHEPZBtqY
	 x3YPSTmldyDkQViHMTrjQe8BZpWJHpksaUq4/5CV3fT8G+cAHhCmEdMhTgGZbWg0i/
	 SVuuZQFip21XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE6CD4855;
	Mon, 11 May 2026 19:16:38 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:25 -0500
Subject: [PATCH v2 13/23] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-13-889cfed17e3f@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=5269;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=PXDHT7Pgu67HfIa3CtBVAX9zuukW62nt8SgJBR84+X0=;
 b=ATgAovf39Bu8VlzKhiJIzCEVvnBT2wERu0O2oZlMMu5nRZnOnGCn2ZIX5LFWM4UTJ+BPwinwU
 XarF/PGupCxBJoNqGZDsfjnpEt+BnW6Czrn9Sc8UkBmQpkP8J0zeaAs
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Queue-Id: 9DBF3514FE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10315-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:replyto]
X-Rspamd-Action: no action

From: Nathan Lynch <nathan.lynch@amd.com>

Add KUnit tests for the descriptor ring reservation API, covering:

- Valid reservations: full-ring and single-slot after advancing the
  read pointer.

- Error paths: zero or over-capacity count (-EINVAL), inconsistent
  index state (-EIO), and insufficient space (-EBUSY).

A .kunitconfig is included ease of use:

  $ tools/testing/kunit/kunit.py run \
         --kunitconfig=drivers/dma/sdxi/.kunitconfig

No SDXI hardware is required to run these tests.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/.kunitconfig |   4 ++
 drivers/dma/sdxi/Kconfig      |   8 ++++
 drivers/dma/sdxi/Makefile     |   3 ++
 drivers/dma/sdxi/ring_kunit.c | 105 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
new file mode 100644
index 000000000000..a98cf19770f0
--- /dev/null
+++ b/drivers/dma/sdxi/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DMADEVICES=y
+CONFIG_SDXI=y
+CONFIG_SDXI_KUNIT_TEST=y
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index a568284cd583..e616d3e323bc 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -6,3 +6,11 @@ config SDXI
 	  Platform Data Mover devices. SDXI is a vendor-neutral
 	  standard for a memory-to-memory data mover and acceleration
 	  interface.
+
+config SDXI_KUNIT_TEST
+	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
+	depends on SDXI && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for parts of the SDXI driver. Does not require
+	  SDXI hardware.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 23536a1defc3..372f793c15b1 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -7,3 +7,6 @@ sdxi-objs += \
 	ring.o
 
 sdxi-$(CONFIG_PCI_MSI) += pci.o
+
+obj-$(CONFIG_SDXI_KUNIT_TEST) += \
+	ring_kunit.o
diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
new file mode 100644
index 000000000000..3bc7073e0c39
--- /dev/null
+++ b/drivers/dma/sdxi/ring_kunit.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor ring management tests.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <kunit/device.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/packing.h>
+#include <linux/string.h>
+
+#include "ring.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void valid(struct kunit *t)
+{
+	__le64 wi, ri;
+	struct sdxi_ring_state r;
+	struct sdxi_ring_resv resv;
+	struct sdxi_desc *descs, *desc;
+
+
+	descs = kunit_kmalloc_array(t, SZ_1K, sizeof(descs[0]),
+				    GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_NULL(t, descs);
+
+	ri = wi = 0;
+	sdxi_ring_state_init(&r, &ri, &wi, SZ_1K, descs);
+
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, r.entries, &resv), 0);
+	KUNIT_EXPECT_EQ(t, resv.range.start, 0);
+	KUNIT_EXPECT_EQ(t, resv.range.end, r.entries - 1);
+	KUNIT_EXPECT_EQ(t, le64_to_cpu(wi), r.entries);
+	sdxi_ring_resv_foreach(&resv, desc) {
+		KUNIT_EXPECT_NOT_NULL_MSG(t, sdxi_ring_resv_next(&resv),
+			"unexpected null descriptor for index %llu", resv.iter);
+	}
+
+	ri = cpu_to_le64(1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, 1, &resv), 0);
+	KUNIT_EXPECT_EQ(t, le64_to_cpu(wi), r.entries + 1);
+	KUNIT_EXPECT_NOT_NULL(t, sdxi_ring_resv_next(&resv));
+}
+
+static void invalid(struct kunit *t)
+{
+	__le64 wi, ri;
+	struct sdxi_ring_state rs;
+	struct sdxi_ring_resv resv;
+	struct sdxi_desc *descs;
+
+	descs = kunit_kmalloc_array(t, SZ_1K, sizeof(descs[0]),
+				    GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_NULL(t, descs);
+
+	ri = wi = 0;
+	sdxi_ring_state_init(&rs, &ri, &wi, SZ_1K, descs);
+
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 0, &resv), -EINVAL);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, rs.entries + 1, &resv), -EINVAL);
+
+	ri = cpu_to_le64(1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EIO);
+
+	ri = 0;
+	wi = cpu_to_le64(rs.entries);
+	sdxi_ring_state_init(&rs, &ri, &wi, SZ_1K, descs);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EBUSY);
+
+	ri = cpu_to_le64(rs.entries);
+	wi = cpu_to_le64(rs.entries + 1);
+	sdxi_ring_state_init(&rs, &ri, &wi, SZ_1K, descs);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, rs.entries, &resv), -EBUSY);
+}
+
+static struct kunit_case testcases[] = {
+	KUNIT_CASE(valid),
+	KUNIT_CASE(invalid),
+	{}
+};
+
+static int setup_device(struct kunit *t)
+{
+	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
+	t->priv = dev;
+	return 0;
+}
+
+static struct kunit_suite generic_desc_ts = {
+	.name = "SDXI descriptor ring management",
+	.test_cases = testcases,
+	.init = setup_device,
+};
+kunit_test_suite(generic_desc_ts);
+
+MODULE_DESCRIPTION("SDXI descriptor ring tests");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_LICENSE("GPL");

-- 
2.54.0



