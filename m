Return-Path: <dmaengine+bounces-645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DD81CFE1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 23:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A38B23A6A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8772F85D;
	Fri, 22 Dec 2023 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="Th/67DuH"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17752F865
	for <dmaengine@vger.kernel.org>; Fri, 22 Dec 2023 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 7D1642D20692;
	Fri, 22 Dec 2023 23:43:44 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id QlR8na06gDHs; Fri, 22 Dec 2023 23:43:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 129E12D20696;
	Fri, 22 Dec 2023 23:43:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 129E12D20696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1703285020;
	bh=7hMMwVJ9BHPVf5oT5QW8fMTlzszBSOKi19RlT3xHXEw=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Th/67DuHWSEaat8POJCsMeJloAbaUh5yjzRzv6pqu6MKsQ1wAyXXm/nUtcjkUCU3+
	 3ghaBoc+rZFbaHrkuvI/1Cn1D63D4n3R7DYBPTPYShz2Q9+PT9p6qljqBeJ741rCpq
	 oRrAmJaAx6Pd7n6iN1eYBEIc7A38jEEzUkHm1fTsAgFZIU2j10kt1X6LkwNNXj5X+t
	 4+NUtSXiwr4UrKrZ3lVtWQ01soUeU7v0kqSzuDha+I08/Y2R5Hxfj7eyBlZuaEPsXp
	 sWqP3Pr7xmhdBJyyKL7CivG9mq+W3XLMkAkTo/Re0BOGyYNickK5NbQluleZgzU8LM
	 DP67uFDArGfCg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jQavP4A7IbgG; Fri, 22 Dec 2023 23:43:40 +0100 (CET)
Received: from [10.125.125.1] (unknown [10.125.125.1])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 5B3032D20692;
	Fri, 22 Dec 2023 23:43:39 +0100 (CET)
Message-ID: <d3ada600-c0ed-486d-98d0-e161059099f3@alatek.krakow.pl>
Date: Fri, 22 Dec 2023 23:43:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] dmaengine: xilinx: xdma: Fix two clang warnings
To: Nathan Chancellor <nathan@kernel.org>, lizhi.hou@amd.com,
 brian.xu@amd.com, raj.kumar.rampelli@amd.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, patches@lists.linux.dev
References: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
Content-Language: en-US
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 22.12.2023 19:06, Nathan Chancellor wrote:
> Hi all,
> 
> This series fixes two clang warnings that I see after
> commit 2f8f90cd2f8d ("dmaengine: xilinx: xdma: Implement interleaved DMA
> transfers"). They have just been build tested but I think the logic is
> sound, please double check though.
> 
> ---
> Nathan Chancellor (2):
>       dmaengine: xilinx: xdma: Fix operator precedence in xdma_prep_interleaved_dma()
>       dmaengine: xilinx: xdma: Fix initialization location of desc in xdma_channel_isr()
> 
>  drivers/dma/xilinx/xdma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> ---
> base-commit: 3d0b2176e04261ab4ac095ff2a17db077fc1e46d
> change-id: 20231222-dma-xilinx-xdma-clang-fixes-b9c2c3f5d0f3
> 
> Best regards,

Thanks for fixing my broken patches Nathan. Next time I submit any patch, I have to pay more attention to use proper compiler flags for sure (I didn't use those flags so I didn't get any warnings/errors). The logic is okay.

Thanks,
Jan

