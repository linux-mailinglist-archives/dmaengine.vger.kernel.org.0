Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1739123F69
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 07:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfLRGLN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 01:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLRGLN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 01:11:13 -0500
Received: from localhost (unknown [27.59.34.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE2220733;
        Wed, 18 Dec 2019 06:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576649472;
        bh=FGH/kEOVkz0IpYK/6ZR33gCKIy3N0BmqgPpHbM5AvwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJF52iRZ/ocILvxdLGVMXK2Gq20Vs9g+BudF30kmn9Gk5WN7fI/Liy5gOhRgqG1wd
         /elbMhiJAu3bmbZz7rYoP+dfyn5+lCBkMnGnLqMAwJA71AOinZvcCXy/p3oa4gPnSb
         NJS3u/Frr4Zwwfz75rxB3VNYUP3nXQLN0svq6R+4=
Date:   Wed, 18 Dec 2019 11:41:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: ti: edma: Fix error return code in
 edma_probe()
Message-ID: <20191218061106.GR2536@vkoul-mobl>
References: <20191212114622.127322-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212114622.127322-1-weiyongjun1@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-12-19, 11:46, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.

Applied, thanks

-- 
~Vinod
