Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9F71466F
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjE2Io0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjE2IoW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 04:44:22 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783E9B1
        for <dmaengine@vger.kernel.org>; Mon, 29 May 2023 01:44:20 -0700 (PDT)
Date:   Mon, 29 May 2023 16:44:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685349859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWWjW272D8dSNO84PIr6uIe+T3G/E2XjK68WyXdYOu8=;
        b=N3LgF6NjYlhUWOYyfVPqcfV/vbf77eNAW3CS7RAF62mQwFXjX8SrBKd2hxO+pu+7kgdDum
        jqT2PmoKp0xhmlzuxXnzFQsNc0+YTAlfTE+N8R4aq/oaTB/NSJQ5piN0OZk4z+y085wZpy
        WGcaKbt0xQZbq6VrxwXMVavg6T0WqqU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     fancer.lancer@gmail.com, gustavo.pimentel@synopsys.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Cai Huoqing as dw-edma maintainer
Message-ID: <ZHRl37L2JPq+UmGp@chq-MS-7D45>
References: <20230529032423.11650-1-cai.huoqing@linux.dev>
 <20230529052227.GA2856@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230529052227.GA2856@thinkpad>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29 5月 23 10:52:27, Manivannan Sadhasivam wrote:
> Hi,
> 
> On Mon, May 29, 2023 at 11:24:23AM +0800, Cai Huoqing wrote:
> > Since HDMA mode was merged, including the commits:
> > commit e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA"),
> > commit 353d5c241e83 ("dmaengine: dw-edma: Add HDMA DebugFS support"),
> > I would like to add myself as maintainer of the dw-edma driver
> > to recive patch for HDMA part. 
> > 
> > I can test HDMA part by our chip and cmodel and do some code review.
> > I'm active in linux contribution, if possible, I want to
> > take the dw-edma maintainership.
> > 
> 
> Thanks for your interest in maintaining this driver. However, maintainership
> involves active reviewing and maintaining the whole driver and not just the HDMA
> part. If that's what you are intend to do, then I'd encourage you to first spend
> some time reviewing and testing the patches targeting the dw-edma driver.

Ok, will do.

Thanks,
Cai-
> 
> This will help justifying the reviewer/maintainership role in the future.
> 
> - Mani
> 
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a0504731524..541601feabd0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5881,6 +5881,7 @@ F:	drivers/mtd/nand/raw/denali*
> >  
> >  DESIGNWARE EDMA CORE IP DRIVER
> >  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +M:	Cai Huoqing <cai.huoqing@linux.dev>
> >  R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >  R:	Serge Semin <fancer.lancer@gmail.com>
> >  L:	dmaengine@vger.kernel.org
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
