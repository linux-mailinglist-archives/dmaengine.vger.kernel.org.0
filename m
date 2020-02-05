Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24161525B8
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 05:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBEE5G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 23:57:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41463 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBEE5G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 23:57:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so927462eds.8;
        Tue, 04 Feb 2020 20:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCEeJD0oPt/cyzPGhF5uF/YpWpW9XVqpjLag5G1/XFc=;
        b=Hv1fXXF32hvj7LYLlq2qPkonws7uAXVX+JzLHRKk/YhcjNzL+e6tCsjNpLKjBmGJLW
         DLLMfdNwwD/0OPOAZ4pUvhP8I1XVo7v6+iSEugDMzM2WBU9hj1Xc9Qjn9F+jR6GXOEOL
         jymYUw+GNbAK5j0W4HHS7jSEjca/FDp4guwxKv6RFQy27Qa4m8gGEQNR8mGIpjTb3bTr
         LYG6usIM4me2OYQl+Y/sUACANTLVZrscSJYLDt8LJcEs5kD6ZhS9S6e8GQIU7fzGdx2i
         E0q8vUNAjFtEuCmUry+x3qi4qgvcqfIOl5Nk7ZJmrLMhACc74P/1k0AoECxpvWAA1HA0
         22ZA==
X-Gm-Message-State: APjAAAUsomYpFMKl5VW2F5T8/xsTn34QORqSwnZAeHzkaHK0klAywEhQ
        C4XB0f8MC/KX6FTCpUcNOL5FhB2adpM=
X-Google-Smtp-Source: APXvYqzZvg2g+5sZ0P6JCpNVatD29o3L5Vs2eUn4du8DylTbX/kBvFuqQQMzUJhkXTdsjwTsziKzdA==
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr3350267edv.236.1580878624510;
        Tue, 04 Feb 2020 20:57:04 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id ck19sm1609324ejb.48.2020.02.04.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 20:57:04 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id z9so948561wrs.10;
        Tue, 04 Feb 2020 20:57:04 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr26015369wrs.365.1580878623767;
 Tue, 04 Feb 2020 20:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20200205044247.32496-1-yuehaibing@huawei.com>
In-Reply-To: <20200205044247.32496-1-yuehaibing@huawei.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 5 Feb 2020 12:56:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v67gzb+8vR=6jQKX07pcARUqBHeburNWM9tqzqhfTnodGg@mail.gmail.com>
Message-ID: <CAGb2v67gzb+8vR=6jQKX07pcARUqBHeburNWM9tqzqhfTnodGg@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: sun4i: remove set but unused variable 'linear_mode'
To:     YueHaibing <yuehaibing@huawei.com>,
        Stefan Mavrodiev <stefan@olimex.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, Feb 5, 2020 at 12:43 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/dma/sun4i-dma.c: In function sun4i_dma_prep_dma_cyclic:
> drivers/dma/sun4i-dma.c:672:24: warning:
>  variable linear_mode set but not used [-Wunused-but-set-variable]
>
> commit ffc079a4accc ("dmaengine: sun4i: Add support for cyclic requests with dedicated DMA")
> involved this unused variable.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/sun4i-dma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index bbc2bda..501cd44 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -669,7 +669,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>         dma_addr_t src, dest;
>         u32 endpoints;
>         int nr_periods, offset, plength, i;
> -       u8 ram_type, io_mode, linear_mode;
> +       u8 ram_type, io_mode;
>
>         if (!is_slave_direction(dir)) {
>                 dev_err(chan2dev(chan), "Invalid DMA direction\n");
> @@ -684,11 +684,9 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>
>         if (vchan->is_dedicated) {
>                 io_mode = SUN4I_DDMA_ADDR_MODE_IO;
> -               linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
>                 ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
>         } else {
>                 io_mode = SUN4I_NDMA_ADDR_MODE_IO;
> -               linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
>                 ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
>         }

I think it's better to actually use these values later when composing
the value for `endpoints`, as we do in sun4i_dma_prep_slave_sg().

The code currently works because SUN4I_DDMA_ADDR_MODE_LINEAR == 0.
However explicitly using the value makes the code more readable,
and doesn't require the reader to have implicit knowledge of default
values for parameters not specified in the composition of `endpoints`.

ChenYu
