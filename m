Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329E69185B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBJGLR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGLQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:11:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539D38662;
        Thu,  9 Feb 2023 22:11:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1695FB82363;
        Fri, 10 Feb 2023 06:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D52C433EF;
        Fri, 10 Feb 2023 06:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009472;
        bh=QLiE6gkj5Z8phLbz5FIHU7mPTkTK6mawflmKsqJKZeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+XZ77nGRcGoMZY8tAtd+3ODdeKJDv3adVfHMrvbMVfHT9Bu+XDXsjmL++bO/KpFT
         26CCYfLsw/ijEJNassKtUO7EI1EbYOgQ3LbZvtFKGzMJIEJb2wYJJLcxVyHuL7Hjdw
         9PmTkXKJJEdZI6kXgp4kLzQffJkSee7jUlCZ9NaxCE/hoKFJ6AwrZEh55bAdk0ctit
         wQou+fn6kzIu7V12eOTngfLoxuiccSCcivKfV817T3SF5C2uUT46qOTPpXVWZEar6w
         k82ECOi92VXjZOpzKASIAFRxG1xahW7FVxlhDx0yHpwVvT2FXG7u9OjBivsuH0S0GX
         Y3Hb2boWlJP7A==
Date:   Fri, 10 Feb 2023 11:41:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Move check for paused channel to
 dwc_get_residue()
Message-ID: <Y+Xf/OqHhRjKPdQD@matsya>
References: <20230130151747.20704-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130151747.20704-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-23, 17:17, Andy Shevchenko wrote:
> Move check for paused channel to dwc_get_residue() and rename the latter
> to dwc_get_residue_and_status().
> 
> This improves data integrity as residue and DMA channel status are set
> in the same function under the same conditions.

Applied, thanks

-- 
~Vinod
