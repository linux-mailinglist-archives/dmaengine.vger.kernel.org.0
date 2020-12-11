Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE52D76DB
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 14:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgLKNrw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 08:47:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40254 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbgLKNrY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Dec 2020 08:47:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BBDjdTv072408;
        Fri, 11 Dec 2020 07:45:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607694339;
        bh=PtbbpmNeH8mroCFh+s1SgSbfVtmFKVFgxh2cmWfEC6c=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=bTB7BB+8EmjuzpTeot2iHsmMi1ajJjBwGI9GezK1bH1UxAfc8UA7w5vVCUSH1bbPr
         xiFXEm51pDW5BWXDeJnJieiD71FO/aFeCu4dzLl9BE8A7L/xlD8rcRqDHIuMi/F4gd
         NvM8HoAtl2J2Y8sNQ5gvgOi26iGfna9MpmhAwouo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BBDjdxu094975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 07:45:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 07:45:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 07:45:38 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BBDjama033193;
        Fri, 11 Dec 2020 07:45:36 -0600
Subject: Re: [PATCH v3 16/20] soc: ti: k3-ringacc: add AM64 DMA rings support.
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-17-peter.ujfalusi@ti.com>
Message-ID: <a1f83b16-c1ce-630e-3410-738b80a92741@ti.com>
Date:   Fri, 11 Dec 2020 15:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208090440.31792-17-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/12/2020 11.04, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The DMAs in AM64 have built in rings compared to AM654/J721e/J7200 where a
> separate and generic ringacc is used.
> 
> The ring SW interface is similar to ringacc with some major architectural
> differences, like
> 
> They are part of the DMA (BCDMA or PKTDMA).
> 
> They are dual mode rings are modeled as pair of Rings objects which has
> common configuration and memory buffer, but separate real-time control
> register sets for each direction mem2dev (forward) and dev2mem (reverse).
> 
> The ringacc driver must be initialized for DMA rings use with
> k3_ringacc_dmarings_init() as it is not an independent device as ringacc
> is.
> 
> AM64 rings must be requested only using k3_ringacc_request_rings_pair(),
> and forward ring must always be initialized/configured. After this any
> other Ringacc APIs can be used without any callers changes.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/soc/ti/k3-ringacc.c       | 325 +++++++++++++++++++++++++++++-
>  include/linux/soc/ti/k3-ringacc.h |  17 ++
>  2 files changed, 335 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 119164abcb41..c88c305ba367 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c

...

> +struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
> +					    struct k3_ringacc_init_data *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k3_ringacc *ringacc;
> +	void __iomem *base_rt;
> +	struct resource *res;
> +	int i;
> +
> +	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
> +	if (!ringacc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ringacc->dev = dev;
> +	ringacc->dma_rings = true;
> +	ringacc->num_rings = data->num_rings;
> +	ringacc->tisci = data->tisci;
> +	ringacc->tisci_dev_id = data->tisci_dev_id;
> +
> +	mutex_init(&ringacc->req_lock);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
> +	base_rt = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base_rt))
> +		return base_rt;

this must have been:
	return ERR_CAST(base_rt);

> +
> +	ringacc->rings = devm_kzalloc(dev,
> +				      sizeof(*ringacc->rings) *
> +				      ringacc->num_rings * 2,
> +				      GFP_KERNEL);
> +	ringacc->rings_inuse = devm_kcalloc(dev,
> +					    BITS_TO_LONGS(ringacc->num_rings),
> +					    sizeof(unsigned long), GFP_KERNEL);
> +
> +	if (!ringacc->rings || !ringacc->rings_inuse)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < ringacc->num_rings; i++) {
> +		struct k3_ring *ring = &ringacc->rings[i];
> +
> +		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i;
> +		ring->parent = ringacc;
> +		ring->ring_id = i;
> +		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
> +
> +		ring = &ringacc->rings[ringacc->num_rings + i];
> +		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i +
> +			   K3_DMARING_RT_REGS_REVERSE_OFS;
> +		ring->parent = ringacc;
> +		ring->ring_id = i;
> +		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
> +		ring->flags = K3_RING_FLAG_REVERSE;
> +	}
> +
> +	ringacc->tisci_ring_ops = &ringacc->tisci->ops.rm_ring_ops;
> +
> +	dev_info(dev, "Number of rings: %u\n", ringacc->num_rings);
> +
> +	return ringacc;
> +}

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
