Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE82298FE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jul 2020 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGVNL1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jul 2020 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGVNL0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jul 2020 09:11:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C5C0619DC
        for <dmaengine@vger.kernel.org>; Wed, 22 Jul 2020 06:11:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88AB2329;
        Wed, 22 Jul 2020 15:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595423484;
        bh=kr9N00y+EQHY8A4LXaUz98sAo14jrO502LY8+9/o33U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jx65ir6mazFneg9pBBigVvtz89bAGexGonp+Oc5SElETKQpvDrK6CLmbNTsdpIWv1
         NhJj5jmKVmUO1C+NincbkIZ0igwIiju/LB1gqmWyZoleQzc7JFK7kQOLJXpKJ62Q22
         U7EWe50hBy8K+5CR8+xwvunySBu5axiFCL5c38tk=
Date:   Wed, 22 Jul 2020 16:11:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 3/3] dmaengine: xilinx: dpdma: fix kernel doc format
Message-ID: <20200722131119.GH5833@pendragon.ideasonboard.com>
References: <20200718135201.191881-1-vkoul@kernel.org>
 <20200718135201.191881-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718135201.191881-3-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you for the patch.

On Sat, Jul 18, 2020 at 07:22:01PM +0530, Vinod Koul wrote:
> xilinx_dpdma_chan structure documents 'desc' members, but that leads
> to warnings, so split that up and describe members
> 
> drivers/dma/xilinx/xilinx_dpdma.c:241: warning: Function parameter or
> member 'desc' not described in 'xilinx_dpdma_chan'
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 430f3714f6a3..d94c75a842f8 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -214,8 +214,8 @@ struct xilinx_dpdma_tx_desc {
>   * @lock: lock to access struct xilinx_dpdma_chan
>   * @desc_pool: descriptor allocation pool
>   * @err_task: error IRQ bottom half handler
> - * @desc.pending: Descriptor schedule to the hardware, pending execution
> - * @desc.active: Descriptor being executed by the hardware
> + * @desc: pending: Descriptor schedule to the hardware, pending execution
> + *        active: Descriptor being executed by the hardware

According to
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions,
the existing syntax is supposed to be valid. Where does the above
warning come from ?

>   * @xdev: DPDMA device
>   */
>  struct xilinx_dpdma_chan {

-- 
Regards,

Laurent Pinchart
