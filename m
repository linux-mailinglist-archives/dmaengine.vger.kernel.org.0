Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE77C200F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2019 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfI3Lk1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Sep 2019 07:40:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44456 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfI3Lk0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Sep 2019 07:40:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UBeDoU012241;
        Mon, 30 Sep 2019 06:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569843613;
        bh=DVgmIFbDsMxJJSm/SVGd9TdiqZgDPzIcalnycvRo6aY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ADXMXkBUhZuNGUROhkNLF963ciFJGhEV15nNiPoGS2qMGYly/kql68nTvB9V/upTu
         1yNn9nxB8G+TXtFWkYzP9RTkt9Yjd0ZvkeeOfUoTDDaZ+3HxKucKu7qadD3Dc2dPFd
         H2d4csLnxMoxN6cnxBLbaEfadV8PMKlmwz35nZ/4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UBeDSQ023753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 06:40:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 06:40:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 06:40:03 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UBe8Xp096764;
        Mon, 30 Sep 2019 06:40:11 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: dmaengine: dma-common: Change dma-channel-mask to uint32-array
Date:   Mon, 30 Sep 2019 14:40:53 +0300
Message-ID: <20190930114055.29315-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930114055.29315-1-peter.ujfalusi@ti.com>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
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
 Documentation/devicetree/bindings/dma/dma-common.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
index ed0a49a6f020..02a34ba2b49b 100644
--- a/Documentation/devicetree/bindings/dma/dma-common.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
@@ -25,11 +25,18 @@ properties:
       Used to provide DMA controller specific information.
 
   dma-channel-mask:
-    $ref: /schemas/types.yaml#definitions/uint32
     description:
       Bitmask of available DMA channels in ascending order that are
       not reserved by firmware and are available to the
       kernel. i.e. first channel corresponds to LSB.
+      The first item in the array is for channels 0-31, the second is for
+      channels 32-63, etc.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      minItems: 1
+      # Should be enough
+      maxItems: 255
 
   dma-channels:
     $ref: /schemas/types.yaml#definitions/uint32
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

