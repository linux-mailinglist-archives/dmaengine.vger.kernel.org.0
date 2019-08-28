Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF69FAB2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1GlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 02:41:19 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:28892 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbfH1GlT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 02:41:19 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559487600"; 
   d="scan'208";a="25123611"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Aug 2019 15:41:17 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A2D141CA206;
        Wed, 28 Aug 2019 15:41:17 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: dmaengine: dma-common: Revise the dma-channel-mask property
Date:   Wed, 28 Aug 2019 15:39:35 +0900
Message-Id: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The commit b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas
for the generic DMA bindings") changed the property from
dma-channel-mask to dma-channel-masks. So, this patch revises it.

Fixes: b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas for the generic DMA bindings")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/dma/dma-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
index 0141af0..ed0a49a 100644
--- a/Documentation/devicetree/bindings/dma/dma-common.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
@@ -24,7 +24,7 @@ properties:
     description:
       Used to provide DMA controller specific information.
 
-  dma-channel-masks:
+  dma-channel-mask:
     $ref: /schemas/types.yaml#definitions/uint32
     description:
       Bitmask of available DMA channels in ascending order that are
-- 
2.7.4

