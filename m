Return-Path: <dmaengine+bounces-11235-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lEZeAWZkI2p2sQEAu9opvQ
	(envelope-from <dmaengine+bounces-11235-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E164BED4
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="hx/eyYE9";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11235-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11235-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C261303A527
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2892571D7;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155722068D;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=WOJHgl1Huk5aT0pXj+ctDvlUJNCq+Ge+kv5w1KNdoe2HsYxs8jjTD4YtIXPQdS3LcYyxU3mXiLAfHT7tTQ0uXoG7he5UOK3nbtozYTvjNC7Lj+SeEQ/hDiwZeaYrPzxwCL9PP5bkJ0/5AA2YQ+ypB17FTeKog7qzb7oJJyKZ3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=Flk3OzgFJwdu7qVBc8FGZ7a1yxRFBhW7x/D8pU+MqB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHu3WFENB5iTMrlw2qL72EpDiodoYVdWp6cB+wMIGPgtRVFl8x9r71wdcfC9o8L67Tpa1peoZOPdb7vp6Vk9ZwdFm/ZDJ86VNY6iY9It2sJNoU6SS7uyu7Xiiu7/xkA9ka2xXcMRMT5oFvTaNtdqGatgvYENwocOJEDOY4bs8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx/eyYE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FAC8C4AF0F;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=Flk3OzgFJwdu7qVBc8FGZ7a1yxRFBhW7x/D8pU+MqB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hx/eyYE9DYjsY8Buz7C/ZhgC2646nMWG1767LVHdi+/QdPv8neyhZu/YpX0KHvu6J
	 PMMxaivuMjQe6VP9MAc4MU5idE5WjFZKpKtqUfOl8lYUJF5l3xO6+KKDmFzwcLJ2QS
	 +XNcaW2EwhQa7xiKu33dU3Ybzf8GDIPUyXAGY6KpbW7bmoH3960vH6UmDMsGMdyG7Y
	 Z9S5tiOlL04jjMWiRtMWaFsquGJHNYTSN6GnMrM5EiKdoXbmYGJAw02cZcFQdfOsZy
	 uYKcT91jvhQ37jKohGWRhz7GqyhnoOmTa3lNc9UZ6sn8H7AHL5q0PB5nFN49DLFOox
	 t9mRmy8givqPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FF2CD6E7B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:16 -0500
Subject: [PATCH v3 13/23] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-13-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=5291;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=AjqlcR1J/MdjgT8HA14M/iwSkOjphEY9WGqJW4+YCzE=;
 b=D0VFz6DmNWL9JA+2QGNBo5wg4j3HDEu7MZMwXhngMRfX1Tsd46uFat+ytjhWOuWlk3/NxUDjb
 UtfW0FaBUrhBLYJphGbugTqK1aY978WWZ00cwFNUKAAINj3m9HFmrHH
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11235-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 954E164BED4

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
 drivers/dma/sdxi/Kconfig      |  10 ++++
 drivers/dma/sdxi/Makefile     |   3 ++
 drivers/dma/sdxi/ring_kunit.c | 105 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
new file mode 100644
index 000000000000..16a1ae04b156
--- /dev/null
+++ b/drivers/dma/sdxi/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DMADEVICES=y
+CONFIG_SDXI_CORE=y
+CONFIG_SDXI_KUNIT_TEST=y
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index b91b44231a04..7217375c9216 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -26,3 +26,13 @@ config SDXI_PCI
 
 	  To compile this driver as a module, choose M here: the module
 	  will be named "sdxi-pci".
+
+config SDXI_KUNIT_TEST
+	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
+	depends on SDXI_CORE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for parts of the SDXI driver. Does not require
+	  SDXI hardware.
+
+	  If unsure, say N.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index bfcb443f1e64..00e3f1cb0808 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -7,3 +7,6 @@ sdxi-core-y := \
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
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



