Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730EB619A50
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiKDOmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiKDOlk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:41:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB8326DE;
        Fri,  4 Nov 2022 07:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F28B82E10;
        Fri,  4 Nov 2022 14:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32A0C433C1;
        Fri,  4 Nov 2022 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572838;
        bh=WYCCcSJVmicU+dbST6CG79P8MqUy8oqYTP/FgTAJBRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+iVWKUE0xZWqAe8c1MIDP5AFq6ebVKKwJEFHrzqs9k9MH2xrFAWcvZNbmreEHaBZ
         9WGIvbY3pqfX1fBGppXzLVuOuExM2ZKjoKuIAlwyRRlfbE68D2CSVkXnqx5rjUNWSg
         fqoHumycwGrDuvYJSf4o14em/m5JDR2CSPmH4yxej4UnhBIltfPf7pbDCet9C11zh+
         7hiX5i0zTxgvLbWTibE7isAQP+KFFOntl7IiY1t+8Y4yovju72v2kesitlqNrKYo9K
         QQaUDLQ8IPMDNv/iJbSnfP9QBPnd/8DjY3otp8eAsIIfJvflP8RHMp0lw6C1KZJB1J
         iysSgwxY8KnVA==
Date:   Fri, 4 Nov 2022 20:10:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Jiapeng.Chong" <jiapeng.chong@linux.alibaba.com>
Cc:     "peter.ujfalusi" <peter.ujfalusi@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENI?= =?utf-8?Q?=5D?= dmaengine: ti:
 edma: Remove the unused function edma_and()
Message-ID: <Y2UkYnTIG4BywIQE@matsya>
References: <20221018083820.25297-1-jiapeng.chong@linux.alibaba.com>
 <Y0//nxmB2CEjFvMp@matsya>
 <354896d0-3a48-44a1-81bf-8e46caf55a7e.jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <354896d0-3a48-44a1-81bf-8e46caf55a7e.jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-22, 10:10, Jiapeng.Chong wrote:
> The report is the link, which can be seen in the submitted patch description. Thank you.

Pls dont top post!

> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2430

This bug says: "ABACI reported the following bug by code static
scanning"

Where is the ABACI report?

> ------------------------------------------------------------------
> 发件人：Vinod Koul <vkoul@kernel.org>
> 发送时间：2022年10月19日(星期三) 21:46
> 收件人：Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 抄　送：peter.ujfalusi <peter.ujfalusi@gmail.com>; dmaengine <dmaengine@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>; Abaci Robot <abaci@linux.alibaba.com>
> 主　题：Re: [PATCH] dmaengine: ti: edma: Remove the unused function edma_and()
> On 18-10-22, 16:38, Jiapeng Chong wrote:
> > The function edma_and() is defined in the edma.c file, but not called
> > elsewhere, so remove this unused function.
> > 
> > drivers/dma/ti/edma.c:321:20: warning: unused function 'edma_and'.
> > 
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2430
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Where is this report?
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> > drivers/dma/ti/edma.c | 8 --------
> > 1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > index fa06d7e6d8e3..9ea91c640c32 100644
> > --- a/drivers/dma/ti/edma.c
> > +++ b/drivers/dma/ti/edma.c
> > @@ -318,14 +318,6 @@ static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
> > edma_write(ecc, offset, val);
> > }
> > 
> > -static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
> > -{
> > - unsigned val = edma_read(ecc, offset);
> > -
> > - val &= and;
> > - edma_write(ecc, offset, val);
> > -}
> > -
> > static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
> > {
> > unsigned val = edma_read(ecc, offset);
> > -- 
> > 2.20.1.7.g153144c
> -- 
> ~Vinod

-- 
~Vinod
