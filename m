Return-Path: <dmaengine+bounces-891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35F84207C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4971C27001
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915860DDE;
	Tue, 30 Jan 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CDFsoy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD660BB1;
	Tue, 30 Jan 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608862; cv=none; b=QgepeJoyJDnxnNoR9saeXruoMcSPc4naXjH1Kv/7Auih5hyIPr1c7TGxqmK0Cf0DSSpybTWH11wXZYt2losli6qcKoko7Lbdz2gcqP72NqnaOrvRDv2C3bXJn0HkLW9U3gSF+UmCAxqMF0FrzRPxwbmG/NjRwZlAOiedGQ9JHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608862; c=relaxed/simple;
	bh=hKlCC6YUzxSXpDs5Zn6rvnAxPGMT1RzEP6h13cQWdtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhmcjg7ZpowBFYZSaOncL0O1tmZbz/m7iUyvFOCr9K49ACda/PerMEI2PMLKmBNVhmgZYgSAAAVf3evq5yw3H/QMFwcUNBp4clNSfOEcFwur8ZrLSRD0PisiXM7LUphpMhrX0yDrEs1y2dxQnCRWQC/dqCLWcGFOyma2xx+IgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CDFsoy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5111ef545bfso395136e87.1;
        Tue, 30 Jan 2024 02:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706608858; x=1707213658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyIC+0v2XinIiBdeUWjmL9g3EZvpHlLY+6DNNfN27Qo=;
        b=h6CDFsoythXGKZzCnWTlYLTpxWyrs37rJgy6EksQUWMsXGnRG81GkPfwF5gAFMZW0Z
         9ZBDhNQ4r034TPh8yLvw+ou0uK/D6+eOFZgyt/grGeFCelvMF+ULE6DpmxDe8FQJc8Kj
         IDgUaCByfCJhmY80opThCwtuZNFm/uRVBhBsNJqvHFnF+ktjKZDk/5hauue6z0TDmr8P
         jKfaIvsfK50XAL/f4g7qQE/QHcZ+EN7420KQBlZJ6uC4m4++Qtpmvlc7btOLNyDI+D+n
         neXvabIOOzOUgecLuZwwRD0jjgWBV50J6i3mR+pfWHmrKoNRPzw8z6DP+icKkNrQyn0r
         t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608858; x=1707213658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyIC+0v2XinIiBdeUWjmL9g3EZvpHlLY+6DNNfN27Qo=;
        b=s0grjjLtgCN/enGqUvRogU6BVdSxfdczkPIolHzBj+gTKHLJcXDPL/PDEd41jG6/FR
         cWwAgoNMyn/z3qXKa7mUUTmNmCTBPh3Z7gaOLZTrKGxDD/OhOaNpklbZsrK2yNJEWve3
         uLU1Ig/E9K0di3HghbqPPjUb55dflaAboE0fw7JvtJtGXlNpIPfR7IsMIGsnbqBROLpe
         /6c7EHC3Yj3zYlXIWn9wnle0XphzRt5nPxzakcPAu5ma6NGmosybVdEWHN499Op0jWtO
         B8e1yvSAVcscfgd2l3IcISrHnPNTH3qdwq8gwJfU+D7SBTrUYq9g1iYL608gsuuYEknl
         4lYg==
X-Gm-Message-State: AOJu0YzslbWJtdSrC+Mv+KRgbi9si2tiwbyHvmOdtwC5dYNwtEYYZ0RX
	jd+vhNG3zSC9UZQmez1g3CLQOQRn9gSSP9FkTWrvnKm/+pkx1hMN
X-Google-Smtp-Source: AGHT+IGmJxgGMmmaVLREQN6NVgyEYuTQSRRLERxVVt5MueMLM0D2kw3IvlV1xef3VoXvP3q+2nMlrQ==
X-Received: by 2002:a05:6512:138c:b0:50e:3e4a:f248 with SMTP id fc12-20020a056512138c00b0050e3e4af248mr6224744lfb.3.1706608857449;
        Tue, 30 Jan 2024 02:00:57 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y8-20020ac24208000000b0051010608804sm1390457lfh.65.2024.01.30.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:00:56 -0800 (PST)
Date: Tue, 30 Jan 2024 13:00:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com, quic_schintav@quicinc.com, 
	quic_shijjose@quicinc.com, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v1 0/6] Add Change to integrate HDMA with dwc ep driver
Message-ID: <yfnvs3l5t7ggvdj2ebrwg7zmrn3r3su3t2xbvcfkwhb2q4sajv@ya3urqlwpzt7>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>

Hi Mrinmay

On Fri, Jan 19, 2024 at 06:30:16PM +0530, Mrinmay Sarkar wrote:
> Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
> unrolled mapping format. This patch series is to integrate HDMA with
> dwc ep driver.
> 
> Add change to provide a valid base address of the CSRs from the
> platform driver and also provides read/write channels count from
> platform driver since there is no standard way to auto detect the
> number of available read/write channels in a platform and set the
> mapping format in platform driver for HDMA.
> 
> This series passes 'struct dw_edma_chip' to irq_vector() as it needs
> to access that particular structure and fix to get the eDMA/HDMA
> max channel count. Also move the HDMA max channel definition to edma.h
> to maintain uniformity with eDMA.

Thanks for the patchset. I'll have a look at it later on this
week or early on the next one. If you wish you can resubmit it by then
with the Dmitry' and Mani' notes fixed.

-Serge(y)

> 
> Dependency
> ----------
> Depends on:
> https://lore.kernel.org/dmaengine/20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com/
> https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/
> 
> Manivannan Sadhasivam (4):
>   dmaengine: dw-edma: Pass 'struct dw_edma_chip' to irq_vector()
>   dmaengine: dw-edma: Introduce helpers for getting the eDMA/HDMA max
>     channel count
>   PCI: dwc: Add HDMA support
>   dmaengine: dw-edma: Move HDMA_V0_MAX_NR_CH definition to edma.h
> 
> Mrinmay Sarkar (2):
>   PCI: qcom-ep: Provide number of read/write channel for HDMA
>   PCI: epf-mhi: Add flag to enable HDMA for SA8775P
> 
>  drivers/dma/dw-edma/dw-edma-core.c           | 29 ++++++++++---
>  drivers/dma/dw-edma/dw-edma-pcie.c           |  4 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        |  4 +-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        |  3 +-
>  drivers/pci/controller/dwc/pcie-designware.c | 63 ++++++++++++++++++++++------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c    | 19 ++++++++-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
>  include/linux/dma/edma.h                     | 18 +++++++-
>  8 files changed, 115 insertions(+), 26 deletions(-)
> 
> -- 
> 2.7.4
> 

