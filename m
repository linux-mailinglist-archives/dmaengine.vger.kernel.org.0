Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFB544387
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jun 2022 08:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiFIGD5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jun 2022 02:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiFIGD5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jun 2022 02:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8021EEF7;
        Wed,  8 Jun 2022 23:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A8961D77;
        Thu,  9 Jun 2022 06:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011C6C34115;
        Thu,  9 Jun 2022 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654754635;
        bh=KhuTmNi0gT1/+OPajKaAtgFaVFT3k4BB4kdNvSXp71U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHiVtlIyms/oni/IwqIRpF+Nt6Vy2fxWTEkY+Y+Ky479w0+xaY3GwZvB1M0GaDU3w
         xGEk1MFTl+D9BOFdcIqjqPCvY0bJid2TkySYPYD4hhVvfmG1o/8XHo2DQn0TQx7gLy
         nR/3pfYEkkAMVJo3RTF37tg5J8ACRGtU1Pn6/GUGOU3+74x/NfHU1HisldN1zSsmqH
         JgBJBmBEzBgDi3u3nOl1nMEs/pWd5yRaTtXTkvlp/yZTPyYWW8mJkB3/abx/Hd7Xqk
         aPYblh032xS/+mY9t0HcvFJCa8GT3if39tKiqEYZWPRc/qWrqEKAoxcLQ6wKqrCg3c
         39JT3q88kFk9A==
Date:   Thu, 9 Jun 2022 11:33:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: Replace symbolic permissions by
 octal permissions
Message-ID: <YqGNR0aSAtSDK4/M@matsya>
References: <a745b883288f95e999b71fac677bbc2daa13c22d.1654702928.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a745b883288f95e999b71fac677bbc2daa13c22d.1654702928.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-06-22, 17:42, Geert Uytterhoeven wrote:
> Octal permissions are easier to read.

Applied, thanks

-- 
~Vinod
