Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2E44CA32
	for <lists+dmaengine@lfdr.de>; Wed, 10 Nov 2021 21:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhKJUMt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Nov 2021 15:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhKJUMs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 139F361213;
        Wed, 10 Nov 2021 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575000;
        bh=xb7tPpeC4MFi6dEWpyRtIl1/I46eVxv3y7H+FoGXJCI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gEcATwKuUwbFffKnJR5MKG/dsjkRMHtncTOD2LiLbel/MFnxBPILXKVW8l2trlou6
         voyLb2u1L9pcFDfHbEoO794IW7e5oWRVa3LeWTsLKWZiaymegabmyQidSG3eu6XDUR
         fV9KqcK7rxM5/c4EKLlnIH/YARsnkv60kwMoVaYUgvCbvnHTaNv8E/z+i08yLKAdLA
         1x8A4IT2ogz4RfNvrZqLGYVpbXKW8+ANfDwLIE61zeHcjg9wBnB0o7VfFDxINL8kCy
         WI96AOWfLKybNgLs5VoxEwAQaCdF2xwxRubiCF4EaU0bTFMyD3J7a8OpLHUzyb3Oyg
         3miiJ6kUxG3Fw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C5166008E;
        Wed, 10 Nov 2021 20:10:00 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYu1huhCBnGJUPZg@matsya>
References: <YYu1huhCBnGJUPZg@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYu1huhCBnGJUPZg@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.16-rc1
X-PR-Tracked-Commit-Id: eb91224e47ec33a0a32c9be0ec0fcb3433e555fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e68a7d35bb17247f8129e17126352a07433f2908
Message-Id: <163657500004.19350.11586253212230885602.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:00 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 17:35:26 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e68a7d35bb17247f8129e17126352a07433f2908

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
