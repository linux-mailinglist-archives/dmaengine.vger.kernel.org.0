Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6620E542
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391294AbgF2Vez (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgF2Skz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:55 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5570023730;
        Mon, 29 Jun 2020 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593424490;
        bh=d9CswmNYtUVd7rQ5C33DkmLgs5/8ixaRznCpZfb770M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdiiVUtr2B4Jn/9WPFpFAjzyjBo7eHShwryL9SW0kTb3828GO77StQ5Zi+Zm7eE3V
         kf8sKV1rJsy9nfLP6HOhMssH6ECWJxEaAJyaTyqhAVNiVq4YbMPrhqKE1ujbLkvV6n
         iA2v1je6E1s66VQQkcWcFy8DDb6uFDKPHRat6hc4=
Date:   Mon, 29 Jun 2020 15:24:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Amit Singh Tomar <amittomer25@gmail.com>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200629095446.GH2599@vkoul-mobl>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
 <20200624061529.GF2324254@vkoul-mobl>
 <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75d154d0-2962-99e6-a7c7-bf0928ec8b2a@arm.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-20, 10:35, André Przywara wrote:
> On 24/06/2020 07:15, Vinod Koul wrote:
> > On 09-06-20, 15:47, Amit Singh Tomar wrote:
> > 
> >> @@ -372,6 +383,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> >>  				  struct dma_slave_config *sconfig,
> >>  				  bool is_cyclic)
> >>  {
> >> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
> >>  	u32 mode, ctrlb;
> >>  
> >>  	mode = OWL_DMA_MODE_PW(0);
> >> @@ -427,14 +439,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> >>  	lli->hw[OWL_DMADESC_DADDR] = dst;
> >>  	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
> >>  	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> >> -	/*
> >> -	 * Word starts from offset 0xC is shared between frame length
> >> -	 * (max frame length is 1MB) and frame count, where first 20
> >> -	 * bits are for frame length and rest of 12 bits are for frame
> >> -	 * count.
> >> -	 */
> >> -	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> >> -	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
> >> +
> >> +	if (od->devid == S700_DMA) {
> >> +		/* Max frame length is 1MB */
> >> +		lli->hw[OWL_DMADESC_FLEN] = len;
> >> +		/*
> >> +		 * On S700, word starts from offset 0x1C is shared between
> >> +		 * frame count and ctrlb, where first 12 bits are for frame
> >> +		 * count and rest of 20 bits are for ctrlb.
> >> +		 */
> >> +		lli->hw[OWL_DMADESC_CTRLB] = FCNT_VAL | ctrlb;
> >> +	} else {
> >> +		/*
> >> +		 * On S900, word starts from offset 0xC is shared between
> >> +		 * frame length (max frame length is 1MB) and frame count,
> >> +		 * where first 20 bits are for frame length and rest of
> >> +		 * 12 bits are for frame count.
> >> +		 */
> >> +		lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> >> +		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
> > 
> > Unfortunately this wont scale, we will keep adding new conditions for
> > newer SoC's! So rather than this why not encode max frame length in
> > driver_data rather than S900_DMA/S700_DMA.. In future one can add values
> > for newer SoC and not code above logic again.
> 
> What newer SoCs? I don't think we should try to guess the future here.

In a patch for adding new SoC, quite ironical I would say!

> We can always introduce further abstractions later, once we actually
> *know* what we are looking at.

Rather if we know we are adding abstractions, why not add in a way that
makes it scale better rather than rework again

> Besides, I don't understand what you are after. The max frame length is
> 1MB in both cases, it's just a matter of where to put FCNT_VAL, either
> in FLEN or in CTRLB. And having an extra flag for that in driver data
> sounds a bit over the top at the moment.

Maybe, maybe not. I would rather make it support N SoC when adding
support for second one rather than keep adding everytime a new SoC is
added...

-- 
~Vinod
