Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9255EFA65
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiI2Q1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiI2Q0X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:26:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17C1E800C
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 09:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17CD1B82456
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA03C433D7;
        Thu, 29 Sep 2022 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468637;
        bh=AsGLeCLFYqYXPeYSyrxLRCFVQR3dq6NULNfwBiPDw78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+vAOTBLRPHoV3GpeAsNTKyyP6fU1p/TSrsYyJHXVlfLDXmCG5bZxS8xit9h6yBYx
         2loQGlF3Fb5yUuN5Fg7uUNq/U7LYpEDJRWAvsn17Cwmnw5aAAyeXCNhHWIocIIEIjq
         y2xlNkl/L9agINg+d1bZKP6jVAVIaGjl6HAVgQirMXPphcHaCnoJ3JYmg9cEUizNzm
         rTLx+0uaNSy2tQAfaNB1twVkXUXFnCO9h2bdutKfksDXhb1hfUCQX8sFPmBIFOaOcO
         Jl9qU6HwImgiG6uEYtqLuy/d31j1e4VD/r6wk4zLf/+Ma9/XOCBm0wGzoJX4oLF36g
         DhoJD+VlAQWnw==
Date:   Thu, 29 Sep 2022 21:53:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ioat: stop mod_timer from resurrecting
 deleted timer in __cleanup()
Message-ID: <YzXGmeTVQlsDa4cx@matsya>
References: <166360672197.3851724.17040290563764838369.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166360672197.3851724.17040290563764838369.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-22, 09:58, Dave Jiang wrote:
> User reports observing timer event report channel halted but no error
> observed in CHANERR register. The driver finished self-test and released
> channel resources. Debug shows that __cleanup() can call
> mod_timer() after the timer has been deleted and thus resurrect the
> timer. While harmless, it causes suprious error message to be emitted.
> Use mod_timer_pending() call to prevent deleted timer from being
> resurrected.

Applied, thanks

-- 
~Vinod
