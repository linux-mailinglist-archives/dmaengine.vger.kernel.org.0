Return-Path: <dmaengine+bounces-9050-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHoHJbannmnfWgQAu9opvQ
	(envelope-from <dmaengine+bounces-9050-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0A193A5F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE61303C84C
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96E2FF161;
	Wed, 25 Feb 2026 07:41:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372362BEC30;
	Wed, 25 Feb 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005288; cv=none; b=sna5NCPF/zfSizLH/mFQ/tyeCII5f5JHejYX3uErSRnyHZbk/rQiKvUcKwaZFyIl4d79cIVKsTUSaqZM4Fo+1fdcONqLnmUQRAwCdzdQ6yptiWa3cePK/ff3gGYYMHODO+vEUi6o8Zwk8T708utVIzN6ER9wMA0n/+WkHuMVLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005288; c=relaxed/simple;
	bh=EutGQUaMDIzHuWT1tx8LPFOvQZ2f7qftHu1DzmloBGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuCNOe1bvoZfnioothUkEMrWUUsKA0a/RkM7pW/x1vhlv5E/oQhtlRkzpzULSCO3pcECz44yofGRH2ZQA67wyYSrZUvAXKgS4zjPVJ7pSs/GBJKctyZVPY+4uQugk5qRDwWoUkoRHuER3rtbg5VZ/NSQjWn+76wwTW18sJ9/1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8DxccChp55pI_4UAA--.5165S3;
	Wed, 25 Feb 2026 15:41:21 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJBxSeCep55pI8RKAA--.10141S3;
	Wed, 25 Feb 2026 15:41:19 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v3 5/6] dt-bindings: dmaengine: Add Loongson Multi-Channel DMA controller
Date: Wed, 25 Feb 2026 15:41:10 +0800
Message-ID: <37c29c43b8acb406a3d20c4575da7d4f1163d812.1771989596.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771989595.git.zhoubinbin@loongson.cn>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeCep55pI8RKAA--.10141S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEJCGmejz8BlwAAsQ
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWDZryrJFyrKrWfAF4xGrX_yoWrJr1DpF
	ZxCr9agr40qF13Aan5tF18Cr1fX3s7A3W7WFZFyw18Kr98G3WYvw4akryqvay7CrWIqFW7
	ZFZa9rWUWa4xAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0lPfDUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9050-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,lists.linux.dev,vger.kernel.org,gmail.com,loongson.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0FB0A193A5F
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
 .../bindings/dma/loongson,ls2k0300-dma.yaml   | 81 +++++++++++++++++++
 MAINTAINERS                                   |  3 +-
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
new file mode 100644
index 000000000000..c3151d806b55
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
@@ -0,0 +1,81 @@
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
+    description:
+      Should contain all of the per-channel DMA interrupts in ascending order
+      with respect to the DMA channel index.
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
index e8cd1e2dac13..aea29c28d865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14948,10 +14948,11 @@ S:	Maintained
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


