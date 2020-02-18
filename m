Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED1162830
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2020 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgBRObb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Feb 2020 09:31:31 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51784 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgBROb2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Feb 2020 09:31:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVNYA025566;
        Tue, 18 Feb 2020 08:31:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582036283;
        bh=afuYAwY1eOQaArGZOvGeyCSYFQzetKyAVrKQfS+rh7s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N1zndXMnb/XjoM3hOcFZOwrm5U7+AbCo0mz6CygTPfXUPkzcxdUEL8CobbkmugGoe
         DlHjAXhr8cNC6576pg2ookHcLOvSLeB3RBs2XkIBTPFr91gVke+9bLFNj3aVNGN3Fh
         bCN40DdYaPdXkMdoCBirI2Y9p9T6+bLORfS7TbW8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01IEVNjx117196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 08:31:23 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 08:31:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 08:31:22 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IEVHXK098737;
        Tue, 18 Feb 2020 08:31:20 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: dma: ti: k3-udma: Update for atype support (virtualization)
Date:   Tue, 18 Feb 2020 16:31:25 +0200
Message-ID: <20200218143126.11361-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218143126.11361-1-peter.ujfalusi@ti.com>
References: <20200218143126.11361-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In UDMA each channel can use different ATYPE value which tells UDMA how
the addresses in the descriptors should be treated:
0: pointers are physical addresses (no translation)
1: pointers are intermediate addresses (PVU)
2: pointers are virtual addresses (SMMU)

When virtualized environment is used then the dma binding should use
additional cell to configure the desired ATYPE for the channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 8b5c346f23f6..567bb820b182 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -45,7 +45,8 @@ allOf:
 
 properties:
   "#dma-cells":
-    const: 1
+    minimum: 1
+    maximum: 2
     description: |
       The cell is the PSI-L  thread ID of the remote (to UDMAP) end.
       Valid ranges for thread ID depends on the data movement direction:
@@ -55,6 +56,8 @@ properties:
       Please refer to the device documentation for the PSI-L thread map and also
       the PSI-L peripheral chapter for the correct thread ID.
 
+      When #dma-cells is 2, the second parameter is the channel ATYPE.
+
   compatible:
     enum:
       - ti,am654-navss-main-udmap
@@ -131,6 +134,20 @@ required:
   - ti,sci-rm-range-rchan
   - ti,sci-rm-range-rflow
 
+if:
+  properties:
+    "#dma-cells":
+      const: 2
+then:
+  properties:
+    ti,udma-atype:
+      description: ATYPE value which should be used by non slave channels
+      allOf:
+        - $ref: /schemas/types.yaml#/definitions/uint32
+
+  required:
+    - ti,udma-atype
+
 examples:
   - |+
     cbass_main {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

