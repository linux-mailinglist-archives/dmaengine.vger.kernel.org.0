Return-Path: <dmaengine+bounces-545-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87879815EAE
	for <lists+dmaengine@lfdr.de>; Sun, 17 Dec 2023 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF15A1C20D8A
	for <lists+dmaengine@lfdr.de>; Sun, 17 Dec 2023 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88914F67;
	Sun, 17 Dec 2023 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcN/nZQ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502314A8C;
	Sun, 17 Dec 2023 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso691680e87.0;
        Sun, 17 Dec 2023 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811926; x=1703416726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVaoHOugQCjoBeCUQCROATdMVPZhczmT0nXVc10IcmQ=;
        b=DcN/nZQ46F0YaWknaUurqVpl/Icj3JWiHNlzXqNrIBvZvaQh6juLIcolCl0Qc24uzO
         SDXiuxICTqpL4m9kK5YeOi9dvso80C/3aX0UrHm67vlHUZ5eMi0bgOO85vdhbyohujl/
         3Td2Rh/VW0dvyVxD3+RlpA1Nk+veczadhEn5Bb0N1iWOihLmIolvFtXGcbzCMRS4nt/6
         EqzvEXwejt6Au1g4K5nzApXKUGChiPTWyW+giyVsA2Jdd6bGyjhcgg8/p94/NEynMPI3
         OThurLKN/BLNAPhw2Psi3viCM2O/I5oedW9Q6Ux8bftLzvBus2+5jAYQWwNnnW7aXes+
         0t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811926; x=1703416726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVaoHOugQCjoBeCUQCROATdMVPZhczmT0nXVc10IcmQ=;
        b=xLOjMlNNFfzQPbVMG3wvJw1NJDH7uo9AdCwjcH1xvIwqc6tJziG9cp9LagI2eRS3mX
         n+63+fb27YtiyttzcBMIYxoEqxo+NiFCYTVGEaqjBY80uWLX1Xkuwi3cs9oNo+cA8eXL
         EXaDE7GVsyCm5fPcksLKrL6xJPZm5chDXhzpH3uSaOIqHPeo/0xSPv2r/FOv3mCRzTxs
         DigcISRkGSHHOsoCjx8WbxrQh4tZQrhm4zOoXgv/J0ldgqvm+9O+hTVcBjw5U+D7B6BK
         nTrXgmLScqn9kZ2ac4Xy/BDwGLlljAwbMLCyljUoQGqHtC1/K8f8TOgHEkighB3xVLnY
         jTkw==
X-Gm-Message-State: AOJu0Yx2eJ8+cqdaikgTdt2FhCUhVGGZB4cp9zmk1La0AHrmPvdLB6qN
	oqzxHcBz584VNgzZLKTwyZI=
X-Google-Smtp-Source: AGHT+IHnRDsQTdFGn8VoI2F0jH7gUUu9jMqny0v7tiwgjsJ6lKss9pqbEAd0yz+jQaJqVo8E6d06PQ==
X-Received: by 2002:a05:6512:1294:b0:50e:1393:c0e2 with SMTP id u20-20020a056512129400b0050e1393c0e2mr4825807lfs.103.1702811926020;
        Sun, 17 Dec 2023 03:18:46 -0800 (PST)
Received: from [10.0.0.100] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id e4-20020a196904000000b0050e3720e977sm79066lfc.56.2023.12.17.03.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 03:18:45 -0800 (PST)
Message-ID: <604657b5-0b88-4108-afd3-8cc88e10b16c@gmail.com>
Date: Sun, 17 Dec 2023 13:18:59 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dmaengine: ti: k3-udma-glue: Add function to
 request TX channel by ID
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com, vigneshr@ti.com
References: <20231212111011.1401641-1-s-vadapalli@ti.com>
 <20231212111011.1401641-4-s-vadapalli@ti.com>
 <800ccf2e-65cc-4524-8a42-1657a5906482@gmail.com>
 <4f13681a-dc13-4de2-a0d5-9f85a4c350d4@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <4f13681a-dc13-4de2-a0d5-9f85a4c350d4@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/12/2023 08:08, Siddharth Vadapalli wrote:
>>>  err:
>>> @@ -395,6 +410,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>>>  }
>>>  EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
>>>  
>>> +struct k3_udma_glue_tx_channel *
>>> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
>>> +				  struct device_node *udmax_np, u32 thread_id)
>>
>> udmax_np is not dev->of_node ?
> 
> I am not sure I fully understand the question. If you meant to ask if the driver
> which uses this API will not have its device's of_node set to udmax_np, then yes
> that's correct.
> 
> The driver shall be probed over RPMsg-bus, due to which its device's of_node
> will not be udmax_np. Additionally, the udmax_np is the device-tree node of one
> of the DMA Controllers described in the device-tree. The driver shall obtain the
> reference to the udmax_np node using the API:
> of_find_compatible_node()
> with the compatible to be passed to the above API being a part of the driver's
> data. Thus, it is possible to specify which DMA Controller to use by specifying
> the compatible in the driver's data. I hope that I have answered your question.
> Please let me know otherwise.

I see, thank you for the detailed explanation!

> Thank you for reviewing the series. I will rename the API as mentioned above and
> if the question you had above regarding the of_node has been addressed, I will
> post the v3 series. Kindly let me know.

I don't have other open issues, thanks for the updates

-- 
Péter

