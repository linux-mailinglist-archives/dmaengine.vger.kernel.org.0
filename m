Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF550859B
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiDTKSg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377524AbiDTKSf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:18:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF506415;
        Wed, 20 Apr 2022 03:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AB14B81DD6;
        Wed, 20 Apr 2022 10:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D248C385A0;
        Wed, 20 Apr 2022 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650449747;
        bh=I2X20qgTvj1B6zHaXLwcUVeCqOXjvFSsK098pm/tD9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tO+Ksg7TqAf+MuBMvxybw77DUg0RCFRYuRpcCRnA8161LhE3uHnSA0mCslgthPXGU
         JE9eSszL0zEzq0fTeS3/dCyyjufVhTp2r1OCRW+6rE5D4MER/Bcbi50LieecV0bD90
         W79VR6huVSk7UkJHaD47y1jqv0JipNxbvApR+TLJnGAPzQaKgnFUgZtgbCv7oIinr1
         low6elIUCKF6aqnI4J91666OrnaZmJZWF3er5XECcPGVEFEzX69vLZbws/wajmx5z7
         1UGpcoCprI4wFP4GCM3nUOylMttVlD9TOHOwoOXFBmR9RSeva9Ekjp/zX/V0fWOx+i
         ldDpscv9mgBAg==
Date:   Wed, 20 Apr 2022 15:45:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     sugar zhang <sugar.zhang@rock-chips.com>
Cc:     Huibin Hong <huibin.hong@rock-chips.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: Fix unbalanced runtime PM
Message-ID: <Yl/dTqT9MLhws6g6@matsya>
References: <1648296988-45745-1-git-send-email-sugar.zhang@rock-chips.com>
 <YlQxy0e/39M4xTdL@matsya>
 <5f13aa47-92cd-6c71-66f5-c5513a36b277@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f13aa47-92cd-6c71-66f5-c5513a36b277@rock-chips.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-04-22, 21:53, sugar zhang wrote:
> Hi Vinod,
> 
> 在 2022/4/11 21:48, Vinod Koul 写道:
> > On 26-03-22, 20:16, Sugar Zhang wrote:
> > > This driver use runtime PM autosuspend mechanism to manager clk.
> > > 
> > >    pm_runtime_use_autosuspend(&adev->dev);
> > >    pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
> > > 
> > > So, after ref count reached to zero, it will enter suspend
> > > after the delay time elapsed.
> > > 
> > > The unbalanced PM:
> > > 
> > > * May cause dmac the next start failed.
> > > * May cause dmac read unexpected state.
> > > * May cause dmac stall if power down happen at the middle of the transfer.
> > >    e.g. may lose ack from AXI bus and stall.
> > > 
> > > Considering the following situation:
> > > 
> > >        DMA TERMINATE               TASKLET ROUTINE
> > >              |                            |
> > >              |                       issue_pending
> > >              |                            |
> > >              |                     pch->active = true
> > >              |                       pm_runtime_get
> > >    pm_runtime_put(if active)              |
> > >      pch->active = false                  |
> > >              |                      work_list empty
> > >              |                            |
> > >              |                     pm_runtime_put(force)
> > maybe unconditional is a better word than force here?
> okay, will do in v2.
> > 
> > >              |                            |
> > > 
> > > At this point, it's unbalanced(1 get / 2 put).
> > > 
> > > After this patch:
> > > 
> > >        DMA TERMINATE               TASKLET ROUTINE
> > >              |                            |
> > >              |                       issue_pending
> > >              |                            |
> > >              |                     pch->active = true
> > >              |                       pm_runtime_get
> > >    pm_runtime_put(if active)              |
> > >      pch->active = false                  |
> > >              |                      work_list empty
> > >              |                            |
> > >              |                   pm_runtime_put(if active)
> > >              |                            |
> > > 
> > > Now, it's balanced(1 get / 1 put).
> > > 
> > > Fixes:
> > > commit 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
> > > commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
> > That is not the right way for Fixes tag
> 
> like this?
> 
> Fixes: 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
> Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")

yes, this is the correct way

-- 
~Vinod
