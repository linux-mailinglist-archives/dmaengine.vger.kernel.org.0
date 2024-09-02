Return-Path: <dmaengine+bounces-3062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2221C968ED4
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 22:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7410BB2186E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362E1A3A96;
	Mon,  2 Sep 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMQjbA2Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D611A4E71;
	Mon,  2 Sep 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308657; cv=none; b=gKQkTMT5sCHpnijlfosWtYWWZnykT2xuGGh2FMM2jmhD4EgTW+uJEeVsOKY9D50xoyU3wbsvipRHC1vx770kQ9OYWQtfdHq4lTJCeSr9jEHgfSpU/xzeKnylWFMoxKt/wupZyhP8FjMAdwgcI0v9JUppa99mM7GMv+eyPVKExSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308657; c=relaxed/simple;
	bh=6xjFkK8uQbkRpwUViOiTPrGX2TrUAF95kC/YUuLceRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBfnW7vbPeyP9p/20TqrVA+x8kAQoQy6ftF3EE5+S7Zd+UmYItvNXJh9vXlO6+l/fY2cVfy3DDptK9ePyaVmdR+OUSXXpqCzpye3GURRSAOE3VoPZZmMf/PBojhCctoo/kAaAo1+3Kxf/Q0MgMyYB13VtY9scB2iAnzzeujFgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMQjbA2Q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533488ffaf7so6218725e87.0;
        Mon, 02 Sep 2024 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725308654; x=1725913454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjYzoPE30IKiODDIsmnQBQJ3DNrH0uPLBC0b4MyV0qg=;
        b=gMQjbA2QGdHOXId0NCHcp1P9Z5bEsCfWtqcjnZ0xXnBU16GLfoseB/vFQKtf0fdo87
         uz8B4gkWBWRxQ5tSHKRXlRsqQq23qtnn8SpE2GiezRO2RnxC3FCK5H8maxNBUx+5czku
         PqLNUSmog+dPxUgKwgTJwnq3Kpn8rOhaWQFbiPrpaqAUlG3JfpHhPDrcBuqqIVm4GrcJ
         RDf1/Hg/X1A8j+8BjzqBWy/3DXjL04VtkM7o0IxXvnMU7/wn5TeC7D0c9Zh+Z7gaOrYI
         2AyR7k/eMkGvljnlcMl1TPAPMtT3/UBPXfb8XBZadTf0Zjf+KcvmRnZpiQN2uchfI9kx
         +sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308654; x=1725913454;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjYzoPE30IKiODDIsmnQBQJ3DNrH0uPLBC0b4MyV0qg=;
        b=pTxVWVO5S0+VPFAL3BSfi9UmVgOz0FuZ5kmGLe4pm/nV8Sl0BKsXCY/iN40VFgehLp
         PgnIpfQY0RmsdXBQeUUoO5yNba6dRtvov/xE0Ni+LkLh3TTazL7Ye76AsXFqgipSmCkb
         ScUG76LCMAZghbmkXXmRhZwcgJn8+rnhjnfjLMFw+bjICC2/5/Ya2OCkmyisWVw4PvDS
         9kPkDOWTNncBXZa9uJd0Nn5/Rd9wrRdt45lctPx+00OYgy/69Hu3O2JTtkA2Sn/q+kiC
         rW/if2Ays1M1vZ5NhQ6zILSxC+Mrb7J/hbLUOmQh3Bhhy9wLc7xo+dMOL0hG4K5b1ag5
         HvYg==
X-Forwarded-Encrypted: i=1; AJvYcCXr4cNc+f6Iu0mYkfM3utU2rJTxNRGZoLu2Jqj/kQGgYDD0rfLAnNmC9w6bP5js9uYutjrSdSE3tdN4I8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVI4hvtSs/D3C769jw6YVP3F9tal7bb6zTdNWCNZQfqg2Zb8P
	wCaCGBf1Gn4Xeivzcu5e7xDgZ6g1BdZD4dBQ7WFLohwocI6YWWGn8XJMhZS5
X-Google-Smtp-Source: AGHT+IFvaLXhQ3odHosU+v+xvcXY7Z0ZYL1ynkaCmNKR5oz4hj/aSVSQ6wLw45eSqhtEQsVOjV0wSA==
X-Received: by 2002:a05:6512:3ba9:b0:535:3c94:70c2 with SMTP id 2adb3069b0e04-53546b2584cmr9761488e87.19.1725308653936;
        Mon, 02 Sep 2024 13:24:13 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bbcbsm1747104e87.9.2024.09.02.13.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 13:24:13 -0700 (PDT)
Message-ID: <69542ad0-c62f-438a-8e3e-0c827b65f0d9@gmail.com>
Date: Mon, 2 Sep 2024 23:24:30 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Prioritize CSI RX traffic as RT
To: Jai Luthra <j-luthra@ti.com>, Vinod Koul <vkoul@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240827-csi_rt-v1-1-f0c5b9488a1e@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240827-csi_rt-v1-1-f0c5b9488a1e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27/08/2024 15:43, Jai Luthra wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Mark BCDMA CSI RX as real-time traffic using OrderID 8/15.
> This ensures CSI traffic takes dedicated RT path towards DDR ensuring
> proper priority when under competing system load.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 406ee199c2ac..74cdb9ec07c3 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -135,6 +135,7 @@ struct udma_match_data {
>  	u32 statictr_z_mask;
>  	u8 burst_size[3];
>  	struct udma_soc_data *soc_data;
> +	u8 order_id;

I would add a new property to the BCDM in DT, like ti,order_id to be
configurable by device and boards if needed.

Static 8 and 15 in code is not too nice and begs for a question why 8
here and why 15 there...

Even if the 'defaults' in code are these magic ones, it is still better
to have means to adjust it without the need to recompile the kernel.

>  };
>  
>  struct udma_soc_data {
> @@ -2110,6 +2111,7 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
>  static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
> +	const struct udma_match_data *match_data = ud->match_data;
>  	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>  	struct udma_rchan *rchan = uc->rchan;
> @@ -2120,6 +2122,11 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
>  	req_rx.nav_id = tisci_rm->tisci_dev_id;
>  	req_rx.index = rchan->id;
>  
> +	if (match_data->order_id) {
> +		req_rx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_ORDER_ID_VALID;
> +		req_rx.rx_orderid = match_data->order_id;
> +	}
> +
>  	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>  	if (ret)
>  		dev_err(ud->dev, "rchan%d cfg failed %d\n", rchan->id, ret);
> @@ -4332,6 +4339,7 @@ static struct udma_match_data am62a_bcdma_csirx_data = {
>  		0, /* No UH Channels */
>  	},
>  	.soc_data = &am62a_dmss_csi_soc_data,
> +	.order_id = 8,
>  };
>  
>  static struct udma_match_data am64_bcdma_data = {
> @@ -4370,6 +4378,7 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
>  		0, /* No UH Channels */
>  	},
>  	.soc_data = &j721s2_bcdma_csi_soc_data,
> +	.order_id = 15,
>  };
>  
>  static const struct of_device_id udma_of_match[] = {
> 
> ---
> base-commit: 6f923748057a4f6aa187e0d5b22990d633a48d12
> change-id: 20240827-csi_rt-fc6bff701f81
> 
> Best regards,

-- 
Péter

