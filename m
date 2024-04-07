Return-Path: <dmaengine+bounces-1755-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2089B099
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FE61C20D62
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8B1C288;
	Sun,  7 Apr 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL/LcCAM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509522EE5;
	Sun,  7 Apr 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488994; cv=none; b=PX6yI0v9srZUrI7C4W16tSqUo0vPkresHN8I+aJHSP1TPJrUnZwPJFK95Zr7DHl65WXI23Qa9rl3C395/tp8aE7jC2+/O9jzI3vvxiZM8vtCZ9B4JEF7KD5TvUIMNus4v3b93Kzj5ahmhSZ8ZFVt0k7f28fbeClA441iMS145Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488994; c=relaxed/simple;
	bh=5suR5ejrCA9fwoRJgZKID0FTG3hpL42flJ7EeEBlYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT0dK09TFA1pXgLuP1QyqjJ9+L0/1iou7Kq/BZbp7wnh9fmDULQbWYqOmMQw5pcWBcP7pC3fXEDY05lYiCFGGU/ht95f8cH4aWTcrM2Y7PnYHeMqHof7TmdgT/mdu+Wi5TekWn/40XAkk0jR9q/roDa/6gPYgz2gWW86ZsCTFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL/LcCAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CEAC43390;
	Sun,  7 Apr 2024 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712488994;
	bh=5suR5ejrCA9fwoRJgZKID0FTG3hpL42flJ7EeEBlYuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GL/LcCAMHHwG1RjtRD1qwdMfbicOlrbROY0L21dD4sFAxjAQIvA3VK1O2gzwZ+wj0
	 Nr45B8vc0nqcQk7+dzlaq3tH+e+CbLZRg8NsxvJec3FhtD9U30WhoaJSB2MxZwQnBZ
	 AyZfPmYQv++1o2fksPW93jOdCjg2EXBbWwfWwRJx/vgMdsm1AVgyMWZnz2Hsktf9PX
	 sFmyhXCbht5iJLccVlEHICpgIgPGxPWWWZzwPwDD1H3GoCjrK/27ZUF4HMUMjZ71I1
	 GMh7cySb4Lpi1JBXCun8kedcXSVAjqpNNZ9ro/3q3BsjFtj5KFDOAvGf2QN632m7vb
	 P0Pe0F1hrC/Rg==
Date: Sun, 7 Apr 2024 16:53:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID: <ZhKCHlAYxnhhcKnt@matsya>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532FB358A842A2ACC5E878BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532FB358A842A2ACC5E878BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>

On 29-03-24, 10:04, Inochi Amaoto wrote:
> The "top" system controller of CV18XX/SG200X exposes control
> register access for various devices. Add soc header file to
> describe it.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/soc/sophgo/cv1800-sysctl.h
> 
> diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
> new file mode 100644
> index 000000000000..b9396d33e240
> --- /dev/null
> +++ b/include/soc/sophgo/cv1800-sysctl.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#ifndef CV1800_SYSCTL_H
> +#define CV1800_SYSCTL_H
> +
> +/*
> + * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
> + */
> +
> +#define CV1800_CONF_INFO		0x004
> +#define CV1800_SYS_CTRL_REG		0x008
> +#define CV1800_USB_PHY_CTRL_REG		0x048
> +#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
> +#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
> +#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
> +#define CV1800_TOP_WDT_CTRL		0x1a8
> +#define CV1800_DDR_AXI_URGENT_OW	0x1b8
> +#define CV1800_DDR_AXI_URGENT		0x1bc
> +#define CV1800_DDR_AXI_QOS_0		0x1d8
> +#define CV1800_DDR_AXI_QOS_1		0x1dc
> +#define CV1800_SD_PWRSW_CTRL		0x1f4
> +#define CV1800_SD_PWRSW_TIME		0x1f8
> +#define CV1800_DDR_AXI_QOS_OW		0x23c
> +#define CV1800_SD_CTRL_OPT		0x294
> +#define CV1800_SDMA_DMA_INT_MUX		0x298

Why are these register defines in soc, all the dma registers should
belong to dma driver and other IPs, why do you need a common header??

-- 
~Vinod

