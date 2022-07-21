Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8E57CB04
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiGUM7O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiGUM7N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 08:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34227DE8D;
        Thu, 21 Jul 2022 05:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE0C61DD3;
        Thu, 21 Jul 2022 12:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3EC3411E;
        Thu, 21 Jul 2022 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658408352;
        bh=fkZ+DyZL6trMl4l+0tyohaMaFrql5cK3kIs1kDmC50c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2qUs0ttPKb4c6oAVjNaJnDuRBBt1TKhrotm/+34lAccDE09vTxhXRCBzR4tuNSPG
         UTTxwpy88TZYIGSMLzKZ+1ym3tYX2lMDpN3gKptaLY2v8A1+y0kcAAALluaXUxdYgF
         sK3NZgwBtI4pRQC+9AhE/rwFKD1ndq7Oz0vGF6Qi3bqMBIX84nhrPLf3Vu/QeChPmr
         pfQ/iOggqnxzGTaSymnZjotTaQz7SSKsXGfNtHzzgk8NaruhgQ4NMizjLewSpM7FNW
         SeW2CymOKgLYXs4Jq/GP1V24UYkAxPQ4Yc3Azb9dHpVJHByYfvgjbjqqnWQKLRwNEf
         PO8ZjtJdXS63w==
Date:   Thu, 21 Jul 2022 18:29:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] dmaengine: imx-sdma: Add FIFO stride support
 for multi FIFO script
Message-ID: <YtlNm9tqgo5lsUcw@matsya>
References: <1657162829-9273-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657162829-9273-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-07-22, 11:00, Shengjiu Wang wrote:
> The peripheral may have several FIFOs, but some case just select
> some FIFOs from them for data transfer, which means FIFO0 and FIFO2
> may be selected. So add FIFO address stride support, 0 means all FIFOs
> are continuous, 1 means 1 word stride between FIFOs. All stride between
> FIFOs should be same.
> 
> Another option words_per_fifo means how many audio channel data copied
> to one FIFO one time, 1 means one channel per FIFO, 2 means 2 channels
> per FIFO.
> 
> If 'n_fifos_src =  4' and 'words_per_fifo = 2', it means the first two
> words(channels) fetch from FIFO0 and then jump to FIFO1 for next two words,
> and so on after the last FIFO3 fetched, roll back to FIFO0.

Applied, thanks

-- 
~Vinod
