Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E4619A66
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKDOoQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiKDOoA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63831DE1;
        Fri,  4 Nov 2022 07:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EA562207;
        Fri,  4 Nov 2022 14:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18450C433C1;
        Fri,  4 Nov 2022 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573024;
        bh=UBbkqkVceLOOAXfkK0cOsW2bKaYhwR/pDIEt/9iU3Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SML8AXMir9D9NFZrj5BLUfryJLJoZlXJLzxsPjgDTtfXha9tKT+ZNezKaXvoWRB30
         8b6BJBtm1hyNNU90UxQ4Wpz/Der716VtsAAuPjeM8FD5vepwjpPH6QV9LuA+RGqSrI
         UHxphMk9rFS9C6O8Sddr8XPbcUF6lZmOKNcoa3sfdmfK/ZsyDT6mWRRpGH8Pazhrh2
         cImPlnuijV+Ac9AtSCPShqkoadseh37DBVi+b+syszZ9HWsa2s1LnlDYgkMkkhKGKu
         yBgOQGlwM6jV9E1Jh/cSFEa/cOEILR2eSiptQQfod224Y4sDWbR5jyXu1pPt6dUDW8
         PBT+AcjxpUyNw==
Date:   Fri, 4 Nov 2022 20:13:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: fix potential race between pause
 and resume
Message-ID: <Y2UlHIp/9P8w/n5m@matsya>
References: <20221024083611.132588-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024083611.132588-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-10-22, 10:36, Amelie Delaunay wrote:
> When disabling dma channel, a TCF flag is set and as TCIE is enabled, an
> interrupt is raised.
> On a busy system, the interrupt may have latency and the user can ask for
> dmaengine_resume while stm32-dma driver has not yet managed the complete
> pause (backup of registers to restore state in resume).
> To avoid such a case, instead of waiting the interrupt to backup the
> registers, do it just after disabling the channel and discard Transfer
> Complete interrupt in case the channel is paused.

Applied, thanks

-- 
~Vinod
