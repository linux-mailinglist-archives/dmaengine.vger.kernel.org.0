Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1242552848E
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiEPMu7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiEPMu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C613396A2
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEAF361221
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B32C385B8;
        Mon, 16 May 2022 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705399;
        bh=ZLfZkGo3vhJgcCeDIEGMBySWHOrKNngwgbXZHca4QNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OS69I2RWjkRlFjtq2DDGQwW15+yw1+kFdG0PD9uEWkv7Z8bb7RWwmkt8IiU58QfgH
         Q2vpsYpmPm6VOzDB/O/w7YLmSWwLcnYx3+2xiuRWD/xPtyrdZ0YRNA+qD3TJ06QF6y
         Ks4cHrpP/ZcH3l/9GfyZMz34OFpDU1k0cMOFkdrP3FDz7jr32c5A9WWlH6W4zObzIH
         9S3FRYZnZ7Uy/Rs+aTHHruKQ5bgq2jRBqrczxWQqgou524J5N1baiMJN04Qk6NKWCX
         Wkox8XQT/YWOya9sAyGN9WbmNkuYpOAS6WTCbYeti32DZFAtoIdZULZtnUGCgAp60m
         JOXITgnaR4Shw==
Date:   Mon, 16 May 2022 18:19:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove redudant
 idxd_wq_disable_cleanup() call
Message-ID: <YoJIc/j5dgeyuIUG@matsya>
References: <165231365717.986350.2441351765955825964.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165231365717.986350.2441351765955825964.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-22, 17:00, Dave Jiang wrote:
> idxd_wq_device_reset_cleanup() already calls idxd_wq_disable_cleanup().
> There is no need to call idxd_wq_disable_cleanup() again in
> idxd_device_wqs_clear_state(). Remove redudant call from
> idxd_wq_device_reset_cleanup().

Applied, thanks

-- 
~Vinod
