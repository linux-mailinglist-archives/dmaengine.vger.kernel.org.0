Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9DE9C0D
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2019 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJ3NJ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Oct 2019 09:09:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJ3NJ4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Oct 2019 09:09:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9UD9hoY093115;
        Wed, 30 Oct 2019 08:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572440983;
        bh=M5l3IXLPZ7PbLcGaD/x5qSLUDpxoQyE8oFPSKxV0M6M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V5lkrTTSDHh0l+SiR9NbcKYF4Ssaol8yXGCPibS7s4RTE0cDwNKtEG18APtxtqZGq
         2uM4ETLP0V3C6c/DuT/EpHRVSbWe59T17HFe9pfSAQnuWKN5ROk9txWhrS4tvS2V6S
         opxO1af7+PkGymOiMkSUpF9JVwCn8ESbgvAJHfPM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9UD9hQN087336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Oct 2019 08:09:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 08:09:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 08:09:43 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9UD9eLx111494;
        Wed, 30 Oct 2019 08:09:40 -0500
Subject: Re: [PATCH v3 02/14] soc: ti: k3: add navss ringacc driver
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-3-peter.ujfalusi@ti.com>
 <b5f47303-b6d2-190b-d38c-d3557a93b111@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5e65db22-1436-5f2d-6355-9ba3aa5a9d88@ti.com>
Date:   Wed, 30 Oct 2019 15:10:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b5f47303-b6d2-190b-d38c-d3557a93b111@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 29/10/2019 10:52, Lokesh Vutla wrote:
> Hi Grygorii,
> 
> [...snip..]
> 
>> +
>> +static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
>> +				     enum k3_ringacc_access_mode access_mode)
>> +{
>> +	void __iomem *ptr;
>> +
>> +	switch (access_mode) {
>> +	case K3_RINGACC_ACCESS_MODE_PUSH_HEAD:
>> +	case K3_RINGACC_ACCESS_MODE_POP_HEAD:
>> +		ptr = (void __iomem *)&ring->fifos->head_data;
>> +		break;
>> +	case K3_RINGACC_ACCESS_MODE_PUSH_TAIL:
>> +	case K3_RINGACC_ACCESS_MODE_POP_TAIL:
>> +		ptr = (void __iomem *)&ring->fifos->tail_data;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ptr += k3_ringacc_ring_get_fifo_pos(ring);
>> +
>> +	switch (access_mode) {
>> +	case K3_RINGACC_ACCESS_MODE_POP_HEAD:
>> +	case K3_RINGACC_ACCESS_MODE_POP_TAIL:
>> +		dev_dbg(ring->parent->dev,
>> +			"memcpy_fromio(x): --> ptr(%p), mode:%d\n", ptr,
>> +			access_mode);
>> +		memcpy_fromio(elem, ptr, (4 << ring->elm_size));
> 
> Does this work for any elem_size < 64 or any element size not aligned with 64?

Max value of elem_size is 6 as per TRM.

> 
> IIUC, in message mode, ring element should be inserted in a single burst write
> and there is no doorbell facility. If the above conditions are not met, we are
> supposed to use proxy.
> 
> In this driver, I don't see any restrictions on the ring element size for
> message mode and directly written to io. Am I missing something?
> 

You are right and corresponding check can be added at k3_ringacc_ring_cfg() for the case
K3_RINGACC_RING_MODE_MESSAGE and no proxy

[..]

-- 
Best regards,
grygorii
