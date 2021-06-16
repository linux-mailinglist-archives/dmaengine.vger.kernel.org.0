Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE523A9A18
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhFPMZn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 08:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPMZl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 08:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0E9B6128C;
        Wed, 16 Jun 2021 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623846215;
        bh=JQHmCW/leR0CDqLSwgusxk3rhfxZDcyA0XqoiaaOZ5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4xAKtxu+l8eMdudgT4MXh8qwS97EpK/VvA/hIGLH5nvQXF4yOTbf7COB+jj9NKNO
         dFUfvzrIP6f05fGgeZ6hNvWIbHFcYxGmmXAUGBW/LI+iNqParxo7hXEh9ZQ9y06lMI
         nW/uBtKxILs7bUAd4l2+U9102kr7vjvPFnn1tfwI=
Date:   Wed, 16 Jun 2021 14:23:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMntRILEO3ceyeZU@kroah.com>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
 <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com>
 <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl>
 <627518e2-8b20-d6a9-1e0c-9822c4fa95ed@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627518e2-8b20-d6a9-1e0c-9822c4fa95ed@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 16, 2021 at 05:30:49PM +0530, Sanjay R Mehta wrote:
> The pt_device is allocated and initialized in the PCI probe function and
> then we just get the "dev" from the "pci_dev" object and save it in
> "pt->dev" as shown in below snippet.
> 
> 
>    static int pt_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
>    {
> 	struct pt_device *pt;
> 	struct pt_msix *pt_msix;
> 	struct device *dev = &pdev->dev;

So "dev" is a parent here, or something else?

If it is the parent, please call it such otherwise it is confusing.

If you are creating child devices, what bus do they belong to?

Can you fix up this series and resend it so that we can review it again?

thanks,

greg k-h
