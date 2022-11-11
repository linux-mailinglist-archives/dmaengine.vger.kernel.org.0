Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD96260C5
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiKKSDE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Nov 2022 13:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiKKSDC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Nov 2022 13:03:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B83063BA0;
        Fri, 11 Nov 2022 10:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59E2FB82694;
        Fri, 11 Nov 2022 18:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 036A2C433C1;
        Fri, 11 Nov 2022 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189779;
        bh=sdNGp3guQXq6RbeF2+roJZSVZX5CNGispvIqNMmia1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GKZWoXRqvqnXNzLqdBt6Ri7iL8N+k6zO4Ayq5R5AdL92J+nJTEfPrwag3q0GINeXc
         d+cwlpc7GRiDleqgv3SS2peknmvAlNqhFPk5O8376QaBzDBJN1wwUvuxbgHCiHozud
         7YXx3QTY8y+4dHdDc2XRgdOwTMDh/Flwwueg/ff3NYM1/qVtrsF8Ohez1e3/ptXlqw
         vxHkJop878mTPALtvOEqu+MDGfPylTYUwnQntvO+VIfhfbGHnAElIIB3aDpWiX4FqW
         6uKhjYz25FNeVXww99ejl/Ad/D7lvhl9w+kxJLI07hjhIS/1ct/CdkMTe9vmFbowMi
         ib8dsHgYsN8+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9E4AE270C3;
        Fri, 11 Nov 2022 18:02:58 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y23uoaujTTOGvcwH@matsya>
References: <Y23uoaujTTOGvcwH@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y23uoaujTTOGvcwH@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.1
X-PR-Tracked-Commit-Id: c47e6403fa099f200868d6b106701cb42d181d2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91c77a6ec4e207085b9d4c27e6710f349d43195d
Message-Id: <166818977887.15878.6603309583822814920.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:02:58 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 12:11:37 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91c77a6ec4e207085b9d4c27e6710f349d43195d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
