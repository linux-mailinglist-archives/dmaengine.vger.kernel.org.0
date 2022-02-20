Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671C4BD11A
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbiBTTuZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 14:50:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiBTTuW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 14:50:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6630F61;
        Sun, 20 Feb 2022 11:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DFB60EBD;
        Sun, 20 Feb 2022 19:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF733C340E8;
        Sun, 20 Feb 2022 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645386599;
        bh=TK2v370atgE9fRzuR8EYA95kvqS3K2nUO253pnsf9hg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=irDZ94xeEQRJpRDLxp8wEQKcTZ/UQaIfAwarVH1wVUaJF7hOFoLwnonaL0BcmQWXL
         JhnoAq/hr+nFK1PmQwer/C1qOmKaUBokdAXlNS+JenM1ytc+3/agaAPIOupnMlTmuj
         SsX4zQHU/YsQZZTYALu9vQgBAAWK9jSD9Q7AUpqeB5i7TdLFsPWqjzEDRacy5T8F7o
         /xad5/N38Yc2m21IPFDpv1/j2J+iGRhF0XPJxx4C5B6Vm9bl3+CmQs5zzBRzWJJf53
         SAbDIapqLB/mHBWPeIV96IIKJzeFCawk1wACzTEnvHfvPwiVp3ckEZPbqLRZ4x/ezt
         F1J6jhSZS13ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD488E5D07D;
        Sun, 20 Feb 2022 19:49:59 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhJLyWF5PZvc242o@matsya>
References: <YhJLyWF5PZvc242o@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhJLyWF5PZvc242o@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.17
X-PR-Tracked-Commit-Id: 455896c53d5b803733ddd84e1bf8a430644439b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77478077349f14c78e30faeac358cf1187c0f0c1
Message-Id: <164538659976.12071.5577396106345948223.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:49:59 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Sun, 20 Feb 2022 19:40:17 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77478077349f14c78e30faeac358cf1187c0f0c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
