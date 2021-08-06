Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13B63E2E40
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhHFQT4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 12:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhHFQTz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 12:19:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD0D9611BF;
        Fri,  6 Aug 2021 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628266779;
        bh=XuvEYYJ4kXC/cVfsfSZSGBZa6Yunv/mmUPU/BeI7C/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OesV5SRw+7jNOOROUuHLWJa6WpW/mgP8tJUTGVy3KW/uf/qpgBqQOSO3j5xCjZ6Y9
         344nOVp8OHatVvSA+LSgsaovIK6thfQYHbAfw2jHOAX/XLeasfZlPsj3EYPHeAX6Jv
         RiaIh9cNZMJo0ZNqtSzg3a/r4mhJiSecKosTZkfsoECxg/GsP7v1v3J75lEEoYEQ+r
         B6yM8miXZt6SdvqObcSbg9zOdY+SNMgq1a+D+IExwM/m+bES3vbHGavlwXN2KjVvja
         /ourGO9OFzwPXhynFfgI6wzzvYGH+8ZYZXHXAHTl/8CRBZLWsfU2T0/K6f781wcjXS
         ++11g+i0dkXQA==
Date:   Fri, 6 Aug 2021 21:49:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Check for errors from
 acpi_register_gsi() separately
Message-ID: <YQ1hFtHRDIflENis@matsya>
References: <20210802175532.54311-1-andriy.shevchenko@linux.intel.com>
 <YQ080pMpNcXqt1ml@matsya>
 <YQ1VU/lHIXFtjwVE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ1VU/lHIXFtjwVE@smile.fi.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-21, 18:29, Andy Shevchenko wrote:
> On Fri, Aug 06, 2021 at 07:14:50PM +0530, Vinod Koul wrote:
> > On 02-08-21, 20:55, Andy Shevchenko wrote:
> > > While IRQ test agaist the returned variable in practice is a good enough
> > > there is still a room for theoretical mistake in case the vIRQ of the
> > > device contains the same error code that acpi_register_gsi() may return.
> > > Due to this, check for error code separately from matching the vIRQs.
> > > 
> > > Besides that, append documentation to tell why acpi_gsi_to_irq() can't
> > > be used and we call acpi_register_gsi() instead.
> > 
> > patch fails to apply, pls rebase
> 
> I don't see that you applied the previous patch [1].
> Care to apply it, please?

Sorry, somehow that one was pushed to queue but never got applied!

Have applied both now

> 
> [1]: https://lore.kernel.org/dmaengine/20210730202715.24375-1-andriy.shevchenko@linux.intel.com/T/#u
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

-- 
~Vinod
