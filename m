Return-Path: <dmaengine+bounces-4420-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB60A3189A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58A31888F8E
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B5268FD7;
	Tue, 11 Feb 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsFaIp0X"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C951267714;
	Tue, 11 Feb 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312792; cv=none; b=UzLaHYbAeU5VHDfaRSpUuplLLirRCwcJdyyToYeySchmqRM3ODFfz/OL+ld1Zpo+zUSA5J0rsqk77+OgmkN8OaVgl146deZoqF/iLI7Im/IkDCBYoCm7nxC//8obqSC/LTyW0DgSVmjvpBgWKP4P1gL+bK6+uvFob01IrXrTCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312792; c=relaxed/simple;
	bh=ZiCYq37YDGQSbnisBGMOuc5JJI4Fc3ZsQrKxYb8IE/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+e2m/zbMfjGLgeWncmiOjVTvAIC/TSv2eZrqmNXIIY31+uBY1QHTrpOU9MjFjWyJIOkPSHwCPttPy1u/SJuT+MyueCbB5b6D6/Lv8R31znHalCsCaJxmJK3V3B39Xh7O4NdbgJ+TksK26CIsljsnPIufL4tii+TGrHSWFs5kHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsFaIp0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D164DC4CEDD;
	Tue, 11 Feb 2025 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739312792;
	bh=ZiCYq37YDGQSbnisBGMOuc5JJI4Fc3ZsQrKxYb8IE/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsFaIp0XxEWYbpcLJ89WV7TcBNK9RpDgupgyeTPsG2H0fFD2ZAr30fhpx0W/TIkLc
	 rb7XzSZPSdDHrmgC9KVGnQAk28KijT1phke59uyNXwaUXceK4y/p4442QIKLe2RVE3
	 y3BVRNMY8M+7uSX9SZT011P1xsvclCpsu+FjiEjPj9DYod43MV/JuF+K3+1crNFtd9
	 L+bsh1KIfJRKxrGPfSTmeaCSHe4sRZzq5n315WlTxKD33vq69DmqkYl2iLROuIU/9G
	 oMZb8u48t4UBCsv82MBOR+eEvVuKi7teOeZ/a7O+ajEH8N/pUc2RN77ziYIl/cK6M9
	 pUhBPKD46AkFA==
Date: Tue, 11 Feb 2025 16:26:30 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family
 of SoCs
Message-ID: <20250211222630.GA1288508-robh@kernel.org>
References: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
 <20250206220308.76669-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206220308.76669-4-fabrizio.castro.jz@renesas.com>

On Thu, Feb 06, 2025 at 10:03:04PM +0000, Fabrizio Castro wrote:
> Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 152 +++++++++++++++---
>  1 file changed, 127 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index 82de3b927479..d4dd22432e49 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -11,19 +11,23 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r7s72100-dmac # RZ/A1H
> -          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> -          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> -          - renesas,r9a07g054-dmac # RZ/V2L
> -          - renesas,r9a08g045-dmac # RZ/G3S
> -      - const: renesas,rz-dmac
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r7s72100-dmac # RZ/A1H
> +              - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> +              - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> +              - renesas,r9a07g054-dmac # RZ/V2L
> +              - renesas,r9a08g045-dmac # RZ/G3S
> +          - const: renesas,rz-dmac
> +
> +      - const: renesas,r9a09g057-dmac # RZ/V2H(P)
>  
>    reg:
>      items:
>        - description: Control and channel register block
>        - description: DMA extended resource selector block
> +    minItems: 1
>  
>    interrupts:
>      maxItems: 17
> @@ -52,6 +56,7 @@ properties:
>      items:
>        - description: DMA main clock
>        - description: DMA register access clock
> +    minItems: 1
>  
>    clock-names:
>      items:
> @@ -61,14 +66,22 @@ properties:
>    '#dma-cells':
>      const: 1
>      description:
> -      The cell specifies the encoded MID/RID values of the DMAC port
> -      connected to the DMA client and the slave channel configuration
> -      parameters.
> +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> +      specifies the encoded MID/RID values of the DMAC port connected to the
> +      DMA client and the slave channel configuration parameters.
>        bits[0:9] - Specifies MID/RID value
>        bit[10] - Specifies DMA request high enable (HIEN)
>        bit[11] - Specifies DMA request detection type (LVL)
>        bits[12:14] - Specifies DMAACK output mode (AM)
>        bit[15] - Specifies Transfer Mode (TM)
> +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> +      slave channel configuration parameters.
> +      bits[0:9] - Specifies the REQ NO
> +      bits[10:16] - Specifies the ACK NO
> +      bit[17] - Specifies DMA request high enable (HIEN)
> +      bit[18] - Specifies DMA request detection type (LVL)
> +      bits[19:21] - Specifies DMAACK output mode (AM)
> +      bit[22] - Specifies Transfer Mode (TM)
>  
>    dma-channels:
>      const: 16
> @@ -80,12 +93,29 @@ properties:
>      items:
>        - description: Reset for DMA ARESETN reset terminal
>        - description: Reset for DMA RST_ASYNC reset terminal
> +    minItems: 1
>  
>    reset-names:
>      items:
>        - const: arst
>        - const: rst_async
>  
> +  renesas,icu:
> +    description:
> +      On the RZ/V2H(P) SoC configures the ICU to which the DMAC is connected to.
> +      It must contain the phandle to the ICU, and the index of the DMAC as seen
> +      from the ICU (e.g. parameter k from register ICU_DMkSELy).
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the ICU node.
> +          - description: The DMAC index.
> +              4 for DMAC0
> +              0 for DMAC1
> +              1 for DMAC2
> +              2 for DMAC3
> +              3 for DMAC4
> +
>  required:
>    - compatible
>    - reg
> @@ -98,27 +128,62 @@ allOf:
>    - $ref: dma-controller.yaml#
>  
>    - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              enum:
> -                - renesas,r7s72100-dmac
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-dmac
>      then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        clocks:
> +          maxItems: 1
> +        resets:
> +          maxItems: 1
> +
> +        clock-names: false
> +        reset-names: false
> +
>        required:
>          - clocks
> -        - clock-names
>          - power-domains
> +        - renesas,icu
>          - resets
> -        - reset-names
>  
>      else:
> -      properties:
> -        clocks: false
> -        clock-names: false
> -        power-domains: false
> -        resets: false
> -        reset-names: false
> +      if:

Please try to avoid nesting if/then/else. Not sure that's easy or not 
here. This diff is hard to read.

> +        not:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - renesas,r7s72100-dmac
> +      then:
> +        properties:
> +          reg:
> +            minItems: 2
> +          clocks:
> +            minItems: 2
> +          resets:
> +            minItems: 2
> +
> +          renesas,icu: false
> +
> +        required:
> +          - clocks
> +          - clock-names
> +          - power-domains
> +          - resets
> +          - reset-names
> +
> +      else:
> +        properties:
> +          clocks: false
> +          clock-names: false
> +          power-domains: false
> +          resets: false
> +          reset-names: false
> +          renesas,icu: false
>  
>  additionalProperties: false
>  
> @@ -164,3 +229,40 @@ examples:
>          #dma-cells = <1>;
>          dma-channels = <16>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/renesas-cpg-mssr.h>
> +
> +    dmac0: dma-controller@11400000 {
> +        compatible = "renesas,r9a09g057-dmac";

Is this example really different enough from the others to need it? I 
would drop it.

Rob


