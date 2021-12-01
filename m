Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37B46596F
	for <lists+dmaengine@lfdr.de>; Wed,  1 Dec 2021 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbhLAWrl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Dec 2021 17:47:41 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37511 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLAWrk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Dec 2021 17:47:40 -0500
Received: by mail-oi1-f181.google.com with SMTP id bj13so51732649oib.4;
        Wed, 01 Dec 2021 14:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqKUtZJX4tXxx+oJx6C8tcKALFqT3uMmXHIm9HsFR8Y=;
        b=4uXqIznbO1B6lXMy0LV+lnwWlpvmhZ5hG7yL851fkRdiE4mEVi/JeJgC6r1LE1mv1M
         UzVFhiTAcvlRtNuDhJBqW5GwrrhCHM7+I62AVTUZI4c/pWbFDVtd3DmuXcq2pbINmIJb
         bhmBuelVq3YqsoXPKm03ViltFX8gPP3C5D8gQDuU7B3l2XfvAWfNcCB6XNVIXq0ZsoSc
         QyLkkjsnE5iIlrtZn2NQr4AfWeh7g8AN90TbnyqE2cJHKOkZ5PMHSSIEUATILacuYYt1
         b4XukfxZKXrlVkORcP/LAvJy0neGbZwrujBsmV3WTNJjGSg/2rObuSyMHy84dw6r37ic
         Oa9Q==
X-Gm-Message-State: AOAM531ay62Khn+LKD/QWnEXufkmYVxllmAwDRdUdgDshJ/KVOYRoEaE
        TgjJduXBKsoGov6ss5/VXYFDMyQz/A==
X-Google-Smtp-Source: ABdhPJwQqt0ub7u+H3TupNo5RseLvfhhE3mV6JcyZK15RQHiXRR0VCUNnvPoyZy+pqhmn1eeJkrfAw==
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr1214031oiv.19.1638398659180;
        Wed, 01 Dec 2021 14:44:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r3sm421239oti.51.2021.12.01.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:44:18 -0800 (PST)
Received: (nullmailer pid 2964857 invoked by uid 1000);
        Wed, 01 Dec 2021 22:44:17 -0000
Date:   Wed, 1 Dec 2021 16:44:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heng Sia <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Group tuples in snps
 properties
Message-ID: <Yaf6wa5tyO/oCCeK@robh.at.kernel.org>
References: <20211125151918.162446-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125151918.162446-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 25, 2021 at 04:19:18PM +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "snps,block-size" and "snps,priority" properties should be grouped
> using angle brackets.

For these, the tools should allow either way. Where are you seeing an 
error?

I tried to rationalize which way should be 'correct' and gave up. I 
think bracketing only makes sense for matrix and phandle+arg cases.

> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 79e241498e2532ce..90d9274e5464e396 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -120,7 +120,7 @@ examples:
>           dma-channels = <4>;
>           snps,dma-masters = <2>;
>           snps,data-width = <3>;
> -         snps,block-size = <4096 4096 4096 4096>;
> -         snps,priority = <0 1 2 3>;
> +         snps,block-size = <4096>, <4096>, <4096>, <4096>;
> +         snps,priority = <0>, <1>, <2>, <3>;
>           snps,axi-max-burst-len = <16>;
>       };
> -- 
> 2.25.1
> 
> 
