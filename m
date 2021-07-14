Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9E3C7DD6
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 07:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhGNFOZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 01:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFOY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 01:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C46B6135A;
        Wed, 14 Jul 2021 05:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626239493;
        bh=GKvbaLpI/cd8qIg2kcIK/1hd8C0ILLfi1PmKGowalhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0fBFBx56q/PtO4yQ9d4vZPdyjpqR9WJxoz7nIgeQn3eacrpO7qSQ1rXCieZBqIaT
         1ypI0v8BOlYroMsH36RDDGb1MNC1kXrE9uayTz4Rjl8yOZMWhd6TNdHmedUQtiy0Nx
         VmyhgUGeJ+NLFSpklUTJNycPfRPn+bJnIXJfW9haO560/GDBefQe7n9PbMIm5B9o/F
         QOlVM4ScOh0x1BuslOsWHZdpd2woNhtbomlsgLfXpk5pAiFobr8VtLjkivM+FQGok9
         HZNonBH2559U408oeipTw/y6bzwW5G6Oxy2en8ql08hA7q4jYtHpQvlwQOkYKmKmFa
         sAd6Pbg3CN71w==
Date:   Wed, 14 Jul 2021 10:41:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH V2] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
Message-ID: <YO5yAnLsJOamBUEP@matsya>
References: <20210706124521.1371901-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706124521.1371901-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-21, 20:45, Yu Kuai wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by moving the error_pm label above the pm_runtime_put() in
> the error path.

Applied, thanks

-- 
~Vinod
