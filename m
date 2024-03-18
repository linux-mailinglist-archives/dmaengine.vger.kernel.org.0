Return-Path: <dmaengine+bounces-1414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A99587E4FD
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 09:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412032826DA
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82426AF5;
	Mon, 18 Mar 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnFd5/o8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7228DA5
	for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750719; cv=none; b=FCRc+tOvMg4AKBDdhIyHV+2i/bfi9pQLPER5Kxw7PbAYnYENJnQibOXie702Lv9XP9nuQQyqKJl0a/6tEBO0BAhoikAwtk21ISL7z87kKbh+xzRPRZKiASPaebTlas0vLyJW7fG4VFZktUQzZhgS0RrEXhderBcUAJlx98psPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750719; c=relaxed/simple;
	bh=R0eRG1p0g8AFekzEpg8g23Efm7qwQnnsE/OUU/36U+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emrY6Sj72YnLr+LOZ/q264kP7OwLAAjP8ABmAsH3VW7W0dn9+sfdEI1WXbBremkPU5IltWFn1CwCBPs/HfkcBViUXDUDuDlISpr5naOyVB0nwP4wdPc7CuwiFhsj/A+xvPwPkCc1Uk4iDSXKJJ/OisMv0nTtbPnU16H81mPEKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnFd5/o8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d27184197cso56013751fa.1
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710750714; x=1711355514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkaqL4VUvAolVzlh7zZXo2NXTwTVjvOLl23zbTujtJs=;
        b=QnFd5/o8at0r7wDThT1NZ3xXbjHgKWPpZSoYb3mIUqU/fPunHXN0r5LcBK3ESd29x3
         M/ePDsG/6uBma+YHPSP/fhdqxdofPz3e1TFjx1vC+CsOo5kQSrZLKxS0xOkI6Oljk2Aj
         4XGqtWv2OwBPJGgouMIoIyYMQGOz0COL52SQs0nGAN9S1NNaAPVgNIFvsPMmhS9Gd5VB
         Tgx++d9GDUNqaBKW1Cr9/PJNvMqnO6+yHR3NqvzdfIiq9JMdjapRc3KyY3s0w+hRORnK
         KBJcXuibULbc42hfMoaSV2dFrDFy55Co8mJkqbuQTVC5FeCK5hzGEqIDx5zPB+D+DkFw
         8MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710750714; x=1711355514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkaqL4VUvAolVzlh7zZXo2NXTwTVjvOLl23zbTujtJs=;
        b=NyNCDXclW2ew5+If8AtF+RAmTU3mSpJbw8fY1bW4iKvJzRI2uCpS5s/VGyhgi/+fOr
         AV8eQd110JXE7kIcqhNM8Up5jmxkxRIpeZTYYdmRJ328o2NpeUM+wVbHTuuFeWBONSpo
         dOIjWyfGBmcBFWDMxWcAozVC6q8MCtbmEJbF/xI4XLUsy7XtUzDenAdrM16NOQNF8b/R
         ZWq8LgekUDsPOt56bvP/iGvS1Sw42vGk69snxqD19pKV0RnGSPoes7SY+ctHJoypBpCt
         vhk3WcAhVJC3cD7EWDKjtxd3HYku6Eijg9RA6y5QKAUotSaxq18S3M398qU3o3q6gjas
         NQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWGPOi8Ht8bQuNjxXCtAzbHNOxafDYQtxSvEI4juepk9zgO/q8B4H3SGgRH47/KE2JEI7dV9RXmGryx6ZIKCr2t4WwQ7zydvm97
X-Gm-Message-State: AOJu0YyZp2jI4BRrQ8ikwMGjpCEqtvD+jGcWq6oj9VZtaI2Wqq2wFq9W
	slLkxhewowtQEjxiJ/EUce9Ah9YhiADLXTYl/dE86fsAJr+vUF5sF1DGRPl/uLE=
X-Google-Smtp-Source: AGHT+IF8BwkyGolz3Y4dFOmRR86m1u0FNVDwGjjC6/3D0n+z5RwK0t/J9JJacVXZjKERYQ/wRPUQbg==
X-Received: by 2002:a2e:aa98:0:b0:2d2:2dbb:389e with SMTP id bj24-20020a2eaa98000000b002d22dbb389emr7645733ljb.23.1710750714337;
        Mon, 18 Mar 2024 01:31:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id p8-20020a50cd88000000b0056851310a04sm4607099edi.16.2024.03.18.01.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:31:53 -0700 (PDT)
Message-ID: <15f0584a-d192-4b0c-99c9-a9584d49f412@linaro.org>
Date: Mon, 18 Mar 2024 09:31:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Content-Language: en-US
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <6da5b070-e61a-4526-833f-1af1bde988e1@linaro.org>
 <IA1PR20MB49537B387D0BC4052AE90812BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB49537B387D0BC4052AE90812BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 09:30, Inochi Amaoto wrote:
>>> @@ -0,0 +1,47 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo CV1800/SG200 Series DMA mux
>>> +
>>> +maintainers:
>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>> +
>>> +allOf:
>>> +  - $ref: dma-router.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: sophgo,cv1800-dmamux
>>> +
>>> +  reg:
>>> +    maxItems: 2
>>
>> You need to describe the items.
>>
> 
> I wonder whether reg-name should be introduced, or item description is
> just enough?

items:
 - description:
 - description:

is enough

> 
>>> +
>>> +  '#dma-cells':
>>> +    const: 3
>>> +    description:
>>> +      The first cells is DMA channel. The second one is device id.
>>> +      The third one is the cpu id.
>>> +
>>> +  dma-masters:
>>> +    maxItems: 1
>>> +
>>> +  dma-requests:
>>> +    const: 8
>>> +
>>> +required:
>>> +  - '#dma-cells'
>>
>> reg is not required? How do you perform any IO?
> 
> This device is part of the syscon. The IO is performed by the offset.
> In the v2, Rob suggest me add the "reg" property to describe registers.
> He also mentioned that driver may not use this info, so I do not make
> this a must.

OK

Best regards,
Krzysztof


