Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF698224
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2019 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfHUR7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Aug 2019 13:59:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36566 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfHUR7J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Aug 2019 13:59:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1so2287064oic.3;
        Wed, 21 Aug 2019 10:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K/th3NArUUDsxYhC0bNRwC8vaVSsABKuuRHPnC96B+s=;
        b=ZQuNCiXwuTceaX7a9G872sey4ZkyACrR2da0wwV2qtzPXwr8n5HPJu/vCmqqxJBaPC
         IP/lqgx0fuMO8WjeHEqN4R+uHwa0/NI161f+8D64xlRiFyt9koWgZilW5fB56I5Zhsax
         0ItVxdahcpUYvrFfvq9m/Q9+bo5w7ByqrHv1pyLaJwB1/JklmZ9cSgE/sdG1W9OKYjVJ
         uAy6YMZ7mrXbp407XDXTXCe7aHtUYrV/p/Z3mYPDfkRUA0dIwRzEMVF0TZXX9a5tYaFf
         NBZjV/XB2MiYUQ+HbPpFNdgTovm/8axTLzNN+/McU7K+1wEpokpRBx2MNpYGqzz5NGht
         s7SA==
X-Gm-Message-State: APjAAAVvcRQewAmkXdAJdiN8RQtPEGZ0OQWw9VfIXBCerBI70aQbv80F
        Po6Y62rdqg8CyvUbP2Yw7Ff3JgU=
X-Google-Smtp-Source: APXvYqxYWHq3juy+XMt1gurNt57qK96nTW0jILgtjvIj6HOsTBk1Wd8+4C/UDmvqsBN8i9a7D1fU9w==
X-Received: by 2002:aca:4a53:: with SMTP id x80mr942404oia.115.1566410347383;
        Wed, 21 Aug 2019 10:59:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm7943096otj.78.2019.08.21.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:59:06 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:59:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v2 07/14] dt-bindings: dma: ti: Add document for K3 UDMA
Message-ID: <20190821175906.GA30618@bogus>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-8-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730093450.12664-8-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 30, 2019 at 12:34:43PM +0300, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
> 
> UDMA-P is introduced as part of the K3 architecture and can be found on
> AM654 and j721e.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.txt    | 170 ++++++++++++++++++
>  include/dt-bindings/dma/k3-udma.h             |  10 ++
>  2 files changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>  create mode 100644 include/dt-bindings/dma/k3-udma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
> new file mode 100644
> index 000000000000..7f30fe583ade
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
> @@ -0,0 +1,170 @@
> +* Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
> +
> +The UDMA-P is intended to perform similar (but significantly upgraded) functions
> +as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
> +supports the transmission and reception of various packet types. The UDMA-P is
> +architected to facilitate the segmentation and reassembly of SoC DMA data
> +structure compliant packets to/from smaller data blocks that are natively
> +compatible with the specific requirements of each connected peripheral. Multiple
> +Tx and Rx channels are provided within the DMA which allow multiple segmentation
> +or reassembly operations to be ongoing. The DMA controller maintains state
> +information for each of the channels which allows packet segmentation and
> +reassembly operations to be time division multiplexed between channels in order
> +to share the underlying DMA hardware. An external DMA scheduler is used to
> +control the ordering and rate at which this multiplexing occurs for Transmit
> +operations. The ordering and rate of Receive operations is indirectly controlled
> +by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
> +
> +The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> +channels. Channels in the UDMA-P can be configured to be either Packet-Based or
> +Third-Party channels on a channel by channel basis.
> +
> +Required properties:
> +--------------------
> +- compatible:		Should be
> +			"ti,am654-navss-main-udmap" for am654 main NAVSS UDMAP
> +			"ti,am654-navss-mcu-udmap" for am654 mcu NAVSS UDMAP
> +			"ti,j721e-navss-main-udmap" for j721e main NAVSS UDMAP
> +			"ti,j721e-navss-mcu-udmap" for j721e mcu NAVSS UDMAP
> +- #dma-cells:		Should be set to <3>.
> +			- The first parameter is a phandle to the remote PSI-L
> +			  endpoint

This is the phandle of the client? That's weird. More below.

> +			- The second parameter is the thread offset within the
> +			  remote thread ID range
> +			- The third parameter is the channel direction.
> +- reg:			Memory map of UDMAP
> +- reg-names:		"gcfg", "rchanrt", "tchanrt"
> +- msi-parent:		phandle for "ti,sci-inta" interrupt controller
> +- ti,ringacc:		phandle for the ring accelerator node
> +- ti,psil-base:		PSI-L thread ID base of the UDMAP channels
> +- ti,sci:		phandle on TI-SCI compatible System controller node
> +- ti,sci-dev-id:	TI-SCI device id
> +- ti,sci-rm-range-tchan: UDMA tchan resource list in pairs of type and subtype
> +- ti,sci-rm-range-rchan: UDMA rchan resource list in pairs of type and subtype
> +- ti,sci-rm-range-rflow: UDMA rflow resource list in pairs of type and subtype
> +
> +For PSI-L thread management the parent NAVSS node must have:
> +- ti,sci:		phandle on TI-SCI compatible System controller node
> +- ti,sci-dev-id:	TI-SCI device id of the NAVSS instance
> +
> +Remote PSI-L endpoint
> +
> +Required properties:
> +--------------------
> +- ti,psil-base:		PSI-L thread ID base of the endpoint
> +
> +Within the PSI-L endpoint node thread configuration subnodes must present with:
> +psil-configX naming convention, where X is the thread ID offset.
> +
> +Configuration node Optional properties:
> +--------------------
> +- pdma,statictr-type:	In case the remote endpoint (PDMAs) requires StaticTR

