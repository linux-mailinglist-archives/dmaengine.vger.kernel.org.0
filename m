Return-Path: <dmaengine+bounces-8821-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEylAERPiWmb6QQAu9opvQ
	(envelope-from <dmaengine+bounces-8821-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B16310B528
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F147301F304
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E42EB87E;
	Mon,  9 Feb 2026 03:05:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22832EAB83;
	Mon,  9 Feb 2026 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606299; cv=none; b=O3Wt6kw5M9kD5IPnWWVyi+/N2dOA+5HwghsIEQfIbiwFW95aqjMTUplpkST1p5Rs321zUYJiDuxqpUhf6RRauH0GpxTu/OnDKEOB3cLodc9jM9FtKMMJPa77sV4iwZsZ2UCcHZo4jvZLYZ/fU/7SnA37YAb3xC+gHL324rzxWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606299; c=relaxed/simple;
	bh=LBHN9arRHjKLukSFxESXJSJM3dewaKHVbwXajKcUkTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtGliP58p58ABYhHCBBrOrW1CzsAwz9mm/LkcB72Jqv0O8MuB3FOU4GefWL/A9H0PD1fGwxEQ/0TX5jj4pR1kfywvZzvcPn78YqFUd/3tdSU1+Dsz5ny/xwFSFxA3RGMBnXH85vIOBpMYyNNQRalSS58K6TYInu0jf2pVDUFb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8Dx98HSTolpCvkQAA--.41747S3;
	Mon, 09 Feb 2026 11:04:50 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJBxKMHHTolpRO1CAA--.46046S5;
	Mon, 09 Feb 2026 11:04:46 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 3/4] dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
Date: Mon,  9 Feb 2026 11:04:20 +0800
Message-ID: <36cc977f0746095196354b631f0b158365208a0e.1770605931.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770605931.git.zhoubinbin@loongson.cn>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMHHTolpRO1CAA--.46046S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgENCGmIJZ8GiAAAsT
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWDZryrJFyrKrWfAF4xGrX_yoW5Kr1UpF
	sxCr9agrW0qF13Aan5JF18Cr1rX3s7A3ZrWFZrtw1UKr98G3WYvw4akryqqay7GrWxXFW7
	ZFZ29rWUWayxAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8821-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,aosc.io];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B16310B528
X-Rspamd-Action: no action

The Loongson-2K0300/Loongson-2K3000 have built-in multi-channel DMA
controllers, which are similar except for some of the register offsets
and number of channels.

Obviously, this is quite different from the APB DMA controller used in
the Loongson-2K0500/Loongson-2K1000, such as the latter being a
single-channel DMA controller.

To avoid cluttering a single dt-binding file, add a new yaml file.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/dma/loongson,ls2k0300-dma.yaml   | 78 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
new file mode 100644
index 000000000000..77e5df47ec01
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/loongson,ls2k0300-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Looongson-2 Multi-Channel DMA controller
+
+description:
+  The Loongson-2 Multi-Channel DMA controller is used for transferring data
+  between system memory and the peripherals on the APB bus.
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k0300-dma
+      - loongson,ls2k3000-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 8
+
+  clocks:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 2
+    description: |
+      DMA request from clients consists of 2 cells:
+        1. Channel index
+        2. Transfer request factor number, If no transfer factor, use 0.
+           The number is SoC-specific, and this should be specified with
+           relation to the device to use the DMA controller.
+
+  dma-channels:
+    enum: [4, 8]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    dma-controller@1612c000 {
+        compatible = "loongson,ls2k0300-dma";
+        reg = <0x1612c000 0xff>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <23 IRQ_TYPE_LEVEL_HIGH>,
+                     <24 IRQ_TYPE_LEVEL_HIGH>,
+                     <25 IRQ_TYPE_LEVEL_HIGH>,
+                     <26 IRQ_TYPE_LEVEL_HIGH>,
+                     <27 IRQ_TYPE_LEVEL_HIGH>,
+                     <28 IRQ_TYPE_LEVEL_HIGH>,
+                     <29 IRQ_TYPE_LEVEL_HIGH>,
+                     <30 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk LS2K0300_CLK_APB_GATE>;
+        #dma-cells = <2>;
+        dma-channels = <8>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 27f77b68d596..d3cb541aee2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14772,10 +14772,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
 F:	drivers/gpio/gpio-loongson-64bit.c
 
-LOONGSON-2 APB DMA DRIVER
+LOONGSON-2 DMA DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
 F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
 F:	drivers/dma/loongson/loongson2-apb-dma.c
 
-- 
2.52.0


