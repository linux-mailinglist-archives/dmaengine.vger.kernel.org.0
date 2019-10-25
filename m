Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19194E446D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2019 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436714AbfJYHaE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Oct 2019 03:30:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48878 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436703AbfJYHaE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Oct 2019 03:30:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P7TwoV011174;
        Fri, 25 Oct 2019 02:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571988598;
        bh=arZMjFkSUwGW/O88UV38VO+/3czIljIqMYjKH7DkrHA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U0lEHUyhrqMnzuVElsu8rzeZSrYdZtm971/hBuSLwdGIRpVfAuRVUTe33qwl0eRg3
         CY4siQFyPpPGUKYZa0VbC6Re5PF87WPCQxTOGV3RtaKZXNrl7JRq5XkBzxI+h0ln0D
         cypjjoWoo42mHJtbi8IcnVobtlVwA/DPJQUbpBUg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9P7Twk6105539
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Oct 2019 02:29:58 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 02:29:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 02:29:47 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7Tr4G103329;
        Fri, 25 Oct 2019 02:29:55 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: dmaengine: dma-common: Change dma-channel-mask to uint32-array
Date:   Fri, 25 Oct 2019 10:30:54 +0300
Message-ID: <20191025073056.25450-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025073056.25450-1-peter.ujfalusi@ti.com>
References: <20191025073056.25450-1-peter.ujfalusi@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

