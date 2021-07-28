Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1D3D8859
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhG1G44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhG1G4z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:56:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3ECA60F6D;
        Wed, 28 Jul 2021 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627455414;
        bh=uG4A0x8I1qOLetqrP5zVU9v4dMBfQQBdM6FU6vTMBmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVAR6HwsGo+IqLUIwPYqelXm/CDjdZpXlJve7lqY+otMsIuecNvV63Kjed3G+Kg2Y
         RnxvH8vBjrpT8FwSCuYJLaWzVBwcBQY7AVDmGVRUCVsdDchbpizp6zYA7lm2tbaE0B
         vRS/Mop+nvQR413/a8uPim3ovhtUo94W9WhLX3C7OUA53CaSOCrlB2Z+xC4677JRE8
         1OyG/NrxNUePg0+CJH8pomkIM9I2ioyve586lkR544a15EOxa/6+xXzb8nVTMOwzxl
         I0kpJnd91f+fYW7lqplTZto7aOLm4R4qpvPgqbe2OsdDIOEJvDgvqF8aHbAvdoBn/q
         zMpKbiHrJMSlA==
Date:   Wed, 28 Jul 2021 12:26:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: use module_platform_driver
Message-ID: <YQD/skGeS0rzYS5P@matsya>
References: <20210625090042.17085-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625090042.17085-1-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-21, 11:00, Clément Léger wrote:
> The driver was previously probed with platform_driver_probe. This does
> not allow the driver to be probed again later if probe function
> returns -EPROBE_DEFER. This patch replace the use of
> platform_driver_probe with module_platform_driver which allows that.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/dma/at_xdmac.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 64a52bf4d737..109a4c0895f4 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2238,11 +2238,7 @@ static struct platform_driver at_xdmac_driver = {
>  	}
>  };
>  
> -static int __init at_xdmac_init(void)
> -{
> -	return platform_driver_probe(&at_xdmac_driver, at_xdmac_probe);
> -}
> -subsys_initcall(at_xdmac_init);
> +module_platform_driver(at_xdmac_driver);

You are also changing the init call here, there is a reason why
dmaengine drivers are subsys_initcall.. have you tested this?

-- 
~Vinod
