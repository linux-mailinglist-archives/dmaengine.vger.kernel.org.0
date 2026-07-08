Return-Path: <dmaengine+bounces-12124-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1c3N1N/TmqiNwIAu9opvQ
	(envelope-from <dmaengine+bounces-12124-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:48:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C867728DE5
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fpCgxJWK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12124-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12124-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E7530DCD1F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A73432BC1;
	Wed,  8 Jul 2026 16:32:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7732ED3A
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 16:32:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528365; cv=none; b=AtpSPw5fshpp1kTiEphLR7cdb0DI3DYo5sWCjcqFCQUVx3BJYhFZ6pDGKSVzW9kUQlfCocinSyH058RTbWD/RaJF8dIW1QA4UMf3XEn5/+FzQD0MUMedej1iqPqlsxUsFyts07IOEDZvCWeWLXKEf7d2oqfRNbpAEJCadar1XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528365; c=relaxed/simple;
	bh=VtZM2qD7Un0eQm+y6xnch5aCljKPdhMYWFqn+0laie0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O/aFLV3zoLyXi6oPlW/3CA2wBiJQBns0NouYvnSHcDsItdb52QjV6LniqOyo/aZM+QUvwg8YkuU2uW7ZdMVdx2kn4Mc7g5Z7Q0nI7iXzduKEfCvfV6qOzEKs3vUBHTbQnVtpip5kSOEkgTRbKVl6VOir5pv2y60jKEbCNtjin6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpCgxJWK; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca53979f8e8so60371a12.2
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783528362; x=1784133162; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fWuQ0mPWMJpAyjf5/+TbvMYXq9kqNgTMYENPSWW7pBg=;
        b=fpCgxJWKr2ROqzfv670bIti+IRxSqUIqBctdhnR7nL/BrFdmOcZhZwuNK4TwrDzlc1
         ZU2kQjIXsMla+3hOtmL8FflDI/8lA3t76Pue7WHyoZyY5QYPvEscoDC98f24GioP3IWs
         PKf7wJh4gPVbcxJG76j6wadCXjAu85O0eiEzZ5VmeeaDzNUPVQwp2rJzGmoMix9r4ECD
         FBIGrjjcmzKUfXCuP3WQQybme5XUHTU0KNV0eBIICMVvmCIWeh9nTqyPkiAvvF72FyxN
         kO8BW4qIU0IxFlbYPMafWcfNQTdvgsV+8mCr5NNp8/G+jYad8eV8w70pRzVtWup96Cv6
         CU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528362; x=1784133162;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fWuQ0mPWMJpAyjf5/+TbvMYXq9kqNgTMYENPSWW7pBg=;
        b=gTRWr6EiXBShrYO+aU9KcJSvfZQY2TKaV6F4h18l9OcFD1mxfOpJqqi2OH4R1oWIdP
         NRCkbF2BZ1wG8fqRT+pZFzyLz8/UVXT1IfLp3EQRMHulzPdOltf5SyjyaMQ2cQ80G36H
         BpNtj2mQBMWQxJQ1H00JsLcTufTt4yXfasV+oG+aoGrzBbqBAWLzJOKs6CQznM6At2yx
         D/ZAFRXN0sjtn/tkLFPcWO8WfCLNJ7e+yjjotzd3/MybaSMLcG1JCG9ZORfqGBfZ33wS
         AXqgP1j3K4JL8JyVa0juUY1K1zsdGMPYPuaCA2UzDQ7WtAYOPddQ/rnYSaSL1HtLOc0x
         5e1Q==
X-Gm-Message-State: AOJu0YztapFfzHvAs93ZYRrTku9YX13y6cwnpBsT8bPfUy6BSF7IsbPV
	uNznryZfXRdKvTp+0d0ZNfxPUTmoK30kavSnS+sSOcEcYYNr37/Sk7fO
X-Gm-Gg: AfdE7cnqi6nYsldNFSR5U3OYgDZVpB6zO4T+H4Y9QUhflfkJtkKPAbee2rUMy05+dZ/
	jMrhCaKxh3gdGuWqPhQQlyb/fcwjUQYxVfV5RqiWFW1f2oXugD/auRxhyyPhQp8Udg6xW3/1369
	aBCVfc0AMHJqSPbdL97SWIwnAMqbmQEhmiiUK6hqpCgUjKWw5HYNmldww08Nl1n9WjIs/zBgB/U
	DmzaXATNTheUS99TcTVLxugstdZj+ubDDOCxxp6ec7pVUydB2HHK+BOjKFKbBzHn1qtVLGTEM4k
	T9UiE8d0KUyFAVHT1zuuwiXqsWci2/4+PafJ9XewjXVE0OqamZQIawPz4OPXP/Vaa572vgYYYh6
	NI3uUxTiXrLqPPlLEFq9ym52k/HntHHNaG2VyzBgRDkwbxmNDzCXtHMuLtEv5SjdLIKMRJPEUSr
	xv5R/ZBzKZcTkGdKp0y9DKew==
X-Received: by 2002:a17:90b:3502:b0:380:7688:fc06 with SMTP id 98e67ed59e1d1-38a21af6569mr199889a91.8.1783528361810;
        Wed, 08 Jul 2026 09:32:41 -0700 (PDT)
Received: from [192.168.1.2] ([2401:4900:881c:f765:f05c:d31e:8ae0:b06d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm21334679eec.22.2026.07.08.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:32:41 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 08 Jul 2026 22:02:18 +0530
Subject: [PATCH v2] dt-bindings: dma: ti,dma-crossbar: Convert to DT schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ti-dma-crossbar-v2-1-2ac0d6efde36@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFtxVJc+R+GRe0DJhFKWtJoS
 P/dyt7lOck9d4fkIrkEt2aH6DIlCksFcWrATHoZHZKtDIIJyTqmcCO0s0YTQ0pPHVE71XJurrZ
 XAupqjc7T+yg+hsoTpS3Ez3GQ+c/+b2WOHL0UXS9boTy/3MdZ0+tswgxDKeULecmDJ64AAAA=
X-Change-ID: 20260708-ti-dma-crossbar-ae8411c5d982
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783528356; l=7311;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=VtZM2qD7Un0eQm+y6xnch5aCljKPdhMYWFqn+0laie0=;
 b=8UUVG/V7m8IFQrOl0+Czl3uNXOfTfrrryplL13fs8AJOXUF7Ax34fabmQJKV+LqcpqDSIYrRY
 f6BvLJU/Ni/C6zeDtxaLninKrrlVYV50kicVUaNZbqfIq/mcpAX2jt2
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vigneshr@ti.com,m:peter.ujfalusi@gmail.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:goledhruva@gmail.com,m:m-chawdhry@ti.com,m:daniel.baluta@gmail.com,m:simona.toaca@nxp.com,m:j.bhargav.u@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:peterujfalusi@gmail.com,m:danielbaluta@gmail.com,m:jbhargavu@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12124-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C867728DE5

Convert Texas Instruments DMA Crossbar from text to DT schema.
Modify MAINTAINERS file to correctly point to new yaml file.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:
- Removed the unmatched `ti,omap4430-sdma` compatible string from the
  example block and trim down example
- Restored dropped documentation regarding client dma-cells
  configuration into the top-level description block.
- Updated the MAINTAINERS file to replace the old .txt reference with
  the new .yaml file path.
- Added constraints on its inner tuple dimensions of
  ti,reserved-dma-request-ranges
- Link to v1: https://lore.kernel.org/r/20260708-ti-dma-crossbar-v1-1-f62796428f13@gmail.com
---
 .../bindings/dma/ti,dra7-dma-crossbar.yaml         | 89 ++++++++++++++++++++++
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    | 68 -----------------
 MAINTAINERS                                        |  2 +-
 3 files changed, 90 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
new file mode 100644
index 000000000000..3de4f53797d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti,dra7-dma-crossbar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DMA Crossbar (DMA request router)
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+  - Bhargav Joshi <j.bhargav.u@gmail.com>
+
+description:
+  When requesting channel via ti,dra7-dma-crossbar, the DMA client must request
+  the DMA event number as crossbar ID (input to the DMA crossbar). For
+  ti,am335x-edma-crossbar the meaning of parameters of dmas for clients dmas =
+  <&edma_xbar 12 0 1>; where <12> is the DMA request number, <0> is the TC the
+  event should be assigned and <1> is the mux selection for in the crossbar.
+  When mux 0 is used the DMA channel can be requested directly from edma node.
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
+    items:
+      items:
+        - description: starting DMA request line number
+        - description: number of consecutive lines to reserve
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
+    dma-router@4a002b78 {
+        compatible = "ti,dra7-dma-crossbar";
+        reg = <0x4a002b78 0xfc>;
+        #dma-cells = <1>;
+        dma-requests = <205>;
+        ti,dma-safe-map = <0>;
+        /* Protect the sDMA request ranges: 10-14 and 100-126 */
+        ti,reserved-dma-request-ranges = <10 5>, <100 27>;
+        dma-masters = <&sdma>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index f37a81950e25..a4b39e0dc178 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26710,7 +26710,7 @@ TEXAS INSTRUMENTS DMA DRIVERS
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
+F:	Documentation/devicetree/bindings/dma/ti,dra7-dma-crossbar.yaml
 F:	Documentation/devicetree/bindings/dma/ti-edma.txt
 F:	Documentation/devicetree/bindings/dma/ti/
 F:	drivers/dma/ti/

---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260708-ti-dma-crossbar-ae8411c5d982

Best regards,
-- 
Bhargav


