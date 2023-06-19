Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5C735CB0
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjFSRC2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFSRCK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 13:02:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D08D11A;
        Mon, 19 Jun 2023 10:02:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4784590e87.2;
        Mon, 19 Jun 2023 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687194125; x=1689786125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/xtxYTOLBznD6otwEWz969tXVdpTwtKn88+fsyR1Zh4=;
        b=Gsp+ibBBHdX7nf3Xmv1cohOYbszcvJrdiPpLB4gi2ZwXo5DCn4FQf9hlRQwVCQY9FN
         fE19D82eRd/k1/mMieDgeW6HxYURH/erwhSox+ocD6H2ahGksLszuW+NN7IlQrxR0mMx
         Y/FtYeELD6SP049BliKcA6XkpVPgcwb87uHqfMvYNK2f4KcmsT3SOFPW8cVX0dEGXjCO
         qgsfgdNNk++G3MNwafQAv+fW8qevtclu5lWoo4Ug6GK7AQZdlWPvJ4bGyoHoGXauoECS
         9ZHAygUB2hbNVnMv2EASo1MYNrqgoNU4HcolV0J727XCvbfLX4E90iYwYHKrKzz0UHW4
         40hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194125; x=1689786125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtxYTOLBznD6otwEWz969tXVdpTwtKn88+fsyR1Zh4=;
        b=BX/IoKujfs55/zOpNH3pvnLvxFNSA4Fn2sHU4IMiypSmK8TAlXDtcl7zmfV5cYYBXZ
         FU1+wSgxExfe3fOI7OK/cPFF34XLbZAjIfNjj6rZODRajCrrOmou/TcNA2M9wCSgMZii
         9pnwTonDHfi/21+B4UwwEqi+8wOR7BgEZiolIeHzij69Zz8K6DB0ta5+S/35u44ht1wp
         HUrCStc/hzZbx54bYVgGOB4obPnPEHDbX9d8baJwqyHa2OcKNLKCVcywyLNWAOtylNHi
         qu6ROZWLpN6mXbChGKLfGL+ifjDz5C2QOWTvXLXNvcoXHt120G/dv6d8vFdelc0FZpdB
         h/mw==
X-Gm-Message-State: AC+VfDwz+b1+lJRcpCgysCfU/ae6o7npKIRmqDTkCyCfJ5AMlEpSngr+
        tz5z1EtHiM83WwfiZlkrhtD5qn7dZ8E=
X-Google-Smtp-Source: ACHHUZ4E9mD3yF1i1AfcuPwIUylx1xme15GtplLSwWfPNa7vzCgVD107kd2fUcptsMJqhkiMUHkDQA==
X-Received: by 2002:a19:e30d:0:b0:4f7:6762:cd1d with SMTP id a13-20020a19e30d000000b004f76762cd1dmr6610436lfh.51.1687194124954;
        Mon, 19 Jun 2023 10:02:04 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b004f1383d57ecsm2349lfd.202.2023.06.19.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:02:03 -0700 (PDT)
Date:   Mon, 19 Jun 2023 20:02:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 4/9] dmaengine: dw-edma: HDMA: Add memory barrier before
 starting the DMA transfer in remote setup
Message-ID: <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609081654.330857-5-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 09, 2023 at 10:16:49AM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 

> The Linked list element and pointer are not stored in the same memory as
> the HDMA controller register. If the doorbell register is toggled before
> the full write of the linked list a race condition error can appears.
> In remote setup we can only use a readl to the memory to assured the full
> write has occurred.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Is this a hypothetical bug? Have you actually experienced the
described problem? If so are you sure that it's supposed to be fixed
as you suggest?

I am asking because based on the kernel doc (Documentation/memory-barriers.txt):

*    1. All readX() and writeX() accesses to the same peripheral are ordered
*       with respect to each other. This ensures that MMIO register accesses
*       by the same CPU thread to a particular device will arrive in program
*       order.
* ...
* The ordering properties of __iomem pointers obtained with non-default
* attributes (e.g. those returned by ioremap_wc()) are specific to the
* underlying architecture and therefore the guarantees listed above cannot
* generally be relied upon for accesses to these types of mappings.

the IOs performed by the accessors are supposed to arrive in the
program order. Thus SET_CH_32(..., HDMA_V0_DOORBELL_START) performed
after all the previous SET_CH_32(...) are finished looks correct with
no need in additional barriers. The results of the later operations
are supposed to be seen by the device (in our case it's a remote DW
eDMA controller) before the doorbell update from scratch. From that
perspective your problem looks as if the IO operations preceding the
doorbell CSR update aren't finished yet. So you are sure that the LL
memory is mapped with no additional flags like Write-Combine or some
caching optimizations? Are you sure that the PCIe IOs are correctly
implemented in your platform?

I do understand that the eDMA CSRs and the LL memory are mapped by
different BARs in the remote eDMA setup. But they still belong to the
same device. So the IO accessors semantic described in the kernel doc
implies no need in additional barrier.

-Serge(y)

> ---
> 
> This patch is fixing a commit which is only in dmaengine tree and not
> merged mainline.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 7bd1a0f742be..0b77ddbe91b5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -247,6 +247,15 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	/* Set consumer cycle */
>  	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
>  		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
> +
> +	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		/* Make sure Linked List has been written.
> +		 * Linux memory barriers don't cater for what's required here.
> +		 * What's required is what's here - a read of the linked
> +		 * list region.
> +		 */
> +		readl(chunk->ll_region.vaddr.io);
> +
>  	/* Doorbell */
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
> -- 
> 2.25.1
> 
