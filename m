Return-Path: <dmaengine+bounces-934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9184748C
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 17:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD11F21D16
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0F1482EF;
	Fri,  2 Feb 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHw0DS2T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221291482EC
	for <dmaengine@vger.kernel.org>; Fri,  2 Feb 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890788; cv=none; b=fJzx4gbu0qQLMlJ4ip+1JQ56ayrw5yvS/odcCqw3szvuk09LinXrMZYpAR20KmfMw4W50SQYnLzJUIFD8ysxmboTwL+OOwO5RnLLpTolbfDGJWOEAGBujVm0lUh54HISYOfx66SeLboVY4GlqJh9qzfirB08dfc0mUD3gRzBAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890788; c=relaxed/simple;
	bh=3jWTcJQ2ZaJDa1JOha3/9xpKiMZarYUJeE5FmnGvkaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euxI7FVT/23bOvXj1KEjQr5rLBkTgeuy3KHt1P49QBx4FGio/IqF9Lp9cjvSyyG7kBUkqB+HAD8cwyE8W4lzllEr18QWu+z/i7xmg0r7a5Qh+Iqif4DRPM7R558GzK46/2/LZjmUwr5N0biNnqVXjp9BSE5RErXGmKfammIkEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHw0DS2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA7C43609;
	Fri,  2 Feb 2024 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890787;
	bh=3jWTcJQ2ZaJDa1JOha3/9xpKiMZarYUJeE5FmnGvkaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHw0DS2TaQBKXDQKeffRLCZCgjMba8rtyLYh8lg2HYHU+y/P0XnOGdLkpnTOgzj2z
	 3Y4Q9n0Kg31F4k8iiBU//hY3v+62Lnda23baoLVP9+jgzbxq9fxE7shhBE05eEEdBn
	 7vsVhadeVjVHtIL8LojZOFNh55UkM1l5CMVCm+lXXxK3CD2SVBjZASifnC8dWwZC0r
	 m5sAV7SD/Ou8oh02+Qv0+Hb4Ga0DbqL8+ISKM7zlkDFZcX3gU4fuL7v/cjt5Rsiea5
	 dBKmcd1GEdhB+0yBpjGIaoCGgkOv7veiYAvx73OT5ncPlWlMC6jjDKphQG5X99IvHp
	 ZHp62+BcM/Eew==
Date: Fri, 2 Feb 2024 17:19:44 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: dmaengine@vger.kernel.org,
	Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] dmaengine: at_hdmac: add missing kernel-doc style
 description
Message-ID: <Zb0WINaX6X58K91u@matsya>
References: <20240130163216.633034-1-vkoul@kernel.org>
 <acd56301-d7b1-4218-9f89-eccc283a9c7e@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd56301-d7b1-4218-9f89-eccc283a9c7e@linaro.org>

Hi Toudor,

On 31-01-24, 08:28, Tudor Ambarus wrote:
> 
> Hi, Vinod,
> 
> On 1/30/24 16:32, Vinod Koul wrote:
> > We get following warning with W=1:
> > 
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
> > drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_PAUSED' not described in enum 'atc_status'
> > drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_CYCLIC' not described in enum 'atc_status'
> > drivers/dma/at_hdmac.c:287: warning: Function parameter or struct member 'cyclic' not described in 'at_dma_chan'
> > drivers/dma/at_hdmac.c:350: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'
> > 
> > Fix this by adding the required description and also drop unused struct
> > member 'cyclic' in 'at_dma_chan'
> > 
> 
> Thanks for fixing these! Few nits below that you may consider while
> applying.
> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/at_hdmac.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> > index 6bad536e0492..57d0697ad194 100644
> > --- a/drivers/dma/at_hdmac.c
> > +++ b/drivers/dma/at_hdmac.c
> > @@ -224,6 +224,12 @@ struct atdma_sg {
> >   * @total_len: total transaction byte count
> >   * @sglen: number of sg entries.
> >   * @sg: array of sgs.
> > + * @boundary: Interleaved dma boundary
> how about: number of transfers to perform before the automatic address
> increment operation
> > + * @dst_hole: Interleaved dma destination hole
> how about: value to add to the destination address when the boundary has
> been reached
> > + * @src_hole: Interleaved dma source hole
> 
> and here the same, but for source
> > + * @memset_buffer: buffer for memset
> how about: buffer used for the memset operation
> > + * @memset_paddr: paddr for buffer for memset
> 
> how about: physical address of the buffer used for the memset operation
> 
> > + * @memset_vaddr: vaddr for buffer for memset
> 
> and here the same but with virtual
> 
> >   */
> >  struct at_desc {
> >  	struct				virt_dma_desc vd;
> > @@ -247,6 +253,9 @@ struct at_desc {
> >  /**
> >   * enum atc_status - information bits stored in channel status flag
> >   *
> > + * @ATC_IS_PAUSED: If channel is pause
> 
> typo, s/pause/paused

I have updated these and applied the patch, thanks for better
suggestions

> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Cheers,
> ta
> > + * @ATC_IS_CYCLIC: If channel is cyclic
> > + *
> >   * Manipulated with atomic operations.
> >   */
> >  enum atc_status {
> > @@ -282,7 +291,6 @@ struct at_dma_chan {
> >  	u32			save_cfg;
> >  	u32			save_dscr;
> >  	struct dma_slave_config	dma_sconfig;
> > -	bool			cyclic;
> >  	struct at_desc		*desc;
> >  };
> >  
> > @@ -333,6 +341,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
> >   * @save_imr: interrupt mask register that is saved on suspend/resume cycle
> >   * @all_chan_mask: all channels availlable in a mask
> >   * @lli_pool: hw lli table
> > + * @memset_pool: hw memset pool
> >   * @chan: channels table to store at_dma_chan structures
> >   */
> >  struct at_dma {

-- 
~Vinod

