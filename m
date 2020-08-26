Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41757252640
	for <lists+dmaengine@lfdr.de>; Wed, 26 Aug 2020 06:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgHZE2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Aug 2020 00:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgHZE2q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Aug 2020 00:28:46 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE04520719;
        Wed, 26 Aug 2020 04:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598416125;
        bh=1pDzP4zxF6AJR/du+yRRXgitkRk+Vo9zPs+Z249XEpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeyKPw3kfgT5B9sMgyG690SDMOhcexuDzCw0uoeq9/Cz58HH35Md6NxlyFVumY4JH
         GfhpA0pe2vmHzZ9XSrDR2SEOhlPOJzIQz7Y8ds6WSU/diYTRe4FHsSMVbckcXpmWD0
         de4kQ14fd8C1MwkCalObepXxmCyGmTEkPbafrIO4=
Date:   Wed, 26 Aug 2020 09:58:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
Message-ID: <20200826042841.GV2639@vkoul-mobl>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
 <20200825110331.GG2639@vkoul-mobl>
 <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Allen,

On 26-08-20, 06:41, Allen wrote:
> Vinod,
> 
> > > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > > introduced a new tasklet initialization API. This series converts
> > > all the dma drivers to use the new tasklet_setup() API
> > >
> > > This is based on 5.9-rc1.
> > >
> > > Please pick this series, as I missed updating a couple of fixes and marking
> > > the correct mailing list.
> >
> > The patches should have been tagged "dmaengine: ...".
> 
>  My bad, Will have it fixed.
> 
> >
> > What is the status of this API conversion, I think I saw some
> > discussions on API change, what is the conclusion?
> 
>  Yes, the updated API should land into Linus's tree shortly.
> Will send out V2 with the new API soon.

Thanks for update

-- 
~Vinod
