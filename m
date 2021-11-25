Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541D45DD50
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356134AbhKYP0j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhKYPYj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 10:24:39 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44EAC0613DD
        for <dmaengine@vger.kernel.org>; Thu, 25 Nov 2021 07:20:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1511:ffa3:275:45dd])
        by andre.telenet-ops.be with bizsmtp
        id NfLA2600H5CGg7701fLAey; Thu, 25 Nov 2021 16:20:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGXi-000DKG-4j; Thu, 25 Nov 2021 16:20:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGXh-000gIs-Kt; Thu, 25 Nov 2021 16:20:09 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heng Sia <jee.heng.sia@intel.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Document optional reset
Date:   Thu, 25 Nov 2021 16:20:08 +0100
Message-Id: <20211125152008.162571-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"make dtbs_check":

    Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
    arch/riscv/boot/dts/canaan/sipeed_maix_bit.dt.yaml: dma-controller@50000000: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
	    From schema: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml

The Synopsys DesignWare AXI DMA Controller on the Canaan K210 SoC
exposes its reset signal.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 90d9274e5464e396..06ddffaada295171 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -53,6 +53,9 @@ properties:
     minimum: 1
     maximum: 8
 
+  resets:
+    maxItems: 1
+
   snps,dma-masters:
     description: |
       Number of AXI masters supported by the hardware.
-- 
2.25.1

