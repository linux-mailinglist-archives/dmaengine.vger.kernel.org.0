Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785E424CCD6
	for <lists+dmaengine@lfdr.de>; Fri, 21 Aug 2020 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgHUElk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Aug 2020 00:41:40 -0400
Received: from mail2.skidata.com ([91.230.2.91]:2296 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHUElj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Aug 2020 00:41:39 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 00:41:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597984899; x=1629520899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8MCltXRL+RGxf4gw22SJJk0rZoXwbuNIta681mVBukg=;
  b=oVkHTLcejWFNHoZlNHs3zN4oXkYbvWRQTYwWBKfs4lBfMjgfrhhVe/Es
   40JAMoksRnMtLzbiSKd6EWC0XR8an+3lOUMRsmgR6SC7hMZSrAXlR4YpV
   +SsZPxcDX9+VWWZL5kdjoWXW0mOIrgQRTKVSHGwFxdp6R+TKe5p7CFnbs
   hcXdFAtvI4uZOuf2IIw9bYeJH/pwLbyPCWCuGIHe+tuaDrPSjIERlwIn0
   +xpyqMFjrknY/3xeKhlDXeNdrOn8+ndTvBM9UMmCVupguWwVtFgM6P8dj
   JpuKjzO4u6NU3jZhZERVXvC+0a59/3KReZN6waVG5nuhJt9P+/t6+hA90
   g==;
IronPort-SDR: HAN9vym7mM33d8fMsKj7u4xEC2g2HvwohDQjA95kU2hj4jut2jxR/PHsvKaEd7LbB7+IDRkmaB
 Zj/9cm09Gb+dP1nj9NLcIT5B+4A8/7PBANIHGP5zyyRfYxDJyi9jP0d8Y4eWOAVXQ05OH539Re
 NEwAp5488VCy830zzz14uO+BsLZJnhTVS0/xn/kmzWinSOQyaQLyXxLtVcX2jB0GvOns9WFHBC
 J8FOf9prgzvqw/1mFhBCfyrAKFizPQmu/tk7pPG4uM3HvHH3dUSuBxxPp+3XpUHxvBxqPsjzc5
 UjY=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="2647454"
Date:   Fri, 21 Aug 2020 06:34:18 +0200
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
Message-ID: <20200821043418.GA65616@pcleri>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
 <VE1PR04MB6638A7AC625B6771F9A69F0D895A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638A7AC625B6771F9A69F0D895A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 20, 2020 at 03:01:44PM +0000, Robin Gong wrote:
> On 2020/08/19 22:26 Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com> wrote: 
> > 
> > @Robin:
> > Is it possible to tag the commits for the stable-tree
> > Cc: stable@vger.kernel.org?
> Could my patch work in your side? If yes, I will add
> Cc: stable@vger.kernel.org 

I've tested the patches 3 & 4 (removing sdmac->context_loaded) of the
series you mentioned and sent Tested-by tags for them [1,2], as they
fix the EIO problems for our use case.

So from our side they are fine for stable.

[1] https://lore.kernel.org/dmaengine/20200817053813.GA551027@pcleri/T/#u
[2] https://lore.kernel.org/dmaengine/20200817053820.GB551027@pcleri/T/#u

regards;rl
