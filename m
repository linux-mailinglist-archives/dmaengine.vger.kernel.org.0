Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC06D29C0F3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1817984AbgJ0RQl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 13:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1817951AbgJ0RQG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 13:16:06 -0400
Received: from localhost (unknown [122.171.48.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3D820657;
        Tue, 27 Oct 2020 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818966;
        bh=AIMHk/Cr/ep5MYXBoIA7vsZGonWhnAq9ZjPEIv/5dbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucz2OQV0CwQZQFiGWjQxFMzjOSn+bEyH51fNbnCyrwPT192A5Xv2NRKmUxY+7g3pI
         oNuq6sBgzV2EitmS1vM4ksrBhECbI0TQuXQAchUVZOKKvmMI024VqhL2a1ilk/RLDO
         y8lpCUySKATcvr9XVgBqqXeuKV84Gle4NOcYyd7k=
Date:   Tue, 27 Oct 2020 22:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: move struct in interface to use
 peripheral term
Message-ID: <20201027171601.GC3550@vkoul-mobl>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-3-vkoul@kernel.org>
 <61417567-e42a-789a-6848-acc84008cd45@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61417567-e42a-789a-6848-acc84008cd45@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-20, 12:04, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> one minor comment...
> 
> On 15/10/2020 10.31, Vinod Koul wrote:
> > dmaengine history has a non inclusive terminology of dmaengine slave, I
> > feel it is time to replace that.
> > 
> > This moves structures in dmaengine interface with replacement of slave
> > to peripheral which is an appropriate term for dmaengine peripheral
> > devices
> > 
> > Since the change of name can break users, the new names have been added
> > with old structs kept as macro define for new names. Once the users have
> > been migrated, these macros will be dropped.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> ...
> 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index f7f420876d21..04b993a5373c 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> 
> ...
> 
> >  /**
> > - * struct dma_slave_map - associates slave device and it's slave channel with
> > + * struct dma_peripheral_map - associates peripheral device and it's peripheral channel with
> >   * parameter to be used by a filter function
> >   * @devname: name of the device
> > - * @slave: slave channel name
> > + * @peripheral: peripheral channel name
> 
> I know that this is slave -> peripheral change, but would not be better
> to call this as 'channame'?

okay have made in chan_name

-- 
~Vinod
