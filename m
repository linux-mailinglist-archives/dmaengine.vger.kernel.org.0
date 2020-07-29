Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102C52322E7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgG2QvD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2QvD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jul 2020 12:51:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E83C061794
        for <dmaengine@vger.kernel.org>; Wed, 29 Jul 2020 09:51:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C689D29E;
        Wed, 29 Jul 2020 18:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1596041461;
        bh=rJjTXG7oHTCq9+/aTzLg9irnYsb8UBgvUgtw7uNJzBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAdNtq4EH0NoWuCD169cmQyYZcXtNhAXKorGxiFLylch/dk6QVYdoVKygVCieRTlO
         Bz0AvNct9L6/DWmKxWGzSeSuvd0096+vmouz8VMdvqNFL5e3D1G5stsh2b+5jtONV/
         6M1wTOzkMw3bmayAEjB1Pk2TUuCV2rG3GzaVzYiQ=
Date:   Wed, 29 Jul 2020 19:50:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
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
Message-ID: <20200729165052.GN6183@pendragon.ideasonboard.com>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
 <20200729162910.13196-2-laurent.pinchart@ideasonboard.com>
 <20200729164326.GA1371039@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729164326.GA1371039@ravnborg.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sam,

On Wed, Jul 29, 2020 at 06:43:26PM +0200, Sam Ravnborg wrote:
> On Wed, Jul 29, 2020 at 07:29:08PM +0300, Laurent Pinchart wrote:
> > Enabling a whole subsystem from a single driver 'select' is frowned
> > upon and won't be accepted in new drivers, that need to use 'depends on'
> > instead. Existing selection of DMAENGINES will then cause circular
> > dependencies. Replace them with a dependency.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  drivers/rapidio/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> > index e4c422d806be..b9f8514909bf 100644
> > --- a/drivers/rapidio/Kconfig
> > +++ b/drivers/rapidio/Kconfig
> > @@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
> >  config RAPIDIO_DMA_ENGINE
> >  	bool "DMA Engine support for RapidIO"
> >  	depends on RAPIDIO
> > -	select DMADEVICES
> > +	depends on DMADEVICES
>
> $subject and changlog talks about DMAENGINES but the patch touches DMADEVICES??

Clearly a typo in the subject line, it should be DMADEVICES. I'll wait a
little bit to see if there are more comments, and will send a v2.

> >  	select DMA_ENGINE
> >  	help
> >  	  Say Y here if you want to use DMA Engine frameork for RapidIO data

-- 
Regards,

Laurent Pinchart
