Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA382D5CCC
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfJNH4a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 03:56:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfJNH4a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 03:56:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so9631005pgc.0
        for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2019 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=k/ju0uxLkLwtL3sDWDJCprGxKz//1GuP8ugQKBBSTurB2DBli1VodHNahR+le8ArUW
         yYf8lfdY1mdptXyuBBoTgkrfaEffPGxpLi0BdzvZHnf0u1yZ5SJ1aEXgZZk7/O1J4SVa
         h/TkRNnxxIe+X7ICYeDw457FVI5cTvQTbZiCrqjOKPBIehiaTcYmsz81ukHKMKjlsryz
         Q5tEOgi42uUAGhrRbuZ/5+pU0Sg1kN5kyM7PZ3IvVW3V55HIpXE+l5D3UMSno9rEmBqf
         882ynOY89OgiJ5TXj3ZlPKvpuEa0my6ehw4v7CUPu5YVMN1rmP8XKZlQ5tQVgyr+DwFL
         zwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYgJCjRBqhwY0ulINWDVeN12R2Tn8RH5kuZplnJEZos=;
        b=Ld5MtLMpLwmZmeMwWw3/X9YCRAhoeSQ2iq5OhCn8cR15JgQcE3nXAGGJHgpMHdZpZj
         yWlHBs3XeNp1bvhvTf9LK4N2nW8gOlhrGcUpiHrCHrdNRcymkSQqmEpzgtdBtA1/lpGl
         ktPIBHsRqVKn26TogiSsVmMio2YKWYxpQyvC2SVbPjBM3dt/Schvx3DXpnm6yrlw0Iy0
         qvaDkZY7QgwNatZSdVT2FbK4EyGO8Lb3HSraf4aGLKeUnMaf078RCUn598q7NF8DlboK
         eBmdQfj3fllXP8zpK4nDotHFHz+pieVt7dF3nSbKv8q1v4UOqPw3oTazqBWPEnZ2f0PP
         c/qQ==
X-Gm-Message-State: APjAAAXKRIzebss29rUfOF8s84RtWfWhCzkZbNzuKFXGtaMDJLKRougR
        1DWMlXVs7E+ctUvCkKSvB+4xMw==
X-Google-Smtp-Source: APXvYqz6tFVkfmFOz7LA+7Ptn1VlaJiPkif2QscBsinQM/p+ODS5CXWKT7Oydfmx35z0zZZjIf7slw==
X-Received: by 2002:aa7:8a97:: with SMTP id a23mr31494124pfc.76.1571039788241;
        Mon, 14 Oct 2019 00:56:28 -0700 (PDT)
Received: from localhost.localdomain (111-241-168-233.dynamic-ip.hinet.net. [111.241.168.233])
        by smtp.gmail.com with ESMTPSA id j126sm16583137pfb.186.2019.10.14.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 00:56:27 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for SiFive PDMA
Date:   Mon, 14 Oct 2019 15:54:24 +0800
Message-Id: <20191014075502.15105-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014075502.15105-1-green.wan@sifive.com>
References: <20191014075502.15105-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT bindings document for Platform DMA(PDMA) driver of board,
HiFive Unleashed Rev A00.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Pragnesh Patel <pragnesh.patel@sifive.com>
Signed-off-by: Green Wan <green.wan@sifive.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
new file mode 100644
index 000000000000..2ca3ddbe1ff4
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
+    minItems: 1
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
-- 
2.17.1

