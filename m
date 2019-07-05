Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE166030D
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGEJZ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 05:25:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6993 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGEJZ1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 05:25:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1f17850000>; Fri, 05 Jul 2019 02:25:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jul 2019 02:25:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jul 2019 02:25:26 -0700
Received: from [10.24.44.191] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 09:25:24 +0000
Subject: Re: [RESEND PATCH] dmaengine: tegra210-adma: Don't program FIFO
 threshold
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20190705091557.726-1-jonathanh@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <9b177cc7-0d51-1b0b-1caa-96d990a2d779@nvidia.com>
Date:   Fri, 5 Jul 2019 14:55:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705091557.726-1-jonathanh@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562318725; bh=MoWfrMDlAIklgIwOCsDdPMYivY9p3vCMU30aIyZeQ2c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=W+H4nDkpx0r0ZXipgUemo9WHdgHW7Zk4CJuJ10Z8ASMS9jT55jBcAw/g8thVswZ3Q
         VPwbgAor8e4jfTUFSHrRPIUBkIzdatvdI8N2kFdLwAmLdtJndrPkVY0W8nwOG08Qhi
         fpCV0Cz7/zS+qPggxImQjMvDcdQL23npfbJCY3pQFMCbVQR3/zsfvnQPSQxeVyVORZ
         jpxWcJQkdVzB3HjJH6u4D9tGXm7tgraBoRvzDiioZGENj+JhIrM/AldTteXc7YVFs5
         1jZbs9oh5u13Xqx7bUiQHpLabzePrJb9nw9zAaXaY6BLpEb6Fuv40xkmVMDzez1SN3
         obUi849D0HQRA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/5/2019 2:45 PM, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
>
> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> which are ...
>
> 1. Transfer data to/from the FIFO as soon as a single burst can be
>     transferred.
> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>     the FIFO threshold is specified in terms on multiple bursts.
>
> Currently, the ADMA driver programs the FIFO threshold values in the
> FIFO_CTRL register, but never enables the transfer mode that uses
> these threshold values. Given that these have never been used so far,
> simplify the ADMA driver by removing the programming of these threshold
> values.
>
> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>
> Resending the patch rebased on top next-20190704. I have added Thierry's
> ACK as well.
>
>   drivers/dma/tegra210-adma.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 2805853e963f..d8646a49ba5b 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -42,12 +42,8 @@
>   #define ADMA_CH_CONFIG_MAX_BUFS				8
>   
>   #define ADMA_CH_FIFO_CTRL				0x2c
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0xf) << 24)
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0xf) << 16)
>   #define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
>   #define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0x1f) << 24)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0x1f) << 16)
>   #define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
>   #define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
>   
> @@ -64,14 +60,10 @@
>   
>   #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
>   
> -#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
> -				    TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
> -				    TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
> +#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
>   				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>   
> -#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
> -				    TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
> -				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
> +#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
>   				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>   
>   #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
Acked-by: Sameer Pujar <spujar@nvidia.com>
