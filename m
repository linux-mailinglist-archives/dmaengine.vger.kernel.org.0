Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46EE5632C5
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGALm7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiGALm4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 07:42:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3385823AB;
        Fri,  1 Jul 2022 04:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F362B82D77;
        Fri,  1 Jul 2022 11:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A52C341C7;
        Fri,  1 Jul 2022 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656675772;
        bh=Bk2ThHc+A9FNBxQ2tLxDVr43abStFyrFGI3w1+QbHmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKD6jtOaqBG5WjYY5lzrsiQ8IDmlxhPLlGo4PW4zUd5xydnAdhUSW31ZElPYJwU35
         r84ze7ycaJS3DvK+N9ePJ9V3o6ZmNRdKH28unV8rkgRtyG0F833Zf5kfhNhBGuQULr
         kI/UkE9jIEvDsc8vjQirYwadjfJfQVKAwPbC5wZaHDKoDpJrYBfm31FNY6hWzn+xIH
         sotWEnY4zeyLQggHF12aL5u2rDQO14fhg2jk3mBoeFJTqww53VlZVtYMbEgfE8WKOc
         4rwxPiHxWyHiNo91s2lTvPikUJLG5SVklr023V/E0xB+snGDvtjG+3mBYrygMXP/qY
         Bs63MVoy/kk6g==
Date:   Fri, 1 Jul 2022 17:12:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Tony Zhu <tony.zhu@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: idxd: force wq context cleanup on device
 disable path
Message-ID: <Yr7dt1TdlVLNL30D@matsya>
References: <20220628230056.2527816-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628230056.2527816-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-06-22, 16:00, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Testing shown that when a wq mode is setup to be dedicated and then torn
> down and reconfigured to shared, the wq configured end up being dedicated
> anyays. The root cause is when idxd_device_wqs_clear_state() gets called
> during idxd_driver removal, idxd_wq_disable_cleanup() does not get called
> vs when the wq driver is removed first. The check of wq state being
> "enabled" causes the cleanup to be bypassed. However, idxd_driver->remove()
> releases all wq drivers. So the wqs goes to "disabled" state and will never
> be "enabled". By that point, the driver has no idea if the wq was
> previously configured or clean. So force call idxd_wq_disable_cleanup() on
> all wqs always to make sure everything gets cleaned up.

Applied, thanks

-- 
~Vinod
