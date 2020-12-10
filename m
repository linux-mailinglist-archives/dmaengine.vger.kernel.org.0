Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9772D56EE
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgLJJWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 04:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgLJJWO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 10 Dec 2020 04:22:14 -0500
Date:   Thu, 10 Dec 2020 14:51:29 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607592094;
        bh=NEjX/XQuV4QW7NhH8UBOpBNE9o3C+o7ki3XfF/B8ou4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/lp3gNzzOaLKugO7qxUaGfwLHUDlOfacTuFpuXJJPA4jRZz2JGTTFqTzhUjuQ7oI
         3hh2H9AqYM+Rt0+Q6DhBsSZ0rhFE9iet6DI3JopR1tPhdjLJ9h1latICLiku5ZoC7G
         QTdLZqtAJZ7S03dDA6nMN7qj7m8BYRpecPVk+1gKbvrtbtkgAchmC4qyDNB2z5nHG9
         kktEWArWS4gcXVGLDXJ2R21kNo20eeP0dkfnd9OCZeTatHcK1fjDDt/R1gSqAQoAHf
         zGDuvqALupdmqwLLvFrXvJAN9Vp1boY7r2mDNT+k7m+VYz9EkRVPfBiaAigOCZaY5i
         wxPhzpIQkLyWg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Green Wan <green.wan@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: =?utf-8?Q?sf-pdma?=
 =?utf-8?Q?=3A_Reduce_scope_for_the_variable_=E2=80=9Cvd?= =?utf-8?B?4oCd?=
 in sf_pdma_desc_residue()
Message-ID: <20201210092129.GO8403@vkoul-mobl>
References: <8cd695d1-c081-1d95-de7b-9747e9a76de2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cd695d1-c081-1d95-de7b-9747e9a76de2@web.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-20, 21:00, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 9 Dec 2020 20:55:05 +0100
> 
> A local variable was used only within an else branch.
> Thus move the definition for the variable “vd” into the corresponding
> code block.
> 
> This issue was detected by using the Coccinelle software.

And what was the issue detected...?

I feel this is fine and patch below does not add much value..

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index c4c4e8575764..c66da79a1b34 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -164,7 +164,6 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
>  static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
>  				   dma_cookie_t cookie)
>  {
> -	struct virt_dma_desc *vd = NULL;
>  	struct pdma_regs *regs = &chan->regs;
>  	unsigned long flags;
>  	u64 residue = 0;
> @@ -180,7 +179,7 @@ static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
>  	if (cookie == tx->cookie) {
>  		residue = readq(regs->residue);
>  	} else {
> -		vd = vchan_find_desc(&chan->vchan, cookie);
> +		struct virt_dma_desc *vd = vchan_find_desc(&chan->vchan, cookie);
>  		if (!vd)
>  			goto out;
> 
> --
> 2.29.2

-- 
~Vinod
