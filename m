Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223BB5EEE12
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiI2Gvv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 02:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiI2Gvu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 02:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC287107580;
        Wed, 28 Sep 2022 23:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5252662040;
        Thu, 29 Sep 2022 06:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C034C433B5;
        Thu, 29 Sep 2022 06:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664434308;
        bh=3megjrmn2ypdBa47HZQSQmgO0S17cxtt4fD5T3bwibg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoXnzGBfHdg7eYEAXWiEmaZpbLrCI3QcpyO4yXql4c27Fqjw4gU6EiNyPIrmUPMlh
         OrnZZ78yGp3ODZ/BbeMNwSQ7NKeZRxy9+GhkEYytSMrCEZrvzHHW16EeDTsVWGDVJ+
         xWEgRuiPwarMlXJhBOlQX2W9RhHpJsRCwtpMH6uGPhr+uxYFr4aa5P/H+rrFHnMa2V
         qCwgO5e6y3X/+gylDIpniGbFfpe23F0CVjb8+K/QzHDSEjoRbFkdbpzd72Ky1K7LUt
         f5Opk/XrVG0FccwlxQLplxJMOSi3vC49+RT47F/P4xj3gy4zDqlZ1pq/V89FVzbEAh
         /a9r7/m7otTyg==
Date:   Thu, 29 Sep 2022 12:21:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tuo Cao <91tuocao@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: move read_lock_bh to read_lock in
 tasklet
Message-ID: <YzVAgDB18pTSqbTD@matsya>
References: <20220814131323.7029-1-91tuocao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814131323.7029-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-08-22, 21:13, Tuo Cao wrote:
> it is unnecessary to call read_lock_bh in a tasklet.

Applied, thanks

-- 
~Vinod
