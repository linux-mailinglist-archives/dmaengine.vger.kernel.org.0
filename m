Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4FBE653
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfIYU2p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 16:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbfIYU2o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 16:28:44 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F8921D7A;
        Wed, 25 Sep 2019 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569443324;
        bh=rE3Bp+UoIT5tfW9FqIroPRLshqWYl9G6V3AQ0ixdge0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnf7mfgVz/B4x6UJZYTYJRioxu9Bw+EJ3mnxGrBzSyenGOCbZL9WvmoNESNMZT25/
         R0EnDUJ5R95doogvxlFZmO8ZDBLY8Ie/vqTWB/w3fFq+PGV44O+oWLddIIi2G/r6aB
         B4sEwVP/YaljS7gMl8IZYP8pddUAxXIdsUEryFE0=
Date:   Wed, 25 Sep 2019 13:27:43 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dan.j.williams@intel.com, peter.ujfalusi@ti.com, arnd@arndb.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: ti: edma: remove unused code
Message-ID: <20190925202743.GJ3824@vkoul-mobl>
References: <20190905060249.23928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905060249.23928-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 14:02, YueHaibing wrote:
> drivers/dma/ti/edma.c: In function edma_probe:
> drivers/dma/ti/edma.c:2252:11: warning:
>  variable off set but not used [-Wunused-but-set-variable]
> 
> 'off' is not used now, so remove it.

Applied, thanks

-- 
~Vinod
