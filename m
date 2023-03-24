Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE76C7A88
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 09:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCXI6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjCXI6L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 04:58:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9B2658F;
        Fri, 24 Mar 2023 01:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07606B82277;
        Fri, 24 Mar 2023 08:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF9C433D2;
        Fri, 24 Mar 2023 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679648249;
        bh=ys+7yc4sUX1/Wx2eRmenuEDPnjFxIcQOIE/STjZHko4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhwSKU9pyBrx2ROAjIW/p7RuF507eM0FSC69dHElcXrQf2yuqK/Xrbh/JXGQvjh3f
         PrWbnxo/K0ouYFnmNzaCNHLlxgdIIdiXRQTovhr24yxAOetZ6TZV3VLDOd4EGIngPJ
         DzoTmuN/gau0G7fgbnyeK5XTpLWCnYTi5GsmeCmA=
Date:   Fri, 24 Mar 2023 09:57:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Message-ID: <ZB1l9mWTNPrUX4FJ@kroah.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
 <76db3d98-2d09-54de-ab46-0ec9d743e05d@intel.com>
 <ZBLsYNXXCBkb8QlO@kroah.com>
 <43c53ae9-6cc7-0fa7-584a-7720569179cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43c53ae9-6cc7-0fa7-584a-7720569179cf@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 16, 2023 at 04:57:54PM -0700, Fenghua Yu wrote:
> Hi, Greg,
> 
> On 3/16/23 03:16, Greg Kroah-Hartman wrote:
> > On Mon, Mar 13, 2023 at 12:07:27PM -0700, Fenghua Yu wrote:
> > > Hi, Greg,
> > > 
> > > On 3/13/23 11:29, Greg Kroah-Hartman wrote:
> > > > In the functions unbind_store() and bind_store(), a struct bus_type *
> > > > should be a const one, as the driver core bus functions used by this
> > > > variable are expecting the pointer to be constant, and these functions
> > > > do not modify the pointer at all.
> > > > 
> > > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > Cc: dmaengine@vger.kernel.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > > Note, this is a patch that is a prepatory cleanup as part of a larger
> > > > series of patches that is working on resolving some old driver core
> > > > design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> > > > its own, but I'd prefer if I could take it through my driver-core tree
> > > > so that the driver core changes can be taken through there for 6.4-rc1.
> > > > 
> > > >    drivers/dma/idxd/compat.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> > > > index 3df21615f888..5fd38d1b9d28 100644
> > > > --- a/drivers/dma/idxd/compat.c
> > > > +++ b/drivers/dma/idxd/compat.c
> > > > @@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
> > > >    static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
> > > >    {
> > > > -	struct bus_type *bus = drv->bus;
> > > > +	const struct bus_type *bus = drv->bus;
> > > >    	struct device *dev;
> > > >    	int rc = -ENODEV;
> > > > @@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
> > > >    static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
> > > >    {
> > > > -	struct bus_type *bus = drv->bus;
> > > > +	const struct bus_type *bus = drv->bus;
> > > >    	struct device *dev;
> > > >    	struct device_driver *alt_drv = NULL;
> > > >    	int rc = -ENODEV;
> > > 
> > > After applying this patch, warning is reported:
> > > 
> > > drivers/dma/idxd/compat.c: In function ‘bind_store’:
> > > drivers/dma/idxd/compat.c:47:47: warning: passing argument 2 of
> > > ‘driver_find’ discards ‘const’ qualifier from pointer target type
> > > [-Wdiscarded-qualifiers]
> > >     47 |                 alt_drv = driver_find("idxd", bus);
> > >        |                                               ^~~
> > > In file included from ./include/linux/device.h:32,
> > >                   from drivers/dma/idxd/compat.c:6:
> > > ./include/linux/device/driver.h:129:59: note: expected ‘struct bus_type *’
> > > but argument is of type ‘const struct bus_type *’
> > >    129 |                                          struct bus_type *bus);
> > >        |                                          ~~~~~~~~~~~~~~~~~^~~
> > > 
> > > Should the "bus" parameter in driver_find() definition be changed to const
> > > as well to avoid the warning?
> > 
> > Oops, yes, it needs an earlier patch in this series, sorry, I didn't
> > call that out properly in the notes section of the patch.
> > 
> > So I can just take this through my tree if that's ok.
> 
> Sure.
> 
> Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Great, thanks for this, I've now queued up the series in my tree.

greg k-h
