Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6558D5E6D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfJNJQj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 05:16:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfJNJQj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 05:16:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so10059796pfw.2
        for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2019 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAld8BuG9x3VG/IVJTpjEzDBkop1lK3AvA+bS4j1hH4=;
        b=YNp4sqTkZTX6BMntUWG1fz9XZahuV0T/cWnBu1KyOeP6b71Q03g2rZNdGbiQShQSBM
         +QvLnXYU+r5L+53M0b3SCA6QvVFCc7as+lLUrjEzPkT5XCFc9BcllKbNFLrF5SiVGKd4
         FAL50S0dqJoysqViNHaaGPjI98odGLfh4JfRhhEQLBSEzNjUidfx78pJ0/tIELzEp68c
         l0voGVIPHT4ME+9KGlbof9V1g1A9/L+jsfdKo3rViA+k9MQ+byIPfgr6f6Owv5G6gBS0
         4B6UH4iHBzeQXb6AmVzhW079TmgaN183ZP950jOSPjMy3ZMeriym7CYzh7/4o/xtvrsv
         zATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAld8BuG9x3VG/IVJTpjEzDBkop1lK3AvA+bS4j1hH4=;
        b=Ppogm2Fz+F6fr8tC/tRH/zJvkpVevrHKkzyuG2cuBJ8pIVYfqPlU/+vyjDSue8jdCF
         NWItNx27LH4rIXXeIcKfnAwjkWUnLdIurcW+CcjkNRfPQEgj4Ch2Bpt/wWO0ljCQTRlu
         jrN3gCtIoSIjWknYmEHtG7CHeib6pEXhdB8IW7kP4FvQWYRqo1vrqjC1v0WeJvr68jX1
         H7dLI1RytJdMmQ+ey/msgiYOsWYDHF6I9UVBFTvwADknLxb7LmNg4PWcESBWG9kgwkxQ
         T7rubsUoUJTWbLt5M3PHe15vni52WHsAd+J48LlJV8iULWx01Z5mPwkdjsPadZGVdr+I
         6hFA==
X-Gm-Message-State: APjAAAXWlmVZneOZdBL1OCiKqLh4/QgWVNoicCeRONqOilKeYlos5/pA
        W9N+wFE44c4ewXU4ViyvRQaOAA==
X-Google-Smtp-Source: APXvYqyxI0PqVoidnFpR5bxVCCOb5c06PIr1as5pGu3LZ8sBxz0vEm6lITxTxYWBwbiuUp3E5+gYXA==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr31284492pgh.26.1571044598198;
        Mon, 14 Oct 2019 02:16:38 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f128sm17926385pfg.143.2019.10.14.02.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 02:16:37 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:46:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: dw: platform: Mark 'hclk' clock optional
Message-ID: <20191014091635.ekr7gl3i3dahttkk@vireshk-i7>
References: <20190924085116.83683-1-andriy.shevchenko@linux.intel.com>
 <20191014082128.GN2654@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014082128.GN2654@vkoul-mobl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-10-19, 13:51, Vinod Koul wrote:
> On 24-09-19, 11:51, Andy Shevchenko wrote:
> > On some platforms the clock can be fixed rate, always running one and
> > there is no need to do anything with it.
> > 
> > In order to support those platforms, switch to use optional clock.
> > 
> > Fixes: f8d9ddbc2851 ("Enable iDMA 32-bit on Intel Elkhart Lake")
> 
> My script complained the Fixes doesnt match, you seem to have omitted
> the subsystem and driver name tags from this line.

Better to automate getting these tags the way Documentation says.

Keep following in your gitconfig file:

[pretty]
        fixes = Fixes: %h (\"%s\")
        onelin = commit %h (\"%s\")

and then you can do:

git log --pretty=fixes OR --pretty=onelin

to get the tags in correct format.

-- 
viresh
