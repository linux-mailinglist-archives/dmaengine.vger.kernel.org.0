Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074BC24D1CF
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHUJyi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Aug 2020 05:54:38 -0400
Received: from mail1.skidata.com ([91.230.2.99]:49057 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUJye (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Aug 2020 05:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1598003673; x=1629539673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NstbtL4h85xlZs4+XVTJ2ZVNFbQJtI/QKJuqZTJ2ZeQ=;
  b=kRb96QOOc5MO+LFrktYiLSRs7IwA3NGeTLusUmzGrVJVRDVGjmHF6ENc
   sCInO7yfgGH/0SEgvxXaMM0rBBcOfuXYV3IxAciCai+KKnNPulICBS8sx
   PRN+/oAAQG5pYdJhVUtWss9AZoS0ObYmkD0dJ678Fdmk9xcNodSQNAQLr
   1EZerV/8QvohyhxTehcUhKtloM9TE9ngfd9YSFbK2eH7tnrWOMJnhHvTJ
   19DnSr0R37yswQYzcwJ/m75bo7Bf5fwWzvb1d93I5tOG+S0EXk9oFioM2
   8DsZEacsecj5a7Q211dhOqX7rv2UpS4le+yWf1rgMpNsuciJ/OxVEunrT
   Q==;
IronPort-SDR: 3YRGmzjJwFhLM47ZZA2avh0ZdlsTTCQs/vrDyCckW8v4KIO9OYH5mDxDlRHi6DXdj0zw0l3grt
 zFumAJ3NT23lh0uS6wZWMxdgSpk1Xr0dBlNPCRmJ5lztPu3KFzyKJJxVV0PHvDrpHz4uKeJ14S
 y7+o1plvPyokFmzMttD3BtEOSYoQPPNKqa3w0vtJRhur8kqBqGxHvyCB5JVemSvoArcwHvWDf0
 YPYQZgTBK+99J3q2ew3/FXG378z1H6pj4Y+XNESw2CcHD/V83drLWg6/hjN4wq/bNyCX19Qt/E
 N04=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="26271758"
Date:   Fri, 21 Aug 2020 11:54:30 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: pcm|dmaengine|imx-sdma race condition on i.MX6
Message-ID: <20200821095430.GB65616@pcleri>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
 <VE1PR04MB6638A7AC625B6771F9A69F0D895A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200821043418.GA65616@pcleri>
 <VE1PR04MB6638271FA459E4068391ABF8895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638271FA459E4068391ABF8895B0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 21, 2020 at 09:21:37AM +0000, Robin Gong wrote:
> On 2020/08/21 12:34 Richard Leitner <richard.leitner@skidata.com> wrote: 
> > On Thu, Aug 20, 2020 at 03:01:44PM +0000, Robin Gong wrote:
> > > On 2020/08/19 22:26 Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
> > wrote:
> > > >
> > > > @Robin:
> > > > Is it possible to tag the commits for the stable-tree
> > > > Cc: stable@vger.kernel.org?
> > > Could my patch work in your side? If yes, I will add
> > > Cc: stable@vger.kernel.org
> > 
> > I've tested the patches 3 & 4 (removing sdmac->context_loaded) of the series
> > you mentioned and sent Tested-by tags for them [1,2], as they fix the EIO
> > problems for our use case.
> > 
> > So from our side they are fine for stable.
> > 
> Okay, I thought that's just decrease the issue in your side not totally fix, and the patch

As Benjamin mentioned the issue isn't "fixed" for us from the logical/
technical side.
Nonetheless the EIO error won't occur anymore with the patches applied.
Therefore the issue is for me "fixed from a userspace point of view", as
they don't get/see the error anymore.

> I post in https://www.spinics.net/lists/arm-kernel/msg829972.html
> could resolve the potential next descriptor wrongly freed by vchan_get_all_descriptors
> in sdma_channel_terminate_work. Anyway, I'll add ' Cc: stable@vger.kernel.org' and
> your Tested-by tags in 3&4, then resend it again, thanks.

Great. Thank you!

regards;rl

