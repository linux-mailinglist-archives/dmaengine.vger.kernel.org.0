Return-Path: <dmaengine+bounces-12083-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xav6MqxvTWoT0AEAu9opvQ
	(envelope-from <dmaengine+bounces-12083-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 23:29:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195571FC2A
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 23:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aJu5yI5J;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12083-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12083-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99FEA3009999
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAB377EA9;
	Tue,  7 Jul 2026 21:29:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9B30FF1D
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 21:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459752; cv=none; b=E5DSCkqrKZTZ9wIzfC5IvAOaaLtj6cdR0Vz0oHKDQ36HdQPHsVIvfC7bcpIUE6+npIC8t/oDm7sqYpj2qpT6m8AUn/SwhxZgf8S8oVU6NCNlAYqJDT6N8vLylAvKs00jQybkrFzSoul0zjStrgyrRh+gfy0GEgH/AVmybLquK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459752; c=relaxed/simple;
	bh=7KrKIvJFv/7r32JxKg5F4GCujmVid0mIntY6Ow7tX6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h+HvhJjBCpQT7bYdcqaLseAiHSNj/zacBrpOMxwhaGPDJ/9+IPNa9lZarI1etapilERZrVDJEIsVA9x3LUYzW3vTwrcyxqIOiz64JtDB1co9sej4ev8/LUv9dJPBTnyvQNhoiVhniIJuju6Rpbqvd+UQXdgYd9VTuhY/eoaoMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJu5yI5J; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so2053a91.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783459751; x=1784064551; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A6xN/HMFEGntFn1hQIosLAbrSvkr9CttasVt2xbou+A=;
        b=aJu5yI5JB1eTvNP3tVsymHXN+ZP9EjSPsD2T3uXTTkFU8V2P1lAUTPH2D+aoZ3TXvM
         ioTfDul9JWgg4pKcKxyRmKAx9d0ZRgRt0uzMmpJ19rc1PaaI51Wlwf8WY5KL6p9Hg/O3
         oE1uDl1rXzJc4lmb/ETAhEAioduNoxtp0CxHEE4Lzz3885bJ0baBVsoyUQ70irSnNjKb
         i1vBYueScTxazg+aa7TbNw6oG7kAR8gL7/E1CoYwYFaEfchrFbENGvg1LJ9/HwBvJRnE
         AP6USsx6dIicUlCToGXpw24q7fHTc6dQkTzh5YsjmsumxvSOLZcvgvfdLXRSfJycPpZg
         P6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783459751; x=1784064551;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A6xN/HMFEGntFn1hQIosLAbrSvkr9CttasVt2xbou+A=;
        b=Mdd7835bWrqEbc0EYn6y3e6J6uHkV7Jhd4dYvPyFnhWRe0incTaU0VrgfoeQ3HvcrR
         DHYccSm5ZS9HWrYYmIpV4sDANdMXB0v6kS2mH0XGO2HdCxQxt3TJJg3eu0xaGqJeDmN9
         +GPzU4UJF4pX+8HqxGJ3b7QMep2stsu8lMxr/DvxkTRqrhl2fRLL4VvzCYyEQj87nfiF
         IZh9kuZy2HS/5fBIiaYC7uVMcxQMT3pGAsT06D+a1kSfJKt0Spc8asDA2ea/ouTD0l3v
         EAs9jB71UHG9ShrMz8V1A3dZ1uPQBlXek3Nr5pGefdLaQnf6D1UaZheecBFSdMBbV6gt
         NK8Q==
X-Gm-Message-State: AOJu0YwakMSidCpt50g+/ioM08ZFxFt4ARi3n2FFZ6Gxc2EcoyIu79I+
	fgMPeqxvHjoN49BZga/H7KLSa07OXYPilS5QaCe98TzQFA1gr/wEnySh
X-Gm-Gg: AfdE7ckpFYQNLCpa9HpZ6dNo9PREQSVT8ekOgh5VrSdV2Qj7LLKGkuASP7/8KnR1Ymw
	PEoNMNdxX7l6H76e/enFB/uFLqBOXJpIycYCkENcGNhr2dE++nBJ+PLrcBzgn31yPPDsqFTqKCa
	2DBNN7gmnpmCv4ZvuwI1Tl7r0mCabwK+2dPx+BHFy16SpxqTGkBRovDsabzkvQ0btD93GklEdoA
	qxcPu5dVBUixZnvSk6sCVyg5LEsaxfMG3yGBydAvGLE4yzk+3z+QmSasnG2Q7cpq1HmqUuJQN6T
	hixdX2t+U8MiVRVhRHqZPoZI0ctf+Spk+oqDssI7RMEdx0iFxFOjCDimLSRzHRvvHJ1KbIb/wP/
	tbIjTfYQ9EkIByPjmU0qjfGHT7phRJvokdjlHYl2b8FVt7hroQfEtbMrE3PKoORqNQ5i1qImCjV
	BbStXqeWDs9B7iocQCKk7YSw==
X-Received: by 2002:a17:90b:3e4f:b0:381:2788:a437 with SMTP id 98e67ed59e1d1-382802bcc65mr11766155a91.1.1783459750645;
        Tue, 07 Jul 2026 14:29:10 -0700 (PDT)
Received: from [192.168.1.2] ([2401:4900:881c:7ad8:e5f1:b20c:5138:fdef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac0557sm14885868eec.26.2026.07.07.14.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:29:10 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 08 Jul 2026 02:59:01 +0530
Subject: [PATCH] dt-bindings: dma: ti,dma-crossbar: Convert to DT schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3ZJM3ZTcRN3kovzi4qTEIt3EVAsTQ8Nk0xRLCyMloK6CotS0zAq
 widGxtbUAGy5c9mEAAAA=
X-Change-ID: 20260708-ti-dma-crossbar-ae8411c5d982
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783459745; l=6488;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=7KrKIvJFv/7r32JxKg5F4GCujmVid0mIntY6Ow7tX6A=;
 b=3lzpmHo3NOSOuZey/YoSurUZTn2lLfPihC3mo8YyBdOXC7G39QfBlWdxcvGRFCOAGtXPDbUi5
 0ElFsigHzHdA1nFfcWibU4ftC7Xm5VZ7fFQljiAORPj0WYkSSLYwBZ1
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vigneshr@ti.com,m:peter.ujfalusi@gmail.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:goledhruva@gmail.com,m:m-chawdhry@ti.com,m:daniel.baluta@gmail.com,m:simona.toaca@nxp.com,m:j.bhargav.u@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,m:jbhargavu@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12083-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ti.com,gmail.com];
	FORGED_SENDER(0.00)[jbhargavu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ti.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbhargavu@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4195571FC2A

Convert Texas Instruments DMA Crossbar from text to DT schema

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../bindings/dma/ti,dra7-dma-crossbar.yaml         | 105 +++++++++++++++++++++
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  68 -------------
 2 files changed, 105 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
new file mode 100644
index 000000000000..287260396098
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti,dra7-dma-crossbar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DMA Crossbar (DMA request router)
+
+maintainers:
+  - Bhargav Joshi <j.bhargav.u@gmail.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dra7-dma-crossbar
+      - ti,am335x-edma-crossbar
+
+  reg:
+    maxItems: 1
+
+  "#dma-cells":
+    minimum: 1
+    maximum: 3
+
+  dma-requests:
+    minimum: 1
+    maximum: 256
+
+  dma-masters:
+    maxItems: 1
+
+  ti,dma-safe-map:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Safe routing value for unused request lines
+
+  ti,reserved-dma-request-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      DMA request ranges which should not be used when mapping xbar input to
+      DMA request, they are either allocated to be used by for example the DSP
+      or they are used as memcpy channels in eDMA.
+
+required:
+  - compatible
+  - reg
+  - "#dma-cells"
+  - dma-requests
+  - dma-masters
+
+allOf:
+  - $ref: dma-router.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am335x-edma-crossbar
+    then:
+      properties:
+        "#dma-cells":
+          const: 3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    /* DMA controller */
+    sdma: dma-controller@4a056000 {
+        compatible = "ti,omap4430-sdma";
+        reg = <0x4a056000 0x1000>;
+        interrupts =  <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        dma-channels = <32>;
+        dma-requests = <127>;
+    };
+
+    /* DMA crossbar */
+    sdma_xbar: dma-router@4a002b78 {
+        compatible = "ti,dra7-dma-crossbar";
+        reg = <0x4a002b78 0xfc>;
+        #dma-cells = <1>;
+        dma-requests = <205>;
+        ti,dma-safe-map = <0>;
+        /* Protect the sDMA request ranges: 10-14 and 100-126 */
+        ti,reserved-dma-request-ranges = <10 5>, <100 27>;
+        dma-masters = <&sdma>;
+    };
+
+    /* DMA client */
+    serial@4806a000 {
+        compatible = "ti,omap4-uart";
+        reg = <0x4806a000 0x100>;
+        interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+        ti,hwmods = "uart1";
+        clock-frequency = <48000000>;
+        /* Requesting crossbar input 49 and 50 */
+        dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
+        dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
deleted file mode 100644
index 1f9831540c97..000000000000
--- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Texas Instruments DMA Crossbar (DMA request router)
-
-Required properties:
-- compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
-		"ti,am335x-edma-crossbar" for AM335x and AM437x
-- reg:		Memory map for accessing module
-- #dma-cells:	Should be set to match with the DMA controller's dma-cells
-		for ti,dra7-dma-crossbar and <3> for ti,am335x-edma-crossbar.
-- dma-requests:	Number of DMA requests the crossbar can receive
-- dma-masters:	phandle pointing to the DMA controller
-
-The DMA controller node need to have the following poroperties:
-- dma-requests:	Number of DMA requests the controller can handle
-
-Optional properties:
-- ti,dma-safe-map: Safe routing value for unused request lines
-- ti,reserved-dma-request-ranges: DMA request ranges which should not be used
-		when mapping xbar input to DMA request, they are either
-		allocated to be used by for example the DSP or they are used as
-		memcpy channels in eDMA.
-
-Notes:
-When requesting channel via ti,dra7-dma-crossbar, the DMA client must request
-the DMA event number as crossbar ID (input to the DMA crossbar).
-
-For ti,am335x-edma-crossbar: the meaning of parameters of dmas for clients:
-dmas = <&edma_xbar 12 0 1>; where <12> is the DMA request number, <0> is the TC
-the event should be assigned and <1> is the mux selection for in the crossbar.
-When mux 0 is used the DMA channel can be requested directly from edma node.
-
-Example:
-
-/* DMA controller */
-sdma: dma-controller@4a056000 {
-	compatible = "ti,omap4430-sdma";
-	reg = <0x4a056000 0x1000>;
-	interrupts =	<GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-	#dma-cells = <1>;
-	dma-channels = <32>;
-	dma-requests = <127>;
-};
-
-/* DMA crossbar */
-sdma_xbar: dma-router@4a002b78 {
-	compatible = "ti,dra7-dma-crossbar";
-	reg = <0x4a002b78 0xfc>;
-	#dma-cells = <1>;
-	dma-requests = <205>;
-	ti,dma-safe-map = <0>;
-	/* Protect the sDMA request ranges: 10-14 and 100-126 */
-	ti,reserved-dma-request-ranges = <10 5>, <100 27>;
-	dma-masters = <&sdma>;
-};
-
-/* DMA client */
-uart1: serial@4806a000 {
-	compatible = "ti,omap4-uart";
-	reg = <0x4806a000 0x100>;
-	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-	ti,hwmods = "uart1";
-	clock-frequency = <48000000>;
-	/* Requesting crossbar input 49 and 50 */
-	dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
-	dma-names = "tx", "rx";
-};

---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260708-ti-dma-crossbar-ae8411c5d982

Best regards,
-- 
Bhargav


