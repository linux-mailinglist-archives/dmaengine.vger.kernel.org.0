Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F771278A0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLTJ6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 04:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfLTJ6A (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 04:58:00 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3375206EC;
        Fri, 20 Dec 2019 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576835879;
        bh=GmxrDdeOg4cCheaZlgE6D51yTf+SUe1HRp8l+b4QsCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVCj5Lr63v5zXDgurOvuFgpKc3hYSbcFTPJuJVlgenwasTnIGAkZ3oebH8v4nHT6E
         Rb8qynWq1Far66Y2GlG00m1a6kcayL4jf+YdB3deHtKUEetjvQPuSNFAmStdmNWf8m
         mN7j2DGGxHgk8C9xSSb0i/voEWp4ExsVWy7Vg2cE=
Date:   Fri, 20 Dec 2019 15:27:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 05/12] dmaengine: Add support for reporting DMA cached
 data amount
Message-ID: <20191220095755.GN2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-6-peter.ujfalusi@ti.com>
 <20191220083713.GL2536@vkoul-mobl>
 <f28301f7-4624-b4f8-d781-7ebfa4ae7856@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28301f7-4624-b4f8-d781-7ebfa4ae7856@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-12-19, 10:49, Peter Ujfalusi wrote:

> >> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
> >> +					   u32 in_flight_bytes)
> >> +{
> >> +	if (state)
> >> +		state->in_flight_bytes = in_flight_bytes;
> >> +}
> > 
> > This would be used by dmaengine drivers right, so lets move it to drivers/dma/dmaengine.h
> > 
> > lets not expose this to users :)
> 
> I have put it where the dma_set_residue() was.
> I can add a patch first to move dma_set_residue() then add

not sure I follow, but dma_set_residue() in already in drivers/dma/dmaengine.h

> dma_set_in_flight_bytes() there as well?

-- 
~Vinod
