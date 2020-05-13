Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686E91D115D
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgEMLaz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 07:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEMLax (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 07:30:53 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9660C206D6;
        Wed, 13 May 2020 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589369453;
        bh=JkZKKNBGFWDwpNuFyBv0vrcVXr+0dJ8oVfOopQ4awrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNH/hAxvcdvPY8RVAOjb3eTqhE03823T7AKDl+K8CbL0L2VEH5oqsapmTb6/cfAbj
         a3h7P/z4TTwMVuZhuEBYyJdbClDAAxLJ/TBXxPyLxysTijbEJvS5pulRn6LKl1Cz57
         xfzrnJZWj+uVxiaWsNX0tSgs/W4d2F/5Zs+/BIxg=
Date:   Wed, 13 May 2020 17:00:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     dmaengine@vger.kernel.org, seraj.alijan@sondrel.com
Subject: Re: [PATCH] dmaengine: dmatest: Restore default for channel
Message-ID: <20200513113049.GE14092@vkoul-mobl>
References: <20200429071522.58148-1-vladimir.murzin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429071522.58148-1-vladimir.murzin@arm.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-20, 08:15, Vladimir Murzin wrote:
> In case of dmatest is built-in and no channel was configured test
> doesn't run with:
> 
> dmatest: Could not start test, no channels configured
> 
> Even though description to "channel" parameter claims that default is
> any.
> 
> Add default channel back as it used to be rather than reject test with
> no channel configuration.
> 
> Fixes: d53513d5dc285d9a95a534fc41c5c08af6b60eac ("dmaengine: dmatest: Add support for multi channel testing)
> 

no need for blank line here

> Reported-by: Dijil Mohan <Dijil.Mohan@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/dma/dmatest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index a2cadfa..5e1fff9 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -1166,10 +1166,11 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
>  		mutex_unlock(&info->lock);
>  		return ret;
>  	} else if (dmatest_run) {
> -		if (is_threaded_test_pending(info))
> -			start_threaded_tests(info);
> -		else
> -			pr_info("Could not start test, no channels configured\n");
> +		if (!is_threaded_test_pending(info)){

We need space before {

That is why we need to run checkpatch before sending patches.

I have fixed that up and applied this

-- 
~Vinod
