Return-Path: <dmaengine+bounces-11088-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOwyAyFbHWrnZgkAu9opvQ
	(envelope-from <dmaengine+bounces-11088-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:12:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764BE61D1F4
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1C530488D9
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82663A5443;
	Mon,  1 Jun 2026 09:49:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7133A9D8F;
	Mon,  1 Jun 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307397; cv=none; b=YcgQ40RMhKvTJDe5uUWfUYRcvCoQsse75tfy15AZmBXU/LwLV1TcFPCytLfx0lfufSUekldGsTFRwD5moLQe9Jn0CTuhOYw/PSopqauIq5RYT9uiu2EIXqi50SOHH532bSTv9tOPkoaGjSLdU1XA/cl5jVyxBb4eAIm0fKbt92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307397; c=relaxed/simple;
	bh=GY/9jcycFYhRRmN1vTL37WOjuJGboSqHcyI9SmmiG20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7RBOLOxqie5CqKz6Qja5+f+tDtapsdsUKHGWE08U7ea9mQy44tupEPNjanDTbeNK83yHg21ipzschfzN3MmTkXtl/ErM3M+ZL7ivObrKIba2jCHM54yT8qdu1kL0f1lEiqJi7PJm50OpTsDO8LXinA4Ahwk2qlhJ0Z/4aPL0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 6519nCZf065448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Mon, 1 Jun 2026 17:49:12 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jun
 2026 17:49:12 +0800
From: CL Wang <cl634@andestech.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <cl634@andestech.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
Date: Mon, 1 Jun 2026 17:48:44 +0800
Message-ID: <20260601094846.1097678-2-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094846.1097678-1-cl634@andestech.com>
References: <20260601094846.1097678-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 6519nCZf065448
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[andestech.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11088-lists,dmaengine=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cl634@andestech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.857];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,andestech.com:mid,andestech.com:email,microchip.com:email,f0c00000:email,devicetree.org:url]
X-Rspamd-Queue-Id: 764BE61D1F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document devicetree bindings for Andes ATCDMAC300 DMA engine

ATCDMAC300 is the IP name, which is embedded in AndesCore-based
platforms or SoCs such as AE350 and Qilai.

Signed-off-by: CL Wang <cl634@andestech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
  Changes for v4:
    - Use items list format with descriptions for reg property
      as suggested by Conor Dooley

  Changes for v3:
    - Rename DT binding file from andestech,qilai-dma.yaml to
      andestech,ae350-dma.yaml
    - Deprecate IP-core-based compatible usage and align with
      SoC/platform-based
    - Dropped Acked-by tag from Conor Dooley due to the above change.
---
 .../bindings/dma/andestech,ae350-dma.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
new file mode 100644
index 000000000000..f040a2bf7d4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/andestech,ae350-dma.yaml#
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
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-dma
+          - const: andestech,ae350-dma
+      - const: andestech,ae350-dma
+
+  reg:
+    minItems: 1
+    items:
+      - description: DMA controller register range
+      - description: cache control in IOCP controller
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: dma
+      - const: iocp
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
+            compatible = "andestech,ae350-dma";
+            reg = <0x0 0xf0c00000 0x0 0x1000>,
+                  <0x0 0xe8000000 0x0 0x10>;
+            reg-names = "dma", "iocp";
+            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+            #dma-cells = <1>;
+        };
+    };
+...
-- 
2.34.1


