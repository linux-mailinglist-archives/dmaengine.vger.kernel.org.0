Return-Path: <dmaengine+bounces-8213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7661D12ADD
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 14:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F5C300647D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA5357A2D;
	Mon, 12 Jan 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm7GSpVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E4242D7C;
	Mon, 12 Jan 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223265; cv=none; b=hEovR9QcdbpnihDeT+vfJDoS6y3Zcb0+l+rZO4qjckIyK1VaEWUbIa/bEgy/bJ8cnk/t/SAz1jUEa2m6Vu8sE/V3bE4HszNq1HkwOqBBEAOnzk8XLwM4PjxbMBdegiG1VukxKQdJVoJ8f3dNmNnSSLCYJmTWqDkiQ5dTzupd520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223265; c=relaxed/simple;
	bh=ix17Ps1qtfC2pvVqBCQ7IXMPmGDF8eNKN/QEJpT2JfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sieJu4lnAn0Dym3wuXH/FihT7lhd4BWA3Imu5B/NQjz1iGqF5I+FTaY4NXHNyJDFQv+YYWyDPTy3ZUCZzx7zsAiI0bojNzOfEy2044ye/grW6ylhVP+sYRhKY33+yLkz46N6Dp9+t6ZTfAURfR0GHGGtuQ/Mjr/J9Gr3aacZ2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm7GSpVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53D4C16AAE;
	Mon, 12 Jan 2026 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768223264;
	bh=ix17Ps1qtfC2pvVqBCQ7IXMPmGDF8eNKN/QEJpT2JfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bm7GSpVXCKIS8pRomJHB+z84Bs6F+FgKNOySpLfK8U7Qg9PsOBtaawYpkhUo7ZK+q
	 LRlnnrmWG9ESGWup87GMrfYC76XMWFfP2pr7pGR2eB3NXSGF9F7hZfNiKNf/BvD7wY
	 5XirUTRbadEcT1N2C4MxEHk7BfLb1CijMEHtWtna5xbBsvvVLOhQQTMxwsEKsWmjmd
	 UNdys7S70CgZuBhlN1gysNPDuMVzDMruYhGHRxhMBZE5UYA+bAi7Wxn1lbzZsOGf94
	 68ax68PfiPzDnvVuPmLAxU33EZ8hyT6xTPEo+C8VGNNUzQWd8i9PpxxiW6MJsW5DTT
	 +UgK/ibdrNvkw==
Date: Mon, 12 Jan 2026 14:07:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and
 simple code
Message-ID: <aWTyGpGN6WqtVCfN@ryzen>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>

Hello Frank,

Thanks for doing this work!

Sorry for pointing out a lot of typos here.
However, I do think it gives a better impression if there are fewer typos.


On Fri, Jan 09, 2026 at 10:28:20AM -0500, Frank Li wrote:

Subject: dmaengine: dw-edma: flatten desc structions and simple code

s/structions/structures/
s/simple/simplify/


> This patch week depend on the below serise.

s/serise/series/


> https://lore.kernel.org/imx/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/

Should this not be based on:
https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
instead?


> 
> Basic change
> 
> struct dw_edma_desc *desc
>        └─ chunk list
>             └─ burst list
> 
> To
> 
> struct dw_edma_desc *desc
>             └─ burst[n]
> 
> And reduce at least 2 times kzalloc() for each dma descriptor create.

s/create/creation/


> 
> I only test eDMA part, not hardware test hdma part.
> 
> The finial goal is dymatic add DMA request when DMA running. So needn't

s/finial/final/

Here and many other places:
s/dymatic/dynamic/

Also in patch 1/11:
s/dynamtic/dynamic/


> wait for irq for fetch next round DMA request.
> 
> This work is neccesary to for dymatic DMA request appending.

s/to/too/
s/neccessary/necessary/

> 
> The post this part first to review and test firstly during working dymatic
> DMA part.
> 
> performance is little bit better. Use NVME as EP function

s/NVME/NVMe/


> 
> Before
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
>   IOPS=261, BW=132MiB/s (138MB/s
> 
> After
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>    IOPS=266, BW=135MiB/s (141MB/s)
> 
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Vinod Koul <vkoul@kernel.org>
> To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
> To: Kees Cook <kees@kernel.org>
> To: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Krzysztof Wilczyński <kwilczynski@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Christoph Hellwig <hch@lst.de>
> To: Niklas Cassel <cassel@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> Cc: imx@lists.linux.dev
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - use 'eDMA' and 'HDMA' at commit message
> - remove debug code.
> - keep 'inline' to avoid build warning
> - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> 
> ---
> Frank Li (11):
>       dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
>       dmaengine: dw-edma: Move control field update of DMA link to the last step
>       dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
>       dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
>       dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
>       dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
>       dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
>       dmaengine: dw-edma: Add callbacks to fill link list entries
>       dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
>       dmaengine: dw-edma: Use burst array instead of linked list
>       dmaengine: dw-edma: Remove struct dw_edma_chunk
> 
>  drivers/dma/dw-edma/dw-edma-core.c    | 203 +++++++----------------------
>  drivers/dma/dw-edma/dw-edma-core.h    |  64 +++++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 234 +++++++++++++++++-----------------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 147 +++++++++++----------
>  4 files changed, 292 insertions(+), 356 deletions(-)
> ---
> base-commit: 5498240f25c3ccbd33af3197bec1578d678dc34d
> change-id: 20251211-edma_ll-0904ba089f01
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 

