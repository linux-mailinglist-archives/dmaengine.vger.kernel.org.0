Return-Path: <dmaengine+bounces-6411-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AAB462A3
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE01B5E08FC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2FF27D77A;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPCL8cjh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF632701B8;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=ZDErWw5ISxHq2II9Ozik++JxBx1MqH5usEjgt9GmIjoVhEbGgh4P0wz8agNOMBja/VbMsYrQlqndVhT/o1HMAtkATM2yiGgE/lZZ9Jt4t59eBmyfYsO8v1okc1ULPNmtKjvhYC8wpVKh0ge4eLgy5yAT5frc0dCMXmFRupriqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=qnf1b2zKcFkUTQHKXISqjdW6MILR4BxPUkttA+Smuto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXOSA2RCdV8Gl62FKF9kXVn0onjXjvD0vyjf8ulGpF3bXSMgsEQHdspnvkPO/KdxBS1bIHXvTYrafeaTT0smxNHwwS5SrneWKJa/+23f5I+yEHAgUmWo+wy88ZrvjfjYqDa6M2T6qBLP5LO5eDzjxfvq1vvd57J7zKqvQ5XJ4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPCL8cjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F428C4CEFA;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=qnf1b2zKcFkUTQHKXISqjdW6MILR4BxPUkttA+Smuto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YPCL8cjhV2u0KXG1MfOuW+Vd1s1HqK1GdZh6sC+Z+dlmb/+CK9a0bl7uyrvDLWXqm
	 mBOj0+9FyCyN27Nd1tPtgcyauGim5yNhv0VzbqxVdILkxNV2cEfYrds4bDORVcysRG
	 vN8/gKOU1yUknk1gSQJJEAl6yZ2AmrRnhgHzjx+oUYIY+5R0TjCgcuM8Vcr1tptYpD
	 4xUG5sar0GfUXgb7gSrOjuU+XdF7RsAlzmoMUOWOGd36Ip7rOw7cRNkDTcbVG0QcSA
	 1xzKvo0+BbT/265pShS1UWcVL7U0gGX2WxyvmdjxdwWrew8FNFksSMdSNr1/ls2SU4
	 jn2Y/F9hl1xLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A13CA1017;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:27 -0500
Subject: [PATCH RFC 04/13] dmaengine: sdxi: Add MMIO register definitions
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-4-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=4036;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=AGyFf5vWBLGgXMTQeKDi2itH4wGLo9U+txLID+JDYc8=;
 b=ckXC4832wmhdl4X+GtoJDyWK0pWs8vPBZBZHOHorNo+MFrwg6bZ22a0Ak7sqn1klOyKsStt2B
 li2rBwFyrwtCp8P9srcd/tkiA9PC/r4rA82+S0RqE0uln/bfHYYtEKj
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add offsets and bitmasks for:

* General control and status registers (MMIO_CTL0, MMIO_CTL2,
  MMIO_STS0)
* Capability registers (MMIO_CAP0, MMIO_CAP1)
* Context table pointer register (MMIO_CXT_L2)
* Error logging control and status registers (MMIO_ERR_CTL,
  MMIO_ERR_STS, MMIO_ERR_CFG, MMIO_ERR_WRT, MMIO_ERR_RD)

