Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49B581370
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiGZMx7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGZMx7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:53:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0DF1DA45
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 05:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C7B4B8161F
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 12:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF7C341C0;
        Tue, 26 Jul 2022 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840035;
        bh=kP12SYaCaA9H6GHGi7rDOnDPrIJd4pb1k41JfpfRqvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seEoF48amBWVBmQ35RyUme6JSfyw0pB4C2JgHWHDAq1F89qPEh3FbB4bvm0FZ+INI
         MpxY6gJHb5J7YNrqVHLdEiwYcIIe70hO7Xa5Jk4/s9OsT7FeVNx8JOUrYiexXjiik4
         rXCYB9qgilYvl2V87HQ0HVi1EOYZ/ySJEs3DK56oFDOpEU9XHqjRH6YZ5QSaEjkZ7h
         mbIR2HnYa3dj5TgNjDZDht597HtJ7IurA5QlEe4NIyiadJU+VP9ui+B9kUi9Q/4tQt
         jp4zfMJ8RcLGHw4Evsx5riQOi2T5dZ0OXeWUK/cRn+onjVnPzr/WYihbUqfD8ZSM1u
         6jnKsK37tpX4w==
Date:   Tue, 26 Jul 2022 18:23:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrian.larumbe@collabora.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove DMA_MEMCPY_SG operation as it has no
 consumers
Message-ID: <Yt/j3/wZZeyYI276@matsya>
References: <20220726094323.566140-1-adrian.larumbe@collabora.com>
 <Yt/dyVXRQ3vxzufo@matsya>
 <20220726125101.k6drrb6tfcwfityc@sobremesa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726125101.k6drrb6tfcwfityc@sobremesa>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-22, 13:51, Adrian Larumbe wrote:
> On 26.07.2022 17:57, Vinod Koul wrote:
> >On 26-07-22, 10:43, Adrian Larumbe wrote:
> >> There are no in kernel consumers for DMA_MEMCPY_SG. Remove operation and
> >> Xilinx CDMA driver code which implemented it.
> >
> >What was this based on?
> 
> dmaengine/master

Pls use next, next time :-)

-- 
~Vinod
