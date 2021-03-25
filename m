Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1367D348917
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 07:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCYG3I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 02:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYG2j (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 02:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B49361A2C;
        Thu, 25 Mar 2021 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616653719;
        bh=QYkth7TBYTzwFa8Sgy++KDQXO6aHhrvcTNjyJkdUYrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJqlt4cWnBAicvHosVV/nZ47Jj8Dqo14teQeon22/N5pzRLEScZmSck6oTIHhHMxA
         7Ykz6e5GfXmr/5D1bAHJcaHhJllV87GTscdIxQkYSofkF5IkgfVpem0xadjVFVEj9+
         RgLVJUk7xy7ts8n39RV03qNZdjFVnQI0qMv+3nyWHlt3xDy9jPCcYSihQOCL6uL5Hu
         YGC1BkB4tNWyjS8jN2UXLB/qTgjwmPNkqWLJKJ7gJVdInHSET3hZFuI8eXP4M9s2lb
         2DIOAL4S7N8/TwQ+ESGqnXhw1SarXL9PpHyMQF/FNUVViuDGVBtojovKHEwBspbKzs
         96MIXn2jT6FtQ==
Date:   Thu, 25 Mar 2021 11:58:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <YFwtk7tnPmzVYGl0@vkoul-mobl.Dlink>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
 <20210323115600.GA2356281@nvidia.com>
 <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-03-21, 08:44, Dave Jiang wrote:
> On 3/23/2021 4:56 AM, Jason Gunthorpe wrote:
> > On Tue, Mar 23, 2021 at 05:15:30PM +0530, Vinod Koul wrote:

> > > > Vinod,
> > > > The series fixes the various 'struct device' lifetime handling in the
> > > > idxd driver. The devm managed lifetime is incompatible with 'struct device'
> > > > objects that resides in the idxd context. Tested with
> > > > CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
> > > Sorry for not looking into this earlier.. But I would like to check on
> > > the direction idxd is taking. Somehow I get the feel the dmaengine is
> > > not the right place for this. Considering that now we have auxdev merged
> > > in, should the idxd be spilt into smaller function and no dmaengine
> > > parts moved away from dmaengine... I think we do lack a subsystem for
> > > all things accelerator in kernel atm...
> > auxdev shouldn't be over-used IMHO.
> > 
> > If the main purpose of the driver is dma engine then it is OK if the
> > "core" part lives there too.
> 
> Hi Vinod,
> 
> So this patch series serves as the basis of getting the idxd dsa_bus_type
> related bits fixed up so that auxdev is not necessary. When Jason reviewed
> previous iterations of the mdev series, he noted that the mdev driver needs
> to go under VFIO. After the auxdev conversion of the mdev series, Jason and
> Dan after further review suggested that given there's an internal bus in
> idxd driver already (dsa_bus_type), that can be used to load drivers rather
> than needing to rely on auxiliary bus. But the implementation of the
> dsa_bus_type needs some fixes. After this series, I have another series
> that's going through internal review right now that will fixup the driver
> setup and initialization of dsa_bus_type and allow us to load external
> drivers for the wq. The in kernel use cases for DSA is still valid under
> dmaengine so the core parts remains valid for dmaengine. The plan going
> forward is after getting all the fixups in we are planning to:
> 
> 1. Introduce UACCE framework support for idxd and have a wq driver resides
> under drivers/misc/uacce/idxd to support the char device operations and
> deprecate the current custom char dev in idxd. This should remove the burden
> on you to deal with the char device.
> 
> 2. Resubmit the mdev driver under drivers/vfio/mdev/idxd after Jason's
> latest VFIO refactoring is done.
> 
> 3. Introduce new kernel use cases with dmanegine API support for SVA
> operations.
> 
> Let me know if this sounds ok to you. Thanks!

Yes that does sound reasonable to me, when should I expect this move to
show up on list?

-- 
~Vinod
