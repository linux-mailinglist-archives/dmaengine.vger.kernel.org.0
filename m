Return-Path: <dmaengine+bounces-2643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A09291AC
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C07283264
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB521350;
	Sat,  6 Jul 2024 08:00:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E612B9B7;
	Sat,  6 Jul 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252826; cv=none; b=sDSTQmGiczBEF/omg/xNMKLa/PrhpkoN43VIIVnhP+2I9ZuVOzSYKRzvghSW4GmYJ6s5Qz0o1G4g7QF+kRzALlJekY8mkcDHbA9ipZ875BOh5ZsCU66/CiyjhmXEfH3hkLoEJbrGTdCOB1eVG9YhwbTy3YPDRcd2WtLUPiBn3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252826; c=relaxed/simple;
	bh=l0OvSIEh5IK5PphP346o1Y0nzFKcQmfMXuqPHsphDao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3Yyyky19z5NHUCWiLZeTV/hnh6KTjurL0yyHNvfneRtoynNX86KZWMEUqTfljpgMUtP4XKIUiMpesX0TMpmaRqxzInjPXqyy6WYCtH/v/MAoRXawdIgXLJGdZpzp+nF50FputQS5sXpRcLm4MUpnUHFpQGNXgP27h3golKl7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn; spf=none smtp.mailfrom=gxmicro.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gxmicro.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gxmicro.cn
X-QQ-mid: bizesmtp83t1720252782t6qsiff5
X-QQ-Originating-IP: HpfmTQNQuiKiGRsdXbnezJOgPGy94hySGLY76zrPsMc=
Received: from localhost.localdomain ( [139.227.197.63])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 06 Jul 2024 15:59:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6247354441702454303
From: dongxiong zheng <zhengdongxiong@gxmicro.cn>
To: manivannan.sadhasivam@linaro.org
Cc: dmaengine@vger.kernel.org,
	fancer.lancer@gmail.com,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	zhengdongxiong@gxmicro.cn
Subject: Re: [PATCH RESEND 2/2] damengine: dw-edma: Add msi wartermark configuration
Date: Sat,  6 Jul 2024 15:59:31 +0800
Message-Id: <20240706075931.306-1-zhengdongxiong@gxmicro.cn>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240705141101.GA57780@thinkpad>
References: <20240705141101.GA57780@thinkpad>
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

> On Fri, Jul 05, 2024 at 06:57:35PM +0800, zheng.dongxiong wrote:
> > HDMA trigger wartermark interrupt, When use the RIE flag.
> > PCIe RC will trigger AER, If msi wartermark addr is not configuration.
> > This patch fix it by add msi wartermark configuration
> >
> > Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
>
> HDMA driver is not at all using watermark interrupts. So we should be disabling
> them altogether.
>
> See: https://lore.kernel.org/dmaengine/1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com/
>
> - Mani
>

Hi Mani:

Ok, Thanks you!

> > ---
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index d77051d1e..c4d15a7a7 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -280,6 +280,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> >  	/* MSI done addr - low, high */
> >  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
> >  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
> > +	/* MSI watermark addr - low, high */
> > +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb, chan->msi.address_lo);
> > +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb, chan->msi.address_hi);
> >  	/* MSI abort addr - low, high */
> >  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
> >  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> > --
> > 2.34.1
> >
>

Regards,
dongxiong zheng

