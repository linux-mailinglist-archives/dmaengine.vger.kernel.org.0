Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769A1B6315
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgDWSNn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWSNm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Apr 2020 14:13:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B929C09B042;
        Thu, 23 Apr 2020 11:13:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so3364866pfd.4;
        Thu, 23 Apr 2020 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFN0/zrQP7F0Mq14HYwfDQmMilQbxmV8QgknbMWRRiA=;
        b=o2cB2aiWMce4KylBe8HnWY7j5AB08CCy4vQabQDeK/Nf2zLPezYcJQizFTt9HcSvSm
         FjFs+2w6vm7NQkx15aSWesYUitcKi85u+EvxDs5mJK9WZP0Ey26mv+4FhqayDgRI6hMB
         Y3VVwSSO2OkjvNX8XEJOxHmrb3C6BU5WC299eeX2kxudo9qYPJ/3yNKauLWUYqNyyi5Z
         E0J3wT9I0noFqW4N6s/AsA0nS8Jl7M9k0anZPnnGyKFi4epKJvMfUSzp3WZOpOE7B/dY
         LmzakcGDHT1Lt0UVnKvfCO/xZ5X+1stmMoh9xqmLBq9Yyn7Ud0Ji81erVcO1R0gjNN5L
         dWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFN0/zrQP7F0Mq14HYwfDQmMilQbxmV8QgknbMWRRiA=;
        b=mZW2dyOnJhfgAYJnUFP8c2bA2824ApYGdaPL8disLaTS8V/YUL/k2YmX6o4TEQlEUq
         WmsnLWK9pyvYitKVvstlhSxo5MNPqvQbpHdS8vZU3LG2qy46e84zDya/vKzCfAHkNtNa
         dBbX7kll9S383FSo6vq//laWVGGrqL2WsZsitmg29aVFOUfFAKU2lhn+ZdRJ+kj/jk44
         ygUAkkZa1N+YgzenXiD4a7nEV0baYNUxnnLfodybXbVlXgAiSvRpgXuq1VZU54ps7G46
         bXkz4V0IQP8MHueZX4SFlkduHCidOwQyzVQmEYDaJZ2NYA7DxAMgwHmm0xUZpANmCDNH
         1jhQ==
X-Gm-Message-State: AGi0PuZALKzcY+ec+M6tLgizcyoKBa1KzCcKAzTVSU+v/bxF8e2kNlLr
        qqs/1GtNHupOzAQA7nYbPw==
X-Google-Smtp-Source: APiQypKgpA/BxrJZSp+4DE6piw6U7i9z+juTdGZ7bdsEmHqatwrxP8Xd0T5SszBpQPq7A02GlbgWqw==
X-Received: by 2002:a63:68c1:: with SMTP id d184mr4982644pgc.231.1587665621977;
        Thu, 23 Apr 2020 11:13:41 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d22:fee6:34b8:6e26:7d76:a7bd])
        by smtp.gmail.com with ESMTPSA id q187sm3072238pfb.131.2020.04.23.11.13.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 11:13:40 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 23 Apr 2020 23:43:35 +0530
To:     Vinod Koul <vkoul@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers: dma: pch_dma.c: Avoid data race between probe
 and irq handler
Message-ID: <20200423181334.GA23094@madhuparna-HP-Notebook>
References: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
 <20200423061935.GV72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423061935.GV72691@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 23, 2020 at 11:49:35AM +0530, Vinod Koul wrote:
> On 16-04-20, 11:53, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > pd->dma.dev is read in irq handler pd_irq().
> > However, it is set to pdev->dev after request_irq().
> > Therefore, set pd->dma.dev to pdev->dev before request_irq() to
> > avoid data race between pch_dma_probe() and pd_irq().
> 
> Please use the right subsystem tag for patch. You can find that using
> git log on the respective subsystem, in this case it would have told you
> that it is dmaengine.
>
Sure, I will take care of this.

> I have fixed that up and applied it, thanks for the patch
>
Thank you,
Madhuparna
> -- 
> ~Vinod
