Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF90528C41
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiEPRsi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiEPRsi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 13:48:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173D37AAA
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 10:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87BE2B8125D
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 17:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705DEC385AA;
        Mon, 16 May 2022 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723315;
        bh=F2otUNyLy6rXnu8dsNaEoFiZWGmx++C8QOY7xewn8Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAp75xoKjaUXoutxPaN65ryUJOqOp2yyJ3bobuIWebSKEkqtj2cdErR/SI9rPX9NL
         FhgZ6L2YO46J9slq06ItAKxLpLQrPI5HnwOprzhUD0PZTgNwZ3P4DpgH2iJ3tTgiNs
         7/7Te0zr+dVHmgLtiF5gzvQM5ef0udywn4jWe6bAQ27L6feJIqme6GIINAN+v7ayzN
         9bQMSVUoObVk9fjnK6QvGsvm+R7VJC2eVqICoAJ5AKojl90dBTGD99y61ygoTJB6Jk
         OFR7MSOx8AN5nkr03apauDsC2MORPNLQG7HDPymNnYutFzt7vX2tCkWL8HXgooxqSs
         BVUUESfiAUrkg==
Date:   Mon, 16 May 2022 23:18:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add missing callback function to
 support DMA_INTERRUPT
Message-ID: <YoKObhZKK3Yen6cx@matsya>
References: <165101232637.3951447.15765792791591763119.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165101232637.3951447.15765792791591763119.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-22, 15:32, Dave Jiang wrote:
> When setting DMA_INTERRUPT capability, a callback function
> dma->device_prep_dma_interrupt() is needed to support this capability.
> Without setting the callback, dma_async_device_register() will fail dma
> capability check.

Applied, thanks

-- 
~Vinod
