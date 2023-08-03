Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA21476E6C3
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjHCLZu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHCLZu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 07:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873B21981;
        Thu,  3 Aug 2023 04:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF1061D4D;
        Thu,  3 Aug 2023 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E9FC433C8;
        Thu,  3 Aug 2023 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691061948;
        bh=42OIzEptMa6drEW3K5eEpD6aaOKTvmXN6uoP8zn4eZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqQfanK4cMycgyR2C5Aq5UnEX+S5/Uaatl0T69ek29TbeBGXIA7G8+eYXjTzEfXZJ
         AVOgSl7KyBLvZis0Zel0nBncPP8gaNpTodnmQ2YIJ8XLyCrtAFiwY87qSObX0HRq97
         tBeeMJHtBbDIhXolfqFYTyiH9sVE0oK4vdzFLPBLpXCfdcR8Eia8dsz6RsCJIAh/YB
         Fclfh7kG9uuBlu61uwIPS/ZNGtlSz+wCjlr9P17qgqse7OyJLrdPO4eAu9dicipc34
         YbTKdCiM+Pig0cCx/z6ojtNXphlH8GAv0Uan4qIJpX84nRTouM54Z9vcZcK1KNsahV
         zxr3o3MDv20tw==
Date:   Thu, 3 Aug 2023 16:55:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
Message-ID: <ZMuOt2THchrNDjDH@matsya>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org>
 <ZMlLjg9UBi3QO/qV@matsya>
 <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-08-23, 23:55, Martin Povišer wrote:

> > can you use virt_dma_chan, that should simplify list handling etc
> 
> I looked into that when I wrote the sister driver apple-admac.c, I don’t
> remember anymore why I decided against it, and I don’t think it came up
> during review. Now that this driver is done, I hope we can take it as is.
> 
> There’s some benefit from the drivers having a similar structure, I sent
> one or two fixes to apple-admac for things I found out because I was
> writing this other driver.

And this would be a chance to covert the other one and get rid of list
handling code in that driver as well

> 
> >> +};
> >> +
> >> +#define SIO_NTAGS		16
> >> +
> >> +typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);
> > 
> > any reason not to use dmaengine callbacks?
> 
> Not sure what dmaengine callback you mean here. This callback means
> the coprocessor acked a tag, not sure how we can fit something dmaengine
> onto it.

Okay lets understand, how is this one used

-- 
~Vinod
