Return-Path: <dmaengine+bounces-9887-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePlNBPxK02mJgwcAu9opvQ
	(envelope-from <dmaengine+bounces-9887-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 07:56:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467E3A1AFA
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 066C93003807
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D09347505;
	Mon,  6 Apr 2026 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhj1Bufx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CB3090D7;
	Mon,  6 Apr 2026 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454968; cv=none; b=F8CEwgKHqLun5chyZmoZ4VBzdVYbjN1YFmfjAaBMKIgdYABiNLc8u8/L3XUdT01N7BkL7kZbnz3w77VWehvhIe6riALJqHEaThdtE7WsImdcoss6m0Pu/HGEO50FV82jR8ggSy2WeF/IOzGCRlEmqeGE+o8omDS4Ea2FjqQc41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454968; c=relaxed/simple;
	bh=/xUt41UrSz7pl19nBBW3JbuU0S9np7jbUn7CqqMLMAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3h6MGmC5uaY0n97KSSGuChLsaVU9Y5MGxMGprkXLCMSR0s2D9V9Pa9MwfJu1DtYAnLVaOzJjmVccZNUC2jbOD4e7ZP9UNdFfAiKIdeBdjLoTygBafitUrr9swtO+O4McMW64jSF6kaNsQWhRZ3OCZ5xNvB5R/eaAJ4Jc5CmEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhj1Bufx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00816C4CEF7;
	Mon,  6 Apr 2026 05:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775454968;
	bh=/xUt41UrSz7pl19nBBW3JbuU0S9np7jbUn7CqqMLMAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hhj1Bufxj0OFpcbIGCTf8fFci969OfYL77M38A8h+v8ZGcLQaqGxQENnDHHQKUEVq
	 XeSe7UUhaO4YlZ5bl/wA1Lo2ar/VX/V0iTx+VNjmmcVIFZ6ozPiC1OGzpKdGFKM777
	 lYcdmFgC/a5yf92do5n80pRWZHZl+uueiamUnTTU3zfUqGIodDvn8fKjQzECrNngkP
	 Ylk2MYpLSAinvzJWVepIGIqhRO5JbhfsRTrmbBwHNCi0YygLDgme5x4DvKHE532NIT
	 NoK3xqGXQJgTZcmOXeUsSMLmeiWrJelRgkYbf1FNUEOsKp2H1vgFlhbWrIEeHq/Og9
	 4ez3v6IY11KAw==
Date: Mon, 6 Apr 2026 11:26:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Khairul Anuar Romli <karom.9560@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
Message-ID: <adNK9Aoa_gKGMfTG@vaman>
References: <20260328025706.52722-1-karom.9560@gmail.com>
 <20260328025706.52722-2-karom.9560@gmail.com>
 <acqQTmr5ti8RWfnV@lizhi-Precision-Tower-5810>
 <46be45c0-ba15-47c4-b356-60a3d6491f6a@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46be45c0-ba15-47c4-b356-60a3d6491f6a@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9887-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,metafoo.de,kernel.org,vger.kernel.org,web.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9467E3A1AFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04-04-26, 23:20, Khairul Anuar Romli wrote:
> On 30/3/2026 11:01 pm, Frank Li wrote:
> > On Sat, Mar 28, 2026 at 10:56:55AM +0800, Khairul Anuar Romli wrote:
> > >      checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:
> > > 
> > >        CHECK: Alignment should match open parenthesis
> > > 
> > >      This warning occurs when multi-line function calls or expressions have
> > >      continuation lines that don't properly align with the opening
> > >      parenthesis position.
> > > 
> > >      Fixes all instances in dw-axi-dmac.c where continuation lines were
> > >      indented with an inconsistent number of spaces/tabs that neither
> > >      matched the parenthesis column nor followed a standard indent pattern.
> > >      Proper alignment improves code readability and maintainability by
> > >      making parameter lists visually consistent across the kernel codebase.
> > > 
> > > Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
> > > Fixes: e3923592f80b ("dmaengine: axi-dmac: populate residue info for completed xfers")
> > > Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
> > > Fixes: 921234e0c5d7 ("dmaengine: axi-dmac: Split too large segments")
> > > Fixes: a5b982af953b ("dmaengine: axi-dmac: add a check for devm_regmap_init_mmio")
> > 
> > This is code cleanup and not user visiual problem. I think needn't add
> > fixes tags here.
> > 
> 
> I can remove the fixes tags in the next revision.
> Thanks for pointing this out.

These kind of code formatting dont help much. These cause problems
porting fixes to stable. So I am not very inclined to take these

> 
> Best Regards,
> Khairul
> 
> > Frank
> > 
> > > Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
> > > ---
> > >   drivers/dma/dma-axi-dmac.c | 28 +++++++++++++++-------------
> > >   1 file changed, 15 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > index 45c2c8e4bc45..0017f4dc6dcc 100644
> > > --- a/drivers/dma/dma-axi-dmac.c
> > > +++ b/drivers/dma/dma-axi-dmac.c
> > > @@ -193,7 +193,7 @@ static struct axi_dmac_desc *to_axi_dmac_desc(struct virt_dma_desc *vdesc)
> > >   }
> > > 
> > >   static void axi_dmac_write(struct axi_dmac *axi_dmac, unsigned int reg,
> > > -	unsigned int val)
> > > +			   unsigned int val)
> > >   {
> > >   	writel(val, axi_dmac->base + reg);
> > >   }
> > > @@ -382,7 +382,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
> > >   }
> > > 
> > >   static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
> > > -	struct axi_dmac_sg *sg)
> > > +						   struct axi_dmac_sg *sg)
> > >   {
> > >   	if (chan->hw_2d)
> > >   		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
> > > @@ -437,7 +437,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
> > >   }
> > > 
> > >   static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
> > > -	struct axi_dmac_desc *active)
> > > +				     struct axi_dmac_desc *active)
> > >   {
> > >   	struct dmaengine_result *rslt = &active->vdesc.tx_result;
> > >   	unsigned int start = active->num_completed - 1;
> > > @@ -517,7 +517,7 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
> > >   }
> > > 
> > >   static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
> > > -	unsigned int completed_transfers)
> > > +				   unsigned int completed_transfers)
> > >   {
> > >   	struct axi_dmac_desc *active;
> > >   	struct axi_dmac_sg *sg;
> > > @@ -667,7 +667,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > >   	desc->chan = chan;
> > > 
> > >   	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > > -				&hw_phys, GFP_ATOMIC);
> > > +				 &hw_phys, GFP_ATOMIC);
> > >   	if (!hws) {
> > >   		kfree(desc);
> > >   		return NULL;
> > > @@ -703,9 +703,11 @@ static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > >   }
> > > 
> > >   static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > > -	enum dma_transfer_direction direction, dma_addr_t addr,
> > > -	unsigned int num_periods, unsigned int period_len,
> > > -	struct axi_dmac_sg *sg)
> > > +						   enum dma_transfer_direction direction,
> > > +						   dma_addr_t addr,
> > > +						   unsigned int num_periods,
> > > +						   unsigned int period_len,
> > > +						   struct axi_dmac_sg *sg)
> > >   {
> > >   	unsigned int num_segments, i;
> > >   	unsigned int segment_size;
> > > @@ -817,7 +819,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
> > >   		}
> > > 
> > >   		dsg = axi_dmac_fill_linear_sg(chan, direction, sg_dma_address(sg), 1,
> > > -			sg_dma_len(sg), dsg);
> > > +					      sg_dma_len(sg), dsg);
> > >   	}
> > > 
> > >   	desc->cyclic = false;
> > > @@ -857,7 +859,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
> > >   	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
> > > 
> > >   	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
> > > -		period_len, desc->sg);
> > > +				period_len, desc->sg);
> > > 
> > >   	desc->cyclic = true;
> > > 
> > > @@ -1006,7 +1008,7 @@ static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
> > >    * features are implemented and how it should behave.
> > >    */
> > >   static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
> > > -	struct axi_dmac_chan *chan)
> > > +				  struct axi_dmac_chan *chan)
> > >   {
> > >   	u32 val;
> > >   	int ret;
> > > @@ -1295,7 +1297,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >   		return ret;
> > > 
> > >   	ret = of_dma_controller_register(pdev->dev.of_node,
> > > -		of_dma_xlate_by_chan_id, dma_dev);
> > > +					 of_dma_xlate_by_chan_id, dma_dev);
> > >   	if (ret)
> > >   		return ret;
> > > 
> > > @@ -1310,7 +1312,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >   		return ret;
> > > 
> > >   	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
> > > -		 &axi_dmac_regmap_config);
> > > +				       &axi_dmac_regmap_config);
> > > 
> > >   	return PTR_ERR_OR_ZERO(regmap);
> > >   }
> > > --
> > > 2.43.0
> > > 

-- 
~Vinod

