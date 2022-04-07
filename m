Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590224F7761
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiDGHZI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDGHZH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 03:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26DD2611
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 00:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7975161DED
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 07:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217C2C385A4;
        Thu,  7 Apr 2022 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649316187;
        bh=KvIdd0ycaEXexE1vm5JQcoPJWkaBXRVez9YZ66kA3Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnX00TSrNZs9nIbukr1MEXXuPchWvSqmgiYrfMBjg8//U2HmvC9WgExSZ5+3kSluO
         Ac1F4EEcPWh1sNhuGo9xgfqHqjZnFdP1/52aQ/bpK1c469n9Chj45UyuQQw7sL97P4
         dlhKrOxIO3LVWt9JtwnZi+OaUF6+0p0PpqDLflH+n6sh3UlmQDboU0bxdqa87FyR60
         u7I5+S0nEvFJCXR1mWOLzsjVPJULgDW8CYFnTFbjKYSVh7RLoPk4m2f9Ucbe6k47Jp
         +r6yrdzmJZ4PvL1/6uO8xBt3harzCmicnRFMOeN2HZtX+nmJN/acpQqPF1WX4QeFwv
         KPsUx2qQ8CUVw==
Date:   Thu, 7 Apr 2022 12:53:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <Yk6RV2xEVqYOjhZN@matsya>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
 <YkU7cYhZUuGyWbob@matsya>
 <20220331064903.GC4012@pengutronix.de>
 <YkVQNhTpeIT7qO/7@matsya>
 <20220401120137.GK4012@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401120137.GK4012@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-04-22, 14:01, Sascha Hauer wrote:
> On Thu, Mar 31, 2022 at 12:24:46PM +0530, Vinod Koul wrote:

> > > I have put this into include/linux/platform_data/dma-imx.h because
> > > that's the only existing include file that is available. I could move
> > > this to a new file if you like that better.
> > 
> > Lets move to include/linux/dma/
> 
> What about the other stuff in include/linux/platform_data/dma-imx.h,
> should this go to include/linux/dma/ as well? There is nothing in it
> that is platform_data at all.

Move that as well please, perhaps a move patch and then the new addition

-- 
~Vinod
