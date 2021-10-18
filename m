Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08275431088
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJRGax (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhJRGax (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C1BC610A6;
        Mon, 18 Oct 2021 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634538522;
        bh=KaJW2C05NuSoGJsMWHo1icknCRLExC6rgqhz+K0yhTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIm8scMJlm0Gr3qcmlO53p34g3Au6hUzdjqwpwvm83bsqOWNHGwcuNOz6G6t+JIRN
         ES36EvMPr6cFgYeDxZk/BV3rI9HE8nHOAjaxrUE8mKxJe0f/MgdouyMh0bVkUWJuUq
         sLoxhgNyovZ/SwyEREfm7EmhIziY0CwlpY38vm81gjeCvbZTiUkuI/9IQuPvfc/eOD
         2dGCdQrUhgj1717un/0v1D5IyEzhCS2o0ZADryES/Jfw9ptxSjPPChN5xVDvhN+FxC
         6iD9woTaskGwNTwqH01dh05zwjYG8wh4te45KKlPqqvizobXTF9+eDFXym06zxbHKn
         PqXB45e9Bfr4Q==
Date:   Mon, 18 Oct 2021 11:58:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, list@opendingux.net,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: dma: ingenic: Support #dma-cells = <3>
Message-ID: <YW0UFWWNuYNEC8y+@matsya>
References: <20211011143652.51976-1-paul@crapouillou.net>
 <20211011143652.51976-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011143652.51976-3-paul@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-10-21, 16:36, Paul Cercueil wrote:
> Extend the binding to support specifying a different request type for
> each direction.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> index f45fd5235879..51b41e4795a2 100644
> --- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> @@ -44,13 +44,17 @@ properties:
>      maxItems: 1
>  
>    "#dma-cells":
> -    const: 2
> +    enum: [2, 3]
>      description: >
>        DMA clients must use the format described in dma.txt, giving a phandle
> -      to the DMA controller plus the following 2 integer cells:
> +      to the DMA controller plus the following integer cells:
>  
>        - Request type: The DMA request type for transfers to/from the
>          device on the allocated channel, as defined in the SoC documentation.
> +        If "#dma-cells" is 2, the request type is a single cell. If
> +        "#dma-cells" is 3, the request type has two cells; the first one
> +        corresponds to the host to device direction, the second one corresponds
> +        to the device to host direction.

Why would you need the direction here, that should be a runtime
parameter and not a DT one?

>  
>        - Channel: If set to 0xffffffff, any available channel will be allocated
>          for the client. Otherwise, the exact channel specified will be used.
> -- 
> 2.33.0

-- 
~Vinod
