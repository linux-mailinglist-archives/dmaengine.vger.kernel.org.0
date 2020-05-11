Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3E1CD157
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 07:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEKFsM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 01:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgEKFsL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 01:48:11 -0400
Received: from sekiro (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDB120735;
        Mon, 11 May 2020 05:48:08 +0000 (UTC)
Date:   Mon, 11 May 2020 07:48:03 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: Replace zero-length array with
 flexible-array
Message-ID: <20200511054803.yrz4hc4y4z5vscpl@sekiro>
References: <20200507190046.GA15298@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190046.GA15298@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 07, 2020 at 02:00:46PM -0500, Gustavo A. R. Silva wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
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
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Ludovic Desroches<ludovic.desroches@microchip.com>

Ludovic Desroches
> ---
>  drivers/dma/at_xdmac.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index bb0eaf38b594..fd92f048c491 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -212,7 +212,7 @@ struct at_xdmac {
>         struct clk              *clk;
>         u32                     save_gim;
>         struct dma_pool         *at_xdmac_desc_pool;
> -       struct at_xdmac_chan    chan[0];
> +       struct at_xdmac_chan    chan[];
>  };
> 
> 
> 
