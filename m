Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588642887AA
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgJILPV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 07:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgJILPV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Oct 2020 07:15:21 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5829922269;
        Fri,  9 Oct 2020 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602242120;
        bh=k6uaFEKd/nFzgD4ScYH6xfNS3bhBKlY2u9F/RvcymNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijRQptxkA5gWAk6lsRYj2aYknp99koRLvxsGj8/yZipBPJEtmvpsDtXna0V/ez6d0
         RajF4Rd6uIQ/hw2qIjBT9MUM3BW6R+Yt57vH1e5yEq5oXPcdiBvutf9o4On7Rmcz8N
         5CK4yiQ1gSfnNCiGNG67r2W647FDfEkPPjwYaYuc=
Date:   Fri, 9 Oct 2020 16:45:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
Message-ID: <20201009111515.GF2968@vkoul-mobl>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
 <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
 <20201009103019.GD2968@vkoul-mobl>
 <a44af464-7d13-1254-54dd-f7783ccfaa0f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a44af464-7d13-1254-54dd-f7783ccfaa0f@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-20, 13:45, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 09/10/2020 13.30, Vinod Koul wrote:
> > Hi Peter,
> > 
> > On 09-10-20, 12:04, Peter Ujfalusi wrote:
> >> On 08/10/2020 15.31, Vinod Koul wrote:
> >>> Some complex dmaengine controllers have capability to program the
> >>> peripheral device, so pass on the peripheral configuration as part of
> >>> dma_slave_config
> >>>
> >>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>> ---
> >>>  include/linux/dmaengine.h | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >>> index 6fbd5c99e30c..a15dc2960f6d 100644
> >>> --- a/include/linux/dmaengine.h
> >>> +++ b/include/linux/dmaengine.h
> >>> @@ -418,6 +418,9 @@ enum dma_slave_buswidth {
> >>>   * @slave_id: Slave requester id. Only valid for slave channels. The dma
> >>>   * slave peripheral will have unique id as dma requester which need to be
> >>>   * pass as slave config.
> >>> + * @peripheral_config: peripheral configuration for programming peripheral
> >>> + * for dmaengine transfer
> >>> + * @peripheral_size: peripheral configuration buffer size
> >>>   *
> >>>   * This struct is passed in as configuration data to a DMA engine
> >>>   * in order to set up a certain channel for DMA transport at runtime.
> >>> @@ -443,6 +446,8 @@ struct dma_slave_config {
> >>>  	u32 dst_port_window_size;
> >>>  	bool device_fc;
> >>>  	unsigned int slave_id;
> >>> +	void *peripheral_config;
> >>> +	size_t peripheral_size;
> >>
> >> Do you foresee a need of src/dst pair of these?
> >> If we do DEV_TO_DEV with different type of peripherals it is going to
> >> cause issues.
> > 
> > Not really as the channel already has direction and this is per channel.
> 
> Yes, in case of DEV_TO_MEM or MEM_TO_DEV.
> 
> > If for any any reason subsequent txn is for different direction, I would
> > expect that parameters are set again before prep_ calls
> 
> But in DEV_TO_DEV?

Do we support that :D

> If we have two peripherals, both needs config:
> p1_config and p2_config
> 
> What and how would one use the single peripheral_config?

Since the config is implementation specific, I do not think it limits.
You may create

struct peter_config {
        struct p1_config;
        struct p2_config;
};

> 
> If only one of them needs config, then sure, the driver can pin-point
> which one the single config might apply to.
> 
> Or you chain the same type of peripheral and you would need different
> config for tx and rx?
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
