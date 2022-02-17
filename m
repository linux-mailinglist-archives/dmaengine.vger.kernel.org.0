Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE74BA8B5
	for <lists+dmaengine@lfdr.de>; Thu, 17 Feb 2022 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiBQStd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Feb 2022 13:49:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiBQStc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Feb 2022 13:49:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFA51338;
        Thu, 17 Feb 2022 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KT4HnucK16+RSYEwIMlsvOnUYi1BdaERlrwptdyeMjo=; b=W3EHhcKTCdUOlRZ/wcV0jHM1Am
        4aQR4HvOJ4ThXsATD0GwyVAq60dvKepEue/zVecj5a+aeaN7t/jI+T7eEuEocCi7QP47FHXT22IK9
        h31WbwqR0VabAr5xHINL7Pox9r7In89Eo75AtNLPoXsL4BE9aQs7wVKcyaoVy5oRhAEaLq72ebUgy
        u04JPlT7Eddy8bX3aep5nbkiz7sE4/vT2V/uBVg6H759vdfc3BfqIuCqjbTrfacjeaYW1qsJ2DeVL
        O/F1Os2zG9jiRnSYe9aI6IxqHQ7h783v1zYzn0Wo/AGHgBa7cBWUNOUXtNkSm8GAVHkDuTdvC90gc
        HYVfB1hw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKlq2-00FrJn-SJ; Thu, 17 Feb 2022 18:49:11 +0000
Message-ID: <078be2a1-707c-2e18-4b93-27dce25b1c46@infradead.org>
Date:   Thu, 17 Feb 2022 10:49:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dma: ti: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, vkoul@kernel.org, peter.ujfalusi@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217182546.3266909-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220217182546.3266909-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/17/22 10:25, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'the'
> 
> Replacements
> completetion to completion
> seens to seen
> pendling to pending
> atleast to at least
> tranfer to transfer
> multibple to a multiple
> transfering to transferring
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  drivers/dma/ti/cppi41.c   |  6 +++---
>  drivers/dma/ti/edma.c     | 10 +++++-----
>  drivers/dma/ti/omap-dma.c |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)


-- 
~Randy
