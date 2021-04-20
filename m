Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD8365630
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhDTKdC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 06:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhDTKdC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 06:33:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C3EC61002;
        Tue, 20 Apr 2021 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618914751;
        bh=6NohsF/OOByVQ5YMe4yiuWb0xtaOGmtlozDwZYMs01o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDSDijoguidyue7XMSuqas9qV9bvDhVAankhp56A0rsA86/rzsCy1qvLHvGxI9ub+
         rxIurUKFumVnCmRmqJvZkRG2kc62pDJCxbGIv0CbvLqGDQ6sLDuIQaL99DJrGqFmgo
         /wuJsSQsXF3kKuxk7Epez8bl+gpLnouOWfc/kDTvdQIUfbzwhq/xYFDQiReq6/ZXK4
         CLZw0aCTQSt4hkyNarjqDwLD/l+LNDWtx4MmsLg9sIT9diZKuXPEEB3HiD4eQ+WWFO
         c/Q92yAExlLVc3VmrK7agEqlXBGDjL+hB/NiGSx4/wTXRVcAZS212pITJG+isK+apK
         Jlz8ZC7YZR17Q==
Date:   Tue, 20 Apr 2021 16:02:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        eugen.hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] dmaengine: at_xdmac: Remove unused inline
 function at_xdmac_csize()
Message-ID: <YH6tu6hF5Vo1Ofh+@vkoul-mobl.Dlink>
References: <20210407132543.23652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407132543.23652-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-21, 21:25, YueHaibing wrote:
> commit 765c37d87669 ("dmaengine: at_xdmac: rework slave configuration part")
> left behind this, so can remove it.

Applied, thanks

-- 
~Vinod
