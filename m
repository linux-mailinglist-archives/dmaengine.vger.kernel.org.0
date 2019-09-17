Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047E7B4764
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2019 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404218AbfIQGWo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Sep 2019 02:22:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41091 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404216AbfIQGWo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Sep 2019 02:22:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so1041963plr.8
        for <dmaengine@vger.kernel.org>; Mon, 16 Sep 2019 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H3ZFg6Ip4/ySx02vg351K3EIXCHgNEDMYbg7+0FsxGE=;
        b=lpeuK2juqN/qKVXGSyG+DrKB9lu5i1+75AnOkmalz4I/1UotZnqmGrQraPClhhYBDc
         i1UMXEalGUoD52lG2gH6Xkkov8Wjk4LSoVfMqWEG4DoqPUgxdrOCsgA1r6bSmLJf47zs
         u++uv0HCaezKN7MyOChrXe7xcHA2LP5be9PvkMlITbfLueY1fhlKjszoo813ND9NABEo
         Vh78+OiSTOCMtNKggBu3UPm6A3GbBJsSW7DvelQMDNtv5vVMhjD94HX/bhV/V0abl7AB
         fYHXZ6KULRMFDNr7gdUHUYI7NOdBOoQ+n+iJeqcvOv7vyVkD7TMfKLrLcFIXifqbU8PL
         /u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3ZFg6Ip4/ySx02vg351K3EIXCHgNEDMYbg7+0FsxGE=;
        b=PbalCBR4XCBtGiEGs+aafueIAbCJv1UUvS53ymCgscKkTqpB3yFBJbv373xdlcKLWt
         lI7ahlqAYDsIWs8YaimXaXh++ElZi6zYoakabZHqZKJhAMDdZrc9nWpY4VBO2a4hSfv9
         BD85sX49/BgqmriYX9qxOn2cBFa11xkapt7VGfeOxDKHSlVbMFUPhbNIKw25FpO9EoPn
         Hi1oCjfZ1z2phw2rJ9L+gyHXS6Y6l9+HLCNc8FNpdDtupCkkKJeoCQLXkrlGQVqTdgSB
         Urp2OKj374YoGCt5UShHNXPYmyHDXaBHaT2s+yyjB16ozfe//PsdndRsd6Z9c76it1Gg
         ev/A==
X-Gm-Message-State: APjAAAXxwloTrlpF/vA9ir7IEtGrEf8mJ5SiIHQ4KdrA1e+tIWCMdgfV
        ZRWPj89P8yiFm0QtG4eVontbIw==
X-Google-Smtp-Source: APXvYqxc1GSAJOFhL24PM4/sAigtUqJGuzkbsT3sbmZF9dP6esNli7c5E5OOqkMQBHYzpIIxZa8pFg==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12mr2076829plr.236.1568701363879;
        Mon, 16 Sep 2019 23:22:43 -0700 (PDT)
Received: from localhost.localdomain (111-241-124-228.dynamic-ip.hinet.net. [111.241.124.228])
        by smtp.gmail.com with ESMTPSA id v21sm1318096pjy.3.2019.09.16.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 23:22:43 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Tue, 17 Sep 2019 14:22:05 +0800
Message-Id: <20190917062239.762-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 63 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..b5423f1cfcaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sifive,fu540-c000-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Unleashed Rev C000 Platform DMA
+
+maintainers:
+  - Green Wan <green.wan@sifive.com>
+  - Palmer Debbelt <palmer@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+description: |
+  Platform DMA is a DMA engine of SiFive Unleashed. It supports 4
+  channels. Each channel has 2 interrupts. One is for DMA done and
+  the other is for DME error.
+
+  In different SoC, DMA could be attached to different IRQ line.
+  DT file need to be changed to meet the difference. For technical
+  doc,
+
+  https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 8
+    maxItems: 8
+
+  interrupt-parent:
+    description:
+      Interrupt parent must correspond to the name PLIC interrupt
+      controller, i.e. "plic0"
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-parent
+  - interrupts
+  - '#dma-cells'
+
+examples:
+  - |
+    dma@3000000 {
+      compatible = "sifive,fu540-c000-pdma";
+      reg = <0x0 0x3000000 0x0 0x8000>;
+      interrupt-parent = <&plic0>;
+      interrupts = <23 24 25 26 27 28 29 30>;
+      #dma-cells = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 49f75d1b7b51..d0caa09a479e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14591,6 +14591,11 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

