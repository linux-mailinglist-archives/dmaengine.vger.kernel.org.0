Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B737B1B7E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjI1L4f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjI1L4d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F319E;
        Thu, 28 Sep 2023 04:56:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3009CC433CA;
        Thu, 28 Sep 2023 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902185;
        bh=XxBvxdoKc83ZQ4fVBEiJGRQrBFbU2kUDHfYCAEg3rO0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DWs/AJmjugNYilFIwyJtJX5bMS+Av8SjZ7hvdvGjmfxUA+vbf3AmvJLj68u5hwk6t
         qCo6qsWmzxUVGTgjNSDb2ZHL9NtBVtUI3CTA6/2z72ACNT8ZQa51kfgf9PMIkZyvar
         oWA1BHoZa9twamGK3cgYXWLp+D5wBKLCS0Vh3kwk/UVDROBY+cB1GyF6Ddx/t1av12
         2lWslrbs/i6en8kZFj+m+gtGApT8vsffb/qWg/5AWiGBcmmkZEpZz/auAU3wzQ06vC
         8TIBt6NAQH3RCuLC5CrCP2OnTWuhsMJKak2UWXkDIAbWu8DHvi0Ja1UkpVJL6/PE+G
         rYVVz4v5JQFUw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
In-Reply-To: <20230919073801.25054-1-kaiwei.liu@unisoc.com>
References: <20230919073801.25054-1-kaiwei.liu@unisoc.com>
Subject: Re: [PATCH V3] dmaengine: sprd: add dma mask interface in probe
Message-Id: <169590218283.152265.463442694069911752.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:22 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 19 Sep 2023 15:38:01 +0800, Kaiwei Liu wrote:
> In the probe of DMA, the default addressing range is 32 bits,
> while the actual DMA hardware addressing range used is 36 bits.
> So add dma_set_mask_and_coherent function to match DMA
> addressing range.
> 
> 

Applied, thanks!

[1/1] dmaengine: sprd: add dma mask interface in probe
      commit: 47b077c21590490f5bcb8ee80c66ce7a6c201d11

Best regards,
-- 
~Vinod


