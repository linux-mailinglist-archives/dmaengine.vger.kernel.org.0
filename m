Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F571993A9
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgCaKmG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 06:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgCaKmF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 06:42:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936A7208E4;
        Tue, 31 Mar 2020 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585651325;
        bh=MZAU576gyLJO4F4wEGfdDUQTS1+k9BE34i/jleEvrXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1DaSB+mTncyky8tsYLt/2VbvY124DhWGXSFbkKH/FsUb3sL2o494Xms4GD3EdOfs
         uWL7HfRO/kMdPHq3Y6acegGr6qNXyYMNd/A0e8MdsotYW0yiJzqm1AAoV6i4o2hUah
         Nbdgrk4B+T0wUCZQgB/PYSLJv5NQJC1UOcvvzgR0=
Date:   Tue, 31 Mar 2020 12:04:06 +0200
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
Message-ID: <20200331100406.GB1204199@kroah.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
> Since the current accelerator devices do not have standard PCIe capability
> enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
> been added to struct pci_dev.  Currently a PCI quirk must be used for the
> devices that have such cap until the PCI cap is standardized. Add a helper
> function to provide the check if a device supports the cmdmem capability.
> 
> Such capability is expected to be added to PCIe device cap enumeration in
> the future.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/base/core.c    |   13 +++++++++++++
>  include/linux/device.h |    2 ++
>  include/linux/pci.h    |    1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index dbb0f9130f42..cd9f5b040ed4 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sysfs.h>
> +#include <linux/pci.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -3790,3 +3791,15 @@ int device_match_any(struct device *dev, const void *unused)
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(device_match_any);
> +
> +bool device_supports_cmdmem(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	return pdev->cmdmem;
> +}
> +EXPORT_SYMBOL_GPL(device_supports_cmdmem);

Why would a pci-specific function like this be ok to have in the driver
core?  Please keep it in the pci core code instead.

thanks,

greg k-h
