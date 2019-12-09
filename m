Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA21169CD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 10:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLIJnq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 04:43:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57532 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfLIJnq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Dec 2019 04:43:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99hXdF108483;
        Mon, 9 Dec 2019 03:43:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575884613;
        bh=EeH349x8o4SCZvve2w+07qwX2Rkls7hx3AcZBuQt9LU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i/qVOQTJIAsoaARBL5UroZbTfhCSVJJZrN4H14yPyCXIXhnSuArTQjtq+Z/hvAt1h
         m0FlKTSDCR+4P4DO19Mq6YMht4RC/Mf1stY1y5NHawuzqNbsMekWxHYsn6Vcbai+bv
         XEhaiAdFhHipmRIL4hoir2pZDmNdWAcHSA0ntOC4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99hXD7041416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:43:33 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:43:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:43:32 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99hOWi080263;
        Mon, 9 Dec 2019 03:43:29 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH v7 01/12] bindings: soc: ti: add documentation for k3 ringacc
Date:   Mon, 9 Dec 2019 11:43:21 +0200
Message-ID: <20191209094332.4047-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209094332.4047-1-peter.ujfalusi@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
enable straightforward passing of work between a producer and a consumer.
There is one RINGACC module per NAVSS on TI AM65x and j721e.

This patch introduces RINGACC device tree bindings.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/ti/k3-ringacc.txt | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
new file mode 100644
index 000000000000..59758ccce809
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
@@ -0,0 +1,59 @@
+* Texas Instruments K3 NavigatorSS Ring Accelerator
+
+The Ring Accelerator (RA) is a machine which converts read/write accesses
+from/to a constant address into corresponding read/write accesses from/to a
+circular data structure in memory. The RA eliminates the need for each DMA
+controller which needs to access ring elements from having to know the current
+state of the ring (base address, current offset). The DMA controller
+performs a read or write access to a specific address range (which maps to the
+source interface on the RA) and the RA replaces the address for the transaction
+with a new address which corresponds to the head or tail element of the ring
+(head for reads, tail for writes).
+
+The Ring Accelerator is a hardware module that is responsible for accelerating
+management of the packet queues. The K3 SoCs can have more than one RA instances
+
+Required properties:
+- compatible	: Must be "ti,am654-navss-ringacc";
+- reg		: Should contain register location and length of the following
+		  named register regions.
+- reg-names	: should be
+		  "rt" - The RA Ring Real-time Control/Status Registers
+		  "fifos" - The RA Queues Registers
+		  "proxy_gcfg" - The RA Proxy Global Config Registers
+		  "proxy_target" - The RA Proxy Datapath Registers
+- ti,num-rings	: Number of rings supported by RA
+- ti,sci-rm-range-gp-rings : TI-SCI RM subtype for GP ring range
+- ti,sci	: phandle on TI-SCI compatible System controller node
+- ti,sci-dev-id	: TI-SCI device id of the ring accelerator
+- msi-parent	: phandle for "ti,sci-inta" interrupt controller
+
+Optional properties:
+ -- ti,dma-ring-reset-quirk : enable ringacc / udma ring state interoperability
+		  issue software w/a
+
+Example:
+
+ringacc: ringacc@3c000000 {
+	compatible = "ti,am654-navss-ringacc";
+	reg =	<0x0 0x3c000000 0x0 0x400000>,
+		<0x0 0x38000000 0x0 0x400000>,
+		<0x0 0x31120000 0x0 0x100>,
+		<0x0 0x33000000 0x0 0x40000>;
+	reg-names = "rt", "fifos",
+		    "proxy_gcfg", "proxy_target";
+	ti,num-rings = <818>;
+	ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+	ti,dma-ring-reset-quirk;
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <187>;
+	msi-parent = <&inta_main_udmass>;
+};
+
+client:
+
+dma_ipx: dma_ipx@<addr> {
+	...
+	ti,ringacc = <&ringacc>;
+	...
+}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

