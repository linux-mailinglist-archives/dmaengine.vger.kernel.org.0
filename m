Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709814D5BD1
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiCKHAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 02:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiCKHAq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 02:00:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950619D619;
        Thu, 10 Mar 2022 22:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B034AB82AD2;
        Fri, 11 Mar 2022 06:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A3C340E9;
        Fri, 11 Mar 2022 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646981981;
        bh=0WbXxLuxlZKAOqGKpTMpp6DzDDfXQiNeF05NorkWRvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAfDw4UK8vxKnXrwzJ0oc89AnkFLsoJbKawVpuaVMFICufxHI0nTTk/H+FLbD35UG
         2pacxuaZf0p3BgDZ4hARUoM3qXCX7ZgPIwOnvW9mu+suDqhPqruepBwJo/HSiPFNGp
         6lWmWNFmy1yFpTSNUM8tssSvbkKpOimXsWGQG26P2cuqcMFNOp5vm8lF7n/vF1x3DA
         C+6UivbBSe7Gay/LQRkipls/X+A2iWokrMuhULxaAcH7c4hz7bjrscM8KRVtOL06nI
         VOEw741wjoJwFMD6q58D/ZjnrQSSj7bRossmloQjtR6gCAvsyF5cd6r+oub8txOAvi
         TwTaynT/hr2rg==
Date:   Fri, 11 Mar 2022 12:29:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] dmaengine: imx-sdma: clean up some inconsistent
 indenting
Message-ID: <YirzWX6bHLzTmhQE@matsya>
References: <20220217011604.123106-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217011604.123106-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-02-22, 09:16, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/dma/imx-sdma.c:896:3-16: code aligned with following code on
> line 897

Applied, thanks

-- 
~Vinod
