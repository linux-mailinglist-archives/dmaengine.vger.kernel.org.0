Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F3605EB8
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJTLWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJTLWT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 07:22:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4B120EE0;
        Thu, 20 Oct 2022 04:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C24E3B82665;
        Thu, 20 Oct 2022 11:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EF1C433D6;
        Thu, 20 Oct 2022 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666264931;
        bh=2+t7qUSOpOIRWsabFBDT0nBgM2tvpVVOWD4jKOlDYp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEwBtoU1iUj780143KKiq7VuU2oN5kJ5X8wuFE7chzYMf3rp4fBmZ7PuDYX4Yb881
         bjLzoIQpn+jW78h8orQlt5PqdUCCcnSN4rDZRZ4JYJqYBZp566ap6uiTRb8G3n7UVf
         w/XDscXzo3VmgH5DriUYjaXVx2wXIdkxmSZlmpfNxqSsydnTZw/MaUK6WQHmH9Mymx
         MugFTbkA2FlHhe6AJ5FU3goE9EqEyQRKHIxYFwDpV2x1cg9VuI/0mz68TSyKDmRCVg
         awgJdAEBPud3Im5YdOHkOnTfNu5SWI1Akuei7pVtABLTJmH3nrYlIQrNivDDN9d2KX
         zvD9Ypqk3QXTA==
Date:   Thu, 20 Oct 2022 16:52:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Cixi Geng <gengcixi@gmail.com>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cixi Geng <cixi.geng1@unisoc.com>
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
Message-ID: <Y1EvX+hL/LWBnuvX@matsya>
References: <20221003234929.186290-1-gengcixi@gmail.com>
 <Y1AEngC3y9+OyG5S@matsya>
 <CAF12kFsKV3dY4pTxv5TxHZ0=WWnNRtjTwJfzrrs0_9YGvBwu_w@mail.gmail.com>
 <a20f43dd-3259-5251-6c13-73664a600c42@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20f43dd-3259-5251-6c13-73664a600c42@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-22, 16:15, Baolin Wang wrote:

> > > why is sprd_dma_int_type part of driver interface. sprd_dma_int_type is
> > > used only by this driver and should be moved into the driver..
> 
> Now we can not move this into dma driver, since we have some drivers in the
> mainline will set the DMA interrupt type, such as spi-sprd.c, sprd_serial.c
> and sprd-pcm-compress.c.

That may not sound right.. Why should peripheral set the DMA
interrupt..?

-- 
~Vinod
