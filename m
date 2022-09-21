Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AB5C047D
	for <lists+dmaengine@lfdr.de>; Wed, 21 Sep 2022 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIUQpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Sep 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiIUQog (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Sep 2022 12:44:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF99C48;
        Wed, 21 Sep 2022 09:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30413B83181;
        Wed, 21 Sep 2022 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EABEAC433D6;
        Wed, 21 Sep 2022 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663778066;
        bh=4zrBKD8p+a54Do+feopb+gqIFXrxU78pdFojW+ucLfU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J3QCuee4s29ve2tV6oh4IFghBWy5ckvmTP9jyy3WWKKqa4lVP9D3HlrU2tDBsD3mC
         UKEYAcVI6CYD4HnQ88uwCNIUterxrnwcyiS9wddwGMx/pstfoLAgmmN/1wRo1w4ltx
         IuiSzZpaNtXcufXu6HtoOE1CrAX9voSRoXqWEBrNQRlkA9OO0mpCco0gxtkEbDh0zo
         DtJXJdNy0cZshJz0fYF7N85p7UBWJRT8BfX52vBzOhhFhhJS0zJz2OGstjlWeGSpF1
         SFA6BzjTJrSj5MrW69OMQDaMIbUhadtaXW++D01PKSbsHrZ2Ck2AanPhA0KPvR5PNQ
         V2gASgG8rlKWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA66E21ECF;
        Wed, 21 Sep 2022 16:34:25 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YysQ6+o7IqJUwTdY@matsya>
References: <YysQ6+o7IqJUwTdY@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YysQ6+o7IqJUwTdY@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.0
X-PR-Tracked-Commit-Id: e0f1b21c504f050de83922dd49e6a425dad2d518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88e6546b36771daa145e7f6cf29f3496341634a6
Message-Id: <166377806582.17149.5464169894846940042.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Sep 2022 16:34:25 +0000
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

The pull request you sent on Wed, 21 Sep 2022 18:56:03 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88e6546b36771daa145e7f6cf29f3496341634a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
