Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DD221D0E
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 09:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGPHMe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 03:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPHMe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 03:12:34 -0400
X-Greylist: delayed 498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jul 2020 00:12:34 PDT
Received: from mx2.mailbox.org (mx2a.mailbox.org [IPv6:2001:67c:2050:104:0:2:25:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778FC061755;
        Thu, 16 Jul 2020 00:12:34 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 9F33DA5B5A;
        Thu, 16 Jul 2020 09:04:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id H3ahpmlKgLcK; Thu, 16 Jul 2020 09:04:09 +0200 (CEST)
Subject: Re: [PATCH 07/17] dma: altera-msgdma: Fix struct documentation blocks
To:     Lee Jones <lee.jones@linaro.org>, dan.j.williams@intel.com,
        vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20200714111546.1755231-1-lee.jones@linaro.org>
 <20200714111546.1755231-8-lee.jones@linaro.org>
From:   Stefan Roese <sr@denx.de>
Message-ID: <edc171b1-39a0-7395-f186-6477c0b490d8@denx.de>
Date:   Thu, 16 Jul 2020 09:04:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200714111546.1755231-8-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -3.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1E3A41818
X-Rspamd-UID: 559862
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14.07.20 13:15, Lee Jones wrote:
> Fix some misspelling/description issues, demote non-kerneldoc header
> to standard comment block and provide a new description for
> msgdma_desc_config()'s 'stride' parameter.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'node' not described in 'msgdma_sw_desc'
>   drivers/dma/altera-msgdma.c:163: warning: Function parameter or member 'tx_list' not described in 'msgdma_sw_desc'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'lock' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dev' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq_tasklet' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'pending_list' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'free_list' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'active_list' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'done_list' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc_free_cnt' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'idle' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmadev' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'dmachan' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'hw_desq' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'sw_desq' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'npendings' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'slave_cfg' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'irq' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'csr' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'desc' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:197: warning: Function parameter or member 'resp' not described in 'msgdma_device'
>   drivers/dma/altera-msgdma.c:265: warning: Function parameter or member 'stride' not described in 'msgdma_desc_config'
> 
> Cc: Stefan Roese <sr@denx.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/dma/altera-msgdma.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 539e785039cac..321ac3a7aa418 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -153,7 +153,8 @@ struct msgdma_extended_desc {
>    * struct msgdma_sw_desc - implements a sw descriptor
>    * @async_tx: support for the async_tx api
>    * @hw_desc: assosiated HW descriptor
> - * @free_list: node of the free SW descriprots list
> + * @node: node to move from the free list to the tx list
> + * @tx_list: transmit list node
>    */
>   struct msgdma_sw_desc {
>   	struct dma_async_tx_descriptor async_tx;
> @@ -162,7 +163,7 @@ struct msgdma_sw_desc {
>   	struct list_head tx_list;
>   };
>   
> -/**
> +/*
>    * struct msgdma_device - DMA device structure
>    */
>   struct msgdma_device {
> @@ -258,6 +259,7 @@ static void msgdma_free_desc_list(struct msgdma_device *mdev,
>    * @dst: Destination buffer address
>    * @src: Source buffer address
>    * @len: Transfer length
> + * @stride: Read/write stride value to set
>    */
>   static void msgdma_desc_config(struct msgdma_extended_desc *desc,
>   			       dma_addr_t dst, dma_addr_t src, size_t len,
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
