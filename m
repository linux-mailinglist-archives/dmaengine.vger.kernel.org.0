Return-Path: <dmaengine+bounces-3611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B029B230D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 03:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F9DB223C9
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E58188CB1;
	Mon, 28 Oct 2024 02:40:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AB418C333
	for <dmaengine@vger.kernel.org>; Mon, 28 Oct 2024 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083218; cv=none; b=VXk1TiRA0TyCvAx1tmGwSy77G3ZB2BAgVWG36g+8TrxohauTeNKj/p3WngLWr4QQ39dOaR7EIffb4VXgb+28WlAS8pE2mT5Q49ZyiLeT8oyK5qLSXza4zYT13gW3cPcveOrrB9NJRWY9LoQCMFkFli+lAGHZkgvWW5pI/hQ0D3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083218; c=relaxed/simple;
	bh=Od1p9eFiEoNUEhnW+sccDNX/y7TBvaNvnIcWV3Vwcic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYoAdeaIAzt15CnpEifkJM+nbokWIVU8Gj51t/+raXb7H7/4rW0/Kh1o8DqJ+mISBoejuzVgADscCDh3BWH+JsNNC/bXeSJlGUPn5/AhZ2JF7AvwyVPX9WBrrMqLMMaiTWO6u6K/owGpc2fYzEgb8JW9wwInKQUr63xJBwObE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8CxieGO+R5nlM0XAA--.50208S3;
	Mon, 28 Oct 2024 10:40:14 +0800 (CST)
Received: from [192.168.100.223] (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMAxDEeL+R5n1_wgAA--.13205S3;
	Mon, 28 Oct 2024 10:40:13 +0800 (CST)
Message-ID: <89738377-d752-4d23-8fe9-928dd4e3440f@loongson.cn>
Date: Mon, 28 Oct 2024 10:40:10 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] dmaengine: ls2x-apb: New driver for the Loongson
 LS2X APB DMA controller
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 zhoubb.aaron@gmail.com
Cc: dmaengine@vger.kernel.org
References: <87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxDEeL+R5n1_wgAA--.13205S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFy7Xw18CF4DCF13Xr1xXrc_yoWkurbEva
	ykWw42grWDJFySvFWjvry5AF1DXaykXr1Fk3ZYgFyjqa4ftws5uFW8Gas5Gw17Zr48WFyY
	9w10gryfAryI9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

Hi Dan:

Thanks for your report.

On 2024/10/25 16:59, Dan Carpenter wrote:
> Hello Binbin Zhou,
>
> Commit 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the
> Loongson LS2X APB DMA controller") from Dec 18, 2023 (linux-next),
> leads to the following Smatch static checker warning:
>
> 	drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
> 	warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'
>
> drivers/dma/loongson2-apb-dma.c
>      184 static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
>      185 {
>      186         struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
>      187         u64 val;
>      188
> --> 189         val = lo_hi_readq(priv->regs + LDMA_ORDER_ERG) & ~LDMA_CONFIG_MASK;
>
> On a 32bit build the ~LDMA_CONFIG_MASK will zero out the high 32 bits.  Should
> LDMA_CONFIG_MASK be defined with GENMASK_ULL()?
Indeed, it is more appropriate to define it as GENMASK_ULL().

I'll submit a patch to redefine it.


Thanks.

Binbin

>
>      190         val |= LDMA_64BIT_EN | cmd;
>      191         lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
>      192 }
>
> regards,
> dan carpenter


