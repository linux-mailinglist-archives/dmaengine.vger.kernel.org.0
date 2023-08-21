Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2263782AEE
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjHUNwQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjHUNwP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A6129;
        Mon, 21 Aug 2023 06:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F23896147C;
        Mon, 21 Aug 2023 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCC0C433C8;
        Mon, 21 Aug 2023 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625925;
        bh=2sYeYTl771M/L/YP43wDdpDWXISB383qntV2VCdR6Qg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K0IoyzgO5Cum3mPZTUhvNqNXGBVoYJ2YKrIC5ABF+f4wI8IZk4xiANzwFSOwrXk9U
         /Y7o7T2zUhnVk1MjlaMMP8HbLCM60gjbN8V73xpESHbDs8P2kFZaWW7Q3gNToR668b
         pViYrgC124AXLtWg6mzgNKkqvO6QrRjwepE7ZuT8DxpX+Mr0/Xmksa8RhnU7FR6Gjy
         DGUkwg2J3j4s5bCCzA9BAgXrvfpz93WoVfckkpN4Jhn02x/U1DuTnSpAHDa1Umk7/K
         /IxuDulH6ssyr2rl13XRi8VfqI51X78dwwZe0t9s4MXung1I9efeN99qqK3IhzajgU
         KPcg8xGk1OLfA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dave.jiang@intel.com, dan.j.williams@intel.com,
        Yajun Deng <yajun.deng@linux.dev>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230815061151.2724474-1-yajun.deng@linux.dev>
References: <20230815061151.2724474-1-yajun.deng@linux.dev>
Subject: Re: [PATCH v2] dmaengine: ioat: fixing the wrong dma_dev->chancnt
Message-Id: <169262592361.224153.4443971178602794196.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:03 +0530
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


On Tue, 15 Aug 2023 14:11:51 +0800, Yajun Deng wrote:
> The chancnt would be updated in __dma_async_device_channel_register(),
> but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
> the wrong value.
> 
> Add chancnt member to the struct ioatdma_device, ioat_dma->chancnt
> is used in ioat, dma_dev->chancnt is used in dmaengine.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ioat: fixing the wrong dma_dev->chancnt
      commit: f4f84fb632b30580f11133fb81372338da2229f5

Best regards,
-- 
~Vinod


