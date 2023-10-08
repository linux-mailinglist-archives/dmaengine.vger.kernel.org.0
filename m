Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6587BD02B
	for <lists+dmaengine@lfdr.de>; Sun,  8 Oct 2023 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjJHVD3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Oct 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjJHVD3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 8 Oct 2023 17:03:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA6B6
        for <dmaengine@vger.kernel.org>; Sun,  8 Oct 2023 14:03:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692d2e8c003so3610681b3a.1
        for <dmaengine@vger.kernel.org>; Sun, 08 Oct 2023 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696799005; x=1697403805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRUv/QSnced096nWx46ar50Ge+209xa4Pte75ck/B5M=;
        b=PGsSrWpA+Q8LDgUPJueSS7HqZvqN8DBOn/f4CnZhK8yY8f/8HVCNvUfvao/NCHzdIA
         wTSUmiee/zicfbkXQTabt6xFmXlMBhftyPWxOW3jZsnHrrevZa2wu7VDICYN/hEq9xpK
         RgUGjlf/31Bw92oUxoOreAPIsozMlO1JaYg50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696799005; x=1697403805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRUv/QSnced096nWx46ar50Ge+209xa4Pte75ck/B5M=;
        b=nMmI96AqyplPBIaeJRifwsPN3Vau9sJWAaSyGPKmv2by3AcKc6zC5oNRYDZtMZ3lgm
         bl7XWck90/WTFoaMkFmqjeVqKE+eCA5GwUHDvlAoDGApj2CIUs22/9EsXyKQ9ahDjvzd
         Y+94aZfQB07I6VSxAeileKdfL7/EVXLlkdk/1eBt6aEQ9XFNu5GCVce4ro2qKW6NtD/4
         VRYK9a+wSo0r7lkoO946NiTIhutzhGhzMG8yyasj9LbeobJIzlQ6jDmmsqHFMLJAK6Co
         +w3+u7yfiYqnay0DyDE15xVDvU3g+eeShjEFLS40Ns55POZbyYcU9lOamysChjxsJyHe
         Wa7w==
X-Gm-Message-State: AOJu0YwHWNZeQqdfbg7fVJNmQHLf1HMfsrZ9RwRQwpZVQ3deXM5/rfy0
        /l5XPPP4XFbcwMxSRz8gX9Ma+A==
X-Google-Smtp-Source: AGHT+IFQUzzmkCoYCWTxyoFQmDoMV6Gdvkd7UGx7JIod6TwuwuTa6MBHAwHgMCrHziMMoNMDAaAD3A==
X-Received: by 2002:a17:902:ec90:b0:1c7:27a1:a9e5 with SMTP id x16-20020a170902ec9000b001c727a1a9e5mr17488409plg.33.1696799005512;
        Sun, 08 Oct 2023 14:03:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001bc18e579aesm7868134pll.101.2023.10.08.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 14:03:24 -0700 (PDT)
Date:   Sun, 8 Oct 2023 14:03:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gustavoars@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in
 pxad_free_desc()
Message-ID: <202310081402.A9A8C49@keescook>
References: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Oct 07, 2023 at 01:13:09PM +0200, Christophe JAILLET wrote:
> If pxad_alloc_desc() fails on the first dma_pool_alloc() call, then
> sw_desc->nb_desc is zero.
> In such a case pxad_free_desc() is called and it will BUG_ON().
> 
> Remove this erroneous BUG_ON().

Perhaps it could be changed to a WARN_ON()?

> It is also useless, because if "sw_desc->nb_desc == 0", then, on the first
> iteration of the for loop, i is -1 and the loop will not be executed.
> (both i and sw_desc->nb_desc are 'int')

Agreed.

> 
> Fixes: a57e16cf0333 ("dmaengine: pxa: add pxa dmaengine driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/pxa_dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 3c574dc0613b..94cef2905940 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -722,7 +722,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
>  	dma_addr_t dma;
>  	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
>  
> -	BUG_ON(sw_desc->nb_desc == 0);
>  	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
>  		if (i > 0)
>  			dma = sw_desc->hw_desc[i - 1]->ddadr;
> -- 
> 2.34.1
> 

-- 
Kees Cook
