Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6512790A
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTKPC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 05:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTKPB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 05:15:01 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F5D206D8;
        Fri, 20 Dec 2019 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576836901;
        bh=3q1NF9VG9IWQH0lcsKzRWfLp9RNI0lBU9URATav/sck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxHI/HJ87pI2J2ulQlfQdf6utepKQnhIl8aUTOmKmyc4Gy1AS/BlCDM8D6h30RU1q
         tFA5JERdV3SyPUgVJXQWTinJTNYs+bMMTVe/LzFse92eoKqDeWsKMzaxd4TBaQnMYV
         4nTCX9z29x19dtDhNUDlXVuqmRBKo32w6wui6mKU=
Date:   Fri, 20 Dec 2019 15:44:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 03/12] dmaengine: doc: Add sections for per descriptor
 metadata support
Message-ID: <20191220101456.GO2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-4-peter.ujfalusi@ti.com>
 <20191220082810.GJ2536@vkoul-mobl>
 <4508bc1c-d424-3285-cb47-d32a4d25b2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4508bc1c-d424-3285-cb47-d32a4d25b2c9@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-12-19, 11:52, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 20/12/2019 10.28, Vinod Koul wrote:
> > Hi Peter,
> > 
> > On 09-12-19, 11:43, Peter Ujfalusi wrote:
> > 
> >> +  Optional: per descriptor metadata
> >> +  ---------------------------------
> >> +  DMAengine provides two ways for metadata support.
> >> +
> >> +  DESC_METADATA_CLIENT
> >> +
> >> +    The metadata buffer is allocated/provided by the client driver and it is
> >> +    attached to the descriptor.
> >> +
> >> +  .. code-block:: c
> >> +
> >> +     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
> >> +				   void *data, size_t len);
> >> +
> >> +  DESC_METADATA_ENGINE
> >> +
> >> +    The metadata buffer is allocated/managed by the DMA driver. The client
> > 
> > and when would it be freed?
> 
> It is not defined as it could be driver dependent, but afaik we have
> defined (which I'm not sure why it is not here or in the code) that in
> DESC_METADATA_ENGINE case the metadata pointer is valid for the client
> between the time it got the desc (via prep call) and the execution of
> the completion callback.
> Iow, DESC_METADATA_ENGINE does not make any sense if the client want to
> receive metadata back and does not provide a callback.

Make sense and once callback completes driver can free it up!
> 
> I will extend the documentation and comment in the code to reflect this.

makes sense, thanks!

> 
> >> +    driver can ask for the pointer, maximum size and the currently used size of
> >> +    the metadata and can directly update or read it.
> >> +
> >> +  .. code-block:: c
> >> +
> >> +     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> >> +		size_t *payload_len, size_t *max_len);
> >> +
> >> +     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
> >> +		size_t payload_len);
> >> +
> >> +  Client drivers can query if a given mode is supported with:
> >> +
> >> +  .. code-block:: c
> >> +
> >> +     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
> >> +		enum dma_desc_metadata_mode mode);
> >> +
> >> +  Depending on the used mode client drivers must follow different flow.
> >> +
> >> +  DESC_METADATA_CLIENT
> >> +
> >> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> >> +      1. prepare the descriptor (dmaengine_prep_*)
> >> +         construct the metadata in the client's buffer
> >> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> >> +         descriptor
> >> +      3. submit the transfer
> > 
> > This is simpler, txn finished the metadata would be freed up right?
> 
> It is up to the client driver what it does with the provided buffer. As
> for what the DMA driver does is not documented as it is not relevant and
> can be different by different HW or SW implementation.

yeah lets document that and the fact the dmaengine driver cant touch it
after the callback
-- 
~Vinod
