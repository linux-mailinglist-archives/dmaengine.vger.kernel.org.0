Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C00161E91
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2020 02:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgBRBep (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Feb 2020 20:34:45 -0500
Received: from condef-09.nifty.com ([202.248.20.74]:56158 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgBRBep (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Feb 2020 20:34:45 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 20:34:43 EST
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-09.nifty.com with ESMTP id 01I1QQFF025679
        for <dmaengine@vger.kernel.org>; Tue, 18 Feb 2020 10:26:26 +0900
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 01I1QD7N019766;
        Tue, 18 Feb 2020 10:26:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01I1QD7N019766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581989173;
        bh=DFo5bZ5Bm4QsGsx8r/W+4n6QGw47HateZtKF1IqGjK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jp8Y9Unk0X+nZxx/4xNp0bdyquwZdI2uguxEiL1thKibD01TDUQchfpR8tzH9qo54
         ebqsDP1nPj2QrD86PyvvbtgtDZ8+GiPD1y5RNNa6TGQb56nqw213MaBrl/ua5uUOxU
         5DgFbeS7eoU+ayS6eMsbL5jSguqEf93I5A31J7oZ1wYAGR5ojC7dKyrDGv00Cngfqv
         iT2QgcdCBSG0oK5tLSXvBgDlhX0dsPlOMUfK8JtSI8F5ZV+NyZIQxGvqxdkZit3/wz
         E3LUSTLD5c77SzuZHnSt3ucM4iXEOsnInbp7Gg7ExPHJF4YNry6LYvdUFi/EjL6m5E
         7JX8AjBphg6hQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id b79so11619638vsd.9;
        Mon, 17 Feb 2020 17:26:13 -0800 (PST)
X-Gm-Message-State: APjAAAXDw3l+2liVfeoZoOSWVq0aQOuWwLZcHtyuN26YGAH5hwNeh+Lo
        fk08zvlMAvRr8imthlwwaLkWMfoNfS1LlR46Lmo=
X-Google-Smtp-Source: APXvYqxSiKTUTozFX1mDbJzMmvg2TfqQRp6FqoGdjnaYvvmSAf4Wg9j1N4gyQ+nadCxh2KhQZghaCZKnVejvMtBs3tE=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr9552896vsq.215.1581989172430;
 Mon, 17 Feb 2020 17:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20200213003535.GA3269@embeddedor.com>
In-Reply-To: <20200213003535.GA3269@embeddedor.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 18 Feb 2020 10:25:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8TomJow4_3T++3u+eo=KhRMP9V5X=urWNRPUE93NOvQ@mail.gmail.com>
Message-ID: <CAK7LNAS8TomJow4_3T++3u+eo=KhRMP9V5X=urWNRPUE93NOvQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: uniphier-mdmac: replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Feb 13, 2020 at 9:35 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
>  drivers/dma/uniphier-mdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
> index 21b8f1131d55..618839df0748 100644
> --- a/drivers/dma/uniphier-mdmac.c
> +++ b/drivers/dma/uniphier-mdmac.c
> @@ -68,7 +68,7 @@ struct uniphier_mdmac_device {
>         struct dma_device ddev;
>         struct clk *clk;
>         void __iomem *reg_base;
> -       struct uniphier_mdmac_chan channels[0];
> +       struct uniphier_mdmac_chan channels[];
>  };
>
>  static struct uniphier_mdmac_chan *
> --
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