Property names are in the form [<vendor>,]prop-name. pdma is not a 
vendor.

> +			configuration:
> +			- PSIL_STATIC_TR_XY (1): XY type of StaticTR
> +			For endpoints without StaticTR the property is not
> +			needed or to be set PSIL_STATIC_TR_NONE (0).
> +- pdma,enable-acc32:	Force 32 bit access on peripheral port. Only valid for
> +			XY type StaticTR, not supported on am654.
> +			Must be enabled for threads servicing McASP with AFIFO
> +			bypass mode.
> +- pdma,enable-burst:	Enable burst access on peripheral port. Only valid for
> +			XY type StaticTR, not supported on am654.
> +- ti,channel-tpl:	Channel Throughput level:
> +			0 / or not present - normal channel
> +			1 - High Throughput channel
> +			2 - Ultra High Throughput channel (j721e only)
> +- ti,needs-epib:	If the endpoint require EPIB to be present in the
> +			descriptor.
> +- ti,psd-size:		Size of the Protocol Specific Data section of the
> +			descriptor.
> +
> +Example:
> +
> +main_navss: main_navss {
> +	compatible = "simple-bus";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	dma-coherent;
> +	dma-ranges;
> +	ranges;
> +
> +	ti,sci = <&dmsc>;
> +	ti,sci-dev-id = <118>;
> +
> +	main_udmap: dma-controller@31150000 {
> +		compatible = "ti,am654-navss-main-udmap";
> +		reg =	<0x0 0x31150000 0x0 0x100>,
> +			<0x0 0x34000000 0x0 0x100000>,
> +			<0x0 0x35000000 0x0 0x100000>;
> +		reg-names = "gcfg", "rchanrt", "tchanrt";
> +		#dma-cells = <3>;
> +
> +		ti,ringacc = <&ringacc>;
> +		ti,psil-base = <0x1000>;
> +
> +		interrupt-parent = <&main_udmass_inta>;
> +
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <188>;
> +
> +		ti,sci-rm-range-tchan = <0x6 0x1>, /* TX_HCHAN */
> +					<0x6 0x2>; /* TX_CHAN */
> +		ti,sci-rm-range-rchan = <0x6 0x4>, /* RX_HCHAN */
> +					<0x6 0x5>; /* RX_CHAN */
> +		ti,sci-rm-range-rflow = <0x6 0x6>; /* GP RFLOW */
> +	};
> +};
> +
> +psilss@340c000 {
> +	/* PSILSS1 AASRC */
> +	compatible = "ti,j721e-psilss";
> +	reg = <0x0 0x0340c000 0x0 0x1000>;
> +	reg-names = "config";
> +
> +	pdma_main_mcasp_g0: pdma_main_mcasp_g0 {
> +		/* PDMA6 (PDMA_MCASP_G0) */
> +		ti,psil-base = <0x4400>;
> +
> +		/* psil-config0 */
> +		psil-config0 {
> +			pdma,statictr-type = <PSIL_STATIC_TR_XY>;
> +			pdma,enable-acc32;
> +			pdma,enable-burst;
> +		};
> +	};
> +};
> +
> +mcasp0: mcasp@02B00000 {

I don't really follow what psilss and mcasp are...

> +...
> +	/* tx: PDMA_MAIN_MCASP_G0-0, rx: PDMA_MAIN_MCASP_G0-0 */
> +	dmas = <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_TX>,
> +	       <&main_udmap &pdma_main_mcasp_g0 0 UDMA_DIR_RX>;
> +	dma-names = "tx", "rx";
> +...
> +};
> +
> +crypto: crypto@4E00000 {
> +	compatible = "ti,sa2ul-crypto";
> +...
> +
> +	/* tx: crypto_pnp-1, rx: crypto_pnp-1 */
> +	dmas = <&main_udmap &crypto 0 UDMA_DIR_TX>,
> +	       <&main_udmap &crypto 0 UDMA_DIR_RX>,
> +	       <&main_udmap &crypto 1 UDMA_DIR_RX>;

'thread offset' is 1?

> +	dma-names = "tx", "rx1", "rx2";
> +...
> +	psil-config0 {

Are these nodes 1-1 with the 'dmas' entries? I think these flags should 
all be DMA cells. They are all configuration of DMA channels, right?

Though I'm not sure about how that would work for the previous example.

> +		ti,needs-epib;
> +		ti,psd-size = <64>;
> +	};
> +
> +	psil-config1 {
> +		ti,needs-epib;
> +		ti,psd-size = <64>;
> +	};
> +
> +	psil-config2 {
> +		ti,needs-epib;
> +		ti,psd-size = <64>;
> +	};
> +};
> diff --git a/include/dt-bindings/dma/k3-udma.h b/include/dt-bindings/dma/k3-udma.h
> new file mode 100644
> index 000000000000..f5c8f5d50491
> --- /dev/null
> +++ b/include/dt-bindings/dma/k3-udma.h
> @@ -0,0 +1,10 @@
> +#ifndef __DT_TI_UDMA_H
> +#define __DT_TI_UDMA_H
> +
> +#define UDMA_DIR_TX		0
> +#define UDMA_DIR_RX		1
> +
> +#define PSIL_STATIC_TR_NONE	0
> +#define PSIL_STATIC_TR_XY	1
> +
> +#endif /* __DT_TI_UDMA_H */
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
