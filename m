Return-Path: <dmaengine+bounces-1000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C2850B41
	for <lists+dmaengine@lfdr.de>; Sun, 11 Feb 2024 20:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B5B1F2377D
	for <lists+dmaengine@lfdr.de>; Sun, 11 Feb 2024 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C75DF18;
	Sun, 11 Feb 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufi4CXf9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4C5D91B;
	Sun, 11 Feb 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680271; cv=none; b=EfHtLbeT+hft419hn1z2lO3m5TM7BA11ABAc7zsF9zVP8Z/yQA26aId+UanDoG1zoHsLL/3PI2q+qAvHp1GxBfduWq5XV7DFz57f2BY+lyCUptxHpWFgd4VlUUANj6OGGYJxhbcBITTrTaGTRnr7o63jGPtGIbTT8FfxdsspwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680271; c=relaxed/simple;
	bh=W+D81AmCL8agIL4L/iH7lZFAZ18DpRcOvjfXxroME6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwfwocAyQkrTL9bFGgJONcZJyE4dC+YZlDIsdcFQRiWyD2yRUnHDa/FX46lJ/PelIvPT9hrdzSRbvLL+/HfAXtm7YdTJUpK88LwGDPDuHK8XMwUO/wHxK4tHlTo36Jk4e0XU8OLwHd9yMOMYy1phUEvErOOX734m6cDkQngJDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufi4CXf9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so37596561fa.1;
        Sun, 11 Feb 2024 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707680267; x=1708285067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8v2iNNcXg9C0tqhxZKMU6R0PA9fchNVtiDqsgf4S1g=;
        b=Ufi4CXf9TNrCb3MoDrJJ+3xmPKWvA69mqnqdBR+5XRFMoBtyibNkOWWgg5pr+bRWoW
         0pabQjW/WXuym+mfFOu2NFWlJxIkrtBFcJTIhlPBK0BjWh/+5CyfUae99x6XIqK+cEde
         txSAOV9e9jGah6BZqZmrlh4XEzrsF0I2B0hRdDCvoiz2wtJqrxhwAzlKoVUOp1qOIr5A
         KDw9kns5n7Lo+WpNe/Ew2S7zatx519ayTXBRCBGAiH+I0Uf2vAEixqyfB5dxWsSQjdZS
         A1NXqRQ9V3DBLbx58slCWq8SI/M3PtC/s4U7+GtGLxFWNUZYLnyXNbPpaHwUgtQPTSkA
         bVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707680267; x=1708285067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8v2iNNcXg9C0tqhxZKMU6R0PA9fchNVtiDqsgf4S1g=;
        b=PYxP0sxExgi2kOp8p+KFjg/doCjs817YcSTNP1vvt6+LZGk+COUGzXi9WWdLnUxyEi
         mnrUlfTqqOnKUReA4Zq/2ETtfYJrcOqIVKUiOjPD3W5TKpF1m2bBIj4vhy1r4bAWt1yU
         GD+5y0vSLQRYmtntZMbODzQZAwGp0v240DCPZH+hLuU6RAfFU4ewzOX1ZypKIBhye5OI
         AgPWXOa2oQ3cuSZ9uRHSkehB0omv1pHR8zrtDsPZvHSEDkn1xdQFcmpVifBri+2FBcrg
         xtJyOEApVkWXHjWWFae0fkI4sfKpiWzHEMTd56rycMliVXDqs5z8wvvRga2p5O4wlvRp
         muJg==
X-Gm-Message-State: AOJu0Yw9tL2sBJJleRUGpDgyHBz4QBveb6dDZ9GNL7KesGdsULsMwy+/
	pWR1MywD0Gptc84nlR29QwdjddCXpy8ouKxg8X//cJnw2U2h6elK
