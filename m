Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5132210F4
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGOP1h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 11:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGOP1g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 11:27:36 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494E8206D5;
        Wed, 15 Jul 2020 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594826856;
        bh=pd1KRNwdr6dNRTt+fz8M+If2IOA/euVVDP3NJec0v2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrLic7g1CDBl7et7jqZXJ7pVzRWFyU0Ngir56bA7NSqYDWZvNwLYalATxabHrQ9g/
         /zWFBdV6j56drzy+KQAxybFkkB7cwW/EwclG0QkT+lvwbqlr0O+Byp27fLkAKoHOcq
         W6yHfnruoDB+11StWz6aqiJ0N7gWJcoaRvN8+KR0=
Date:   Wed, 15 Jul 2020 20:57:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: remove always true comparisons
Message-ID: <20200715152732.GA52592@vkoul-mobl>
References: <20200715130122.39873-1-vkoul@kernel.org>
 <CAOMZO5AYWKw2RBjt+sEveejzwmD1o0768FiCfa9ObHupENsweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AYWKw2RBjt+sEveejzwmD1o0768FiCfa9ObHupENsweQ@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabio,

On 15-07-20, 10:16, Fabio Estevam wrote:
> Hi Vinod,
> 
> On Wed, Jul 15, 2020 at 10:01 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > sdmac->event_id0 is of type unsigned int and hence can never be less
> > than zero. Driver compares this at couple of places with greater than or
> > equal to zero, these are always true so should be dropped
> >
> > drivers/dma/imx-sdma.c:1336:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> > drivers/dma/imx-sdma.c:1637:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> I have already fixed this problem and you have already applied my patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=next&id=2f57b8d57673af2c2caf8c2c7bef01be940a5c2c

My bad that I didnt run this on -next :-)

-- 
~Vinod
