Return-Path: <dmaengine+bounces-989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C284FAB1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E41C218F8
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750D7BAE4;
	Fri,  9 Feb 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/Ntb0GA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE6DD18;
	Fri,  9 Feb 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498634; cv=none; b=qIWDCNk4BJM14cIAZks0epRFB+I7z0jAJF+Yi/OzrSFJxIFRjH+imfjx7SESsFih/wbGlsc0hosQ+F0y7tjz5d1P2vJmT+b9bFiD4ybK7cJP8Ts69uTBlwVYsR/BdONA2L8Ia/2e9YDiwAxr2DGBf6hbq+PbeKJ59H+8O4Xn8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498634; c=relaxed/simple;
	bh=1DJyQGZWkyINk+0P2VsSNjoETpjN/mE2UKBByCakbuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QUdFuQXXx0oV0s4UARDZryBv8s0GSm54hMEbICMBL6PopFWdsVL+BEIT6enDcPOxFZ1MD4nf3hHvTu7IImAyCVZrJhXg35jHyO3lpBp/83BMh6Fzmxi1XHfl5skZ+C458d8oFhqEhLpWTp6ULvVEdFWBOEENG+sC6N2oEVkXRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/Ntb0GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2009C433F1;
	Fri,  9 Feb 2024 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498634;
	bh=1DJyQGZWkyINk+0P2VsSNjoETpjN/mE2UKBByCakbuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b/Ntb0GAdQuPhorZNPOqkKxNKtS8/IC3CPaCzUNDjuhbYzgUQQpN1nmdSRvATUagt
	 qR9FDSA7njDGtlOYo+Zr0LP43Yo+UHHd20nwenjRUDNlOxOJcwoh4KlYQ5IGHF6Vdu
	 niQeED7H47m8v8MBn/PUy5rKWUTsf6A1c1IKtB0fAm75YTEE+pqEhfcoe67FWUJlZN
	 FJlS+9EPDJKcR+ZnaskzZ3CYg7565Pehp9v35jt2ROMid1UdTUNQX0yBUEfpo5VObV
	 v86ez5zUEaMr2Ym5FD/N5JAAciRcNcGrxxCM3Kn+eU0e5awsgmKEyLUo5ltCbxn+NR
	 qlATClLOoxEzA==
Date: Fri, 9 Feb 2024 11:10:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, vkoul@kernel.org,
	jingoohan1@gmail.com, conor+dt@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 3/6] PCI: dwc: Add HDMA support
Message-ID: <20240209171032.GA1004885@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oa76ts3zqud7mtkpilbo4uub7gazqncnbh6rma26kaz6wt6fch@ufv672fgrcgj>

On Sat, Feb 03, 2024 at 12:40:39AM +0300, Serge Semin wrote:
> On Fri, Jan 19, 2024 at 06:30:19PM +0530, Mrinmay Sarkar wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> > Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
> > unrolled mapping format. So the platform drivers need to provide a valid
> > base address of the CSRs. Also, there is no standard way to auto detect
> > the number of available read/write channels in a platform. So the platform
> > drivers has to provide that information as well.
> ...

> Basically this change defines two versions of the eDMA info
> initialization procedure:
> 1. use pre-defined CSRs mapping format and amount of channels,
> 2. auto-detect CSRs mapping and the amount of channels.
> The second version also supports the optional CSRs mapping format
> detection procedure by means of the DW_PCIE_CAP_EDMA_UNROLL flag
> semantics. Thus should this patch is accepted there will be the
> functionality duplication. I suggest to make things a bit more
> flexible than that. Instead of creating the two types of the
> init-methods selectable based on the mapping format, let's split up
> the already available DW eDMA engine detection procedure into the next
> three stages:
> 1. initialize DW eDMA data,
> 2. auto-detect the CSRs mapping format,
> 3. auto-detect the amount of channels.
> and convert the later two to being optional. They will be skipped in case
> if the mapping format or the amount of channels have been pre-defined
> by the platform drivers. Thus we can keep the eDMA data init procedure
> more linear thus easier to read, drop redundant DW_PCIE_CAP_EDMA_UNROLL flag
> and use the new functionality for the Renesas R-Car S4-8's PCIe
> controller (for which the auto-detection didn't work), for HDMA with compat
> and _native_ CSRs mapping. See the attached patches for details:

I am still bound by the opinion of Google's legal team that I cannot
accept the code changes that were attached here.  I think it's fair to
read the review comments (thank you for those), but I suggest not
reading the patches that were attached.

Bjorn

