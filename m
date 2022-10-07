Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6E5F8144
	for <lists+dmaengine@lfdr.de>; Sat,  8 Oct 2022 01:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJGXh5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 19:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJGXhv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 19:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7FA2618;
        Fri,  7 Oct 2022 16:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F2D61E03;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D8C0C433B5;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665185870;
        bh=357zRFROIW4a2y8A+PgWe9vPssaARCkGsIvrFwgEUAs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l8U+HwtovLcoymGcKoyQATy/VG/XU7vXnhpLKp3F9eAlieqT/Sf3wRrelYPj/gzc6
         gUbIP0NMMPQlMMndQL6KPqB99OUeqVP5hmW2ZfknowtpvDajtjSl89LjCURm4GZ/BP
         ooeeIaaQga4wBjbSrFPQ4AYXfZsrgxT9chC0Z5aySivQ+pD8D1ZRPvcGyvn4AGKMLV
         uAbqtVik5n6pDD9i7ugfg7XoT5OWnLNegNps5WhO7Nwe3en5Wk91EAP39UxBhoNrkK
         X/ihQMXmpDKuGbbUsNMpOwfs5LKk6p/d/d33re0LBCUf34x5CHC5xphLVTEHywlhno
         UwuIURBE9omNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C29E21ED6;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0AeWM7UabE2ZK34@matsya>
References: <Y0AeWM7UabE2ZK34@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0AeWM7UabE2ZK34@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.1-rc1
X-PR-Tracked-Commit-Id: b957df98469240d459bcfae6904b36d6ecea9bee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 416a2f4f91525fcdec821320bc4608cf012d418e
Message-Id: <166518587026.18327.1358246973646450497.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 23:37:50 +0000
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

The pull request you sent on Fri, 7 Oct 2022 18:10:56 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/416a2f4f91525fcdec821320bc4608cf012d418e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
