Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86B5EFB8B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiI2RFr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiI2RFn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE15FF7;
        Thu, 29 Sep 2022 10:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 664BF61FE4;
        Thu, 29 Sep 2022 17:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D866C433C1;
        Thu, 29 Sep 2022 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664471140;
        bh=/Ns5udtIoy5Gv1RHDJwtfbZDb3xMN9STvDj8547wnVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfhK9aF4WgN15PNax22DfvlQxYwDJUNgh6Op8KodStt37Rc/3RmNOC/sxSw3XfuHU
         UoerEkuVkPrbrCk8Ax6UnbNA6Vk3O0qYc4yP+dsHoIF0B9HJNwOZaZ4PXT96IZMLCa
         +U81OIPkLqqVYvokw6bopN6p6fNnN8XUW5r5dpBUEwrtpFm265jHOHd1lo/jFHY+cR
         RJtWo0tIWCxul8KPDVxQa74kbBfTenNNeu+FiUyyWerQwAfqoXmTjHJ4jeOL8FM0RK
         qpUDtN6mpsUTe01goiQclww1noTHq4wDckzSPGfiBFH4zgrRfdBxKDfLijKRBEOsKQ
         XHg8scAdta6dQ==
Date:   Thu, 29 Sep 2022 22:35:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     dmaengine@vger.kernel.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
        vigneshr@ti.com
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Respond TX done if
 DMA_PREP_INTERRUPT is not requested
Message-ID: <YzXQYE/N3S+TijFI@matsya>
References: <20220914110049.5842-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914110049.5842-1-vaishnav.a@ti.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-09-22, 16:30, Vaishnav Achath wrote:
> If the DMA consumer driver does not expect the callback for TX done, then
> we need not perform the channel RT byte counter calculations and estimate
> the completion but return complete on first attempt itself.This assumes
> that the consumer who did not request DMA_PREP_INTERRUPT has its own
> mechanism for understanding TX completion, example: MCSPI EOW interrupt
> can be used as TX completion signal for a SPI transaction.

Applied, thanks

-- 
~Vinod
