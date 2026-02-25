Return-Path: <dmaengine+bounces-9057-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOBuNoLNnmnxXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9057-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:22:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F1195B31
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29FDC300D0FB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A73431F2;
	Wed, 25 Feb 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUXCSxmc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046E32695F;
	Wed, 25 Feb 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014967; cv=none; b=FuZgKtysYzSt3QlkvRMF8d/oNx3TvAduEzWgtTnyN2K2/tPv9qXH219AKidmkDU8h2KYveMlqQIyAQ/IAjX/HUoNrRAfczir91sDGTl/bluPBiJ2+v2QaV4uCu7l+V+4d6O3yYWn4sKtWsVWpDID5fsnt5Y4ANaf4KHnV7bBW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014967; c=relaxed/simple;
	bh=m8Npz5IATdXMAbbfXgeZWqeu8QwnEwLElv4fs71BWes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt2uvr7UPEUjDCpiMjEczcnFd71mXTqu0Y72Oz6cs3o56or3Bp+b7WNcbTw/0WEcqpYmedjk2x6Ay7twLOFG7ccsBMX2vtWnJdhksxIgHXpILAidbQQViFJ4TrIexpSf2aj3CBItFJS7Gb5bG9QaauH29XDaJyNmaGeVP1LG4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUXCSxmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3937C116D0;
	Wed, 25 Feb 2026 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014966;
	bh=m8Npz5IATdXMAbbfXgeZWqeu8QwnEwLElv4fs71BWes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUXCSxmcI4NdgFuO9hQuq7Nggs53GCTwhopJGsfRKKs7h6evOZq3AOh4WiU4eo5pQ
	 GUAswkyEYS5jlQqrghlzGIVqfUn+8efZUcWvb2auSYN/0f//5xn7X/l6k8nJtfL0db
	 3LxMQbZYeOL4bS+7ndEoN5Nlo3RICVJfn75rJnUKz01KiuxL90bt9Hil7l60MbFjEY
	 iMb0BC2lAmcvlDrRcXQXcdl21aZR49mP8bu62MpJSyqzK26t2t/8i6VQeBji+eDEqK
	 uc39RYVKFoL0Ip5yh6qMc/KExjgqhFGgvOD/aI3rLo93jmNC5f1oLEl+M+0x+8zOs2
	 3I8ivBz9xpgTg==
Date: Wed, 25 Feb 2026 11:22:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com, 
	radhey.shyam.pandey@amd.com, git@amd.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dmaengine: xlnx,axi-dma: Convert
 bindings into yaml
Message-ID: <20260225-cerise-oryx-of-pluck-8e2f30@quoll>
References: <20260225050521.160724-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225050521.160724-1-abin.joseph@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9057-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[2.98.207.48:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110F1195B31
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:35:21AM +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA from txt to yaml.
> No changes to existing binding description.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
> 
> v2:
> -> Add examples for each compatible

No, why? We did not ask for that and (see writing schema) we ask for one
example, more only if they are different.


...


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
> +    items:
> +      - description: Interrupt for single channel (MM2S or S2MM)
> +      - description: Interrupt for dual channel configuration
> +    minItems: 1
> +    description:
> +      Interrupt lines for the DMA controller. Only used when
> +      xlnx,axistream-connected is present (DMA connected to AXI Stream
> +      IP). When child dma-channel nodes are present, interrupts are
> +      specified in the child nodes instead.
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
> +      Width in bits of the length register as configured in hardware.
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
> +  - $ref: ../dma-controller.yaml#
> +
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

This is REALLY unexpected syntax. You are supposed to have strictly
ordered list - why do you need need it to be so flexible? And if element
is required it should be the first item. There is no single DTS even
mentioning it!

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
> +            enum:
> +              - xlnx,axi-dma-1.00.a
> +              - xlnx,axi-mcdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: s_axi_lite_aclk

Why do you need this?

> +          items:
> +            enum:
> +              - s_axi_lite_aclk
> +              - m_axi_mm2s_aclk
> +              - m_axi_s2mm_aclk
> +              - m_axi_sg_aclk

Why this cannot be ordered list like we expect (see writing bindings)?


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
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,axi-cdma-1.00.a
> +              - xlnx,axi-mcdma-1.00.a
> +              - xlnx,axi-dma-1.00.a
> +    then:
> +      properties:
> +        interrupts: false

Why interrupts are flexible in other case?

This should be probably squashed in each of previous if:then:.


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
> +    dma-controller@40030000 {
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
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    dma-controller@a4030000 {
> +        compatible = "xlnx,axi-dma-1.00.a";
> +        #dma-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0xa4030000 0x10000>;
> +        dma-ranges = <0x0 0x0 0x40000000>;
> +        xlnx,addrwidth = <32>;
> +        xlnx,sg-length-width = <14>;
> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>;
> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
> +                      "m_axi_s2mm_aclk", "m_axi_sg_aclk";
> +
> +        dma-channel-mm2s {
> +            compatible = "xlnx,axi-dma-mm2s-channel";
> +            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +            xlnx,include-dre;
> +        };
> +
> +        dma-channel-s2mm {
> +            compatible = "xlnx,axi-dma-s2mm-channel";
> +            interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +            xlnx,include-dre;
> +        };
> +    };
> +

Drop all examples past this point.

Best regards,
Krzysztof


