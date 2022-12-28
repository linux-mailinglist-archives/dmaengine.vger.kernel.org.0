Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4A65759D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiL1LGA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiL1LFY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:05:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928421AC;
        Wed, 28 Dec 2022 03:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA46C6146E;
        Wed, 28 Dec 2022 11:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FC5C433D2;
        Wed, 28 Dec 2022 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225523;
        bh=2oVQexl5Xw6F45gdOgjBBvmkf8CFOEXDNcEDndh1Ips=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2hyQOC5PJPUGEVUWtP1t7o/h7me8GYObph5X4s8pPf2Wxd0krJBKCWgh3K5u0mWY
         64e46Auv6azu1vyvTp6uqfyxetdoL16qaYK+XeWs5eSNrrhFaIdbmk3ckdVTD7k13q
         lJOxPqetgwORo9/IIHEAKrCmEwIHMEQQWA/KTbnaSsUZ28+Do5xX0oWJ4+6qFi3lD8
         0ZVk3NJgVhhcErBJ+QpmXYFlGxQ8W72dObgp9h6ICPU2M6oxBVOE+m+dus/0aWmRZY
         3PJGoVaK4lcu3uxZdxkbzZsyRk/LNFY9n4xj+sRKKa4Jj+rM+eN7g836wLOYPtiyRF
         JE1CowJe6o1UA==
Date:   Wed, 28 Dec 2022 16:35:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, liudongdong3@huawei.com
Subject: Re: [PATCH] MAINTAINERS: update Jie Hai's email address
Message-ID: <Y6wi7yKPcIYq/4jN@matsya>
References: <20221126064938.50685-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126064938.50685-1-haijie1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-11-22, 14:49, Jie Hai wrote:
> Signed-off-by: Jie Hai <haijie1@huawei.com>

Applied, thanks

-- 
~Vinod
