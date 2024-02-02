Return-Path: <dmaengine+bounces-932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59859847047
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 13:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F12850AD
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25496145341;
	Fri,  2 Feb 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUg5xpMf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478F14461F
	for <dmaengine@vger.kernel.org>; Fri,  2 Feb 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876819; cv=none; b=PItTH/lBfF3fi9YYxF7yBa87yad+9BFUap3J3MbtYdq+tavPMJ2wM2q8lwqHkY8z4a6PD0IYqiL5C3U1EFJJyg6RpsbzawVd52HIEs7ulM7ARXKMrx2fNXJvDURIln91FkYflEw7MwZQJe3nRvVcdF4kKC9o/l2xCRoNCij11m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876819; c=relaxed/simple;
	bh=Bf4Up7WRKNNJkk2B2Ny8OMSo7CnhLQW6PMrg0VWGUfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjDXHjNSdqSw6q2xrpKvV3koMIWZkszXoyJ09gM2iY1USaGgb9b9XOlltgxeOsa0tIoYLN9VwyIxCZBjgfTBsgz0rrQBBr0kKVmhFI+XG6nBZ05UBIzAEEJXNpd9BH8VHdPsKCfDDwfLzQfF2fHOTR2PyvN/KIhCiUlNwAk8FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUg5xpMf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1723559a12.3
        for <dmaengine@vger.kernel.org>; Fri, 02 Feb 2024 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706876817; x=1707481617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Y+fTwYyuNILHWoWbcIweD1jablI0n426/hbloY+0EY=;
        b=AUg5xpMfsjt24dz5JsokpejZmMcmrlGE4BRyCc4+gIYv5MYU4ln2Isnmm5bjaskZEp
         GSsM4tl8cYvI3S1WbMjKOxapa339H+YmZAkEwV/8KbBVlfLZb9pPaCgB15RaIfZt0RtX
         hGjJytt2B1OpESE2WWzqcKF/L6SPnovG4BjlnI0SbNhkeB7IourVOBDdbxhtchFA2Jsd
         LcR7ll2SoBg+ii3tm27A7NTC1KhvIoOF7DtzgneA4bcjfyfGm66WrNgvTVZCuQj2ouJs
         ZaCbKrk8epLTF61HSujlLxvs8ZBycz50lxfc9HAf1TpnYu/MPBUlvWqd89QTLqwaCSgi
         RHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876817; x=1707481617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y+fTwYyuNILHWoWbcIweD1jablI0n426/hbloY+0EY=;
        b=PEPwTUpgtKTvMd/ZiqmVgIOQ03Q+6dmgtdmh0KdeQ8zCxxdTZxsKNlQsirWWrCt0Cs
         MmW3CPNUi5kHWb9P1wkNT9uBiHbzaubMOh6boZviZKm18IfUfXbyxtOvrKJELOrdZdkl
         BxMKbilWIkyfj72ARFRiJJcP7Boc4rQwX7jC7f/ctNa2Sk/vmgyXtuXn8CdVx87UUpVr
         Q6vagyIYRrXNWqEAwJr2a+SiM0hPgDFePQaktTms+38Aqb1W3YVVV5vvLLhMs+22Iw9R
         ROk5+0U7qp9Cr9nIUSKV1nD9mlsGZkxL27lS2+KK0HHZgwR1l3gaW7IIWzj8Ed3MJxeI
         a9qg==
X-Gm-Message-State: AOJu0Yx5PFRGQ5zwmssOwV+VdGvcCMYNuVqzXhyjX6a0P2VVaw58smuH
	0m6BH7rlOXkgOI93RjOytga42xMIyqvPDrHE8KpVtf2R85tOoyH0bdgF+4pLWC6htxZ9AbO2or4
	=
X-Google-Smtp-Source: AGHT+IGI1K8CSU7kV9E2ObyJafkFW954cd+WUxDFClY8Hk2SO4JShs6jB7GNIUQmPp4iwYKDO+tqbQ==
X-Received: by 2002:a17:902:eb4b:b0:1d9:6e53:b8ca with SMTP id i11-20020a170902eb4b00b001d96e53b8camr1792547pli.62.1706876816709;
        Fri, 02 Feb 2024 04:26:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUABWAbmKPc1y0oGs2Om27vm/Z02JNjlc9/2Sy1H9Ll7b+nL4h06xNLL1B0iuzPgp8SGmfkksjo2pyI78ujs0mnIF+WHrc8fCyr140aR5E5MJDhRNg93IU1AzIHk8pzudUW6HPRRqU8vdWccO/Z3JUdyH9vAffuYLYw6IizeJJw6PBKZBwVXVVLtDc1NTIyhK3QwSTvWkLsTNGeN7jkAfPUmdVUJdDv4kvI/64BzJPAzkRCrlmOR+aTjhDSSlvqrbfWJg7rdI+4gLHxybGKXFf61ScPET5OZxERmQE4JMttmn/HPeRQt9/RPeg+7pl2geeInpmRJJkrl3+UlmhQuKj9XHexbCRrLERdZvjTdWQdnyx9JFO4qtfgn4eoWEhEw5TpvU3tJ13LRmsyKRxGldGJAQMtrxANvtDVjqHNH8VmggN5fl8ank/XKQPxupIEkXyVdevC9hpF7iDIvSJBcJu665LurKdmOOU6psv3n34DtkCDc0F1P+iM1pUirdTnV77yQgYthaxIKV3KZ3Umc304U21nvVeSDowbJbz3I28/zZKrnl9ithNTIZEqE9FvvuEK7JDnBKYrYw4wHc4f4bqePM23GpFncQ/hfyBq0lyXu3acjwDwEsOu1Xxkae8nIMq95PDWjX680A/PdaN2YUvMhrx4kDBNO+2Po1i1FGjgG5ukp461HtiQIRfZc8SfWDWqJ463wvXagADveuTgOiPpI1tas1BzF7pOQ4ZtflyVsFvuyy5Ub31lvaqA5U3Z34G1f7pcjmMoyj6aKpplMjq6xCPfHdFbusxl1gi+J8Maqdx/OrOCxRk6qUBUZfhmUEwSpoeArudjzrO3TpZsGvQw9DfgIri2c/krT/khABIjBXWP5nuDcoKvhRkka7qekr4m6/n3Su2lFOA=
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001d7405022ecsm1462559plb.159.2024.02.02.04.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:26:56 -0800 (PST)
Date: Fri, 2 Feb 2024 17:56:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, vkoul@kernel.org,
	jingoohan1@gmail.com, conor+dt@kernel.org, konrad.dybcio@linaro.org,
	robh+dt@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 4/6] dmaengine: dw-edma: Move HDMA_V0_MAX_NR_CH
 definition to edma.h
