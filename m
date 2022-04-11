Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030134FBB8F
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbiDKMEZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbiDKMEU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 08:04:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1F40A05
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 05:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14265B815B4
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 12:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253BFC385A5;
        Mon, 11 Apr 2022 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678520;
        bh=nbcvDtyXWhUGAUkn3X7rUP8c9AQ89q1b4i9HXzKN3Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDbJPjyY3hN+Qk85kMmS8q1EHaE098XNPBrEKAYxpAiLNgsiuhBW9BCM3iZfoBvnz
         9xanUS4718T3fgCwaGr8FUi52K9EQlQ0xDgv9NGbLv1YtA1K2WDIspa3ogOXANcfKl
         LO6V7DTY83uKrXhTM7stuYixJlQFTfrzAaBH85pixid8T9Bjd3HJdNgd8jFdwuMvn5
         uA9WGi5wm0lSx9kauXnCFBjiPmUuXK54kSPS/wOEC6b7inmWI5mFh4uxKWtvMQxLjf
         spN5SDKQX+dgqA2PhXIMsVIepKOelcC/ltGKlo9HaVERCK8qyzdCP7j99vRsof7FO3
         Ca1Lrtz8l70Xw==
Date:   Mon, 11 Apr 2022 17:31:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ep93xx: Remove redundant word in comment
Message-ID: <YlQYtLk+7O9hJ81o@matsya>
References: <20220403123120.7794-1-jianchunfu@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403123120.7794-1-jianchunfu@cmss.chinamobile.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-04-22, 20:31, jianchunfu wrote:
> Remove the second 'to' which is repeated.

Applied, thanks

-- 
~Vinod
