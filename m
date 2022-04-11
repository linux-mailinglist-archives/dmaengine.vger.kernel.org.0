Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846B4FBB78
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiDKMBm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiDKMBk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 08:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE319032
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 04:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5849615E5
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 11:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797EC385A3;
        Mon, 11 Apr 2022 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678365;
        bh=EgCPKI6svrkgsZGhyD7Dnk4uJYIRsvr1axFHynpwkOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uz6+Z0yePxOMmtJNKHZHOEXihbJ9B6CxcOsX7gitErlDmz1QnJSoH+0sxTF1574Ke
         2W+EjYNonQS0RQAgrBKeKHz7dxCTObJD3wQ5DpOCxe1yrrnMLBryhJyCgbvi4qHAR+
         ld74cSeQ3l1xpemLgj0OUJ6rxe8iG7eLL8+q6kuzRoLHWfL3W+S9NMwLnoDDGmN7Tz
         AHu20pMOjzrFaaXEXgtm2W0CKk9s8uAiLiZ0XUotTDkLF72O3fzChfE97W1GYiMBwH
         FoAO9NBiDawuY6lDGl5i3xVlDVI46nQfVMWHbYEZ41FxTv1zHc58jXAPrqgQYraBOe
         YtpVzYnv8Jz4w==
Date:   Mon, 11 Apr 2022 17:29:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: don't load pasid config until needed
Message-ID: <YlQYGXWWtYgMvEPq@matsya>
References: <164935607115.1660372.6734518676950372366.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164935607115.1660372.6734518676950372366.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-22, 11:28, Dave Jiang wrote:
> The driver currently programs the system pasid to the WQ preemptively when
> system pasid is enabled. Given that a dwq will reprogram the pasid and
> possibly a different pasid, the programming is not necessary. The pasid_en
> bit can be set for swq as it does not need pasid pasid programming but
> needs the pasid_en bit. Remove system pasid programming on device config
> write. Add pasid programming for kernel wq type on wq driver enable. The
> char dev driver already reprograms the dwq on ->open() call so there's no
> change.

Applied, thanks

-- 
~Vinod
