Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A46BCC46
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCPKQa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCPKQW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 06:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99091F5F7;
        Thu, 16 Mar 2023 03:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 675F9B81FC5;
        Thu, 16 Mar 2023 10:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA1FC433EF;
        Thu, 16 Mar 2023 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678961763;
        bh=/X6mivln8z/I5JC2sVDzwGffX08YdZ7Anm7VgAYEof8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRAURE/afC5otWPb1vC4c8zeeq+hxwbZ8QaQcLmgdexhGfplsdrCMBvSeN4UljlO+
         Uwej54rJgOrcCekAvw+67cxY34y02u5ksnuaXm9mKBztI/6Zurk6ymGm9c5vGs0Mvq
         NlrVtSEvnXFJP/vzs5LIbDPdS7+zXJo/1yeXTWco=
Date:   Thu, 16 Mar 2023 11:16:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Message-ID: <ZBLsYNXXCBkb8QlO@kroah.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
 <76db3d98-2d09-54de-ab46-0ec9d743e05d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76db3d98-2d09-54de-ab46-0ec9d743e05d@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 13, 2023 at 12:07:27PM -0700, Fenghua Yu wrote:
> Hi, Greg,
> 
> On 3/13/23 11:29, Greg Kroah-Hartman wrote:
> > In the functions unbind_store() and bind_store(), a struct bus_type *
> > should be a const one, as the driver core bus functions used by this
> > variable are expecting the pointer to be constant, and these functions
> > do not modify the pointer at all.
> > 
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Note, this is a patch that is a prepatory cleanup as part of a larger
> > series of patches that is working on resolving some old driver core
> > design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> > its own, but I'd prefer if I could take it through my driver-core tree
> > so that the driver core changes can be taken through there for 6.4-rc1.
> > 
> >   drivers/dma/idxd/compat.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/compat.c b/drivers/dma/idxd/compat.c
> > index 3df21615f888..5fd38d1b9d28 100644
> > --- a/drivers/dma/idxd/compat.c
> > +++ b/drivers/dma/idxd/compat.c
> > @@ -16,7 +16,7 @@ extern void device_driver_detach(struct device *dev);
> >   static ssize_t unbind_store(struct device_driver *drv, const char *buf, size_t count)
> >   {
> > -	struct bus_type *bus = drv->bus;
> > +	const struct bus_type *bus = drv->bus;
> >   	struct device *dev;
> >   	int rc = -ENODEV;
> > @@ -32,7 +32,7 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, 0200, NULL, unbind_store);
> >   static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
> >   {
> > -	struct bus_type *bus = drv->bus;
> > +	const struct bus_type *bus = drv->bus;
> >   	struct device *dev;
> >   	struct device_driver *alt_drv = NULL;
> >   	int rc = -ENODEV;
> 
> After applying this patch, warning is reported:
> 
> drivers/dma/idxd/compat.c: In function ‘bind_store’:
> drivers/dma/idxd/compat.c:47:47: warning: passing argument 2 of
> ‘driver_find’ discards ‘const’ qualifier from pointer target type
> [-Wdiscarded-qualifiers]
>    47 |                 alt_drv = driver_find("idxd", bus);
>       |                                               ^~~
> In file included from ./include/linux/device.h:32,
>                  from drivers/dma/idxd/compat.c:6:
> ./include/linux/device/driver.h:129:59: note: expected ‘struct bus_type *’
> but argument is of type ‘const struct bus_type *’
>   129 |                                          struct bus_type *bus);
>       |                                          ~~~~~~~~~~~~~~~~~^~~
> 
> Should the "bus" parameter in driver_find() definition be changed to const
> as well to avoid the warning?

Oops, yes, it needs an earlier patch in this series, sorry, I didn't
call that out properly in the notes section of the patch.

So I can just take this through my tree if that's ok.

thanks,

greg k-h
