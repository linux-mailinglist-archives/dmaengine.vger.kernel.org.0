Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E3691A75
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 09:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjBJI5S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 03:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjBJI5R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 03:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C73EC5D
        for <dmaengine@vger.kernel.org>; Fri, 10 Feb 2023 00:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB8461CE7
        for <dmaengine@vger.kernel.org>; Fri, 10 Feb 2023 08:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65954C4339C;
        Fri, 10 Feb 2023 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019434;
        bh=cq2Zjxb9IFLTjKoTG1Sgf8ioMQeBIEyucNefb0l2NQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPn0LRYUWl2kdcJeerNjD6GpodqgG85RywOQ86VQZQ0sPE9uqO7c3pRZ5z8n2XWTO
         aTT0BRAQV/HbCLuEEUMuQc2JUWyS5tKUBtOOkVcPtWLO0ZLBK9ZpAt5i78NepStaxf
         xj8TyWCcbF6Au6F23HC5xqP+S3z/j7yP0Q5so+W/7zEqux0Ue0I2lgismC8kRzFlP8
         ZjgLXjGPJkE/BbxqZRIicEL8UJdsaRchUoVwUU+zrqyAdIGp6sOqftFOGEK+6c2yvw
         GdvwgcDFd0D9GqAKw7oYlP+++d+TF9HXTKTWIgJHdzSiiC3ACr42G2mGBOvJoeBYzc
         UYD/ZKpuHUTSQ==
Date:   Fri, 10 Feb 2023 14:27:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     Sanju.Mehta@amd.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: ptdma: check for null desc before calling
 pt_cmd_callback
Message-ID: <Y+YG5QPxpjdjHlxA@matsya>
References: <20230210075142.58253-1-epilmore@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210075142.58253-1-epilmore@gigaio.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-02-23, 23:51, Eric Pilmore wrote:
> Resolves a panic that can occur on AMD systems, typically during host
> shutdown, after the PTDMA driver had been exercised. The issue was
> the pt_issue_pending() function is mistakenly assuming that there will
> be at least one descriptor in the Submitted queue when the function
> is called. However, it is possible that both the Submitted and Issued
> queues could be empty, which could result in pt_cmd_callback() being
> mistakenly called with a NULL pointer.
> Ref: Bugzilla Bug 216856.

Applied, thanks

-- 
~Vinod
