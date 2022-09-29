Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58CD5EFB42
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiI2Qsg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiI2Qse (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:48:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793A1CD117;
        Thu, 29 Sep 2022 09:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5195DB82573;
        Thu, 29 Sep 2022 16:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D84C433D6;
        Thu, 29 Sep 2022 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664470111;
        bh=Tp5H3jVIEwFE3SV+vvO/B3k7OVx4JaJeMGqu8WZxptU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppW63Y7QLxGzh/L7y0NNlk+LGZ6Lr6IZR7llWrEpc/wSwjhiHZuvXNBLGaCx9t5sR
         HRIOlFj8LObKRN1WNL+LX+WIFtFaJK0/bcn3F7+vmyePj948zk33e4mdbt6m91o45+
         xVm2btVTV8YXnaEZFAMAYbDX9XBlZbN1QGE22vnOPUJJY0ve0dRiT7t4K5iL9o5GF+
         SI0V3V+RnEa0AiyxlVGGZ+L1R81HnuKT3j6YFGYrEQuahPWfXSm9VqYpZ8cGJ+qMwV
         qgfOH/jLmuxCfEgdI6yU4WaQjRryfXDcWOWYU3FKk7XKxGNuI94oIdE8iEmdEvkxiU
         /o2hstiBvB76Q==
Date:   Thu, 29 Sep 2022 22:18:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swati Agarwal <swati.agarwal@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, harini.katakam@amd.com,
        radhey.shyam.pandey@amd.com, michal.simek@amd.com,
        appana.durga.kedareswara.rao@amd.com
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Add device_synchronize support
Message-ID: <YzXMWrGekWc5sCcC@matsya>
References: <20220915090516.5812-1-swati.agarwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915090516.5812-1-swati.agarwal@amd.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-09-22, 14:35, Swati Agarwal wrote:
> dmaengine_synchronize implementation is required to synchronize proper
> termination of current transfers so that any memory resources are not freed
> while still in use.
> 
> Implement this callback in the driver so that framework can use the same
> (in dmaengine_terminate_sync/ dmaengine_synchronize).

Applied, thanks

-- 
~Vinod
