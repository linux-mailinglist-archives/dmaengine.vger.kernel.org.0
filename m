Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD6F714156
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 02:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjE2ALO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 May 2023 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjE2ALN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 May 2023 20:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DBEBB;
        Sun, 28 May 2023 17:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2647F60C00;
        Mon, 29 May 2023 00:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D3DFC433D2;
        Mon, 29 May 2023 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685319071;
        bh=BNKxS+PJOrkbDagxpmjQSTugWAYQ9hT+ce2uKujG9yU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j49H8zzCaW3B6fIdVkYmsTBdSxQv9VRMPDOis5GhcpFiZIB2fxoezwYqWeAheCD25
         J2j69XKvx90FojB33DVGlrDgbxxViL99eRP4Vn+yESFl7IgK6aA5F0mitYJ2xGyfAF
         USRIFp/otcp8LiP1iYf6yqnla85dNiyIqkWF0aXsGuNdYs9evBxj6RkJPczdJGjXUU
         3nUqFPaf9Velg/e6pa7ZGqCjVkjRPAZrW8qIuV+nBd/lek0q3H4qa98W4HREfpJXUc
         zwb6zSPZQCkuqr8SIIICr8pXhgUqNNzzcc6o+X0tCflMDqCd0BmLHK0NT8aq2zI4Ta
         IOlaC9Rojr/Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 728FBE52BF2;
        Mon, 29 May 2023 00:11:11 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZHOQzA0H/foJoyN+@matsya>
References: <ZHOQzA0H/foJoyN+@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZHOQzA0H/foJoyN+@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.4
X-PR-Tracked-Commit-Id: e14fd2af7a1d621c167dad761f729135a7a76ff4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dca389eb958f982406df8199af40fefe1b881b84
Message-Id: <168531907146.13206.1157903086650079726.pr-tracker-bot@kernel.org>
Date:   Mon, 29 May 2023 00:11:11 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 23:05:08 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dca389eb958f982406df8199af40fefe1b881b84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
