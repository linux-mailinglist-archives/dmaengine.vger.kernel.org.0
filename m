Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7901B8D53
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2019 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405405AbfITJAn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Sep 2019 05:00:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405402AbfITJAm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Sep 2019 05:00:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so4053305pfn.11
        for <dmaengine@vger.kernel.org>; Fri, 20 Sep 2019 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lZ6o83XsrCODlciR1nsXn3cLtmEeSlMrbT5toWJpCcc=;
        b=boRD9KgdLzUDsKREFe8UooLcvnhttqrmMKJ4JJhiYtlGGMw+CVF6SF+eZPxWodTfbL
         BNFPx1e5qW4K0Z19vCoeGPRDaw5+mnXvWTBdQns+nrRSQeFimtdY44ONxttr5iMp5alO
         TIlGWUwDdgP3OWd7JA6Cn2GCNYXO10D91svahg0d7vqDoSiZxLmu7ChaNdQH1JhZXhDu
         EQRo6w897sfn6bT21bnOvhffhZQxWPMQoIfDzWeieIlF3MBEbvgy0X6YaxAa/fJsMChA
         AxDMf7BVksAMmhU8syqB3tE0udnT9TiSQz3cIumCQMqa8VtcqgU4qwIMEOHO4ZsBGgOP
         kH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lZ6o83XsrCODlciR1nsXn3cLtmEeSlMrbT5toWJpCcc=;
        b=T5OsNqFyQN4CAwZPWIoe6xglJ8BhbA4t5l4wfdh5jZBw04cafsppiVPFoAVYxV0CVJ
         TdLlpk5YcjTuI17RuwOkxaMwP/deD41/JE/ryCRc3uv2JNAwPlOrtRoHPDP+hUnPh7aT
         lKnSxnA0nbrUPLEprfgmMLP88yVFxfDQm3oozH2JBgP9kZxZNyGwMpSG/a9D4tVyCfj5
         rDFK9vpd0ArZ+IlXxjh+GcYV22HkdozrvYYMSOneWixS6BmFA6GvDq8lD7v512gVfUGZ
         vr30KJ7Tcl+TYKHcmk1cJQA9K/rhchRRiVT02Hicb44lR6+ZNyjNFQzQE8IcVnSUvvs9
         OpYA==
X-Gm-Message-State: APjAAAUNUxcBOlxIQevgUSWhoF2CBqTcXPTId5mQ1JBxmtGOLPIzeMaa
        bpHROifpNJp8VhwaBnrkqNx2WA==
X-Google-Smtp-Source: APXvYqw+06XQxJJ/V6LSwB5FOqyXHpQco/KIgZInvygsU6gRfbquO1CkKRsztR7zc2+L4Gy1eVkotQ==
X-Received: by 2002:a65:4286:: with SMTP id j6mr14346419pgp.218.1568970041990;
        Fri, 20 Sep 2019 02:00:41 -0700 (PDT)
Received: from localhost.localdomain (36-228-113-219.dynamic-ip.hinet.net. [36.228.113.219])
        by smtp.gmail.com with ESMTPSA id n9sm1287730pgf.64.2019.09.20.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 02:00:41 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Fri, 20 Sep 2019 17:00:01 +0800
Message-Id: <20190920090033.19438-1-green.wan@sifive.com>
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
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..3ed015f2b83a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -0,0 +1,55 @@
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
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#dma-cells'
+
+examples:
+  - |
+    dma@3000000 {
+      compatible = "sifive,fu540-c000-pdma";
+      reg = <0x0 0x3000000 0x0 0x8000>;
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

