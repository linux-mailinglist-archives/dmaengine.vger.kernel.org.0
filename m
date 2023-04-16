Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FC6E3930
	for <lists+dmaengine@lfdr.de>; Sun, 16 Apr 2023 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDPOYZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Apr 2023 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDPOYY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Apr 2023 10:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A18B2D4C;
        Sun, 16 Apr 2023 07:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA650611AA;
        Sun, 16 Apr 2023 14:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5246C433EF;
        Sun, 16 Apr 2023 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655062;
        bh=DRmjqzj0vppDmwa+O86tDrM1feeK6o2CP6HsH/iSM5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wt/oOFIOb7ClzTlXeE51KP9dzjzQfnpaiY0WTAv4NobCq54yPwX5qV/qjjK/b0RrA
         cpavE5HEA9pj+xEdppDeLnD/JC67azwEuGpvp6wlEFOrandFtCm1FLhthsjnoARCsp
         XbNcXBC/3+tzrgybHGZg2B/Z5GdRPXfgWYT6g5oal0L863CtHpHi3Z6ZUIdoWsrG6H
         fvHFyV6Zl1d/K/RanvVcGEJV8WMozjP5AR1oxJ/JIAkgq8r2+bL3UVAVQGJocbYUZU
         2RxLvisVOdPSoWac6/WZtNAFJhHG2iDLOUYXsZ6B59lSpqZLjEIBxDfmVr42E/nhhT
         3e1p5nnM2kGlA==
Date:   Sun, 16 Apr 2023 15:24:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 03/11] iio: buffer-dma: Get rid of outgoing queue
Message-ID: <20230416152422.477ecf67@jic23-huawei>
In-Reply-To: <20230403154800.215924-4-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
        <20230403154800.215924-4-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon,  3 Apr 2023 17:47:52 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> The buffer-dma code was using two queues, incoming and outgoing, to
> manage the state of the blocks in use.
> 
> While this totally works, it adds some complexity to the code,
> especially since the code only manages 2 blocks. It is much easier to
> just check each block's state manually, and keep a counter for the next
> block to dequeue.
> 
> Since the new DMABUF based API wouldn't use the outgoing queue anyway,
> getting rid of it now makes the upcoming changes simpler.
> 
> With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and can
> be removed.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> v2: - Only remove the outgoing queue, and keep the incoming queue, as we
>       want the buffer to start streaming data as soon as it is enabled.
>     - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
>       same as IIO_BLOCK_STATE_DONE.

I'm not that familiar with this code, but with my understanding this makes
sense.   I think it is independent of the earlier patches and is a useful
change in it's own right.  As such, does it make sense to pick this up
ahead of the rest of the series? I'm assuming that discussion on the
rest will take a while.  No great rush as too late for the coming merge
window anyway.

Thanks,

Jonathan

