Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA29569184E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBJGIC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGIC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:08:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570638662;
        Thu,  9 Feb 2023 22:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88BA1B82363;
        Fri, 10 Feb 2023 06:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A5C4339B;
        Fri, 10 Feb 2023 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009278;
        bh=xAYq0m+TN9NE+gqZV+hA2IrMne/6+qx7kx4zkU5rzyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOwdRxlD4uV9xAQqMqfr3fKFmfO7y45HDWOYnGTAYjLKu5GvLvsx31ttgWyLE2DQo
         kGbi/IANd9PB4RG7J42PIbJX4JQUxyXQDfO/m+LLCjPKGcExMoficmjdkrofZW5qH6
         n5ClL7SToPKsdFy/b0y9rReoyaG0IFc5Zk9KeRmM/53zDuDBvaquyyqxd2n2WIf9MH
         IN9fLNSZXz4qfdsDw0FjmWgMjTPXy5Ii+GRISdIG7HxbsrHimf0hM4hI2Z1VcmtJaY
         UXsmKqL1qUScWjQ2NGOf693RLqGO267nGY1VQ3Coe0RD0wYUtEetfkz8hr0jnohF3v
         1xp9hW7JUVX1A==
Date:   Fri, 10 Feb 2023 11:37:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: Make an order in struct dma_device
 definition
Message-ID: <Y+XfOs1LBjX18SH8@matsya>
References: <20230130110503.52250-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130110503.52250-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-23, 13:05, Andy Shevchenko wrote:
> Make an order in struct dma_device:
> - added missing kernel doc descriptions
> - put descriptions in the order of appearance in the code
> - updated indentation where it makes sense

Applied, thanks

-- 
~Vinod
