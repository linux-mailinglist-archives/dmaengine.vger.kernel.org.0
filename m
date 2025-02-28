Return-Path: <dmaengine+bounces-4611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2DA4A059
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D904188FAFE
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD223597A;
	Fri, 28 Feb 2025 17:26:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E21EF366;
	Fri, 28 Feb 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763603; cv=none; b=cXgNC6tN9Vb0qPPOIJJNkL3MEXFZpMih8bAq+OI1enDjhuiKlN+Wa3jb2dw06mgw01IEljVN+PrIrVV9eYrgfURaHA1Mdt0JDFXG4/CVv4x04bXo/wgUXMZnkZT58rC9TK1nM8MggXsYyj88QbNxHBciVHdZKH25jSpr5S3X1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763603; c=relaxed/simple;
	bh=6F56SRAravCCOsVX6tQy7mIbCmCu3ZAaXeOnrtICYNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDCn82kR5Fgc4133rmi1HyHiYak8BaW8wajXpJMdwEsyeROwPR8gyHFKRP4+xC5tUQR+8IOTf8yDu60iRrpggNG4Fg9Yl9zoq6qyrfE3Yp2g1Je3aEWhR21eqiU76m0VI4Ed1Y5EqGlqII5xowMR3ZZGdrXzEymo0uv8SDZGY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49F81515;
	Fri, 28 Feb 2025 09:26:55 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E15E03F6A8;
	Fri, 28 Feb 2025 09:26:39 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: dma: Add Arm DMA-350
Date: Fri, 28 Feb 2025 17:26:32 +0000
Message-Id: <2918c3b4403f78b89f46e32f7572eace9f50ab93.1740762136.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1740762136.git.robin.murphy@arm.com>
References: <cover.1740762136.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm CoreLink DMA-350 is a pleasantly straightforward DMA controller
which, although highly configurable, lends itself to a simple binding
thanks to plenty of self-describing ID registers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../devicetree/bindings/dma/arm,dma-350.yaml  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/arm,dma-350.yaml

diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
new file mode 100644
index 000000000000..429f682f15d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/arm,dma-350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreLink DMA-350 Controller
+
+maintainers:
+  - Robin Murphy <robin.murphy@arm.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: arm,dma-350
+
+  reg:
+    items:
+      - description: Base and size of the full register map
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Channel 0 interrupt
+      - description: Channel 1 interrupt
+      - description: Channel 2 interrupt
+      - description: Channel 3 interrupt
+      - description: Channel 4 interrupt
+      - description: Channel 5 interrupt
+      - description: Channel 6 interrupt
+      - description: Channel 7 interrupt
+
+  "#dma-cells":
+    const: 1
+    description: The cell is the trigger input number
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
-- 
2.39.2.101.g768bb238c484.dirty


