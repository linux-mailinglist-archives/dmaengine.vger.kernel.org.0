Return-Path: <dmaengine+bounces-1150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6086B3BA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0ED128B89C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F415CD5D;
	Wed, 28 Feb 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyAE0/Wu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FD1552F8;
	Wed, 28 Feb 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135475; cv=none; b=ndByAyrv1VhwLbyiszy4VLQRQUvYlP6Rn1+P9ol76zpRAv0qIGxa5prB+OWlEPg7WTIDt7JohXv3fJJE27L7DRzi6v0xbsnxTW9jqpVFO0l/Rg0qWignqs3g2EAwBrRqjlj+chLGX5XYoKAviHma4PC1+thReBrSBByxdKMK1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135475; c=relaxed/simple;
	bh=bBANsiX1oqnfELIhJ2Ldb94oj+2VzQup9IpDxs0eqNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYBP2pCt7YDu1QXovGj5wov9YnabGCl6r1DkSmyKQdWt4vGxoIYZPWqbWzUJxIZVejLqpebEVZ+2VCiXBQN8uAQW0sXD4+uJ1Z5Qmzb+bJ7Kq/MQ1I+gHtwTjUL9otkxCKkWTX8QxPdNJEU+XUKV9Fj++iK5RBs2G+KGgotK4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyAE0/Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04038C433C7;
	Wed, 28 Feb 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709135475;
	bh=bBANsiX1oqnfELIhJ2Ldb94oj+2VzQup9IpDxs0eqNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyAE0/WuLiyanl4AqhvdmoyyCs6ZyNSZ7MlqNMRQ5+1IIOffTm+eRgtri2sd4+agA
	 S0jcKZcceEDROliTshY9ZBYADM2jMCpCf7wMwt6Vx5tNXUmhtlB77aMHxihfG7HyWo
	 c1zJ/pwFSjLzL1hAT+lSzVv04nlummiIM5VUBzmQf/AMtYEpY+coMS7LAHH9bSRelg
	 XKsCvVm/XYCPEKtm9Zry30vkB2cA+s2MWEOvwzBMPsq6Da8wMXnI82sy14QsDzG147
	 Ep2zWHqwrFN5Rf38qfZqFtSLM3vODS7ClRt8v9wFejRW8w8KfAVDUjPwO2JXV7FFRQ
	 uNJAHrnwhI7AQ==
Date: Wed, 28 Feb 2024 09:51:12 -0600
From: Rob Herring <robh@kernel.org>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: crypto: starfive: Add jh8100 support
Message-ID: <20240228155112.GA4059153-robh@kernel.org>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
 <20240227163758.198133-2-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227163758.198133-2-jiajie.ho@starfivetech.com>

On Wed, Feb 28, 2024 at 12:37:53AM +0800, Jia Jie Ho wrote:
> Add compatible string and additional interrupt for StarFive JH8100
> crypto engine.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  .../crypto/starfive,jh7110-crypto.yaml        | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> index 71a2876bd6e4..d44d77908966 100644
> --- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> @@ -12,7 +12,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: starfive,jh7110-crypto
> +    enum:
> +      - starfive,jh8100-crypto
> +      - starfive,jh7110-crypto
>  
>    reg:
>      maxItems: 1
> @@ -28,7 +30,10 @@ properties:
>        - const: ahb
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: SHA2 module irq
> +      - description: SM3 module irq
>  
>    resets:
>      maxItems: 1
> @@ -54,6 +59,27 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: starfive,jh7110-crypto
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: starfive,jh8100-crypto
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2

This is already the max. Don't you want 'minItems: 2'?

> +
>  examples:
>    - |
>      crypto: crypto@16000000 {
> -- 
> 2.34.1
> 

