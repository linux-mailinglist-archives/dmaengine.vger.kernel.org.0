Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE56E034B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 02:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDMAoq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 20:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDMAoo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 20:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B76C3C31;
        Wed, 12 Apr 2023 17:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38CA63362;
        Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43E9BC433EF;
        Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681346679;
        bh=axEhXMR4SNrvbRCvQJiOp4uw2/fNrsTxZYLSfU1y48Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PipjA7vNur9LOvDfvdf4sz0XJ7ntn/kM1fhjLB2ezFbxrmxxziSgvhrWm8VibEr4f
         EqSNCtaYpfG+ZQByxVaZJrBMPML75wujbpcE+hv8gUg87flqxIhjtz54p/eo0FxvS8
         +T25dGKy2BjYopZimUCl5tKIUP4MTB/HrSfG5iGfYJpNXGZ9a8WbIBSk1oSG3oTO91
         cPY5Z4FpnnxIt2xa9F2EOpMS+Lh15vgV93nyGuDuJq9vihKMrQy0oit/Cpd1ImfasA
         nc1JVYSNStx6Tf9LOalcMJn4YsxLe4vsABMBZMint7FTQDiF9ZgLC6wMJ+J6dvzIbK
         rK4VB7zbrE6og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E4D7E5244C;
        Thu, 13 Apr 2023 00:44:39 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZDbiYVOQFNzdnq24@matsya>
References: <ZDbiYVOQFNzdnq24@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZDbiYVOQFNzdnq24@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.3
X-PR-Tracked-Commit-Id: d9503be5a100c553731c0e8a82c7b4201e8a970c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b05e0f5e74e48a3e39066794fc1d7df37507953d
Message-Id: <168134667918.12533.10870150423196240731.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 00:44:39 +0000
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

The pull request you sent on Wed, 12 Apr 2023 22:24:57 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b05e0f5e74e48a3e39066794fc1d7df37507953d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
