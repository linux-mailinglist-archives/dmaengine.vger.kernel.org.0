Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B4421EDE
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJEGe7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 02:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEGe7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 02:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9244661251;
        Tue,  5 Oct 2021 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633415589;
        bh=QFHAeDRRSiQyrtHsYxia9CmhBdGDJKJLZc5S01XcQWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYMQdaGZCHaGOSxekgQOpfwZS4fA8PeVUETCQ9P0v0TpMTw5jRM4AFMjOBII4WjXQ
         r4tZIqZlZKewHNzBdg95E0KacIxrCkrjLMR75xB9Txnj6TbckNCjrLH4rb9S1C/71Q
         gDrnxC2i6Hijnkmg8CN+bpadCkpGBFlISSLMdic/yThYfMh1Xf+q2nr/hVNmGOoHGr
         XTFtjVsyMI5GdyeLJV1l7xJj0wTjXtEJyQ1SdbTGs8tytq9V1HUPC6ASwg4oP356oJ
         SmXHfNQHgwC92gWpX3elE/Yk8WinBz6MddVTatu+XhdEVCj9+1MuMB8gtLHVkYvD9l
         /jp84T94POfEQ==
Date:   Tue, 5 Oct 2021 12:03:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/3] Few Tegra210 ADMA fixes
Message-ID: <YVvxoSChGm0lN4rZ@matsya>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
 <564a850a-41e4-31fc-9ebe-51ac6b859f62@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564a850a-41e4-31fc-9ebe-51ac6b859f62@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-10-21, 21:19, Sameer Pujar wrote:
> Hi Vinod,
> 
> On 9/15/2021 9:37 PM, Sameer Pujar wrote:
> > Following are the fixes in the series:
> >   - Couple of minor fixes (non functional fixes)
> > 
> >   - ADMA FIFO size fix: The slave ADMAIF channels have different default
> >     FIFO sizes (ADMAIF FIFO is actually a ring buffer and it is divided
> >     amongst all available channels). As per HW recommendation the sizes
> >     should match with the corresponding ADMA channels to which ADMAIF
> >     channel is mapped to at runtime. Thus program ADMA channel FIFO sizes
> >     accordingly. Otherwise FIFO corruption is observed.
> > 
> > Sameer Pujar (3):
> >    dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
> >    dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
> >    dmaengine: tegra210-adma: Override ADMA FIFO size
> > 
> >   drivers/dma/tegra210-adma.c | 55 +++++++++++++++++++++++++++++++--------------
> >   1 file changed, 38 insertions(+), 17 deletions(-)
> > 
> 
> Are these patches good to be picked up? or I need to resend these?

Pls do not send unnecessary pings, I was on vacation, back now and going
thru the queue!
 
-- 
~Vinod
