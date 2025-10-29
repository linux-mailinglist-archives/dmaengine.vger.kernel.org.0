Return-Path: <dmaengine+bounces-7034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20935C1B922
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3F5A5F26
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134E32573C;
	Wed, 29 Oct 2025 14:26:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E332A3D8;
	Wed, 29 Oct 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748016; cv=none; b=FsCr0Dq2tmqFUNmd4gAaliq5HYRdCn74xwABSMtMyzirKlA9PASUaiyzREZxWGxParyijdHkPmqqLVFZtD21U0QxvaLXTL0+jMmStgzjKzhMDcpo90igsDqQoFYlDsmBAf3926aCy1Hz2p+8E7dDKd9GSv/YnAHnt5p0xgIPxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748016; c=relaxed/simple;
	bh=gjfvwBmM6WTCHadbPAzKhJOs5Dx0xvLh0oPHOjl1n4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6o+PvKojCM0lvL99G8r3CIAa1GlRwLvLKL2ZmD7cGnYQ+vzcYe2nzNWxUtew75iLuGY105sz4rMtiDUyRFXIFD6DP0+7R3Zy+tVL+fAu2AZanLwumvJjn+qCXTdTzgN6NOMUG16r6k2rBkPRS3WHGF6ydTTsXjzjJMJJ1oeJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 59TEQW7W080421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 29 Oct 2025 22:26:33 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 22:26:33 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 1/2] dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
Date: Wed, 29 Oct 2025 22:26:20 +0800
Message-ID: <20251029142621.4170368-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029142621.4170368-1-cl634@andestech.com>
References: <20251029142621.4170368-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59TEQW7W080421

Document devicetree bindings for Andes ATCDMAC300 DMA engine

Signed-off-by: CL Wang <cl634@andestech.com>

---
Changes for v2:
 - Add platform-specific compatible string "andestech,qilai-dma" and
   remove "andestech,atcdmac300".
---
 .../bindings/dma/andestech,qilai-dma.yaml     | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml b/Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml
new file mode 100644
index 000000000000..c7158e4f4639
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/andestech,qilai-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes ATCDMAC300 DMA Controller
+
+maintainers:
+  - CL Wang <cl634@andestech.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: andestech,qilai-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@f0c00000 {
+            compatible = "andestech,qilai-dma";
+            reg = <0x0 0xf0c00000 0x0 0x1000>;
+            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..e0b9ef522139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1778,6 +1778,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES DMA DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/dma/andestech,qilai-dma.yaml
+F:	drivers/dma/atcdmac300*
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
-- 
2.34.1


