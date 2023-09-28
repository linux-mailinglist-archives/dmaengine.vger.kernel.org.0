Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFD47B1B73
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjI1L4I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjI1L4H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8CF121;
        Thu, 28 Sep 2023 04:56:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB8DC433C9;
        Thu, 28 Sep 2023 11:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902165;
        bh=5b+JFvT9DiouyTUTSqMvYLxQB37vJpbM/wYpqa0N+1Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JWn+F8RprkQZi3B0bDtJqjDmMM8RUdXBlvsOTsWYDU+p9o7nFpcB+kaaJs/bW4fj3
         86MFWePufY/fd6Wb72TyvR1SS8DJTdhsNOzy+Z6u/F+WohhRj4FFcwbb1JnKzGuGXk
         GC4Iduf266O3HekLcoS1mC625s+iPJFHJMVz+5S9M3gtgO68Tim+3fHjQh1XLD6+BO
         ZX4pSlwTk2q/o6dBjwgqgyRwNH3ewBZWnBAjzLj0sPd4ec+S0sSoBZ9/r7+iSOoM59
         SRvfRl4uEEqMhVMd/CGd+7B4JQLm1Ashwmoiz+JwZ2BpWEv78DjLD7yMrLLEGw7VKv
         bqlpSigxz9UtA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Prinke <michael.prinke@intel.com>
In-Reply-To: <20230924162232.1409454-1-fenghua.yu@intel.com>
References: <20230924162232.1409454-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Register dsa_bus_type before
 registering idxd sub-drivers
Message-Id: <169590216388.152265.6921600433276753022.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sun, 24 Sep 2023 09:22:32 -0700, Fenghua Yu wrote:
> idxd sub-drivers belong to bus dsa_bus_type. Thus, dsa_bus_type must be
> registered in dsa bus init before idxd drivers can be registered.
> 
> But the order is wrong when both idxd and idxd_bus are builtin drivers.
> In this case, idxd driver is compiled and linked before idxd_bus driver.
> Since the initcall order is determined by the link order, idxd sub-drivers
> are registered in idxd initcall before dsa_bus_type is registered
> in idxd_bus initcall. idxd initcall fails:
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers
      commit: 88928addeec577386e8c83b48b5bc24d28ba97fd

Best regards,
-- 
~Vinod


