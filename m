Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2D5085FA
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbiDTKhF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDTKhE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:37:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD903FBD3
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 03:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C99B81E8D
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 10:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6180C385A1;
        Wed, 20 Apr 2022 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650450856;
        bh=FnrVmx+Zd9WLsSiEcBhASuFEdp+GoKbSPQRWbmQTxKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTdTwYVNBeww0ieYHdxi6i+B91sQ3oyHQpSpMR6IH4WeAMw2Igj5uwGusWVlHf9Tz
         blZpek+xQTuGR9zkloFCuNOShTGeAUxvRgyJYVY+0PvwrNjI8TSZcR1jdo3lQ3cSWJ
         9i1JLxG3ajTg7VrYNBM684EbB2rtP+PEVmArEoNNFV3iK503A4h+SmFtat+BmavbbM
         gRipirciCB/edYj8/uYbbxdRMB7BZJUJcv7yb7pBWAQ/97QBX7jZodSzvfyih65sPK
         WLFoCvVK7QZY5RXMXXE7XtfMuwsSHfn1QL1UdgEzN+oxdZxA/PUeWg77249m1oHcz6
         23wyqU3h2XMCw==
Date:   Wed, 20 Apr 2022 16:04:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Thiago Macieira <thiago.macieira@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: match type for retries var in
 idxd_enqcmds()
Message-ID: <Yl/hpHBlZOoLlvrA@matsya>
References: <165031747059.3658198.6035308204505664375.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165031747059.3658198.6035308204505664375.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-04-22, 14:31, Dave Jiang wrote:
> wq->enqcmds_retries is defined as unsigned int. However, retries on the
> stack is defined as int. Change retries to unsigned int to compare the same
> type.

Applied, thanks

-- 
~Vinod
