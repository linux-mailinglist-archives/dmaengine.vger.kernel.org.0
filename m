Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2835EFB04
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiI2QhV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiI2QhU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0301288AF;
        Thu, 29 Sep 2022 09:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B232EB823E0;
        Thu, 29 Sep 2022 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C50C433D6;
        Thu, 29 Sep 2022 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469436;
        bh=vNYtvUwZ3HUq8cwYA19NVMmvgmpcrt5d+/MrssAtMJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6anIAoCx3kZr1zafAJ0CY9NGHSvOaCHXAXVV1BAvAhKOfkxWtOeZsXUNnvt1TN6c
         6XBWgMSAcST0XVlIv5tiV4OW06GsnIQI7RN5CdOf26nUv5fMqJ6a2U2vWA2GdJiZsp
         kWjZL+V70yM+cPvrwRh4aH8KTC2Zn+tZbN3+RFdTDum/jDVWGPa5GA67ebnmFEDWq+
         otr/qSGFGzBndUSeq23jQU+a96xr14rCuD2U3AHc6tMozT/xsp+Q9xTbmpLlLNVLaw
         PlXJWBiNedJTD7xgbJ1hhRCrZ6pWLD96SX9PinHLyZhssSJO8ghDu5Pon4s8DhAzTT
         q/4pvUHiti2bA==
Date:   Thu, 29 Sep 2022 22:07:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <YzXJuI5lwF10JguR@matsya>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-22, 20:08, Rafael Mendonca wrote:
> If the IDA id allocation fails, then the allocated memory for the
> idxd_device struct doesn't get freed before returning NULL, which leads to
> a memleak.

Applied, thanks

-- 
~Vinod
