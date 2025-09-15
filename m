Return-Path: <dmaengine+bounces-6512-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD0B57A3F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D64E162226
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74224A044;
	Mon, 15 Sep 2025 12:18:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8482AD11;
	Mon, 15 Sep 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938693; cv=none; b=Ca7jmi/T4G3t4L+Ea9f14gJJqqUV6SuGtEFKsjafsYms3H+WxfzG47GSZR73if3xCRVtU410rv6aIXiVP+YO3Q2Ecd9mkEw1Omc46N3SSj/g6j9e4Ui/wkx2rhkrraZfijH0Y3A2vFXibvVsFhEVMvRkKOn55jjEuYArc6NWvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938693; c=relaxed/simple;
	bh=ybjcuwbdPeSSf58GfNrZLbTx361DsTpYMPNclLBtM/o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWfxGAoBpqLy/Cj3XEXymw9LudgSimwy42rBuqSUHHPdP88U9+r2TLnbgUXUMSKg3JOsoCwN/mAYOkZiVMQ4DrsXp8+FRvtVO0jbMsU0xoIAF5xYPWjKQy9UIdKexHyy3ctAOyXd8kdsMfmmmT8YSItT7blkbw/+k1JHOULaBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQPB252rRz6M5B2;
	Mon, 15 Sep 2025 20:15:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A8961400DC;
	Mon, 15 Sep 2025 20:18:08 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 14:18:07 +0200
Date: Mon, 15 Sep 2025 13:18:06 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 07/13] dmaengine: sdxi: Import descriptor enqueue
 code from spec
Message-ID: <20250915131806.00006e3b@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-7-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-7-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:30 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Import the example code from the "SDXI Descriptor Ring Operation"
> chapter of the SDXI 1.0 spec[1], which demonstrates lockless
> descriptor submission to the ring. Lightly alter the code
> to (somewhat) comply with Linux coding style, and use byte order-aware
> types as well as kernel atomic and barrier APIs.
> 
> Ultimately we may not really need a lockless submission path, and it
> would be better for it to more closely integrate with the rest of the
> driver.
> 
> [1] https://www.snia.org/sites/default/files/technical-work/sdxi/release/SNIA-SDXI-Specification-v1.0a.pdf
> 
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Hi Nathan,

I suspect you have a good idea of what needs to happen to get this ready for a merge
but I'll comment briefly anyway!

> ---
>  drivers/dma/sdxi/enqueue.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/enqueue.h |  16 ++++++
>  2 files changed, 152 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/enqueue.c b/drivers/dma/sdxi/enqueue.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..822d9b890fa3538dcc09e99ef562a6d8419290f0
> --- /dev/null
> +++ b/drivers/dma/sdxi/enqueue.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + *
> + * Copyright (c) 2024, The Storage Networking Industry Association.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the
> + * distribution.
> + *
> + * * Neither the name of The Storage Networking Industry Association
> + * (SNIA) nor the names of its contributors may be used to endorse or
> + * promote products derived from this software without specific prior
> + * written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <asm/barrier.h>
> +#include <asm/byteorder.h>
> +#include <asm/rwonce.h>
> +#include <linux/atomic.h>
> +#include <linux/errno.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/processor.h>
> +#include <linux/types.h>
> +
> +#include "enqueue.h"
> +
> +/*
> + * Code adapted from the "SDXI Descriptor Ring Operation" chapter of
> + * the SDXI spec, specifically the example code in "Enqueuing one or
> + * more Descriptors."
> + */
> +
> +#define SDXI_DESCR_SIZE 64
I think that's already effectively encoded in the asserts in the header.
Hence don't repeat it here. Use sizeof() whatever makes sense.

> +#define SDXI_DS_NUM_QW (SDXI_DESCR_SIZE / sizeof(__le64))

> +#define SDXI_MULTI_PRODUCER 1  /* Define to 0 if single-producer. */

Get rid of other path and drop this.

> +
> +static int update_ring(const __le64 *enq_entries,   /* Ptr to entries to enqueue */
> +		       u64 enq_num,                 /* Number of entries to enqueue */
> +		       __le64 *ring_base,           /* Ptr to ring location */
> +		       u64 ring_size,               /* (Ring Size in bytes)/64 */
> +		       u64 index)                   /* Starting ring index to update */

Whilst I get the minimal changes bit, make this kernel-doc.

