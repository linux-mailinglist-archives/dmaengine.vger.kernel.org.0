Return-Path: <dmaengine+bounces-2645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1149291FD
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B871F21E6F
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8CA41A94;
	Sat,  6 Jul 2024 08:41:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F411C69D;
	Sat,  6 Jul 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255265; cv=none; b=kuOafj1pVe0W2zf83JaASI81iSKRDNFYaLDJgx4ShvMoE3EEYXqVgDNupI8/+JxWWR0WJt29GO2VOo0f7SVBK8xWx3WJ78QJIrQcj8TsR6umopP6L0/xTIMlqKoNJi6aNnjrWWwFWUV7561A8GB4BbrWHPBIN2uJdAFWlRPQ6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255265; c=relaxed/simple;
	bh=SytcVlEMBmbjx58Bg5PMQV7NBdW2R9Yo25763l9T/2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkV03HWYPEX0s+WSln24B78fXa29EwbDt00q57ao0LNsnrqsaxTjwfMrGORr5YLNnv83IQ1guy/Dd4Th8G1yxQwHWDM68j3aeTwL4id5ZGdArYpJGgC9akzqLCjM804hbWc+/l+JobLJJ1oupNvrADvd352bQ7V+wjn2IWPIP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn; spf=none smtp.mailfrom=gxmicro.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gxmicro.cn
X-QQ-mid: bizesmtp79t1720255212t8yh5pqm
X-QQ-Originating-IP: k9LwgqnLfTm1YJAF1ETMds3oFl38YFHKLM7iyWgsa00=
Received: from zhengdongxiong.. ( [139.227.197.63])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 06 Jul 2024 16:40:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10991724749373251913
From: dongxiong zheng <zhengdongxiong@gxmicro.cn>
To: manivannan.sadhasivam@linaro.org
Cc: dmaengine@vger.kernel.org,
	fancer.lancer@gmail.com,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	zhengdongxiong@gxmicro.cn
Subject: Re: [PATCH RESEND 1/2] dmaengine: dw-edma: Move "Set consumer cycle" into first condition in dw_hdma_v0_core_start()
Date: Sat,  6 Jul 2024 16:40:10 +0800
Message-Id: <20240706084010.2094-1-zhengdongxiong@gxmicro.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705141241.GB57780@thinkpad>
References: <20240705141241.GB57780@thinkpad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:gxmicro.cn:qybglogicsvrgz:qybglogicsvrgz8a-0

Hi, Manivannan Sadhasivam:
	Thank you for your reply!

On Fri, Jul 05, 2024 at 19:42:41 +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 05, 2024 at 06:57:34PM +0800, zheng.dongxiong wrote:
> > Two or more chunks are used in a transfer,
> > Consumer cycle only needs to be set on the first transfer.
> >
>
> Can you please reference the section of the spec that mentions this behavior?
>
> - Mani
>

Reference:
	Chapter 6.4.9.1 LL Operation Overview:
	"Figure 6-23 Linked List Flow for Producer and Consumer" in
	DesignWare Cores PCI Express Controller Databook (Version 6.00a June 2022)

The CCS must be set when L1 is executed for the first time, After an interruption is
triggered, CCS does not need to be configured again when L3 is executed.

> > Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
> > ---
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 10e8f0715..d77051d1e 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  			  lower_32_bits(chunk->ll_region.paddr));
> >  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> >  			  upper_32_bits(chunk->ll_region.paddr));
> > +		/* Set consumer cycle */
> > +		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > +			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> >  	}
> > -	/* Set consumer cycle */
> > -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> > -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> >
> >  	dw_hdma_v0_sync_ll_data(chunk);
> >
> > --
> > 2.34.1
> >
>

Test brief: hdma set chan->ll_max == 1,
then user alloc two or more scatterlist, start transfer.

--
Regards,
dongxiong zheng


