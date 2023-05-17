Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD370626D
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEQIMb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 04:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjEQIM2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 04:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDD310C3;
        Wed, 17 May 2023 01:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68E864364;
        Wed, 17 May 2023 08:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A469C433EF;
        Wed, 17 May 2023 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311146;
        bh=nCq3wyagGzcAnVK/CuXROM0u9JK6bfH6cEQEixju2n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VT6ZdunxonwqwKp0xZZmk6cbBBAJhlAz2betwj/2YP2QReJtkK8j+AmbJ2v7b7C2H
         DLtxUPJKUSKoNeqW+ZcKzq6AmVqEM5PwChnBaoT1Me6BeLskgYBXsl5FvKB65nGZE2
         JPUIFU4nWA3ZpsMyx+Y6SmD0JwAwLdeDEjtbv4as4qWW1d8Z4W+Cm+fush9jiI5B5W
         eRQGl8ebauyTFB0iH/ln3WoVxo8wk3S7yPfElF8XSGBOLd9XITS3Kn/mSWspwLJy6A
         iIAIUJId4ntgRB3YFwVHGeLlzlahFbXvp6J3eCvd5RWxyAWk+W0H5Sz7d6PBhKeSvR
         dm+tkCmKyW96Q==
Date:   Wed, 17 May 2023 13:42:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 12/14] MAINTAINERS: Demote Gustavo Pimentel to
 DW EDMA driver reviewer
Message-ID: <ZGSMZtvJnXDkSkiL@matsya>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-13-Sergey.Semin@baikalelectronics.ru>
 <20230517053154.GE4868@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517053154.GE4868@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-23, 11:01, Manivannan Sadhasivam wrote:
> On Thu, May 11, 2023 at 10:09:00PM +0300, Serge Semin wrote:
> > No maintaining actions from Gustavo have been noticed for over a year.
> > Demote him to being the DW eDMA driver reviewer for now.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to dmaengine/next, thanks

-- 
~Vinod
