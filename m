Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F7492590
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 13:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiARMSI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 07:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiARMSI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jan 2022 07:18:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038EC061574;
        Tue, 18 Jan 2022 04:18:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E285E61381;
        Tue, 18 Jan 2022 12:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FCD3C00446;
        Tue, 18 Jan 2022 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642508287;
        bh=6AH8An8aCWynBNBj2yGfMSAv/Nb6xiSJB6JkaQ23Cck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JNrWLEdiY75QwT7hV7dDpjqBTpksYsGzhloD8aYSSM+6+qYYmlwsKaBq+jvIMfUDO
         tVIyksK82T51NAfAMojVMt3mJF1852mygvA6+LdC6EKZU/LZIDY84mcf2BmNRQUHw9
         0LQ1VtpIEoef0DHbkKKG1YkKTgtlJf6pc+HY51HBd0Cg2t6Z1fznNb72jsKNzIPM78
         xNQ/VFLvQRgdD9Mm1XAVgNYT4ibhq3NoURZiXL03ecowLWew7jkpKhCJAc+38vHl2+
         0G3EDGsnt44zDfUun10fa0Ag4bQVIO2X+K5nDQbTQrMHW1woVwML9lY5Dyvrq3bYjm
         cKA/BehLu7ksA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BDFCF60794;
        Tue, 18 Jan 2022 12:18:07 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeafgZT1M7IbK8cF@matsya>
References: <YeafgZT1M7IbK8cF@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeafgZT1M7IbK8cF@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.17-rc1
X-PR-Tracked-Commit-Id: bbd0ff07ed12fda9dbd0cc5f239bb678a775833a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99613159ad749543621da8238acf1a122880144e
Message-Id: <164250828723.8762.14271021445447659093.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 12:18:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 16:37:45 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99613159ad749543621da8238acf1a122880144e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
