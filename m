Return-Path: <dmaengine+bounces-3216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA2986EF6
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2024 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7239C1C221BE
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965B1AD3F1;
	Thu, 26 Sep 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DBecXBrH"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1C1A76DF;
	Thu, 26 Sep 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339784; cv=none; b=sNTSdVCUpepO3O8PoVE9lg4C9JzanEZrFhIOb7pBE1XdHbyEGtZFhqbroeeq8CC6ecUlDm3zPI7yayLazwBO/nxl9Tuj85RUyAlLO2JFhGbGXgc2UAsm0NlHyvvbAc/l5isQaJfLxqYrqeL8lvZsSjoIKXidrsRAnsAZlN45yOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339784; c=relaxed/simple;
	bh=0vx2wLHIP341Fcw6qUhYwA5kM6D965fe51U5NDuNykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5SfY7IiZbxUm309tSk3epAhTSWi24rD4JaC28BYvPuD3rs84gvOliRIQ17vUhzc08+dqqXlWOqT5DZhr4JCDTliYcuZPpxPMTaWg1WtEuTzAXcK3pYS59qzUlGyFbvoFYmD392sdfNeVwulOy4TALPnMbmv/US8RdtQYY6/gqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DBecXBrH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CFCEF169;
	Thu, 26 Sep 2024 10:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1727339692;
	bh=0vx2wLHIP341Fcw6qUhYwA5kM6D965fe51U5NDuNykk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBecXBrHZnJ73ugoSwlvEFZl5HNOOcuYbIIdgLX1AkDR6PH7vK9Arte2y8mICEzuh
	 DXLodimMtWBjICZsq8QJw6rUDxSmTNStU9keIPkEqgc1e45rvdlA7HJY/31ZgKMTlG
	 9tBNMwgZHEvdG1BfpH27Ivag8bjqyiquObr5/TM0=
Date: Thu, 26 Sep 2024 11:36:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix array property constraints
Message-ID: <20240926083617.GA29582@pendragon.ideasonboard.com>
References: <20240925232409.2208515-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925232409.2208515-1-robh@kernel.org>

Hi Rob,

Thank you for the patch.

On Wed, Sep 25, 2024 at 06:24:06PM -0500, Rob Herring (Arm) wrote:
> Schemas for array properties should only have 1 level of array
> constraints (e.g. items, maxItems, minItems). Sometimes the old
> encoding of all properties into a matrix leaked into the schema, and
> didn't matter for validation. Now the inner constraints are just
> silently ignored as json-schema array keywords are ignored on scalar
> values.
> 
> Generally, keep the inner constraints and drop the outer "items". With
> gicv3 "mbi-alias" property, it is more appropriately a uint32 or uint64
> as it is an address and size depends on "#address-cells".

I haven't followed what changed in the validation tools, but this is
definitely less confusing. Thanks for improving the experience.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/cache/l2c2x0.yaml  |  5 ++---
>  .../devicetree/bindings/dma/dma-common.yaml          |  7 +++----
>  .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 +++++-------
>  .../devicetree/bindings/media/i2c/thine,thp7312.yaml |  3 +--
>  .../bindings/memory-controllers/exynos-srom.yaml     |  5 ++---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       |  5 ++---
>  .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml     |  3 +--
>  7 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cache/l2c2x0.yaml b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
> index d7840a5c4037..10c1a900202f 100644
> --- a/Documentation/devicetree/bindings/cache/l2c2x0.yaml
> +++ b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
> @@ -100,9 +100,8 @@ properties:
>        filter. Addresses in the filter window are directed to the M1 port. Other
>        addresses will go to the M0 port.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -    items:
> -      minItems: 2
> -      maxItems: 2
> +    minItems: 2
> +    maxItems: 2
>  
>    arm,io-coherent:
>      description: indicates that the system is operating in an hardware
> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
> index ea700f8ee6c6..fde5160b5d29 100644
> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> @@ -32,10 +32,9 @@ properties:
>        The first item in the array is for channels 0-31, the second is for
>        channels 32-63, etc.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -    items:
> -      minItems: 1
> -      # Should be enough
> -      maxItems: 255
> +    minItems: 1
> +    # Should be enough
> +    maxItems: 255
>  
>    dma-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index 5f051c666cbe..f3247a47f9ee 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -132,10 +132,9 @@ properties:
>        Address property. Base address of an alias of the GICD region containing
>        only the {SET,CLR}SPI registers to be used if isolation is required,
>        and if supported by the HW.
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> -    items:
> -      minItems: 1
> -      maxItems: 2
> +    oneOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - $ref: /schemas/types.yaml#/definitions/uint64
>  
>    ppi-partitions:
>      type: object
> @@ -223,9 +222,8 @@ patternProperties:
>            (u32, u32) tuple describing the untranslated
>            address and size of the pre-ITS window.
>          $ref: /schemas/types.yaml#/definitions/uint32-array
> -        items:
> -          minItems: 2
> -          maxItems: 2
> +        minItems: 2
> +        maxItems: 2
>  
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> index 535acf2b88a9..bc339a7374b2 100644
> --- a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
> @@ -135,8 +135,7 @@ properties:
>  
>            data-lanes:
>              $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes
> -            items:
> -              maxItems: 4
> +            maxItems: 4
>              description:
>                This property is for lane reordering between the THP7312 and the imaging
>                sensor that it is connected to.
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> index 10a2d97e5f8b..a5598ade399f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
> @@ -66,9 +66,8 @@ patternProperties:
>  
>        samsung,srom-timing:
>          $ref: /schemas/types.yaml#/definitions/uint32-array
> -        items:
> -          minItems: 6
> -          maxItems: 6
> +        minItems: 6
> +        maxItems: 6
>          description: |
>            Array of 6 integers, specifying bank timings in the following order:
>            Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 0925c520195a..2ad1652c2584 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -92,9 +92,8 @@ properties:
>        may have two component regions -- base and extended -- so
>        this information cannot be deduced from the dma-ranges.
>      $ref: /schemas/types.yaml#/definitions/uint64-array
> -    items:
> -      minItems: 1
> -      maxItems: 3
> +    minItems: 1
> +    maxItems: 3
>  
>    resets:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> index 141d666dc3f7..1ba1d419e83b 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
> @@ -55,8 +55,7 @@ properties:
>  
>    qcom,smem:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -    items:
> -      maxItems: 2
> +    maxItems: 2
>      description:
>        Two identifiers of the inbound and outbound smem items used for this edge.
>  

-- 
Regards,

Laurent Pinchart

