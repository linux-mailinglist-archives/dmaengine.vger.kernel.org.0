Return-Path: <dmaengine+bounces-1441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977087F668
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 05:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A96B220AC
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 04:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D933C7C08F;
	Tue, 19 Mar 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EG1dHoQu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D87C086
	for <dmaengine@vger.kernel.org>; Tue, 19 Mar 2024 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822462; cv=none; b=jcXSBwrT3xB0Ar4TH6GKNxFnZzDgcrEywjPp85stiHUDY+gSFA4i9pe/XR69aeF5W/mAjxPTQSMDP0CKamdnOBzbZt7I7T05CCIRwvYcX+W5YGOdCpMm6V2gxbH/bemPLVLEoBy3g2w7k747jPiI1UanBuhniVFRQC3MWrmZc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822462; c=relaxed/simple;
	bh=JmzK7Zbo9hPfx8/XuPbiw7bbbYqr8mArE5GHiVVNrjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctw7zVwexh8rvZMF/27rqjgLfvlBQ47AqP0v0DMxD4yFegTz+sLO2tHsgKPC+Z9sk1JyZGVG5RjQrXbPJvxK7Q8AHRr5T0ftE/DipCDs7XlCs5Dd1smGzd37um/m1c2FxVdGRLUEbH8ZeHWVk1yQgnmpISov4Km1wvJHPNHt7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EG1dHoQu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc236729a2bso4891018276.0
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710822460; x=1711427260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fSeo85Yh8XHxlmyjnlgCbtVU1rId28fL57bIXUgDgo=;
        b=EG1dHoQuB8X3FzCPLvHnp6iB2AabsZCpU2YR0veCsHJtgP49hLJ+vdtxXeGprJj98W
         OvYQykEJlZCYtTLuNQvW8ky8EJ4v5l8yiwgwJgp6P6f29FpkBABzN45U7bVrQZbCpmh/
         1w9ilYtFMGaE42LbbseopvEogU/mX5UgYUEHbZgZiMofpNmrqzAlvP/m7HXKrpU+Kg/e
         6VBD2mt75GyZtbQ4vw4CGatR6goOZa+Q8LpDk5Y0nHyIu75/SdrKPjGCLL96FYoV00hy
         RZqNko1YrvYiWoovAB4D96+HHSwvRfwLdnopJ+aAfBeAxpZROq1UlgmBv+1d/T1fqixE
         Hzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710822460; x=1711427260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fSeo85Yh8XHxlmyjnlgCbtVU1rId28fL57bIXUgDgo=;
        b=lxO3Z0VGR1NwQuHMkSE+EQ6DawiJMDtkhlsdmtOxcB3BIPGCrrgAScu+P6y4JYMi7w
         9Q2vX70GiWYtihn6emdJtq4O4T1FXM5u9wy6NGmNFU8ou6P7s9RwIeHsrPjdV8V/uxdL
         1gzFrbR/rH5MbJc9M8rTJTTqAn8I/vcyKHoI0XIAmtq0WbgaUOQk5mwIiEb5/euv/EtQ
         9RJVvtUtaTOkk5D7r1U9BfXTpYYzeuyRgew1K/873LD7PCh496BjKxbTtnOHZuZaixM4
         VFDPwrCRiR7sn2o1PYblEpLQ7A5Eer+mPdipDJC15aqBP98fNpRzFdNxOfZ/DJdZx2yb
         i9cg==
X-Forwarded-Encrypted: i=1; AJvYcCWJPJ1bpljU+ZCrJIjHCuolHMSMToTFL87fEgtppi+cnVNoQ8+SKtcU81avDQwUekHTDCMyUehzdmKr8LT7sDCctyqLTuAOrMyF
X-Gm-Message-State: AOJu0Yy55bXXkMZE1QtIPWSKvQKlX0aAP13HtVXzXC+ylElHHkngsdY8
	BWbF1VcgeaREY7p2nXsOf0gAeuW9mdyuvXvkUN23gXqEXs+PuVaOXyTPuFO/N5s=
X-Google-Smtp-Source: AGHT+IHgaLA2b2A4WmPe+4Rv2P3Jrxx3QjSR6PArx5q5wlgmR/45U+DUfpoQCzkEkaNfhEua0UrDTA==
X-Received: by 2002:a25:db85:0:b0:dc6:238e:d766 with SMTP id g127-20020a25db85000000b00dc6238ed766mr13124502ybf.2.1710822460000;
        Mon, 18 Mar 2024 21:27:40 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id w12-20020a02968c000000b004743bc59379sm2659823jai.59.2024.03.18.21.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 21:27:39 -0700 (PDT)
Message-ID: <b4863d37-2182-479d-8ca2-79951badfb8d@sifive.com>
Date: Mon, 18 Mar 2024 23:27:37 -0500
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
 Conor Dooley <conor+dt@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <29f468c5-1aaa-4326-8088-e03a1d6b7174@sifive.com>
 <IA1PR20MB495363835DD4C6B0EA2DA224BB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <IA1PR20MB495363835DD4C6B0EA2DA224BB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Inochi,

