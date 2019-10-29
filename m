Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CECA7E837F
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2019 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfJ2Ixg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Oct 2019 04:53:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59186 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ2Ixf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Oct 2019 04:53:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9T8rMdP075590;
        Tue, 29 Oct 2019 03:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572339202;
        bh=GENQOkaFvVatZv1GMFR3zbGCbH5x94AbSDwlQyYRy4k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ryNYsmDLJEX96Q+mU0OivEDViSqNSb3nMrcJpZ1CwikrLprdf3c1ZFwFLFEGyr7Z4
         bjY4DGY2VwoPy0uOWRd4JCMwAgwubYxlHYWPTXUntK8Ky3GoXdkre/Nmar9eZ/SrHJ
         sZVM/v/z2jsQ1peboThHmeA9SGFCGu6tzGoGz8ds=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9T8rMG2086926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 03:53:22 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 03:53:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 03:53:10 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9T8rIvA090581;
        Tue, 29 Oct 2019 03:53:18 -0500
Subject: Re: [PATCH v3 02/14] soc: ti: k3: add navss ringacc driver
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-3-peter.ujfalusi@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <b5f47303-b6d2-190b-d38c-d3557a93b111@ti.com>
Date:   Tue, 29 Oct 2019 14:22:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Grygorii,

[...snip..]

> +
> +static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
> +				     enum k3_ringacc_access_mode access_mode)
> +{
> +	void __iomem *ptr;
> +
> +	switch (access_mode) {
> +	case K3_RINGACC_ACCESS_MODE_PUSH_HEAD:
> +	case K3_RINGACC_ACCESS_MODE_POP_HEAD:
> +		ptr = (void __iomem *)&ring->fifos->head_data;
> +		break;
> +	case K3_RINGACC_ACCESS_MODE_PUSH_TAIL:
> +	case K3_RINGACC_ACCESS_MODE_POP_TAIL:
> +		ptr = (void __iomem *)&ring->fifos->tail_data;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ptr += k3_ringacc_ring_get_fifo_pos(ring);
> +
> +	switch (access_mode) {
> +	case K3_RINGACC_ACCESS_MODE_POP_HEAD:
> +	case K3_RINGACC_ACCESS_MODE_POP_TAIL:
> +		dev_dbg(ring->parent->dev,
> +			"memcpy_fromio(x): --> ptr(%p), mode:%d\n", ptr,
> +			access_mode);
> +		memcpy_fromio(elem, ptr, (4 << ring->elm_size));

Does this work for any elem_size < 64 or any element size not aligned with 64?

IIUC, in message mode, ring element should be inserted in a single burst write
and there is no doorbell facility. If the above conditions are not met, we are
supposed to use proxy.

In this driver, I don't see any restrictions on the ring element size for
message mode and directly written to io. Am I missing something?

Thanks and regards,
Lokesh

> +		ring->occ--;
> +		break;
> +	case K3_RINGACC_ACCESS_MODE_PUSH_TAIL:
> +	case K3_RINGACC_ACCESS_MODE_PUSH_HEAD:
> +		dev_dbg(ring->parent->dev,
> +			"memcpy_toio(x): --> ptr(%p), mode:%d\n", ptr,
> +			access_mode);
> +		memcpy_toio(ptr, elem, (4 << ring->elm_size));
> +		ring->free--;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(ring->parent->dev, "free%d index%d occ%d index%d\n", ring->free,
> +		ring->windex, ring->occ, ring->rindex);
> +	return 0;
> +}
> +
> +static int k3_ringacc_ring_push_head_io(struct k3_ring *ring, void *elem)
> +{
> +	return k3_ringacc_ring_access_io(ring, elem,
> +					 K3_RINGACC_ACCESS_MODE_PUSH_HEAD);
> +}
> +
> +static int k3_ringacc_ring_push_io(struct k3_ring *ring, void *elem)
> +{
> +	return k3_ringacc_ring_access_io(ring, elem,
> +					 K3_RINGACC_ACCESS_MODE_PUSH_TAIL);
> +}
> +
> +static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem)
> +{
> +	return k3_ringacc_ring_access_io(ring, elem,
> +					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
> +}
> +
> +static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
> +{
> +	return k3_ringacc_ring_access_io(ring, elem,
> +					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
> +}
> +
