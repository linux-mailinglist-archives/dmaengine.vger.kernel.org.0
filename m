Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9E5284D9
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiEPM7b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiEPM7a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43F3981E
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 684CBB811CE
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E68C385B8;
        Mon, 16 May 2022 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705967;
        bh=52t/aydhQKNY4VngPN5wVFXroRu8Wj13ccGtx9w7eKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDmDsnrlmunGBN4OGZtHAfKSQb6SGZuA9fqORR2Qzak7fDdAcsA4hdqJkHHYLv/SR
         6wCvwp9zpOiybNMw1x6f27SfgCGtO/icq+gxmv5+5ZhkrR6mDz2j64Q/JG83zYXqQo
         vItZkt8Fc43qyiScJo+beVxczassxnK9AqSkxRZmrzUO9RrPYPJ6DJ3EfHkCQ/tXSS
         AJdYQr+ctckgmSJrbHieVny9R8ykAbroBH5kOY8AMUvsHet3BETzDy3kR48XRoZbC2
         mDeYtYQaBwXqXQiagnapkv/3xJtg9f4INZI4aOaGT1x75qerKA6j1y8WRpkSmgyDFj
         LStpvNL7w6Vxw==
Date:   Mon, 16 May 2022 18:29:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tony Zu <tony.zhu@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: skip irq free when wq type is not kernel
Message-ID: <YoJKq95mP4TUgVrf@matsya>
References: <165176310726.2112428.7474366910758522079.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165176310726.2112428.7474366910758522079.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-05-22, 08:05, Dave Jiang wrote:
> Skip wq irq resources freeing when wq type is not kernel since the driver
> skips the irq alloction during wq enable. Add check in wq type check in
> idxd_wq_free_irq() to mirror idxd_wq_request_irq().

Applied, thanks

-- 
~Vinod
