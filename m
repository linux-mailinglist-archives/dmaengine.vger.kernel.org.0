Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08A112A73
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2019 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfLDLr0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Dec 2019 06:47:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37240 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLr0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Dec 2019 06:47:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4Bl2sF002950;
        Wed, 4 Dec 2019 05:47:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575460022;
        bh=GzDNworWBtqYezjFy1PouWFEtcVajB2CsP3RTLTs3EY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vFIdZ3f78mYDNJR7se/mnsiflN1hDZ9MW30244U1lxnT8OcUlZsWbD4Tx9tEqQBtm
         bOIbiLlceJjbeb4Qi2B0nnnYMUDFDeL/3P3spxPoKWyrL/pQNK+184q4BaFYNQSO/C
         Lzn9Y8F9r/m4T7Sq9LkbWNN8ayGL4VCf3+1KS4Nc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4Bl201096189;
        Wed, 4 Dec 2019 05:47:02 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 05:47:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 05:47:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4BkxEa033437;
        Wed, 4 Dec 2019 05:47:00 -0600
Subject: Re: vchan helper broken wrt locking
To:     Sascha Hauer <s.hauer@pengutronix.de>, <dmaengine@vger.kernel.org>
CC:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vkoul@kernel.org>, <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>
References: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <12ec3499-ac9a-2722-2052-02d77975c26c@ti.com>
Date:   Wed, 4 Dec 2019 13:47:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203115050.yvpaehsrck6zydmk@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,

On 03/12/2019 13.50, Sascha Hauer wrote:
> Hi All,
> 
> vc->desc_free() used to be called in non atomic context which makes
> sense to me. This changed over time and now vc->desc_free() is sometimes
> called in atomic context and sometimes not.
> 
> The story starts with 13bb26ae8850 ("dmaengine: virt-dma: don't always
> free descriptor upon completion"). This introduced a vc->desc_allocated
> list which is mostly handled with the lock held, except in vchan_complete().
> vchan_complete() moves the completed descs onto a separate list for the sake
> of iterating over that list without the lock held allowing to call
> vc->desc_free() without lock. 13bb26ae8850 changes this to:
> 
> @@ -83,8 +110,10 @@ static void vchan_complete(unsigned long arg)
>                 cb_data = vd->tx.callback_param;
>  
>                 list_del(&vd->node);
> -
> -               vc->desc_free(vd);
> +               if (dmaengine_desc_test_reuse(&vd->tx))
> +                       list_add(&vd->node, &vc->desc_allocated);
> +               else
> +                       vc->desc_free(vd);
> 
> vc->desc_free() is still called without lock, but the list operation is done
> without locking as well which is wrong.

Hrm, yes all list operation against desc_* should be protected by the
lock, it is a miss.

> Now with 6af149d2b142 ("dmaengine: virt-dma: Add helper to free/reuse a
> descriptor") the hunk above was moved to a separate function
> (vchan_vdesc_fini()). With 1c7f072d94e8 ("dmaengine: virt-dma: Support for
> race free transfer termination") the helper is started to be called with
> lock held resulting in vc->desc_free() being called under the lock as
> well. It is still called from vchan_complete() without lock.

Right.
I think the most elegant way to fix this would be to introduce a new
list_head in virt_dma_chan, let's name it desc_terminated.

We would add the descriptor to this within vchan_terminate_vdesc() (lock
is held).
In vchan_synchronize() we would
list_splice_tail_init(&vc->desc_terminated, &head);
with the lock held and outside of the lock we free them up.

So we would put the terminated descs to the new list and free them up in
synchronize.

This way the vchan_vdesc_fini() would be only called without the lock held.

> I think vc->desc_free() being called under a spin_lock is unfortunate as
> the i.MX SDMA driver does a dma_free_coherent() there which is required
> to be called with interrupts enabled.

In the in review k3-udma driver I use dma_pool or dma_alloc_coherent in
mixed mode depending on the type of the channel.

I did also see the same issue and what I ended up doing is to have
desc_to_purge list and udma_purge_desc_work()
in udma_desc_free() if the descriptor is from the dma_pool, I free it
right away, if it needs dma_free_coherent() then I put it to the
desc_to_purge list and schedule the purge worker to deal with them at a
later time.

In this driver I don't use vchan_terminate_vdesc() because of this.

> I am not sure where to go from here hence I'm writing this mail. Do we
> agree that vc->desc_free() should be called without lock?

I think it should be called without the lock held.

> 
> Sascha
> 
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
