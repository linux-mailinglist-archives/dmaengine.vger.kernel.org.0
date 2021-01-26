Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F8304BC0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbhAZVvY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbhAZRQV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:16:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7B6420829;
        Tue, 26 Jan 2021 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681340;
        bh=CNUsfkSJIRFb1fE4bIdw+xuP6VYc/2fRsDn+vBfaKrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N26+U4iQTOHQVlPVSltiH0hTBsB7Gtl5RYJf58GdThDounY/UXHWx+GvEW0EUqwcx
         7gGOeTubf7/L7EmyjAznggYB5r1LFGvCGebNQVGV0yIbcGw6PGLlqY3IH7lWzCmGId
         e9F2JmSef+GandQvMhNhbGUqQZEZa7kMTSkJLvxbcS0b7d7mUhwNRuGa9h9C7iCEr2
         AFuZmBg8BPVQxuTxv5LLSAaDGrzQyR04Ki6uXk5wFKqI5BGnkivMI8IzEUfrGyXKQ4
         YsguA+PMY1EhYJX+rq52E00pJk6I/uBWS8QvVMiF2MfElXnpNbvcVbBuCIerpAEaHv
         qsm3C+VFx6PmQ==
Date:   Tue, 26 Jan 2021 22:45:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: ingenic: Add compatible strings
 for JZ4760(B) SoCs
Message-ID: <20210126171536.GR2771@vkoul-mobl>
References: <20210120105322.16116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120105322.16116-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-01-21, 10:53, Paul Cercueil wrote:
> Add ingenic,jz4760-dma and ingenic,jz4760b-dma compatible strings to
> support the DMA engines present in the JZ4760 and JZ4760B SoCs.

Applied, thanks

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> index 6a2043721b95..ac4d59494fc8 100644
> --- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> @@ -17,6 +17,8 @@ properties:
>      enum:
>        - ingenic,jz4740-dma
>        - ingenic,jz4725b-dma
> +      - ingenic,jz4760-dma
> +      - ingenic,jz4760b-dma
>        - ingenic,jz4770-dma
>        - ingenic,jz4780-dma
>        - ingenic,x1000-dma
> -- 
> 2.29.2

-- 
~Vinod
