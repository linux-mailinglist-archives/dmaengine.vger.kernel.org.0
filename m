Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7325D6DDC
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 05:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJODdy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 23:33:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34364 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJODdy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 23:33:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so3888069pgi.1;
        Mon, 14 Oct 2019 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VxMaYUDhGvjPs63iaiTixHwZKtvhNFibU+RwYL+rHM=;
        b=Z4lO4m6Re1dwgpnnPRFo9OvicbDWZOSYxWogJk/emHGpsSoUEYHxiGxUJbbOMN6UaP
         VdGN9ZmD85TH/AqGQsglQ0ZNweFX4JBYPj3KX/K6ulRlPhKh3cUhLMpSnrKSoU/AXVJV
         TYFXw7dHiEGk8Tjr32ZyrqqkN/fi6pyncG3gh2tFdKxC50Z4OgGyk5A+eWZ66Vu0OIll
         s4hs4CFTnkMAoXAE4z0aq/HXoXXdqCTxPtQqSszJlI8yqh3L6jHN4+TTVH3W/j6OYuDM
         k6UQQfWW0hqjBu3OTtwqUeuqJ1cqbAQ5gdg5hdw9ehqe55SUeq5dYQ2lEPgzq3TNK9bZ
         M+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VxMaYUDhGvjPs63iaiTixHwZKtvhNFibU+RwYL+rHM=;
        b=It529IhF8xcAQ7KUTJG3ZQK6T9/YUp7QQLIy3nspwSta2KEHEpl8SaC28Bb4uJ00M/
         EuXRbTMQ0NxidzFZPFTvHDF/hRJi84YaCBexPD6R9E5mQUxFeXihA0c8PpPsl6qxjhGK
         szE0itVqMcIBaqLxFLGdlc6jK6ap9Te77TbRR+SRHmLCsYdyYQto3UrnEQn4f0yR5wUU
         jRByaYrohfHfVobBB9lvI8vzIs+Cc9DupE6FqKYlsyKYz9N3LNWF9LjaIhSkTITK8kH1
         JpgbCqoj8qOqpPqAKUTdpn8pgwsn3pOY2C1SQtYh7Wimbme+sPg+3Ah9TTooYkGDqfr4
         NyhA==
X-Gm-Message-State: APjAAAUXHEH0xdA3gdjply7E802uh6R+uF4FNi7Imy4KwG2GV8wtgVlE
        ZOmrn8WZ+quB76+qygxCMVwpXH0A
X-Google-Smtp-Source: APXvYqxtsoJ/AyiSd3vof0hpIpvZoU1QbUoypWrozxiOv65HssNBbwFBeWxazio4PP6++SFv0d+GNw==
X-Received: by 2002:a17:90a:a411:: with SMTP id y17mr40990822pjp.116.1571110433697;
        Mon, 14 Oct 2019 20:33:53 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id 14sm20564794pfn.21.2019.10.14.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:33:53 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC bindings
Date:   Mon, 14 Oct 2019 22:33:50 -0500
Message-Id: <20191015033350.14866-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015033301.14791-1-jassisinghbrar@gmail.com>
References: <20191015033301.14791-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.20.1

