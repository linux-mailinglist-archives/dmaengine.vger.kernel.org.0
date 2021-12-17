Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5D479670
	for <lists+dmaengine@lfdr.de>; Fri, 17 Dec 2021 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhLQVnY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Dec 2021 16:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLQVnX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Dec 2021 16:43:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF4C061574;
        Fri, 17 Dec 2021 13:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 471E9B82AD9;
        Fri, 17 Dec 2021 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 060BFC36AE5;
        Fri, 17 Dec 2021 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639777401;
        bh=m3jXppKHa7Dq1fUeuCqQabpQVxCxalsaywnmgFOPsME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dy2LOj9N+Ra6OIDM9Auw2j5ywzMs+2IWJghTG/CGElAqPKgxOuvYpsvBHYeSq3/Ec
         ebrpBVSAhvFPluSOSJweDTGQyuTMaoI4zbzJKs2WDAlWK9Lx0rIAZ1G8O75rV60YyB
         BMPAnp2mi1vqjNCJ4CUuRDRq4CS9MwJxEdP7qfeYpniKoFcrz+GEzAPJ/ueK5C9Gun
         fYD77XiH8Z3TaAE9QmjfpN7J0PQyraOs2ubJCY71wdgqYSDvRf8h/gQmM3wcJZU5LA
         KcGjTxxKrQS/R7q7qPkQPKaV4agxcTKO+To5nIlViBtXKKy/a3e3UHwDvgoTVmZ9lQ
         DTtU5kM1bbiBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E771F60A27;
        Fri, 17 Dec 2021 21:43:20 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ybwkx9ZapFijTpqX@matsya>
References: <Ybwkx9ZapFijTpqX@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ybwkx9ZapFijTpqX@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.16
X-PR-Tracked-Commit-Id: 822c9f2b833c53fc67e8adf6f63ecc3ea24d502c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43d1c6a6395070cb02944d78bc919425ffd3e599
Message-Id: <163977740094.30898.10133610366994215243.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 21:43:20 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 11:18:55 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43d1c6a6395070cb02944d78bc919425ffd3e599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
