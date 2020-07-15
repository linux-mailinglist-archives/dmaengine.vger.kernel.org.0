Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1570220C93
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgGOMBx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 08:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgGOMBw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 08:01:52 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD1C20658;
        Wed, 15 Jul 2020 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594814512;
        bh=Asm2zKeo6RUzv3qZh0M/yLSCpflT44ffhplUnINxP60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW3gGmQZA89N4eAtDMQ9aeeHQkuGpSOV0nlqEqLD+4oUyFPWRlcZMmhEp1sQBvei+
         6Mc8nfFxVskvuvwh4Ag5QXE4NSOBrV6QSBbPZ5uhXBGXaYRRyZ0k/0YbnMYyfzML9l
         QJUAQVvrmhHBKXcDYB1xPq+V6y4LRB53IDboT1VA=
Date:   Wed, 15 Jul 2020 17:31:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200715120145.GL34333@vkoul-mobl>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-9-Sergey.Semin@baikalelectronics.ru>
 <20200710085123.GF3703480@smile.fi.intel.com>
 <20200710094510.j6ugxygkadxex53c@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094510.j6ugxygkadxex53c@mobilestation>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-20, 12:45, Serge Semin wrote:
> On Fri, Jul 10, 2020 at 11:51:23AM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2020 at 01:45:47AM +0300, Serge Semin wrote:
> > > Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> > > have non-uniform DMA capabilities per device channels, let's add
> > > the DW DMA specific device_caps callback to expose that specifics up to
> > > the DMA consumer. It's a dummy function for now. We'll fill it in with
> > > capabilities overrides in the next commits.
> > 
> 
> > Just a reminder (mainly to Vinod) of my view to this.
> > Unneeded churn, should be folded to patch 9.
> 
> Just to remind (mainly to Vinod). That's Andy's bikeshedding.
> This isn't a churn, since it's totally normal to design the patchset in this way:
> introduce a callback, then fill it in with functionality.

Looking at both patches, they do one thing, so please fold them in..

-- 
~Vinod
