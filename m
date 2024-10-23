Return-Path: <dmaengine+bounces-3417-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E332E9ABE6C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5D1F22BFF
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9E13775E;
	Wed, 23 Oct 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8b+RaVF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CDEAC5
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663773; cv=none; b=PFuhnNLJxBbVj7Vywhl3VGWNKg5h/bK23kJbP2hrDBl90r3DxlkN6vihU/ucFW4N1t5TGGSMYAISIx/GE1wfpWDXNkTGSBAXc5ePvodM4F+eqx6fqRaAtb2EKSbMtYtUnq98FhF2CLq2vzX1AGGO527Z/dcaHedqlQnDggxmBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663773; c=relaxed/simple;
	bh=0SUZ8/TKHGHWmNcyxBGnhV132WQCz8OEveZqNDPwWlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUwPq1alDvvyhXUn6mfigatXO0e8stDjHrBEoMFRT/acuCMI+Q4vDTz3A/8lnHrtAowR8uYGmv5/R4Fsm6bGbZQ+fIf7O+tLv5hRnFKWSoS9ww23SfJIE6G0tOrRkDtFLMdPa4otzLufqrjWEXQA5o3oummnfROwEy+ALltf1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8b+RaVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC00BC4CEC6;
	Wed, 23 Oct 2024 06:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729663773;
	bh=0SUZ8/TKHGHWmNcyxBGnhV132WQCz8OEveZqNDPwWlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8b+RaVFaqhR1307Adqxg/5SsaI3Xwf7wRONp0Mo4Etg+7p9TievMy5MCa06BMLhn
	 0+JhEBkcWl3PBYmxeZhL4vCUvofAeMhTbScV+6u4Tjt+i8wc4cRSAhE5xt+E+aqlgV
	 hlxzqsiL3AiqzBSYXwkWgpWBRt3XPfxFUwdwQcGAglmiod3fBN50y5PYsHlykxwl8K
	 QhhBF4ILAivMxI8BJIUNw9Bt6ggsgw/TfEQOnEZaNZNpepHeJFaxxaBKAVxk1xWiGz
	 U88XWEWT5CFwJIzUTtIhWxRudCiTGSzYnt+uGPDlZAT2YKfOjOxJCN2UjRZNZuB3Nx
	 rI1UTO+zPtUMw==
Date: Wed, 23 Oct 2024 11:39:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v6 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <ZxiTGXxqHtYiTW0O@vaman>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
 <20240909123941.794563-5-Basavaraj.Natikar@amd.com>
 <ZxaQMP8b0Dfk96aa@vaman>
 <549a5919-117a-d96f-a00b-391ed142dc91@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549a5919-117a-d96f-a00b-391ed142dc91@amd.com>

On 22-10-24, 10:53, Basavaraj Natikar wrote:
> 
> On 10/21/2024 11:02 PM, Vinod Koul wrote:
> > On 09-09-24, 18:09, Basavaraj Natikar wrote:
> > > Use the pt_dmaengine_register function to register a AE4DMA DMA engine.
> > > 
> > > Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> > > Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> > > Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > > ---
> > >   drivers/dma/amd/ae4dma/ae4dma-dev.c     |  51 +----------
> > >   drivers/dma/amd/ae4dma/ae4dma-pci.c     |   1 +
> > >   drivers/dma/amd/ae4dma/ae4dma.h         |   3 +
> > >   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 114 +++++++++++++++++++++++-
> > >   drivers/dma/amd/ptdma/ptdma.h           |   3 +
> > >   5 files changed, 123 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> > > index f0b3a3763adc..cd84b502265e 100644
> > > --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
> > > +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> > > @@ -14,53 +14,6 @@ static unsigned int max_hw_q = 1;
> > >   module_param(max_hw_q, uint, 0444);
> > >   MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
> > > -static char *ae4_error_codes[] = {
> > > -	"",
> > > -	"ERR 01: INVALID HEADER DW0",
> > > -	"ERR 02: INVALID STATUS",
> > > -	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> > > -	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> > > -	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> > > -	"ERR 06: INVALID ALIGNMENT",
> > > -	"ERR 07: INVALID DESCRIPTOR",
> > > -};
> > > -
> > > -static void ae4_log_error(struct pt_device *d, int e)
> > > -{
> > > -	/* ERR 01 - 07 represents Invalid AE4 errors */
> > > -	if (e <= 7)
> > > -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> > > -	/* ERR 08 - 15 represents Invalid Descriptor errors */
> > > -	else if (e > 7 && e <= 15)
> > > -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> > > -	/* ERR 16 - 31 represents Firmware errors */
> > > -	else if (e > 15 && e <= 31)
> > > -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
> > > -	/* ERR 32 - 63 represents Fatal errors */
> > > -	else if (e > 31 && e <= 63)
> > > -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
> > > -	/* ERR 64 - 255 represents PTE errors */
> > > -	else if (e > 63 && e <= 255)
> > > -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> > > -	else
> > > -		dev_info(d->dev, "Unknown AE4DMA error");
> > > -}
> > > -
> > > -static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> > > -{
> > > -	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> > > -	struct ae4dma_desc desc;
> > > -	u8 status;
> > > -
> > > -	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> > > -	status = desc.dw1.status;
> > > -	if (status && status != AE4_DESC_COMPLETED) {
> > > -		cmd_q->cmd_error = desc.dw1.err_code;
> > > -		if (cmd_q->cmd_error)
> > > -			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> > > -	}
> > > -}
> > why is this getting moved?
> 
> To avoid circular dependency between PTDMA and AE4DMA, we are reusing PTDMA code to prevent
> duplication, as AE4DMA depends on PTDMA.

Okay please move the code first and then do changes, that makes it easier to
review and follow

-- 
~Vinod

