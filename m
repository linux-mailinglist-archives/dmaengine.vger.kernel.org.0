Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC8C2D3C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2019 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfJAGQz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Oct 2019 02:16:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47960 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732717AbfJAGQy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Oct 2019 02:16:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x916GkWm009371;
        Tue, 1 Oct 2019 01:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569910606;
        bh=Pgjk77igAROFlh+s9KVYoYfiPSmphJHDbtf3r1cTFqA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LVpV9EiLSCRz6kyP8oQa0MpJliySHKFFTPgTswRXLfB9Fk3L8BnHFUZZa3yrzxBNA
         cTlBUFGoCP1y/jaz0p0l9WeFvtbTfmAXWmiT3mcHz4HjCo8WBNw2BYQLP4NBVHJRdH
         LbkVH3QjyHPzToUo5IscHNEebt3cIavKVxK4MaoM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x916GkOY034146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Oct 2019 01:16:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 1 Oct
 2019 01:16:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 1 Oct 2019 01:16:45 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x916GGXC090310;
        Tue, 1 Oct 2019 01:16:42 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v3 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
Date:   Tue, 1 Oct 2019 09:16:57 +0300
Message-ID: <20191001061704.2399-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001061704.2399-1-peter.ujfalusi@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New binding document for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).

UDMA-P is introduced as part of the K3 architecture and can be found in
AM654 and j721e.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.txt    | 185 ++++++++++++++++++
 include/dt-bindings/dma/k3-udma.h             |  10 +
 2 files changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
 create mode 100644 include/dt-bindings/dma/k3-udma.h

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
new file mode 100644
index 000000000000..3a8816ec9ce0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
@@ -0,0 +1,185 @@
+* Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
+
+The UDMA-P is intended to perform similar (but significantly upgraded) functions
+as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
+supports the transmission and reception of various packet types. The UDMA-P is
+architected to facilitate the segmentation and reassembly of SoC DMA data
+structure compliant packets to/from smaller data blocks that are natively
+compatible with the specific requirements of each connected peripheral. Multiple
+Tx and Rx channels are provided within the DMA which allow multiple segmentation
+or reassembly operations to be ongoing. The DMA controller maintains state
+information for each of the channels which allows packet segmentation and
+reassembly operations to be time division multiplexed between channels in order
+to share the underlying DMA hardware. An external DMA scheduler is used to
+control the ordering and rate at which this multiplexing occurs for Transmit
+operations. The ordering and rate of Receive operations is indirectly controlled
+by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
+
+The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
+channels. Channels in the UDMA-P can be configured to be either Packet-Based or
+Third-Party channels on a channel by channel basis.
+
+All transfers within NAVSS is done between PSI-L source and destination threads.
+The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
+legacy, non PSI-L native peripherals. In the later case a special, small PDMA is
+tasked to act as a bridge between the PSI-L fabric and the legacy peripheral.
+
+PDMAs can be configured via UDMAP peer registers to match with the configuration
+of the legacy peripheral.
+
+Required properties:
+--------------------
+- compatible:		Should be
+			"ti,am654-navss-main-udmap" for am654 main NAVSS UDMAP
+			"ti,am654-navss-mcu-udmap" for am654 mcu NAVSS UDMAP
+			"ti,j721e-navss-main-udmap" for j721e main NAVSS UDMAP
+			"ti,j721e-navss-mcu-udmap" for j721e mcu NAVSS UDMAP
+- #dma-cells:		Should be set to <3>.
+			- The first parameter is a phandle to the remote PSI-L
+			  endpoint
+			- The second parameter is the thread offset within the
+			  remote thread ID range
+			- The third parameter is the channel direction.
+- reg:			Memory map of UDMAP
+- reg-names:		"gcfg", "rchanrt", "tchanrt"
+- msi-parent:		phandle for "ti,sci-inta" interrupt controller
+- ti,ringacc:		phandle for the ring accelerator node
+- ti,psil-base:		PSI-L thread ID base of the UDMAP channels
+- ti,sci:		phandle on TI-SCI compatible System controller node
+- ti,sci-dev-id:	TI-SCI device id
+- ti,sci-rm-range-tchan: UDMA tchan resource list in pairs of type and subtype
+- ti,sci-rm-range-rchan: UDMA rchan resource list in pairs of type and subtype
+- ti,sci-rm-range-rflow: UDMA rflow resource list in pairs of type and subtype
+
+For PSI-L thread management the parent NAVSS node must have:
+- ti,sci:		phandle on TI-SCI compatible System controller node
+- ti,sci-dev-id:	TI-SCI device id of the NAVSS instance
+
+Remote PSI-L endpoint
+
+Required properties:
+--------------------
+- ti,psil-base:		PSI-L thread ID base of the endpoint
+
+Within the PSI-L endpoint node thread configuration subnodes must present with:
+psil-configX naming convention, where X is the thread ID offset.
+
+Configuration node Optional properties:
+--------------------
+- ti,pdma-statictr-type:In case the remote endpoint (PDMAs) requires StaticTR
+			configuration:
+			- PSIL_STATIC_TR_XY (1): XY type of StaticTR
+			For endpoints without StaticTR the property is not
+			needed or to be set PSIL_STATIC_TR_NONE (0).
+- ti,pdma-enable-acc32:	Force 32 bit access on peripheral port. Only valid for
+			XY type StaticTR, not supported on am654.
+			Must be enabled for threads servicing McASP with AFIFO
+			bypass mode.
+- ti,pdma-enable-burst:	Enable burst access on peripheral port. Only valid for
+			XY type StaticTR, not supported on am654.
+- ti,channel-tpl:	Channel Throughput level:
+			0 / or not present - normal channel
+			1 - High Throughput channel
+			2 - Ultra High Throughput channel (j721e only)
+- ti,needs-epib:	If the endpoint require EPIB to be present in the
+			descriptor.
+- ti,psd-size:		Size of the Protocol Specific Data section of the
+			descriptor.
+- ti,notdpkt:		The Teardown Completion Message on the thread must be
+			suppressed.
+
+Example:
+
+main_navss: main_navss {
+	compatible = "simple-bus";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	dma-coherent;
+	dma-ranges;
+	ranges;
+
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <118>;
+
+	main_udmap: dma-controller@31150000 {
+		compatible = "ti,j721e-navss-main-udmap";
+		reg =	<0x0 0x31150000 0x0 0x100>,
+			<0x0 0x34000000 0x0 0x100000>,
+			<0x0 0x35000000 0x0 0x100000>;
+		reg-names = "gcfg", "rchanrt", "tchanrt";
+		#dma-cells = <3>;
+
+		ti,ringacc = <&main_ringacc>;
+		ti,psil-base = <0x1000>;
+
+		interrupt-parent = <&main_udmass_inta>;
+
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <212>;
+
+		ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+					<0x0f>, /* TX_HCHAN */
+					<0x10>; /* TX_UHCHAN */
+		ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+					<0x0b>, /* RX_HCHAN */
+					<0x0c>; /* RX_UHCHAN */
+		ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+	};
+};
+
+psilss@340c000 {
+	/* PSILSS1 AASRC */
+	compatible = "ti,j721e-psilss";
+	reg = <0x0 0x0340c000 0x0 0x1000>;
+	reg-names = "config";
+
+	pdma_main_mcasp_g0: pdma_main_mcasp_g0 {
+		/* PDMA6 (PDMA_MCASP_G0) */
+		ti,psil-base = <0x4400>;
+
+		/* psil-config0 */
+		psil-config0 {
+			ti,pdma-statictr-type = <PDMA_STATIC_TR_XY>;
+			ti,pdma-enable-acc32;
+			ti,pdma-enable-burst;
+		};
+	};
+};
+
+mcasp0: mcasp@02B00000 {
+...
+	/* tx: PDMA_MAIN_MCASP_G0-0, rx: PDMA_MAIN_MCASP_G0-0 */
+	dmas = <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_TX>,
+	       <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_RX>;
+	dma-names = "tx", "rx";
+...
+};
+
+crypto: crypto@4E00000 {
+	compatible = "ti,sa2ul-crypto";
+...
+
+	/* tx: crypto_pnp-1, rx: crypto_pnp-1 */
+	dmas = <&main_udmap &crypto 0 UDMA_DIR_TX>,
+	       <&main_udmap &crypto 0 UDMA_DIR_RX>,
+	       <&main_udmap &crypto 1 UDMA_DIR_RX>;
+	dma-names = "tx", "rx1", "rx2";
+...
+	psil-config0 {
+		ti,needs-epib;
+		ti,psd-size = <64>;
+		ti,notdpkt;
+	};
+
+	psil-config1 {
+		ti,needs-epib;
+		ti,psd-size = <64>;
+		ti,notdpkt;
+	};
+
+	psil-config2 {
+		ti,needs-epib;
+		ti,psd-size = <64>;
+		ti,notdpkt;
+	};
+};
diff --git a/include/dt-bindings/dma/k3-udma.h b/include/dt-bindings/dma/k3-udma.h
new file mode 100644
index 000000000000..7479d991a147
--- /dev/null
+++ b/include/dt-bindings/dma/k3-udma.h
@@ -0,0 +1,10 @@
+#ifndef __DT_TI_UDMA_H
+#define __DT_TI_UDMA_H
+
+#define UDMA_DIR_TX		0
+#define UDMA_DIR_RX		1
+
+#define PDMA_STATIC_TR_NONE	0
+#define PDMA_STATIC_TR_XY	1
+
+#endif /* __DT_TI_UDMA_H */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

