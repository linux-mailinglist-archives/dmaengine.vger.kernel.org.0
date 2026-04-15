Return-Path: <dmaengine+bounces-10020-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN3xOFD632ntbAAAu9opvQ
	(envelope-from <dmaengine+bounces-10020-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:51:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D60AF407B9A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B3E1301DE7E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05338BF91;
	Wed, 15 Apr 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHPz3lzR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B9385506;
	Wed, 15 Apr 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286283; cv=none; b=e8cJneUJ2P/g7h9EcxXjcSUiGPole5kiwi8kbFFkwoL/fKjxcuANqojbuOwrVv4jIZrxqI4JjM7vVeATUM2n3MbMwqs5JOtE+hF8QdElJ18wnlKujN7mMI2QvI97MEbRl4eViBIf5CdHze7jEbgeT33ifxgNJS9rohkQ6JB9P2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286283; c=relaxed/simple;
	bh=ccxvPQ9IHLzAd7f2NYR3IfFEAhs2uYAktFiooxlp2Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEpYZssPusVWcb+d6BGvjsBAbJWo0qW1x+v2q/+Lo2xZ5KHgdeKF+dnAxTQJThDmipHU5RVoHsTGwqCUtptIzA3gecfnM1qsNKtP9rokGUzY04lCvyeFyO7/R1dCOYjvS6IM44LT3AgLKqet+3t85WYqcpIsQftSdXAI0CL/kNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHPz3lzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D801EC19424;
	Wed, 15 Apr 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776286283;
	bh=ccxvPQ9IHLzAd7f2NYR3IfFEAhs2uYAktFiooxlp2Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHPz3lzR4GChsWdyYUXCUUFjGnRPPot3R7nnKAS+FxHW6fnGddaPlzixKD9tWRoX4
	 h2/B8ls76o3uNAxk1fQ7QliR9glvcPokjxD7yXbUhoI4rz0LLNjxUHadTix9uOxCkT
	 0uO5fUcxmrFzW9Pz4/p6W6LkU64jptJIyyM60cXfmOME/3oljAg7D1q+EeCHn88g6Z
	 pwXt9wH8/xF30nT/G2WtZDmXZ08w1ckrNB1S1gQolkVlPP/zbkLtL/+6oFy0jvPO1H
	 f3c/vo66WGpET+HVxW2Kp20f2b9DFPA454limWIXzWVMPHwGJb7Eh+8Y0W2Lf8XCXa
	 H+5tYwcjVgPEg==
Date: Wed, 15 Apr 2026 15:51:21 -0500
From: Rob Herring <robh@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 05/24] ASoC: dt-bindings: renesas,rsnd: Split into
 generic and SoC-specific parts
Message-ID: <20260415205121.GA331204-robh@kernel.org>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-6-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402090524.9137-6-john.madieu.xa@bp.renesas.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10020-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D60AF407B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:05:04AM +0200, John Madieu wrote:
> The current renesas,rsnd.yaml binding file handles all supported SoCs
> in a single schema, resulting in deeply nested if/else/then constructs
> that become increasingly difficult to maintain. Each new SoC addition
> amplifies this complexity, making reviews harder and diffs noisier than
> they need to be.
> 
> Refactor the binding by extracting the common properties shared across
> all SoCs into a dedicated renesas,rsnd-common.yaml schema, and keeping
> only SoC-specific constraints (required nodes, port counts, clock names,
> etc.) in per-SoC or per-family files that $ref the common part.
> 
> This prepares the ground for upcoming SoCs such as the RZ/G3E, which
> introduces a different set of audio resources compared to existing
> R-Car Gen variants. With the split in place, adding RZ/G3E support
> becomes a self-contained change that neither bloats a monolithic schema
> nor buries new constraints inside ever-deeper conditional blocks.
> 
> No functional change in validation behaviour for existing device trees.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v2: New patch
> 
>  .../bindings/sound/renesas,rsnd-common.yaml   | 196 +++++++++++
>  .../bindings/sound/renesas,rsnd.yaml          | 319 +++++-------------
>  2 files changed, 274 insertions(+), 241 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml
> new file mode 100644
> index 000000000000..ec6bf644d1a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/renesas,rsnd-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car/RZ Sound Common Properties
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +description:
> +  Common property and subnode definitions shared by Renesas R-Car and RZ
> +  sound controller bindings.
> +
> +select: false
> +
> +properties:
> +  compatible: true
> +
> +  reg: true
> +
> +  reg-names: true

Drop these as they should be defined in the device specfic schemas.

