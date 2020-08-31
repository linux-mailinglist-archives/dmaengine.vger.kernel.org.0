Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2B257DE0
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHaPr1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 11:47:27 -0400
Received: from ale.deltatee.com ([204.191.154.188]:51046 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaPr0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JRbfWDvjuTAK2WjTBlVMadPW+0e3TpcbGs2uUIirJf0=; b=kPg8mEga5geILpa9w5blNWD+fp
        mF/Nldo9L/IFYrBzKS7G9DTCt9Q+a7rmV0K5sEVVEjeHLqsQFKB4VOLusoH3vcD5tEitgq6+wN+o4
        9ulU+Qa8CzazyvImHZnrnOlVVwB1WBu4y3C+2BYcQG99Q6MwwPvp8bjieXzTKeaTE5rB/NXCveewF
        IKP5KBkbAoFrjamJBzWaIUs1oe0B0OEyLrEMqaDrxgA5UBpA9mXkLu7hMix2VE/uM2/2DlJ2Am3Fe
        DCpJKixv9LKp3RvolvkMjjg5nqmDoK1NmxAl+fIrFFBcbx29Cp0DcB7/VPNfMenjqM2Id018O2xVb
        RDhNqOxg==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kCm1j-00067l-Vb; Mon, 31 Aug 2020 09:47:24 -0600
To:     Allen Pais <allen.lkml@gmail.com>, vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com, agross@kernel.org,
        jorn.andersson@linaro.org, green.wan@sifive.com, baohua@kernel.org,
        mripard@kernel.org, wens@csie.org, dmaengine@vger.kernel.org
References: <20200831103542.305571-1-allen.lkml@gmail.com>
 <20200831103542.305571-34-allen.lkml@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9368c823-4240-4d86-879c-6dae662a36e4@deltatee.com>
Date:   Mon, 31 Aug 2020 09:47:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831103542.305571-34-allen.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, wens@csie.org, mripard@kernel.org, baohua@kernel.org, green.wan@sifive.com, jorn.andersson@linaro.org, agross@kernel.org, matthias.bgg@gmail.com, sean.wang@mediatek.com, s.hauer@pengutronix.de, shawnguo@kernel.org, zw@zh-kernel.org, leoyang.li@nxp.com, vireshk@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org, allen.lkml@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 33/35] dmaengine: plx_dma: convert tasklets to use new
 tasklet_setup() API
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2020-08-31 4:35 a.m., Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/dma/plx_dma.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index db4c5fd453a9..f387c5bbc170 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -241,9 +241,9 @@ static void plx_dma_stop(struct plx_dma_dev *plxdev)
>  	rcu_read_unlock();
>  }
>  
> -static void plx_dma_desc_task(unsigned long data)
> +static void plx_dma_desc_task(struct tasklet_struct *t)
>  {
> -	struct plx_dma_dev *plxdev = (void *)data;
> +	struct plx_dma_dev *plxdev = from_tasklet(plxdev, t, desc_task);

The discussion I saw on another thread suggested the private macro
from_tasklet() would be replaced with something generic. So isn't this
patchset a bit premature?

Thanks,

Logan
