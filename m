Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8965736D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 08:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiL1HAD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 02:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiL1HAB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 02:00:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7728B9B;
        Tue, 27 Dec 2022 23:00:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85ECD61286;
        Wed, 28 Dec 2022 07:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617A6C433EF;
        Wed, 28 Dec 2022 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672210800;
        bh=Jo+l7IDwfenVlSG1rQ201Swfp6qyC0EM/RykRufwhHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+jeVYnoZIfdCJhmzrsya2aZGaFppsfEdiXrwhEb/wF/Jl08M4ZNXgRxbMvJ9r9Qu
         XDBdvKtYJofryWZjbpCQLQsm++hWPUxmpMl64oNVkdIIkS3D7S+bEnd5py04Y5sXzv
         5TecK+nTXAxbW17nWVqzXqBPjKlTeX5751ERuNCw9z4jrwLLCdWzhm9krJiv1q69rn
         r4yrpNPijmDXFQiw5X7OKIcNp+wUyFBr2qN4ufUmMaNLbELkLms7HBDsrd+lxr7Ct3
         M7fTsykzMm3jlAl9wBsW+yAydfOmwZphwB7+cVxWUYMns210PhrWX6igXkN6cLVU1q
         /DoNGAP3YUJtw==
Date:   Wed, 28 Dec 2022 12:29:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] dmaengine: idxd: Remove the unused function
 set_completion_address()
Message-ID: <Y6vpa+ItYy0IUrpC@matsya>
References: <20221212033514.5831-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212033514.5831-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-12-22, 11:35, Jiapeng Chong wrote:
> The function set_completion_address is defined in the dma.c file, but not
> called elsewhere, so remove this unused function.

Applied, thanks

-- 
~Vinod
