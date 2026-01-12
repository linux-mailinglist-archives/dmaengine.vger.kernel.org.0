Return-Path: <dmaengine+bounces-8214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F70D12D6B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B4F30142C7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0D358D07;
	Mon, 12 Jan 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSAsE2ck"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD93587A1;
	Mon, 12 Jan 2026 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224941; cv=none; b=A7nEE4qRuMG/oXelVpdLdkQapmH9KxUmoiq6F4TQxmMwElBxDLKJjU9d6gNQbYoc4ODnKMnxppcdYTozUQdLNE3AFPr7EX3ReiVsGCMHCMeclOIUulxQy/EHrvrOEN4GaMa96gtJbJfBnYzTiJued3poiUVEMRi7dC9ng+I0dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224941; c=relaxed/simple;
	bh=hAdDNP0uJNY4vw73AVjOI055cmk4EXKQe7NLD05xkKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8rbZ1l1UoOn265ySLmIUdi+JRY5vHpthAwsBfswmAwOzUmnqfnAvHOAQ2cCJKuFUyCx6hVMfPFTiO31iRVKnwNYTzKPJL8UtFEzUsZhJnMr3ZbLrGHjIEbb/XRjoLLdW1GtoI00fE2td3L5X+IDNJgokMVWMPti22WXLJAmpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSAsE2ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D250C16AAE;
	Mon, 12 Jan 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768224941;
	bh=hAdDNP0uJNY4vw73AVjOI055cmk4EXKQe7NLD05xkKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSAsE2ckcMezYmFQIV9Yd3FvJ6NJatqBOWcglypCWCOOZcaRknUNzSGc1K1VDI6Q8
	 G0+bUFIRre9DiQ8r9tI7UlnoO5tRY7Ry76RH6d/S7VS+YRTR2msLcsGXwXF2zA6GqL
	 zAG+Ci/fWtl+3TQ+geYxXPx0H9l0tZmRXY9i5MC54T3nrR1oqNAMPtLFhAgceeehCA
	 ZFYReahADgOJcNjwd5qjjTEduqvXJghwtfiQ2LHpMDlzRrYztueJoEt6PIR8kE07Fe
	 L87h2tJEN7v2yrW04x6YoiiBTm9Sh/MqmMFic8lIUkq6ZP2FA7EvHBPS1NOjCL+ibG
	 Gxx+qqK3PtHNw==
Date: Mon, 12 Jan 2026 14:35:35 +0100
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
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <aWT4p7RnFykJnuOz@ryzen>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>

Hello Frank,

On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:

Subject: dmaengine: dw-edma: support dynamtic add link entry during dma engine running

s/dynamtic/dynamic/

Also in patch 1/5:
s/dymatic/dynamic/


> Patch depend on
> https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t

To make it easier for the reader, please include the full list of
dependencies, i.e. also include:
https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
here.


> 
> Only test eDMA, have not tested HDMA.
> Corn case have not tested, such as pause/resume transfer.

s/Corn case/Corner cases/


> 
> Before
> 
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
> After
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
>  IOPS=299, BW=149MiB/s (156MB/s)

We can clearly see the improvement, but overall, your numbers are quite low.
What is the PCIe Gen + number of lanes you are using?
Are you running nvmet-pci-epf backed by a real drive or backed by null-blk?
(Having nvmet-pci-epf backed by null-blk is much better for benchmarking.)

I'm using nvmet-pci-epf backed by null-blk, with a PCIe Gen3 link with 4 lanes.


Applying only your dependencies, I get:

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.1k, BW=47.2MiB/s (49.5MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=51.1k, BW=200MiB/s (209MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=72.2k, BW=282MiB/s (296MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=2922, BW=365MiB/s (383MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=18.9k, BW=2368MiB/s (2483MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=18.7k, BW=2334MiB/s (2447MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1867, BW=934MiB/s (979MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=4738, BW=2369MiB/s (2484MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=4675, BW=2338MiB/s (2451MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=10.6k, BW=41.4MiB/s (43.5MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=34.4k, BW=135MiB/s (141MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=34.4k, BW=135MiB/s (141MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=2624, BW=328MiB/s (344MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1277MiB/s (1339MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=10.3k, BW=1282MiB/s (1344MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=3195, BW=399MiB/s (419MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=18.6k, BW=2321MiB/s (2434MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=2162, BW=1081MiB/s (1134MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=4727, BW=2364MiB/s (2479MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=2360, BW=2361MiB/s (2476MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2997, BW=375MiB/s (393MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1278MiB/s (1341MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=1434, BW=717MiB/s (752MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=2557, BW=1279MiB/s (1341MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=1276, BW=1276MiB/s (1338MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2110, BW=1058MiB/s (1109MB/s)
 IOPS=2127, BW=1068MiB/s (1120MB/s)


Applying your dependencies + this series, I get:

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.5k, BW=48.7MiB/s (51.0MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=55.3k, BW=216MiB/s (226MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=175k, BW=682MiB/s (715MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=3018, BW=377MiB/s (396MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=20.1k, BW=2519MiB/s (2641MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=24.4k, BW=3051MiB/s (3199MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1850, BW=925MiB/s (970MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=5846, BW=2923MiB/s (3065MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=6141, BW=3071MiB/s (3220MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=11.6k, BW=45.4MiB/s (47.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=49.6k, BW=194MiB/s (203MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=82.0k, BW=320MiB/s (336MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=3051, BW=381MiB/s (400MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=13.0k, BW=1619MiB/s (1698MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=12.5k, BW=1559MiB/s (1635MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=3445, BW=431MiB/s (452MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=18.3k, BW=2283MiB/s (2394MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=2048, BW=1024MiB/s (1074MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=5766, BW=2883MiB/s (3023MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=3038, BW=3038MiB/s (3186MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2961, BW=370MiB/s (388MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=12.3k, BW=1535MiB/s (1609MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=1482, BW=741MiB/s (777MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=3144, BW=1572MiB/s (1648MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=1549, BW=1550MiB/s (1625MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2596, BW=1303MiB/s (1366MB/s)
 IOPS=2617, BW=1313MiB/s (1377MB/s)


So I can clearly see an improvement with this patch series.
Great work so far!


Kind regards,
Niklas

