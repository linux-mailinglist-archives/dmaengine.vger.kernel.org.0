Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60350A3CF
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389959AbiDUPSe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDUPSd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 11:18:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF535A86;
        Thu, 21 Apr 2022 08:15:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LFFekn096130;
        Thu, 21 Apr 2022 10:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650554140;
        bh=BSmVKrWhv52kLUAhA2dwa8QvQEt8yIyAabglUhHYYvc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=X+i6UeSQVuzFnhmu/Jyx1BNXESg04Pe0GryT/tpDDAg1D4jMpMcN4Xs57IWhOp64r
         kkJNqG2GDLfJCNj3cve4oRDhImsqgVPVzcGTy/JOqMN9ZTrTKEONio7G/uvTVW8JXY
         PfH5Vyz97SGY2lh/VdMyxEn7HTqK8I7S74Z7tb0U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LFFeSn013596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 10:15:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 10:15:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 10:15:39 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LFFaQl121385;
        Thu, 21 Apr 2022 10:15:37 -0500
Message-ID: <7993bc10-fff1-bacb-d0c5-929b14f35244@ti.com>
Date:   Thu, 21 Apr 2022 20:45:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Update PSIL thread for saul.
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <dmaengine@vger.kernel.org>
CC:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220421065323.16378-1-j-choudhary@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220421065323.16378-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jayesh,

On 21/04/22 12:23 pm, Jayesh Choudhary wrote:
> Correct the RX PSIL thread for sa3ul.
> 

Commit message needs more info:
Threads are not wrong but, the first 4 threads are reserved
for secure side usage and the rest is available to be paired with main pktdma.

Also, add fixes tag:

Fixes: 5ac6bfb587772 ("dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data")


> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> The new updated PSIL threads have been tested on local am62x board.
> Log is available here:
> <https://gist.github.com/Jayesh2000/b0316190de3d9dbb8e98337106ebe24a>
> 
>  drivers/dma/ti/k3-psil-am62.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
> index d431e2033237..2b6fd6e37c61 100644
> --- a/drivers/dma/ti/k3-psil-am62.c
> +++ b/drivers/dma/ti/k3-psil-am62.c
> @@ -70,10 +70,10 @@
>  /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
>  static struct psil_ep am62_src_ep_map[] = {
>  	/* SAUL */
> -	PSIL_SAUL(0x7500, 20, 35, 8, 35, 0),
> -	PSIL_SAUL(0x7501, 21, 35, 8, 36, 0),
> -	PSIL_SAUL(0x7502, 22, 43, 8, 43, 0),
> -	PSIL_SAUL(0x7503, 23, 43, 8, 44, 0),
> +	PSIL_SAUL(0x7504, 20, 35, 8, 35, 0),
> +	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
> +	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
> +	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
>  	/* PDMA_MAIN0 - SPI0-3 */
>  	PSIL_PDMA_XY_PKT(0x4302),
>  	PSIL_PDMA_XY_PKT(0x4303),


Regards
Vignesh
