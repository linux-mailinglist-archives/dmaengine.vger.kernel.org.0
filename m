Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8733776DD
	for <lists+dmaengine@lfdr.de>; Sun,  9 May 2021 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhEIN7v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 May 2021 09:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhEIN7u (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 9 May 2021 09:59:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5462761352;
        Sun,  9 May 2021 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620568727;
        bh=jy+c/MRGNZzgQtvHeGWu7ND4F9yRMF4b7fI/CJwYVns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD1bNRPFbBq+ZolvfhDr6AiLY5D7wGlRM577dux5QDuU8g44Mp69o8BD5tDu5ev+L
         j1ryqq+2usS2Lv6b0mFCAS27tsoxXYgxu+231Nxcq0gcD8KlRby4zV5S7CKZ3qtiFx
         10b+DJ31rJ8SdYsYq5bA4lkwCG97xxhho+6HDaUpDDTpzZftAF3ASUnihX7EdL0CcJ
         s8Iiz8apBa/CFa1dlmObQtMnKF7GzKY6pqoBKmoLBKIodaNgl4qSsSyb8jVLu6kwRp
         ZvAW9TymeAgzpU9xipIopW4dMLnySrWFtLzHym0i727I3W+TCT+Rv4YORlO0NpbQeV
         bkMdU0cZzSNtQ==
Date:   Sun, 9 May 2021 19:28:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        dmaengine@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH v2 14/17] dma: qcom: bam_dma: Create a new header file
 for BAM DMA driver
Message-ID: <YJfqk/0Whr2Qfxjb@vkoul-mobl.Dlink>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
 <20210505213731.538612-15-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505213731.538612-15-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-21, 03:07, Bhupesh Sharma wrote:
> Create a new header file for BAM DMA driver to make sure
> that it can be included in the follow-up patch to defer probing
> drivers which require BAM DMA driver to be first probed successfully.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 283 +-----------------------------------
>  include/soc/qcom/bam_dma.h | 290 +++++++++++++++++++++++++++++++++++++

1. Please use -M with move patches...

2. susbsytem is dmaengine

3. Why move..? These things are internal to the driver and I dont think
it is wise for clients to use everything here... If the client needs to
know defer probe, it should request a channel and check the status
returned for EPROBE_DEFER

Thanks

-- 
~Vinod
