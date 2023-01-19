Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A23673A3A
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 14:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjASNal (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Jan 2023 08:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjASNab (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Jan 2023 08:30:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB57A505
        for <dmaengine@vger.kernel.org>; Thu, 19 Jan 2023 05:30:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBC0FCE22A9
        for <dmaengine@vger.kernel.org>; Thu, 19 Jan 2023 13:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E595C4339B;
        Thu, 19 Jan 2023 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674135013;
        bh=d0NKl7S8MmzqwjLJ+ovbAHwdUMqPPSop8DR07/FXtxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+DzvCm3j97MifW706MLjApGVrObDMFEVvxIucGvSWmCK4ivXqcZTLAivrcPTF5af
         KK0E/xQZdxm1v5KYE5AwVdV4kZmXPRlUhnnwiqtnnNBYK5vtP2F7845xlhsOCbm2gj
         hCIUR4O+2dO3YyCn2eWlI3CckhDOCd4RSuxUI6VnG4ftbfss2Kgi0HUZU4zzpn1YqH
         zFjj8BsbluM6Q8+KCfZ2dWfRZHFfCYrOQJJKKjVq7vOK3I/Usf2hp+aISxCOZwBODb
         wjAO8XvHH32hnN32onOD0lXxkncBak3jKxNpnZLwY8Jy3q4YbM1dDvWiOqCK33KBix
         7YnDfcNW8tlwg==
Date:   Thu, 19 Jan 2023 19:00:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     sanju.mehta@amd.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH] ptdma: pt_core_execute_cmd() should use spinlock
Message-ID: <Y8lF4YNal4rS9jN9@matsya>
References: <20230119033907.35071-1-epilmore@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119033907.35071-1-epilmore@gigaio.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-23, 19:39, Eric Pilmore wrote:
> From: Eric Pilmore <epilmore@gigaio.com>
> 
> The interrupt handler (pt_core_irq_handler()) of the ptdma
> driver can be called from interrupt context. The code flow
> in this function can lead down to pt_core_execute_cmd() which
> will attempt to grab a mutex, which is not appropriate in
> interrupt context and ultimately leads to a kernel panic.
> The fix here changes this mutex to a spinlock, which has
> been verified to resolve the issue.

Applied, thanks

-- 
~Vinod
