Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE9706270
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjEQIMu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEQIMt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 04:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30F3C32;
        Wed, 17 May 2023 01:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F25164358;
        Wed, 17 May 2023 08:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DBAC433D2;
        Wed, 17 May 2023 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311163;
        bh=KV1YaRt9oD+2S1+2WNhsdmMPrNPWxJUUf2i0IlELy7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHCTFI6AvuXknvpDdj68UQednyBLginlEjpsoD5D7PR2CGq9h7YB+ampU8cvVO+Vb
         SoMjUK6JjIDIB71UGzTcXL8Yi4MrbvhJbz0aQGXv+JBqDNroCJ73q5CrcnPX5XUstW
         dMc4vKzYcjVut77j8K3usAudVIXO53z1EWm1c6ibjSlpyf3tS6gC387QaLhYGdjPd5
         BuqM8TwIxSKllGV3/aZWToWMdd+ABJT/X6sbM8wgUYgVZJ+1YW9B0F0LSMW3KfrDV3
         4uw4p4z/hc30YxN9iz96EW6wS5uE80lPFtHExsIOD83Pyuib3aNq5aCMcGyU7Qa5s8
         F7ss6I3n+ouOg==
Date:   Wed, 17 May 2023 13:42:39 +0530
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
Subject: Re: [PATCH RESEND v5 13/14] MAINTAINERS: Add Manivannan to DW eDMA
 driver maintainers list
Message-ID: <ZGSMd+mOQSq560dZ@matsya>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-14-Sergey.Semin@baikalelectronics.ru>
 <20230517052824.GA4868@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517052824.GA4868@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-23, 10:58, Manivannan Sadhasivam wrote:
> On Thu, May 11, 2023 at 10:09:01PM +0300, Serge Semin wrote:
> > Manivannan has been very active in reviewing the bits coming to the DW
> > eDMA driver. Let's add him to the driver maintainers list.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to dmaengine/next, thanks

-- 
~Vinod
