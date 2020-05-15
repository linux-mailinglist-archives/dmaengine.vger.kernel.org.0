Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6361D461C
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEOGsS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 02:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgEOGsS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 02:48:18 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFBC2065F;
        Fri, 15 May 2020 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589525298;
        bh=FalsbYc52oWPaMj/27MdS9atxuelk/cRSZ3Jh4sfRBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uy/jaJM3EKXvApRjU0S/5ZlqgyYVjxujYvnhacmOqXw9I14j6mMUyzXbV9JVAktJ2
         4FIwyLT0o17yVn7H/ftX7VeA+GPPrCJiy6Ebh2dGvWwDzj+9MHYovuJmFK1SWK8jBC
         Q56pnu5/30tgT0SWtRC9K6H/lT51xIPumSU+naLs=
Date:   Fri, 15 May 2020 12:18:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        swathi.kovvuri@intel.com
Subject: Re: [PATCH v4] dmaengine: cookie bypass for out of order completion
Message-ID: <20200515064811.GJ333670@vkoul-mobl>
References: <158924063387.26270.4363255780049839915.stgit@djiang5-desk3.ch.intel.com>
 <4d279eb4-baf8-f504-da30-6a6a963bc521@ti.com>
 <f63a0895-914c-3509-1521-f978f30fb39b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63a0895-914c-3509-1521-f978f30fb39b@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-05-20, 09:35, Dave Jiang wrote:
> 
> 
> On 5/13/2020 12:30 AM, Peter Ujfalusi wrote:
> > 
> > 
> > On 12/05/2020 2.47, Dave Jiang wrote:
> > > The cookie tracking in dmaengine expects all submissions completed in
> > > order. Some DMA devices like Intel DSA can complete submissions out of
> > > order, especially if configured with a work queue sharing multiple DMA
> > > engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
> > > those DMA devices. The user should use callbacks to track the completion
> > > rather than the DMA cookie. This would address the issue of dmatest
> > > complaining that descriptors are "busy" when the cookie count goes
> > > backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
> > > DMA capability to allow the driver to flag the device's ability to complete
> > > operations out of order.
> > 
> > I'm still a bit hesitant around this.
> > If the DMA only support out of order completion then it is mandatory
> > that each descriptor must have unique callback parameter in order the
> > client could know which transfer has been completed.

Maybe we can still use the cookie to indicate that, or leave it to users
to manage? They can add an id in the callback params?

Using former is easy, but still user needs to keep track... later can be
possibly more suited here?

-- 
~Vinod
