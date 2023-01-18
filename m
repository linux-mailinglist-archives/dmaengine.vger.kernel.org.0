Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07375671C64
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjARMpI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 07:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjARMm6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 07:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598659C9;
        Wed, 18 Jan 2023 04:07:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72671615CE;
        Wed, 18 Jan 2023 12:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B98C433EF;
        Wed, 18 Jan 2023 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674043623;
        bh=e9Wxc55fI7ZbFULfL7bxEE4idKgMyLXHupx2KDWNs3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pl89mAnbxEPV7q155R0vxt+UvOffs9p2DQhqxn+3c2od2Hj3XeRpTb7ExSZyxUmcC
         K5+UcAQGxZmoD5/6wGv36X2U8aMtHVeeK9uYifo06TVhWc/gVKt6OY9iDMrgnWlf4Y
         cjl3kp5ckTdluTrvjTr/RsVZhudpewtn0+iPhrYUTkP/dV2jhbQ1s07NQY5mnrEeeQ
         Sdg8xyEU4SyO5Z2d1ggw8Jru4toJJsBU4qkFWb6WDO+4EqHbVvn8GNIY5fEcqa+ZQU
         Dxh6b/zgd756WM171fkzmhDcxpo/qM4aEsGT2SrXzfwe38nwqgBn4p99BbwaAZQVpg
         6uEll/ZZfxTDw==
Date:   Wed, 18 Jan 2023 17:36:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH V3] dmaengine: Fix double increment of client_count in
 dma_chan_get()
Message-ID: <Y8fg44HzvwY3Bb8N@matsya>
References: <20221201030050.978595-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201030050.978595-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-12-22, 11:00, Koba Ko wrote:
> The first time dma_chan_get() is called for a channel the channel
> client_count is incorrectly incremented twice for public channels,
> first in balance_ref_count(), and again prior to returning. This
> results in an incorrect client count which will lead to the
> channel resources not being freed when they should be. A simple
>  test of repeated module load and unload of async_tx on a Dell
>  Power Edge R7425 also shows this resulting in a kref underflow
>  warning.

Applied, thanks

-- 
~Vinod
