Return-Path: <dmaengine+bounces-5727-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C769DAF6468
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05351168C7C
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A0238C0D;
	Wed,  2 Jul 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7fEB+PD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359B19D8A7;
	Wed,  2 Jul 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493235; cv=none; b=E3mh+3mWHI/Yor8Xzb3GZz5BgA+NrpqKq9pTgvxZf1gSi3P5Rsw95T8f9t9HvC13lp4SQ4L2cqrmmvaf2LgZ2+oSXyD0/KH5mDukJ6R/isbwSw7/YVOs6+c0Jirz8jzo2w/YGk6mjmTDHAdUSVIiXD9xyHLAbTkI8PTb44+H6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493235; c=relaxed/simple;
	bh=rxvHHcdLxay5pgV2pri9chnKzLlI/6ZTM1bPqLXpXno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDMEUXvx0Xo6zsUYz2IEJTRqohtk59TS0jpNb8dM4kD4t+NbOerww0yln3xKrjWyN8zh4EHyZljLdn3cirzukvT4fpYfy2XBm+nU6l+Bf6vuAn7P63Vpf6J446gyrjQNBtxiHWx5FMJkVcUmUFKdsYmk8F2ClTqo4v4NlX81g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7fEB+PD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dad3a179so1167679666b.1;
        Wed, 02 Jul 2025 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751493231; x=1752098031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjhU4lWDkYhIAdbwGlMIPjSef1uErDPPW0mevCjlBN0=;
        b=d7fEB+PDCFvMQskrNPBnHBB/lC7F28TmDs/aXRrXBOmwPPa7m5GRRq2xCbsx0W1pMa
         iMdvjvWm/UJBzsIY1DyU+lhBEYf+d7aFfQi1+PKhQuh9johwHla0XsAp2t/4wncHrjkW
         waCU3tN7NjRJL6X2YeA1T1kQ+1UWFGnGyCnbS7hieXCLm+q/CkOHFqB1kdGexKb4XE8d
         Ggg/FXXDxYo9QK1hHuYs1coJbG/8UIq3vbIFUiBizCsdT0Lwiw2sFg2oVg3cJYEq5Jh8
         cMwkYW6AAAYOkyJ4f2SIpvocM1UBUd8zMsBqnmT8CnmaDryskPsOh9cYy5GevISQStW0
         QlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493231; x=1752098031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjhU4lWDkYhIAdbwGlMIPjSef1uErDPPW0mevCjlBN0=;
        b=g06Q5ctRUaRdXLL9RH+TXdx0o2lsYHqLph8iOkmIvpUBlfRHObGdSYAxcJ2DQ2Bdbp
         b5QjJoP9SrcZus8rW6hx/FsTk1GP813e6rKHpgCICWJIPPH7j0UVNM0Mq6m1xXkRBMG9
         IbyYOIRcIoY9FEIuoo0DGSd+oQxZ0ubeZx98OGmEPtyuKQDaPfxKCt9T7Ve2P0xOo72+
         e6/v94XVnIkVZu8HXsoe1mlrG60fFxcq2lHWfw6Ez1Sbq3wsXdNRT9U4cJr/s0iKPkbU
         jiZ3Ehkk6YjK3G5btJaaOH/BA6/kaNwNCcGVHgsncEgq6CzMB7vFIeIYTW1WKKQ3FC6A
         4Jxg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9YYv/tjWJkBDl0LLGyeiCnY6+c1NKm2b+xsAG6tqo1BghU9FatdhnF39uKeAYcKyBqtF4qct/+c=@vger.kernel.org, AJvYcCVjEuWViTr/dwuJnRaU3gGF9uhe6OMcO/7+do5YesemBtj4Avdpx+Ji4x4te1eWn8oLCpvpOz69EgMvrrsh@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAFhFrgoboykjoQaRXdZzk+iB00mpv3rvN7LohBXxbYQhNy5l
	BmLF+2dBEceGo8FwOCHLCTjYPvhZsHPxYoVrbT78uvvzHoWmxP1FNdQX
