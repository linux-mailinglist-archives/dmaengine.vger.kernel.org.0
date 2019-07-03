Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D75EA75
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCRaz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 13:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCRay (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jul 2019 13:30:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4471421882;
        Wed,  3 Jul 2019 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562175053;
        bh=dESY6s9erPS+daa9EoD+hzMvKyEvEHwmVOabdgtibc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ty3qSp0oxpqzGfs+3PXh97mHnCB7I1BVit4KnVtwb6+Bi0JxyLwSx2WYo7WO+TyXq
         QUfeb52o/YQbYiKKxFBx4TrbIH3oBcjRLChW/if+5JoPzVJRd55rVu7b2OBm71yVIg
         3ykWfIgP3L1tgZk7Cu/JjPb/hbg0L0MX4vKPw2BI=
Date:   Wed, 3 Jul 2019 19:30:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "George G . Davis" <george_davis@mentor.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190703173050.GA11328@kroah.com>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
 <20190628125534.GB1458@ninjato>
 <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 28, 2019 at 03:02:00PM +0200, Eugeniu Rosca wrote:
> Hi Wolfram,
> 
> On Fri, Jun 28, 2019 at 02:55:34PM +0200, Wolfram Sang wrote:
> [..]
> > If you could formally add such a tag:
> > 
> > Tested-by: <your email>
> > 
> > (maybe also Acked-by: or Reviewed-by:, dunno if you think it is
> > apropriate)
> > 
> > to the patches, this would be much appreciated and will usually speed up
> > the patches getting applied.
> > 
> > Thanks for your help!
> 
> I am doing this per-patch to allow patchwork to reflect the status of
> each patch on the linux-renesas-soc front-page. AFAIK patchwork ignores
> series-wide '*-by: Name <email>' signatures/tags.

I don't use patchwork :)

