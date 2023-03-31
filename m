Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449DC6D195E
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 10:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCaIGh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjCaIG2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 04:06:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CC12CF5;
        Fri, 31 Mar 2023 01:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F665B82CD7;
        Fri, 31 Mar 2023 08:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417E4C433D2;
        Fri, 31 Mar 2023 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680249972;
        bh=hwI8O7moMEGKvJAw99qM33KgYZAC18q5nJaBazMJeU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPd8f4Y1fzyJ2H/C8lzIiZnigs4/n2M2AoPnGAVoIruPfK3TYFLfC8tw1XYmoCmiZ
         KoJtcdPWqSWzpzyGt6AJrbop30nsqwesiVI1gIzY0pWuHffyus4ZJzR7J/p8tpRWO8
         nLJM/ly+G1qQBRCSWuSNUWTVeU562tcdVbvrLSbquhkSnVmw7GdQSkLkkrouzEFn8u
         ClAccJCotZYVrFGLMGPCWjvnA9ChTgSvEh6hpY4s977rsnWoCfjbpmwyDgtcDfMQE+
         LkmOS48WYYO9Zsb7VfQyKM6RhjH0imj9V5l31GM2yBYDKG1tCapg6ai1dRvPB/8Kot
         aQLkft/yf2xXg==
Date:   Fri, 31 Mar 2023 13:36:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2] dmaengine: ti: k3-udma: Add system
 suspend/resume support
Message-ID: <ZCaUcFXeOLRemD7J@matsya>
References: <20230329155349.2566010-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329155349.2566010-1-vigneshr@ti.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-03-23, 21:23, Vignesh Raghavendra wrote:
> The K3 platforms configure the DMA resources with the
> help of the TI's System Firmware's Device Manager(DM)
> over TISCI. The group of DMA related Resource Manager[1]
> TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
> This configuration however, does not persist in the DM
> after leaving from Suspend-to-RAM state. We have to restore
> the DMA channel configuration over TISCI for all configured
> channels when returning from suspend.
> 
> The TISCI resource management calls for each DMA type (UDMA,
> PKTDMA, BCDMA) happen in device_free_chan_resources() and
> device_alloc_chan_resources(). In pm_suspend() we store
> the current udma_chan_config for channels that still have
> attached clients and call device_free_chan_resources().
> In pm_resume() restore the udma_channel_config from backup
> and call device_alloc_chan_resources() for those channels.
> 
> Drivers like CPSW that use k3-udma-glue already do their own
> DMA resource management so use the late system suspend/resume hooks.

Applied, thanks

-- 
~Vinod