> +
> +  "#sound-dai-cells":
> +    description:
> +      Must be 0 for a single-DAI system and 1 for a multi-DAI system.
> +    enum: [0, 1]
> +
> +  "#clock-cells":
> +    description:
> +      Must be 0 when the system has audio_clkout and 1 when it has
> +      audio_clkout0/1/2/3.
> +    enum: [0, 1]
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  clock-frequency:
> +    description: Audio clock output frequency for audio_clkout0/1/2/3.
> +
> +  clkout-lr-asynchronous:
> +    description: audio_clkoutn is asynchronous with lr-clock.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  power-domains: true
> +
> +  resets: true
> +
> +  reset-names: true
> +
> +  clocks: true
> +
> +  clock-names: true

And drop these unless you have some global constraints.

> +
> +  port:
> +    $ref: audio-graph-port.yaml#/definitions/port-base
> +    unevaluatedProperties: false

Blank line

> +    patternProperties:
> +      "^endpoint(@[0-9a-f]+)?$":
> +        $ref: audio-graph-port.yaml#/definitions/endpoint-base

Blank line

> +        properties:
> +          playback:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array

Blank line

(and similar throughout)

> +          capture:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +        unevaluatedProperties: false

Move after $ref.

> +
> +  rcar_sound,dvc:
> +    description: DVC subnode.
> +    type: object
> +    patternProperties:
> +      "^dvc-[0-1]$":
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          dmas: true
> +          dma-names: true
> +        required:
> +          - dmas
> +          - dma-names
> +    additionalProperties: false

Move after 'type'.

> +
> +  rcar_sound,mix:
> +    description: MIX subnode.
> +    type: object
> +    patternProperties:
> +      "^mix-[0-1]$":
> +        type: object
> +        additionalProperties: false
> +    additionalProperties: false
> +
> +  rcar_sound,ctu:
> +    description: CTU subnode.
> +    type: object
> +    patternProperties:
> +      "^ctu-[0-7]$":
> +        type: object
> +        additionalProperties: false
> +    additionalProperties: false
> +
> +  rcar_sound,src:
> +    description: SRC subnode.
> +    type: object
> +    patternProperties:
> +      "^src-[0-9]$":
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          interrupts:
> +            maxItems: 1
> +          dmas: true
> +          dma-names: true
> +    additionalProperties: false
> +
> +  rcar_sound,ssiu:
> +    description: SSIU subnode.
> +    type: object
> +    patternProperties:
> +      "^ssiu-[0-9]+$":
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          dmas: true
> +          dma-names: true
> +        required:
> +          - dmas
> +          - dma-names
> +    additionalProperties: false
> +
> +  rcar_sound,ssi:
> +    description: SSI subnode.
> +    type: object
> +    patternProperties:
> +      "^ssi-[0-9]$":
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          interrupts:
> +            maxItems: 1
> +          dmas: true
> +          dma-names: true
> +          shared-pin:
> +            description: Shared clock pin.
> +            $ref: /schemas/types.yaml#/definitions/flag
> +          pio-transfer:
> +            description: PIO transfer mode.
> +            $ref: /schemas/types.yaml#/definitions/flag
> +          no-busif:
> +            description: BUSIF is not used for the mem-to-SSI via DMA case.
> +            $ref: /schemas/types.yaml#/definitions/flag
> +        required:
> +          - interrupts
> +    additionalProperties: false
> +
> +patternProperties:
> +  'rcar_sound,dai(@[0-9a-f]+)?$':

Why does this have a unit-address, but no 'reg' property? That should be 
dropped.

> +    description: DAI subnode.
> +    type: object
> +    patternProperties:
> +      "^dai([0-9]+)?$":
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          playback:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +          capture:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +        anyOf:
> +          - required:
> +              - playback
> +          - required:
> +              - capture
> +    additionalProperties: false
> +
> +  'ports(@[0-9a-f]+)?$':
> +    $ref: audio-graph-port.yaml#/definitions/port-base

This is 'ports', not 'port', so not the right ref.

