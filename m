Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19CF13B1AC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgANSIY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 13:08:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49550 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSIX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 13:08:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EI35PI135086;
        Tue, 14 Jan 2020 18:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8huRquYJuRzktEGhLgBn3jch4GfJtH2XqGhnCkGfssw=;
 b=sjLkjcigTAvd2hbqEY+IHT16I8X12Wq7ECnPesHsmDHbQRezbEyd9oHjd08M/zLLFDqg
 hi5VDwFKAjeUYuj6e9YguvE9eYYGMhd7JUEGxXtzCoeGG2UPDW45I1ETz1lbj3/gNANV
 Xp5je2uSnPrmvxD4z+ai8OmRR+lKMfa+tYmxPbDXZRUMkHfu4Rz4DhtDAN4/Dg+j45i+
 qiuKZ5lWW/B/mLTXmxIeVtvqai0vf5bXwtWmBIUAhur/m2p/M6LrNJqmhu1Nmf1v6wVj
 0cKchYbG4CUGNeezEAdFtssB2fntWkimymkl1m4GvWhUaNeb4hbHHWBr69gRDVEwIWow pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73tqk92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 18:08:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EI4KsI061308;
        Tue, 14 Jan 2020 18:06:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xh2tp4n1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 18:06:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00EI688F009660;
        Tue, 14 Jan 2020 18:06:09 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 10:06:08 -0800
Subject: Re: [PATCH v8 02/18] soc: ti: k3: add navss ringacc driver
To:     Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com, frowand.list@gmail.com
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-3-peter.ujfalusi@ti.com>
 <6d70686b-a94e-18d1-7b33-ff9df7176089@ti.com>
 <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
 <ea6a87ae-b978-a786-27eb-db99483a82d9@ti.com>
 <f0230e88-bd9b-cd6d-433d-06d507cafcbd@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <9177657a-71c7-7bd0-a981-3ef1f736d4dc@oracle.com>
Date:   Tue, 14 Jan 2020 10:06:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f0230e88-bd9b-cd6d-433d-06d507cafcbd@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140143
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/14/20 12:11 AM, Sekhar Nori wrote:
> On 14/01/20 12:28 PM, Peter Ujfalusi wrote:
>> Hi Santosh,
>>
>> On 13/01/2020 23.28, santosh.shilimkar@oracle.com wrote:
>>>
>>>
>>> On 12/23/19 3:38 AM, Peter Ujfalusi wrote:
>>>> Hi Santosh,
>>>>
>>>> On 23/12/2019 13.04, Peter Ujfalusi wrote:
>>>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>>
>>>>> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
>>>>> enable straightforward passing of work between a producer and a
>>>>> consumer.
>>>>> There is one RINGACC module per NAVSS on TI AM65x SoCs.
>>>>>
>>>>> The RINGACC converts constant-address read and write accesses to
>>>>> equivalent
>>>>> read or write accesses to a circular data structure in memory. The
>>>>> RINGACC
>>>>> eliminates the need for each DMA controller which needs to access ring
>>>>> elements from having to know the current state of the ring (base
>>>>> address,
>>>>> current offset). The DMA controller performs a read or write access to a
>>>>> specific address range (which maps to the source interface on the
>>>>> RINGACC)
>>>>> and the RINGACC replaces the address for the transaction with a new
>>>>> address
>>>>> which corresponds to the head or tail element of the ring (head for
>>>>> reads,
>>>>> tail for writes). Since the RINGACC maintains the state, multiple DMA
>>>>> controllers or channels are allowed to coherently share the same
>>>>> rings as
>>>>> applicable. The RINGACC is able to place data which is destined towards
>>>>> software into cached memory directly.
>>>>>
>>>>> Supported ring modes:
>>>>> - Ring Mode
>>>>> - Messaging Mode
>>>>> - Credentials Mode
>>>>> - Queue Manager Mode
>>>>>
>>>>> TI-SCI integration:
>>>>>
>>>>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>>>>> now
>>>>> has control over Ringacc module resources management (RM) and Rings
>>>>> configuration.
>>>>>
>>>>> The corresponding support of TI-SCI Ringacc module RM protocol
>>>>> introduced as option through DT parameters:
>>>>> - ti,sci: phandle on TI-SCI firmware controller DT node
>>>>> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
>>>>>
>>>>> if both parameters present - Ringacc driver will configure/free/reset
>>>>> Rings
>>>>> using TI-SCI Message Ringacc RM Protocol.
>>>>>
>>>>> The Ringacc driver manages Rings allocation by itself now and requests
>>>>> TI-SCI firmware to allocate and configure specific Rings only. It's done
>>>>> this way because, Linux driver implements two stage Rings allocation and
>>>>> configuration (allocate ring and configure ring) while TI-SCI Message
>>>>> Protocol supports only one combined operation (allocate+configure).
>>>>>
>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>>> Reviewed-by: Tero Kristo <t-kristo@ti.com>
>>>>> Tested-by: Keerthy <j-keerthy@ti.com>
>>>>
>>>> Can you please giver your Acked-by for the ringacc patches if they are
>>>> still OK from your point of view as you had offered to take them before
>>>> I got comments from Lokesh.
>>>>
>>> Sure. But you really need to split the series so that dma engine and
>>> soc driver patches can be applied independently.
>>
>> The ringacc is a build and runtime dependency for the DMA. I have hoped
>> that all of them can go via DMAengine (hence asking for your ACK on the
>> drivers/soc/ti/ patches) for 5.6.
>>
>>> Can you please do that?
>>
>> This late in the merge window that would really mean that I will miss
>> another release for the KS3 DMA...
>> I can live with that if you can pick the ringacc for 5.6 and if Vinod
>> takes the DMAengine core changes as well.
>>
>> That would leave only the DMA drivers for 5.7 and we can also queue up
>> changes for 5.7 which depends on the DMAengine API (ASoC changes, UART,
>> sa2ul, etc).
>>
>> If they go independently and nothing makes it to 5.6 then 5.8 is the
>> realistic target for the DMA support for the KS3 family of devices...
> 
> Thats too many kernel versions to get this important piece in.
> 
> Santosh, if you do not have anything else queued up that clashes with
> this, can the whole series be picked up by Vinod with your ack on the
> drivers/soc/ti/ pieces?
> 
I would prefer driver patches to go via driver tree.

> Vinod could also perhaps setup an immutable branch based on v5.5-rc1
> with just the drivers/soc/ti parts applied so you can merge that branch
> in case you end up having to send up anything that conflicts.
> 
As suggested on other email to Peter, these DMA engine related patches
should be queued up since they don't have any dependency. Based on
the status of that patchset, will take care of pulling in the driver
patches either for this merge window or early part of next merge window.

Regards,
Santosh
