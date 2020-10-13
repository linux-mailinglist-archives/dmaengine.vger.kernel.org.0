Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF48A28C907
	for <lists+dmaengine@lfdr.de>; Tue, 13 Oct 2020 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbgJMHQT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Oct 2020 03:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389829AbgJMHQT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Oct 2020 03:16:19 -0400
Received: from localhost (unknown [122.171.192.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F1220797;
        Tue, 13 Oct 2020 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602573378;
        bh=3o+J5156BZXHbm9WUNyHjx/6jWMYsHSO9hdScpW0Qas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppTuoiDpFosth+C+clfakXVMKOqo6iGPwdv+SXj72ApDLyVGqKEYB5c9v45HJXONE
         YikSWao8G+nffPLW9psgHu92KmMfiIMDS35qVUmMBt2bvRU8KZkoe4UM7iU7Br4Lbl
         yadaBUUvsDNaEHNRKHSlpvSv5B9kougUWtAB2bIo=
Date:   Tue, 13 Oct 2020 12:46:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Sia, Jee Heng" <jee.heng.sia@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Message-ID: <20201013071614.GP2968@vkoul-mobl>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <20201012135905.GX4077@smile.fi.intel.com>
 <BL0PR11MB3362A202A1D3BDC8C1CA41DBDA040@BL0PR11MB3362.namprd11.prod.outlook.com>
 <20201013070118.GN2968@vkoul-mobl>
 <BL0PR11MB336251229FB2A626D7178DB8DA040@BL0PR11MB3362.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB336251229FB2A626D7178DB8DA040@BL0PR11MB3362.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-10-20, 07:12, Sia, Jee Heng wrote:
> 
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 13 October 2020 3:01 PM
> > To: Sia, Jee Heng <jee.heng.sia@intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> > Eugeniy.Paltsev@synopsys.com; dmaengine@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> > AxiDMA
> > 
> > On 13-10-20, 05:49, Sia, Jee Heng wrote:
> > > > >
> > > > > This patch set is to replace the patch series submitted at:
> > > > > https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-emai
> > > > > l-je
> > > > > e.heng.sia@intel.com/
> > > >
> > > > And it means effectively the bumped version, besides the fact that
> > > > you double sent this one...
> > > >
> > > >
> > > > Please fix and resend. Note, now is merge window is open. Depends on
> > > > maintainer's flow it may be good or bad time to resend with properly
> > > > formed changelog and version of the series.
> > 
> > yeah sorry I wont look at it till merge window closes
> [>>] Sorry.
> > 
> > > [>>] Thanks. Will resend the patch set with v1 in the header.
> > 
> > Should this be v1, v1 was the first post, this would be v2!
> > 
> [>>] Thanks for the correction. I meant v2.
> > Please use git format-patch -v2 to autogenerate version headers in patches..
> > 
> > I thought Intel folks had internal review list to take care of these things, is it no
> > longer used..?
> [>>] We are, but I am confuse on what should I do to the existing patch set sent in 
> https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-email-jee.heng.sia@intel.com/. There is no response from anyone.

Sorry my bad looks like I have missed this one, can you please repost
this after merge window closes and I will look into it

Thanks

-- 
~Vinod
