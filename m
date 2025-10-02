Return-Path: <dmaengine+bounces-6745-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB8BB4020
	for <lists+dmaengine@lfdr.de>; Thu, 02 Oct 2025 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1F9192609F
	for <lists+dmaengine@lfdr.de>; Thu,  2 Oct 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312C3112CF;
	Thu,  2 Oct 2025 13:17:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C5255F5E;
	Thu,  2 Oct 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411070; cv=none; b=ABa8p4I5h3wMHscx3tqHqUMSHgER0StYGnVPCzYR/rbvOKoWVp+Bsb7fHBRMotC+sN8H+0a93l2mXHfqwD1AEd/HNbmedA+FKuyyxb9m4b8pV0AekXqLXPxGMn2DRmb/FQdf6mnxtVKYkByMLCdawpT6LbcwzGVgHnXiYC69vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411070; c=relaxed/simple;
	bh=TZwBNxE5ArDZwTU0zTDah05bHJ9XjPwSqny/oe2iHOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kckjZxgBGHc40iwsWWZ84JZIVHO3U+izLGkmNsLM98LLYPjzyJqJFc739f8MGRhRrJimLfoAgtlwgWkZDU88lS1b0YxTdQ5/GCnXjr7OvocQJTyJ+Py9M+8SaT6ymRmK72A5mqDFQOs5My9xug/DYopw6GkGdKtJXTfq8MB2FYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 592DHEkS031947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 2 Oct 2025 21:17:14 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 21:17:14 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
Date: Thu, 2 Oct 2025 21:16:58 +0800
Message-ID: <20251002131659.973955-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002131659.973955-1-cl634@andestech.com>
References: <20251002131659.973955-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 592DHEkS031947

Document devicetree bindings for Andes ATCDMAC300 DMA engine

Signed-off-by: CL Wang <cl634@andestech.com>
---
 .../bindings/dma/andestech,atcdmac300.yaml    | 51 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml

diff --git a/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
new file mode 100644
index 000000000000..769694616517
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/andestech,atcdmac300.yaml#
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
+    const: andestech,atcdmac300
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
+unevaluatedProperties: false
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
+            compatible = "andestech,atcdmac300";
+            reg = <0x0 0xf0c00000 0x0 0x1000>;
+            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..dd3272cdadd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1778,6 +1778,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES DMA DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/dma/andestech,atcdmac300.yaml
+F:	drivers/dma/atcdmac300*
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
-- 
2.34.1


