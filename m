Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC2E61EA39
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 05:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKGEdp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Nov 2022 23:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKGEdo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Nov 2022 23:33:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7684B4B6;
        Sun,  6 Nov 2022 20:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98077B80D29;
        Mon,  7 Nov 2022 04:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74165C433D6;
        Mon,  7 Nov 2022 04:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667795620;
        bh=XpKJPY3QlMzLiFW4RgPvo3K9iBcixDKpaA6o3IlYcYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7vmUPp5u0A1cVtOcf0pen1xU42WlMSoPQ6CzM5TeNnUltJTdaJjPZP8+lyFP3Vo9
         lRt0Il0OfwFSn5nQYz5tz3+IX0l9cHc8C2/qUyXz6ojbjGJO2tyG+WnzB80AlnqE/i
         nrEvQ78PAbqOYb8YyGutRb0slK0NhXDH94rt/iPLaQMuvNdHv5+tMN0W1ysjkbuwx7
         tqEhLPGWcM2ulGf6WrZYuBsiatVNohje2fkt0lHAydOe8LPUDLh8olxQKLSWwzyc1s
         L8I406dHxuBTSeaWsNL40g4zGHe+Wqq9lpVkxwKScHpPnQcl8CuKepd+57cVlzx4PP
         ZsDSN/AoIZyrg==
Date:   Mon, 7 Nov 2022 10:03:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     peda@axentia.se, du@axentia.se, maciej.sosnowski@intel.com,
        Nicolas.Ferre@microchip.com, mripard@kernel.org,
        torfl6749@gmail.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and
 then convert to virt-dma
Message-ID: <Y2iKn5CH7IYUxwy8@matsya>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
 <Y2USF24O90/dLKz7@matsya>
 <d1035d5f-02f8-a98f-fbfe-bccbdfd3920b@microchip.com>
 <93048355-18a0-df4e-54ad-9c5955933109@microchip.com>
 <Y2VS6xPnTXNvNtf8@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VS6xPnTXNvNtf8@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-11-22, 23:29, Vinod Koul wrote:
> On 04-11-22, 15:21, Tudor.Ambarus@microchip.com wrote:
> > 
> > >>
> > >> This does not apply on dmaengine-fixes, can you please rebase and resend
> > >>
> > > 
> > > Sure, I can, but on my side it applies just fine, both on the fixes and next
> > > branches. I used git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> > > Shall I use other tree?
> 
> this is right tree, I was on fixes branch (for initial fixes) and i
> think 7th or 8th one failed to apply for me...
> 
> > 
> > $ git log --oneline
> > 79029dc341c7 (HEAD, vkoul-dma/fixes) dmaengine: stm32-dma: fix potential race between pause and resume
> > 
> > [cut]
> > 
> > $ b4 am 20221025090306.297886-1-tudor.ambarus@microchip.com
> > Looking up https://lore.kernel.org/r/20221025090306.297886-1-tudor.ambarus%40microchip.com
> > Grabbing thread from lore.kernel.org/all/20221025090306.297886-1-tudor.ambarus%40microchip.com/t.mbox.gz
> > Analyzing 37 messages in the thread
> > Checking attestation on all messages, may take a moment...

Okay grabbing the b4 version did the trick, no sure why my local one
failed. I have applied these now. Thanks

-- 
~Vinod
