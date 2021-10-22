Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6429437419
	for <lists+dmaengine@lfdr.de>; Fri, 22 Oct 2021 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJVI7l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Oct 2021 04:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232338AbhJVI7l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Oct 2021 04:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40B13603E9;
        Fri, 22 Oct 2021 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634893043;
        bh=RFCDB+PAgD4OJ71NPOKLB8rC7qWzqFddQNvlx4Q8aoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5/rQFGg7PVzqwbqY+l5wnhgJ0SPUebvudVOJsG6YeTjIjf46A9EOx9kqJc7GO2qz
         /UCIoWRqgaDRhnCTqWfleZBkIu51uMUTGSgDM96auIlKJPb73RJjBlJA9xl1NGM69v
         mF5Ic1kJTh2Z6wnxPuskl80+WJ1KFncrMmuhq+is=
Date:   Fri, 22 Oct 2021 10:57:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jianxiong Gao <jxgao@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 4/5] driver core: inhibit automatic driver binding on
 reserved devices
Message-ID: <YXJ88eARBE3vU1aA@kroah.com>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
 <20211022020032.26980-5-zev@bewilderbeest.net>
 <YXJeYCFJ5DnBB63R@kroah.com>
 <YXJ3IPPkoLxqXiD3@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXJ3IPPkoLxqXiD3@hatter.bewilderbeest.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Oct 22, 2021 at 01:32:32AM -0700, Zev Weiss wrote:
> On Thu, Oct 21, 2021 at 11:46:56PM PDT, Greg Kroah-Hartman wrote:
> > On Thu, Oct 21, 2021 at 07:00:31PM -0700, Zev Weiss wrote:
> > > Devices whose fwnodes are marked as reserved are instantiated, but
> > > will not have a driver bound to them unless userspace explicitly
> > > requests it by writing to a 'bind' sysfs file.  This is to enable
> > > devices that may require special (userspace-mediated) preparation
> > > before a driver can safely probe them.
> > > 
> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > ---
> > >  drivers/base/bus.c            |  2 +-
> > >  drivers/base/dd.c             | 13 ++++++++-----
> > >  drivers/dma/idxd/compat.c     |  3 +--
> > >  drivers/vfio/mdev/mdev_core.c |  2 +-
> > >  include/linux/device.h        | 14 +++++++++++++-
> > >  5 files changed, 24 insertions(+), 10 deletions(-)
> > 
> > Ugh, no, I don't really want to add yet-another-state to the driver core
> > like this.  Why are these devices even in the kernel with a driver that
> > wants to bind to them registered if the driver somehow should NOT be
> > bound to it?  Shouldn't all of that logic be in the crazy driver itself
> > as that is a very rare and odd thing to do that the driver core should
> > not care about at all.
> > 
> > And why does a device need userspace interaction at all?  Again, why
> > would the driver not know about this and handle it all directly?
> > 
> 
> Let me expand a bit more on the details of the specific situation I'm
> dealing with...
> 
> On a server motherboard we've got a host CPU (Xeon, Epyc, POWER, etc.) and a
> baseboard management controller, or BMC (typically an ARM SoC, an ASPEED
> AST2500 in my case).  The host CPU's firmware (BIOS/UEFI, ME firmware, etc.)
> lives in a SPI flash chip.  Because it's the host's firmware, that flash
> chip is connected to and generally (by default) under the control of the
> host CPU.
> 
> But we also want the BMC to be able to perform out-of-band updates to the
> host's firmware, so the flash is *also* connected to the BMC.  There's an
> external mux (controlled by a GPIO output driven by the BMC) that switches
> which processor (host or BMC) is actually driving the SPI signals to the
> flash chip, but there's a bunch of other stuff that's also required before
> the BMC can flip that switch and take control of the SPI interface:
> 
>  - the BMC needs to track (and potentially alter) the host's power state
> to ensure it's not running (in OpenBMC the existing logic for this is    an
> entire non-trivial userspace daemon unto itself)
> 
>  - it needs to twiddle some other GPIOs to put the ME into recovery mode
> 
>  - it needs to exchange some IPMI messages with the ME to confirm it got
> into recovery mode
> 
> (Some of the details here are specific to the particular motherboard I'm
> working with, but I'd guess other systems probably have broadly similar
> requirements.)
> 
> The firmware flash (or at least the BMC's side of the mux in front of it) is
> attached to a spi-nor controller that's well supported by an existing MTD
> driver (aspeed-smc), but that driver can't safely probe the chip until all
> the stuff described above has been done.  In particular, this means we can't
> reasonably bind the driver to that device during the normal
> device-discovery/driver-binding done in the BMC's boot process (nor do we
> want to, as that would pull the rug out from under the running host).  We
> basically only ever want to touch that SPI interface when a user (sysadmin
> using the BMC, let's say) has explicitly initiated an out-of-band firmware
> update.
> 
> So we want the kernel to be aware of the device's existence (so that we
> *can* bind a driver to it when needed), but we don't want it touching the
> device unless we really ask for it.
> 
> Does that help clarify the motivation for wanting this functionality?

Sure, then just do this type of thing in the driver itself.  Do not have
any matching "ids" for this hardware it so that the bus will never call
the probe function for this hardware _until_ a manual write happens to
the driver's "bind" sysfs file.

Then when userspace is done, do a "unbind" write.

No driver core changes should be needed at all here.

thanks,

greg k-h
