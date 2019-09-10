Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA7AE214
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392567AbfIJBrX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 21:47:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41201 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392565AbfIJBrW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 21:47:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so10514393pfo.8;
        Mon, 09 Sep 2019 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPs6A8lDNpICZmUpEyxEyuqr3RMXqZTPOjxLSO08Fjs=;
        b=fbv2oHguO69qstVBK6kmyRwhUkmfa86gv053xwDJkbrjHeGk28T2Wc/6KWLtAFHwy8
         NZ7aObpFOjH0/MJHTkBySiFUrDci9j9NJ5ErxcNTkjE6CRqIx+p1VacCeuSGeUzcV7ez
         tYpyGhAgZKlWMQC+o1ZryqRZfCRJrEW3e/vzO6LVu1f9nCrvwiVqTp2u5tqoJ7EVAFBK
         YN16iFWD8Bc7QRlizY/uh7xqUGtcoB0FX/cPbvPAedgVYNE+fe+rhIP4jphwyauslUQA
         pZ7MICDE/uaPoeCa4+Drl3dhFnjf27kHnKTETHZVxkw2tuvloX65XMx1sIhA+jNuVY3b
         Wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPs6A8lDNpICZmUpEyxEyuqr3RMXqZTPOjxLSO08Fjs=;
        b=nK6tFU9XnkPhAzrxqGadSIerwfvfBsSFjd7eLkhDm6Qzfxt+zKim9Zb46e/GAYSXi6
         69Zt0PkegiEMhvcuVsSMKap2BwCbbUhHW6xxDQO+d/e5Ngb4oACk0/OsykdZMZzvm93L
         UCFI09dP3SuLOPlv0rwdFIBTwYdbZg+MjHa1H9aQEPYb4jkgQXZMOTfHn/WY9NUYFjYc
         9JNXcMZSU3f7yvGFpx7rc4CA3gwyzwQzax1qdNfiC4mIUaGSTUdfTSRzYJdlsgamEwww
         kJOzvcG48lhN6VDRrQn/VlaYA6mD6WxrdD+p/lmognnENtVfHlABsbmY+FEUeQeS4EJa
         Bdlw==
X-Gm-Message-State: APjAAAV4mNRHXiIWj+ggwsvBRV/GGLRtZOZ7udapvz4B7/glObgX3iU8
        8HhP40waTYl44PB1r565jBDIyORq
X-Google-Smtp-Source: APXvYqxeq6G5brIinercSHXAhFJUoxVUN24qlvsibi4gg8PFx/x7gkx2cC8UfUUdKBv5VaVcbpCS5g==
X-Received: by 2002:aa7:9341:: with SMTP id 1mr32960375pfn.202.1568080041734;
        Mon, 09 Sep 2019 18:47:21 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id o35sm13491699pgm.29.2019.09.09.18.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:47:21 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC bindings
Date:   Mon,  9 Sep 2019 20:47:18 -0500
Message-Id: <20190910014718.5832-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910014647.5782-1-jassisinghbrar@gmail.com>
References: <20190910014647.5782-1-jassisinghbrar@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Document the devicetree bindings for Socionext Milbeaut HDMAC
controller. Controller has upto 8 floating channels, that need
a predefined slave-id to work from a set of slaves.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt

diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
new file mode 100644
index 000000000000..1f0875bd5abc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
@@ -0,0 +1,32 @@
+* Milbeaut AHB DMA Controller
+
+Milbeaut AHB DMA controller has transfer capability below.
+ - device to memory transfer
+ - memory to device transfer
+
+Required property:
+- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
+- reg:              Should contain DMA registers location and length.
+- interrupts:       Should contain all of the per-channel DMA interrupts.
+                     Number of channels is configurable - 2, 4 or 8, so
+                     the number of interrupts specified should be {2,4,8}.
+- #dma-cells:       Should be 1. Specify the ID of the slave.
+- clocks:           Phandle to the clock used by the HDMAC module.
+
+
+Example:
+
+	hdmac1: dma-controller@1e110000 {
+		compatible = "socionext,milbeaut-m10v-hdmac";
+		reg = <0x1e110000 0x10000>;
+		interrupts = <0 132 4>,
+			     <0 133 4>,
+			     <0 134 4>,
+			     <0 135 4>,
+			     <0 136 4>,
+			     <0 137 4>,
+			     <0 138 4>,
+			     <0 139 4>;
+		#dma-cells = <1>;
+		clocks = <&dummy_clk>;
+	};
-- 
2.17.1

