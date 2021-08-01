Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58973DCA54
	for <lists+dmaengine@lfdr.de>; Sun,  1 Aug 2021 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhHAG17 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 1 Aug 2021 02:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhHAG16 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 1 Aug 2021 02:27:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A70061057;
        Sun,  1 Aug 2021 06:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627799270;
        bh=2PHY9JhVD/YwlHDPKNMJfQk6cWOpOdiuFnlPIR1Cyco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMQuE1xbZE1JJWZGWWPuMZ/Fex6D/H6joQKK92I03ggzjSYiFMjisUA7zElyV8ziB
         /Sd5sVOJWdRrWhw639yl86nLzowtIQOYOQE+6TZn42QrN9j2JZg5UsgYsKFg/HXD2m
         qv77iiTKxi+5rRW+KDRNDHbP31NthSL+kzW0w848=
Date:   Sun, 1 Aug 2021 08:27:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: usb-dmac: make usb_dmac_get_current_residue
 unsigned
Message-ID: <YQY+5OaQKYeWQ+/n@kroah.com>
References: <20210731091939.510816-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731091939.510816-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jul 31, 2021 at 11:19:38AM +0200, Jordy Zomer wrote:
> The usb_dmac_get_current_residue function used to
> take a signed integer as a pos parameter.
> The only callers of this function passes an unsigned integer to it.
> Therefore to make it obviously safe, let's just make this an unsgined
> integer as this is used in pointer arithmetics.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/dma/sh/usb-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index 8f7ceb698226..a5e225c15730 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -466,7 +466,7 @@ static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
>  
>  static unsigned int usb_dmac_get_current_residue(struct usb_dmac_chan *chan,
>  						 struct usb_dmac_desc *desc,
> -						 int sg_index)
> +						 unsigned int sg_index)
>  {
>  	struct usb_dmac_sg *sg = desc->sg + sg_index;
>  	u32 mem_addr = sg->mem_addr & 0xffffffff;
> -- 
> 2.27.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
