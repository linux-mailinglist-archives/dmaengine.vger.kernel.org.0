Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B097C9FDA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjJPGpQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPGpP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 02:45:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F0D9;
        Sun, 15 Oct 2023 23:45:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB681C433C8;
        Mon, 16 Oct 2023 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697438713;
        bh=N06xdxdHVyi+X/um7IY8yIF9m93k5bD0usOzf3X3W8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xs+R2JAUHkeCB/m7bf/BgPuQ5lJlBiglBdGxWCHXqKmyRJtg5S66pPAUAJBlQWaVB
         8cZmMNSTS/FhsH9Z2ntqZfKhYCQdYVaJ6silZJSSEUMaY+lnpMlnbLbJxvKdiRVpwr
         0XrK2dBKIsB5LZhhamzQe7k0T7ZHMM8X1FbCISs7Lc4eSEitiUu6sUwvavlojo9rdD
         s4S6J1yCID3yzyvUkcJlKpcglYLn7dlxtMLgRVqCrzsPxSo4cVWfvWcQzvThawI2Mx
         nFxuSjn1VIKHoQssufTZdkIFhlD+xzN/jnVYrD5CSSnzkwApggW1Ot66x3A0MfjrrE
         cl6ReYqdFOcxw==
Date:   Mon, 16 Oct 2023 12:15:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller driver
 with multi channel
Message-ID: <ZSzb9OEo6cIbln3A@matsya>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
 <ZR02PT/k0op8T71U@matsya>
 <DM4PR12MB6326A31446E45335D2FB457BE5D1A@DM4PR12MB6326.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6326A31446E45335D2FB457BE5D1A@DM4PR12MB6326.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-10-23, 08:26, Mehta, Sanju wrote:
> [AMD Official Use Only - General]

??

> > > diff --git a/drivers/dma/ae4dma/ae4dma-pci.c
> > > b/drivers/dma/ae4dma/ae4dma-pci.c new file mode 100644 index
> > > 0000000..a77fbb5
> > > --- /dev/null
> > > +++ b/drivers/dma/ae4dma/ae4dma-pci.c
> > > @@ -0,0 +1,247 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * AMD AE4DMA device driver
> > > + * -- Based on the PTDMA driver
> >
> > cant we use ptdma driver to support both cores?
> >
> AE4DMA has multiple channels per engine, whereas PTDMA is limited to a single channel per engine. Furthermore, there are significant disparities in both the DMA engines and their respective handling methods. Hence wanted to keep separate codes for PTDMA and AE4DMA.

Pls wrap your replies to 80chars!

The channel count should be configurable and for the handling methods,
you can have low level handler functions for each controller which can
be selected based on device probe

I feel reuse of code is better idea than having two different drivers
-- 
~Vinod
