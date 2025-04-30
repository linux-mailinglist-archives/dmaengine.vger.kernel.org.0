Return-Path: <dmaengine+bounces-5041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9BAA483D
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F44C6BEE
	for <lists+dmaengine@lfdr.de>; Wed, 30 Apr 2025 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005A238171;
	Wed, 30 Apr 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKNx2/KN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BA237194;
	Wed, 30 Apr 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008766; cv=none; b=osU0+Ee9v7xXQgaGmosVzqaBa40uTWjlomML7SRH8PSCq1DB9G5ltxvUWfmLIE2f7fvKwY7mkHEoWXABSy1DwRyL+89gUOYGkd2rrAEwORsJ6HR4Fw0GrZ6GSLXPWZkPKVho4NjSKWpxJqOj0Y+izUvlal//2mEevbbvcaexevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008766; c=relaxed/simple;
	bh=U83C1fx4RiCnbON4J3BLjckTisNNBrWzMaUOSyTeN0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+PGNnVa8YHCFdgX/4omxH6XHsebJj+szWIZSUzegVhRG0Ir2KpvFwlG8FEaLBAcDp/Oem0isgY2iBlRuhbfPPEJvASthFtJwjmuyilCdWA1CKsQ1ex/adGIjWT7I9lDkCp5qJaq6TooJ0JXOocNoNMa1cApduEHbOisCR9kBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKNx2/KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A074C4CEEA;
	Wed, 30 Apr 2025 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746008765;
	bh=U83C1fx4RiCnbON4J3BLjckTisNNBrWzMaUOSyTeN0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKNx2/KNqd+nIiX4NgFYdjgXQ3RpDGD4sxrkCgK2xt3GfgNMkmBZZN+VNcOa4SSG9
	 SfgTPNdYVW9SX4QG71IdLI4kqaEHXn9OCgIEKA2PfIwLzx3FufqMnyqJ4ETIGqFupY
	 03zFpqIr/+nDjrLyHYhKWIpzgfJgnzGykS5glGuoE0WwercwS5QWCWWqfLIyxpAse+
	 kNgclIfc0SEVVCtKaW7DCZiK41oQEknEEV7/oOMqzLWc1K842QffIu5A2LzKw0F8Iz
	 Lp7nGHhBw0fVRIU0cJ0Q4I4BpQIzHgdkRKOYywgrUDctamkiURw8mD4L4c1ZlvRuWD
	 ZyWJZzq1bH/Fg==
Date: Wed, 30 Apr 2025 12:26:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
	a-chavda@ti.com
Subject: Re: [PATCH 1/8] dt-bindings: dma: ti: Add document for K3 BCDMA V2
Message-ID: <20250430-energetic-hippo-from-tartarus-bf4b65@kuoka>
References: <20250428072032.946008-1-s-adivi@ti.com>
 <20250428072032.946008-2-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428072032.946008-2-s-adivi@ti.com>

On Mon, Apr 28, 2025 at 12:50:25PM GMT, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
> 
> BCDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/k3-bcdma-v2.yaml          | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> new file mode 100644
> index 0000000000000..af4aa3839fd66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024-2025 Texas Instruments Incorporated
> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/k3-bcdma-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS BCDMA V2
> +
> +maintainers:
> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +
> +description: |
> +  The BCDMA V2 is intended to perform similar functions as the TR
> +  mode channels of K3 UDMA-P.
> +  BCDMA V2 includes block copy channels and Split channels.
> +
> +  Block copy channels mainly used for memory to memory transfers, but with
> +  optional triggers a block copy channel can service peripherals by accessing
> +  directly to memory mapped registers or area.
> +
> +  Split channels can be used to service PSI-L based peripherals.
> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
> +  legacy peripheral.
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,dmss-bcdma-v2

SoC compatibles instead.

> +
> +  reg:
> +    items:
> +      - description: BCDMA Control /Status Registers region

s/Registers region//

> +      - description: Block Copy Channel Realtime Registers region
> +      - description: Channel Realtime Registers region
> +      - description: Ring Realtime Registers region
> +
> +  reg-names:
> +    items:
> +      - const: gcfg
> +      - const: bchanrt
> +      - const: chanrt
> +      - const: ringrt
> +
> +  "#dma-cells":
> +    const: 4
> +    description: |
> +      cell 1: Trigger type for the channel
> +        0 - disable / no trigger
> +        1 - internal channel event
> +        2 - external signal
> +        3 - timer manager event
> +
> +      cell 2: parameter for the trigger:
> +        if cell 1 is 0 (disable / no trigger):
> +          Unused, ignored
> +        if cell 1 is 1 (internal channel event):
> +          channel number whose TR event should trigger the current channel.
> +        if cell 1 is 2 or 3 (external signal or timer manager event):
> +          index of global interfaces that come into the DMA.
> +
> +          Please refer to the device documentation for global interface indexes.
> +
> +      cell 3: Channel number for the peripheral
> +
> +        Please refer to the device documentation for the channel map.
> +
> +      cell 4: ASEL value for the channel
> +
> +required:
> +  - compatible
> +  - "#dma-cells"
> +  - reg
> +  - reg-names

Keep same order as in properties: block.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+

Drop +

> +    cbass_main {

Follow DTS coding style... or just make it like all other SoC bindings.

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +      main_bcdma: dma-controller@485c4000 {

Messed indentation.


Best regards,
Krzysztof


