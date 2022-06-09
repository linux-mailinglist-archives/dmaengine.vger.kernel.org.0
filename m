Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08681544382
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiFIGCh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbiFIGCg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:02:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A982D3467B;
        Wed,  8 Jun 2022 23:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4150461D74;
        Thu,  9 Jun 2022 06:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63EC34114;
        Thu,  9 Jun 2022 06:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654754554;
        bh=X34ZjtsyR0m6ClijUw/6T122Jch6uZuEEKkg4CUvxnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bzk1ZEYO/ct+lsSah+RfSooCnTQPmDCuz91FUk1KiSQ/x0mE3pw54T+VKucP46xXY
         RAZ8rmRqu+VFuJPeqjfLKG1Ne47umqU5WJbxT9L4aY4YpYedfyp+jJYWn80sxWxudv
         NMHjH7/oof08crzD79HLjHCfQy3/5y/5oelqpNTNPVQg2D5GoUtUscsjH9vwqJIckE
         9x3kOmvyV9w264mHplC+cfMJAU52KvYBx46k+R1CSVQ+kKRABAXKvv2ruMObZtdggU
         6fdUaudajeKk3ADgwdy+GBX5YX6Cxm3QbnQd1Rja6VWNycLShJEVYlrTxcSmzTqFzQ
         okAF81k5Go/UQ==
Date:   Thu, 9 Jun 2022 11:32:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: Remove spaces before tabs
Message-ID: <YqGM9iA3+d/OUJjA@matsya>
References: <d863916120d043e3f9dd2f2670238c34f68f7d5f.1654702886.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d863916120d043e3f9dd2f2670238c34f68f7d5f.1654702886.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-06-22, 17:42, Geert Uytterhoeven wrote:
> Scripts/checkpath.pl says "please, no space before tabs".

Applied, thanks

-- 
~Vinod