> +{
> +	for (u64 i = 0; i < enq_num; i++) {
> +		__le64 *ringp = ring_base + ((index + i) % ring_size) * SDXI_DS_NUM_QW;
> +		const __le64 *entryp = enq_entries + (i * SDXI_DS_NUM_QW);
> +
> +		for (u64 j = 1; j < SDXI_DS_NUM_QW; j++)
> +			*(ringp + j) = *(entryp + j);

memcpy?

> +	}
> +
> +	/* Now write the first QW of the new entries to the ring. */
> +	dma_wmb();
> +	for (u64 i = 0; i < enq_num; i++) {
> +		__le64 *ringp = ring_base + ((index + i) % ring_size) * SDXI_DS_NUM_QW;
> +		const __le64 *entryp = enq_entries + (i * SDXI_DS_NUM_QW);
> +
> +		*ringp = *entryp;
> +	}
> +
> +	return 0;
> +}
> +
> +int sdxi_enqueue(const __le64 *enq_entries,                 /* Ptr to entries to enqueue */
> +		 u64 enq_num,                               /* Number of entries to enqueue */
> +		 __le64 *ring_base,                         /* Ptr to ring location */
> +		 u64 ring_size,                             /* (Ring Size in bytes)/64 */
> +		 __le64 const volatile * const Read_Index,  /* Ptr to Read_Index location */
> +		 __le64 volatile * const Write_Index,       /* Ptr to Write_Index location */
> +		 __le64 __iomem *Door_Bell)                 /* Ptr to Ring Doorbell location */
> +{
> +	u64 old_write_idx;
> +	u64 new_idx;
> +
> +	while (true) {
> +		u64 read_idx;
> +
> +		read_idx = le64_to_cpu(READ_ONCE(*Read_Index));
> +		dma_rmb();  /* Get Read_Index before Write_Index to always get consistent values */
> +		old_write_idx = le64_to_cpu(READ_ONCE(*Write_Index));
> +
> +		if (read_idx > old_write_idx) {
> +			/* Only happens if Write_Index wraps or ring has bad setup */
> +			return -EIO;
> +		}
> +
> +		new_idx = old_write_idx + enq_num;
> +		if (new_idx - read_idx > ring_size) {
> +			cpu_relax();
> +			continue;  /* Not enough free entries, try again */
> +		}
> +
> +		if (SDXI_MULTI_PRODUCER) {
> +			/* Try to atomically update Write_Index. */
> +			bool success = cmpxchg(Write_Index,
> +					       cpu_to_le64(old_write_idx),
> +					       cpu_to_le64(new_idx)) == cpu_to_le64(old_write_idx);
> +			if (success)
> +				break;  /* Updated Write_Index, no need to try again. */
> +		} else {
> +			/* Single-Producer case */
> +			WRITE_ONCE(*Write_Index, cpu_to_le64(new_idx));
> +			dma_wmb();  /* Make the Write_Index update visible before the Door_Bell update. */
> +			break;  /* Always successful for single-producer */
> +		}
> +		/* Couldn"t update Write_Index, try again. */
> +	}
> +
> +	/* Write_Index is now advanced. Let's write out entries to the ring. */
> +	update_ring(enq_entries, enq_num, ring_base, ring_size, old_write_idx);
> +
> +	/* Door_Bell write required; only needs ordering wrt update of Write_Index. */
> +	iowrite64(new_idx, Door_Bell);
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/sdxi/enqueue.h b/drivers/dma/sdxi/enqueue.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..28c1493779db1119ff0d682fa6623b016998042a
> --- /dev/null
> +++ b/drivers/dma/sdxi/enqueue.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/* Copyright (c) 2024, The Storage Networking Industry Association. */
> +#ifndef DMA_SDXI_ENQUEUE_H
> +#define DMA_SDXI_ENQUEUE_H
> +
> +#include <linux/types.h>
> +
> +int sdxi_enqueue(const __le64 *enq_entries,  /* Ptr to entries to enqueue */
> +		 u64 enq_num,  /* Number of entries to enqueue */
> +		 __le64 *ring_base,  /* Ptr to ring location */
> +		 u64 ring_size,  /* (Ring Size in bytes)/64 */
> +		 __le64 const volatile * const Read_Index,  /* Ptr to Read_Index location */
> +		 __le64 volatile * const Write_Index,  /* Ptr to Write_Index location */
> +		 __le64 __iomem *Door_Bell);  /* Ptr to Ring Doorbell location */
> +
> +#endif /* DMA_SDXI_ENQUEUE_H */
> 


