Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF98274D61
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 01:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVXda (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 19:33:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38724 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXda (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Sep 2020 19:33:30 -0400
Received: by mail-io1-f66.google.com with SMTP id q4so12290934iop.5;
        Tue, 22 Sep 2020 16:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOD073YFkEuqWXn9WNz67EW80D+y9ARv2S5hPcoEdZM=;
        b=HzeMTTpT5y8T3KizRPYigNScDN5h3VUKNBFvvtCA1HUnZIjlDprtnI2+ljja1ARbZg
         zC1VOlAHVEyXulVUgmNPR1CdvK/cuF/xm9DrPN8sLEzyac90mqYNaMEbarGCp7/xlZe/
         JPKbVC/xDo932nCvmpcxbV5ZEuDo1lY+gcLmLnFzYzoLO+pYiikFg4O9cu+CgI19KRfZ
         m1g470LfMiYtxQ8kiKwJIMqNroyz6DfxMJ6Tbw40onqP8qCQZvFSUWtcH7FGZvq0xWpU
         aLYFLOEfIet6k2ZiJYMd9jY9K7pWZs+xT6w2nCuQUA9Yg5QujFgDC5ZWgb1P3vnLVO8O
         U85Q==
X-Gm-Message-State: AOAM531tV/DrjDgZwWb0AWUcnpM561jNbWoTeORY6f5r3z2Ed9qCjp5Q
        Okt0PHi6QhTQPKL0j5AV3g==
X-Google-Smtp-Source: ABdhPJz5blj1DQ3tggL5vJDaLWINJGBgevRqkv3eF0oNldHQMmuuWtoeWX5gSI9SZ+CCL3dV21eWeQ==
X-Received: by 2002:a02:cd0e:: with SMTP id g14mr6328316jaq.74.1600817609087;
        Tue, 22 Sep 2020 16:33:29 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c12sm9930706ili.48.2020.09.22.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:33:28 -0700 (PDT)
Received: (nullmailer pid 3476406 invoked by uid 1000);
        Tue, 22 Sep 2020 23:33:27 -0000
Date:   Tue, 22 Sep 2020 17:33:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     vkoul@kernel.org, tudor.ambarus@microchip.com,
        ludovic.desroches@microchip.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Message-ID: <20200922233327.GA3474555@bogus>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-7-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914140956.221432-7-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 14, 2020 at 05:09:55PM +0300, Eugen Hristev wrote:
> Add optional microchip,m2m property that specifies if a controller is
> dedicated to memory to memory operations only.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> index 510b7f25ba24..642da6b95a29 100644
> --- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> +++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> @@ -15,6 +15,12 @@ the dmas property of client devices.
>      interface identifier,
>      - bit 30-24: PERID, peripheral identifier.
>  
> +Optional properties:
> +- microchip,m2m: this controller is connected on AXI only to memory and it's
> +	dedicated to memory to memory DMA operations. If this option is
> +	missing, it's assumed that the DMA controller is connected to
> +	peripherals, thus it's a per2mem and mem2per.

Wouldn't 'dma-requests = <0>' cover this case?

Rob
