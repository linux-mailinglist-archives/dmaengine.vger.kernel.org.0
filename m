Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1186A2693
	for <lists+dmaengine@lfdr.de>; Sat, 25 Feb 2023 02:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBYBh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 20:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBYBh6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 20:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70817EC60;
        Fri, 24 Feb 2023 17:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4CEB81D78;
        Sat, 25 Feb 2023 01:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA8A2C433EF;
        Sat, 25 Feb 2023 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289074;
        bh=mmc6ujydkNfiOmiAhQIcKI7mxZhfqrRKXc+fk6m6HDM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KRkRYY8yecJLR2WhFi5wzP+B93NlhQsd3FwxjqhgTfWDbKoIS46yVCXcK9aLoz776
         +S7+YsN0HxRKT9uL8TTbqSVo/oNRoIhPIV+VL2a42sLZtudiy/0Z8iqKpLaxEP4feY
         Y/9bmCSvtPgnujKWnoSfxZQ60DjR4Tl62zK24CHZnaw2BocSKPTtmVXsCsx3gNHtmW
         kLQBd4ZheJy1rg5VypAKIxo82iVYbVFXECB/jIFZ2C6MIM4glxfmch0t31oasupxVf
         aY+708TrPYMA7/4zeaHDxCwUUqKQR210Oj5sU7Zc3dRQR8++iorAGb9rI/JqDhGrP5
         L926K0SN8A6Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9CA0C41676;
        Sat, 25 Feb 2023 01:37:54 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/i6M7DxoQQwL5Et@matsya>
References: <Y/i6M7DxoQQwL5Et@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/i6M7DxoQQwL5Et@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.3-rc1
X-PR-Tracked-Commit-Id: e922bbf37564a4c67efca9dd6133eaadbffb65f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e6bfd42b14b45737cae8bc84c759f1874949b8b
Message-Id: <167728907475.28954.5142347962769887728.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 01:37:54 +0000
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

The pull request you sent on Fri, 24 Feb 2023 18:52:59 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e6bfd42b14b45737cae8bc84c759f1874949b8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
