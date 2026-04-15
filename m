Return-Path: <dmaengine+bounces-10022-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kADeBMf732ntbAAAu9opvQ
	(envelope-from <dmaengine+bounces-10022-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:57:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA66407C7E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A905307BD73
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB938C2A8;
	Wed, 15 Apr 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvrvxP8f"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB810785;
	Wed, 15 Apr 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286656; cv=none; b=apgzXLKnTz6NrMGalQ449Xu8FGs1DfEdPE26apA0/QKpv2kly3HNUMIhU+2T4MmRuNPqwV2FRGe1edVioJfoeWNW+h5JaZPTI9zh9Ij9zo92lo6ErrnPyN9txg5oGu+IDBxq7F1i8eur+Cx5rTcyDTyNs5IFWb+CalUGg5sd6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286656; c=relaxed/simple;
	bh=aqhppy8I9dR8UMYq5nQG0mjZqAyJaHAT6wJPHqTBjp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWYfR4IOHrQloeyxjlZQSG7CQhNBODEnZq2/3r7cu1nzBgaMipngklN3t+nq/mdaKe53MxR31HCXjwcgTw2fvyjnW09NORORgY/df4agtbohfMigSj4M0VEYhUyaoB1TWVrmHwjquxr9bsI1zGnlmnayCVuMHlWERDAcJE/BtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvrvxP8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D819DC19424;
	Wed, 15 Apr 2026 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776286656;
	bh=aqhppy8I9dR8UMYq5nQG0mjZqAyJaHAT6wJPHqTBjp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvrvxP8f3feyB84C54LUvSSbpisJTYNVytbYbS977fkWQ1Yn8/kU3888fH18CC2gc
	 CxsjSPfxa+Y0/rYs7Z0J0iD2iLR4iBAJfetB4POM2eLmN9IZhw8nwjXgFD3yB+0dFp
	 e/ejxw++syxZqhq4qQlhTuYue6ydk3c7yXcgopbPEFGFn+XZxGh9Xq8qAHDC0J1ChT
	 r64fQH4f529LG0zJkRJRBTsIS1bETKyTkSP/z/ftFUmYX1rFbT8YNJiRvLEqaumPoJ
	 CPbFIkzw+59fQaS6pTNsGG6xWCC6kiP13U+TAs7Xx9FU5gGJKOBwe7nds/T8y/Gfa9
	 9bM5ZsiCSnv7Q==
Date: Wed, 15 Apr 2026 15:57:33 -0500
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
Subject: Re: [PATCH v2 06/24] ASoC: dt-bindings: Add RZ/G3E (R9A09G047) sound
 binding
Message-ID: <20260415205733.GA354660-robh@kernel.org>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-7-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402090524.9137-7-john.madieu.xa@bp.renesas.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10022-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8CA66407C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:05:05AM +0200, John Madieu wrote:
> The RZ/G3E shares the same audio IP as the R-Car variants but differs
> in several aspects: it supports up to 5 DMA controllers per audio
> channel, requires additional clocks (47 total including per-SSI ADG
> clocks, SCU domain clocks and SSIF supply) and additional reset lines
> (14 total including SCU, ADG and Audio DMAC peri-peri resets).
> 
> Add a dedicated devicetree binding for the RZ/G3E sound controller.
> The binding references the common renesas,rsnd-common.yaml schema for
> shared property and subnode definitions.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v2: New patch
> 
>  .../sound/renesas,r9a09g047-sound.yaml        | 371 ++++++++++++++++++
>  1 file changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml b/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> new file mode 100644
> index 000000000000..1dfe9bab3382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> @@ -0,0 +1,371 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/renesas,r9a09g047-sound.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G3E Sound Controller
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +  - John Madieu <john.madieu.xa@bp.renesas.com>
> +
> +description:
> +  The RZ/G3E (R9A09G047) integrates an R-Car compatible sound controller
> +  with extended DMA channel support (up to 5 DMACs per direction), additional
> +  clock domains, and additional reset lines compared to the R-Car Gen2/Gen3
> +  variants.
> +
> +allOf:
> +  - $ref: renesas,rsnd-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a09g047-sound
> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: scu
> +      - const: adg
> +      - const: ssiu
> +      - const: ssi
> +      - const: audmapp
> +
> +  clocks:
> +    maxItems: 47
> +
> +  clock-names:
> +    items:
> +      - const: ssi-all
> +      - const: ssi.9
> +      - const: ssi.8
> +      - const: ssi.7
> +      - const: ssi.6
> +      - const: ssi.5
> +      - const: ssi.4
> +      - const: ssi.3
> +      - const: ssi.2
> +      - const: ssi.1
> +      - const: ssi.0
> +      - const: src.9
> +      - const: src.8
> +      - const: src.7
> +      - const: src.6
> +      - const: src.5
> +      - const: src.4
> +      - const: src.3
> +      - const: src.2
> +      - const: src.1
> +      - const: src.0
> +      - const: mix.1
> +      - const: mix.0
> +      - const: ctu.1
> +      - const: ctu.0
> +      - const: dvc.0
> +      - const: dvc.1
> +      - const: clk_a
> +      - const: clk_b
> +      - const: clk_c
> +      - const: clk_i
> +      - const: ssif_supply
> +      - const: scu
> +      - const: scu_x2
> +      - const: scu_supply
> +      - const: adg.ssi.9
> +      - const: adg.ssi.8
> +      - const: adg.ssi.7
> +      - const: adg.ssi.6
> +      - const: adg.ssi.5
> +      - const: adg.ssi.4
> +      - const: adg.ssi.3
> +      - const: adg.ssi.2
> +      - const: adg.ssi.1
> +      - const: adg.ssi.0
> +      - const: audmapp
> +      - const: adg
> +
> +  resets:
> +    maxItems: 14
> +
> +  reset-names:
> +    items:
> +      - const: ssi-all
> +      - const: ssi.9
> +      - const: ssi.8
> +      - const: ssi.7
> +      - const: ssi.6
> +      - const: ssi.5
> +      - const: ssi.4
> +      - const: ssi.3
> +      - const: ssi.2
> +      - const: ssi.1
> +      - const: ssi.0
> +      - const: scu
> +      - const: adg
> +      - const: audmapp
> +
> +  rcar_sound,dvc:
> +    description: DVC subnode.
> +    type: object

Move 'additionalProperties' here.

blank line after.

> +    patternProperties:
> +      "^dvc-[0-1]$":
> +        type: object
> +        additionalProperties: false

blank line

> +        properties:
> +          dmas:
> +            maxItems: 5

blank line

> +          dma-names:
> +            maxItems: 5
> +            allOf:

Don't need 'allOf'

> +              - items:
> +                  enum:
> +                    - tx

blank line

> +        required:
> +          - dmas
> +          - dma-names
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
> +          dmas:
> +            maxItems: 10
> +          dma-names:
> +            maxItems: 10
> +            allOf:
> +              - items:
> +                  enum:
> +                    - tx
> +                    - rx
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
> +          dmas:
> +            maxItems: 10
> +          dma-names:
> +            maxItems: 10
> +            allOf:
> +              - items:
> +                  enum:
> +                    - tx
> +                    - rx
> +        required:
> +          - dmas
> +          - dma-names
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names

Most of these are already required by the common schema. No need to 
duplicate.

> +
> +unevaluatedProperties: false

