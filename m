Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDFF707CF5
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjERJcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjERJcs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 05:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B692123;
        Thu, 18 May 2023 02:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AEEA64DC5;
        Thu, 18 May 2023 09:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B693C4339B;
        Thu, 18 May 2023 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684402365;
        bh=AxosTDF4QElj+lF1aFKpzDoBWCNtV2DhU375tkIJwHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wiw61qcuhVDj5zJkbgdbELZ5rbttjn0+LQWiy2Bad0QaVf9jb5Xzf9sIoI5Qi48eG
         at76n9GncvKk0FCkJLTbUF1W1ddkt7dFeYPs1+2bFRfP/EJfEIg0zJ1yMCbXV3Z9eZ
         z+kRykqnoX1sd/LFHjo7BO5rs1SPNWQVUZagwjjlXBtVPtYwevVDa9V2LNAP6Vg1QI
         +eOc/aj0OloKZAgik57+ecrapuh5N+jv46XPeFCt1/kD0Zu1avfAlB0ebjS63XPSma
         BORoQdh9nPnVKHOGxK2vibN17IjtGCCKLYy4fKZlRfN43mg6sb00FlPPnxcc4jz4du
         i9BcXvBRhPheg==
Date:   Thu, 18 May 2023 15:02:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 14/14] MAINTAINERS: Add myself as the DW eDMA
 driver reviewer
Message-ID: <ZGXwuZgUCabzj0/O@matsya>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511190902.28896-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-23, 22:09, Serge Semin wrote:
> The driver original maintainer has been inactive for almost two years now.
> It doesn't positively affect the new patches tests and reviews process.
> Since the DW eDMA engine has been embedded into the PCIe controllers in
> several our SoCs we will be interested in helping with the updates review.

Applied, thanks

-- 
~Vinod
