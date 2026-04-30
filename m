Return-Path: <dmaengine+bounces-10199-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHlENckE82nawgEAu9opvQ
	(envelope-from <dmaengine+bounces-10199-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 09:29:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8649E9CA
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF9A3301874C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D243A7F78;
	Thu, 30 Apr 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx7mViHT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7593A7F4A;
	Thu, 30 Apr 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534148; cv=none; b=qsPsXrPSqlTywN6XhjFK4h+KDkNLFRlWQmeJ0WijgXUyU2RWQPO75Nt0hCXZbLQLLn5EKW6kSxik5CjT5XbphSuH5UBH/88Rg8yWgLvc9NHI8LIAhmx34xeuX4+PQ9UmvCAaNmfiFxLcyYcY8BSZXDsVmO3FofiCHugdbMgxuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534148; c=relaxed/simple;
	bh=fX0LBlHuuGJ2LnBmpaYmRUok+v8NthOe/2YIwmNGOzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoKSGd95YDUBO3fvTx6ZKI+RGgfNwoJzAh/XOQRccssS4poNIq/EjMVOpvW1mZI1DyVTReSs4sYXwn5zJrSaePKLd0ICcupfLcrwUpYGRBAs85wx8zcCDBDJCqfyW6izjjnfV7augzMK7sPn1zclFC/OU2Dn50FNdIjURm0G4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx7mViHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EEBC2BCB3;
	Thu, 30 Apr 2026 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777534147;
	bh=fX0LBlHuuGJ2LnBmpaYmRUok+v8NthOe/2YIwmNGOzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx7mViHT3laPzlfWs1tJJoJTi+e80hngfvmF8o66ggqSYS/+AXRLTo5XKGCLoP+wG
	 im5qhdJ/9tIetVAd6MzHGZDh9H9nYiujFbJF49unhxU7YRGTfJc9cYTjhXOy9Isr8B
	 /dybG9ZTdw/hiYxMyohM3UrfKMdTJ7Hy2V0go0BdRPdiE2q5YMnt8GBe247+ZfZ3ZQ
	 KxHvACKttt17qF/PN+kAKy1UvZdx5Sky5eNCn/zgtlhYLQsXesXGb/gWP1DA0/lvvY
	 27pBT5Oe8VIwafuXvJ2UsZocktgVxg9TFQ8URhAIMVJ1cmc1QkMJzQzBg3JtaQTAZ+
	 2A406CYfHMqlA==
Date: Thu, 30 Apr 2026 09:29:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, Frank.li@nxp.com, r-sharma3@ti.com, 
	gehariprasath@ti.com
Subject: Re: [PATCH v6 13/19] dt-bindings: dma: ti: Add K3 BCDMA V2
Message-ID: <20260430-orthodox-athletic-agama-be4111@quoll>
References: <20260428085202.1724548-1-s-adivi@ti.com>
 <20260428085202.1724548-14-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428085202.1724548-14-s-adivi@ti.com>
X-Rspamd-Queue-Id: 51A8649E9CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10199-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,ti.com:email]

On Tue, Apr 28, 2026 at 02:21:42PM +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for

I don't see improvements.

> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
> 
> BCDMA V2 is introduced as part of AM62L.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> new file mode 100644
> index 0000000000000..28dcfce5633ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
> @@ -0,0 +1,121 @@
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

Why do you need address-cells?

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
> +  interrupts:
> +    minItems: 1
> +    maxItems: 144
> +    description:
> +      Interrupts for DMA channels.

And interrupts are flexible because?

Best regards,
Krzysztof


