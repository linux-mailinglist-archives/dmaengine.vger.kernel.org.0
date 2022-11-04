Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915A6199AC
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDO0V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKDOZk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:25:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73013EA3;
        Fri,  4 Nov 2022 07:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BEC5B82E10;
        Fri,  4 Nov 2022 14:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF1C433D7;
        Fri,  4 Nov 2022 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667571806;
        bh=whWPClS/alRqLYsy1/mTyPtTHF0C97qQhJcqxk8t16I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsUxoSPPwM84zkz+t8UXsKETEK+fOHmyO99JoXKzLbR6+B+tYqxRNe2154rS69XVK
         hwu2kI3Du2EbFBy0dyOiHqoLe1QDqzrJwoTudAzvA2vYEpfTpYkh3PAOz0+UtJWerX
         qBVtJ2I6xGiauK3WbxTS6ILRPywkDGFbQKPJw15+FGDuJRcLSrD0YOIA/IK5AtUriP
         dMzr4ruC1fjpJ9TvEaqNsh4Ez3LcgvCwPbsdDWvColBYwR2S1xeEjOKaA3SDZEGx9n
         /lt5L7aTQI+MNgY4Gg0Nj97fGVdbEHvXhAGRJRSIaX7v5MxhcAMvr0YoE4tm6dI58Z
         VvXuBhEuMcRZw==
Date:   Fri, 4 Nov 2022 19:53:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mv_xor_v2: Fix a resource leak in
 mv_xor_v2_remove()
Message-ID: <Y2UgWUSppfl+nngY@matsya>
References: <e9e3837a680c9bd2438e4db2b83270c6c052d005.1666640987.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e3837a680c9bd2438e4db2b83270c6c052d005.1666640987.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-10-22, 21:50, Christophe JAILLET wrote:
> A clk_prepare_enable() call in the probe is not balanced by a corresponding
> clk_disable_unprepare() in the remove function.

Applied, thanks

-- 
~Vinod
