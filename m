Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A589BF114
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfIZLTW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 07:19:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48892 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfIZLTW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Sep 2019 07:19:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJF47022824;
        Thu, 26 Sep 2019 06:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569496755;
        bh=gYeM81ZJ0PDJp9Yxe7eqp+2YLGoUzBTCt62WZh8PCUA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hYR2ZwazZKeQfAknCA8Lfqt6ffg1ZGT3pP2Z9tnZxnrNaEfNm0+cqvulVZv3XnPaM
         DWuuL4AbK1dNRLHHQgmgOznEwKdnmgM1s5iD8iQn7jP8WKZH4opIY1+e4TgPSd8GuP
         kbRgYMcydK3hlQKWFkF6ZyLKq2RGiKSQ8e8Ehii8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBJFX4038351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:19:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:19:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:19:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJAds013885;
        Thu, 26 Sep 2019 06:19:13 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: dmaengine: dma-common: Change dma-channel-mask to uint32-array
Date:   Thu, 26 Sep 2019 14:19:52 +0300
Message-ID: <20190926111954.9184-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926111954.9184-1-peter.ujfalusi@ti.com>
References: <20190926111954.9184-1-peter.ujfalusi@ti.com>
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
index ed0a49a6f020..4527f20301ff 100644
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
+        items:
+          minItems: 1
+          # Should be enough
+          maxItems: 255
 
   dma-channels:
     $ref: /schemas/types.yaml#definitions/uint32
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

