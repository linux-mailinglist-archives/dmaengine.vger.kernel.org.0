Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF159BB1
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfF1MjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 08:39:19 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36211 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF1MjT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 08:39:19 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 4BCD43C00C6;
        Fri, 28 Jun 2019 14:39:16 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LpuWT6knsDUd; Fri, 28 Jun 2019 14:39:10 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E4E303C00BB;
        Fri, 28 Jun 2019 14:39:10 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 14:39:10 +0200
Date:   Fri, 28 Jun 2019 14:39:07 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
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
Message-ID: <20190628123907.GA10962@vmlxhi-102.adit-jv.com>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190626173434.GA24702@x230>
 <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWuk7CkfcUSX=706f8b6YMFio7iwZg32+uXsyOKL68fuQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On Fri, Jun 28, 2019 at 01:51:25PM +0200, Geert Uytterhoeven wrote:

[..]

> If a serial port is used as a console, the port is used for both DMA
> (normal use) and PIO (serial console output).  The latter can have a
> negative impact on the former, aggravating existing bugs, or triggering
> more races, even in the hardware.  So I think it's better to be more
> cautious and keep DMA disabled for the console.

Thanks for the extensive and comprehensible replies.
No more questions from my end.
Looking forward to picking the patches from vanilla/stable trees.

-- 
Best Regards,
Eugeniu.
