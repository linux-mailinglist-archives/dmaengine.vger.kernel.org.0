Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA888379335
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhEJP6s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 11:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhEJP6l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 11:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D901615FF;
        Mon, 10 May 2021 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620662256;
        bh=WdPzlfDTCAqTArztGfKS9FeSEMSjEbUExqTn0eT1uxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCU08r3+JeiM1EODyVhtcL2uqBllYgKaB/IxQtyt2gibGzH+xGQAkE09Fx7Kokl2A
         O8KsI7gOMkOPTXhrnnTjo2a8IXlsY5nWLu34oTgzzop+pogX+9SLjLKPOxxiiN9aSJ
         mItmR6M7Jl58iqIb3ma8KavCj3l5dbAvXGSfFRxgl3aDaDvnnhu79ucWhaOHcpfrbv
         1OEzjMWmW9jO9FslFM6B1VoAAxalzBTzEZKLjgS2NsSbwUH0ZJk/MBS83iC8R+Ay5W
         DvA6iRo2WqTiDcf4fn7aBHoLfoUdkZTTrx+cJioSMtLzn6gQBwEU4lM/QrPOIrqdwl
         WVsHG6GIhSfkQ==
Date:   Mon, 10 May 2021 21:27:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dmaengine: idxd: remove unused variable 'cdev_ctx'
Message-ID: <YJlX7BxruP43f7BR@vkoul-mobl.Dlink>
References: <20210508063012.2624-1-thunder.leizhen@huawei.com>
 <3181e59b-727b-50fd-2c14-78d68a5e09e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3181e59b-727b-50fd-2c14-78d68a5e09e9@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-05-21, 17:26, Dave Jiang wrote:
> 
> On 5/7/2021 11:30 PM, Zhen Lei wrote:
> > GCC reports the following warning with W=1:
> > 
> > drivers/dma/idxd/cdev.c:298:28: warning:
> >   variable 'cdev_ctx' set but not used [-Wunused-but-set-variable]
> >    298 |  struct idxd_cdev_context *cdev_ctx;
> >        |                            ^~~~~~~~
> > 
> > The variable 'cdev_ctx' is not used, remove it to fix the warning.
> > 
> > Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> 
> Thank you. Issue already reported and fix posted here.
> 
> https://lore.kernel.org/dmaengine/324261b0-1fa6-29f7-071a-a3c0ac09b506@intel.com/T/#t

dropped this
-- 
~Vinod
