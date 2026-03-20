Return-Path: <dmaengine+bounces-9553-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIcuJLETvWnG6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9553-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:30:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E04572D80AD
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29F593011506
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277843603F6;
	Fri, 20 Mar 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btdOSa/R"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B772E2850;
	Fri, 20 Mar 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998993; cv=none; b=psDYThbVxBMyLcAWD3QnocY6rTCDX7VOObkFfC3JY6k3qMkTW+1pkoVIfntNUCHADdVxLMWV5mJTBZcpQO1LTun1fr+oAnrgWVEi7+ghWcqlOcULCmECrvWqQN0j2PykIWOJ8ajg4+o2yYiDNxbZ7+oxic42+0jH1UMVxJWr9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998993; c=relaxed/simple;
	bh=LfFmVCPsvjpc+MzWiP7Uv1vwUKJcyLzLQ4f89tdstFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7Bf65HgPUVmktLlCienPUEmGaGqA9xaVyjBQTzmW8cliWWTBxDFgGoFsTprOXD/bncMNSxux2boRZrfzxLKMSCtkiNbBQjSgAAj+nhkaQltX7bJU7KN8byDZasOfIU29GQ83UUoJIWQdD0FJfQqxrBsTsI5DjF/HBB2I3co7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btdOSa/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9AC4CEF7;
	Fri, 20 Mar 2026 09:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773998992;
	bh=LfFmVCPsvjpc+MzWiP7Uv1vwUKJcyLzLQ4f89tdstFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btdOSa/RRTxID46FD+SM3Vu5F71uwvI4JsAhBN97H9RFqrroiS9Te5NeZv+Suce7g
	 FDqdgqs8SeJyLBQW2/0htwGiOcOcw0eHb9JmJvf6o2q9S/NKZ2MrHT6cufR6+HyMU7
	 5olUllZ40xuvL5/RYXTt2a4+HXmrcDMySr9SruCaiLDV8qvIBTVWcPElWFXWkgHDyC
	 qb7W/xXf4fEiXv08Fs49cdCl6CSpaaJWijiy3A5PtecB/vYGCiE/YEFD4bbNLT5p5s
	 DkS4hF1/cqMAxvd2CPsSiYq7am/6A8eSZeUTWMiyQMHjqp+rJCcshrD2X5P+2PspMz
	 y4xPC+IAxfrHw==
Date: Fri, 20 Mar 2026 10:29:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu <john.madieu@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 07/22] ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E support
Message-ID: <20260320-peculiar-cat-of-acumen-c6f6b3@quoll>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-8-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319155334.51278-8-john.madieu.xa@bp.renesas.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9553-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E04572D80AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:53:19PM +0100, John Madieu wrote:
> Add support for the RZ/G3E (R9A09G047) SoC audio subsystem.
> 
> RZ/G3E has a different audio architecture from R-Car Gen2/Gen3/Gen4,
> with additional clocks and resets:
> - Per-SSI ADG clocks (adg.ssi.0-9)
> - SCU related clocks (scu, scu_x2, scu_supply)
> - SSIF supply clock
> - AUDMAC peri-peri clock
> - ADG clock
> - Additional resets for SCU, ADG, and AUDMAC peri-peri
> 
> RZ/G3E has 5 DMA controllers that can all be used by audio peripherals.
> To allow the DMA core to distribute channels across all available
> controllers, increase the maximum number of DMA entries in DVC, SRC,
> and SSIU sub-nodes so that multiple providers can be listed with
> repeated channel names.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  .../bindings/sound/renesas,rsnd.yaml          | 169 +++++++++++++++---
>  1 file changed, 148 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> index e8a2acb92646..bc8885c4fa24 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> @@ -58,6 +58,7 @@ properties:
>            - renesas,rcar_sound-gen2
>            - renesas,rcar_sound-gen3
>            - renesas,rcar_sound-gen4
> +          - renesas,rcar_sound-r9a09g047     # RZ/G3E

Do not use underscores in compatibles. Previously used wrong style is
not the excuse here, just like previously poor code, mistakes, bugs,
unreadable approches is not justification to repeat the same.

>  
>    reg:
>      minItems: 1
> @@ -97,20 +98,22 @@ properties:
>  
>    resets:
>      minItems: 1
> -    maxItems: 11
> +    maxItems: 14
>  
>    reset-names:
>      minItems: 1
> -    maxItems: 11
> +    maxItems: 14
>  
>    clocks:
>      description: References to SSI/SRC/MIX/CTU/DVC/AUDIO_CLK clocks.
>      minItems: 1
> -    maxItems: 31
> +    maxItems: 47
>  
>    clock-names:
>      description: List of necessary clock names.
>      # details are defined below
> +    minItems: 1
> +    maxItems: 47
>  
>    # ports is below
>    port:
> @@ -136,9 +139,17 @@ properties:
>  
>          properties:
>            dmas:
> -            maxItems: 1
> +            description:
> +              Must contain unique DMA specifiers, one per available
> +              DMAC. On RZ/G3E, up to 5 for transmission.
> +            minItems: 1
> +            maxItems: 5
>            dma-names:
> -            const: tx
> +            minItems: 1
> +            maxItems: 5
> +            items:
> +              enum:
> +                - tx

Multiple levels, multiple if:then: (further) - I don't find this binding
manageable/readable. You should split it, with common binding defining
common part of hardware or interface if there is such.

Best regards,
Krzysztof


