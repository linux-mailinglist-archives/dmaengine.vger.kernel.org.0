Return-Path: <dmaengine+bounces-2981-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2658962838
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614CAB2390A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDB17A5A4;
	Wed, 28 Aug 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqhDxg7O"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6690175D47;
	Wed, 28 Aug 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850377; cv=none; b=SXfFtcrpL4UH2N0QuePxlMUsmlMJa2SA1ENGXaBS72EyQ/j5gnPeggdxRY5gHDEQXipGY8tFw6NP5RUAaF8eb5baU+y5u19djaDcOm6TH5mVM1CMqGgsJYW/Ao1CoRKTN8GZVsnpuYJyRxLYFcN0ppnhj5pVbqviny8dKUYfJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850377; c=relaxed/simple;
	bh=EAdjClXapxDjpgnzaErsxac7Ms6f3DmQPAtiSikh0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz4J9v95tB6zZS9QVko4K3wDnK2o8BAcavSs0JADiCfnoatKWBAsQvqvOIPKNUz/wcTqvQK7v1EM60WrKztudJwPBlORvEV4pDmDU4h6T4Z/hAvZWydaD4mFX4Qe7iMKZp8/9cEdzSlbJ6ZNXBERemSY1EouVPU/ibwaZjLfQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqhDxg7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B061C515AF;
	Wed, 28 Aug 2024 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724850377;
	bh=EAdjClXapxDjpgnzaErsxac7Ms6f3DmQPAtiSikh0mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqhDxg7OLfyXhZJg0/6GI7L1rn3nyBCEOpEGcoT2jrkx0uP1NuGUz2vUSz7/2ibPR
	 Ptl++7k3/8sp8CaT4JREMDaXXKGht7roD/tgfXKeETkGjblPM2dcrOOVdRqJXVLgki
	 RaLDMoyhCFMe6v36FH+576lIHTDV9XWY52FjTFNgKfz28UZwRR4OCM3CzmNZWXqWPc
	 MKFWpnoLOwxrkY6r5F/mn58yKtBkpxQKI96rssqDvKMxobXI3jssuYuberTXok3vlr
	 6JF2JjO8zp+qkmx+h6VcdIU9yri0fg/P39bBAONkKLFfZ0AMSRHtC3r7dHnCyXCgXj
	 mFY/AjrUg421A==
Date: Wed, 28 Aug 2024 18:36:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	olivierdautricourt@gmail.com, sr@denx.de,
	ludovic.desroches@microchip.com, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, wangzhou1@hisilicon.com, haijie1@huawei.com,
	fenghua.yu@intel.com, dave.jiang@intel.com, zhoubinbin@loongson.cn,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, afaerber@suse.de,
	manivannan.sadhasivam@linaro.org, Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org, ldewangan@nvidia.com,
	jonathanh@nvidia.com, thierry.reding@gmail.com,
	laurent.pinchart@ideasonboard.com, michal.simek@amd.com,
	Frank.Li@nxp.com, n.shubin@yadro.com, yajun.deng@linux.dev,
	quic_jjohnson@quicinc.com, lizetao1@huawei.com, pliem@maxlinear.com,
	konrad.dybcio@linaro.org, kees@kernel.org, gustavoars@kernel.org,
	bryan.odonoghue@linaro.org, linux@treblig.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] dmaengine: Fix spelling mistakes
Message-ID: <Zs8gxcOa8/ja5wDW@vaman>
References: <20240817080408.8010-1-av2082000@gmail.com>
 <b155a6e9-9fe1-4990-8ba7-e1ff24cca041@stanley.mountain>
 <CAPMW_rLPN1uLNR=j+A7U03AHX5m_LSpd1EnQoCpXixX+0e4ApQ@mail.gmail.com>
 <070cc3e2-d0db-4d50-9a64-6a16d88b30df@stanley.mountain>
 <CAPMW_rJi46_2Ho6KNS9NK0kbfc3ujrx-EJ3586wf0u7vq2kUog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMW_rJi46_2Ho6KNS9NK0kbfc3ujrx-EJ3586wf0u7vq2kUog@mail.gmail.com>

On 27-08-24, 21:47, Amit Vadhavana wrote:

> Hi All,
> 
> I wanted to follow up on the DMA patch that I submitted on 17 Aug.
> Kees Cook has already reviewed it. Have you all had a chance to review
> it as well?
> Please let me know if any additional changes or updates are needed.

Oddly enough, I dont see that in my list, can you please repost

-- 
~Vinod

