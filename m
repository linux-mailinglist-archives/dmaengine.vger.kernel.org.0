Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FCE650E42
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiLSPHO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 10:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiLSPGj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 10:06:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E9312AC2;
        Mon, 19 Dec 2022 07:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E654860FB5;
        Mon, 19 Dec 2022 15:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59E2EC433D2;
        Mon, 19 Dec 2022 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462370;
        bh=a2io9VDVekYMHwFYhGPjasGdVVGLK44JKXwWGPq5IP0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BZ7TFCAcKrrScSa/mLgxwzL5J47G+qtb3/1qjF1e+YcV86CSQ1p6MZFLeWPJhylOQ
         flnBQ1l2fxeHRu8ta40q8gROSRkdBm2fLAbGYCNVeRd31bpENjZsuPLaxnB5/rJcsv
         AZeGlUIQgWWH/kUv3VbSy6ECOAJI5mNj6hGnIk5Tq0Tnd6Qg2Rm2gxfnpZswLv33vF
         3BO+IGUpZN8OY61euqb+OEtztjN2PYEICPb2MwysGFPuK+As6PauxBinD6qjdTQQoc
         ACVtVVKc/Hjrcrb1M5iEgvRQ6DAVpwUhFe2aQ9sSD4AwxbDhco101yOA6oXbWxn9JF
         H6uWZ7xEoLAFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 422D5C00445;
        Mon, 19 Dec 2022 15:06:10 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y58oexapv1XevgDL@matsya>
References: <Y58oexapv1XevgDL@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y58oexapv1XevgDL@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.2-rc1
X-PR-Tracked-Commit-Id: 25483dedd2f5d9bc6928cd790ee59772fb880a79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9322af3e6aeae04c7eda3e6a0c977e97a13cf6ed
Message-Id: <167146237026.24644.12258355054657263527.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 15:06:10 +0000
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

The pull request you sent on Sun, 18 Dec 2022 20:19:31 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9322af3e6aeae04c7eda3e6a0c977e97a13cf6ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
