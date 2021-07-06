Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2C3BCAE0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jul 2021 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhGFKwe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jul 2021 06:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhGFKwc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Jul 2021 06:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 932BE619C3;
        Tue,  6 Jul 2021 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625568594;
        bh=bPKQG7VMSSD0/w80TXY6qN1X/ZiWRyDZ2D5tRURQYPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tA6MLSx4ezUqNV9nz99ni3dC//5IdrSKEZx+qd9oK7btksPTPA9/u8z8D40imzky8
         U87OblPdTzumM4K/2ZIrpZ2z8HKk0KPws6PuFQ5a6qRnIjHI6cNSLIm6U3/ri1Pl/j
         HCjGcaFq6qY6QEHfRJAAorpg2KWXydeaQ26Qs4G9QCpXmFvh8a0mf+XtQdmBb7yK5r
         DI4KyalVQT43VwBWA9i/EgJijoyoBxs1h0O3H4ybEbCI/bssHcKt1HykaTS0R3vwWo
         U4Lgu2Hx7nPUrFdKoBOw692vEXKEJKOugPzAAoQEjVzY2JEZFNhRzDPGoVgEA0i/9Q
         7vuyU6jH6P6OA==
Date:   Tue, 6 Jul 2021 16:19:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
Message-ID: <YOQ1TufSjoXDJBBj@matsya>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-3-yukuai3@huawei.com>
 <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
 <b6c340de-b0b5-6aad-94c0-03f062575b63@huawei.com>
 <YLSk/i6GmYWGEa9E@vkoul-mobl.Dlink>
 <YLSqD+9nZIWJpn+r@hovoldconsulting.com>
 <YLi4VGwzrat8wJHP@vkoul-mobl>
 <YL3TlDqe4KSr3ICl@hovoldconsulting.com>
 <YL3ynd1KiJoe9y6+@vkoul-mobl>
 <c8fcdaa1-f053-47aa-2dad-521b8f34b8d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fcdaa1-f053-47aa-2dad-521b8f34b8d1@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-21, 16:41, yukuai (C) wrote:
> Hi, Vinod
> 
> Are you still intrested in accepting this patch?

- Please do not top post

- yes, pls rebase and resend

> On 2021/06/07 18:19, Vinod Koul wrote:
> > On 07-06-21, 10:06, Johan Hovold wrote:
> > > On Thu, Jun 03, 2021 at 04:39:08PM +0530, Vinod Koul wrote:
> > > > On 31-05-21, 11:19, Johan Hovold wrote:
> > > > > On Mon, May 31, 2021 at 02:27:34PM +0530, Vinod Koul wrote:
> > > > > > On 31-05-21, 14:11, yukuai (C) wrote:
> > > > > > > On 2021/05/31 12:00, Vinod Koul wrote:
> > > > > > > > On 17-05-21, 16:18, Yu Kuai wrote:
> > > > > > > > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > > > > > > > Forgetting to putting operation will result in reference leak here.
> > > > > > > > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > > > > > > > counter balanced.
> > > 
> > > > > > Yes the rumtime_pm is disabled on failure here and the count would have
> > > > > > no consequence...
> > > > > 
> > > > > You should still balance the PM usage counter as it isn't reset for
> > > > > example when reloading the driver.
> > > > 
> > > > Should I driver trust that on load PM usage counter is balanced and not
> > > > to be reset..?
> > > 
> > > Not sure what you're asking here. But a driver should never leave the PM
> > > usage counter unbalanced.
> > 
> > Thinking about again, yes we should safely assume the counter is
> > balanced when driver loads.. so unloading while balancing sounds better
> > behaviour
> > 
> > Thanks
> > 

-- 
~Vinod
