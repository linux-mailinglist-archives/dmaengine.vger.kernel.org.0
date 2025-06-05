Return-Path: <dmaengine+bounces-5309-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAAACEF7D
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EB33AD17C
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE3D221FB8;
	Thu,  5 Jun 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tid6uU+A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B5212B3B
	for <dmaengine@vger.kernel.org>; Thu,  5 Jun 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127693; cv=none; b=nD0yx7C6W2Wrpb8afc9gf6ddOT/YeS+fP0R7wy7JYBVlbkxBUb54IhpwjxasXPs9wPGrVNFWc/CUFsVTFbOybAljaibv89Ia5cJRW1aVckAPo+q2dSXxFb9AcbbOp8QG5bxMoE21KDTaJXaNBLaeQpQ//1r1k5oP1m7LzH/tFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127693; c=relaxed/simple;
	bh=wWC8vTRxd4PCSHw6ozhyBpPg3oAWX6S9agX0DtmSV7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdWRmZcTDA7pEVATQwCYW1FFq/NifVQ4ZVqgRXzzvI3XTq2i/DnuqrrTBvAUOaJUqrUmp6tB+IRefd2rkbfjOaPnJ1JyWFya+niDN04Tg7tH2GRsiAxfdlg3Knn2zwWg0B8Ld8fjCqyBOLaugJWyYXfN9Bp7RvP9cmk+3InTVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tid6uU+A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so530811f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 05 Jun 2025 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749127688; x=1749732488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD3X3bkoKyLMyd5gKvCIGY/mSWv524B+viUEHfNcoG4=;
        b=tid6uU+AkAHmk57IwrAFgnQ9ZjzvLpPOIF5/QkAMcrZH8jTdkF6z0KgRUv+ZsQYfvP
         zRyvtxXBxW9D+JXadJMvphKJLF29X1veMxoRLQOfGlKjZHHmYFi+LDEcbkEHfOqn/GQo
         O6GWiKMmyOm9lCxQNhz/JliXgpvIHYTkOrdQmxQQr0spex8l8IZ9qg+RVDcPNYXf8Yly
         6cIcBxeKi0mh6RxgyFXILLZ4TFNRm89UN3D6x4cXbBWJOSlEetFtaWIZoPMRfL95QuhY
         9B1ekyM62fHkz71YcAczCLxGKnzvSMA8x86gR+NLqdvIvKy28eekPLMI+DWWKleRxdcJ
         v/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749127688; x=1749732488;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD3X3bkoKyLMyd5gKvCIGY/mSWv524B+viUEHfNcoG4=;
        b=rS9RUYkLwkKi6o3XRA/azxWVK3543sKJcjXExjwvfVGV0DLbM7jvMqAd3d/i6yxpGl
         PODSAh7roYFrd2iETh1LgEDTMa7TX0IcHK+VfKz/RSeEmyu4LiGKvJ6406YqmMyM4/Th
         NMSN5VAoUAQKx/Q0MRQG869SNXu7MGjt8AYPGSkqa9aTkn262XNa3RaOKMSkQIQMV5Gq
         jy7BZVFKv84iRXYDVETc8Qxi1j3jqka5lM/IgLyEsu3WcgjCzD/oFBmVa57DJZxwGY0b
         6ChhXTQyHq3fA7m1uSaBjj0b9647tyiDUrhYLfKEMGRx9Dr4nWD7DHUTn495zHYP6OkZ
         C1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnJa0H3/ScKIEeJKuCf+mc0RP/cAO2LOffUp6R4XgGWEXKf+SOiR+Wz+ORLmYlOHmqGndWXgJ1WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg125Co2tHmdckfCPSHtu3nHebMwyuEIKedcvxLCl+J46tjfxz
	63eIyDHoDnjsuz4KT2KFogizxgOihSMDPut9CFWkw0wdOADNmL28dKC27grk19jhMhc=
X-Gm-Gg: ASbGnct6u8X9jAgEK+sDpXZaIA8X/Qsb0ettU7xdHMXrwWKGK+Yd4nia63HG5jiqVBH
	tvcf2nxsDKGwW15UlzckPC7MQ9ioWro4sppth+ge8xw8Awx7TC46vk3o10bbXtjyYyNBwH98UjH
	W19N1E+FlQo3WkdL/+nfscHJIwz2hvSxuagA2o0HFbgItZJMDjqAdQoBCLat+eF99kIKfhs/hlg
	lcDQrpH3/FH1AMTIjTWiLNj+da69L2nXh39UyYRqEK754V7yI9ImhgVs5E/Ni2As7S9Rro4m6uo
	sS2vBtumZ+pyWl5Z0NsMLctbwZGfAv3vFznsNbt7vvIuK2HLddv/13HXJBc=
X-Google-Smtp-Source: AGHT+IEwmO65LIe9TsZFLYgqhHXDd2a/mab3lz1o4pMeJkOsxlaOnFsXZyBKpwTgYdWa5aLH5sL/BA==
X-Received: by 2002:a05:6000:2210:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3a51dbcd100mr5959406f8f.15.1749127688507;
        Thu, 05 Jun 2025 05:48:08 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971e4sm24840719f8f.65.2025.06.05.05.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 05:48:08 -0700 (PDT)
Message-ID: <550a7ead-99a8-44ac-af49-c0e9d79c35c9@linaro.org>
Date: Thu, 5 Jun 2025 15:48:04 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] arm64: dts: qcom: sc8280xp: Add GPI DMA
 configuration
To: Pengyu Luo <mitltlatltl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250605075434.412580-1-mitltlatltl@gmail.com>
 <20250605075434.412580-3-mitltlatltl@gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250605075434.412580-3-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/25 10:54, Pengyu Luo wrote:
> SPI on SC8280XP requires DMA (GSI) mode to function properly. Without it,
> SPI controllers fall back to FIFO mode, which causes:
> 
> [    0.901296] geni_spi 898000.spi: error -ENODEV: Failed to get tx DMA ch
> [    0.901305] geni_spi 898000.spi: FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode
> ...
> [   45.605974] goodix-spi-hid spi0.0: SPI transfer timed out
> [   45.605988] geni_spi 898000.spi: Can't set CS when prev xfer running
> [   46.621555] spi_master spi0: failed to transfer one message from queue
> [   46.621568] spi_master spi0: noqueue transfer failed
> [   46.621577] goodix-spi-hid spi0.0: spi transfer error: -110
> [   46.621585] goodix-spi-hid spi0.0: probe with driver goodix-spi-hid failed with error -110
> 
> Therefore, add GPI DMA controller nodes for qup{0,1,2}, and add DMA
> channels for SPI and I2C, UART is excluded for now, as it does not
> yet support this mode.
> 
> Note that, since there is no public schematic, this configuration

Device tree should describe the hardware, not hold a configuration. If
you are configuring hardware, DT is not the place for this. Same goes
for the commit short message.

> is derived from Windows drivers. The drivers do not expose any DMA
> channel mask information, so all available channels are enabled.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>



