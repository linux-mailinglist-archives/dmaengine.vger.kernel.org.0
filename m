Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E22573D7
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgHaGkj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 02:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgHaGk1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 02:40:27 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995842078D;
        Mon, 31 Aug 2020 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598856027;
        bh=1euV9QyDpicEeG1/rnRwrFLEfnT4VyUf9/DxYRA0qUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjTaswt4M/1YNkWZqCHffUIOQdRyzCOJLSMPdh9Jau7Y5+kRhZcHAgcyT8niCEnYs
         kwm6k8FK0fYvnw9OmDpCbrHBtsUmzUSOdmDYHl4qnwGyQy0z8kkhJLO1ijhKF+4Fku
         DOPmLTrHfTQc+/NXsNW62kvTLm3KVaikHFqIx17g=
Date:   Mon, 31 Aug 2020 12:10:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
Message-ID: <20200831064023.GE2639@vkoul-mobl>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
 <20200825110331.GG2639@vkoul-mobl>
 <CAOMdWSKvj9Bwt_JpJ072c-LYKRO4aA+vEPyJLZSYgMvuXhTBmQ@mail.gmail.com>
 <20200826042841.GV2639@vkoul-mobl>
 <CAOMdWS+ZE8hKwVPT=XQVHoZ3uX-Wr7Ao=WxyT8JPzN_4NR2DbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWS+ZE8hKwVPT=XQVHoZ3uX-Wr7Ao=WxyT8JPzN_4NR2DbA@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-08-20, 11:30, Allen wrote:
> Vinod,
> > > > > Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> > > > > introduced a new tasklet initialization API. This series converts
> > > > > all the dma drivers to use the new tasklet_setup() API
> > > > >
> > > > > This is based on 5.9-rc1.
> > > > >
> > > > > Please pick this series, as I missed updating a couple of fixes and marking
> > > > > the correct mailing list.
> > > >
> > > > The patches should have been tagged "dmaengine: ...".
> > >
> > >  My bad, Will have it fixed.
> > >
> > > >
> > > > What is the status of this API conversion, I think I saw some
> > > > discussions on API change, what is the conclusion?
> > >
> > >  Yes, the updated API should land into Linus's tree shortly.
> > > Will send out V2 with the new API soon.
> >
> > Thanks for update
> 
> We weren't successful in getting the new API accepted. We will be
> sticking to from_tasklet() unless you as a maintainer object to it.


Ok, but is the colclusion to keep from_tasklet() or move to something
else later on. If that is the case, I would like to see the change once
only

> If there's no objection, please let me know if I can send out V2
> with subject line fixed.

If this wont change, then yes please

-- 
~Vinod
