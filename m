Return-Path: <dmaengine+bounces-11796-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tTYGMbAQPmrG/QgAu9opvQ
	(envelope-from <dmaengine+bounces-11796-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:40:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 399726CA708
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=FzMQsLtB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11796-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11796-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87BF530432EA
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFB3C819B;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83C3C6A38;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452378; cv=none; b=j2ydVpgyTltngZpGJmJqxOJ68YimMGmq9CrMqLSy+4lb5tX5Ftg33Y5IenNr0TZVA9PPgIhITJu+AyXN2Ahn/XAMRHQdtyIr2JeYD64vq3vxK++Uep/meFhF1mC0UxxjmD5bKMsRYEMip6CPbd3ZmgtHpGLZ6VqMguIBDE2E5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452378; c=relaxed/simple;
	bh=/BgmOAire621Z/jgVhyfIQNUbAABDn5uV30D8Z3Qf0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJ8alWXXjBuOKNbcW19wUU8j8wuuy5oiPFIcYGOiel0r8tobWXHXo0k2kzQZ88vKoA73pkaWeHbe6KQijslUfjCRBJab37qoo04OrYHgE3OHnSvd0WATo3l2fG56Vuur7jAshSTg+92CWCbZsHU7gEXEjh0qn+/SQIS5uxvpaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzMQsLtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184D5C19425;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782452378;
	bh=/BgmOAire621Z/jgVhyfIQNUbAABDn5uV30D8Z3Qf0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FzMQsLtBWQ/Ch0BV5BGSlZvl9VVgJOK4tcMpkX2WIfetymjuRnIWhaUk4pIJ2KmZi
	 DzYfYDSUvplCuOSqVFrxGR5PvfoHw1US8R936pN7ad1fzFg1GCUjmk5uqHZJ0BDM19
	 NyfZAro11PcHJCNZnIUadj4Ds2IWPQV71qwN0mfyo6K/Nzy6lqQjOXBvzs4ChSPU4y
	 KA/nnCR0g0Fbt2SVX89hBULIxoPgH3BRkqVtNuJSEhR41OHXNcPkdUPATsqNqaeXpA
	 IgYq7jtKP+nX808ZjYINEs4OMOkIRLPxnVRKBCOE8nagSFv3W+RIJHv0slI092oPdn
	 iIKBZswsa3JtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F0CDE011;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 26 Jun 2026 05:39:33 +0000
Subject: [PATCH v9 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-amlogic-dma-v9-1-558d672c4a95@amlogic.com>
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
In-Reply-To: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782452375; l=2780;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=wQ86G1QdzFbWQ2wHf2Egs+gPp1C5gmZDaeMgB/r2pGQ=;
 b=ppgaT6gwT0uqOphL4VNgv8VIir4JAXEuCP8ve3JzmHX9ygvs5b+NO3nhUW+pFr7spMROVmGTo
 Sa9CtNzX40RDT+6QQ7w+VW+O1l2cLWJKwopzrelEDdGxVLHF0EhGTNX
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11796-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:Frank.Li@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:xianwei.zhao@amlogic.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:replyto,amlogic.com:email,amlogic.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399726CA708

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add documentation describing the Amlogic A9 SoC DMA. And add
the properties specific values defines into a new include file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 65 ++++++++++++++++++++++
 include/dt-bindings/dma/amlogic,a9-dma.h           |  8 +++
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
diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
new file mode 100644
index 000000000000..c59c2fd4b956
--- /dev/null
+++ b/include/dt-bindings/dma/amlogic,a9-dma.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
+
+#define DMA_TX			0
+#define DMA_RX			1
+#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */

-- 
2.52.0



