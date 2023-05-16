Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7098705516
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjEPRgC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjEPRgB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FDC9;
        Tue, 16 May 2023 10:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA20863D1F;
        Tue, 16 May 2023 17:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D584C433EF;
        Tue, 16 May 2023 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684258560;
        bh=rRh1kKegHXWftlVCBewhadYwGEJ3x4QHeAn6DLtCDG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gi83DkaLYO5yw19mlnCFK6hXrLO2TjHTuVVEER6nYjh7qargNLzizm98aSD8pxots
         65bDLhfNqA2tj4eai2VirbrRPSF0kyCuaLWRSJbr5ilJB7rXWRLzjLDoPhdHv4CJZt
         7EpdrNmJEgcXs/S0sR9B4ycfSP1wUkGfcHQ8YZfakl6X4qb0eaR2Pl1+ZSnPof62dp
         C9Znmc6/iP3qXOykXCE//tgQshrW82hA+GAnawyYjE9eZy2E1A7Y6ZUxZZ1LMFg65g
         rLGHOUDC8DELNu1PZYIyAbLae4M5GyQoFeRhjV4oRw6HadfZbXzJYL/tGWhZmjR6pr
         xOZ/FLKJCjMxg==
Date:   Tue, 16 May 2023 23:05:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Subject: Re: linux-next: Tree for May 15 (drivers/dma/ti/k3-udma.c)
Message-ID: <ZGO+/E34V83rjQKi@matsya>
References: <20230515141235.0777c631@canb.auug.org.au>
 <abc2472d-34f1-069b-00c8-66b751158fa9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc2472d-34f1-069b-00c8-66b751158fa9@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-23, 19:18, Randy Dunlap wrote:
> Hi--
> 
> On 5/14/23 21:12, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230512:
> > 
> > New trees:	fastrpc, wpan-staging
> > 
> 
> This build problem has been around for a few days/weeks/?.
> 
> # CONFIG_SUSPEND is not set
> 
> ../drivers/dma/ti/k3-udma.c:5552:12: warning: 'udma_pm_resume' defined but not used [-Wunused-function]
>  5552 | static int udma_pm_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> ../drivers/dma/ti/k3-udma.c:5530:12: warning: 'udma_pm_suspend' defined but not used [-Wunused-function]
>  5530 | static int udma_pm_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~

Thanks for report, this should be fixed by adding __maybe_unused. I will
send a patch shortly

-- 
~Vinod
