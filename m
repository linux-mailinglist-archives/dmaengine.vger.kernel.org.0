Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC220B9FD
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZUIQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 16:08:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:8814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgFZUIQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 26 Jun 2020 16:08:16 -0400
IronPort-SDR: 6CUANNw87mm0T/cC4tTQ5Qu1D4l9JrvWd6EFJO5g+M7FMZIQSGAXfxuAn1IJVJ5t5Wj74Brufz
 t3Wu3Ez7lh3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="163495099"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="163495099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 13:08:15 -0700
IronPort-SDR: DFxhAN9uAkgMQalhsvNo9cBN/6ui9Dzq1fygm1mPOL8AVTs4uAwUqd36H8Rr7JhvRtvzPtOvP2
 Uv4rlwNWx0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="302432552"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2020 13:08:15 -0700
Date:   Fri, 26 Jun 2020 13:08:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Ruf <freelancer@rufusul.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200626200815.GC2454695@iweiny-DESK2.sc.intel.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <581f1761-e582-c770-169a-ee3374baf25c@intel.com>
 <84270660.632865.1593072688966@mailbusiness.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84270660.632865.1593072688966@mailbusiness.ionos.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 25, 2020 at 10:11:28AM +0200, Thomas Ruf wrote:
> 
> > On 25 June 2020 at 02:42 Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > 
> > 
> > 
> > On 6/21/2020 12:24 AM, Vinod Koul wrote:
> > > On 19-06-20, 16:31, Dave Jiang wrote:
> > >>
> > >>
> > >> On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > >>> Hello,
> > >>>
> > >>> is there the possibility of using a DMA engine channel from userspace?
> > >>>
> > >>> Something like:
> > >>> - configure DMA using ioctl() (or whatever configuration mechanism)
> > >>> - read() or write() to trigger the transfer
> > >>>
> > >>
> > >> I may have supposedly promised Vinod to look into possibly providing
> > >> something like this in the future. But I have not gotten around to do that
> > >> yet. Currently, no such support.
> > > 
> > > And I do still have serious reservations about this topic :) Opening up
> > > userspace access to DMA does not sound very great from security point of
> > > view.
> > 
> > What about doing it with DMA engine that supports PASID? That way the user can 
> > really only trash its own address space and kernel is protected.
> 
> Sounds interesting! Not sure if this is really needed in that case...
> I have already implemented checks of vm_area_struct for contiguous memory or even do a get_user_pages_fast for user memory to pin it (hope that is the correct term here). Of course i have to do that for every involved page.

FWIW there is a new pin_user_pages_fast()/unpin_user_page() interface now.

Ira

> But i will do some checks if my code is really suitable to avoid misusage.
> 
> Best regards,
> Thomas
