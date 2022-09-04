Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5018B5AC56C
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiIDQ2X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiIDQ2V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 12:28:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305C32A80;
        Sun,  4 Sep 2022 09:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267F6B80DB1;
        Sun,  4 Sep 2022 16:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67812C433D6;
        Sun,  4 Sep 2022 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308897;
        bh=K5NnPbSymMs3AKykE7PHxHnFNTgsCQlVrRUjYmQkZd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZECx8K6fBpYlrkY+btLivGDbw5VXPkR6+YJzWV8G/MgykN1BXw2Zz1zo2qvaJ3eE8
         U4m6UfrxEHwVzQsN+BDU6xkqSLsO+As4B7EcrbQIWWakpwlDVjMsMymHLiVAxn743F
         FRLWsFqeyxq3SiN1AQR7o6jZnlHCkFGgLyKzYEamRdJ+4L5qmRqPc171e9J0RouUgb
         QzNMa3lPzixNfc+gqmw8VciIZyxtas4bKEEaBYKkQKK5rTCjLoPEvIzq1WN73YiTdl
         6kiwtqZ3+Xuo3tXJ2tmf5k4pZSefX0PCRuJL0V4JAQ+wbe/hf+OrgRLLwxkb6TYmUg
         bsNHXHi3Gbv9g==
Date:   Sun, 4 Sep 2022 21:58:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Message-ID: <YxTSHscENM2NL+ze@matsya>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
 <20220823163709.2102468-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823163709.2102468-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-08-22, 09:37, Jerry Snitselaar wrote:
> idxd_device_clear_state() now grabs the idxd->dev_lock
> itself, so don't grab the lock prior to calling it.
> 
> This was seen in testing after dmar fault occurred on system,
> resulting in lockup stack traces.

Applied, thanks

-- 
~Vinod
