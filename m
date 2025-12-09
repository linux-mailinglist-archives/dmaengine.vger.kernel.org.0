Return-Path: <dmaengine+bounces-7545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BFCAF1DE
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 08:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBFE3006A75
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDB27FD76;
	Tue,  9 Dec 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/jVDiia"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AE19CCF7;
	Tue,  9 Dec 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264809; cv=none; b=lBwFuvzjAXS1wndkqW35ixy7ifzYQiCldK/gXgY1/9QqOvihFOsjf8CdgLitRp+DXA2bk6/xab3bppEpEwo7I9jR+029fC6LjXs1L1F5iTgFGtPtVWPCOMWYjVsJGv4j0EANScjMWQOUbQaS6ANqIBlVtnWqBT8VwqsN13tn5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264809; c=relaxed/simple;
	bh=2+RBfirrXuFnkMRxDw7t0EtfDZroa6uDXyUspwpTeIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a96dkxOQClkof4kcvL77GbAJ6Uou34WKxUZm/wGMBX3LcrOfGMJGRYC2MrN5gLLUltAtBktZ7wKQ3tnavb03VIv8MwneZS3b0EBaLRa/++QpivpTpu/uqpwU8jmENsKNC6QrAoUvCRHrUelBA29k9faL/PHvKFXiTLRwAWapM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/jVDiia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137C4C4CEFB;
	Tue,  9 Dec 2025 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765264809;
	bh=2+RBfirrXuFnkMRxDw7t0EtfDZroa6uDXyUspwpTeIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/jVDiia6Xt689ozubWpINb6zPps2GAGN4ovKR+yZJbb1pZ3FqoiGlaESeOnFGwnC
	 oFohj1jB3EQDwexnuAimLRCSTAIkMcqqUUp/Ppk00eblJIMiI/hUSM5ZqNuoxKDqZy
	 qgunAerivYkbJNWMeG6MbaGPRLrk4rTDm8kPpdrvVO6pUGQ3o1l5c+0pYQxttsTsb0
	 s+gzBg72oPYzw/GIwTiMssFxRpmpM6CU76gMyTDS9l6ARdgm0Y7ac8cxoaqmsswcKH
	 AwmLtUYjLUKVPw9RIwCOxo2ni4xc0MAgPG9bSbJcD8Qiv+TID/luQz8wBjVO8pFKff
	 fxdkxqKFXombQ==
Date: Tue, 9 Dec 2025 08:20:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aTfNoU6fKBOcjL5j@ryzen>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>

On Mon, Dec 08, 2025 at 12:09:39PM -0500, Frank Li wrote:
> Frank Li (8):
>       dmaengine: Add API to combine configuration and preparation (sg and single)
>       PCI: endpoint: pci-epf-test: use new DMA API to simple code
>       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
>       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
>       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
>       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
>       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
>       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> 
>  drivers/crypto/atmel-aes.c                    | 10 ++---
>  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
>  drivers/nvme/target/pci-epf.c                 | 21 +++------
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
>  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
>  6 files changed, 111 insertions(+), 82 deletions(-)
> ---
> base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> change-id: 20251204-dma_prep_config-654170d245a2

For the series (tested using drivers/nvme/target/pci-epf.c):
Tested-by: Niklas Cassel <cassel@kernel.org>

Mainline:
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=5721, BW=22.3MiB/s (23.4MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=51.8k, BW=202MiB/s (212MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=109k, BW=426MiB/s (447MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=2678, BW=335MiB/s (351MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=19.1k, BW=2388MiB/s (2504MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=18.1k, BW=2258MiB/s (2368MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1388, BW=694MiB/s (728MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=4554, BW=2277MiB/s (2388MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=4516, BW=2258MiB/s (2368MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=4679, BW=18.3MiB/s (19.2MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=35.1k, BW=137MiB/s (144MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=33.7k, BW=132MiB/s (138MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=2490, BW=311MiB/s (326MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=4964, BW=621MiB/s (651MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=4966, BW=621MiB/s (651MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=2586, BW=323MiB/s (339MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=17.5k, BW=2190MiB/s (2296MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=1614, BW=807MiB/s (847MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=4540, BW=2270MiB/s (2381MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=2283, BW=2284MiB/s (2395MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2313, BW=289MiB/s (303MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=4948, BW=619MiB/s (649MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=901, BW=451MiB/s (473MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=1289, BW=645MiB/s (676MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=632, BW=633MiB/s (663MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=1756, BW=880MiB/s (923MB/s)
 IOPS=1767, BW=886MiB/s (929MB/s)


Mainline + this series applied:
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=3681, BW=14.4MiB/s (15.1MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=54.8k, BW=214MiB/s (224MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=123k, BW=479MiB/s (502MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=2132, BW=267MiB/s (280MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=19.0k, BW=2369MiB/s (2485MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=18.7k, BW=2341MiB/s (2454MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1135, BW=568MiB/s (595MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=4546, BW=2273MiB/s (2384MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=4708, BW=2354MiB/s (2469MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=3369, BW=13.2MiB/s (13.8MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=31.7k, BW=124MiB/s (130MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=31.1k, BW=122MiB/s (127MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1820, BW=228MiB/s (239MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=5703, BW=713MiB/s (748MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=5813, BW=727MiB/s (762MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1958, BW=245MiB/s (257MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=18.8k, BW=2345MiB/s (2459MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=1319, BW=660MiB/s (692MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=4542, BW=2271MiB/s (2382MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=2325, BW=2325MiB/s (2438MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2174, BW=272MiB/s (285MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=5697, BW=712MiB/s (747MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=1035, BW=518MiB/s (543MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=1462, BW=731MiB/s (767MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=720, BW=721MiB/s (756MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2029, BW=1018MiB/s (1067MB/s)
 IOPS=2037, BW=1023MiB/s (1072MB/s)


Small performance boost, but I think the nicest thing with this series is
to be able to remove the ugly mutex in pci-epf.c.


Kind regards,
Niklas

