Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F003E2DC6
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbhHFP3r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 11:29:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:22818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242735AbhHFP3r (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 11:29:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="214119746"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="214119746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:29:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="513477110"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:29:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mC1ml-0067Lj-Qj; Fri, 06 Aug 2021 18:29:23 +0300
Date:   Fri, 6 Aug 2021 18:29:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Check for errors from
 acpi_register_gsi() separately
Message-ID: <YQ1VU/lHIXFtjwVE@smile.fi.intel.com>
References: <20210802175532.54311-1-andriy.shevchenko@linux.intel.com>
 <YQ080pMpNcXqt1ml@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ080pMpNcXqt1ml@matsya>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 06, 2021 at 07:14:50PM +0530, Vinod Koul wrote:
> On 02-08-21, 20:55, Andy Shevchenko wrote:
> > While IRQ test agaist the returned variable in practice is a good enough
> > there is still a room for theoretical mistake in case the vIRQ of the
> > device contains the same error code that acpi_register_gsi() may return.
> > Due to this, check for error code separately from matching the vIRQs.
> > 
> > Besides that, append documentation to tell why acpi_gsi_to_irq() can't
> > be used and we call acpi_register_gsi() instead.
> 
> patch fails to apply, pls rebase

I don't see that you applied the previous patch [1].
Care to apply it, please?

[1]: https://lore.kernel.org/dmaengine/20210730202715.24375-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


