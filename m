Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8112771D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfLTI2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLTI2Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 03:28:16 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7648A227BF;
        Fri, 20 Dec 2019 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576830495;
        bh=/KzTBILL8UHCE07b1BUC9/oeP6eglWtHpVzn8+71Crg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0f+gM3rUF7VxJ7D2UmrQkNTfFaxtbS95hDsAW4nP/sZkybZqFyTOWe+lJyWoDumH
         zJo+49xPEuIwTNkTd/YYaOBkRtJNp9b2QwQUU7IjEmrIbP3659GxF+hbt1a8h8qB+y
         Wa6osl7DPbfxyGPDUoQlwXKprDozAnNIZXEJ0NVI=
Date:   Fri, 20 Dec 2019 13:58:10 +0530
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
Message-ID: <20191220082810.GJ2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-4-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209094332.4047-4-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 09-12-19, 11:43, Peter Ujfalusi wrote:

> +  Optional: per descriptor metadata
> +  ---------------------------------
> +  DMAengine provides two ways for metadata support.
> +
> +  DESC_METADATA_CLIENT
> +
> +    The metadata buffer is allocated/provided by the client driver and it is
> +    attached to the descriptor.
> +
> +  .. code-block:: c
> +
> +     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
> +				   void *data, size_t len);
> +
> +  DESC_METADATA_ENGINE
> +
> +    The metadata buffer is allocated/managed by the DMA driver. The client

and when would it be freed?

> +    driver can ask for the pointer, maximum size and the currently used size of
> +    the metadata and can directly update or read it.
> +
> +  .. code-block:: c
> +
> +     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> +		size_t *payload_len, size_t *max_len);
> +
> +     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
> +		size_t payload_len);
> +
> +  Client drivers can query if a given mode is supported with:
> +
> +  .. code-block:: c
> +
> +     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
> +		enum dma_desc_metadata_mode mode);
> +
> +  Depending on the used mode client drivers must follow different flow.
> +
> +  DESC_METADATA_CLIENT
> +
> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +         construct the metadata in the client's buffer
> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> +         descriptor
> +      3. submit the transfer

This is simpler, txn finished the metadata would be freed up right?
> +    - DMA_DEV_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
> +         descriptor
> +      3. submit the transfer
> +      4. when the transfer is completed, the metadata should be available in the
> +         attached buffer

and when and how would driver free that up :)

> +
> +  DESC_METADATA_ENGINE
> +
> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
> +         engine's metadata area
> +      3. update the metadata at the pointer
> +      4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
> +         amount of data the client has placed into the metadata buffer
> +      5. submit the transfer
> +    - DMA_DEV_TO_MEM:
> +      1. prepare the descriptor (dmaengine_prep_*)
> +      2. submit the transfer
> +      3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
> +         pointer to the engine's metadata area
> +      4. Read out the metadata from the pointer
> +
> +  .. note::
> +
> +     Mixed use of DESC_METADATA_CLIENT / DESC_METADATA_ENGINE is not allowed,
> +     client drivers must use either of the modes per descriptor.

We should check that if not done already!
-- 
~Vinod
