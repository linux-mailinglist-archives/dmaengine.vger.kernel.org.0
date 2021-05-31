Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1426439544E
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhEaEFf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhEaEFe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:05:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1413E611EE;
        Mon, 31 May 2021 04:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622433835;
        bh=0xfMtsHewwb7fTSKcKv14cPltEk1ithOlhx+6gwiMWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VM8YtfKyDimkBGOLI3jzbPADCGHY9togxkgw/t1OJMJA2/EzV9QKERn5fqR1/9ZBM
         2VkbAULuFn67dcinY8YvPt9aSTfOwCD3OMfAmdOdATsGgQmlDYz+DnSq86GNczjch/
         jHZF9i5WOPlctEss+1/B7yd+GY/zgo0728rj+KNPRryYFr+6z+gW8jExoB2Rzl/LTW
         vXnoMZEGyASpNtqOb/yP05BgodiXKKEb6VQ5ejhheI0ZgmzFsk/mWZPJPYFci2gPkE
         vM2QQI/dCeM0J0HcNECT+1muCQsp/Tg4DI3me/yqVGyYj14+P/A7yF1CBQ59BmTTWq
         knMP96zf2+otg==
Date:   Mon, 31 May 2021 09:33:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, yi.zhang@huawei.com
Subject: Re: [PATCH 3/3] dmaengine: zynqmp_dma: Fix PM reference leak in
 zynqmp_dma_alloc_chan_resourc()
Message-ID: <YLRgKG04vRzXJVNG@vkoul-mobl.Dlink>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517081826.1564698-4-yukuai3@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-21, 16:18, Yu Kuai wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.

Applied, thanks

-- 
~Vinod
