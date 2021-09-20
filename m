Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8E4119C8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Sep 2021 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhITQaB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Sep 2021 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhITQaB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Sep 2021 12:30:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1FC061574;
        Mon, 20 Sep 2021 09:28:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 825822F06;
        Mon, 20 Sep 2021 18:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1632155311;
        bh=rT3iP0dO5pvYhS8utchpgMyakT6U9Iy8T0YzsoNSQus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDZgeUitXVv8n0Ag8SqWvA+699JQg38we82uzXq94Z6g+LA9b9B33PXNtOpdU/zBZ
         dueDxH8QPImnBbYd3TfLgOMu0QY7hdsrpiGQOK58d7oZ+Frlui8kFY99laly0Nw6r7
         iKqJz0GABmZ536ENyCDwipW8LOi0YyKGCnAwqez8=
Date:   Mon, 20 Sep 2021 19:28:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianqiang Chen <jianqiang.chen@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: remove debugfs #ifdef
Message-ID: <YUi2kQqNVLSeA87X@pendragon.ideasonboard.com>
References: <20210920122017.205975-1-arnd@kernel.org>
 <YUiCy7A9cXTDGx6s@pendragon.ideasonboard.com>
 <CAK8P3a1fcmCWsOuqF8qy4ko9MC8nCd4gyt2K6Rk5K-Zs7yCbJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1fcmCWsOuqF8qy4ko9MC8nCd4gyt2K6Rk5K-Zs7yCbJA@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

On Mon, Sep 20, 2021 at 02:50:52PM +0200, Arnd Bergmann wrote:
> On Mon, Sep 20, 2021 at 2:47 PM Laurent Pinchart wrote:
> >
> > It's only a few bytes of data in struct dma_device, but a bit more in
> > .text here. Is the simplification really required in this driver ?
> 
> The intention was to not change the resulting object code in this driver,
> and I still don't see where it would grow after dead-code-elimination removes
> all the unused static functions. What am I missing?

Indeed, gcc does a fairly good job there. The .text section doesn't
grow. Interestingly, there's an increase in size in the .data and
.rodata sections in the xilinx-dpdma module:

-  8 .rodata.str1.8 0000029f  0000000000000000  0000000000000000  00003660  2**3
+  8 .rodata.str1.8 000002a7  0000000000000000  0000000000000000  00003660  2**3

- 10 .rodata       00001080  0000000000000000  0000000000000000  00003960  2**5
+ 10 .rodata       000010e0  0000000000000000  0000000000000000  00003960  2**5

- 15 .data         00001050  0000000000000000  0000000000000000  00004e40  2**5
+ 15 .data         00001090  0000000000000000  0000000000000000  00004ea0  2**5

I'm not entirely sure where it comes from, it may be related to
instrumentation caused by debugging options.

For your patch,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
