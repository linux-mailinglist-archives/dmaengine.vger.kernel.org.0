Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4644E26F654
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIRGwT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 02:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgIRGwT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 02:52:19 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7677B2076A;
        Fri, 18 Sep 2020 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600411939;
        bh=htRsgl6utV3W8b/u+GiV8r/Zl69DqcE8WOpd56JrAyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1kLN5d9aawT1CJAs21a/uhN7gRLbqcBL5i3fSVI8XsnyvE8j79Shv00PM7vZkHvz
         Uu7/Nhp4SvHuxVudtfSccFA2dRWituJ4kVkWBYQSYeY8Pa+OG5HZF2d0ZnEW1UhM4d
         hEhJ4G5XgnMEt96wLaJLS7MmWOMN6AZ9n/m3Rpro=
Date:   Fri, 18 Sep 2020 12:22:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 00/35] dmaengine: convert tasklets to use new
Message-ID: <20200918065215.GE2968@vkoul-mobl>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-08-20, 16:05, Allen Pais wrote:
> Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> introduced a new tasklet initialization API. This series converts
> all the dma drivers to use the new tasklet_setup() API

Patch 'dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API' failed to apply for me, have skipped that.

Applied rest except fsl one where I have picked the resend version.

Thanks
-- 
~Vinod
