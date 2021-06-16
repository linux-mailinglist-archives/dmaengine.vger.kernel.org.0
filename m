Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4C3A9B47
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhFPM7T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 08:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232790AbhFPM7S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 08:59:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E927B61019;
        Wed, 16 Jun 2021 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623848231;
        bh=DWFBu/mfBxZGTgWooOIBmvdwLAeW2eIRNfnsK75iQco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHu3CoBCSbsA0xo+wX912jkLND6O7VUmdGKgAk+RwzIcwJPTaE2JtYzzavr6ALXpJ
         QbmvGllMsmDwRzA1ctF2FdcAv/4R4VLgjb2jJ+MzQQe9bC/0lmC68+JRQcUBwyP39c
         pyPzWXqmNsqymObTpC/W2z/0SSN/Qu2OWP1nlks4=
Date:   Wed, 16 Jun 2021 14:57:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMn1JRfj/n3O8Jfp@kroah.com>
References: <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
 <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com>
 <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl>
 <627518e2-8b20-d6a9-1e0c-9822c4fa95ed@amd.com>
 <YMntRILEO3ceyeZU@kroah.com>
 <0221d964-1cbc-c925-133f-40c3eaa11421@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0221d964-1cbc-c925-133f-40c3eaa11421@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 16, 2021 at 06:23:10PM +0530, Sanjay R Mehta wrote:
> 
> 
> On 6/16/2021 5:53 PM, Greg KH wrote:
> > [CAUTION: External Email]
> > 
> > On Wed, Jun 16, 2021 at 05:30:49PM +0530, Sanjay R Mehta wrote:
> >> The pt_device is allocated and initialized in the PCI probe function and
> >> then we just get the "dev" from the "pci_dev" object and save it in
> >> "pt->dev" as shown in below snippet.
> >>
> >>
> >>    static int pt_pci_probe(struct pci_dev *pdev, const struct
> >> pci_device_id *id)
> >>    {
> >>       struct pt_device *pt;
> >>       struct pt_msix *pt_msix;
> >>       struct device *dev = &pdev->dev;
> > 
> > So "dev" is a parent here, or something else?
> > 
> > If it is the parent, please call it such otherwise it is confusing.
> > 
> > If you are creating child devices, what bus do they belong to?
> > 
> > Can you fix up this series and resend it so that we can review it again?
> > 
> 
> Hi Greg,
> 
> Yes, "dev" is the parent here and there are no child devices created.

But you should be creating a child device, as that will be the name you
need.  Or again, I am probably confused, I'll wait for the next round of
patches...

thanks,

greg k-h