Message-ID: <20240202122648.GD8020@thinkpad>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-5-git-send-email-quic_msarkar@quicinc.com>
 <qfdsnz7louqdrs6mhz72o6mzjo66kw63vtlhgpz6hgqfyyzyhq@tge3r7mvwtw3>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qfdsnz7louqdrs6mhz72o6mzjo66kw63vtlhgpz6hgqfyyzyhq@tge3r7mvwtw3>

On Fri, Feb 02, 2024 at 01:47:37PM +0300, Serge Semin wrote:
> Hi Mrinmay
> 
> On Fri, Jan 19, 2024 at 06:30:20PM +0530, Mrinmay Sarkar wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > To maintain uniformity with eDMA, let's move the HDMA max channel
> > definition to edma.h. While at it, let's also rename it to HDMA_MAX_NR_CH.
> 
> First of all include/linux/dma/edma.h already contains the common DW
> EDMA and _HDMA_ settings/entities including the number of channels.
> Both of these IP-cores have the same constraints on the max amount of
> channels. Moreover the EDMA_MAX_WR_CH/EDMA_MAX_RD_CH macros are
> already utilized in the common dw_edma_probe() method. So to speak you
> can freely use these macros for HDMA too. Thus this change is
> redundant. So is the patches 1/6 and 2/6.
> 
> Note currently all the common DW EDMA driver code uses the EDMA_/edma_
> prefixes. HDMA_/hdma_ prefixes are utilized in the Native
> HDMA-specific module only. So if you wished to provide some IP-core
> specific settings utilized in the common part of the driver, then the
> best approach would be to provide a change for the entire driver
> interface (for instance first convert it to having a neutral prefixes,
> like xdma_/etc, and then use the IP-core specific ones). So please
> just use the EDMA_MAX_WR_CH and EDMA_MAX_RD_CH macros and drop the
> patches 1, 2, and 4.
> 

Hmm. With my limited access to the HDMA IP insights, I was not aware that the
constraints are similar with EDMA. If so, then it makes sense to reuse the same
macros. But I would also add a comment on top of the macros to avoid confusion.

- Mani

> -Serge(y)
> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 4 ++--
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 3 +--
> >  include/linux/dma/edma.h              | 1 +
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 1f4cb7d..819ef1f 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -54,7 +54,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
> >  {
> >  	int id;
> >  
> > -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > +	for (id = 0; id < HDMA_MAX_NR_CH; id++) {
> >  		SET_BOTH_CH_32(dw, id, int_setup,
> >  			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> >  		SET_BOTH_CH_32(dw, id, int_clear,
> > @@ -70,7 +70,7 @@ static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >  	 * available, we set it to maximum channels and let the platform
> >  	 * set the right number of channels.
> >  	 */
> > -	return HDMA_V0_MAX_NR_CH;
> > +	return HDMA_MAX_NR_CH;
> >  }
> >  
> >  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > index a974abd..cd7eab2 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > @@ -11,7 +11,6 @@
> >  
> >  #include <linux/dmaengine.h>
> >  
> > -#define HDMA_V0_MAX_NR_CH			8
> >  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
> >  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
> >  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> > @@ -92,7 +91,7 @@ struct dw_hdma_v0_ch {
> >  } __packed;
> >  
> >  struct dw_hdma_v0_regs {
> > -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
> > +	struct dw_hdma_v0_ch ch[HDMA_MAX_NR_CH];	/* 0x0000..0x0fa8 */
> >  } __packed;
> >  
> >  struct dw_hdma_v0_lli {
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 550f6a4..2cdf249a 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -14,6 +14,7 @@
> >  
> >  #define EDMA_MAX_WR_CH                                  8
> >  #define EDMA_MAX_RD_CH                                  8
> > +#define HDMA_MAX_NR_CH					8
> >  
> >  struct dw_edma;
> >  struct dw_edma_chip;
> > -- 
> > 2.7.4
> > 

-- 
மணிவண்ணன் சதாசிவம்

