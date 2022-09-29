Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80D15EEF17
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiI2Hcx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiI2Hcv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB8138F0B;
        Thu, 29 Sep 2022 00:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B00162063;
        Thu, 29 Sep 2022 07:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF21DC433C1;
        Thu, 29 Sep 2022 07:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664436769;
        bh=fdtYhFuA7lgdfB8bFDS9FiJx6x5oeWMDaKJz1jOPrTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqsG+jXtCf3FSgMAgNOu6AT+t9bNVWxxgbrAFPxP43atrflCISowZi5CfJaNoW6DX
         TyhztZNoF2yeAJ8DtsnyXPmZiWYWSa6HAv2pL1htjdA4h4D6n3dmxL3X6n+N91ujXm
         fGXKiP8JHcHoRXf5oGBY1AQGtlaQSjf07I1IizXXmx5E8azDEfvnhkN4YIYgBHk2S0
         9Pen7uNlk+gUhyikTJMPsbOLhAQ7UDW0iI4sSJ8yA7bCfqQkfm03BjtJQYcJAQAVF4
         bq5rIfRcZG8OmZ8kK8COquwuqpH81KaNvUpDIELc7Ii5aax6ZWbGQO68BBK2LsqwHQ
         dyWoU4WotjLKg==
Date:   Thu, 29 Sep 2022 13:02:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 0/2] dmaengine: idxd: Fix up re-enabling device
 workqueues
Message-ID: <YzVKHWip32Y1swG5@matsya>
References: <20220928154856.623545-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928154856.623545-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-22, 08:48, Jerry Snitselaar wrote:
> Currently if a software reset is attempted on an idxd device
> the workqueues will not be re-enabled, because it will see
> incorrectly see that wq->state is already set to IDXD_WQ_ENABLED.
> So set the workqueue state to disabled in idxd_wq_disable_cleanup(),
> and use a bitmap to track which workqueues have been enabled so they
> can be re-enabled during device re-initialization.

Applied, thanks

-- 
~Vinod
