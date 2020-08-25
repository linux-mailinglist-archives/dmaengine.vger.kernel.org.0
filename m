Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477525172A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgHYLLq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYLLp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:11:45 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A77720715;
        Tue, 25 Aug 2020 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598353905;
        bh=WKdpRjvr2lVA/6uzvF7Jb5gbSH6uAY1poBfBKan1cIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhWp0CohVCHtW4Ji7VHSo96UCTBBHdCuZBuiA6TWH76EuachWVoq0peC8FDm5YNS7
         8Rju/tdXxCWRuIR/Ux3usQ7ReYUtRUDcRSRXiQQGKTMUlAwqKvO29gPGctGe3pGIsX
         rF5bTSCTTjt37Dbwew5WC2WJopTBsMkYWyj23bTI=
Date:   Tue, 25 Aug 2020 16:41:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: Re: [PATCH] dmaengine: pl330: fix instruction dump formatting
Message-ID: <20200825111141.GK2639@vkoul-mobl>
References: <CGME20200813204151eucas1p1c64a0880ba83013f87d0ca41242e533a@eucas1p1.samsung.com>
 <20200813204123.19044-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813204123.19044-1-l.stelmach@samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-08-20, 22:41, Łukasz Stelmach wrote:
> Instruction dump uses two printk() in a row to print one instruction. Use
> KERN_CONT to prevent breaking the output in the middle.

Applied, thanks

> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/dma/pl330.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 88b884cbb7c1..e1af6a470453 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -254,7 +254,7 @@ enum pl330_byteswap {
>  static unsigned cmd_line;
>  #define PL330_DBGCMD_DUMP(off, x...)	do { \
>  						printk("%x:", cmd_line); \
> -						printk(x); \
> +						printk(KERN_CONT x); \
>  						cmd_line += off; \
>  					} while (0)
>  #define PL330_DBGMC_START(addr)		(cmd_line = addr)
> -- 
> 2.26.2

-- 
~Vinod
