Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4774B25BAFC
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgICGXC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 02:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICGXB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 02:23:01 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8D620737;
        Thu,  3 Sep 2020 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599114181;
        bh=WvdWpfp4yGs/OG6vxMqXYw0dclAmH6PLGk5akCtgnLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvF6UsRHtjegha6BStVkGgJX+G2qghxgaTFHsUbAUqT3P9nw8/j8HEX/tMVXJIpTp
         SuWTwMQKqLpyLUI1f620ktsgHwLO/5Es+CeUY7BWeLeodfV0q4+yql2wD+C/e9PDdb
         lXYc9RFgmKSA/EeK7LtUFaT7t7qrXLw16V/fgfFc=
Date:   Thu, 3 Sep 2020 11:52:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Brad Kim <brad.kim@sifive.com>
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        Brad Kim <brad.kim@semifive.com>
Subject: Re: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback
 twice
Message-ID: <20200903062257.GE2639@vkoul-mobl>
References: <20200827133309.17362-1-brad.kim@semifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827133309.17362-1-brad.kim@semifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Brad,

On 27-08-20, 22:33, Brad Kim wrote:
> Because a callback is called twice when DMA transfer complete
> the second callback may be possible to access a freed memory
> if the first callback routines perform the dma_release_channel function.
> So this patch serialized the callback functions
> 
> Signed-off-by: Brad Kim <brad.kim@semifive.com>

The patch came from Brad Kim <brad.kim@sifive.com> but was s-o-b brad.kim@semifive.com

I am not sure which one is correct but DCO clearly states that patch
author Brad Kim <brad.kim@sifive.com> should sign off! You can add
additional sign offs but that one is mandatory!

Thanks

-- 
~Vinod
