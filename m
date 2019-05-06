Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70510149D6
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFMgA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:36:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54272 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMgA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:36:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CZNDa059224;
        Mon, 6 May 2019 07:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146123;
        bh=E/RDTiGfkvfUatsiHKhpgwopQi5Kz6u+zKIcoE9UgMY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tpqciy604lId4D1+IcqarpqN0RMg17+qKFHZNtuMpvOtthACi+EhZRQP8IvF2UFN0
         ZOxQPY54FG9tlrJo59ATmB3+kazsdoaQhXzXCrOiyr00E1tbMzw0unQmILpqy+77iF
         f/25SktFH9L6vNguhDNXn5XI/MovU38SBbWjsUOE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CZN0K129509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:35:23 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:35:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:35:22 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpUF110286;
        Mon, 6 May 2019 07:35:19 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 09/16] dt-bindings: dma: ti: Add document for K3 UDMA
Date:   Mon, 6 May 2019 15:34:49 +0300
Message-ID: <20190506123456.6777-10-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506123456.6777-1-peter.ujfalusi@ti.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
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

UDMA-P is introduced as part of the K3 architecture and can be found on
AM65x SoC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.txt    | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
new file mode 100644
index 000000000000..b221a5ea119c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
@@ -0,0 +1,134 @@
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
+Required properties:
+--------------------
+- compatible:		Should be
+			"ti,am654-navss-main-udmap" for am654 main NAVSS UDMAP
+			"ti,am654-navss-mcu-udmap" for am654 mcu NAVSS UDMAP
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
+ti,psil-configX naming convention, where X is the thread ID offset.
+
+Configuration node Required properties:
+--------------------
+- linux,udma-mode:	Channel mode, can be:
+			- UDMA_PKT_MODE: for Packet mode channels (peripherals)
+			- UDMA_TR_MODE: for Third-Party mode
+
+Configuration node Optional properties:
+--------------------
+- statictr-type:	In case the remote endpoint requires StaticTR
+			configuration:
+			- PSIL_STATIC_TR_XY: XY type of StaticTR
+			- PSIL_STATIC_TR_MCAN: MCAN type of StaticTR
+- ti,channel-tpl:	Channel Throughput level:
+			0 / or not present - normal channel
+			1 - High Throughput channel
+- ti,needs-epib:	If the endpoint require EPIB to be present in the
+			descriptor.
+- ti,psd-size:		Size of the Protocol Specific Data section of the
+			descriptor.
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
+	main_udmap: udmap@31150000 {
+		compatible = "ti,am654-navss-main-udmap";
+		reg =	<0x0 0x31150000 0x0 0x100>,
+			<0x0 0x34000000 0x0 0x100000>,
+			<0x0 0x35000000 0x0 0x100000>;
+		reg-names = "gcfg", "rchanrt", "tchanrt";
+		#dma-cells = <3>;
+
+		ti,ringacc = <&ringacc>;
+		ti,psil-base = <0x1000>;
+
+		interrupt-parent = <&main_udmass_inta>;
+
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <188>;
+
+		ti,sci-rm-range-tchan = <0x6 0x1>, /* TX_HCHAN */
+					<0x6 0x2>; /* TX_CHAN */
+		ti,sci-rm-range-rchan = <0x6 0x4>, /* RX_HCHAN */
+					<0x6 0x5>; /* RX_CHAN */
+		ti,sci-rm-range-rflow = <0x6 0x6>; /* GP RFLOW */
+	};
+};
+
+pdma0: pdma@2a41000 {
+	compatible = "ti,am654-pdma";
+	reg = <0x0 0x02A41000 0x0 0x400>;
+	reg-names = "eccaggr_cfg";
+
+	ti,psil-base = <0x4400>;
+
+	/* ti,psil-config0-2 */
+	UDMA_PDMA_TR_XY(0);
+	UDMA_PDMA_TR_XY(1);
+	UDMA_PDMA_TR_XY(2);
+};
+
+mcasp0: mcasp@02B00000 {
+...
+	/* tx: pdma0-0, rx: pdma0-0 */
+	dmas = <&main_udmap &pdma0 0 UDMA_DIR_TX>,
+	       <&main_udmap &pdma0 0 UDMA_DIR_RX>;
+	dma-names = "tx", "rx";
+...
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

