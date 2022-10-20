Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D53605637
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 06:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJTEMc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 00:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJTEMb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 00:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7AC164BE1;
        Wed, 19 Oct 2022 21:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33CE7B8265D;
        Thu, 20 Oct 2022 04:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53090C433D6;
        Thu, 20 Oct 2022 04:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666239146;
        bh=8Sy3yjbG4x+58rCR96ZxpH5efyxWTXR5EzlYoAF02Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9QKV7oX1tGOYm7q9C3NfFgwmw4NiaixAwz2JXzeDYqRM4BXBMMqRhn2tNTZJh9A3
         hOwPpiOZMQhdxNWRHxrtmg9UW614jyUigx4HyhOPPWdH5ibe+XjgpGyZmkcmnc0V6L
         tT0KO/q5sy6N2B5EKFL3mgjSZxS6mYN5fShfDYKYXO9ir7kXufxX0eylGFo+6hF30H
         0TayjJkcW8c4TpV+v1qMVkOzZ1w/K2nwTUhuflbII/JVNH4la5bqY2FwGgCkc/PQ9d
         2QrylT8QKR3yYNp49Vqo8CF79LedNC/q+cu3nrWHUvpd77FFOzT/j1h0MDn1fYzBDA
         f3/zM4UfpBcBQ==
Date:   Thu, 20 Oct 2022 09:42:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Walker, Benjamin" <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] dmaengine: Add provider documentation on cookie
 assignment
Message-ID: <Y1DKpnOdP5MbSGeO@matsya>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-5-benjamin.walker@intel.com>
 <Y1Am/RpgWv3PAVaU@matsya>
 <297dff63-e199-d14b-7148-916888030740@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297dff63-e199-d14b-7148-916888030740@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-22, 10:21, Walker, Benjamin wrote:
> On 10/19/2022 9:34 AM, Vinod Koul wrote:
> > On 29-08-22, 13:35, Ben Walker wrote:
> > > Clarify the rules on assigning cookies to DMA transactions.
> > > 
> > > Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> > > ---
> > >   .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
> > >   1 file changed, 37 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> > > index 1d0da2777921d..a5539f816d125 100644
> > > --- a/Documentation/driver-api/dmaengine/provider.rst
> > > +++ b/Documentation/driver-api/dmaengine/provider.rst
> > > @@ -417,7 +417,9 @@ supported.
> > >       - tx_submit: A pointer to a function you have to implement,
> > >         that is supposed to push the current transaction descriptor to a
> > > -      pending queue, waiting for issue_pending to be called.
> > > +      pending queue, waiting for issue_pending to be called. Each
> > > +      descriptor is given a cookie to identify it. See the section
> > > +      "Cookie Management" below.
> > >     - In this structure the function pointer callback_result can be
> > >       initialized in order for the submitter to be notified that a
> > > @@ -522,6 +524,40 @@ supported.
> > >     - May sleep.
> > > +Cookie Management
> > > +------------------
> > > +
> > > +When a transaction is queued for submission via tx_submit(), the provider
> > > +must assign that transaction a cookie (dma_cookie_t) to uniquely identify it.
> > > +The provider is allowed to perform this assignment however it wants, but for
> > 
> > We assumes that we have monotonically increasing cookie and
> > if cookie 10 is marked complete cookie 8 is assumed complete too...
> 
> That's exactly what this patch series is changing. The earlier patches make
> changes to no longer report to the client the "last" or "used" cookie (to
> compare against) in the client APIs, and it turns out that nothing in the
> kernel actually cares about this behavior. So it's simply a documentation
> change to indicate that the client no longer has any visibility into the
> cookie behavior.

Not really, there are some engines which will notify that descriptor X
completed which also implies that all descriptors before X have
completed as well...

If we change the default behaviour, we risk breaking those.
> 
> Immediately below here the documentation then says that there's some
> convenience functions that providers can use that do produce monotonically
> increasing cookies. These are now optional for providers to use, if they
> find them useful, rather than the required way to manage the cookies.
> 
> > 
> > Completion is always in order unless we specify DMA_COMPLETION_NO_ORDER
> 
> The final patch in this series eliminates DMA_COMPLETION_NO_ORDER entirely.
> It was only used by the IDXD driver, and the reason I'm doing these patches
> is so that we can poll the IDXD driver for completions even though it can
> complete out of order.
-- 
~Vinod
