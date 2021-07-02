Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9626F3BA241
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jul 2021 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhGBOfL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jul 2021 10:35:11 -0400
Received: from mx08-00376f01.pphosted.com ([91.207.212.86]:9762 "EHLO
        mx08-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232749AbhGBOfL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jul 2021 10:35:11 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 10:35:11 EDT
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
        by mx08-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 162CRYvS008923;
        Fri, 2 Jul 2021 15:23:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=dk201812; bh=hdrlkyt4i9VXpMEFo4pxkhE0lKEee8hSaxmMPrbCxqY=;
 b=HDuCnWekpgpLNtos2ehSalV3aMEiw6qbvq2FXd2fKbIijq1ssrHhtXvD2JRq340dXpNx
 86UUPeL8pdTLVfttlVmZm8OdJ+sj2jlhijTFUDj08dpu73doCoIXFDeZu05FRdXBti/w
 h1eW3APbzlQGG0NyZAfBE0EqXSpigFOsA+dfpoYg1bw3c2d3qkctMwBjHewJKswjjfty
 5tp+h9uq56Lh6q6yWXUros+UJelKinQKSighCc0JKku9MbamTtFZ2CIm0kTWojUqAjsK
 nbfEMuOUaXWjdUJejywvMvifNdWLBmO1DK3O3CoGEiY705ukoxD/yRk9Bd+srUxfePnh rA== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx08-00376f01.pphosted.com with ESMTP id 39j23h02xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Jul 2021 15:23:12 +0100
Received: from localhost (10.100.70.86) by HHMAIL05.hh.imgtec.org
 (10.100.10.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 2 Jul
 2021 15:23:11 +0100
Date:   Fri, 2 Jul 2021 15:23:10 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     radhey pandey <radheydmaengine@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <dmaengine@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <radheys@xilinx.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <20210702142310.vowvjanfwfivu45a@adrianlarumbe-HP-Elite-7500-Series-MT>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
 <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
 <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
 <YIMB6DpM//wrPC6q@vkoul-mobl.Dlink>
 <CAK8fcYC3Hdxas-5qUbXTi=a6VMXavt9O+yWn=1+8fPewehKy2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK8fcYC3Hdxas-5qUbXTi=a6VMXavt9O+yWn=1+8fPewehKy2w@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: fORXzKQOe-SJx2OrNF-VGnC-szgr9k1f
X-Proofpoint-ORIG-GUID: fORXzKQOe-SJx2OrNF-VGnC-szgr9k1f
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01.06.2021 15:59, radhey pandey wrote:
> On Fri, Apr 23, 2021 at 10:51 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 23-04-21, 15:51, Lars-Peter Clausen wrote:
> > > On 4/23/21 3:24 PM, Vinod Koul wrote:
> > > > On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> > > > > It seems to me what we are missing from the DMAengine API is the equivalent
> > > > > of device_prep_dma_memcpy() that is able to take SG lists. There is already
> > > > > a memset_sg, it should be possible to add something similar for memcpy.
> > > > You mean something like dmaengine_prep_dma_sg() which was removed?
> > > >
> > > Ah, that's why I could have sworn we already had this!
> >
> > Even at that time we had the premise that we can bring the API back if
> > we had users. I think many have asked for it, but I havent seen a patch
> > with user yet :)
> Right.  Back then we had also discussed bringing the dma_sg API
> but the idea was dropped as we didn't had a xilinx/any consumer
> client driver for it in the mainline kernel.
> 
> I think it's the same state now.

Would it be alright if I brought back the old DMA_SG interface that was removed
in commit c678fa66341c?  It seems that what I've effectively done is
implementing the semantics of that API call under the guise of
dma_prep_slave. However I still need mem2mem SG transfer support on CDMA, which
seems long gone from the driver, even though the HW does offer it.

If people are fine with it I can restore that interface and CDMA as the sole consumer.

>
> > > static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
> > >                 struct dma_chan *chan,
> > >                 struct scatterlist *dst_sg, unsigned int dst_nents,
> > >                 struct scatterlist *src_sg, unsigned int src_nents,
> > >                 unsigned long flags)
> > >
> > > The problem with this API is that it would work only when src_sg and
> > > dst_sg is of similar nature, if not then how should one go about
> > > copying...should we fill without a care for dst_sg being different than
> > > src_sg as long as total data to be copied has enough space in dst...
> > At least for the CDMA the only requirement is that both buffers have the
> > same total size.
>
> I will merge if with a user but semantics need to be absolutely clear on
> what is allowed and not, do I hear a volunteer ?
> --
> ~Vinod
