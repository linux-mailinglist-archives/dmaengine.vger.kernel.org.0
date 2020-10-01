Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AF27F8AB
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJAE3N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 00:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgJAE3N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 1 Oct 2020 00:29:13 -0400
Received: from localhost (unknown [122.167.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6798021531;
        Thu,  1 Oct 2020 04:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601526553;
        bh=GRJyHppYoU3yAd0Hf9faOF9M9F0Po2XXmWUXqinU49A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GS0Sm+hl+tOjOpMqOyTzs9OfRcjI7rtRjpJAOiPLShYww2/aBrhZmel8QTDwk704D
         uSovgqkrVQcv1n993m7Mbkf611YMjuxcxmimj8rc4fCA7oM9DR27NG34snWK6bOLXT
         pxRUgZPmDoGDXX1WO/RFsQcevMZoWic6dQ/saUN0=
Date:   Thu, 1 Oct 2020 09:59:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dan.j.williams@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201001042908.GO2968@vkoul-mobl>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
 <20200924215136.GS5030@zn.tnic>
 <4d857287-c751-8b37-d067-b471014c3b73@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d857287-c751-8b37-d067-b471014c3b73@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

On 30-09-20, 15:19, Dave Jiang wrote:
> 
> 
> On 9/24/2020 2:51 PM, Borislav Petkov wrote:
> > On Thu, Sep 24, 2020 at 02:32:35PM -0700, Dave Jiang wrote:
> > > Hi Vinod,
> > > Looks like we are cleared on the x86 patches for this series with sign offs
> > > from maintainer Boris. Please consider the series for 5.10 inclusion. Thank
> > > you!
> > 
> > As I said here, I'd strongly suggest we do this:
> > 
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/5FKNWNCCRV3AXUAEXUGQFF4EDQNANF3F/
> > 
> > and Vinod should merge the x86/pasid branch. Otherwise is his branch
> > and incomplete you could not have tested it properly.
> > 
> 
> Hi Vinod,
> Just checking to see if you have any objections or concerns with respect to
> this series. We are hoping it can be queued for the 5.10 merge if there are
> no objections. Thanks!

I was out for last few days, so haven't checked on this yet, but given
that we are very close to merge widow I fear it is bit late to merge
this late. I will go thru the series today though..

Thanks
-- 
~Vinod
