Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB9435680
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTXaJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 19:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTXaJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 19:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FBB660F57;
        Wed, 20 Oct 2021 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634772474;
        bh=vvRfwlxU8SZoTOlb+tOlX8/u84LD6FdEwl6WBQOZ+Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dxe/2mw2u998213c2OEBsM+rmgFmeySkb1AN7HPknwuv/VV80nKAP2ufhmV6lBq+M
         3PIQO/YXQrRM45BFEfCKzFpHlYamtnEuKk/kn/4TdrFapzUtiX/XN8Krt+4XQ9aDjf
         3KxkOC3Q6cIUp3JQdWnZt228t5jHvMto3m3x94gRP8pedSm7l72CVAImRnmPIJ+xCQ
         uGPbHGZHvDwbp8IOcHhElGCcgAjXayJ80KWLJ/o1tX3gYjT906BiODqr89ZOsKdPSl
         /o9MLlNfGH0OaORrwMs6/2672EDzHDX+yTZ3Buant1Ts8fdmfJNzEropurEqGx2swU
         +rkGKPKYTAqzQ==
Date:   Wed, 20 Oct 2021 18:32:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Len Baker <len.baker@gmx.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pxa_dma: Prefer struct_size over open coded
 arithmetic
Message-ID: <20211020233233.GA1320242@embeddedor>
References: <20210918104055.8444-1-len.baker@gmx.com>
 <e7e103f3-74eb-9cf4-a150-e2333d4f2ace@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e103f3-74eb-9cf4-a150-e2333d4f2ace@embeddedor.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 20, 2021 at 07:00:58PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/18/21 05:40, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the struct_size() helper to do the arithmetic instead of the
> > argument "size + count * size" in the kzalloc() function.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm taking this in my -next tree.

Thanks
--
Gustavo
