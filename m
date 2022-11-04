Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F66197D5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 14:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKDN1c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiKDN0V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 09:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E542EF33;
        Fri,  4 Nov 2022 06:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864E2621CE;
        Fri,  4 Nov 2022 13:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F79EC433C1;
        Fri,  4 Nov 2022 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667568325;
        bh=2PFxzBX7s+64u62MIo+teBpcFai9aBCYC6SoIUVdvu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSKfg4d7QirVYt7cnopx9vZPyiYmPIGnzXJMYNGjw7bGcPGwPo846lkOLSdSRbtLg
         piV+CXpQMqCRFzDbY/XNg/BYBYbpwBfdVoMYUe83kNESKXzncVNaUUI2PDwyCeTNPp
         rzlYWysq4tDGtWnE5ULboOWlL4wTS3pNNEzH0Jcecdexyi8UMplnofrl68EW96RVn+
         Wsj+UcIAKFX4L4ZLvjyDNnILck73HWn1H3Xq2FMnzhO0lmfvm/9OwjINHvTWJe35V7
         ZzB4oxa71pCLz3kupGs2qKTqkHCCIS1KjKYDcZkkiJ0Zy9fmMKJc3NZ2NI1bRnv6za
         hlaBbhFIyhczQ==
Date:   Fri, 4 Nov 2022 18:55:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Koba Ko <koba.ko@canonical.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <Y2USwbAzuaCKTGdX@matsya>
References: <20220930173652.1251349-1-koba.ko@canonical.com>
 <20221102180726.fuwwk2npsse56ius@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102180726.fuwwk2npsse56ius@cantor>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-11-22, 11:07, Jerry Snitselaar wrote:
> Hi Vinod,
> 
> Thoughts on this patch?
> 
> Maybe changing the summary to "dmaengine: Fix double increment of client_count in dma_chan_get()"
> would be clearer?

Yes that would be better

> 
> On Sat, Oct 01, 2022 at 01:36:52AM +0800, Koba Ko wrote:
> > If the passed client_count is 0,
> > it would be incremented by balance_ref_count first
> > then increment one more.
> > This would cause client_count to 2.
> >
> > cat /sys/class/dma/dma0chan*/in_use
> > 2
> > 2
> > 2
> 
> Would this be better?
> 
>     The first time dma_chan_get() is called for a channel the channel
>     client_count is incorrectly incremented twice for public channels,
>     first in balance_ref_count(), and again prior to returning. This
>     results in an incorrect client count which will lead to the
>     channel resources not being freed when they should be. A simple
>     test of repeated module load and unload of async_tx on a Dell
>     Power Edge R7425 also shows this resulting in a kref underflow
>     warning.

Agree, also if you have the underflow warning handy, do add it to the
log

-- 
~Vinod
