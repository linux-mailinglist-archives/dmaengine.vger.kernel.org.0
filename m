Return-Path: <dmaengine+bounces-5679-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644FAEDA7D
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CAB3A3F43
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jun 2025 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C1245000;
	Mon, 30 Jun 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uWj5q0qT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A41A3154;
	Mon, 30 Jun 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281728; cv=none; b=rLwyjjQiCRwUnVL98TiE6eds0M1rEknR51N2Mt4xlO3FIK6K24u0dF2IbN1w3UY7wnkrXCnefhmCB/M+Ty6h9HOPImsFNSYWM7fT337xdem4Ex1jUc1roDpbzsAcQTX0xM9XGTpEcuLgpVm+ZgE5pV796+6HJskPH88IjHkwtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281728; c=relaxed/simple;
	bh=xeNpkjWQch2NbOHRUvdma+xIq5icCiLRNG/kXkIEEUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1/T4+ftiJgGAUSSBckqOKtJRGoJAb11O5dOQU+s9g4SBowSXHS2SN0Urv3d22SxIkYgJO7aZsiOgGFIYrmxaUxM/LLn7yvRpqUgmB/sAwxZdjNgfG86c6iCCUFQP/6O9kgxb6P9HooKbS/6DQvfgA8C0xnQ888fAqg6TlbAKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uWj5q0qT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8e10N013074;
	Mon, 30 Jun 2025 13:08:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hCK+JNiz/bYO7J2DWpXBYxNDtczevbXi8wneI/4lIHw=; b=uWj5q0qTavpWUevx
	Vi+UdKWHC/3Qjeeq//y7qsv+iUrhsyGPhUrvKDhotvJQpmgoQsyj+uChnXxg53rz
	ZhBIDSZGqASugloP88kwCxjv+Lve6TwDMz4vAK6awZOxHke/NXm8H/Do+KHH2JXp
	13FxpfZfv5tLEelusizShyeg5mI3gv/m1aWPNJEqAqHdhAZs8+0Qa2Rd1vvsO5iQ
	J26ATSfJuxfl78ji9BPXMqkXshp6GL28tz6R1gMlC0hM01bTA/jQW+ejNI2JGWoM
	enkOd1nP4EWF+7Q6YLH3QXZ9ScvfaGxxKPNF3diZMzAT4UuJ1vBEldj65eNXlL6i
	dMkAPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47jsy4mtta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 13:08:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 132544006A;
	Mon, 30 Jun 2025 13:07:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70B94B17B06;
	Mon, 30 Jun 2025 13:07:13 +0200 (CEST)
Received: from [10.48.87.237] (10.48.87.237) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 13:07:11 +0200
Message-ID: <13cb5cad-7ad4-40fd-a423-10187b327b8c@foss.st.com>
Date: Mon, 30 Jun 2025 13:07:10 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: virt-dma: convert tasklet to BH
 workqueue for callback invocation
To: Alexander Kochetkov <al.kochet@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nishad Saraf <nishads@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
        Jacky Huang
	<ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil
	<paul@crapouillou.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Zhou
 Wang <wangzhou1@hisilicon.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Andy
 Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
	<afaerber@suse.de>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang
	<haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul
 Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland
	<samuel.holland@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi
	<peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Amit Vadhavana <av2082000@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Md Sadre Alam <quic_mdalam@quicinc.com>,
        Casey
 Connolly <casey.connolly@linaro.org>,
        Kees Cook <kees@kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>,
        Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
References: <20250616124934.141782-1-al.kochet@gmail.com>
 <20250616124934.141782-2-al.kochet@gmail.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250616124934.141782-2-al.kochet@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01



On 6/16/25 14:48, Alexander Kochetkov wrote:
> Currently DMA callbacks are called from tasklet. However the tasklet is
> marked deprecated and must be replaced by BH workqueue. Tasklet callbacks
> are executed either in the Soft IRQ context or from ksoftirqd thread. BH
> workqueue work items are executed in the BH context. Changing tasklet to
> BH workqueue improved DMA callback latencies.
> 
> The commit changes virt-dma driver and all of its users:
> - tasklet is replaced to work_struct, tasklet callback updated accordingly
> - kill_tasklet() is replaced to cancel_work_sync()
> - added include of linux/interrupt.h where necessary
> 
> Tested on Pine64 (Allwinner A64 ARMv8) with sun6i-dma driver. All other
> drivers are changed similarly and tested for compilation.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
...
>   drivers/dma/stm32/stm32-dma.c                  |  1 +
>   drivers/dma/stm32/stm32-dma3.c                 |  1 +
>   drivers/dma/stm32/stm32-mdma.c                 |  1 +

For STM32:
Acked-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Tested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

