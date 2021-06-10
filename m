Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3340D3A21EC
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jun 2021 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJBku (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 21:40:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33894 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBku (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Jun 2021 21:40:50 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 943DA8A2;
        Thu, 10 Jun 2021 03:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623289133;
        bh=yqpHWZPanjkC+V9yvODkHojqHp3PntAQ434IwkjrduM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZNBT8CDKmhWq5cKGb3SHMOG5gszAfxe0XtLk6Wo7lVNi70RuY9TvK2QpWtgZ1nRH
         D6T9KUrJtNCgWdqCpoaVFXVsaCTZM+Zp1wVyZjlQH71nyGToUpOxi74t2yetS/p5Kc
         DxCca1Z28Wn1wvjNYmofmVM0reUIVR9mfjTTkXYg=
Date:   Thu, 10 Jun 2021 04:38:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hyun.kwon@xilinx.com, vkoul@kernel.org, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: xilinx: dpdma: fix kernel-doc
Message-ID: <YMFtGqicAMoZ0LOV@pendragon.ideasonboard.com>
References: <1623222893-123227-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1623222893-123227-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Yang Li,

Thank you for the patch.

On Wed, Jun 09, 2021 at 03:14:53PM +0800, Yang Li wrote:
> Fix function name in xilinx/xilinx_dpdma.c comment to remove 
> a warning found by kernel-doc.
> 
> drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
> xilinx_dpdma_chan_no_ostand(). Prototype was for
> xilinx_dpdma_chan_notify_no_ostand() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Change in v2:
> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
> https://lore.kernel.org/patchwork/patch/1442639/
> 
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 70b29bd..0c8739a 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
>  }
>  
>  /**
> - * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
> + * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
>   * @chan: DPDMA channel
>   *
>   * Notify waiters for no outstanding event, so waiters can stop the channel

-- 
Regards,

Laurent Pinchart
