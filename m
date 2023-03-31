Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9886D2027
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjCaMYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjCaMYn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE9026BE;
        Fri, 31 Mar 2023 05:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15C062886;
        Fri, 31 Mar 2023 12:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9325FC433EF;
        Fri, 31 Mar 2023 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265454;
        bh=AJOWQfHZ/r+wkoc9b1OyiVgeYxTZYaQovPh/PNg25Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxS1ZcWyox5ogrJhoaKGwwLKbirYXOaP5rOyguEkvsmA43PzCKz9wKmxg+lCPWE4H
         +WGVXtbEzGGcIQeQR1ibCoOmmx0szT/I9hN6IuirYrKtl2f/JOS7HzLEXvbhUkNHan
         gQhDqBYMBGUXcn8AJFnIdqWB10ALNuofHP4SGCQTGSewO/0LGsyrIa9ebTddNfD7Ag
         rgIKevzyYboiaegTcoym04cmZ2oIF8KaONrZ5i7Ca50n5HVn7jDJOq/ENVC5RDSC5F
         uJoHh9gIsWlMYLE30gwgHl0Dd3mbkzOmzss1G5PqHcbi2k/NLZpLiMQp1ZFLmBtCFk
         zMmQTgoHIgU2Q==
Date:   Fri, 31 Mar 2023 17:54:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     romain.perier@gmail.com, allen.lkml@gmail.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Sync DMA and coherent masks
Message-ID: <ZCbQ6n5/6A42VSVO@matsya>
References: <20230316093318.6722-1-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316093318.6722-1-harini.katakam@amd.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-03-23, 15:03, Harini Katakam wrote:
> Align ZDMA DMA as well as coherent memory masks to 44 bit. This is
> required when using >32 bit memory regions.

Applied, thanks

-- 
~Vinod
