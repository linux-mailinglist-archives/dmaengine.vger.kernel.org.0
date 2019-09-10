Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF37DAE967
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfIJLpm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:45:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41574 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731389AbfIJLpl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:45:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABjZYh130303;
        Tue, 10 Sep 2019 06:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568115935;
        bh=oj1t9aK27h7kYmeJtRxpc+tY35M83uRPBJm+zMEvkzs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xhY4es2sP9GJEKK2AZdZWSswZpwAbOEtHXfbgHYhxJTNGP+2JYkfypnvXd0Fq/84S
         NOyG7vS/LyLrz0oGoYMz6GoiMzxP2JK70ozW3zwkGKjlrswpv7d/W6WcGSy3UnDagR
         Q9X0OxRLBe+coZNZwDjIn2meeg4r5im5Dcuf24Uo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8ABjZNr005985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 06:45:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:45:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:45:32 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABjRpJ119821;
        Tue, 10 Sep 2019 06:45:30 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: dma-common: Change dma-channel-mask to uint32-array
Date:   Tue, 10 Sep 2019 14:45:57 +0300
Message-ID: <20190910114559.22810-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910114559.22810-1-peter.ujfalusi@ti.com>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make the dma-channel-mask to be usable for controllers with more than 32
channels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/dma-common.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
index ed0a49a6f020..41460946be64 100644
--- a/Documentation/devicetree/bindings/dma/dma-common.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
@@ -25,11 +25,19 @@ properties:
       Used to provide DMA controller specific information.
 
   dma-channel-mask:
-    $ref: /schemas/types.yaml#definitions/uint32
     description:
       Bitmask of available DMA channels in ascending order that are
       not reserved by firmware and are available to the
       kernel. i.e. first channel corresponds to LSB.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          minItems = 1
+          maxItems = 255 # Should be enough
+          - description: Mask of channels 0-31
+          - description: Mask of channels 32-63
+          ...
+          - description: Mask of chnanels X-(X+31)
 
   dma-channels:
     $ref: /schemas/types.yaml#definitions/uint32
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