> +    unevaluatedProperties: false
> +    patternProperties:
> +      '^port(@[0-9a-f]+)?$':
> +        $ref: "#/properties/port"
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> index e8a2acb92646..0d989922a5b4 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> @@ -9,8 +9,11 @@ title: Renesas R-Car Sound Driver
>  maintainers:
>    - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>  
> -properties:
> +description:
> +  Binding for Renesas R-Car Gen1/Gen2/Gen3/Gen4 and RZ/G1/G2 sound
> +  controllers using the standard RSND layout.
>  
> +properties:
>    compatible:
>      oneOf:
>        # for Gen1 SoC
> @@ -67,34 +70,6 @@ properties:
>      minItems: 1
>      maxItems: 5
>  
> -  "#sound-dai-cells":
> -    description: |
> -      it must be 0 if your system is using single DAI
> -      it must be 1 if your system is using multi  DAIs
> -      This is used on simple-audio-card
> -    enum: [0, 1]
> -
> -  "#clock-cells":
> -    description: |
> -      it must be 0 if your system has audio_clkout
> -      it must be 1 if your system has audio_clkout0/1/2/3
> -    enum: [0, 1]
> -
> -  "#address-cells":
> -    const: 1
> -
> -  "#size-cells":
> -    const: 0
> -
> -  clock-frequency:
> -    description: for audio_clkout0/1/2/3
> -
> -  clkout-lr-asynchronous:
> -    description: audio_clkoutn is asynchronizes with lr-clock.
> -    $ref: /schemas/types.yaml#/definitions/flag
> -
> -  power-domains: true
> -
>    resets:
>      minItems: 1
>      maxItems: 11
> @@ -109,181 +84,45 @@ properties:
>      maxItems: 31
>  
>    clock-names:
> -    description: List of necessary clock names.
> -    # details are defined below
> -
> -  # ports is below
> -  port:
> -    $ref: audio-graph-port.yaml#/definitions/port-base
> -    unevaluatedProperties: false
> -    patternProperties:
> -      "^endpoint(@[0-9a-f]+)?":
> -        $ref: audio-graph-port.yaml#/definitions/endpoint-base
> -        properties:
> -          playback:
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -          capture:
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -        unevaluatedProperties: false
> -
> -  rcar_sound,dvc:
> -    description: DVC subnode.
> -    type: object
> -    patternProperties:
> -      "^dvc-[0-1]$":
> -        type: object
> -        additionalProperties: false
> -
> -        properties:
> -          dmas:
> -            maxItems: 1
> -          dma-names:
> -            const: tx
> -        required:
> -          - dmas
> -          - dma-names
> -    additionalProperties: false
> -
> -  rcar_sound,mix:
> -    description: MIX subnode.
> -    type: object
> -    patternProperties:
> -      "^mix-[0-1]$":
> -        type: object
> -        additionalProperties: false
> -    additionalProperties: false
> -
> -  rcar_sound,ctu:
> -    description: CTU subnode.
> -    type: object
> -    patternProperties:
> -      "^ctu-[0-7]$":
> -        type: object
> -        additionalProperties: false
> -    additionalProperties: false
> -
> -  rcar_sound,src:
> -    description: SRC subnode.
> -    type: object
> -    patternProperties:
> -      "^src-[0-9]$":
> -        type: object
> -        additionalProperties: false
> -
> -        properties:
> -          interrupts:
> -            maxItems: 1
> -          dmas:
> -            maxItems: 2
> -          dma-names:
> -            allOf:
> -              - items:
> -                  enum:
> -                    - tx
> -                    - rx
> -    additionalProperties: false
> -
> -  rcar_sound,ssiu:
> -    description: SSIU subnode.
> -    type: object
> -    patternProperties:
> -      "^ssiu-[0-9]+$":
> -        type: object
> -        additionalProperties: false
> -
> -        properties:
> -          dmas:
> -            maxItems: 2
> -          dma-names:
> -            allOf:
> -              - items:
> -                  enum:
> -                    - tx
> -                    - rx
> -        required:
> -          - dmas
> -          - dma-names
> -    additionalProperties: false
> -
> -  rcar_sound,ssi:
> -    description: SSI subnode.
> -    type: object
> -    patternProperties:
> -      "^ssi-[0-9]$":
> -        type: object
> -        additionalProperties: false
> -
> -        properties:
> -          interrupts:
> -            maxItems: 1
> -          dmas:
> -            minItems: 2
> -            maxItems: 4
> -          dma-names:
> -            allOf:
> -              - items:
> -                  enum:
> -                    - tx
> -                    - rx
> -                    - txu # if no ssiu node
> -                    - rxu # if no ssiu node
> -
> -          shared-pin:
> -            description: shared clock pin
> -            $ref: /schemas/types.yaml#/definitions/flag
> -          pio-transfer:
> -            description: PIO transfer mode
> -            $ref: /schemas/types.yaml#/definitions/flag
> -          no-busif:
> -            description: BUSIF is not used when [mem -> SSI] via DMA case
> -            $ref: /schemas/types.yaml#/definitions/flag
> -        required:
> -          - interrupts
> -    additionalProperties: false
> +    description: List of clock names.
> +    minItems: 1
> +    maxItems: 31
> +

