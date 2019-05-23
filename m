Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB25B28487
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfEWRJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 13:09:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36739 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfEWRJC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 May 2019 13:09:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so10236539edx.3;
        Thu, 23 May 2019 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JqpKKF8u4atruLZeJRlzKvhmwKnhiDpsfffFU0OwfeY=;
        b=Z7+8XpluiUSJ+/YUPE0uV14ZCVH8GfOJhzpz8+LsfeVFNh878jI9pBHJVzsNmwjX94
         ReSkwP0/sIj4vB9YFnU2wJXWgPDbsNtpXgPLWszOb32gK8mSmVfcYNnly60BgvL3zdlG
         splNHmjr/LeSRqDmbsijHH5LzezX791OHsEtxJvbfNATpbdW8NEfXcmm2sT/6Bf211F2
         t9MQ0NtjEqseHMFcRWXNGYlvk9UmhnzkBGlWZQeVvCGgrs8IDVKph6tZ0G9e1eUDwQCC
         TvXGeNtht0sqJz9DRFawaav4yLyYKXEPcfHpDa/Dn+I/RPVzJBQ/ooKz8WD4UycmrG9f
         gEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JqpKKF8u4atruLZeJRlzKvhmwKnhiDpsfffFU0OwfeY=;
        b=mqjuHeNeWvSmOYBBeqvCRU5lJj+9OoH23u8fTa9NzEJPRUXCqMazDzQjW3rsVgsRuo
         cHK90vwm6JojoR2mph1T/92hVDPj+yjm0sZQpWUUTnpk8WhOiH5ij+TTWejm0H2tmHzK
         DMraIb8sCW3EzcAbiYHXMWa1jfNIEw2sh/ljAHwniiTl8AytmiPwIUarHLl0sSE0glUj
         scmwlF3wDXn5ed1qzzI87iBLdbhT/26134TAU6StbWByzA3OnyUTTXRLmXDNUA+GJmvQ
         14PPMN5Qn9pr0GR9mpUyYR85/ar78gPHiPQZyjv6BdIt190KwPTJR4xSGlTAcwKKIJJH
         RLrg==
X-Gm-Message-State: APjAAAW+C/GJGf2BUJQWOin78uNS+D2GyWuIX/hDGkShq7c4IKwRI5Bs
        AxWzTMotR/3qloC/i6HwtwY=
X-Google-Smtp-Source: APXvYqxYkwRM0SzTeyMSlhinkKDLc5vcOeez94usU0quFrHEUKgUcbL04sMp03vL57Ghbzl0L1p87w==
X-Received: by 2002:a50:987c:: with SMTP id h57mr51649310edb.229.1558631339545;
        Thu, 23 May 2019 10:08:59 -0700 (PDT)
Received: from ziggy.stardust (charybdis-ext.suse.de. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id f44sm20208eda.73.2019.05.23.10.08.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:08:58 -0700 (PDT)
Subject: Re: [PATCH v13 1/2] arm: dts: mt2712: add uart APDMA to device tree
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Long Cheng <long.cheng@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
References: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
 <1558596909-14084-2-git-send-email-long.cheng@mediatek.com>
 <434cbd9b-face-de45-0d17-4096ad81a7b9@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <9c7fdd43-dffe-9339-272d-62311a39dbb9@gmail.com>
Date:   Thu, 23 May 2019 19:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <434cbd9b-face-de45-0d17-4096ad81a7b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/05/2019 19:04, Matthias Brugger wrote:
> 
> 
> On 23/05/2019 09:35, Long Cheng wrote:
>> 1. add uart APDMA controller device node
>> 2. add uart 0/1/2/3/4/5 DMA function
>>
>> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   51 +++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> index 43307ba..a7a7362 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> @@ -300,6 +300,9 @@
>>  		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 10
>> +			&apdma 11>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -369,6 +372,39 @@
>>  			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
>>  	};
>>  
>> +	apdma: dma-controller@11000400 {
>> +		compatible = "mediatek,mt2712-uart-dma",
>> +			     "mediatek,mt6577-uart-dma";
> 
> I was able to find a binding descpription but no actual driver.
> drivers/dma/mediatek only has hsdma and cqdma but no apdma driver.
> 
> Seems there is something missing here.
> 

Sorry I just realized that tje driver got merged from v12.

Regards,
Matthias

> Regards,
> Matthias
> 
>> +		reg = <0 0x11000400 0 0x80>,
>> +		      <0 0x11000480 0 0x80>,
>> +		      <0 0x11000500 0 0x80>,
>> +		      <0 0x11000580 0 0x80>,
>> +		      <0 0x11000600 0 0x80>,
>> +		      <0 0x11000680 0 0x80>,
>> +		      <0 0x11000700 0 0x80>,
>> +		      <0 0x11000780 0 0x80>,
>> +		      <0 0x11000800 0 0x80>,
>> +		      <0 0x11000880 0 0x80>,
>> +		      <0 0x11000900 0 0x80>,
>> +		      <0 0x11000980 0 0x80>;
>> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
>> +		dma-requests = <12>;
>> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
>> +		clock-names = "apdma";
>> +		#dma-cells = <1>;
>> +	};
>> +
>>  	auxadc: adc@11001000 {
>>  		compatible = "mediatek,mt2712-auxadc";
>>  		reg = <0 0x11001000 0 0x1000>;
>> @@ -385,6 +421,9 @@
>>  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 0
>> +			&apdma 1>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -395,6 +434,9 @@
>>  		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 2
>> +			&apdma 3>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -405,6 +447,9 @@
>>  		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 4
>> +			&apdma 5>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -415,6 +460,9 @@
>>  		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 6
>> +			&apdma 7>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>> @@ -629,6 +677,9 @@
>>  		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
>>  		clocks = <&baud_clk>, <&sys_clk>;
>>  		clock-names = "baud", "bus";
>> +		dmas = <&apdma 8
>> +			&apdma 9>;
>> +		dma-names = "tx", "rx";
>>  		status = "disabled";
>>  	};
>>  
>>
