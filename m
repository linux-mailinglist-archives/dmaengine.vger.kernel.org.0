Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6D61984B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKDNmb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 09:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKDNma (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 09:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F342EF48;
        Fri,  4 Nov 2022 06:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF0E1B82C15;
        Fri,  4 Nov 2022 13:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D1C433D6;
        Fri,  4 Nov 2022 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667569346;
        bh=9ZqIElqcShR5LwhCeGum1uHrDgCCKcIFiHMYf2kWAUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ywr0bms5YeK8NNHlt4Wc5sqkHIAsrBX3t7MzgkNOcnRTm+ne1f9qnAMe2Rm7tqYK1
         /6dXjIF+ZUdAmeeXIUfixD6Ywb90KWVcd7g3fa0DHbWnIfV0PDDmFnxAJSiiuN+KGN
         FbO+kNovFSBjaaQyTjC1rYd3XJxQPiLikMnUPqw2iIlHzCpyDWmwrwAawvRDtha2qE
         YulW42gOsJb3aar4GehqPcmJQ37aH4q6YPqZ09emfC9r0p28cCd18H5JM/XTJaZTZV
         0wdJXXfrL2Q2bCfmaiOWwlZbCyv61zva7SfaUTVvqovBRmHKkaVwBCSh/1Opby19Ok
         DDCpAhgxBMZOQ==
Date:   Fri, 4 Nov 2022 19:12:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     fancer.lancer@gmail.com, caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <Y2UWvjNHBGa8PjBZ@matsya>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-22, 14:48, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
> Rename dw_edma_core_ops structure to dw_edma_plat_ops,
> because the 'ops' is related to platform device

Is that really a case, the device can be non platform too right?

-- 
~Vinod
