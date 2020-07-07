Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA4216899
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGGItI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 04:49:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57702 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGItH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 04:49:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0678n1RA043856;
        Tue, 7 Jul 2020 03:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594111741;
        bh=cUKbzFPB0R56K9Sx9/yEe+icvdAzQi/ah85bcuISHR0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YldwKCTrgIjQOf/VqgYUdPHB50y3g1RSjcZMf6pQYlaygPWo66zAlMZc2k8W6VGsP
         1kxKKe6N0TP+LtE8WAkZUwFW3hXmd0/EHUp+zNnewTyyD1BPNhgBMGuIQVp3Sd94rM
         caF8btrArco4MGpQY7kUCIpBn44REfWzA8WhNw74=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0678n1QU055450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 03:49:01 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 03:49:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 03:49:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0678mxRB016975;
        Tue, 7 Jul 2020 03:48:59 -0500
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Jiri Slaby <jirislaby@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <vkoul@kernel.org>
CC:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        <dmaengine@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <f5557e02-a9b8-8d43-7ff0-6a04bdc920fc@ti.com>
Date:   Tue, 7 Jul 2020 11:50:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/07/2020 9.05, Jiri Slaby wrote:
> On 26. 06. 20, 20:09, Dave Jiang wrote:
>> Check dma device list and channel list for empty before iterate as the=

>> iteration function assume the list to be not empty. With devices and
>> channels now being hot pluggable this is a condition that needs to be
>> checked. Otherwise it can cause the iterator to spin forever.
>=20
> Could you be a little bit more specific how this can spin forever? I.e.=

> can you attach a stacktrace of such a behaviour?
>=20
> As in the empty case, "&pos->member" is "head" (look into
> list_for_each_entry) and the for loop should loop exactly zero times.

This is my understanding as well.

Isn't it more plausible that you have race between
dma_async_device_register() / dma_async_device_unregister() /
dma_async_device_channel_register() /
dma_async_device_channel_unregister() ?

It looks like that there is unbalanced locking between
dma_async_device_channel_register() and
dma_async_device_channel_unregister().

The later locks the dma_list_mutex for a short while, while the former
does not.
Both device_register/unregister locks the same dma_list_mutex in some poi=
nt.

>> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unreg=
ister of channels")
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> ---
>>
>> Rebased to dmaengine next tree
>>
>>  drivers/dma/dmaengine.c |  119 +++++++++++++++++++++++++++++++++++++-=
---------
>>  1 file changed, 94 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 2b06a7a8629d..0d6529eff66f 100644
>> --- a/drivers/dma/dmaengine.c>> +++ b/drivers/dma/dmaengine.c

=2E..

>> +static int dma_channel_enumeration(struct dma_device *device)
>> +{
>> +	struct dma_chan *chan;
>> +	int rc;
>> +
>> +	if (list_empty(&device->channels))
>> +		return 0;
>> +
>> +	/* represent channels in sysfs. Probably want devs too */
>> +	list_for_each_entry(chan, &device->channels, device_node) {
>> +		rc =3D __dma_async_device_channel_register(device, chan);
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +
>> +	/* take references on public channels */
>> +	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mas=
k))
>> +		list_for_each_entry(chan, &device->channels, device_node) {
>> +			/* if clients are already waiting for channels we need
>> +			 * to take references on their behalf
>> +			 */
>> +			if (dma_chan_get(chan) =3D=3D -ENODEV) {
>> +				/* note we can only get here for the first
>> +				 * channel as the remaining channels are
>> +				 * guaranteed to get a reference
>> +				 */
>> +				return -ENODEV;
>> +			}
>> +		}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * dma_async_device_register - registers DMA devices found
>>   * @device:	pointer to &struct dma_device
>> @@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_devic=
e *device)
>>  	if (rc !=3D 0)
>>  		return rc;
>> =20
>> +	mutex_lock(&dma_list_mutex);
>>  	mutex_init(&device->chan_mutex);
>>  	ida_init(&device->chan_ida);
>> -
>> -	/* represent channels in sysfs. Probably want devs too */
>> -	list_for_each_entry(chan, &device->channels, device_node) {
>> -		rc =3D __dma_async_device_channel_register(device, chan);
>> -		if (rc < 0)
>> -			goto err_out;
>>
>> +	rc =3D dma_channel_enumeration(device);
>> +	if (rc < 0) {
>> +		mutex_unlock(&dma_list_mutex);
>> +		goto err_out;
>>  	}

Here you effectively moved the __dma_async_device_channel_register()
under dma_list_mutex.


>> =20
>> -	mutex_lock(&dma_list_mutex);
>> -	/* take references on public channels */
>> -	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mas=
k))
>> -		list_for_each_entry(chan, &device->channels, device_node) {
>> -			/* if clients are already waiting for channels we need
>> -			 * to take references on their behalf
>> -			 */
>> -			if (dma_chan_get(chan) =3D=3D -ENODEV) {
>> -				/* note we can only get here for the first
>> -				 * channel as the remaining channels are
>> -				 * guaranteed to get a reference
>> -				 */
>> -				rc =3D -ENODEV;
>> -				mutex_unlock(&dma_list_mutex);
>> -				goto err_out;
>> -			}
>> -		}
>>  	list_add_tail_rcu(&device->global_node, &dma_device_list);
>>  	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
>>  		device->privatecnt++;	/* Always private */
>> @@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device =
*device)
>>  		return rc;
>>  	}
>> =20
>> +	if (list_empty(&device->channels))
>> +		return rc;
>> +
>>  	list_for_each_entry(chan, &device->channels, device_node) {
>>  		if (chan->local =3D=3D NULL)
>>  			continue;
>> @@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_devi=
ce *device)
>> =20
>>  	dmaengine_debug_unregister(device);
>> =20
>> -	list_for_each_entry_safe(chan, n, &device->channels, device_node)
>> -		__dma_async_device_channel_unregister(device, chan);
>> +	if (!list_empty(&device->channels))
>> +		list_for_each_entry_safe(chan, n, &device->channels, device_node)
>> +			__dma_async_device_channel_unregister(device, chan);
>> =20
>>  	mutex_lock(&dma_list_mutex);
>>  	/*
>=20
>=20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

