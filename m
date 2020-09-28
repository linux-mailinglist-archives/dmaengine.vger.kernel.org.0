Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DB27B14D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Sep 2020 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1P74 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Sep 2020 11:59:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32903 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1P74 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Sep 2020 11:59:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so1881529oie.0;
        Mon, 28 Sep 2020 08:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDZaQ21Usp87w25mzRYuT8tC9E3ltWzHrXuhQk5quZo=;
        b=h5dL8fJazHsTqNx/FGB2LX92fJaF0nofaWX8aKKjDOItT+TIpXJnlh2L2yW4ljS3ks
         4p370+JcT3MamqrIn5gKkfBE8sdbmaGc7TMrkT6gnzoQTztDx9+/740tjjldpfJ43YXy
         JITDzm5dy9UUoK4hbrVZXMw5Mf7IxSjMNco4Z0r4k95PJAwB92yghhlA4Af3sK+PFpSh
         Ph70Aqdd3OkbzLHrcaukXD3Sy3xaD/UeIef2Lb8/z/oQIz9EF5trulet8ioPAr1xqvb/
         hTJIQqfEUjdVXEO69WrEACtYZmST+17/u5kSR98YWdE4bB2b/fhtkhzg2axb5NcgMTw6
         g/4w==
X-Gm-Message-State: AOAM5339dJcN4tRlu5P55YnabrUyqZLtpq+bhwbFQs/EGqU6O5c7WEJq
        X7CfC3H6XkDvYV6ldFrUnbfNgm/CHos2
X-Google-Smtp-Source: ABdhPJzx+t1SOL3gjMvBl7qVDgfaG2ctw26l0RciW4e4fNOhVNui+5TwEJ9WxZinHySz68G0w5+aZg==
X-Received: by 2002:aca:f203:: with SMTP id q3mr1238105oih.148.1601308794852;
        Mon, 28 Sep 2020 08:59:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u2sm2170497oot.39.2020.09.28.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:59:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        dmaengine@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix 'reg' size issues in zynqmp examples
Date:   Mon, 28 Sep 2020 10:59:53 -0500
Message-Id: <20200928155953.2819930-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The default sizes in examples for 'reg' are 1 cell each. Fix the
incorrect sizes in zynqmp examples:

Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.example.dt.yaml: example-0: dma-controller@fd4c0000:reg:0: [0, 4249616384, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:0: [0, 4249485312, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:1: [0, 4249526272, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:2: [0, 4249530368, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:3: [0, 4249534464, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml          | 8 ++++----
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
index 52a939cade3b..7b9d468c3e52 100644
--- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
+++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
@@ -145,10 +145,10 @@ examples:
 
     display@fd4a0000 {
         compatible = "xlnx,zynqmp-dpsub-1.7";
-        reg = <0x0 0xfd4a0000 0x0 0x1000>,
-              <0x0 0xfd4aa000 0x0 0x1000>,
-              <0x0 0xfd4ab000 0x0 0x1000>,
-              <0x0 0xfd4ac000 0x0 0x1000>;
+        reg = <0xfd4a0000 0x1000>,
+              <0xfd4aa000 0x1000>,
+              <0xfd4ab000 0x1000>,
+              <0xfd4ac000 0x1000>;
         reg-names = "dp", "blend", "av_buf", "aud";
         interrupts = <0 119 4>;
         interrupt-parent = <&gic>;
diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
index 5de510f8c88c..2a595b18ff6c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
@@ -57,7 +57,7 @@ examples:
 
     dma: dma-controller@fd4c0000 {
       compatible = "xlnx,zynqmp-dpdma";
-      reg = <0x0 0xfd4c0000 0x0 0x1000>;
+      reg = <0xfd4c0000 0x1000>;
       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
       interrupt-parent = <&gic>;
       clocks = <&dpdma_clk>;
-- 
2.25.1

