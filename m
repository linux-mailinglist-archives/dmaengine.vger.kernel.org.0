Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2C4ECBE4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiC3SWl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbiC3SW3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 14:22:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EB42A28;
        Wed, 30 Mar 2022 11:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85360B81D51;
        Wed, 30 Mar 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CC37C3410F;
        Wed, 30 Mar 2022 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664409;
        bh=gzh0EOG1JNR43ORglEsk1MLiF82IIvrN9omYOSzdZ4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gvDtaKTmtIX7M7seiGzNMvik8tNAfojZaMEpgcTTHsYLYf5iJCOt0uU9eSApvkWol
         CpwvmbyCqsuPVeC/kruoOgBtoviPwHepOnFfDMm1haJTGrpJ6ycGBLJzFZaH0Pl9qS
         ceUZeVa96Szf3vUqcCTRUkU1bgWm2DW3ZMvWVAbUK0v4KWr9WWq+gxRsljmDAkOagU
         YROUDXxmAr/SsINBlGHQD+3uWOeF//KHTDfs5+TPnJLKsjtEcW4aNQidv/AfqB30Kl
         H4EXUzdgZfKFKM2EZAdg2rcUuz/1TXTcRetdmH1AGiVgQjPK2z6jniDD0EbSEELat6
         AbEAi8e5agdCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F764E6BBCA;
        Wed, 30 Mar 2022 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkPudJlxlw+Ab3Fi@matsya>
References: <YkPudJlxlw+Ab3Fi@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkPudJlxlw+Ab3Fi@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.18-rc1
X-PR-Tracked-Commit-Id: b95044b38425f563404234d96bbb20cc6360c7e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a44cdaa01837355b14b9221e87d75963846296c
Message-Id: <164866440917.5472.3670106532672354625.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:09 +0000
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

The pull request you sent on Wed, 30 Mar 2022 11:15:24 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a44cdaa01837355b14b9221e87d75963846296c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
