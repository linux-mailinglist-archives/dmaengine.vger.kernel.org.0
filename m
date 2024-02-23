Return-Path: <dmaengine+bounces-1104-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E456861C36
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 20:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033B8283926
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F01339BA;
	Fri, 23 Feb 2024 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gSJOHz8G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE8143C6F
	for <dmaengine@vger.kernel.org>; Fri, 23 Feb 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714803; cv=none; b=rXKF6a3RqSMRNVXRfbp967VWsaQ0CUsB7vRW/+gENMhhU8jE+v0AEjuPOVzTtY2/a5IEOk8oAdXuSpsXyFaDA2Qu8SrnPMPg9aG8v3WlHxsQq9Fdu+ebHLmDOCHR7t0DA7h65KdSAbKYJlVXj6A7azWBpC7sWSIlKKrpD7zoqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714803; c=relaxed/simple;
	bh=7UqDuwBDaflgwCxw652350Ulcmu75Iyquu+SWNAvWw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLXA50UuuwuqLUt/uwFG20BvF4hoXxG1PC2iWqjUGTa5iUR4lZVRCeZIcUPHVopoxZ0vP2NPJBpE9En98CWn8o3iy3EIfKSifSwsro/Lo02KG42x5DmBwA+8QlgqcEjKJRu1zYMsydhKVu1HBMXLWCJeTRGktRnAX6Hl+mSQO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gSJOHz8G; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id dad3rSWmGAVWCdad3rWYDQ; Fri, 23 Feb 2024 19:50:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708714238;
	bh=b2nzjyV92V5xFcCR433HxBvfMH7+kUtrO9FWeyeWOCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gSJOHz8G0WmTpVutXKnIFVjcLbBB1QIclwwVEQyQ4j6idFD9JbNJap3o6UKPBJVZz
	 cqMFD/y4EvOF8qWOv8Y8+4Qy1CHhsbC2ahw9ZY+oHwAwBojDPKbLC+0eARYERsT9kZ
	 J8MljnZMQYF9Ed3LsOYxwkorekwBuoSpdxNXoEfegcDpWAKJ/8I6lQGCdD5v3FdVWp
	 qo8FRhlWim+zAOeryHLsfiwrcj1wkkTTeNGWvmNwMpDTDfoPGJkMYbh8KayxOMxHWG
	 NjB7hOFJZMC9iA/hGqmcSxgeeNpY5s+jus6lwGJZpxVEzbWBI1yZ87CD5L9VV1q6tH
	 oiJ1FRv0DTNCA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Feb 2024 19:50:38 +0100
X-ME-IP: 92.140.202.140
Message-ID: <530912d2-aa44-494d-bd51-dcac6147b78a@wanadoo.fr>
Date: Fri, 23 Feb 2024 19:50:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V8 2/2] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-MW
To: Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
 sonal.santan@amd.com, max.zhen@amd.com
References: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
 <1708707403-47386-3-git-send-email-lizhi.hou@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1708707403-47386-3-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 17:56, Lizhi Hou a écrit :
> From: Nishad Saraf <nishads@amd.com>
> 
> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> Accelerator devices.
>      https://www.xilinx.com/applications/data-center/v70.html
> 
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
> 
>              +-------+       +-------+       +-----------+
>     PCIe     |       |       |       |       |           |
>     Tx/Rx    |       |       |       |  AXI  |           |
>   <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>              |       |       |       |       |           |
>              +-------+       +-------+       +-----------+
> 
> The primary mechanism to transfer data using the QDMA is for the QDMA
> engine to operate on instructions (descriptors) provided by the host
> operating system. Using the descriptors, the QDMA can move data in both
> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
> The QDMA provides a per-queue basis option whether DMA traffic goes
> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
> 
> The hardware detail is provided by
>      https://docs.xilinx.com/r/en-US/pg302-qdma
> 
> Implements dmaengine APIs to support MM DMA transfers.
> - probe the available DMA channels
> - use dma_slave_map for channel lookup
> - use virtual channel to manage dmaengine tx descriptors
> - implement device_prep_slave_sg callback to handle host scatter gather
>    list
> - implement descriptor metadata operations to set device address for DMA
>    transfer
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---

...

> +static void qdma_free_qintr_rings(struct qdma_device *qdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < qdev->qintr_ring_num; i++) {
> +		if (!qdev->qintr_rings[i].base)
> +			continue;
> +
> +		dma_free_coherent(&qdev->pdev->dev, QDMA_INTR_RING_SIZE,
> +				  qdev->qintr_rings[i].base,
> +				  qdev->qintr_rings[i].dev_base);
> +	}
> +}
> +
> +static int qdma_alloc_qintr_rings(struct qdma_device *qdev)
> +{
> +	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
> +	struct device *dev = &qdev->pdev->dev;
> +	struct qdma_intr_ring *ring;
> +	struct qdma_ctxt_intr intr_ctxt;
> +	u32 vector;
> +	int ret, i;
> +
> +	qdev->qintr_ring_num = qdev->queue_irq_num;
> +	qdev->qintr_rings = devm_kcalloc(dev, qdev->qintr_ring_num,
> +					 sizeof(*qdev->qintr_rings),
> +					 GFP_KERNEL);
> +	if (!qdev->qintr_rings)
> +		return -ENOMEM;
> +
> +	vector = qdev->queue_irq_start;
> +	for (i = 0; i < qdev->qintr_ring_num; i++, vector++) {
> +		ring = &qdev->qintr_rings[i];
> +		ring->qdev = qdev;
> +		ring->msix_id = qdev->err_irq_idx + i + 1;
> +		ring->ridx = i;
> +		ring->color = 1;
> +		ring->base = dma_alloc_coherent(dev, QDMA_INTR_RING_SIZE,
> +						&ring->dev_base,
> +						GFP_KERNEL);

Hi,

Does it make sense to use dmam_alloc_coherent() and remove 
qdma_free_qintr_rings()?

If yes, maybe the function could be renamed as qdmam_alloc_qintr_rings() 
or devm_qdma_alloc_qintr_rings() to show that it is fully managed.

CJ

> +		if (!ring->base) {
> +			qdma_err(qdev, "Failed to alloc intr ring %d", i);
> +			ret = -ENOMEM;
> +			goto failed;
> +		}
> +		intr_ctxt.agg_base = QDMA_INTR_RING_BASE(ring->dev_base);
> +		intr_ctxt.size = (QDMA_INTR_RING_SIZE - 1) / 4096;
> +		intr_ctxt.vec = ring->msix_id;
> +		intr_ctxt.valid = true;
> +		intr_ctxt.color = true;
> +		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
> +					QDMA_CTXT_CLEAR, ring->ridx, NULL);
> +		if (ret) {
> +			qdma_err(qdev, "Failed clear intr ctx, ret %d", ret);
> +			goto failed;
> +		}
> +
> +		qdma_prep_intr_context(qdev, &intr_ctxt, ctxt);
> +		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
> +					QDMA_CTXT_WRITE, ring->ridx, ctxt);
> +		if (ret) {
> +			qdma_err(qdev, "Failed setup intr ctx, ret %d", ret);
> +			goto failed;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, vector, NULL,
> +						qdma_queue_isr, IRQF_ONESHOT,
> +						"amd-qdma-queue", ring);
> +		if (ret) {
> +			qdma_err(qdev, "Failed to request irq %d", vector);
> +			goto failed;
> +		}
> +	}
> +
> +	return 0;
> +
> +failed:
> +	qdma_free_qintr_rings(qdev);
> +	return ret;
> +}

...

