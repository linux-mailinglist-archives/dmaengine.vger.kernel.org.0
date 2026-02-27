Return-Path: <dmaengine+bounces-9147-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GeuL6lGoWkirwQAu9opvQ
	(envelope-from <dmaengine+bounces-9147-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:24:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4441B3D2D
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 08:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B280031632C8
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEFE364946;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4nQoMsc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB0332638;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176857; cv=none; b=EAX5geHYnWnOzS7WRJLLl/wOtgD2/v0mAi8PnDeqlagXJA8kWFGSznepA5JdjW2uLBewGfdFaQ965975h70iHOsKMxK5EN6MIcTum6Nud3LNqqNYy84pjJ8skpZy5QxsyDLONLQW93FfcvZsNUe/Rvv+2HPCkn6kZM+iN8z0xFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176857; c=relaxed/simple;
	bh=T7mCD06lDU5DfC9aZgE7urBavQIEpNqLFoT5bM3tG1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJqzHRlTPYjXT0p489AoQ1a2iMLsIQ+bv8+FkFNtUKW/tFCzrttEnD+83zKf5UGMF1wra+K3gHUHJOaeshtAKFTxDoFKvRVzx6c7pszMGME2P1l+jnXrvdtPav2VW5831OTOK2y+2lHXPq55bW9l1IlAgxFgEjlWgkjCStWlhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4nQoMsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03E36C19422;
	Fri, 27 Feb 2026 07:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772176857;
	bh=T7mCD06lDU5DfC9aZgE7urBavQIEpNqLFoT5bM3tG1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n4nQoMsc8cTql05xLqUbXNHUlUQDCi+d1bqD1Pmm1CSbCZSIwDKAfW+3jrBa+Qz3r
	 8NMr/+n/AeolLOT16C+Zoip5IWdDfTgNYHT1I4RBJxzckRuhoW9Xwtc0QuOY6CwbeJ
	 RVH3Y0k9cb5sZJwz5RKPJhWQwx4Awd6FCTsQ+rBzT5XWOqlGSCthosmNWcb1kwGDKp
	 Z4Ghyt3/ni5FKsu30l9y8fEOffyedQaovVnpx61H5BD2raYc9sG4VWqOmF3l0oAr+3
	 7QsAe2PfzgENRpKIH7TGVZfz5SPXst8VoWrMmWr3AKefEgXqWBvGbyNt1sjtJfJ4tT
	 p70Qal3iUf2Ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB2FD5304;
	Fri, 27 Feb 2026 07:20:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 27 Feb 2026 07:20:53 +0000
Subject: [PATCH v4 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-amlogic-dma-v4-1-f25e4614e9b7@amlogic.com>
References: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
In-Reply-To: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772176854; l=2714;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=kAPLFHoe2A7SVw2vXJTjrGauMsdYZiEvifE22xpjjBo=;
 b=yX2kd6NWfUScjoGpltvYYUcwtCcpiMw2C1VdfpjjA01frK3bCd9gn8zxl94ebazsSzxovYqDI
 O7D27TXGZDQD/gvIuHYER7G5LbLL77iE/qQ/bWuiZPfh81uQIjPKaa4
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9147-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fe400000:email,devicetree.org:url,amlogic.com:mid,amlogic.com:email,amlogic.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E4441B3D2D
X-Rspamd-Action: no action

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add documentation describing the Amlogic A9 SoC DMA. And add
the properties specific values defines into a new include file.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++++++++
 include/dt-bindings/dma/amlogic-dma.h              |  8 +++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
new file mode 100644
index 000000000000..efd7b2602c33
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic general DMA controller
+
+description:
+  This is a general-purpose peripheral DMA controller. It currently supports
+  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
+  for the same peripheral use two separate channels, controlled by different
+  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
+  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
+  there is no significant difference.
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a9-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sys
+
+  '#dma-cells':
+    const: 2
+
+  dma-channels:
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dma-controller@fe400000{
+        compatible = "amlogic,a9-dma";
+        reg = <0xfe400000 0x4000>;
+        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc 45>;
+        #dma-cells = <2>;
+        dma-channels = <28>;
+    };
diff --git a/include/dt-bindings/dma/amlogic-dma.h b/include/dt-bindings/dma/amlogic-dma.h
new file mode 100644
index 000000000000..025ecc42e395
--- /dev/null
+++ b/include/dt-bindings/dma/amlogic-dma.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+
+#define AML_DMA_TYPE_TX		0
+#define AML_DMA_TYPE_RX		1
+#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

-- 
2.52.0



