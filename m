Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406354E29E
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiFPN4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiFPN4m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 09:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230546B2A
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 06:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A7EB823C4
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 13:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654E6C34114;
        Thu, 16 Jun 2022 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655387798;
        bh=nWuMbDfMp2zzBoRWgMzgvNmbkP/03B+daOFjbJR4HVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjpzPC0ETVbnP8ghjYipglTA2WfQB9HFh4sx48Dl/Zod8h7WZoO6eXyEaNoclIs0O
         skPu3JuS0nzo5Ryh25LTRzpVmIkaTFxT+Cd/KHkR4XSLx6PNKAaFPKLe6KrqnqpYrD
         qPjimInAyd7xQ/3bhbnlVOvfCkR7q4qrtdDCZi70Np7/jK3lnbkijY79mqKeC2IViw
         rBsNIdurHhwjU1dL7Ir0TCxjaXXpp6RDZguOdscPRlwHIlStZcS/4/wjF6fIMQXL8Y
         EMGnrv6RJtKOT08Gvi6r6ILHXNvbHhNow81AoZStVHvSrQ09ugxKhKfF7qrGl9VSKo
         JW2lHUCxvGF9w==
Date:   Thu, 16 Jun 2022 06:56:37 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lznuaa@gmail.com, vladimir.zapolskiy@linaro.org,
        gustavo.pimentel@synopsys.com, herve.codina@bootlin.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: remove a macro conditional with
 similar branches
Message-ID: <Yqs2lfGPMNMkEbi+@matsya>
References: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
 <20220615133621.28027-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615133621.28027-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-22, 08:36, Frank Li wrote:
> On Fri, Jun 10, 2022 at 05:49:36PM +0530, Vinod Koul wrote:
> > On 10-06-22, 13:07, Vladimir Zapolskiy wrote:
> > > After adding commit 8fc5133d6d4d ("dmaengine: dw-edma: Fix unaligned
> > > 64bit access") two branches under macro conditional become identical,
> > > thus the code can be simplified without any functional change.
> > 
> > Applied, thanks
> 
> @vinod:
> 	I am very strang!
> 	why you pick this patch, not pick one this one
> 	https://www.spinics.net/lists/dmaengine/msg29735.html

Maybe it was on top of the queue for me..

> 	
> 	both patch do the exactly the same works.
> 
> 	Any no any feedback about patches 
> 	https://www.spinics.net/lists/dmaengine/msg29913.html.
> 	which already review 12 round and test at three difference platform.
> 	And at least 3 person working on these patches. 

People can be busy, due to travel/work etc, pls have patience with
reviews. FWIW, I have picked this already

> 
> 	At least https://www.spinics.net/lists/dmaengine/msg29914.html is cleanup
> 	And only two lines change.
> 
> 	At begin, I think you don't care dw_edma at all. 
> 	But you pick this patch. 

Based on my bandwidth, I will pick patches, I dont pick during or before
merge window... It is unfair to say I dont care about a specific driver.
Smaller changes are quick to review and do the needful, larger ones need
more time for review...

-- 
~Vinod
