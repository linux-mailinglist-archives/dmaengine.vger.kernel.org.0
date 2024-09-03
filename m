Return-Path: <dmaengine+bounces-3067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4F96A625
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 20:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7C01F24E1C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Sep 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D518FDAB;
	Tue,  3 Sep 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQh42C54"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C20F9DF;
	Tue,  3 Sep 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386801; cv=none; b=QKIEJ8byKjFcScduZd94rdq8irmmyZWi6HyUy5sGor7DRxxE1ENgTdqA2Gite6iiBmp6lgbU2ue2F3YUv3PYCO7PYM/yrgIiwQkQmFdOuleC6R+PPI9V2M/Mk3KS1w56/LRiqRmeOu7IKU72gN4ViZJMqQZLUkWtOC9TMjF0EdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386801; c=relaxed/simple;
	bh=QBlWFVCUitxnwtkee+MaQw7kPhB3x9e9lyFjxZvuhUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J+ktwUu2CZYioxjq3YVRjG//djAts/wWO/DyO4mE/Iu18S0kOvTxvCnyR67dkBhinBlUDzA6xEinedkasQ8w8sfUV+LUIbcCy9GpSawCGNAajItrDRfq6Y9xIHFu5cxk6nOU1AJ6O1ouUROgkoumvzVvfl9ru3XEtb4+6GVfWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQh42C54; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53345dcd377so7854087e87.2;
        Tue, 03 Sep 2024 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386798; x=1725991598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXRpbXbCVh0YAZLb+6qWmUYss8TmYOa1oNMVO2XKui0=;
        b=CQh42C54A/zf5BjzyV7lPJ+KljWOZ88pAnkp1p7yCLR/XaQWl0tHxBBC8+VqUzEOUU
         OPY+3LQk1VGDploVyuoGn9IUberBBnGfK3kvmTf7HdLC4U2HE82vlJNbkttIc7XOwnwl
         02Oi96ZORpH7gVxAuKZJsTtso4sg5oKrwDfc6Hkt7NBVvXzBB3V7eizPUZCfJ2aSMzRl
         4sN2cKicBkyAfkZ3i0kJ3dv608HPr7yAY7Hy92orZCblCeVSrtRW88sRGzBKMTHNfRkO
         6JgKkDDTZc5vW+JA3cl9ZYL/yfPrejC69Vt6k9dAuIYKH+aPIapFtqYfv942sL1BmAme
         eltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386798; x=1725991598;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXRpbXbCVh0YAZLb+6qWmUYss8TmYOa1oNMVO2XKui0=;
        b=aIZ9GrQarcjyuZU/eQOdPzAp6iESKLaWsOZzVbATX5y6IK2RmWGHLCc+Rb7s61zDFV
         QaEysLRZUzu3sTcuavCCJPsL/AS0Q76937iB8UZxNB9hsSVAFfZfDsa3bI6JCr1AO1I9
         DWskIOLQnMExYil28WAM4wzzu3p31fkjB4SxzZWCXDJ52PbrjURkNKp6qTqskQrHkG0n
         jJCtDluqufhUZL+mmKWlNzrsIJHYYUzMX2M4XOVInaaYHXVBmbDvAG9JmPdagV68R8F+
         5dcD8N/Tdw/h9WYCzkV81q1Md5KBlu7nrWKIBcX7rS7noVKZfY0YjAxBsmwUskzH/nRn
         sIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHtd02yRvvyxhKJUoN/Kb4IZvRGSSQZlJloLxggAgBMEkEfcFoU8T5T9ynQB7BDNGMsJiMFNsAxBOyUJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWIb7PDiJfr10VfjPESffduUtudc2YZHHTQy6RvoKbApNCYt6
	ZCXmMV/4mw8EoQhYTcDqWLOCcR3CTLnBdcAFYHSZFgbN0qEj7rJH
X-Google-Smtp-Source: AGHT+IHJPovIlcxdpj7GDjPSGCf3ASW4Oletmm6vw7nAJOFodovFo1rmO0RWmerXoHTUB6RkuMYm/Q==
X-Received: by 2002:a05:6512:ea1:b0:52e:9c69:b25b with SMTP id 2adb3069b0e04-53546b2a85fmr9316277e87.28.1725386797488;
        Tue, 03 Sep 2024 11:06:37 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b82fsm2102561e87.17.2024.09.03.11.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 11:06:36 -0700 (PDT)
Message-ID: <ed0bb435-c7a0-490e-a1b4-3de05fdf4434@gmail.com>
Date: Tue, 3 Sep 2024 21:06:54 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Prioritize CSI RX traffic as RT
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
To: Jai Luthra <j-luthra@ti.com>, Vinod Koul <vkoul@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240827-csi_rt-v1-1-f0c5b9488a1e@ti.com>
 <69542ad0-c62f-438a-8e3e-0c827b65f0d9@gmail.com>
Content-Language: en-US
In-Reply-To: <69542ad0-c62f-438a-8e3e-0c827b65f0d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/2024 23:24, Péter Ujfalusi wrote:
> Hi,
> 
> On 27/08/2024 15:43, Jai Luthra wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> Mark BCDMA CSI RX as real-time traffic using OrderID 8/15.
>> This ensures CSI traffic takes dedicated RT path towards DDR ensuring
>> proper priority when under competing system load.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 406ee199c2ac..74cdb9ec07c3 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -135,6 +135,7 @@ struct udma_match_data {
>>  	u32 statictr_z_mask;
>>  	u8 burst_size[3];
>>  	struct udma_soc_data *soc_data;
>> +	u8 order_id;
> 
> I would add a new property to the BCDM in DT, like ti,order_id to be
> configurable by device and boards if needed.

Or should the order_id be per channel configurable? Audio is handled by
generic BCDMA and might need higher priority to avoid starvation.

But how this affect other none navss DMAs, like display?

> Static 8 and 15 in code is not too nice and begs for a question why 8
> here and why 15 there...
> 
> Even if the 'defaults' in code are these magic ones, it is still better
> to have means to adjust it without the need to recompile the kernel.
> 
>>  };
>>  
>>  struct udma_soc_data {
>> @@ -2110,6 +2111,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
>>  static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
>>  {
>>  	struct udma_dev *ud = uc->ud;
>> +	const struct udma_match_data *match_data = ud->match_data;
>>  	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>>  	struct udma_rchan *rchan = uc->rchan;
>> @@ -2120,6 +2122,11 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
>>  	req_rx.nav_id = tisci_rm->tisci_dev_id;
>>  	req_rx.index = rchan->id;
>>  
>> +	if (match_data->order_id) {
>> +		req_rx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_ORDER_ID_VALID;
>> +		req_rx.rx_orderid = match_data->order_id;
>> +	}
>> +
>>  	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>>  	if (ret)
>>  		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
>> @@ -4332,6 +4339,7 @@ static struct udma_match_data am62a_bcdma_csirx_data = {
>>  		0, /* No UH Channels */
>>  	},
>>  	.soc_data = &am62a_dmss_csi_soc_data,
>> +	.order_id = 8,
>>  };
>>  
>>  static struct udma_match_data am64_bcdma_data = {
>> @@ -4370,6 +4378,7 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
>>  		0, /* No UH Channels */
>>  	},
>>  	.soc_data = &j721s2_bcdma_csi_soc_data,
>> +	.order_id = 15,
>>  };
>>  
>>  static const struct of_device_id udma_of_match[] = {
>>
>> ---
>> base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
>> change-id: 20240827-csi_rt-fc6bff701f81
>>
>> Best regards,
> 

-- 
Péter

