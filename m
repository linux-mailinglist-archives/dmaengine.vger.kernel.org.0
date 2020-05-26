Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF61E1B3D
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 08:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEZG3O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 02:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEZG3O (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 02:29:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BB720776;
        Tue, 26 May 2020 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590474553;
        bh=1bi6tm/grFse4a4MPlt1A7X1cCrCLhJ1NkOLAEX78B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEuTqWd4htM5rnZTZTTs7KjKExi5VbYKBm7qjorcqYoryx9oIiphApHho10cGGRx1
         Agdy03TJrym0qVFbxxU2kgMBIDkJOHcnJgvbjQZYdBkFwW6o+19JoZVo6t3t9emwV5
         or6ZS+9iyvwILaw2rAQlwIx6oF1sf7bVQ4nh8a5M=
Date:   Tue, 26 May 2020 08:29:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dmaengine: ptdma: Initial driver for the AMD
 PTDMA controller
Message-ID: <20200526062911.GA2578492@kroah.com>
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-2-git-send-email-Sanju.Mehta@amd.com>
 <20200504055539.GJ1375924@vkoul-mobl>
 <f016a02b-ebc4-6280-dff4-25e189ff2d49@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f016a02b-ebc4-6280-dff4-25e189ff2d49@amd.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 26, 2020 at 11:35:02AM +0530, Sanjay R Mehta wrote:
> Apologies for my delayed response.
> 
> >> +#include <linux/module.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/interrupt.h>
> >> +
> >> +#include "ptdma.h"
> >> +
> >> +static int cmd_queue_length = 32;
> >> +module_param(cmd_queue_length, uint, 0644);
> >> +MODULE_PARM_DESC(cmd_queue_length,
> >> +              " length of the command queue, a power of 2 (2 <= val <= 128)");
> > 
> > Any reason for this as module param? who will configure this and how?
> > 
> The command queue length can be from 2 to 64K command.
> Therefore added as module parameter to allow the length of the queue to be specified at load time.

Please no, this is not the 1990's.  No one can use them easily, make
this configurable on a per-device basis if you really need to be able to
change this.

But step back, why do you need to change this at all?  Why do you have a
limit and why can you not just do this dynamically?  The goal here
should not have any user-changable options at all, it should "just
work".

> >> + * List of PTDMAs, PTDMA count, read-write access lock, and access functions
> >> + *
> >> + * Lock structure: get pt_unit_lock for reading whenever we need to
> >> + * examine the PTDMA list. While holding it for reading we can acquire
> >> + * the RR lock to update the round-robin next-PTDMA pointer. The unit lock
> >> + * must be acquired before the RR lock.
> >> + *
> >> + * If the unit-lock is acquired for writing, we have total control over
> >> + * the list, so there's no value in getting the RR lock.
> >> + */
> >> +static DEFINE_RWLOCK(pt_unit_lock);
> >> +static LIST_HEAD(pt_units);
> >> +
> >> +static struct pt_device *pt_rr;
> > 
> > why do we need these globals and not in driver context?
> > 
> The AMD SOC has multiple PT controller's with the same PCI device ID and hence the same driver is probed for each instance.
> The driver stores the pt_device context of each PT controller in this global list.

That's horrid and not needed at all.  No driver should have a static
list anymore, again, this isn't the 1990's :)

> >> +static void pt_add_device(struct pt_device *pt)
> >> +{
> >> +     unsigned long flags;
> >> +
> >> +     write_lock_irqsave(&pt_unit_lock, flags);
> >> +     list_add_tail(&pt->entry, &pt_units);
> >> +     if (!pt_rr)
> >> +             /*
> >> +              * We already have the list lock (we're first) so this
> >> +              * pointer can't change on us. Set its initial value.
> >> +              */
> >> +             pt_rr = pt;
> >> +     write_unlock_irqrestore(&pt_unit_lock, flags);
> >> +}
> > 
> > Can you please explain what do you mean by having a list of devices and
> > why are we adding/removing dynamically?
> > 
> Since AMD SOC has many PT controller's with the same PCI device ID and
> hence the same driver probed for initialization of each PT controller device instance.

That's fine, PCI drivers should all work on a per-device basis and not
care if there are 1, or 1000 of the same device in the system.

> Also, the number of PT controller varies for different AMD SOC's.

Again, that's fine.

> Therefore the dynamic adding/removing of each PT controller context to global device list implemented.

Such a list should never be needed, unless you are doing something
really wrong.  Please remove it and use the proper PCI device driver
apis for your individual instances instead.

thanks,

greg k-h
