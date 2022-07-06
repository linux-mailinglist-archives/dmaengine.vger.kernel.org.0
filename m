Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF651568F31
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiGFQaV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiGFQaU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 12:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780BB22BCB;
        Wed,  6 Jul 2022 09:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 217D6B81E03;
        Wed,  6 Jul 2022 16:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470BEC3411C;
        Wed,  6 Jul 2022 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657125016;
        bh=wpL0VpuulEkxBMYGMFoXZ3Z1ijIaNjwBi/XMXl6efi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pc0ux1gTFqfqCMvM+42XLAyo8QhJ557q1V/vmN9xbzHMlOaq4U4pe0TROwE6B6Bk7
         taSkjDARnVTbpcYbjhpiqI8Q24XI5Lb2lWlKMHubOeDOPcdSC9jkPP8k044ZLTXGZj
         E8ABe1GD8YYpzb/uuE9JzR8lF1TOS/nqVAY7IyCSGv5G+a3h9vkUFr4mFZ4CjI2yh9
         YIKZmP2chYrj1rg9moNg7CQToTcweX9XgaTiu4mTWDOmad0M7NYIJN7yeR11/xZoqA
         1phq4trYIpzmWvwqZvmPDQ3chPSGw2SGsJwpPDyVAZB8NQLsd6Wc0ZHJ0Qh/P1Ft4t
         ObtsqX9/JbCtw==
Date:   Wed, 6 Jul 2022 22:00:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     olivierdautricourt@gmail.com, sr@denx.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: altera-msgdma: Fixed some inconsistent
 function name descriptions
Message-ID: <YsW4lXE/6IqcQrKk@matsya>
References: <20220706082605.114907-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082605.114907-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-22, 16:26, Jiapeng Chong wrote:
> Inconsistent function names describing msgdma_chan_remove() and
> msgdma_dma_remove are modified to msgdma_dev_remove() and msgdma_remove().
> 
> Remove some warnings found by running scripts/kernel-doc, which is caused
> by using 'make W=1'.
> 
> drivers/dma/altera-msgdma.c:927: warning: expecting prototype for msgdma_dma_remove(). Prototype was for msgdma_remove() instead.
> drivers/dma/altera-msgdma.c:758: warning: expecting prototype for msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead.

Applied, thanks

-- 
~Vinod
