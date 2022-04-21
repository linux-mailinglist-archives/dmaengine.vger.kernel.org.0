Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F6150ABF5
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 01:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442531AbiDUXbR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442541AbiDUXbQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 19:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4A3FBC0;
        Thu, 21 Apr 2022 16:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3EE61E33;
        Thu, 21 Apr 2022 23:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B91C385A7;
        Thu, 21 Apr 2022 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650583704;
        bh=dl23++W9UJZcvdnBX9fl//8YOaVml3u+ZhcJ+tjmWDY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tArxI6qLJsGUvDid+vw1xzrIEaJeA8jNIliQgshg6EIBUZ9vQr9p6h/mS6shEcDzd
         vEzEZsOISbK+lfa4/G1HFR4SRhh27mzCwr/awlwCYGQsytiU7ReVpk/QS0CGLnOEZl
         L2nhkEf+TeWGWbrybKoGqV1xlaegDjhUaB3oyfzhuvx355naBqgcJhMZPbF6HfWxso
         d+gnwkn28XoVx5FqO7MkPCQNqJa0+A5aJx6kXi59RZY4bfYfkVQUaIYGHYoE+z7bz8
         49pIfwXjMVJ/m25bXcbMLDJanYxdFnLnig8ZuAIkBJG4tlkRPMaRPYk6yT2tWw4dVg
         d3Rev3n8j2hzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88E1DE85D90;
        Thu, 21 Apr 2022 23:28:24 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmFST5F0AdoaM7om@matsya>
References: <YmFST5F0AdoaM7om@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmFST5F0AdoaM7om@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.18
X-PR-Tracked-Commit-Id: 7495a5bbf89f68c8880757c112fd0994f5dba309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b05a5683eba6e2d40eadd5eeef53c4864149a4fe
Message-Id: <165058370455.28823.5023790438425301947.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Apr 2022 23:28:24 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Thu, 21 Apr 2022 18:17:11 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b05a5683eba6e2d40eadd5eeef53c4864149a4fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
