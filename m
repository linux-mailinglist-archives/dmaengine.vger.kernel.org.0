Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15153F4D2
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jun 2022 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiFGEDk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jun 2022 00:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiFGEDj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jun 2022 00:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4B68F86;
        Mon,  6 Jun 2022 21:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D98636149B;
        Tue,  7 Jun 2022 04:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41EDC385A5;
        Tue,  7 Jun 2022 04:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654574618;
        bh=uwZd+PtADOcTNRf/awMnnXVR+GS1giNOlX+OVaKeMZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHlWr0qRQFXAB+LPXWPfjctaYgXqB20EMpwNVUTePMjdUUtjcI7jJYNz4/BY/g4if
         30PvbW+aFEbqc0lSJm3WiRXZsoriemWarVPfUaNkvgoKigPGP7z1NVjLcFwdS6FtWn
         c3CiFxIgAgUd6ILHCGdiVKWDeTzR3MU9hOW/Kzs6kEkuzmQwABMfvmHdoTh8qhZ0Dh
         70Prt0tzaXQnVTNb5U3bffPzaMSFJD8Ug9h7Me85IkiP3ETsxuR5HJYfC4jDHgybly
         UMw8/f4Qx1CGFGUDmCokXzG4H8+M1RjI0KahCOG+IggwKuAoiL1qzWEJfi91BXHUNo
         GqkRu32j0BAWA==
Date:   Tue, 7 Jun 2022 09:33:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrianml@alumnos.upm.es>
Cc:     Christoph Hellwig <hch@lst.de>, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Message-ID: <Yp7OFYFp7oyjyKx1@matsya>
References: <20220606074733.622616-1-hch@lst.de>
 <Yp4/JW4P12s4siRz@matsya>
 <20220606195455.qmq3yu6mc6g4rmm2@sobremesa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606195455.qmq3yu6mc6g4rmm2@sobremesa>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-22, 20:54, Adrian Larumbe wrote:
> >On 06.06.2022 23:23, Vinod Koul wrote:
> >On 06-06-22, 09:47, Christoph Hellwig wrote:
> >> This was removed before due to the complete lack of users, but
> >> 3218910fd585 ("dmaengine: Add core function and capability check for
> >> DMA_MEMCPY_SG") and 29cf37fa6dd9 ("dmaengine: Add consumer for the new
> >> DMA_MEMCPY_SG API function.") added it back despite still not having
> >> any users whatsoever.
> >> 
> >> Fixes: 3218910fd585 ("dmaengine: Add core function and capability check for DMA_MEMCPY_SG")
> >> Fixes: 29cf37fa6dd9 ("dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.")
> >
> >This is consumer of the driver API and it was bought back with the
> >premise that user will also come...
> 
> It's commit 29cf37fa6dd9 ("dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.")
> 
> The two previous commits add the new driver API callback and document it.
> 
> >Adrianm, Michal any reason why user is not mainline yet..?
> 
> Just double checked the mainline, and all three commits are there.

There are no clients in mainline which call this API. There is a driver
which implements this API, but no users...

$ git grep dmaengine_prep_dma_memcpy_sg
include/linux/dmaengine.h:static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(

-- 
~Vinod
