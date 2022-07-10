Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18056D0DA
	for <lists+dmaengine@lfdr.de>; Sun, 10 Jul 2022 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGJSqm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Jul 2022 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGJSql (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Jul 2022 14:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04A140EB;
        Sun, 10 Jul 2022 11:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB1260EB3;
        Sun, 10 Jul 2022 18:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 084F2C3411E;
        Sun, 10 Jul 2022 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657478800;
        bh=JzwJrFfzuqohNYnuHRqMNAlVmmv/nzVgQ8IBYgw9c60=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MQ+kw4HKr+flnAnom/xiE91jU41CI45ExcZB9CXfqgse86gwZ8gh8JN+FUzOVT2n0
         gbIlVIHHW9JjXl2JqIZSPvc+Gau5toBOM5kEdxRNit6WWMrlZeqQlhY3yVQCpvPFsM
         1+GAg/JzOxxUsB02jLVQNLIxxCCKXbAiyhHyjSF0FZ6lrVNLNWi59wOHXUpGdfoU6t
         /nSI69FvE0PbCCRstlExlyWfGCMvoxaPwg6i5AKaac6E/g7fXJYj5cYu9DKoFs5h4G
         /kPboeterbEuwcHlQ06SRHftnHm4xiyZXSrHiP6cWWUXcoJgmhrxsB3508bFFS6meh
         ARPtQWF46G5ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF11FE45BD9;
        Sun, 10 Jul 2022 18:46:39 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YssIxUbLKJ+wwlzG@matsya>
References: <YssIxUbLKJ+wwlzG@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YssIxUbLKJ+wwlzG@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.19
X-PR-Tracked-Commit-Id: 607a48c78e6b427b0b684d24e61c19e846ad65d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952c53cd357c71338a59d444933ed48a879229e1
Message-Id: <165747879990.14656.10481519392421242330.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 18:46:39 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 22:43:41 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952c53cd357c71338a59d444933ed48a879229e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
