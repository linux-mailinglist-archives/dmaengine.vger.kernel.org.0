Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319F345DD48
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356106AbhKYP0T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhKYPYS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 10:24:18 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D74C06175D
        for <dmaengine@vger.kernel.org>; Thu, 25 Nov 2021 07:19:27 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1511:ffa3:275:45dd])
        by baptiste.telenet-ops.be with bizsmtp
        id NfKQ2600H5CGg7701fKQWd; Thu, 25 Nov 2021 16:19:25 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGWy-000DJx-6C; Thu, 25 Nov 2021 16:19:24 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqGWx-000gGr-Kt; Thu, 25 Nov 2021 16:19:23 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heng Sia <jee.heng.sia@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Group tuples in snps properties
Date:   Thu, 25 Nov 2021 16:19:18 +0100
Message-Id: <20211125151918.162446-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To improve human readability and enable automatic validation, the tuples
in "snps,block-size" and "snps,priority" properties should be grouped
using angle brackets.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 79e241498e2532ce..90d9274e5464e396 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -120,7 +120,7 @@ examples:
          dma-channels = <4>;
          snps,dma-masters = <2>;
          snps,data-width = <3>;
-         snps,block-size = <4096 4096 4096 4096>;
-         snps,priority = <0 1 2 3>;
+         snps,block-size = <4096>, <4096>, <4096>, <4096>;
+         snps,priority = <0>, <1>, <2>, <3>;
          snps,axi-max-burst-len = <16>;
      };
-- 
2.25.1

