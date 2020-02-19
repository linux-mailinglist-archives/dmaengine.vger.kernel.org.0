Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10B316401E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSJR7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 04:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgBSJR7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 04:17:59 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DE721D56;
        Wed, 19 Feb 2020 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582103878;
        bh=ryVYryIobjSVx+pW5LLK3jBFpRtMoBclGB/Qtjpwt50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIXfl5SDg41ZN+XnQWii24UwvPYahnAiB2YtjcP82LkH/oPN2mGKXD7mWbshweBCg
         RxrkqewZvqYYpeDWTrIUMCL+ogeyBS7gPSwdzvlikwGXX/X+Z8C6yOcCf6x8ON0uXU
         7r507UQVbro9oQ/Gykr82vkDdUBycSuBbXEncAY8=
Date:   Wed, 19 Feb 2020 14:47:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: coh901318: Fix a double lock bug in
 dma_tc_handle()
Message-ID: <20200219091754.GE2618@vkoul-mobl>
References: <20200217144050.3i4ymbytogod4ijn@kili.mountain>
 <CAMuHMdWaCqZ_zcHuBetAQu4kmoffNw5jvHM5ciTi29MAxL70bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWaCqZ_zcHuBetAQu4kmoffNw5jvHM5ciTi29MAxL70bg@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-02-20, 23:24, Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Mon, Feb 17, 2020 at 3:41 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The caller is already holding the lock so this will deadlock.
> >
> > Fixes: 0b58828c923e ("DMAENGINE: COH 901 318 remove irq counting")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > This is the second double lock bug found using static analysis.  The
> > previous one was commit 627469e4445b ("dmaengine: coh901318: Fix a
> > double-lock bug").
> >
> > The fact that this has been broken for ten years suggests that no one
> > has the hardware.
> 
> Or this only runs CONFIG_SMP=n kernels?
> This seems to be used in arch/arm/boot/dts/ste-u300.dts only, and
> CONFIG_ARCH_U300 is a ARCH_MULTI_V5 platform, which looks like
> it doesn't support SMP?

Should we drop the driver then..?

-- 
~Vinod
