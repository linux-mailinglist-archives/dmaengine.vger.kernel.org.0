Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34B199CC4
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgCaRZD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 13:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgCaRZD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 13:25:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E155220BED;
        Tue, 31 Mar 2020 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585675502;
        bh=fqj8rZSX2LtQTT5i1PXswN5RpOtslvLeE1KpZGlhvQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPP8VZGjkyxMKz4ildZObA4mn4wDlnaD5j4vTqunlzN8MIGSm/1Lxg2dEVO2atzFa
         fjT36a9OMrjYr4JUd+iMVVUv7jlNkyp3Mhc3UL7VHzY2Mgto/Y+jGVnQBmMOnRCd2t
         RubqfH2yZZxjid30NVtJAyK985MthNBuhydR2U9w=
Date:   Tue, 31 Mar 2020 19:24:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
Message-ID: <20200331172459.GA1841577@kroah.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
 <20200331100406.GB1204199@kroah.com>
 <00d8e780-105e-f552-daf0-9854f2e99a91@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d8e780-105e-f552-daf0-9854f2e99a91@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 31, 2020 at 10:07:07AM -0700, Dave Jiang wrote:
> 
> On 3/31/2020 3:04 AM, Greg KH wrote:
> > On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
> > > Since the current accelerator devices do not have standard PCIe capability
> > > enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
> > > been added to struct pci_dev.  Currently a PCI quirk must be used for the
> > > devices that have such cap until the PCI cap is standardized. Add a helper
> > > function to provide the check if a device supports the cmdmem capability.
> > > 
> > > Such capability is expected to be added to PCIe device cap enumeration in
> > > the future.
> > > 
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >   drivers/base/core.c    |   13 +++++++++++++
> > >   include/linux/device.h |    2 ++
> > >   include/linux/pci.h    |    1 +
> > >   3 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index dbb0f9130f42..cd9f5b040ed4 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -27,6 +27,7 @@
> > >   #include <linux/netdevice.h>
> > >   #include <linux/sched/signal.h>
> > >   #include <linux/sysfs.h>
> > > +#include <linux/pci.h>
> > >   #include "base.h"
> > >   #include "power/power.h"
> > > @@ -3790,3 +3791,15 @@ int device_match_any(struct device *dev, const void *unused)
> > >   	return 1;
> > >   }
> > >   EXPORT_SYMBOL_GPL(device_match_any);
> > > +
> > > +bool device_supports_cmdmem(struct device *dev)
> > > +{
> > > +	struct pci_dev *pdev;
> > > +
> > > +	if (!dev_is_pci(dev))
> > > +		return false;
> > > +
> > > +	pdev = to_pci_dev(dev);
> > > +	return pdev->cmdmem;
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_supports_cmdmem);
> > Why would a pci-specific function like this be ok to have in the driver
> > core?  Please keep it in the pci core code instead.
> 
> The original thought was to introduce a new arch level memory mapping
> semantic.

Please do not.  Also, that's not what you are doing here from what I can
tell.

> If you feel this should be PCI exclusive, should we make the ioremap
> routines for this memory type pci specific as well?

Why wouldn't it be?  Is this needed anywhere else?

thanks,

greg k-h
