Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAB20292F
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFUG5U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 02:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbgFUG5U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Jun 2020 02:57:20 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23EDD24829;
        Sun, 21 Jun 2020 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592722640;
        bh=1T7L5CYvUKOKzOtIc26JQy8rVEfP3d+xIeZ+Bdc/yoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9wNna9zcmMSycjgIfDwYG8a5e4EUUpQTRcMcb8cykAi3DpSzpDCDgv+wBQFVi6zs
         krO2qNzYx/C6ReVZrJKjaZmPFAGxqpsWFjMXidlnQHiSfn0pm1GA1qiJ9GO7kKfBlh
         hsAKaDkP+UgSf/mxX/7YoSJwIaalQg75WLzPQVvU=
Date:   Sun, 21 Jun 2020 12:27:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com,
        peter.ujfalusi@ti.com
Subject: Re: [PATCH v5] dmaengine: cookie bypass for out of order completion
Message-ID: <20200621065715.GZ2324254@vkoul-mobl>
References: <158939557151.20335.12404113976045569870.stgit@djiang5-desk3.ch.intel.com>
 <20200617141526.GV2324254@vkoul-mobl>
 <7cf3f322-787b-1aaa-227c-11c603e6d663@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf3f322-787b-1aaa-227c-11c603e6d663@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-06-20, 11:15, Dave Jiang wrote:
> 
> 
> On 6/17/2020 7:15 AM, Vinod Koul wrote:
> > On 13-05-20, 11:47, Dave Jiang wrote:
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
> > Applied, thanks
> > 
> 
> Thanks Vinod. I'm trying to find your branch that has this commit so I can
> rebase against it, and I can't seem to find it.

Urgh, infradead seems to have some issues and my push had failed, sorry I
should have noticed. It is failing again for me, meanwhile use below
mirror:
git.kernel.org:pub/scm/linux/kernel/git/vkoul/slave-dma.git

Thanks
-- 
~Vinod
