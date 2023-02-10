Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157B691854
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBJGIb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjBJGI2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:08:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255B7714B;
        Thu,  9 Feb 2023 22:08:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A1061CBB;
        Fri, 10 Feb 2023 06:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABDDC433EF;
        Fri, 10 Feb 2023 06:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009302;
        bh=ZQR6K3pJ1iyr1U5DgGyywyBhDHQYnv2UToP9osG1yr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnbGhTWmIOPlMrFHzHnbfUMGoHTVDgQcjuLse6ETc3xle8CvZmYIBVeN1ANg4/Zb2
         JaMMlpx6j35wMuNuIkyBsyteRpF4dYFdI0qZViJIlruwd0IHDbUXFz/IYkwoM/BOtm
         Uy7YCKTUosjubBpYMdJe7in9Kfjzv/+UbOtLRffva5LfaVhX7FTLbO2orC1m4vm7wu
         SJYxww8fkEOQcXbGGfjJtaMPay27UCbp58pMW+vI9ExhtaxLtx/bCNRLm/NmydAF5b
         zxCvwliIJDFPGj29sy8b4geaiYb1XVNn6CrDeQOwKNgeISck+5rzWXfUjEF/4gOBvp
         bii9/BjOQcayg==
Date:   Fri, 10 Feb 2023 11:38:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: Simplify
 dmaenginem_async_device_register() function
Message-ID: <Y+XfUh3lk+4Uopmu@matsya>
References: <20230130112830.52353-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130112830.52353-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-23, 13:28, Andy Shevchenko wrote:
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.

Applied, thanks

-- 
~Vinod
