Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFB12787C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfLTJwE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 04:52:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44820 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfLTJwE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 04:52:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBK9puEN043580;
        Fri, 20 Dec 2019 03:51:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576835516;
        bh=kqMZ+z+MUwo+a+ooyLFGuoxw4kbNKOy1pOOeeFzsQwM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pWf/bWLf5zxUwl/KcnGqAnzK8j+hh9Or4Vc4UI+30twtPCuJEqV5JK179kH1XA5G2
         Kb8ncQMSrKd8aPSK9dIMXHjMq+zeNHzwblkMYiqrtNJ7dpxOvfDcJQN0ojYAL45Nfa
         Z6AqtnT+CCM2Mm5TLtfsjPbHIuErmTSriJ2PDRH4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBK9puVL025449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 03:51:56 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 03:51:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 03:51:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBK9pqn5035604;
        Fri, 20 Dec 2019 03:51:52 -0600
Subject: Re: [PATCH v7 03/12] dmaengine: doc: Add sections for per descriptor
 metadata support
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-4-peter.ujfalusi@ti.com>
 <20191220082810.GJ2536@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4508bc1c-d424-3285-cb47-d32a4d25b2c9@ti.com>
Date:   Fri, 20 Dec 2019 11:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220082810.GJ2536@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 20/12/2019 10.28, Vinod Koul wrote:
> Hi Peter,
> 
> On 09-12-19, 11:43, Peter Ujfalusi wrote:
> 
>> +  Optional: per descriptor metadata
>> +  ---------------------------------
>> +  DMAengine provides two ways for metadata support.
>> +
>> +  DESC_METADATA_CLIENT
>> +
>> +    The metadata buffer is allocated/provided by the client driver and it is
>> +    attached to the descriptor.
>> +
>> +  .. code-block:: c
>> +
>> +     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
>> +				   void *data, size_t len);
>> +
>> +  DESC_METADATA_ENGINE
>> +
>> +    The metadata buffer is allocated/managed by the DMA driver. The client
> 
> and when would it be freed?

It is not defined as it could be driver dependent, but afaik we have
defined (which I'm not sure why it is not here or in the code) that in
DESC_METADATA_ENGINE case the metadata pointer is valid for the client
between the time it got the desc (via prep call) and the execution of
the completion callback.
Iow, DESC_METADATA_ENGINE does not make any sense if the client want to
receive metadata back and does not provide a callback.

I will extend the documentation and comment in the code to reflect this.

>> +    driver can ask for the pointer, maximum size and the currently used size of
>> +    the metadata and can directly update or read it.
>> +
>> +  .. code-block:: c
>> +
>> +     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
>> +		size_t *payload_len, size_t *max_len);
>> +
>> +     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
>> +		size_t payload_len);
>> +
>> +  Client drivers can query if a given mode is supported with:
>> +
>> +  .. code-block:: c
>> +
>> +     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
>> +		enum dma_desc_metadata_mode mode);
>> +
>> +  Depending on the used mode client drivers must follow different flow.
>> +
>> +  DESC_METADATA_CLIENT
>> +
>> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
>> +      1. prepare the descriptor (dmaengine_prep_*)
>> +         construct the metadata in the client's buffer
>> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>> +         descriptor
>> +      3. submit the transfer
> 
> This is simpler, txn finished the metadata would be freed up right?

It is up to the client driver what it does with the provided buffer. As
for what the DMA driver does is not documented as it is not relevant and
can be different by different HW or SW implementation.

>> +    - DMA_DEV_TO_MEM:
>> +      1. prepare the descriptor (dmaengine_prep_*)
>> +      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>> +         descriptor
>> +      3. submit the transfer
>> +      4. when the transfer is completed, the metadata should be available in the
>> +         attached buffer
> 
> and when and how would driver free that up :)

It is up to the client, it manages the buffer. It can reuse it and
attach it to another descriptor or free it up or pass it to other
layers, return it to other layer.

>> +
>> +  DESC_METADATA_ENGINE
>> +
>> +    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
>> +      1. prepare the descriptor (dmaengine_prep_*)
>> +      2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
>> +         engine's metadata area
>> +      3. update the metadata at the pointer
>> +      4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
>> +         amount of data the client has placed into the metadata buffer
>> +      5. submit the transfer
>> +    - DMA_DEV_TO_MEM:
>> +      1. prepare the descriptor (dmaengine_prep_*)
>> +      2. submit the transfer
>> +      3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
>> +         pointer to the engine's metadata area
>> +      4. Read out the metadata from the pointer
>> +
>> +  .. note::
>> +
>> +     Mixed use of DESC_METADATA_CLIENT / DESC_METADATA_ENGINE is not allowed,
>> +     client drivers must use either of the modes per descriptor.
> 
> We should check that if not done already!

Yes, we check it.


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
