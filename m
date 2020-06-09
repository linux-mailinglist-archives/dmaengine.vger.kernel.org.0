Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3D1F377D
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 12:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFIKB3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 06:01:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:27198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgFIKB1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 06:01:27 -0400
IronPort-SDR: EWZ3YvaOzfvJjuc9f/Zh0wplIB29dsZJEmRFLSjXjRgHX3NFXirs+p3oB3zf9YsCbPU2BFRY8T
 INVU+8TApeJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 03:01:26 -0700
IronPort-SDR: ACl2+c3q8DAeTm1vQ0OVYA5vGbVYr6sTBmPemDdI5y3hdQ/aDkaxbbL637EwZ8MEAf38MD3Cru
 HmkMNskXO8jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="447075409"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 09 Jun 2020 03:01:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jib4R-00Brpc-3G; Tue, 09 Jun 2020 13:01:27 +0300
Date:   Tue, 9 Jun 2020 13:01:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/15] dmaengine: dw-edma: Use PCI_IRQ_MSI_TYPES where
 appropriate
Message-ID: <20200609100127.GA2428291@smile.fi.intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091751.1065-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609091751.1065-1-piotr.stankiewicz@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 09, 2020 at 11:17:47AM +0200, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I think I saw somebody gave you tag here...
Am I mistaken?

...

>  	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
> -					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +					PCI_IRQ_MSI_TYPES);

Now one line?

-- 
With Best Regards,
Andy Shevchenko


