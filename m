Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB867BD02D
	for <lists+dmaengine@lfdr.de>; Sun,  8 Oct 2023 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJHVFP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Oct 2023 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjJHVFP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 8 Oct 2023 17:05:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DDAC
        for <dmaengine@vger.kernel.org>; Sun,  8 Oct 2023 14:05:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-694ed847889so2831401b3a.2
        for <dmaengine@vger.kernel.org>; Sun, 08 Oct 2023 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696799113; x=1697403913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gxm93K6GGWMbjUtGXp1BZmgoqSMt/fikbA5J3YWvlU=;
        b=S2ejNuTm6W8bIEkFe3KjXWzRMN75Gy4bYtOi6KAeZGoOmPCfeba3AUcGaeMW21N6Qd
         Ucr2bEoKyv9ujkr8F2dNOso1rA/lXseMHrMt3WHWifHt0bpYV69qEpIYro9uq0mCxalf
         5MqJvjgs9C5wVov/SFGKFF5cbeQ+UAiPNAUGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696799113; x=1697403913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gxm93K6GGWMbjUtGXp1BZmgoqSMt/fikbA5J3YWvlU=;
        b=QcrgFBfTY5XVjpzYZzX79i3TS0znqXzFAJCcgBSJXpk7tgWe62roHJW6ZqZ/HklHIH
         yHPPfWmt0Gg+eQyAhjmMFExNQe5zgh1+JA2oNkdpr1U0xEvA2USNdQ9dxwOSe8dfcQ/Y
         v0n8ER48JRSHP+631++kip6THNkqFYMDglw7KPshmE/1kbNuUeezDvPmk42XDmnjM35H
         ZhTMV/vVOGlJU7i3zAZaeetyWDmZ4N67jInX1gx3dWfg213F9xB2Nz790+6iGUupoyT9
         0EvsiphzpCPXzZjOBeoKjO/tdW7oFXKyfy5OMDQMClgcp25+Cj1oMqiAI6RQPCF4PNjk
         7Bkg==
X-Gm-Message-State: AOJu0Yw1Tk/+DgQcsjhaToGbj+YH7+jQSuTPdPfqhRVr/2d1bmHhcowP
        gFUCOZb3RlKvt6R46XTh3ZbzOA==
X-Google-Smtp-Source: AGHT+IHXtwJV5QiOwEV9BS5g5BayCndoQLHqktCHa0OWTprxahWUvy7m6rsAL0Es1eBJ85IRithi+g==
X-Received: by 2002:a05:6a00:1d89:b0:68f:c6f8:144a with SMTP id z9-20020a056a001d8900b0068fc6f8144amr10953293pfw.22.1696799113111;
        Sun, 08 Oct 2023 14:05:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006934390d0c5sm5078353pfn.175.2023.10.08.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 14:05:12 -0700 (PDT)
Date:   Sun, 8 Oct 2023 14:05:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gustavoars@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] dmaengine: pxa_dma: Annotate struct pxad_desc_sw
 with __counted_by
Message-ID: <202310081404.382AE20@keescook>
References: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
 <1c9ef22826f449a3756bb13a83494e9fe3e0be8b.1696676782.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9ef22826f449a3756bb13a83494e9fe3e0be8b.1696676782.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Oct 07, 2023 at 01:13:10PM +0200, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> To do so, the code needs a little shuffling related to how hw_desc is used
> and nb_desc incremented.
> 
> The one by one increment is needed for the error handling path, calling
> pxad_free_desc(), to work correctly.
> 
> So, add a new intermediate variable, desc, to store the result of the
> dma_pool_alloc() call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks! Yeah, this looks like a sensible refactor to handle the
increment before array assignment without losing error checking.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>  drivers/dma/pxa_dma.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 94cef2905940..c6e2862896e3 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -91,7 +91,8 @@ struct pxad_desc_sw {
>  	bool			cyclic;
>  	struct dma_pool		*desc_pool;	/* Channel's used allocator */
>  
> -	struct pxad_desc_hw	*hw_desc[];	/* DMA coherent descriptors */
> +	struct pxad_desc_hw	*hw_desc[] __counted_by(nb_desc);
> +						/* DMA coherent descriptors */
>  };
>  
>  struct pxad_phy {
> @@ -739,6 +740,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  {
>  	struct pxad_desc_sw *sw_desc;
>  	dma_addr_t dma;
> +	void *desc;
>  	int i;
>  
>  	sw_desc = kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc),
> @@ -748,20 +750,21 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
>  	sw_desc->desc_pool = chan->desc_pool;
>  
>  	for (i = 0; i < nb_hw_desc; i++) {
> -		sw_desc->hw_desc[i] = dma_pool_alloc(sw_desc->desc_pool,
> -						     GFP_NOWAIT, &dma);
> -		if (!sw_desc->hw_desc[i]) {
> +		desc = dma_pool_alloc(sw_desc->desc_pool, GFP_NOWAIT, &dma);
> +		if (!desc) {
>  			dev_err(&chan->vc.chan.dev->device,
>  				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
>  				__func__, i, sw_desc->desc_pool);
>  			goto err;
>  		}
>  
> +		sw_desc->nb_desc++;
> +		sw_desc->hw_desc[i] = desc;
> +
>  		if (i == 0)
>  			sw_desc->first = dma;
>  		else
>  			sw_desc->hw_desc[i - 1]->ddadr = dma;
> -		sw_desc->nb_desc++;
>  	}
>  
>  	return sw_desc;
> -- 
> 2.34.1
> 

-- 
Kees Cook
