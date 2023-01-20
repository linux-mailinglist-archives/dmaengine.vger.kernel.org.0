Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5B675CF5
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 19:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjATSq7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 13:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjATSqz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 13:46:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED466FD39;
        Fri, 20 Jan 2023 10:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEAF62057;
        Fri, 20 Jan 2023 18:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03FF4C4339B;
        Fri, 20 Jan 2023 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674240414;
        bh=JrTVY1ZJqrmeSEPreF0on9OeiVuMZkx2m2qekpWWMnQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GBKxqmwxfSkc7W1x0CgbToQJRN0sYEvoecTwVufU/1Y9wbYSXVw9UumNnxgzyd9a2
         dTOvYbSOWpvtvbuHpcaN3h6sj/nIX7CsWg3ug0p7wXooUV8jlrewnC9UBL9Qxile1S
         Xr+sV/9ArvGEzQnHtL7rmLmk5CTfGUgkToXEXO1QNDqyBjpO+GNcRh1LRhcaFNMvRI
         +FTw3C00K6sLxcPOsMIx4AQ1Hu9NXZkYesPq81fpXSeZzu8qh8osNVPBl/J9XCg3di
         0iGwB1KgYS+hqJXllYS70ZUTc6cemXaFLyUUq42WzDQ5Li8rU7d0uOheuhntGvNibk
         Y1eVtP++syglg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0F12E54D2B;
        Fri, 20 Jan 2023 18:46:53 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8qtzmmIEH+zN7Bm@matsya>
References: <Y8qtzmmIEH+zN7Bm@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8qtzmmIEH+zN7Bm@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.2
X-PR-Tracked-Commit-Id: 95e5fda3b5f9ed8239b145da3fa01e641cf5d53c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35929dae72332e41cb11b56439999fd0295d5a64
Message-Id: <167424041391.21297.869422164732470094.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 18:46:53 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 20:35:50 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35929dae72332e41cb11b56439999fd0295d5a64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
