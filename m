Return-Path: <dmaengine+bounces-6418-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C032FB462AE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963CA1CC1CBE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268A283FDF;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uns1K3EQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53582280017;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=f4k/Mb32+r+vqcMOE+ZA6AEw/UEH2HL5LujXkruaty9R//erFd7ADLKtXqTHQKzsj6AGWK7jJi4Fe2cHP5RTzNX50/lIVINqmcvoOgu7TQTT5mORM2sgRfZha+ZTUtOhrpLqHnlpx2r1jpNav2FK8Qi2blQl3uiTY/h8XN4qyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=q/cnJYwiQrYCXLKiAQYrAuGmRzLn79YGRxuj3an5Vmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDZmSFw7zqZTvIbPP75X38znvDQbtGQO0b0/dn++AAojzqqx0uad6ZsR7XStS5N/qxaNkGKBXmZ7ya3T8ZVtZZqraQhEXv+iI42XPq//HBz2PYQSjerqLEknY/AvTFjEK4J2G3wRVahSMWte7kSAN0a7LG9lvEeMnBTNHrS6dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uns1K3EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06067C4CEFB;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098131;
	bh=q/cnJYwiQrYCXLKiAQYrAuGmRzLn79YGRxuj3an5Vmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uns1K3EQQuQU1283oQwUuOGEFpHFwTkZFZ5mLzp2+VjFCNEATIeenO8yLWbXi5DH/
	 0CdDQaxHILYc9D+J/cIAzjflTnkSI8z0aMhVar4o1Qr+hLC4OqnbWHqufXn4rOe8+a
	 XSeOFk6E+9pL0CsZr4BQruljJ2UomxoV7yh8xutR8nNZKJ440Bqw3h+M9Vf4D6vi2u
	 IbGm1HeHh33Tak8oOoRU+oxAWwZSDJWp5sm7Rm+UaF2L52pkkEbQL0eO9pZQn6Pxti
	 kohaeYpJCy4dqW9P3J7VngFoM9+4RpkgXddqY/9EQvibEkzSF97zv1NANLnswAoy8c
	 FC0kxNdr5BgoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33BCCA1017;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:35 -0500
Subject: [PATCH RFC 12/13] dmaengine: sdxi: Add Kconfig and Makefile
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-12-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098129; l=3113;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=ouNlAF3ey9kkPHIHkTAL8nkSqeI8aY290db9HnPAHSw=;
 b=9QEgbeZtoY02av3vXIAReneK8LIym6iDIavrtDdkJoaGAe+hK8loAznGg4DdNdfkul4tka+N0
 gEXJrStJhE2APqhhM6Crk3tgkYiLF4lmaIzYy1L6gpxa4Mx6/56hMGo
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add SDXI Kconfig that includes debug and unit test options in addition
to the usual tristate. SDXI_DEBUG seems necessary because
DMADEVICES_DEBUG makes dmatest too verbose.

One goal is to keep the bus-agnostic portions of the driver buildable
without PCI(_MSI), in case non-PCI SDXI implementations come along
later.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/Kconfig       |  2 ++
 drivers/dma/Makefile      |  1 +
 drivers/dma/sdxi/Kconfig  | 23 +++++++++++++++++++++++
 drivers/dma/sdxi/Makefile | 17 +++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 05c7c7d9e5a4e52a8ad7ada8c8b9b1a6f9d875f6..cccf00b73e025944681b03cffe441c372526d3f3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -774,6 +774,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/sdxi/Kconfig"
+
 source "drivers/dma/stm32/Kconfig"
 
 # clients
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b1a0e956fa5d23633507f52f017d9..ae4154595e1a6250b441a90078e9df3607d3d1dd 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_SDXI) += sdxi/
 
 obj-y += amd/
 obj-y += mediatek/
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..c9757cffb5f64fbc175ded8d0c9d751f0a22b6df
--- /dev/null
+++ b/drivers/dma/sdxi/Kconfig
@@ -0,0 +1,23 @@
+config SDXI
+	tristate "SDXI support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select PACKING
+	help
+	  Enable support for Smart Data Accelerator Interface (SDXI)
+	  Platform Data Mover devices. SDXI is a vendor-neutral
+	  standard for a memory-to-memory data mover and acceleration
+	  interface.
+
+config SDXI_DEBUG
+	bool "SDXI driver debug"
+	default DMADEVICES_DEBUG
+	depends on SDXI != n
+	help
+	  Enable debug output from the SDXI driver. This is an option
+	  for use by developers and most users should say N here.
+
+config SDXI_KUNIT_TEST
+       tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
+       depends on SDXI && KUNIT
+       default KUNIT_ALL_TESTS
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c67e475689b45d6260fe970fb4afcc25f8f9ebc1
--- /dev/null
+++ b/drivers/dma/sdxi/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-$(CONFIG_SDXI_DEBUG) += -DDEBUG
+
+obj-$(CONFIG_SDXI) += sdxi.o
+
+sdxi-objs += \
+	context.o     \
+	descriptor.o  \
+	device.o      \
+	dma.o         \
+	enqueue.o     \
+	error.o
+
+sdxi-$(CONFIG_PCI_MSI) += pci.o
+
+obj-$(CONFIG_SDXI_KUNIT_TEST) += descriptor_kunit.o

-- 
2.39.5



