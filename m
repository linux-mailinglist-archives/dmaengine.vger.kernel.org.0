Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F75AE964
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfIJLpk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:45:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60760 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbfIJLpj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:45:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABja1F081894;
        Tue, 10 Sep 2019 06:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568115936;
        bh=ng9Cs8sOz+sU2Y/eAwCWJ2zVQwHbGtllOEtnh+KMP8E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hl4soldCIUdr7LpYsNjwiTN44fRJxaGS0iPeQ8WWfppgPrV8LBU8zrp17Ay0OUof4
         ftfMBmaBuO6xXEqeSZn1wbC7N/zcz5HcSW6GTa4bB1whaeCeB+TxTc4vBt2vwl7sip
         2412jhCm8O2hvVMlRaoRJ4DF6cHUZksjHpi60GOk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8ABjaRC088283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 06:45:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:45:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:45:34 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABjRpK119821;
        Tue, 10 Sep 2019 06:45:32 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
Date:   Tue, 10 Sep 2019 14:45:58 +0300
Message-ID: <20190910114559.22810-3-peter.ujfalusi@ti.com>
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

Similarly to paRAM slots, channels can be used by other cores.

The common dma-channel-mask property can be used for specifying the
available channels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 4bbc94d829c8..3c7736246354 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -42,6 +42,9 @@ Optional properties:
 - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
 		the driver, they are allocated to be used by for example the
 		DSP. See example.
+- dma-channel-mask: Mask of usable channels, see
+		Documentation/devicetree/bindings/dma/dma-common.yaml
+
 
 ------------------------------------------------------------------------------
 eDMA3 Transfer Controller
@@ -91,6 +94,9 @@ edma: edma@49000000 {
 	ti,edma-memcpy-channels = <20 21>;
 	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
 	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
+	/* The following channels are reserved: 35-44 */
+	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
+			   <0xffffe007>; /* Channel 32-63 */
 };
 
 edma_tptc0: tptc@49800000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

