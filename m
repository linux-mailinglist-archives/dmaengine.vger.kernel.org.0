Return-Path: <dmaengine+bounces-9011-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFfNNnaenGmyJgQAu9opvQ
	(envelope-from <dmaengine+bounces-9011-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 19:37:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE317B994
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070043141284
	for <lists+dmaengine@lfdr.de>; Mon, 23 Feb 2026 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C0366DCD;
	Mon, 23 Feb 2026 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFCg5ok3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58893612D6;
	Mon, 23 Feb 2026 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871605; cv=none; b=UloVms3he3dFnHzsmWsHGWuQbgasiuiSf53XVGc5GYqFj2x9yvq7QNDbvY3NTGATEjcc1avGALfaFWVB/qJELVj13ovIzEKBu78xx+Kso1a99C80KaweYEekqkP3FV2WvF0dgE9e6rgJwnq4KO3janeyNnnLextEz0hZ62LtnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871605; c=relaxed/simple;
	bh=M3iI/MJ+BGFtm/5M6IZ4SD9nkAAgr25XUBkmytw5IAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqTUbxg0OLNyKMLjWbMYi8VJV2k5l5cP1uGE1H0JOpHXwvt5abVm81ICblR5Cjgx4Ch/vwchN5vAi7X2sGHKH59SW5bjpDrJBEt3g9NQyBDstowOIRt1wgLuuSc19f++Ae4xwrZKZf8FEfZ0WhhmwsLgkWCYnV1a8WyLqWNTpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFCg5ok3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE29C116C6;
	Mon, 23 Feb 2026 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771871605;
	bh=M3iI/MJ+BGFtm/5M6IZ4SD9nkAAgr25XUBkmytw5IAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFCg5ok3pbt/XSzLXlSb0jfDVMo72gaFVYoAKMiMWBPH1kk21yfD5ELCJtNM5Q+CE
	 48jwe/H1hHIL+jLOJ1sspoY92hyjrlP7gTIiYYb6vSzXWUW6QMQJ/91WGfnyU4cp+1
	 n1lhgEG2cLaeXVOfD3VbdEt5zZ+x/Owx85qj/Vi04S/dKn/ts+Hh09lIgxc1D6bxJ6
	 KDEV+TxOUe6RYvyTbHst1ge2dZG7iP41PclNrgsZGyUgudA64OlWSv8nllv1P1blev
	 a6T9aOTtzg29hH4MnOqojR/IU5kWBaPWeIIcLhvcdB03SgOlfnOiW9h5f1OaiF9xTl
	 692s+rirqgBhQ==
Date: Mon, 23 Feb 2026 12:33:24 -0600
From: Rob Herring <robh@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: vkoul@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	michal.simek@amd.com, radhey.shyam.pandey@amd.com, git@amd.com,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: xlnx,axi-dma: Convert bindings
 into yaml
Message-ID: <20260223183324.GA118767-robh@kernel.org>
References: <20260219152621.2375256-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219152621.2375256-1-abin.joseph@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9011-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[2.98.207.78:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,2.98.207.48:email]
X-Rspamd-Queue-Id: 40BE317B994
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 08:56:21PM +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA from txt to yaml.
> No changes to existing binding description.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>  .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
>  .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 290 ++++++++++++++++++
>  2 files changed, 290 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> deleted file mode 100644
> index b567107270cb..000000000000
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -Xilinx AXI VDMA engine, it does transfers between memory and video devices.
> -It can be configured to have one channel or two channels. If configured
> -as two channels, one is to transmit to the video device and another is
> -to receive from the video device.
> -
> -Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
> -target devices. It can be configured to have one channel or two channels.
> -If configured as two channels, one is to transmit to the device and another
> -is to receive from the device.
> -
> -Xilinx AXI CDMA engine, it does transfers between memory-mapped source
> -address and a memory-mapped destination address.
> -
> -Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
> -target devices. It can be configured to have up to 16 independent transmit
> -and receive channels.
> -
> -Required properties:
> -- compatible: Should be one of-
> -		"xlnx,axi-vdma-1.00.a"
> -		"xlnx,axi-dma-1.00.a"
> -		"xlnx,axi-cdma-1.00.a"
> -		"xlnx,axi-mcdma-1.00.a"
> -- #dma-cells: Should be <1>, see "dmas" property below
> -- reg: Should contain VDMA registers location and length.
> -- xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
> -- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
> -- dma-channel child node: Should have at least one channel and can have up to
> -	two channels per device. This node specifies the properties of each
> -	DMA channel (see child node properties below).
> -- clocks: Input clock specifier. Refer to common clock bindings.
> -- clock-names: List of input clocks
> -	For VDMA:
> -	Required elements: "s_axi_lite_aclk"
> -	Optional elements: "m_axi_mm2s_aclk" "m_axi_s2mm_aclk",
> -			   "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
> -	For CDMA:
> -	Required elements: "s_axi_lite_aclk", "m_axi_aclk"
> -	For AXIDMA and MCDMA:
> -	Required elements: "s_axi_lite_aclk"
> -	Optional elements: "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
> -			   "m_axi_sg_aclk"
> -
> -Required properties for VDMA:
> -- xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
> -
> -Optional properties for AXI DMA and MCDMA:
> -- xlnx,sg-length-width: Should be set to the width in bits of the length
> -	register as configured in h/w. Takes values {8...26}. If the property
> -	is missing or invalid then the default value 23 is used. This is the
> -	maximum value that is supported by all IP versions.
> -
> -Optional properties for AXI DMA:
> -- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
> -- xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
> -	0-255. Setting this value to zero disables the delay timer interrupt.
> -	1 timeout interval = 125 * clock period of SG clock.
> -Optional properties for VDMA:
> -- xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> -	It takes following values:
> -	{1}, flush both channels
> -	{2}, flush mm2s channel
> -	{3}, flush s2mm channel
> -
> -Required child node properties:
> -- compatible:
> -	For VDMA: It should be either "xlnx,axi-vdma-mm2s-channel" or
> -	"xlnx,axi-vdma-s2mm-channel".
> -	For CDMA: It should be "xlnx,axi-cdma-channel".
> -	For AXIDMA and MCDMA: It should be either "xlnx,axi-dma-mm2s-channel"
> -	or "xlnx,axi-dma-s2mm-channel".
> -- interrupts: Should contain per channel VDMA interrupts.
> -- xlnx,datawidth: Should contain the stream data width, take values
> -	{32,64...1024}.
> -
> -Optional child node properties:
> -- xlnx,include-dre: Tells hardware is configured for Data
> -	Realignment Engine.
> -Optional child node properties for VDMA:
> -- xlnx,genlock-mode: Tells Genlock synchronization is
> -	enabled/disabled in hardware.
> -- xlnx,enable-vert-flip: Tells vertical flip is
> -	enabled/disabled in hardware(S2MM path).
> -Optional child node properties for MCDMA:
> -- dma-channels: Number of dma channels in child node.
> -
> -Example:
> -++++++++
> -
> -axi_vdma_0: axivdma@40030000 {
> -	compatible = "xlnx,axi-vdma-1.00.a";
> -	#dma_cells = <1>;
> -	reg = < 0x40030000 0x10000 >;
> -	dma-ranges = <0x00000000 0x00000000 0x40000000>;
> -	xlnx,num-fstores = <0x8>;
> -	xlnx,flush-fsync = <0x1>;
> -	xlnx,addrwidth = <0x20>;
> -	clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
> -	clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
> -		      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
> -	dma-channel@40030000 {
> -		compatible = "xlnx,axi-vdma-mm2s-channel";
> -		interrupts = < 0 54 4 >;
> -		xlnx,datawidth = <0x40>;
> -	} ;
> -	dma-channel@40030030 {
> -		compatible = "xlnx,axi-vdma-s2mm-channel";
> -		interrupts = < 0 53 4 >;
> -		xlnx,datawidth = <0x40>;
> -	} ;
> -} ;
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> new file mode 100644
> index 000000000000..6a260f9292d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
> @@ -0,0 +1,290 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/xilinx/xlnx,axi-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI VDMA, DMA, CDMA and MCDMA IP
> +
> +maintainers:
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> +  - Abin Joseph <abin.joseph@amd.com>
> +
> +description:

Need '>' to maintain paragraphs.

> +  Xilinx AXI VDMA engine, it does transfers between memory and video devices.
> +  It can be configured to have one channel or two channels. If configured
> +  as two channels, one is to transmit to the video device and another is
> +  to receive from the video device.
> +
> +  Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
> +  target devices. It can be configured to have one channel or two channels.
> +  If configured as two channels, one is to transmit to the device and another
> +  is to receive from the device.
> +
> +  Xilinx AXI CDMA engine, it does transfers between memory-mapped source
> +  address and a memory-mapped destination address.
> +
> +  Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
> +  target devices. It can be configured to have up to 16 independent transmit
> +  and receive channels.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,axi-cdma-1.00.a
> +      - xlnx,axi-dma-1.00.a
> +      - xlnx,axi-mcdma-1.00.a
> +      - xlnx,axi-vdma-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Interrupt lines for the DMA controller. Only used when xlnx,axistream-connected
> +      is present (DMA connected to AXI Stream IP). One interrupt for single channel
> +      (MM2S or S2MM), two interrupts for dual channel configuration.
> +      When child dma-channel nodes are present, interrupts are specified in the
> +      child nodes instead.

Wrap lines at 80 char.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 5
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 5
> +
> +  dma-ranges: true
> +
> +  xlnx,addrwidth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [32, 64]
> +    description: The DMA addressing size in bits.
> +
> +  xlnx,num-fstores:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    description: Should be the number of framebuffers as configured in h/w.
> +
> +  xlnx,flush-fsync:
> +    type: boolean
> +    description: Tells which channel to Flush on Frame sync.
> +
> +  xlnx,sg-length-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 26
> +    default: 23
> +    description:
> +      Should be set to the width in bits of the length register as configured
> +      in h/w. Takes values {8...26}. If the property is missing or invalid then
> +      the default value 23 is used. This is the maximum value that is supported

No need to repeat what the schema defines.

> +      by all IP versions.
> +
> +  xlnx,irq-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +    description:
> +      Tells the interrupt delay timeout value. Valid range is from 0-255.
> +      Setting this value to zero disables the delay timer interrupt.
> +      1 timeout interval = 125 * clock period of SG clock.
> +
> +  xlnx,axistream-connected:
> +    type: boolean
> +    description: Tells whether DMA is connected to AXI stream IP.
> +
> +# Note: This schema combines all DMA types in one file. Parent-child channel
> +# compatibility is enforced via allOf conditionals below. Alternatively, this
> +# could be split into separate schemas per DMA type to simplify validation rules.

Yeah, it's on the border of whether we should split it or not. I think 
it's fine as-is as splitting it would need a common schema for the 
shared parent and child properties. I don't think we need this comment 
in the file forever though.

> +patternProperties:
> +  "^dma-channel(-mm2s|-s2mm)?$":
> +    type: object
> +    description:
> +      Should have at least one channel and can have up to two channels per
> +      device. This node specifies the properties of each DMA channel.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - xlnx,axi-vdma-mm2s-channel
> +          - xlnx,axi-vdma-s2mm-channel
> +          - xlnx,axi-cdma-channel
> +          - xlnx,axi-dma-mm2s-channel
> +          - xlnx,axi-dma-s2mm-channel
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      xlnx,datawidth:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [32, 64, 128, 256, 512, 1024]
> +        description: Should contain the stream data width, take values {32,64...1024}.
> +
> +      xlnx,include-dre:
> +        type: boolean
> +        description: Tells hardware is configured for Data Realignment Engine.
> +
> +      xlnx,genlock-mode:
> +        type: boolean
> +        description: Tells Genlock synchronization is enabled/disabled in hardware.
> +
> +      xlnx,enable-vert-flip:
> +        type: boolean
> +        description:
> +          Tells vertical flip is enabled/disabled in hardware(S2MM path).
> +
> +      dma-channels:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Number of dma channels in child node.
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - xlnx,datawidth
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,axi-vdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: s_axi_lite_aclk
> +          items:
> +            enum:
> +              - s_axi_lite_aclk
> +              - m_axi_mm2s_aclk
> +              - m_axi_s2mm_aclk
> +              - m_axis_mm2s_aclk
> +              - s_axis_s2mm_aclk
> +          minItems: 1
> +          maxItems: 5
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-vdma-mm2s-channel
> +                - xlnx,axi-vdma-s2mm-channel
> +      required:
> +        - xlnx,num-fstores
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,axi-cdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: s_axi_lite_aclk
> +            - const: m_axi_aclk
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-cdma-channel
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: xlnx,axi-dma-1.00.a
> +              - const: xlnx,axi-mcdma-1.00.a

Use 'enum' rather than 'anyOf' and 'const'.

> +    then:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: s_axi_lite_aclk
> +          items:
> +            enum:
> +              - s_axi_lite_aclk
> +              - m_axi_mm2s_aclk
> +              - m_axi_s2mm_aclk
> +              - m_axi_sg_aclk
> +          minItems: 1
> +          maxItems: 4
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?(@[0-9a-f]+)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-dma-mm2s-channel
> +                - xlnx,axi-dma-s2mm-channel
> +
> +  - if:
> +      anyOf:
> +        - properties:

Don't need 'anyOf' with 1 entry.

> +            compatible:
> +              contains:
> +                anyOf:
> +                  - const: xlnx,axi-cdma-1.00.a
> +                  - const: xlnx,axi-mcdma-1.00.a
> +                  - const: xlnx,axi-dma-1.00.a

Use 'enun' rather than 'anyOf'.

> +    then:
> +      properties:
> +        interrupts: false
> +
> +required:
> +  - "#dma-cells"
> +  - reg
> +  - xlnx,addrwidth
> +  - dma-ranges
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    axi_vdma_0: dma@40030000 {
> +        compatible = "xlnx,axi-vdma-1.00.a";
> +        #dma-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x40030000 0x10000>;
> +        dma-ranges = <0x0 0x0 0x40000000>;
> +        xlnx,num-fstores = <8>;
> +        xlnx,flush-fsync;
> +        xlnx,addrwidth = <32>;
> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
> +                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
> +                      "s_axis_s2mm_aclk";
> +
> +        dma-channel-mm2s {
> +            compatible = "xlnx,axi-vdma-mm2s-channel";
> +            interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +        };
> +
> +        dma-channel-s2mm {
> +            compatible = "xlnx,axi-vdma-s2mm-channel";
> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +        };
> +    };
> -- 
> 2.25.1
> 

