Return-Path: <dmaengine+bounces-3376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179919A0060
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 06:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67571F25E0C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05FB18A6B8;
	Wed, 16 Oct 2024 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cINXcgBH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CED189F57;
	Wed, 16 Oct 2024 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054615; cv=none; b=nz2WMldWbwyZz3XySsobPsCJPlL/1+g4jQDNVI0dBAI5QtfDm8BqWgmn5HeiJRmB931iADjZaGDFMOVvjWtdcUFkDZQ7REp9Mxq0PKoOr3RzeqqYIK2UsIf8/SHeZBI+DgodfQZrCfu04yg8h3VehANjeMHCYBgdPx7FeUX7zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054615; c=relaxed/simple;
	bh=wj4cIxs+tZA29hqkjcBUsro7NGxLsN9hei0/lnBpqrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir7RFSv4lFYnog1quUcfBIOOpyJWpnyfh7vW/303VIGGrQhe6Ju3gNem9IwCYSk+LSNQA+guAZd958rcQpPzJMNy5shbKnl3A1U4jd2iiIVGE+GUf9SPP7idLplyKwkEeY6Ej+QoexCOS0FBUsKi0aZ3h9f+FnDntNrph4hIMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cINXcgBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9621EC4CEC5;
	Wed, 16 Oct 2024 04:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729054615;
	bh=wj4cIxs+tZA29hqkjcBUsro7NGxLsN9hei0/lnBpqrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cINXcgBH0zhFdguWrEgq/pkBpHyUCnxxTCdrFi7ovG1V3Aarc8UErxybywDCMG8XB
	 RkNN4SaJ8RdxQI+zdaLU6F6NolnvnuOqVUPgoR13vW95LBVbEaBiQoEmev0fsWb3+n
	 svP57G1Sumrm30XOJQcZd4f+hqAXLByLdezlK8zl0g+4pdK0kLRTkFYqIRVgfrL32l
	 mmtSQcsLwKn7pZqVwhvp1gw62Dy3OHcWP7+Q3p8WL8V0l5M5Sb1e46ubk/OOli5F2F
	 YGmtF6SN5mKVjd0WixAv8gLByMF1L6N/AN5lkU1cCYEMeUjx3GMz6TECMk/3cRrmPt
	 yjWfnS3YfI1Ng==
Date: Wed, 16 Oct 2024 10:26:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?B?5ZSQ5pil5pyJ?= <tangchunyou@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	fancer.lancer@gmail.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dma/dw-edma: chip regs base should add the offset
Message-ID: <Zw9Hkv9y92GErmhZ@vaman>
References: <20241014134832.4505-1-tangchunyou@163.com>
 <20241015053608.h2avloxfak5yagyd@thinkpad>
 <7100a983.a923.1928fc86b23.Coremail.tangchunyou@163.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7100a983.a923.1928fc86b23.Coremail.tangchunyou@163.com>

On 15-10-24, 18:45, 唐春有 wrote:
> hi Mani:
> 
> sorry, I am a novice in submitting patches. Do you think my modifications meet the requirements? If not, please help point out the problem, preferably with an example. Thank you!

Please do NOT top post
> 
> I had modify it in the attachment.

Please read again the Documentation/process/development-process.rst on
how to follow up on comments and post an update and how to describe your
changes

> 
> 
> 
> 
> chunyou
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2024-10-15 13:36:08, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >On Mon, Oct 14, 2024 at 09:48:32PM +0800, ChunyouTang wrote:
> >> From: tangchunyou <tangchunyou@163.com>
> >> 
> >> fix the regs base with offset.
> >> 
> >
> >Initially I thought that this patch is a spam, but it is not. It is indeed
> >fixing a real bug in the driver. But the subject and description made it look
> >like a spam. Please follow the process defined in:
> >Documentation/process/5.Posting.rst to send the patches.
> >
> >Essentially you need to properly describe what the patch does and how it impacts
> >the driver etc... Then there needs to be a valid 'Fixes' tag and stable list
> >should be CCed to backport to stable kernels.
> >
> >- Mani
> >
> >> Signed-off-by: tangchunyou <tangchunyou@163.com>
> >> ---
> >>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> >> index 1c6043751dc9..2918b64708f9 100644
> >> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> >> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> >> @@ -234,6 +234,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >>  	if (!chip->reg_base)
> >>  		return -ENOMEM;
> >>  
> >> +	chip->reg_base += vsec_data.rg.off;
> >> +
> >>  	for (i = 0; i < chip->ll_wr_cnt; i++) {
> >>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> >>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> >> -- 
> >> 2.25.1
> >> 
> >
> >-- 
> >மணிவண்ணன் சதாசிவம்



-- 
~Vinod

