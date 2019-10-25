Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09EE4472
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2019 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436973AbfJYHaP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Oct 2019 03:30:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41786 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393149AbfJYHaD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Oct 2019 03:30:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P7U13n083504;
        Fri, 25 Oct 2019 02:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571988601;
        bh=3qESwgK0U+EAwQQL6PAX7MJ+aaVlzVEC8XOoAoFnNlo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cAifdiSWMeUuttErMKa1KjLN/dVC0GXLvGV0SibL6sYDkZhMthGoSNTZk8WiXyNNk
         tUVDT8vDYnmfxXo2cQUxAYUEwWxggineOtpvg0CSQ3sOXUO2yhN43t9LW5kEs4tEMC
         VVA1pPos/fQ/T2V9kF354Md43jR/RxiB2+7Qpeu0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7U0h9070088;
        Fri, 25 Oct 2019 02:30:00 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 02:29:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 02:29:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7Tr4H103329;
        Fri, 25 Oct 2019 02:29:58 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
Date:   Fri, 25 Oct 2019 10:30:55 +0300
Message-ID: <20191025073056.25450-3-peter.ujfalusi@ti.com>
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

Similarly to paRAM slots, channels can be used by other cores.

The common dma-channel-mask property can be used for specifying the
available channels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 4bbc94d829c8..0e1398f93aa2 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -42,6 +42,11 @@ Optional properties:
 - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
 		the driver, they are allocated to be used by for example the
 		DSP. See example.
+- dma-channel-mask: Mask of usable channels.
+		Single uint32 for EDMA with 32 channels, array of two uint32 for
+		EDMA with 64 channels. See example and
+		Documentation/devicetree/bindings/dma/dma-common.yaml
+
 
 ------------------------------------------------------------------------------
 eDMA3 Transfer Controller
@@ -91,6 +96,9 @@ edma: edma@49000000 {
 	ti,edma-memcpy-channels = <20 21>;
 	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
 	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
+	/* The following channels are reserved: 35-44 */
+	dma-channel-mask = <0xffffffff /* Channel 0-31 */
+			    0xffffe007>; /* Channel 32-63 */
 };
 
 edma_tptc0: tptc@49800000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