X-Gm-Gg: ASbGncvR4/zFUseZp8vi4yw8+IPurAMX0SOpcHvSay7lXPqjVMaFB9ka10ef0HUJer/
	MxzYVfMOK5vBedovDwHl5ZlJdj6zsHcVC/bduUzxnx9KM5wVbNOQumlGPGLlAfNJQqW9dXHfSMq
	quTn433SxdRgLaDgNWVXjC0Qv8pVis8TAMqOn/u8bSEj81dl+hXnzn0sWqXu2zPC+p/SO0m6r84
	0xCoAgqShyZd1u6XUs5zpLYuAGyyusCpYBXSFGJWAgG4VlAeUctX9TCDFeIFCojtVsslJJ2BfVU
	h53M6ZMNZF3C0e7vWUQZK1AQ8PAiUhrENLpw52z1ML/gOfeO436Sd20n6GX0Ti+3fi/rConS+PF
	ZJM1ntOUSxhA0DcHxNNe2BVkNRf/Kjgvj34/fwSn/5/MjfRn/8lyvvU3BH2NK6hVdLboAE+s+Lt
	ebHHY1FSM=
X-Google-Smtp-Source: AGHT+IH5fqSYi27hWsKvh5k/kAGyjsZCZElfUzRK3f2yygjGkAJ4EGIUiFN5Zdt0UXCyCqiowOwOQQ==
X-Received: by 2002:a17:907:60d3:b0:ae3:5e2a:493 with SMTP id a640c23a62f3a-ae3c2c4703amr463260966b.49.1751493230681;
        Wed, 02 Jul 2025 14:53:50 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:c65a:f772:14df:7b2d? (2a02-a466-68ed-1-c65a-f772-14df-7b2d.fixed6.kpn.net. [2a02:a466:68ed:1:c65a:f772:14df:7b2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca0fdasm1147252666b.147.2025.07.02.14.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 14:53:50 -0700 (PDT)
Message-ID: <dd2b009a-cc8b-4f21-b248-64e909830bc0@gmail.com>
Date: Wed, 2 Jul 2025 23:53:48 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: virt-dma: convert tasklet to BH
 workqueue for callback invocation
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Kochetkov <al.kochet@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishad Saraf <nishads@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Paul Cercueil <paul@crapouillou.net>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>,
 Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Orson Zhai
 <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Amit Vadhavana <av2082000@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, Casey Connolly <casey.connolly@linaro.org>,
 Kees Cook <kees@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
References: <20250616124934.141782-1-al.kochet@gmail.com>
 <20250616124934.141782-2-al.kochet@gmail.com>
 <aFku5QPf38JKlcPt@smile.fi.intel.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <aFku5QPf38JKlcPt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 23-06-2025 om 12:39 schreef Andy Shevchenko:
> On Mon, Jun 16, 2025 at 12:48:03PM +0000, Alexander Kochetkov wrote:
>> Currently DMA callbacks are called from tasklet. However the tasklet is
>> marked deprecated and must be replaced by BH workqueue. Tasklet callbacks
>> are executed either in the Soft IRQ context or from ksoftirqd thread. BH
>> workqueue work items are executed in the BH context. Changing tasklet to
>> BH workqueue improved DMA callback latencies.
>>
>> The commit changes virt-dma driver and all of its users:
>> - tasklet is replaced to work_struct, tasklet callback updated accordingly
>> - kill_tasklet() is replaced to cancel_work_sync()
>> - added include of linux/interrupt.h where necessary
> 
> ...
> 
>>   drivers/dma/hsu/hsu.c                          |  2 +-
>>   drivers/dma/idma64.c                           |  3 ++-
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> for the above two.

With and without PREEMPT_RT (on Intel Edison) same 2 drivers.

Tested-by: Ferry Toth <fntoth@gmail.com> # for Merrifield


