Return-Path: <dmaengine+bounces-8968-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vkthBBS/lmmslgIAu9opvQ
	(envelope-from <dmaengine+bounces-8968-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 08:43:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276715CC3E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C22300EC99
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C82D3A93;
	Thu, 19 Feb 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdbKhf8z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFB18027;
	Thu, 19 Feb 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771486991; cv=none; b=e45C02sTouW1E6srLSBPplEd7s7C8Man2JPDptCIkR+znlq8YH7WGN+F+g1rh8ya5HD5FVKI+SDbvmcmNupXe23mhXLyqgGMP/sOJfW/l8OjyMnzXlhpSP7eIRI+awks9+It0MO0Du3uvZoqMgUl+bKp0baNfEDnWOWC4tCIVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771486991; c=relaxed/simple;
	bh=EZbnBXFpdDmY3HCD/8ilJbQIHY5K83u0h3fNzYw/pC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfkhyYCVx8QkuyLqwTUu6TNYym9iRrA7yKpTPNiQxoAvKxEwvWBwIz5VP6EiCIcP5yQIFu7MYFXn/c3GXJkuWYSkz3erkM8H579UEQ+8p+n7juiceRJI30l0315fVdiad9D4EC+4IqWaL71cD0yAUceiEoBK6PCBfOk7aOcZASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdbKhf8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08798C4CEF7;
	Thu, 19 Feb 2026 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771486990;
	bh=EZbnBXFpdDmY3HCD/8ilJbQIHY5K83u0h3fNzYw/pC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdbKhf8zttPjUjMASJ2uyl50RJ9RS1Y/5DCJ/mUg0/uB2fGsF3JONLgEXfVR9hKpm
	 YkUxak9x0GC7hs/ENIts6NSA5uCkpZrz8GmOYrx38wJO7i0JFu3++bsK9vmqyXg+3K
	 hei0MmYhikf6xPuct2JxXDXeJZ/4y3xpxe+X7NVBb4gV5agdpLeDq936KUGa7JJgN5
	 /l+MR2N7y+5TSyqIJtPiSxJFvM7HnxVB+DSnTKXEAPj0hi8fJD55ezVZT0FE+jEuvE
	 FKrAa8OhkVagkfFVdDH7MxuQevsVr6cN9Pb8c0H7NPanfTLnLbRisFn1oyz85nZtYo
	 pYcBcNNNULnuw==
Date: Thu, 19 Feb 2026 08:43:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, Frank.li@nxp.com, r-sharma3@ti.com, 
	gehariprasath@ti.com
Subject: Re: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
Message-ID: <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-13-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218095243.2832115-13-s-adivi@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8968-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 6276715CC3E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 03:22:37PM +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for

Fix wrapping - it's wrapped too early.

> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
> 
> BCDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> new file mode 100644
> index 0000000000000..6fa08f22df375
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024-25 Texas Instruments Incorporated
> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS BCDMA V2
> +
> +maintainers:
> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +
> +description:
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
> +    const: ti,am62l-dmss-bcdma
> +
> +  reg:
> +    items:
> +      - description: BCDMA Control & Status Registers region
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
> +  "#address-cells":
> +    const: 0
> +
> +  "#interrupt-cells":
> +    const: 1

I don't get why this is nexus but not a interrupt-controller.

Can you point me to DTS with complete picture using this?

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
> +  interrupt-map-mask:
> +    items:
> +      - const: 0x7ff
> +
> +  interrupt-map:
> +    description: |
> +      Maps internal BCDMA channel IDs to the parent GIC IRQ lines.

Isn't this mapping fixed in given device? IOW, not really part of DTS
description but deducible from the compatible.

You only need to provide interrupts for your device.


Best regards,
Krzysztof


