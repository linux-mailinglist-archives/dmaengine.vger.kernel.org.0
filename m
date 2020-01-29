Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A614C91A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgA2K4U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 05:56:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3592 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2K4U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 05:56:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3164a00000>; Wed, 29 Jan 2020 02:55:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 02:56:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 02:56:18 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 10:56:16 +0000
Subject: Re: [PATCH v5 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-2-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <858021de-62fd-2d21-7152-42af4e3a04b2@nvidia.com>
Date:   Wed, 29 Jan 2020 10:56:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123230325.3037-2-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580295328; bh=Fje555DfDUE6kGnSNsqCRpVoc3wD3ZspNfNjXOQTA0o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jwWWXwsLS3RIOIH3Updt2zyJEIjVb4v51V8oCPlpr/+Dcyc13CfyZIm99/xTSJNK/
         pgKyRgJIx4S+QswHhyMhvP6oPIZqSo90hPdGb/0qnpPYbZK4A3wC06sJyqhLLZLYgu
         LTcJW0KdCO+oSMV11EgmTFZAn1w4B3HfQt1f92tzcCauaXIIjPsicqMoHAlgT7f8sq
         09SUShHGsSKPNNuTFCCM9ObcTWZNbPmxnKBdVcN77CSnBJSCAV2pv4k2QZ2cT7pXHr
         TUSUZ6AJx5vAmNYMD3D+jG666sRgpIxTYRabIlHZwdX07hpDfYDkeFEIT1VrtNcrNW
         LOaP9fBXVRaZQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 23/01/2020 23:03, Dmitry Osipenko wrote:
> I was doing some experiments with I2C and noticed that Tegra APB DMA
> driver crashes sometime after I2C DMA transfer termination. The crash
> happens because tegra_dma_terminate_all() bails out immediately if pending
> list is empty, thus it doesn't release the half-completed descriptors
> which are getting re-used before ISR tasklet kicks-in.
> 
>  tegra-i2c 7000c400.i2c: DMA transfer timeout
>  elants_i2c 0-0010: elants_i2c_irq: failed to read data: -110
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 142 at lib/list_debug.c:45 __list_del_entry_valid+0x45/0xac
>  list_del corruption, ddbaac44->next is LIST_POISON1 (00000100)
>  Modules linked in:
>  CPU: 0 PID: 142 Comm: kworker/0:2 Not tainted 5.5.0-rc2-next-20191220-00175-gc3605715758d-dirty #538
>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>  Workqueue: events_freezable_power_ thermal_zone_device_check
>  [<c010e5c5>] (unwind_backtrace) from [<c010a1c5>] (show_stack+0x11/0x14)
>  [<c010a1c5>] (show_stack) from [<c0973925>] (dump_stack+0x85/0x94)
>  [<c0973925>] (dump_stack) from [<c011f529>] (__warn+0xc1/0xc4)
>  [<c011f529>] (__warn) from [<c011f7e9>] (warn_slowpath_fmt+0x61/0x78)
>  [<c011f7e9>] (warn_slowpath_fmt) from [<c042497d>] (__list_del_entry_valid+0x45/0xac)
>  [<c042497d>] (__list_del_entry_valid) from [<c047a87f>] (tegra_dma_tasklet+0x5b/0x154)
>  [<c047a87f>] (tegra_dma_tasklet) from [<c0124799>] (tasklet_action_common.constprop.0+0x41/0x7c)
>  [<c0124799>] (tasklet_action_common.constprop.0) from [<c01022ab>] (__do_softirq+0xd3/0x2a8)
>  [<c01022ab>] (__do_softirq) from [<c0124683>] (irq_exit+0x7b/0x98)
>  [<c0124683>] (irq_exit) from [<c0168c19>] (__handle_domain_irq+0x45/0x80)
>  [<c0168c19>] (__handle_domain_irq) from [<c043e429>] (gic_handle_irq+0x45/0x7c)
>  [<c043e429>] (gic_handle_irq) from [<c0101aa5>] (__irq_svc+0x65/0x94)
>  Exception stack(0xde2ebb90 to 0xde2ebbd8)
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 3a45079d11ec..319f31d27014 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -756,10 +756,6 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	bool was_busy;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
> -	if (list_empty(&tdc->pending_sg_req)) {
> -		spin_unlock_irqrestore(&tdc->lock, flags);
> -		return 0;
> -	}
>  
>  	if (!tdc->busy)
>  		goto skip_dma_stop;

Acked-by: Jon Hunter <jonathanh@nvidia.com>

I think that we should mark this one for stable.

Cheers
Jon

-- 
nvpublic