X-Google-Smtp-Source: AGHT+IE30xox9EwbJIoEIZgckCD1IwXsG3IG07OQ7abrd6N4GEDxV/ymbMUeh5b3Q4juMI5yVaWO+A==
X-Received: by 2002:a2e:3c05:0:b0:2d0:af6e:3d17 with SMTP id j5-20020a2e3c05000000b002d0af6e3d17mr2937949lja.39.1707680267021;
        Sun, 11 Feb 2024 11:37:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+oN0J1wjcvwCY8fGvVDN6HujzSHwnj40efaR2DPlQSYjk6uygfSe/c8vU0k3pEnGiLA7rZylLpULQ8v9dYjY0rqiEe678RpEzs/npGFfzf+ZdBm0feyqmVaLvPM3pFDBB/WGL0VtTXR+7M/ErpMyPgqpU2Fxewz3CssL50AxneF9PZon6bJBG/wZAKMeX0LlOodNsOJodaqvq6lyERM1/RJsF7hePsJpVxQgooDtfBpXAnNlwl8at5C9FEfkQuDsjniZCi5B0onVUC9JNawbDmd9NGs++7DA1bN4j5btB/8l6L0oGv7Wr31fATwlrPqN5MmlJs++WgaCeNDMUemzQA7sT57WNP51YtKtu85TVDjAT3Pb8CODkw2WDostffkQeheTKonl7bgXr7+qXuwoKrc+Tx0W2wX/0C8dsFz1btHYYwATH14paibFnYD7yN0lkHlFfhGMH4a7VYdY1DekFsbQKsyv321S3yfYoJGLzVca/NADXwxgDoPmNNXi6eX+s6Oo6Qoe33jssL8qhBZeB1uPDYwl577uK3bJRsYiZdjXIl6a6Dlb55CXVgdpcyWdQgW/MfLnful1IPVWV1CVG6JT51v8uUBugnWuD+0R83ugj7jqpDRy8SOdC6G+9kGv0VMdC/xeBT/AB+DO4zAYFpMTOFgFJOFPqhHDjIURut0UkYgHTjwCMthRxowFGvUjfu/I1+kD7ihOhpKdrBwuKYJrpOhLTRQB1Si2OAJq4nf/t6Qx4ebBIXO9K9ZLiQ8KGpAvA4fFNP7LOfpG8hjvtjWVuAGppL7yqu/wM4QyI2Ce7qd4ghwOOqQv2Mlu/x+xn/EPGYawqHG9woo3NeMZXv3pISDF17NZrcyCEDMXnDkdJKZCAe1dqzKvU9hKSrPnSuCruePl/+MAr4YVtdZh1blxvMD3+YQd3fGoaIWEtrqodPfcUqzQoWvAXRXVXex53Cv
 L3Wp2gsBZJM8Pjy+XAbkOd2wM=
Received: from mobilestation ([95.79.164.159])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c008d00b002d0c639e0cesm1054579ljq.6.2024.02.11.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 11:37:46 -0800 (PST)
Date: Sun, 11 Feb 2024 22:37:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Mrinmay Sarkar <quic_msarkar@quicinc.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, vkoul@kernel.org, 
	jingoohan1@gmail.com, conor+dt@kernel.org, konrad.dybcio@linaro.org, 
	robh+dt@kernel.org, quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, quic_parass@quicinc.com, 
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v1 3/6] PCI: dwc: Add HDMA support
Message-ID: <qppxhhlbjqmop2vmaa6b5zjesgry75hapllokcmllgfwti4tbo@55aeewwp23cq>
References: <oa76ts3zqud7mtkpilbo4uub7gazqncnbh6rma26kaz6wt6fch@ufv672fgrcgj>
 <20240209171032.GA1004885@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209171032.GA1004885@bhelgaas>

On Fri, Feb 09, 2024 at 11:10:32AM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 03, 2024 at 12:40:39AM +0300, Serge Semin wrote:
> > On Fri, Jan 19, 2024 at 06:30:19PM +0530, Mrinmay Sarkar wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> > > Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
> > > unrolled mapping format. So the platform drivers need to provide a valid
> > > base address of the CSRs. Also, there is no standard way to auto detect
> > > the number of available read/write channels in a platform. So the platform
> > > drivers has to provide that information as well.
> > ...
> 
> > Basically this change defines two versions of the eDMA info
> > initialization procedure:
> > 1. use pre-defined CSRs mapping format and amount of channels,
> > 2. auto-detect CSRs mapping and the amount of channels.
> > The second version also supports the optional CSRs mapping format
> > detection procedure by means of the DW_PCIE_CAP_EDMA_UNROLL flag
> > semantics. Thus should this patch is accepted there will be the
> > functionality duplication. I suggest to make things a bit more
> > flexible than that. Instead of creating the two types of the
> > init-methods selectable based on the mapping format, let's split up
> > the already available DW eDMA engine detection procedure into the next
> > three stages:
> > 1. initialize DW eDMA data,
> > 2. auto-detect the CSRs mapping format,
> > 3. auto-detect the amount of channels.
> > and convert the later two to being optional. They will be skipped in case
> > if the mapping format or the amount of channels have been pre-defined
> > by the platform drivers. Thus we can keep the eDMA data init procedure
> > more linear thus easier to read, drop redundant DW_PCIE_CAP_EDMA_UNROLL flag
> > and use the new functionality for the Renesas R-Car S4-8's PCIe
> > controller (for which the auto-detection didn't work), for HDMA with compat
> > and _native_ CSRs mapping. See the attached patches for details:
> 
> I am still bound by the opinion of Google's legal team that I cannot
> accept the code changes that were attached here.  I think it's fair to
> read the review comments (thank you for those), but I suggest not
> reading the patches that were attached.

Em, the review comment and the resultant patches were my own private
researches and developments. Is Google now blocking even individual
contributors?

In anyway if you are agree with the changes suggested above you can
set to the patches any author you think would be acceptable. My only
concern was to maintain the cleanness of the driver code developed by
me and which is going to be affected in the framework of this series.

-Serge(y)

> 
> Bjorn

