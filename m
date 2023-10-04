Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3F7B789C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjJDHWD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjJDHWD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:22:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB77AC;
        Wed,  4 Oct 2023 00:21:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7DBC433C7;
        Wed,  4 Oct 2023 07:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696404119;
        bh=Ky7c8t0FyexeqTm60yuSOH3ESa76yTDdIDKIxaTzu3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YR0Dc5392LGrqEna/XL6UdpxixpQvZswHEYy/WlG3UYbHIM25hpAH7NwTW7LUuQk6
         S81l7youIH6GgHsUc/ZNFk+N9ciLfEslWak1DW8cqN63Ei7JcHI5sKGkui7JffAGhQ
         iXYhDX5ymg+eM4w9x4N7WCaMbHDPDquW0NZZJCRA4fvmsdDTQiQ23Fd5xYFuIi5ePc
         ETiDilUwEP8229rEw8Cor3CCHA/DHlI9F8pw1wpV5jCTKnPqwrZavHh38QglzcTWiD
         SmBkTlfy9EL46bzqyLgD3q807HlPBzrYKn3QFayD3hECIoPi1bgxLKY2jq+PiARA7p
         +BO9HJPL5Ju5A==
Date:   Wed, 4 Oct 2023 12:51:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 0/5] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <ZR0SkhEFe7Cc8p3k@matsya>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-1-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-10-23, 15:17, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> This patch series fix the support of dw-edma HDMA NATIVE IP.
> I can only test it in remote HDMA IP setup with single dma transfer, but
> with these fixes it works properly.
> 
> Few fixes has also been added for eDMA version. Similarly to HDMA I have
> tested only eDMA in remote setup.

Changes in v2...?

> 
> Kory Maincent (5):
>   dmaengine: dw-edma: Fix the ch_count hdma callback
>   dmaengine: dw-edma: Typos fixes
>   dmaengine: dw-edma: Add HDMA remote interrupt configuration
>   dmaengine: dw-edma: HDMA: Add sync read before starting the DMA
>     transfer in remote setup
>   dmaengine: dw-edma: eDMA: Add sync read before starting the DMA
>     transfer in remote setup
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>  3 files changed, 53 insertions(+), 14 deletions(-)
> 
> -- 
> 2.25.1

-- 
~Vinod
