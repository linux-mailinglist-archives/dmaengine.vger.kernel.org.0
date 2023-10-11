Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880737C527B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjJKLvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjJKLsz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 07:48:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F257CA9;
        Wed, 11 Oct 2023 04:48:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE7EC433C8;
        Wed, 11 Oct 2023 11:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697024933;
        bh=u9Bib1G26xubCLXuoKQJbbgiqRSPlByRzAQB8SaHLx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgEbu6Bq9z3UKeqhLy0QAKw1dKpXyvqi+9uOAtjmlqemipeYtjlEItfPEOMrzvuT3
         OZZLazIYlcv5TbWWw9783GNQ9q9wAE6p+IBpzwXzpPeYNbuL7SiWkMvZesL9ajtmv2
         DSA13c+KAkJ4OzrSGP3PStTDv1jAAg/VP7UupPmJUsr6Zmut+AzNyU/H24KHp+OEmz
         /aoXU7viEam2Fmft5M/qEVLlUtpW49CGK+h33lBfBZ9qh5afKui/QK1+Fiui+MQIC+
         R4d5sn5dk+CAU/oBsKPdGklyZXeZsv2qt2vH4B4BaIUTE4IXX9Tl79xdWdplCJYDE3
         FP5NJR4xepdEA==
Date:   Wed, 11 Oct 2023 17:18:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     dmaengine@vger.kernel.org, George.Ge@microchip.com,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        christophe.jaillet@wanadoo.fr, hch@infradead.org
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZSaLoaenhsEG4/IP@matsya>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
 <20230728200327.96496-2-kelvin.cao@microchip.com>
 <ZMlSLXaYaMry7ioA@matsya>
 <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
 <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
 <ZR/htuZSKGJP1wgU@matsya>
 <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
 <ZSORx0SwTerzlasY@matsya>
 <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-10-23, 21:23, Kelvin.Cao@microchip.com wrote:
> On Mon, 2023-10-09 at 11:08 +0530, Vinod Koul wrote:

> > > u64 size_to_transfer;
> > 
> > Why cant the client driver write to doorbell, is there anything which
> > prevents us from doing so?
> 
> I think the potential challenge here for the client driver to ring db
> is that the client driver (host RC) is a different requester in the
> PCIe hierarchy compared to DMA EP, in which case PCIe ordering need to
> be considered. 
> 
> As PCIe ensures that reads don't pass writes, we can insert a read DMA
> operation with DMA_PREP_FENSE flag in between the two DMA writes (one
> for data transfer and one for notification) to ensure the ordering for
> the same requester DMA EP. I'm not sure if the RC could ensure the same
> ordering if the client driver issue MMIO write to db after the data DMA
> and read DMA completion, so that the consumer is guaranteed the
> transferred data is ready in memory when the db is triggered by the
> client MMIO write. I guess it's still doable with MMIO write but just
> some special consideration needed. 

Given that it is a single value, overhead of doing a new txn would be
higher than a mmio write! I think that should be preferred

-- 
~Vinod