This is a useful subset of the MMIO registers and fields defined in
the spec. The driver currently does not use MMIO_VERSION,
MMIO_GRP_ENUM, or the mailbox registers.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/mmio.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
new file mode 100644
index 0000000000000000000000000000000000000000..36d174a1f8859055f7808d520de1ff193c49ae26
--- /dev/null
+++ b/drivers/dma/sdxi/mmio.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * SDXI MMIO register offsets and layouts.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_MMIO_H
+#define DMA_SDXI_MMIO_H
+
+#include <linux/bits.h>
+#include <linux/compiler_attributes.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+/* Refer to "MMIO Control Registers". */
+enum sdxi_reg {
+	SDXI_MMIO_CTL0       = 0x00000,
+	SDXI_MMIO_CTL2       = 0x00010,
+	SDXI_MMIO_STS0       = 0x00100,
+	SDXI_MMIO_CAP0       = 0x00200,
+	SDXI_MMIO_CAP1       = 0x00208,
+	SDXI_MMIO_VERSION    = 0x00210,
+	SDXI_MMIO_CXT_L2     = 0x10000,
+	SDXI_MMIO_RKEY       = 0x10100,
+	SDXI_MMIO_ERR_CTL    = 0x20000,
+	SDXI_MMIO_ERR_STS    = 0x20008,
+	SDXI_MMIO_ERR_CFG    = 0x20010,
+	SDXI_MMIO_ERR_WRT    = 0x20020,
+	SDXI_MMIO_ERR_RD     = 0x20028,
+};
+
+enum {
+	/* SDXI_MMIO_CTL0 fields */
+	SDXI_MMIO_CTL0_FN_GSR         = GENMASK_ULL(1, 0),
+	SDXI_MMIO_CTL0_FN_PASID_VL    = BIT_ULL(2),
+	SDXI_MMIO_CTL0_FN_ERR_INTR_EN = BIT_ULL(4),
+	SDXI_MMIO_CTL0_FN_PASID       = GENMASK_ULL(27, 8),
+	SDXI_MMIO_CTL0_FN_GRP_ID      = GENMASK_ULL(63, 32),
+
+	/* SDXI_MMIO_CTL2 fields */
+	SDXI_MMIO_CTL2_MAX_BUFFER  = GENMASK_ULL(3, 0),
+	SDXI_MMIO_CTL2_MAX_AKEY_SZ = GENMASK_ULL(15, 12),
+	SDXI_MMIO_CTL2_MAX_CXT     = GENMASK_ULL(31, 16),
+	SDXI_MMIO_CTL2_OPB_000_AVL = GENMASK_ULL(63, 32),
+
+	/* SDXI_MMIO_STS0 bit definitions */
+	SDXI_MMIO_STS0_FN_GSV = GENMASK_ULL(2, 0),
+
+	/* SDXI_MMIO_CAP0 bit definitions */
+	SDXI_MMIO_CAP0_SFUNC = GENMASK_ULL(15, 0),
+	SDXI_MMIO_CAP0_DB_STRIDE = GENMASK_ULL(22, 20),
+	SDXI_MMIO_CAP0_MAX_DS_RING_SZ = GENMASK_ULL(28, 24),
+
+	/* SDXI_MMIO_CAP1 fields */
+	SDXI_MMIO_CAP1_MAX_BUFFER    = GENMASK_ULL(3, 0),
+	SDXI_MMIO_CAP1_RKEY_CAP      = BIT_ULL(4),
+	SDXI_MMIO_CAP1_RM            = BIT_ULL(5),
+	SDXI_MMIO_CAP1_MMIO64        = BIT_ULL(6),
+	SDXI_MMIO_CAP1_MAX_ERRLOG_SZ = GENMASK_ULL(11, 8),
+	SDXI_MMIO_CAP1_MAX_AKEY_SZ   = GENMASK_ULL(15, 12),
+	SDXI_MMIO_CAP1_MAX_CXT       = GENMASK_ULL(31, 16),
+	SDXI_MMIO_CAP1_OPB_000_CAP   = GENMASK_ULL(63, 32),
+
+	/* SDXI_MMIO_VERSION fields */
+	SDXI_MMIO_VERSION_MINOR = GENMASK_ULL(7, 0),
+	SDXI_MMIO_VERSION_MAJOR = GENMASK_ULL(23, 16),
+
+	/* SDXI_MMIO_CXT_L2 fields */
+	SDXI_MMIO_CXT_L2_PTR = GENMASK_ULL(63, 12),
+
+	/* SDXI_MMIO_ERR_CFG bit definitions */
+	SDXI_MMIO_ERR_CFG_PTR = GENMASK_ULL(63, 12),
+	SDXI_MMIO_ERR_CFG_SZ  = GENMASK_ULL(5, 1),
+	SDXI_MMIO_ERR_CFG_EN  = BIT_ULL(0),
+
+	/* SDXI_MMIO_RKEY bit definitions */
+	SDXI_MMIO_RKEY_PTR = GENMASK_ULL(63, 12),
+	SDXI_MMIO_RKEY_SZ = GENMASK_ULL(4, 1),
+	SDXI_MMIO_RKEY_EN = BIT_ULL(0),
+
+	/* SDXI_MMIO_ERR_CTL bit definitions */
+	SDXI_MMIO_ERR_CTL_EN = BIT_ULL(0),
+
+	/* SDXI_MMIO_ERR_STS bit definitions. */
+	SDXI_MMIO_ERR_STS_STS_BIT = BIT_ULL(0),
+	SDXI_MMIO_ERR_STS_OVF_BIT = BIT_ULL(1),
+	SDXI_MMIO_ERR_STS_ERR_BIT = BIT_ULL(3),
+};
+
+#endif  /* DMA_SDXI_MMIO_H */

-- 
2.39.5



