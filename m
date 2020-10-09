Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D52886F1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgJIKaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 06:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbgJIKaY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Oct 2020 06:30:24 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5192226B;
        Fri,  9 Oct 2020 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602239423;
        bh=2S5cTsiaGUTnL4qYAUGa56y6UyS/LmE34JmfxGcQ1cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ws/Iqsc0keJOJ4dffz7XEfkOTlv2bWVqrWRRcbvydc1+adsdkeKel5MAWcBuDqoTx
         ecTxhwGKjS8SDcsrTDq4zg4i3Fjly892qD7bo2q/1+/DPxpaR9Sw9zqzhQOPe24puQ
         B0xH1diT7tVjHj27BpXRKGNqjvfy2Ih+vVr0urW8=
Date:   Fri, 9 Oct 2020 16:00:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
Message-ID: <20201009103019.GD2968@vkoul-mobl>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
 <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 09-10-20, 12:04, Peter Ujfalusi wrote:
> On 08/10/2020 15.31, Vinod Koul wrote:
> > Some complex dmaengine controllers have capability to program the
> > peripheral device, so pass on the peripheral configuration as part of
> > dma_slave_config
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  include/linux/dmaengine.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 6fbd5c99e30c..a15dc2960f6d 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -418,6 +418,9 @@ enum dma_slave_buswidth {
> >   * @slave_id: Slave requester id. Only valid for slave channels. The dma
> >   * slave peripheral will have unique id as dma requester which need to be
> >   * pass as slave config.
> > + * @peripheral_config: peripheral configuration for programming peripheral
> > + * for dmaengine transfer
> > + * @peripheral_size: peripheral configuration buffer size
> >   *
> >   * This struct is passed in as configuration data to a DMA engine
> >   * in order to set up a certain channel for DMA transport at runtime.
> > @@ -443,6 +446,8 @@ struct dma_slave_config {
> >  	u32 dst_port_window_size;
> >  	bool device_fc;
> >  	unsigned int slave_id;
> > +	void *peripheral_config;
> > +	size_t peripheral_size;
> 
> Do you foresee a need of src/dst pair of these?
> If we do DEV_TO_DEV with different type of peripherals it is going to
> cause issues.

Not really as the channel already has direction and this is per channel.
If for any any reason subsequent txn is for different direction, I would
expect that parameters are set again before prep_ calls

-- 
~Vinod
