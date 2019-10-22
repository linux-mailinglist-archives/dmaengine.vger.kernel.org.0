Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6BE0857
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfJVQKe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 12:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJVQKd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 12:10:33 -0400
Received: from localhost (unknown [122.181.223.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FFD21783;
        Tue, 22 Oct 2019 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571760632;
        bh=xi2a30iBVKEL1sbscpkqFNVDbDwtN/p2WWW2qs/YLkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvVReUhK0Gi+MolURPUlwdVU9rgKwtBoKTYg7TUkYCCEGQnhIYKXrhp2QzXoiaHpy
         yS7u3wlZm159nh6r8fuAel3wEIohOqO7t6if1BSO8zq0cUGbXKFCERfD2REYQb7tUk
         dFcjmJZp4zr7OKU1cEByjjYxYn7U5lROS8Al4mNo=
Date:   Tue, 22 Oct 2019 21:40:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Message-ID: <20191022161020.GM2654@vkoul-mobl>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
 <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
 <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Please *do* *not* top post!

On 22-10-19, 10:19, Peng Ma wrote:
> Hi Anders && Viod,

Its Vinod!

> 
> I sent v6 patch to fix the build error, please check.
> Patchwork link:
> https://patchwork.kernel.org/project/linux-dmaengine/list/?series=191397

No I have already applied v5, please send fixes on top on
dmaengine-next! Would also make sense to give credit to Anders using
Reported-by tag

> 
> Best Regards,
> Peng
> >-----Original Message-----
> >From: Anders Roxell <anders.roxell@linaro.org>
> >Sent: 2019年10月22日 17:27
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: Vinod Koul <vkoul@kernel.org>; dan.j.williams@intel.com; Leo Li
> ><leoyang.li@nxp.com>; linux-kernel@vger.kernel.org;
> >dmaengine@vger.kernel.org
> >Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
> >DPDMAI(Data Path DMA Interface) support
> >
> >Caution: EXT Email
> >
> >On Thu, 17 Oct 2019 at 08:16, Peng Ma <peng.ma@nxp.com> wrote:
> >>
> >> Hi Vinod,
> >>
> >> Thanks very much for your reply.
> >>
> >> Best Regards,
> >> Peng
> >> >-----Original Message-----
> >> >From: Vinod Koul <vkoul@kernel.org>
> >> >Sent: 2019年10月17日 12:11
> >> >To: Peng Ma <peng.ma@nxp.com>
> >> >Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> >> >linux-kernel@vger.kernel.org; dmaengine@vger.kernel.org
> >> >Subject: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
> >> >DPDMAI(Data Path DMA Interface) support
> >> >
> >> >Caution: EXT Email
> >> >
> >> >On 30-09-19, 02:04, Peng Ma wrote:
> >> >> The MC(Management Complex) exports the DPDMAI(Data Path DMA
> >> >Interface)
> >> >> object as an interface to operate the DPAA2(Data Path Acceleration
> >> >> Architecture 2) qDMA Engine. The DPDMAI enables sending frame-based
> >> >> requests to qDMA and receiving back confirmation response on
> >> >> transaction completion, utilizing the DPAA2 QBMan(Queue Manager and
> >> >> Buffer Manager
> >> >> hardware) infrastructure. DPDMAI object provides up to two
> >> >> priorities for processing qDMA requests.
> >> >> The following list summarizes the DPDMAI main features and capabilities:
> >> >>       1. Supports up to two scheduling priorities for processing
> >> >>       service requests.
> >> >>       - Each DPDMAI transmit queue is mapped to one of two service
> >> >>       priorities, allowing further prioritization in hardware between
> >> >>       requests from different DPDMAI objects.
> >> >>       2. Supports up to two receive queues for incoming transaction
> >> >>       completion confirmations.
> >> >>       - Each DPDMAI receive queue is mapped to one of two receive
> >> >>       priorities, allowing further prioritization between other
> >> >>       interfaces when associating the DPDMAI receive queues to DPIO
> >> >>       or DPCON(Data Path Concentrator) objects.
> >> >>       3. Supports different scheduling options for processing received
> >> >>       packets:
> >> >>       - Queues can be configured either in 'parked' mode (default),
> >> >>       or attached to a DPIO object, or attached to DPCON object.
> >> >>       4. Allows interaction with one or more DPIO objects for
> >> >>       dequeueing/enqueueing frame descriptors(FD) and for
> >> >>       acquiring/releasing buffers.
> >> >>       5. Supports enable, disable, and reset operations.
> >> >>
> >> >> Add dpdmai to support some platforms with dpaa2 qdma engine.
> >> >
> >> >Applied both, thanks
> >
> >I see this error when I'm building.
> >
> >WARNING: modpost: missing MODULE_LICENSE() in
> >drivers/dma/fsl-dpaa2-qdma/dpdmai.o
> >see include/linux/module.h for more information
> >ERROR: "dpdmai_enable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_set_rx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_tx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_rx_queue"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_get_attributes"
> >[drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> >ERROR: "dpdmai_open" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_close" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_disable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >ERROR: "dpdmai_reset" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko]
> >undefined!
> >make[2]: *** [../scripts/Makefile.modpost:95: __modpost] Error 1
> >make[1]: *** [/srv/src/kernel/next/Makefile:1282: modules] Error 2
> >make: *** [Makefile:179: sub-make] Error 2
> >make: Target 'Image' not remade because of errors.
> >make: Target 'modules' not remade because of errors.
> >
> >any other that see the same ?
> >
> >Cheers,
> >Anders

-- 
~Vinod
