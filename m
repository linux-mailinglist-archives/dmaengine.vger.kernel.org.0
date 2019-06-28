Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE759C61
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF1NCL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 09:02:11 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36468 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF1NCL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 09:02:11 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A4EFC3C00D1;
        Fri, 28 Jun 2019 15:02:09 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7LQ893BF_rht; Fri, 28 Jun 2019 15:02:04 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 1E4643C00BB;
        Fri, 28 Jun 2019 15:02:04 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 15:02:03 +0200
Date:   Fri, 28 Jun 2019 15:02:00 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <dmaengine@vger.kernel.org>,
        "George G . Davis" <george_davis@mentor.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190628130200.GA11231@vmlxhi-102.adit-jv.com>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
 <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
 <20190628125534.GB1458@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190628125534.GB1458@ninjato>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Wolfram,

On Fri, Jun 28, 2019 at 02:55:34PM +0200, Wolfram Sang wrote:
[..]
> If you could formally add such a tag:
> 
> Tested-by: <your email>
> 
> (maybe also Acked-by: or Reviewed-by:, dunno if you think it is
> apropriate)
> 
> to the patches, this would be much appreciated and will usually speed up
> the patches getting applied.
> 
> Thanks for your help!

I am doing this per-patch to allow patchwork to reflect the status of
each patch on the linux-renesas-soc front-page. AFAIK patchwork ignores
series-wide '*-by: Name <email>' signatures/tags.

-- 
Best Regards,
Eugeniu.
