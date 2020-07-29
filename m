Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73692322D5
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2Qnd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 12:43:33 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46616 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Qnd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jul 2020 12:43:33 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3B0162004A;
        Wed, 29 Jul 2020 18:43:28 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:43:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH 1/3] rapidio: Replace 'select' DMAENGINES 'with depends
 on'
Message-ID: <20200729164326.GA1371039@ravnborg.org>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
 <20200729162910.13196-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729162910.13196-2-laurent.pinchart@ideasonboard.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=P1BnusSwAAAA:8 a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8
        a=6Oqx4sNpb8nSHwTV4vAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=D0XLA9XvdZm18NrgonBM:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent.

On Wed, Jul 29, 2020 at 07:29:08PM +0300, Laurent Pinchart wrote:
> Enabling a whole subsystem from a single driver 'select' is frowned
> upon and won't be accepted in new drivers, that need to use 'depends on'
> instead. Existing selection of DMAENGINES will then cause circular
> dependencies. Replace them with a dependency.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/rapidio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index e4c422d806be..b9f8514909bf 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
>  config RAPIDIO_DMA_ENGINE
>  	bool "DMA Engine support for RapidIO"
>  	depends on RAPIDIO
> -	select DMADEVICES
> +	depends on DMADEVICES
$subject and changlog talks about DMAENGINES but the patch touches DMADEVICES??

	Sam


>  	select DMA_ENGINE
>  	help
>  	  Say Y here if you want to use DMA Engine frameork for RapidIO data
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
