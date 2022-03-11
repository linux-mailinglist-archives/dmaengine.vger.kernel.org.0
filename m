Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD64D5F29
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbiCKKKZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiCKKKY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 05:10:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC132EC1;
        Fri, 11 Mar 2022 02:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C001D61620;
        Fri, 11 Mar 2022 10:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AC1C340E9;
        Fri, 11 Mar 2022 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646993360;
        bh=TWUk4GO2oB/K3czDnPcdU7EQjZJTbqJNvkFZfSomEHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRCjkwRAAtFjFb+rc/AgI177DMno+xoydk4ZqVin8RwlUr8yy5slsm2kUFeFdFtdi
         pdUJ4fZoYga4vT0TtKvN6u2wAJh1CgiEWNQruKgjZvPOxrmUq2W6QvgzT9fWYdwOiv
         bqr28PcGAcxAJIGLCcyG8iRqUMY+UncTq6GdYhuiqojbRkHJlE0qaY++Hx5iNxDUzg
         cFtL1YG4ri4hEq9UO+KL4cj+j5gkimN42UMKrqUuhbaFAE5R+7AMKhRHlqEDQEJtKT
         TpvgLr2zYNLuOqWqNA1ughzDJFpnUPDSW2WNY6M/JBGSi6Ygo4T4LFUhkCIE19RVZG
         mlX+fhFMw2+gw==
Date:   Fri, 11 Mar 2022 15:39:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Salah Triki <salah.triki@gmail.com>,
        Jason Wang <wangborong@cdjrlc.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ppc4xx: Make use of the helper macro
 LIST_HEAD()
Message-ID: <YisfzHlbqRRzKCOE@matsya>
References: <20220209032221.37211-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209032221.37211-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-02-22, 11:22, Cai Huoqing wrote:
> Replace "struct list_head head = LIST_HEAD_INIT(head)" with
> "LIST_HEAD(head)" to simplify the code.

Applied, thanks

-- 
~Vinod
