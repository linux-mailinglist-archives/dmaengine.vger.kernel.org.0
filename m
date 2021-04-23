Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857D2369572
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbhDWPBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 11:01:48 -0400
Received: from mx08-00376f01.pphosted.com ([91.207.212.86]:54641 "EHLO
        mx08-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243410AbhDWPBO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Apr 2021 11:01:14 -0400
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 11:01:13 EDT
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
        by mx08-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N6cPTb013057;
        Fri, 23 Apr 2021 15:36:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=dk201812; bh=uySPgWu7hrrY3FeuQ0Qsd4QHgTnPEVFoyovBam6su/U=;
 b=X+6naz8A6H8qn/xNnT9rSFVZvQpLLGdpFACjY1TweeqO1ft2hC8cHZX5rioEUjXRxmZO
 ttoTG4Gk8WKOyi5nODxuG0kLKF9CJJcTRqr32d+VhA950+KrbuqMkfSNGLRjVf8bEq1+
 S1TGW3NroEL9tV//IAoI4fzFV/KUcbTvEie5Rhnl+mHwk7top3cuclu362lolFOd0gJv
 yi0m0tAfgGrq48WIjjfL+F616udMuMwUQWYKHzs0jVOH9n4M4aFmCxSy0vzhnbCPRof7
 FnByTEotzbhZ1I6HaLbqI1DsiE2QNbVinx9b5VMKrphx6jiGPwt4SYhXQNLS7idjlY+3 jA== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx08-00376f01.pphosted.com with ESMTP id 383rmc09t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 15:36:44 +0100
Received: from localhost (10.100.70.86) by HHMAIL05.hh.imgtec.org
 (10.100.10.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 23 Apr
 2021 15:36:43 +0100
Date:   Fri, 23 Apr 2021 15:36:43 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <20210423143643.3y6opm6j4ry4wmao@adrianlarumbe-HP-Elite-7500-Series-MT>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
 <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
 <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <bed31611-a084-2a05-f3a3-25585a47be9a@metafoo.de>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: oNtr8xRpN7TZLbmZbUyFaxtAEOkAkeFa
X-Proofpoint-ORIG-GUID: oNtr8xRpN7TZLbmZbUyFaxtAEOkAkeFa
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23.04.2021 15:51, Lars-Peter Clausen wrote:

> > On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> > > It seems to me what we are missing from the DMAengine API is the equivalent
> > > of device_prep_dma_memcpy() that is able to take SG lists. There is already
> > > a memset_sg, it should be possible to add something similar for memcpy.
> > You mean something like dmaengine_prep_dma_sg() which was removed?
> > 
> Ah, that's why I could have sworn we already had this!

Yes, after that API function was removed, the Xilinx DMA driver effectively
ceased to support memory-to-memory SG transfers. My assumption was if it wasn't
ever reimplemented through the callback you mentioned before, is because there
isn't truly much interest in this device.

However we do need this functionality in our system. At the moment, and for our
particular use of it, we can always guarantee that either the source or
destination will be one contiguous chunk of memory, so just one scatterlist
pointer array was enough to fully program an operation. I think this would fit
alright into memset_sg.  What do you think?

Also, at the moment we're using it for transfers between main memory and
CPU-mapped PCI memory, which cannot be allocated with kmalloc. Wouldn't this
fall into the use case for device_prep_slave_sg?

Adrian
