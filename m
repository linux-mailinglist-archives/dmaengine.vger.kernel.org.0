Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE45EF995
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiI2Pz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiI2Pz4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 11:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496BF108081;
        Thu, 29 Sep 2022 08:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1168618CF;
        Thu, 29 Sep 2022 15:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A377AC433D6;
        Thu, 29 Sep 2022 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466954;
        bh=strQ1cTtSFa7c6rNX/9qXNlPx+SJ1jtkhz9AomUjClU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ+QgzIXiQ0L6FuKV9j864o4Nktj5o3fE4ysl8YcG+PKhWYji/1E5J0rfnassSntj
         j8KiFKVEYHIdnfmtJuMtqL0V/0IW9Db2JTHkMmb3goW4pcUq+gdTiC9wONfQXZ8/ya
         dQYeeyRuoFhNh50SzVNlkF+jvfF2RrtYawf6jt+o6Tnc90N2gA2qYVSySW8TNvkQ7s
         o67iWLKEwTUS8qDX8L+5/LMusJj6+WuKHqGpq9CBvOg6CRYbcytk5/9EQbv/Mblv7w
         jLU5h5qw/i98GQ41He+aYVpgQbzhPL+qsk1zLTUx0g3HGqaG4SMwLgNBtuVapNlD+W
         xfelW6/d6dFnw==
Date:   Thu, 29 Sep 2022 21:25:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: ti: edma: Remove some unused functions
Message-ID: <YzXABt7oNtZ7KDSe@matsya>
References: <20220914101943.83929-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914101943.83929-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-22, 18:19, Jiapeng Chong wrote:
> These functions are defined in the edma.c file, but not called elsewhere,
> so delete these unused functions.

Applied, thanks

-- 
~Vinod
