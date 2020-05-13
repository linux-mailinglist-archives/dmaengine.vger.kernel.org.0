Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D511D122A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEMMDr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 08:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEMMDr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 08:03:47 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB72206CC;
        Wed, 13 May 2020 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371426;
        bh=jgsvEj4hSp2KHLWxRQq4uLcCV2APGpBgXkd4qjzuuS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0a4nebR/bFTaCFNsP/skJdIa7ZZ+JKTWA2wtFHGnX4KbMT+74EqKRtiSEHWLYkx/
         Nkh3rNpX9HqszmdJ/c117ZObpGsajqHnQDVFb0O3VGKZmOi1S8Idc04eMqkhf9CdbY
         6uDdjYJiwFp4qiY+xY75pgyIubZ/BHoQoixxbHls=
Date:   Wed, 13 May 2020 17:33:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: moxart-dma: Drop pointless static
 qualifier in moxart_probe()
Message-ID: <20200513120342.GH14092@vkoul-mobl>
References: <20200505101353.195446-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505101353.195446-1-yuehaibing@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-20, 10:13, YueHaibing wrote:
> There is no need to have the 'void __iomem *dma_base_addr' variable
> static since new value always be assigned before use it.

Applied, thanks

-- 
~Vinod