> +  "#sound-dai-cells": true
> +
> +  "#clock-cells": true
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  clock-frequency: true
> +
> +  clkout-lr-asynchronous: true
> +
> +  power-domains: true
> +
> +  port: true
> +
> +  rcar_sound,dvc: true
> +
> +  rcar_sound,mix: true
> +
> +  rcar_sound,ctu: true
> +
> +  rcar_sound,src: true
> +
> +  rcar_sound,ssiu: true
> +
> +  rcar_sound,ssi: true

Use 'unevaluatedProperties' and drop all of these.

>  
>  patternProperties:
> -  # For DAI base
> -  'rcar_sound,dai(@[0-9a-f]+)?$':
> -    description: DAI subnode.
> -    type: object
> -    patternProperties:
> -      "^dai([0-9]+)?$":
> -        type: object
> -        additionalProperties: false
> -
> -        properties:
> -          playback:
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -          capture:
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -        anyOf:
> -          - required:
> -              - playback
> -          - required:
> -              - capture
> -    additionalProperties: false
> -
> -  'ports(@[0-9a-f]+)?$':
> -    $ref: audio-graph-port.yaml#/definitions/port-base
> -    unevaluatedProperties: false
> -    patternProperties:
> -      '^port(@[0-9a-f]+)?$':
> -        $ref: "#/properties/port"
> -
> -required:
> -  - compatible
> -  - reg
> -  - reg-names
> -  - clocks
> -  - clock-names
> +  'rcar_sound,dai(@[0-9a-f]+)?$': true
> +  'ports(@[0-9a-f]+)?$': true
>  
>  allOf:
> -  - $ref: dai-common.yaml#
> +  - $ref: renesas,rsnd-common.yaml#
>  
> -  # --------------------
> -  # reg/reg-names
> -  # --------------------
> -  # for Gen1
>    - if:
>        properties:
>          compatible:
> @@ -295,11 +134,10 @@ allOf:
>            maxItems: 3
>          reg-names:
>            items:
> -            enum:
> -              - sru
> -              - ssi
> -              - adg
> -  # for Gen2/Gen3
> +            - const: sru
> +            - const: ssi
> +            - const: adg
> +
>    - if:
>        properties:
>          compatible:
> @@ -310,16 +148,34 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 5
> +          maxItems: 5
>          reg-names:
>            items:
> -            enum:
> -              - scu
> -              - adg
> -              - ssiu
> -              - ssi
> -              - audmapp
> -  # for Gen4
> +            - const: scu
> +            - const: adg
> +            - const: ssiu
> +            - const: ssi
> +            - const: audmapp
> +        resets:
> +          maxItems: 11
> +        reset-names:
> +          items:
> +            oneOf:
> +              - const: ssi-all
> +              - pattern: '^ssi\.[0-9]$'
> +        clocks:
> +          maxItems: 31
> +        clock-names:
> +          items:
> +            oneOf:
> +              - const: ssi-all
> +              - pattern: '^ssi\.[0-9]$'
> +              - pattern: '^src\.[0-9]$'
> +              - pattern: '^mix\.[0-1]$'
> +              - pattern: '^ctu\.[0-1]$'
> +              - pattern: '^dvc\.[0-1]$'
> +              - pattern: '^clk_(a|b|c|i)$'
> +
>    - if:
>        properties:
>          compatible:
> @@ -336,38 +192,19 @@ allOf:
>                - ssiu
>                - ssi
>                - sdmc
> -
> -  # --------------------
> -  # clock-names
> -  # --------------------
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            const: renesas,rcar_sound-gen4
> -    then:
> -      properties:
> -        clock-names:
> -          maxItems: 3
> +        resets:
> +          maxItems: 2
> +        reset-names:
>            items:
> -            enum:
> -              - ssi.0
> -              - ssiu.0
> -              - clkin
> -    else:
> -      properties:
> +            - const: ssiu.0
> +            - const: ssi.0
> +        clocks:
> +          maxItems: 3
>          clock-names:
> -          minItems: 1
> -          maxItems: 31
>            items:
> -            oneOf:
> -              - const: ssi-all
> -              - pattern: '^ssi\.[0-9]$'
> -              - pattern: '^src\.[0-9]$'
> -              - pattern: '^mix\.[0-1]$'
> -              - pattern: '^ctu\.[0-1]$'
> -              - pattern: '^dvc\.[0-1]$'
> -              - pattern: '^clk_(a|b|c|i)$'
> +            - const: ssiu.0
> +            - const: ssi.0
> +            - const: clkin
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.25.1
> 