On 2024-03-18 11:03 PM, Inochi Amaoto wrote:
> On Mon, Mar 18, 2024 at 10:22:47PM -0500, Samuel Holland wrote:
>> On 2024-03-18 1:38 AM, Inochi Amaoto wrote:
>>> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
>>> an additional channel remap register located in the top system control
>>> area. The DMA channel is exclusive to each core.
>>>
>>> Add the dmamux binding for CV18XX/SG200X series SoC
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 47 ++++++++++++++++
>>>  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
>>>  2 files changed, 102 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
>>>  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
>>> new file mode 100644
>>> index 000000000000..c813c66737ba
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
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
>>> +
>>> +  '#dma-cells':
>>> +    const: 3
>>> +    description:
>>> +      The first cells is DMA channel. The second one is device id.
>>> +      The third one is the cpu id.
>>
>> There are 43 devices, but only 8 channels. Since the channel is statically
>> specified in the devicetree as the first cell here, that means the SoC DT author
>> must pre-select which 8 of the 43 devices are usable, right? 
> 
> Yes, you are right.
> 
>> And then the rest
>> would have to omit their dma properties. Wouldn't it be better to leave out the
>> channel number here and dynamically allocate channels at runtime?
>>
> 
> You mean defining all the dma channel in the device and allocation channel
> selectively? This is workable, but it still needs a hint to allocate channel.

I mean allocating hardware channels only when a channel is requested by a client
driver. The dmamux driver could maintain a counter and allocate the channels
sequentially -- then the first 8 calls to cv1800_dmamux_route_allocate() would
succeed and later calls from other devices would fail.

> Also, according to the information from sophgo, it does not support dynamic 
> channel allocation, so all channel can only be initialize once.

That's important to know. In that case, the driver should probably leave the
registers alone in cv1800_dmamux_free(), and then scan to see if a device is
already mapped to a channel before allocating a new one. (Or it should have some
other way of remembering the mapping.) That way a single client can repeatedly
allocate/free its DMA channel without consuming all of the hardware channels.

> There is another problem, since we defined all the dmas property in the device,
> How to mask the devices if we do not want to use dma on them? I have see SPI
> device will disable DMA when allocation failed, I guess this is this mechanism
> is the same for all devices?

I2C/SPI/UART controller drivers generally still work after failing to acquire a
DMA channel. For audio-related drivers, DMA is generally a hard dependency.

If each board has 8 or fewer DMA-capable devices enabled in its DT, there is no
problem. If some board enables more than 8 DMA-capable devices, then it should
use "/delete-property/ dmas;" on the devices that would be least impacted by
missing DMA. Otherwise, which devices get functional DMA depends on driver probe
order.

Normally you wouldn't need to do "/delete-property/ dmas;", because many drivers
only request the DMA channel when actively being used (e.g. userspace has the
TTY/spidev/ALSA device file open), but this doesn't help if you can only assign
each channel once.

Regards,
Samuel

>>> +
>>> +  dma-masters:
>>> +    maxItems: 1
>>> +
>>> +  dma-requests:
>>> +    const: 8
>>> +
>>> +required:
>>> +  - '#dma-cells'
>>> +  - dma-masters
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    dma-router {
>>> +      compatible = "sophgo,cv1800-dmamux";
>>> +      #dma-cells = <3>;
>>> +      dma-masters = <&dmac>;
>>> +      dma-requests = <8>;
>>> +    };
>>> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
>>> new file mode 100644
>>> index 000000000000..3ce9dac25259
>>> --- /dev/null
>>> +++ b/include/dt-bindings/dma/cv1800-dma.h
>>> @@ -0,0 +1,55 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>>> +
>>> +#ifndef __DT_BINDINGS_DMA_CV1800_H__
>>> +#define __DT_BINDINGS_DMA_CV1800_H__
>>> +
>>> +#define DMA_I2S0_RX		0
>>> +#define DMA_I2S0_TX		1
>>> +#define DMA_I2S1_RX		2
>>> +#define DMA_I2S1_TX		3
>>> +#define DMA_I2S2_RX		4
>>> +#define DMA_I2S2_TX		5
>>> +#define DMA_I2S3_RX		6
>>> +#define DMA_I2S3_TX		7
>>> +#define DMA_UART0_RX		8
>>> +#define DMA_UART0_TX		9
>>> +#define DMA_UART1_RX		10
>>> +#define DMA_UART1_TX		11
>>> +#define DMA_UART2_RX		12
>>> +#define DMA_UART2_TX		13
>>> +#define DMA_UART3_RX		14
>>> +#define DMA_UART3_TX		15
>>> +#define DMA_SPI0_RX		16
>>> +#define DMA_SPI0_TX		17
>>> +#define DMA_SPI1_RX		18
>>> +#define DMA_SPI1_TX		19
>>> +#define DMA_SPI2_RX		20
>>> +#define DMA_SPI2_TX		21
>>> +#define DMA_SPI3_RX		22
>>> +#define DMA_SPI3_TX		23
>>> +#define DMA_I2C0_RX		24
>>> +#define DMA_I2C0_TX		25
>>> +#define DMA_I2C1_RX		26
>>> +#define DMA_I2C1_TX		27
>>> +#define DMA_I2C2_RX		28
>>> +#define DMA_I2C2_TX		29
>>> +#define DMA_I2C3_RX		30
>>> +#define DMA_I2C3_TX		31
>>> +#define DMA_I2C4_RX		32
>>> +#define DMA_I2C4_TX		33
>>> +#define DMA_TDM0_RX		34
>>> +#define DMA_TDM0_TX		35
>>> +#define DMA_TDM1_RX		36
>>> +#define DMA_AUDSRC		37
>>> +#define DMA_SPI_NAND		38
>>> +#define DMA_SPI_NOR		39
>>> +#define DMA_UART4_RX		40
>>> +#define DMA_UART4_TX		41
>>> +#define DMA_SPI_NOR1		42
>>> +
>>> +#define DMA_CPU_A53		0
>>> +#define DMA_CPU_C906_0		1
>>> +#define DMA_CPU_C906_1		2
>>> +
>>> +
>>> +#endif // __DT_BINDINGS_DMA_CV1800_H__
>>> --
>>> 2.44.0
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>


