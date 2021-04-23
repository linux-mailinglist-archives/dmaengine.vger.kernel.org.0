Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83546369138
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhDWLj6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 07:39:58 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:50098 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhDWLj5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Apr 2021 07:39:57 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N7lYbl007463;
        Fri, 23 Apr 2021 12:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=dk201812; bh=neyO67KHOkdsSRPKA3TCOuGMIaXXeOtfMiT60PTC1ms=;
 b=q+SXAS1UGkL7XPI1lwrGeEdXk6211cySlbVoecrznyl2ysLSLwN6KSk61ZFkHdGA9xoW
 z3HFT8fqHbCRE0js36pt1GJEG3IsJgOIB2RmalA4lWpYG1lYz6j/+oI+YvSvyEOfNYTh
 shTitSayXfuqk4rwv7SQcHKgW/j46fH6A8+q7jEmEc5UM8o/0RpPaY+jDCCwMXR9ihom
 p/STvOpych+sxR9ivtHtMgTu1umDjdc2qo9ykfV2Q1ZpKyTIzQp/3hzZ/dK+2+cFfc7b
 k5Q74EfmB0uJYLqSJeY6i76oa4yBiMRQw0K0UygKluVunKgbKavS9cc68iJnwY+89x3n Aw== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 383r8kr6nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 12:39:01 +0100
Received: from localhost (10.100.70.86) by HHMAIL05.hh.imgtec.org
 (10.100.10.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 23 Apr
 2021 12:39:00 +0100
Date:   Fri, 23 Apr 2021 12:38:59 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <20210423113859.tdowrt5nx5bxb225@adrianlarumbe-HP-Elite-7500-Series-MT>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 5NUt_YeRbKCeH2jKf4bTfoK1xEhajsux
X-Proofpoint-ORIG-GUID: 5NUt_YeRbKCeH2jKf4bTfoK1xEhajsux
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23.04.2021 11:17, Lars-Peter Clausen wrote:

> The device_config() and device_prep_slave_sg() APIs are meant for
> memory-to-device or device-to-memory transfers. This means the device address
> is fixed and usually maps to a FIFO in the device.
> 
> What you are implementing is memory-to-memory, which means addresses are
> incremented on both sides of transfer. And this works if you know what you are
> doing, e.g. you know that you are using a specific dmaengine driver that
> implements the dmaengine API in a way that does not comply with the
> specification. But it breaks for generic dmaengine API clients that expect
> compliant behavior. And it is the reason why we have an API in the first
> place, to get consistent behavior. If you have to know about the driver
> specific semantics you might as well just bypass the framework and use driver
> specific functions.

You're absolutely right about this. I think I might've been confused when
picking the right DMA Engine API callback to write this new functionality into
by the fact that, on our particular configuration, transfers were being done
between main system memory and DDR memory on a PCI card. However, from the point
of view of the semantics of the API, these are still memory-to-memory transfers,
just like you said.

> It seems to me what we are missing from the DMAengine API is the equivalent of
> device_prep_dma_memcpy() that is able to take SG lists. There is already a
> memset_sg, it should be possible to add something similar for memcpy.

I wasn't aware of the existence of this callback. Grepping the sources reveals a
single consumer at the moment, I guess this also might've led me to wrongly
conclude device_prep_slave_sg was the right choice. Perhaps I can convert most
of the code currently in xilinx_cdma_prep_slave_sg to fit the semantics of this
DMAengine API function instead. Any thoughts on this?

Cheers,
Adrian
