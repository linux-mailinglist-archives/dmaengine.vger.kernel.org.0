Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3C23A6E2
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHCMzv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 08:55:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52356 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgHCMze (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 08:55:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073CtOKY110727;
        Mon, 3 Aug 2020 07:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596459324;
        bh=WYNukEVRHfZsaR36KvZkUDOLNg6q0B0GBqASCxqL5Uk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=daUCzK1lBs5eUhC5ZhbT3vEBNO9ujIy5fs1Dd5XN26bsggte826Hi9EeASTtzpbOB
         YsjLLADA5eXmwv5YRxUucnv8hmTs83gtIYQ1+iIQXdZ+Q+rHwhhWTKprBGuhLUtzUW
         OIBWOe/MGIckgWZ/fWecPtyM0nupC7E+JUQscgPs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073CtOI9079018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 07:55:24 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 07:55:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 07:55:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073CtL4R083147;
        Mon, 3 Aug 2020 07:55:22 -0500
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-psil: Use soc_device_match to get
 the psil map
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
References: <20200803101128.20885-1-peter.ujfalusi@ti.com>
 <20200803101128.20885-2-peter.ujfalusi@ti.com>
 <20200803111436.GN12965@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5ac0498e-8874-4864-c823-d9648c381411@ti.com>
Date:   Mon, 3 Aug 2020 15:56:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803111436.GN12965@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 03/08/2020 14.14, Vinod Koul wrote:
> On 03-08-20, 13:11, Peter Ujfalusi wrote:
>> Instead of separate of_machine_is_compatible() it is better to use
>> soc_device_match() and soc_device_attribute struct to get the PSI-L ma=
p
>> for the booted device.
>>
>> By using soc_device_match() it is easier to add support for new device=
s.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/k3-psil.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
>> index fb7c8150b0d1..3ca29aabac93 100644
>> --- a/drivers/dma/ti/k3-psil.c
>> +++ b/drivers/dma/ti/k3-psil.c
>> @@ -9,11 +9,18 @@
>>  #include <linux/init.h>
>>  #include <linux/mutex.h>
>>  #include <linux/of.h>
>> +#include <linux/sys_soc.h>
>> =20
>>  #include "k3-psil-priv.h"
>> =20
>>  static DEFINE_MUTEX(ep_map_mutex);
>> -static struct psil_ep_map *soc_ep_map;
>> +static const struct psil_ep_map *soc_ep_map;
>> +
>> +static const struct soc_device_attribute k3_soc_devices[] =3D {
>> +	{ .family =3D "AM65X", .data =3D &am654_ep_map },
>> +	{ .family =3D "J721E", .data =3D &j721e_ep_map },
>> +	{ /* sentinel */ }
>> +};
>> =20
>>  struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>>  {
>> @@ -21,15 +28,17 @@ struct psil_endpoint_config *psil_get_ep_config(u3=
2 thread_id)
>> =20
>>  	mutex_lock(&ep_map_mutex);
>>  	if (!soc_ep_map) {
>> -		if (of_machine_is_compatible("ti,am654")) {
>> -			soc_ep_map =3D &am654_ep_map;
>> -		} else if (of_machine_is_compatible("ti,j721e")) {
>> -			soc_ep_map =3D &j721e_ep_map;
>> +		const struct soc_device_attribute *soc;
>> +
>> +		soc =3D soc_device_match(k3_soc_devices);
>> +		if (soc) {
>> +			soc_ep_map =3D soc->data;
>>  		} else {
>>  			pr_err("PSIL: No compatible machine found for map\n");
>>  			mutex_unlock(&ep_map_mutex);
>>  			return ERR_PTR(-ENOTSUPP);
>>  		}
>> +
>=20
> not related

True, I'll drop it.

>=20
>>  		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
>>  	}
>>  	mutex_unlock(&ep_map_mutex);

Thanks,
- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

