Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F7E77E4E0
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbjHPPRT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbjHPPQt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 11:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310F1987;
        Wed, 16 Aug 2023 08:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60BFC653FD;
        Wed, 16 Aug 2023 15:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4148CC433C7;
        Wed, 16 Aug 2023 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692199006;
        bh=RiV/mx1g8NJ0W8pjhCev/3TqAoyjGUb/fK24JyWQPos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzPojsfhCVGG/gnE90Br9t3myMafCDPAPrFtXkOLf75DZ0h41Hq9C+Sb4OVhS3ed7
         kNxptuMTLF4vw5ip+5ijKl+NIYEWLPUch1bpYeFiHYp/DNt8alM7rSksXLzAZM0EH3
         POzoHvgwGxV+Xwjex2TzX1+36rOKdrEAWK1fS40A=
Date:   Wed, 16 Aug 2023 17:16:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     coolrrsh@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] dma: dmatest: Use div64_s64
Message-ID: <2023081654-dormitory-vocally-02f7@gregkh>
References: <20230816060400.3325-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816060400.3325-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 16, 2023 at 11:34:00AM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> In the function do_div, the dividend is evaluated multiple times
> so it can cause side effects. Therefore replace it with div64_s64.
> 
> This fixes warning such as:
> drivers/dma/dmatest.c:496:1-7:
> WARNING: do_div() does a 64-by-32 division,
> please consider using div64_s64 instead.
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/dma/dmatest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index ffe621695e47..07042f239db8 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/math64.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/freezer.h>
> @@ -493,7 +494,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
>  
>  	per_sec *= val;
>  	per_sec = INT_TO_FIXPT(per_sec);
> -	do_div(per_sec, runtime);
> +	per_sec=div64_s64(per_sec, runtime);

Please always run checkpatch.pl on your changes before submitting them
for others to review.

thanks,

greg k-h
