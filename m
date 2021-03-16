Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042233D224
	for <lists+dmaengine@lfdr.de>; Tue, 16 Mar 2021 11:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhCPKq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Mar 2021 06:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236840AbhCPKqD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Mar 2021 06:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F2C64FB1;
        Tue, 16 Mar 2021 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615891561;
        bh=dkTRc5/yqM5Ao8hri8SLqb6PswLpKgQXSaZlsxs7Z8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNmZ7T07zKtvlo86JkmuLgjjMDmK2iDG5PjLQNEY33LG4fjY6RA0wyvSMv3N7eyzr
         PrHiyJOH5FqkPI1+OfFAtozbSUheYjv/Zoos5326Zt0Qm7EgXBuSCXjgLY2sTFTQLp
         bgkOs5RjLNMNc7IsLoexo/JTaPbXrrCcIOxJrMxaa9kjJGCp+9kYIRXVXSkKzr8Izw
         1vacp9ANv70aaDKWqk4cxv+6tPyYuunRxIULc4zUhY++YzoS05FI9uknFmfTO8UMmX
         AXe4NB2I9ScqJRFZMffgfwfCwFQzD6ajhtR5aISZUWE/zqAR5l67wv7C8HNW1XR0rC
         efRsjWTj/9p4Q==
Date:   Tue, 16 Mar 2021 16:15:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Shravya Kumbham <shravya.kumbham@xilinx.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: Introduce synchronize() callback
Message-ID: <YFCMZthQen6RaFfU@vkoul-mobl>
References: <20210313125311.4823-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313125311.4823-1-lars@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-03-21, 13:53, Lars-Peter Clausen wrote:
> The Xilinx dmaengine driver uses a tasklet to process completed
> descriptors and execute their callbacks.
> 
> Currently consumers of the DMA channel have to no method of synchronization
> against this tasklet when using the Xilinx dmaengine drivers. This can lead
> to race conditions when the consumer frees resources that are accessed in
> the callback before the tasklet has finished running.
> 
> It is not enough to just call dmaengine_terminal_all() since on a
> multi-processor system the tasklet can run concurrently to it and might
> call the callback after dmaengine_terminate_all() has already finished.
> 
> To mitigate this issue implement the synchronize() callback for the driver,
> which will wait until the tasklet has finished.

Applied, thanks

-- 
~Vinod
