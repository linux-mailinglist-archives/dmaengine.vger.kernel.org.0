Return-Path: <dmaengine+bounces-4712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B508A5DC3F
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 13:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A13189803C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075E24169E;
	Wed, 12 Mar 2025 12:05:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777F2417D6;
	Wed, 12 Mar 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781154; cv=none; b=gYe9/OlaeTsA/XTSiH/MS4WAi5BpGC6KyFvRpG9BnAiMufru2WUza92g9gLYEHU59nHiGf0igxoI7o7WXUpbbruPu/EtN6lf6KHmheAfg7eK2Cm4YppOL8lKbqs8TRpmi4u5APsbTo/8o5yAEe3lcZMz8+9uXiVbvWGhTHG6pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781154; c=relaxed/simple;
	bh=IbKVa72RWH0LnCYEZ7CqXXzn8zWMWS1/hMn+/yVhytw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXO9v0AZ+B3FAFot3VMjuCKtV83mhyo+5tV7CC7lm/GsTFkDlYp9gbZ21eJR0S5B0HYDcW+nQLbsTi7KI7puO+Sko+RSpPY0colDDVoe+JPMTPPHF75GRwDFrQ9xzehOQOoJ1gyXAiw6QsItF3j5GLxnU1j7E5lwoqY10rLIOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25320113E;
	Wed, 12 Mar 2025 05:06:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF3AC3F694;
	Wed, 12 Mar 2025 05:05:51 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: dma: Add Arm DMA-350
Date: Wed, 12 Mar 2025 12:05:09 +0000
Message-Id: <15830b2a8ff9721e364f30f93ea3993139b0103b.1741780808.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1741780808.git.robin.murphy@arm.com>
References: <cover.1741780808.git.robin.murphy@arm.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: No change

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


