Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C56F5DFA
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjECSd6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjECSdw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 14:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70B27DA5;
        Wed,  3 May 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4EEA62F62;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58506C433D2;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138742;
        bh=XE7aMIz1/fg5CrjxxS4/BT2UJQ1PwebGH+ftLtKFVP0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N360NN6wULhnrGlbussPe8axDosgP2ApqOJqb1+8GUauVryzSRUjgsScV/6XRFKLE
         y5EaXs6G0XFUB0i1vK3v+urYhVgEvVazqmtOjgwskvOscQd9ZgPgvawpMfkNGxiibO
         3aewfBs1vYBxv4aiCGRpmJGp4oj5HZL20q5qpyRQTqeB6N/KPKIoSpvA4mMlyk6+KG
         e01tni1+zuifpz6RsC1cU538MBLNQKQSUdP8PIB5EBhi/KScJXGt7iRM1Z3Cy0tgBA
         /BStiksDevGz1U9ACuGmYggeXjSZWQX+vffdNlMaKUR77WyqDpc7k6kga90vl7r7OQ
         Ljzxz+6OB2flQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41894C395C8;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFI7PrQHKum6Wuxf@matsya>
References: <ZFI7PrQHKum6Wuxf@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFI7PrQHKum6Wuxf@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.4-rc1
X-PR-Tracked-Commit-Id: f2dc327131b5cbb2cbb467cec23836f2e9d4cf46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7994beabfbb9a15c069eba7833a00f5ff4da1172
Message-Id: <168313874226.23026.15932489216395969260.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 18:32:22 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:15:18 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7994beabfbb9a15c069eba7833a00f5ff4da1172

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
