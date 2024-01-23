Return-Path: <dmaengine+bounces-807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE221838873
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 09:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12741C22F88
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE3955E65;
	Tue, 23 Jan 2024 08:06:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750A481C6;
	Tue, 23 Jan 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997180; cv=none; b=Yw37sSOcjTHcImvkeSK0N4rfGH0YZhXNccGVgt0WfCs7ncd+EPlJ7ujEOjwXSYr9ZKKbZb9g0pnhP0iP0DKRfxPPLKoPD+zdgDbGjHOiDtEdVsk6Lm1tuvktB72TBGCDMpHUX4uQpliRhNUHc36QJYkmCwkOs9ye0ZZpVjJ8okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997180; c=relaxed/simple;
	bh=4/K55dB9rh4UZmkNTtpX2GXfSp70c5vicsJHlLGsTA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWvjsYpjUX3dQrXAzWK+G43mTPIMXXMtf7WyPu1WcZxLhc3/iU9suDrIRprw+9iMmqc4ZF8df//ftu2XfvcQkoskxsKKWbi4t7bUkqIczZyVdF7J4SbIVSjF/qrLbAR5VNfO4JDsZIHC8pWLOxgES/CT8//4LWJC2F8nRA9c+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f2a04d7271c4a8bb35cbb34bf93eb72-20240123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6ee0d275-512d-4ca5-93e0-c4010540e78b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:6ee0d275-512d-4ca5-93e0-c4010540e78b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:84ae8e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:24012219255757WX6MZL,BulkQuantity:5,Recheck:0,SF:19|44|64|66|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3f2a04d7271c4a8bb35cbb34bf93eb72-20240123
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1568919713; Tue, 23 Jan 2024 16:00:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 19C69E000EBA;
	Tue, 23 Jan 2024 16:00:44 +0800 (CST)
X-ns-mid: postfix-65AF722C-37049320
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id CF4ADE000EBA;
	Tue, 23 Jan 2024 16:00:38 +0800 (CST)
Message-ID: <ea1a51bb-4e82-4df6-88b3-e080448eb4ab@kylinos.cn>
Date: Tue, 23 Jan 2024 16:00:38 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Add a null pointer check to the
 dma_request_chan
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118033052.193282-1-chentao@kylinos.cn>
 <Za5QoCO_o0duPJ4J@matsya>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <Za5QoCO_o0duPJ4J@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.

On 2024/1/22 19:25, Vinod Koul wrote:
> On 18-01-24, 11:30, Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/dma/dmaengine.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 491b22240221..a6f808d13aa4 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -856,6 +856,8 @@ struct dma_chan *dma_request_chan(struct device *d=
ev, const char *name)
>>   #ifdef CONFIG_DEBUG_FS
>>   	chan->dbg_client_name =3D kasprintf(GFP_KERNEL, "%s:%s", dev_name(d=
ev),
>>   					  name);
>> +	if (!chan->dbg_client_name)
>> +		return chan;
>=20
> That is wrong, you cant return a half done channel here
> Pls see rest of the code for reference
I handle the error path like line 862 in 'dma_request_chan', though i=20
think it's not so perfect. Why it just return chan in line 862 when in=20
error? I would be very grateful if it could help me solve this puzzle

dma_request_chan find and return the ``name`` DMA channel associated=20
with the 'dev' device. The association is done via DT, ACPI or board=20
file based dma_slave_map matching table.

So when error occurs, just do the opposite, like in 'dma_release_channel'=
.

look likes:
---

         chan->dbg_client_name =3D kasprintf(GFP_KERNEL, "%s:%s",=20
dev_name(dev),
                                           name);
+       if (!chan->dbg_client_name) {
+               dma_cap_clear(DMA_SLAVE, chan->device->cap_mask);
+               dma_cap_zero(chan->device->cap_mask);
+               dma_chan_put(chan);
+               chan->slave =3D NULL;
+               chan =3D NULL;
+               return chan;
+       }

---
It's that right by clear the cap and set chan to NULL=EF=BC=9F


>=20
>>   #endif
>>  =20
>>   	chan->name =3D kasprintf(GFP_KERNEL, "dma:%s", name);
>> --=20
>> 2.39.2
>=20
--=20
Thanks,
   Kunwu


