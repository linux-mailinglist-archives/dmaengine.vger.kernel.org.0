Return-Path: <dmaengine+bounces-9551-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOeVG+oPvWlf6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9551-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:14:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9E2D7D36
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA603012245
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F937DE80;
	Fri, 20 Mar 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT+O+ydk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9930B50A;
	Fri, 20 Mar 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997976; cv=none; b=OcNzDE2xI04Zu1s5BhNIKVjL7Yi17r8/YUUxtwUoyQgBhN13jswzPXMQvwcQvgY7hfxwXtmtcKtb04QBeNUgqvwFRQVnXteBS7iTVy0MhC+YlVWP9QMBuzhNN3JE3Dj1p9SfV9BAKeXL4k+K6x+rDaSMV25K9bHdK4ZEaREfz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997976; c=relaxed/simple;
	bh=eCK0dEmHKu71hb3Dx847pAiVP184hX3MEz6AOGBp5mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqCHRB6uBx+lZJNWGH7kada8H1L96yE0L/h/BqFuJDXoJDEkuojWkqGsGYybmllWgknve1cOHIPIQvpBqsonjKuOHDCkuwzxl1/cHS+GDjlmYWztb3LCysTL/BXT4jMGW/xOirAe1a42Tyhiihq41M6ui7oc1aZcizk/6LlAmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT+O+ydk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02516C4CEF7;
	Fri, 20 Mar 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997975;
	bh=eCK0dEmHKu71hb3Dx847pAiVP184hX3MEz6AOGBp5mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PT+O+ydkF5j+137rY6WJz4keuhBPTfc0t6ixXD+/1zrq9NEbi2tyARuqViWybHPcN
	 NBgzqaW4GERsWeEpcYEhw9x65T6wiiFK3wNQzF+GZ2xeOZXsvnMoCc/Y7Ml/eS2BTb
	 Q/PL3L+zYlQ2S7b3ytyp0zc175a4R0QcmmacBIEjB17ov+A6r637aUlrFUgJG/iUXq
	 UF62WWdmuOS5Kkfd6GIoSnJove6T2j/SNMPMms5fSVSmMkb+f+zueNUOyqNi6eaoao
	 6eZKz610mHNbIORhOZkE+u3w2NjMljrw2zngu5wMrhBNereJeOQ+D6+s+nePRUwEVA
	 3Q9qMM+EvPpTA==
Date: Fri, 20 Mar 2026 10:12:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com, 
	schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic
 and combined IRQ topologies
Message-ID: <20260320-vengeful-violet-cockle-382580@quoll>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319101723.246539-2-jun.guo@cixtech.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9551-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CEA9E2D7D36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
> Update the DMA-350 DT binding to match the current driver behavior.
> 
> Allow both:
> - "arm,dma-350" as the generic compatible, and
> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
> 
> Also document interrupt topology variants supported by hardware
> integration:
> - one combined interrupt for all channels, or
> - one interrupt per channel (up to 8 channels).
> 
> This patch is Assisted-by: Cursor: GPT-5.3 Codex.

Wrong tag, please read carefully the guideline before using LLM tools.

> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> Link: https://lore.kernel.org/r/20251216123026.3519923-2-jun.guo@cixtech.com

What does this express? Changelog link? Then keep it in the changelog
--- part.


> ---
>  .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> index 429f682f15d8..3639ce0d5054 100644
> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> @@ -14,7 +14,11 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: arm,dma-350
> +    oneOf:
> +      - const: arm,dma-350
> +      - items:
> +          - const: cix,sky1-dma-350
> +          - const: arm,dma-350
>  
>    reg:
>      items:
> @@ -22,15 +26,22 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    items:
> -      - description: Channel 0 interrupt
> -      - description: Channel 1 interrupt
> -      - description: Channel 2 interrupt
> -      - description: Channel 3 interrupt
> -      - description: Channel 4 interrupt
> -      - description: Channel 5 interrupt
> -      - description: Channel 6 interrupt
> -      - description: Channel 7 interrupt
> +    maxItems: 8
> +    description: |
> +      The DMA controller may be configured with separate interrupts for each channel,
> +      or with a single combined interrupt for all channels, depending on the SoC integration.

And more important - you must review the LLM microslop output before
posting and adjust it to Linux kernel coding style. Don't send
unredacted tool output.

Best regards,
Krzysztof


