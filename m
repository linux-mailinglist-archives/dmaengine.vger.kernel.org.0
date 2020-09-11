Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31614265F57
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKMOi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 08:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgIKMNb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Sep 2020 08:13:31 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD5822204;
        Fri, 11 Sep 2020 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826383;
        bh=xAWTdjYU1UYc4H3V/H7SmZMfjJloSVi9eO38wf8alrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYHs/ryIBwPTZzC3D/b6SrTyq9z7N6yqlPyRgsYHEyeb9xEi5o17NxgUm/ejlMWXh
         C5FaqucWatBvgrKD9xpvvpsL3GGsOENuj8KT0JDkMw3YIo7MZELFxIgivPbX5+bkj/
         JCGQF84ypN8d6zesJZzfyqOjmj8h/gZBYeGIeNSI=
Date:   Fri, 11 Sep 2020 17:42:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/9] dmaengine: Tidy up dma_parms
Message-ID: <20200911121258.GZ77521@vkoul-mobl>
References: <cover.1599164692.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1599164692.git.robin.murphy@arm.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-09-20, 21:25, Robin Murphy wrote:
> Just a bit of trivial housekeeping now that it's no longer necessary for
> platform and AMBA devices to allocate their own dma_parms. Feel free to
> squash patches if desired.

Applied all, thanks

> 
> I have no idea why I'm spending my own Thursday evening on this, but
> apparently the itch has to be scratched :)

And looking at diffstat and good itch scratched :-)

>  9 files changed, 24 deletions(-)

-- 
~Vinod
