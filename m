Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CE3F45CB
	for <lists+dmaengine@lfdr.de>; Mon, 23 Aug 2021 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhHWHaJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Aug 2021 03:30:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:63005 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235129AbhHWHaI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Aug 2021 03:30:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="204249034"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="204249034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:29:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="514693897"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:29:23 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI4OT-00ChCe-3b; Mon, 23 Aug 2021 10:29:17 +0300
Date:   Mon, 23 Aug 2021 10:29:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        vireshk@kernel.org, wangzhou1@hisilicon.com, logang@deltatee.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: switch from 'pci_' to 'dma_' API
Message-ID: <YSNOTX68ltbt2hwf@smile.fi.intel.com>
References: <547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Aug 22, 2021 at 02:40:22PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> 
> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
> This is less verbose.
> 
> It has been compile tested.

> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)

Can we, please, replace this long noise in the commit message with a link to a
script in coccinelle data base?

And the same comment for any future submission that are based on the scripts
(esp. coccinelle ones).

...

> This patch is mostly mechanical and compile tested. I hope it is ok to
> update the "drivers/dma/" directory all at once.

There is another discussion with Hellwig [1] about 64-bit DMA mask,
i.e. it doesn't fail anymore, so you need to rework drivers accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

-- 
With Best Regards,
Andy Shevchenko


