Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDC6E0391
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbfJVMFR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 08:05:17 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:35739 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbfJVMFR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 08:05:17 -0400
Received: by mail-lj1-f179.google.com with SMTP id m7so16913700lji.2
        for <dmaengine@vger.kernel.org>; Tue, 22 Oct 2019 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VGTfUe//Lkyyq1CFsi2Aw+FdHH2W9Ju5Bb6Df3fquDw=;
        b=pi2vCaoItbcXJ3F6Bo71yn+jXqd3pUZmK66jHNjAkxWt9qjAswyRHIIsKKK72IkTXF
         /IvctVUS5+Et1kRm85+/fTdAMG6rzkj4+bC/284zs0NqpGElHvrvhM6VtG5Oteyu3d8z
         X3/6G6g//2ckZ/demrHv7AuYYD7M7xSSbVgMj0XayXZhIwSodnRNmXSaxpCWbszhUD68
         wQb6DLFyZ+Hj85zp69FgdmjvHHjZuGsYd56eKrruHekeB9s2DSlxgz1TYs2RZPVqBGKj
         yaiHok3rmXo/vPDzoXU0deh8jdiYvdZaUgncHbfuyUiknG+ebmixBr2n3MkfWfs2FE7w
         hKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VGTfUe//Lkyyq1CFsi2Aw+FdHH2W9Ju5Bb6Df3fquDw=;
        b=XhcyBMyXzqYGamnASIAvrbxc30Aqu4wCOIccTD4QpXrAn4aiubi9gEHG+GX7CPqdfy
         755NYH1wNjXlAuaH/dxVz2zW6aOFu7mOk5wDYqUOTCAJ7Eb8DFV2R01D8gMoXMEPmf9I
         s7HfdM3gbHxr8l8kGj9f+0gL0UbUUn2DFLSuq6sXvYTmemLPZWY+dcWNXSRJjft4JReI
         DYD6SmRazhCTGjrZrBCl+D0dfoqtbJXdej8lcm6LVKr+iQ1ER2nATaLTnkQfxeaSzGrA
         ilycFJ0XJA1qXnX409GdCmysTcdtWqHDQ9fZct9oCFcXD+S6wRUFtPXAex8kHvDxmt2Y
         vu+g==
X-Gm-Message-State: APjAAAX3ddZJRAPOVUp8ezuZCS45xHZECrlF33XG7npWCBSqgntEIqhd
        +Q3Y3UUI3sbzKiDOik0txd6NMw==
X-Google-Smtp-Source: APXvYqw73VgC0S976eZM9uQqGSZ6Ma0RPqQ57qIGOHoyqFCwxrGlaeFe6OIdIpOCQtqa5/Z8vQsNJA==
X-Received: by 2002:a2e:9b46:: with SMTP id o6mr2071632ljj.90.1571745914535;
        Tue, 22 Oct 2019 05:05:14 -0700 (PDT)
Received: from localhost.localdomain (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id r75sm6940248lff.93.2019.10.22.05.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 05:05:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:10:39 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Message-ID: <20191022111039.GA8762@localhost.localdomain>
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
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019-10-22 10:19, Peng Ma wrote:
> Hi Anders && Viod,
> 
> I sent v6 patch to fix the build error, please check.

oh I will check, didn't see them when I sent out my email. =/

Cheers,
Anders

> Patchwork link:
> https://patchwork.kernel.org/project/linux-dmaengine/list/?series=191397
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
