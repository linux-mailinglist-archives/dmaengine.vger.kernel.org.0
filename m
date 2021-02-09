Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12B7314F6B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 13:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhBIMrd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 07:47:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhBIMqb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 07:46:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119Cjasp102812;
        Tue, 9 Feb 2021 06:45:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612874736;
        bh=dpFap93OJFoMCL6N2sI87pM+cqa/ZFq/0zKd/+sd+CQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ew0OwIV0Szsj+MNFNtx4NQItS+gIW7Dq4IooKlJfYkEu5dNZydJ3UTdFFs2P9Z33c
         J8GlONkexma0ZWOQOwdWMpNpRYw5tDVu5QQxlfhW6wvU5kE0/BcN7FsWg0Gck4ZwyX
         /F2cvl9MlG8MkKomsxT4sdbM8o23PZhHu4/eKtSw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119Cjawm088819
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 06:45:36 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 06:45:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 06:45:36 -0600
Received: from [10.250.232.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119CjXvd084235;
        Tue, 9 Feb 2021 06:45:34 -0600
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210209090036.30832-1-kishon@ti.com>
 <19488154-22d5-33b4-06a1-17e9a896ae04@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7e06c63d-606b-be78-84ff-d5a5c72f7ad7@ti.com>
Date:   Tue, 9 Feb 2021 18:15:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <19488154-22d5-33b4-06a1-17e9a896ae04@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 09/02/21 5:53 pm, Péter Ujfalusi wrote:
> Hi Kishon,
> 
> On 2/9/21 11:00 AM, Kishon Vijay Abraham I wrote:
>> bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
>> already allocated by checking if it has a NON NULL value. For the
>> error cases, bchan/rchan/tchan/rflow will have error value
>> and bcdma_get_*() and udma_get_*() considers this as already allocated
>> (PASS) since the error values are NON NULL. This results in
>> NULL pointer dereference error while de-referencing
>> bchan/rchan/tchan/rflow.
> 
> I think this can happen when a channel request fails and we get a second
> request coming and faces with the not cleanup up tchan/rchan/bchan/rflow
> from the previous failure.
> Interesting that I have not faced with this, but it is a valid oversight
> from me.

Thank you for reviewing.

Got into this issue when all the PCIe endpoint functions were requesting
for a MEMCOPY channel (total 22 endpoint functions) specifically in
bcdma_get_bchan() where the scenario you mentioned above happened.

Vignesh asked me to fix it for all udma_get_*().
> 
>> Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
>> actually fails.
>>
>> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
> 
> Will this patch apply at any of these?
> 25dcb5dd7b7c does not have BCDMA (bchan)
> 017794739702 does not contain PKTDMA (tflow)

I can probably split this patch
017794739702 for bchan and 25dcb5dd7b7c for bchan/rchan/tchan/rflow

> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 298460438bb4..aa4ef583ff83 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -1330,6 +1330,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>>  {
>>  	struct udma_dev *ud = uc->ud;
>>  	enum udma_tp_level tpl;
>> +	int ret;
>>  
>>  	if (uc->bchan) {
>>  		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
>> @@ -1347,8 +1348,11 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>>  		tpl = ud->bchan_tpl.levels - 1;
>>  
>>  	uc->bchan = __udma_reserve_bchan(ud, tpl, -1);
>> -	if (IS_ERR(uc->bchan))
>> -		return PTR_ERR(uc->bchan);
>> +	if (IS_ERR(uc->bchan)) {
>> +		ret = PTR_ERR(uc->bchan);
>> +		uc->bchan = NULL;
>> +		return ret;
>> +	}
>>  
>>  	uc->tchan = uc->bchan;
>>  
>> @@ -1358,6 +1362,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
>>  static int udma_get_tchan(struct udma_chan *uc)
>>  {
>>  	struct udma_dev *ud = uc->ud;
>> +	int ret;
>>  
>>  	if (uc->tchan) {
>>  		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
>> @@ -1372,8 +1377,11 @@ static int udma_get_tchan(struct udma_chan *uc)
>>  	 */
>>  	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
>>  					 uc->config.mapped_channel_id);
>> -	if (IS_ERR(uc->tchan))
>> -		return PTR_ERR(uc->tchan);
>> +	if (IS_ERR(uc->tchan)) {
>> +		ret = PTR_ERR(uc->tchan);
>> +		uc->tchan = NULL;
>> +		return ret;
>> +	}
>>  
>>  	if (ud->tflow_cnt) {
>>  		int tflow_id;
>> @@ -1403,6 +1411,7 @@ static int udma_get_tchan(struct udma_chan *uc)
>>  static int udma_get_rchan(struct udma_chan *uc)
>>  {
>>  	struct udma_dev *ud = uc->ud;
>> +	int ret;
>>  
>>  	if (uc->rchan) {
>>  		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
>> @@ -1417,8 +1426,13 @@ static int udma_get_rchan(struct udma_chan *uc)
>>  	 */
>>  	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
>>  					 uc->config.mapped_channel_id);
>> +	if (IS_ERR(uc->rchan)) {
>> +		ret = PTR_ERR(uc->rchan);
>> +		uc->rchan = NULL;
>> +		return ret;
>> +	}
>>  
>> -	return PTR_ERR_OR_ZERO(uc->rchan);
>> +	return 0;
>>  }
>>  
>>  static int udma_get_chan_pair(struct udma_chan *uc)
>> @@ -1472,6 +1486,7 @@ static int udma_get_chan_pair(struct udma_chan *uc)
>>  static int udma_get_rflow(struct udma_chan *uc, int flow_id)
>>  {
>>  	struct udma_dev *ud = uc->ud;
>> +	int ret;
>>  
>>  	if (!uc->rchan) {
>>  		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
>> @@ -1485,6 +1500,11 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
>>  	}
>>  
>>  	uc->rflow = __udma_get_rflow(ud, flow_id);
>> +	if (IS_ERR(uc->rflow)) {
>> +		ret = PTR_ERR(uc->rflow);
>> +		uc->rflow = NULL;
>> +		return ret;
>> +	}
>>  
>>  	return PTR_ERR_OR_ZERO(uc->rflow);
> 
> return 0;

Will fix this.

Thanks
Kishon
