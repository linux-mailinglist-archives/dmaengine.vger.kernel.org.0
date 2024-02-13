Return-Path: <dmaengine+bounces-1005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FF852A51
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690AAB22A3F
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DD1775E;
	Tue, 13 Feb 2024 07:53:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92117743;
	Tue, 13 Feb 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810800; cv=none; b=Noss5BMsnFlJjNnyYLv1W3ADUXNdpb/bnbjPljDBLhpQz5BtdgeSG+XrU+bBpILrkaAgvnyYnqG0z8sxYgZMOXzTPxIr4PxZbROD/PtWoIy92hnbc4Y7Egm86y4lRvkSdvEefLCynEPRgx8KsToEZeX5VcRefuzfkx0DLwRRheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810800; c=relaxed/simple;
	bh=h2mcc3tinXFTTUlzRS/uHQRAwxsDtAwyOZUFiyrUldQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flBgj2nXH8WZopqddbBcqJI2VGjaYqyaGGOWCH5EH30oTgssBpzC4Uo8piLsPEnAlNQS59K9zihPmm2oWp2cMNSu4QuQKfQc78NLazn8btCaPBFUjNuHnzuYXx/SNRZxctX2+n6ZVUajaQiFXmjj7hPPK/JnSryuPVl13PHtSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F0C433C7;
	Tue, 13 Feb 2024 07:53:10 +0000 (UTC)
Date: Tue, 13 Feb 2024 13:23:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>, vkoul@kernel.org,
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
Subject: Re: [PATCH v1 3/6] PCI: dwc: Add HDMA support
Message-ID: <20240213075232.GA5067@thinkpad>
References: <oa76ts3zqud7mtkpilbo4uub7gazqncnbh6rma26kaz6wt6fch@ufv672fgrcgj>
 <20240209171032.GA1004885@bhelgaas>
 <qppxhhlbjqmop2vmaa6b5zjesgry75hapllokcmllgfwti4tbo@55aeewwp23cq>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qppxhhlbjqmop2vmaa6b5zjesgry75hapllokcmllgfwti4tbo@55aeewwp23cq>

On Sun, Feb 11, 2024 at 10:37:43PM +0300, Serge Semin wrote:
> On Fri, Feb 09, 2024 at 11:10:32AM -0600, Bjorn Helgaas wrote:
> > On Sat, Feb 03, 2024 at 12:40:39AM +0300, Serge Semin wrote:
> > > On Fri, Jan 19, 2024 at 06:30:19PM +0530, Mrinmay Sarkar wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> > > > Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
> > > > unrolled mapping format. So the platform drivers need to provide a valid
> > > > base address of the CSRs. Also, there is no standard way to auto detect
> > > > the number of available read/write channels in a platform. So the platform
> > > > drivers has to provide that information as well.
> > > ...
> > 
> > > Basically this change defines two versions of the eDMA info
> > > initialization procedure:
> > > 1. use pre-defined CSRs mapping format and amount of channels,
> > > 2. auto-detect CSRs mapping and the amount of channels.
> > > The second version also supports the optional CSRs mapping format
> > > detection procedure by means of the DW_PCIE_CAP_EDMA_UNROLL flag
> > > semantics. Thus should this patch is accepted there will be the
> > > functionality duplication. I suggest to make things a bit more
> > > flexible than that. Instead of creating the two types of the
> > > init-methods selectable based on the mapping format, let's split up
> > > the already available DW eDMA engine detection procedure into the next
> > > three stages:
> > > 1. initialize DW eDMA data,
> > > 2. auto-detect the CSRs mapping format,
> > > 3. auto-detect the amount of channels.
> > > and convert the later two to being optional. They will be skipped in case
> > > if the mapping format or the amount of channels have been pre-defined
> > > by the platform drivers. Thus we can keep the eDMA data init procedure
> > > more linear thus easier to read, drop redundant DW_PCIE_CAP_EDMA_UNROLL flag
> > > and use the new functionality for the Renesas R-Car S4-8's PCIe
> > > controller (for which the auto-detection didn't work), for HDMA with compat
> > > and _native_ CSRs mapping. See the attached patches for details:
> > 
> > I am still bound by the opinion of Google's legal team that I cannot
> > accept the code changes that were attached here.  I think it's fair to
> > read the review comments (thank you for those), but I suggest not
> > reading the patches that were attached.
> 
> Em, the review comment and the resultant patches were my own private
> researches and developments. Is Google now blocking even individual
> contributors?
> 
> In anyway if you are agree with the changes suggested above you can
> set to the patches any author you think would be acceptable. My only
> concern was to maintain the cleanness of the driver code developed by
> me and which is going to be affected in the framework of this series.
> 

I take the patch authorship seriously, so I won't change the author of your
patches. Instead, I'll just create my own patches based on your comments above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

