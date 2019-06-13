Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86744A7C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 20:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfFMSQ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 14:16:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34342 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 14:16:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so23683103qtu.1;
        Thu, 13 Jun 2019 11:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LZwa4Y9iu5P5LhB+uNK8C/QGl8P96xdRo5tEgClxxCU=;
        b=PxTCfFrCJgknZSJSC7CF0eENgaLUcqsAii8cqlZ6cBcSX1fkYStvnX4OyMUDb+JMML
         bwBB5giFTiCnRDZOFL76hAQ2BTO2qwUJCsbF78KD3xj2TWM/rnW7J401d4UsGcolEf3h
         FgYD090su52kfAS8GX1lU7iGaXirjVrmsTqnnduA1P1a1gFC/3ydlSdgdhAT9CfeZu4S
         DsQGMW5Cooo+uf4oCmtVjwyXYQ2fauzhW9cGQzgVfhv6vJ4lWRwZIfChPOFTEh2Z31XJ
         MKI5b0jnMFWUtYOHW0CqPhFl+SrpmBnDw5piWt6IHVoaw2A7bOzZesP0/upKjfr9VHJr
         ol9g==
X-Gm-Message-State: APjAAAXPZYnI8guXpcmvrkkDewaO5hId1fLkGmKyVmYb3d12wOgE2dDD
        6pt2mnVidYErRtAd7ZQ3sQr7WYQ=
X-Google-Smtp-Source: APXvYqxLRQhvve6GhV2ckkqYyyrf9ojXLqnVwWwrfVDmCAMzo7e/VX6qq+dMhNVsBwi+bfkhUlMPbA==
X-Received: by 2002:a0c:ba97:: with SMTP id x23mr4747453qvf.133.1560449787683;
        Thu, 13 Jun 2019 11:16:27 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id s23sm301502qtj.56.2019.06.13.11.16.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:16:27 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:16:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com
Subject: Re: [PATCH 09/16] dt-bindings: dma: ti: Add document for K3 UDMA
Message-ID: <20190613181626.GA7039@bogus>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-10-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506123456.6777-10-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 06, 2019 at 03:34:49PM +0300, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).
> 
> UDMA-P is introduced as part of the K3 architecture and can be found on
> AM65x SoC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.txt    | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.txt b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
> new file mode 100644
> index 000000000000..b221a5ea119c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.txt
> @@ -0,0 +1,134 @@
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
> +- #dma-cells:		Should be set to <3>.
> +			- The first parameter is a phandle to the remote PSI-L
> +			  endpoint
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
> +ti,psil-configX naming convention, where X is the thread ID offset.

Don't use vendor prefixes on node names.

> +
> +Configuration node Required properties:
> +--------------------
> +- linux,udma-mode:	Channel mode, can be:
> +			- UDMA_PKT_MODE: for Packet mode channels (peripherals)
> +			- UDMA_TR_MODE: for Third-Party mode

This is hardly a common linux thing. What determines the value here.

> +
> +Configuration node Optional properties:
> +--------------------
> +- statictr-type:	In case the remote endpoint requires StaticTR
> +			configuration:
> +			- PSIL_STATIC_TR_XY: XY type of StaticTR
> +			- PSIL_STATIC_TR_MCAN: MCAN type of StaticTR
> +- ti,channel-tpl:	Channel Throughput level:
> +			0 / or not present - normal channel
> +			1 - High Throughput channel
> +- ti,needs-epib:	If the endpoint require EPIB to be present in the
> +			descriptor.
> +- ti,psd-size:		Size of the Protocol Specific Data section of the
> +			descriptor.

You've got a lot of properties and child nodes here, but not in the 
example. Please make the example more complete.

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
> +	main_udmap: udmap@31150000 {

dma-controller@...

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
> +pdma0: pdma@2a41000 {
> +	compatible = "ti,am654-pdma";
> +	reg = <0x0 0x02A41000 0x0 0x400>;
> +	reg-names = "eccaggr_cfg";
> +
> +	ti,psil-base = <0x4400>;
> +
> +	/* ti,psil-config0-2 */
> +	UDMA_PDMA_TR_XY(0);

What is this? Don't abuse defines with stuff like this. Generally only 
defines of single values should be used.

> +	UDMA_PDMA_TR_XY(1);
> +	UDMA_PDMA_TR_XY(2);
> +};
> +
> +mcasp0: mcasp@02B00000 {
> +...
> +	/* tx: pdma0-0, rx: pdma0-0 */
> +	dmas = <&main_udmap &pdma0 0 UDMA_DIR_TX>,
> +	       <&main_udmap &pdma0 0 UDMA_DIR_RX>;
> +	dma-names = "tx", "rx";
> +...
> +};
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
