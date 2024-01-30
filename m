Return-Path: <dmaengine+bounces-888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD107841E4C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FEB28B362
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8FF57882;
	Tue, 30 Jan 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFBVUY5M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4759144
	for <dmaengine@vger.kernel.org>; Tue, 30 Jan 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604499; cv=none; b=egCnl7ueRGhAKygCBVmlYuNK7PRQxsWRS2uHovGfi45xeg8iXGX8Tb3TAeHB8LuDKhoKgjjUYBtS+kB0kpV3qBSy58tzIdtEl8s1IvaLGSNhaU7+1GJSfHwveE5cAWF739K7/mCXfcSN7/rG8ZVOq+RoMblSsQPlNkecDsCaNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604499; c=relaxed/simple;
	bh=OTwo8h1r/HNa/CiLlIhtm61CfaQXTQtYUzvR2httRas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vpe9EyZBrdTUYuQ1mfqGS5/OXxO0hMjaIu9/q6+tSJfJqOteX1VLaHSHLsQ0OZ2qxEfQ6HKrZxdmh1foW6YFm1Bc7dxd0KtgrvN/5/jTvuCLOmBsc782tyOsMN//UbamhsRkgpwU8Z8H5n8JtvNrWfnkimzxBJa3/Bknm99p9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yFBVUY5M; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bb9b28acb4so2647782b6e.2
        for <dmaengine@vger.kernel.org>; Tue, 30 Jan 2024 00:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706604495; x=1707209295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYqm9+PdfliMcUPhu/XhOrYgIKmn3e//lFHUo82Q1J0=;
        b=yFBVUY5M5PJznZXXUoI9QF0l1pvmA01vHxgzQE9fmP34C7v4Yt//W2LXStTS2O23sM
         W6Lrtw6l/Czds4I/4hJv7k2ScEUNXQMKXbNzGWR5tB/uYOLoeqesWQWSk8girbrmy3LV
         LXtDVa1UCM3GOw5KCpyKXilzVO/B3chZA9okugeMrbWXYKBDiiG5oCtYBB+2ZjxqNVQJ
         uqYr7aprpZ+MCJVY2Ua++WiOTroR3B5G7IRbbag19uE0NoVFqEMKWes6oQ+YTL4jqn/u
         3+nUh+DBaw5KxoCvNNIZpDkD8EmhIbyUUqmzhk1fycfwHW2YThQadxVKnZRTqsQfLDwz
         JK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604495; x=1707209295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYqm9+PdfliMcUPhu/XhOrYgIKmn3e//lFHUo82Q1J0=;
        b=kV0DKYaN49guPhdX+1pZXxQkh14qVzT+eT4oVPO21cttfNgHaLnvO12lqdrg/zyS26
         2ioH2PCe4LV0PUWXB4OLF2ApPPxlHOG6jWyGvLiwBwbt8AjzVhQjv8LxGGLDoBPTeDJ3
         pPaczNLMCs6DmBps1vbiH0j/tfzdehOJAxfP4zVEl2Ilo4AOOCc+GAm2RKWsk7oIxEsn
         O1WRvm8UcDp5Z5AJ6EZTselXxb03Y3rHcwmTIrrYMuCb6eTFohqlQjnYkfJfQ5aQ9HU+
         vQR/wGzS+RrH9FWHN/PESPnJV6/NK1ZffNWqZHQnkzNNdg8ZgwQYxG3xmHFAsZL3Nymt
         bjhQ==
X-Gm-Message-State: AOJu0YzoQNd6CYm19DNU5nLp+DxRe6lADM6J65bhVHMC7XxjbYy04Mnc
	JW8wbfkbSukdZMInSQCsAn3yUARK4Qg+5fN6/pVtywXpfFOWYl8Bt/i3Ypww3A==
X-Google-Smtp-Source: AGHT+IH71sIX/2pyKvffdPLMRveRZzkZyOEOtO+a5eNkPZVGWZQUlduVZZ+zglJ0uCa6g/1z9Tuwng==
X-Received: by 2002:a05:6808:1144:b0:3bd:c710:760 with SMTP id u4-20020a056808114400b003bdc7100760mr6316837oiu.51.1706604495567;
        Tue, 30 Jan 2024 00:48:15 -0800 (PST)
Received: from thinkpad ([117.202.188.6])
        by smtp.gmail.com with ESMTPSA id e7-20020aa79807000000b006da96503d9fsm7207700pfl.109.2024.01.30.00.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:48:15 -0800 (PST)
Date: Tue, 30 Jan 2024 14:18:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, vkoul@kernel.org,
	jingoohan1@gmail.com, conor+dt@kernel.org, konrad.dybcio@linaro.org,
	robh+dt@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 2/6] dmaengine: dw-edma: Introduce helpers for getting
 the eDMA/HDMA max channel count
Message-ID: <20240130084803.GA83288@thinkpad>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
 <CAA8EJprWHiShFpZdb+pWsCoxNvNEoP+3By2x4u8rq+ek37hJXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJprWHiShFpZdb+pWsCoxNvNEoP+3By2x4u8rq+ek37hJXw@mail.gmail.com>

On Fri, Jan 19, 2024 at 03:26:56PM +0200, Dmitry Baryshkov wrote:
> On Fri, 19 Jan 2024 at 15:00, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Add common helpers for getting the eDMA/HDMA max channel count.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c           | 18 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.c |  6 +++---
> >  include/linux/dma/edma.h                     | 14 ++++++++++++++
> >  3 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 7fe1c19..2bd6e43 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -902,6 +902,24 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >         return err;
> >  }
> >
> > +static u32 dw_edma_get_max_ch(enum dw_edma_map_format mf, enum dw_edma_dir dir)
> > +{
> > +       if (mf == EDMA_MF_HDMA_NATIVE)
> > +               return HDMA_MAX_NR_CH;
> 
> This will break unless patch 5 is applied.

I believe you are referring to patch 4.

> Please move the
> corresponding definition to this path.
>

Right. But it can be fixed by reordering the patches.

Mrinmay, please move patch 4/6 ahead of this one.

- Mani
 
-- 
மணிவண்ணன் சதாசிவம்

