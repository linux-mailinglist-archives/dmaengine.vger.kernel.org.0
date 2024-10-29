Return-Path: <dmaengine+bounces-3635-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806179B4EF8
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41251C22957
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FA196455;
	Tue, 29 Oct 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="V3PYjkVL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C63234;
	Tue, 29 Oct 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218297; cv=none; b=VEFT83zHFKWOtOck+NbLrxcZCSuQ7ilWlD7N1sZ+D1tfNmgk3gFQ2MBqo92pAAKFeqC/ZwCmwLVIcmQFO6G1qu5hyiRBfIdSx6EDTb6vTjjQi6tsZ0QvF+TacdY+nNoLgRCkLHjDOOlSdydUNvO3TFliC4Rk2zsogdc69fyHXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218297; c=relaxed/simple;
	bh=HIzrdGWI3IONHky7NnivXt0fzPZAZxo29SfCs8w6Hyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jHLENYRIGW2mnCvcgKUNIufCjL7mSXXhYOomB2j4+ytwA+J9CyaeQAfjaFHr3hNwYR/M1Z8r9gwT+ytmq7zl1y256kpMqeKE01l+oHyv2NNz4oA8YevZW4FmwQzzEyVd+Bc8ECOCuyhkCH8GTnzoJj4kuPqcA+ikonhxB4RTobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=V3PYjkVL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCDCcJ003448;
	Tue, 29 Oct 2024 17:11:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MkDktSYrjXNPZMAtxoSkcXW+d4aBH8F1X5a432npQX8=; b=V3PYjkVLwMqzXB4l
	CS/mON3AaOAapVnS8zQmnPVjM8PM41HaPZhQEr/F7k/lLm57SdoOUf2BS4lN3PRc
	Iu/owBTh0qL7ljgwinFl3hWtRdX7v/3ezMfe3HA9n008mD6Z1NkWHAvxSs0OiZ5a
	aWW/usqEB9fVMehHEZ9UUY+NFXzjAuGjN5io+tTzFBH9nqkCGw/oVoPTTOM2jqzw
	ZfPxcJ0VEEMY77vT3ONE7V7yQdszow1ZvxpaF0pxfZwWBw5Nj/amT/PTuUko4xWT
	kDJbaftv2kJFX24ob+StWReNIA3aMx4wkBPSjQhnri8o4MklCG0eczaO/K1zOsS/
	O8MLyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42ha00w283-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:11:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B122B40049;
	Tue, 29 Oct 2024 17:10:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 061332649E7;
	Tue, 29 Oct 2024 17:09:26 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 29 Oct
 2024 17:09:25 +0100
Message-ID: <f091f532-f6b0-429c-9fde-c952c9c26382@foss.st.com>
Date: Tue, 29 Oct 2024 17:09:24 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] STM32 DMA3 updates for STM32MP25
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241016-dma3-mp25-updates-v3-0-8311fe6f228d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi

On 10/16/24 14:39, Amelie Delaunay wrote:
> The HW version of STM32 DMA3 inside STM32MP25 requires some tunings to
> meet the needs of the interconnect. This series adds the linked list
> refactoring feature to have optimal performance when addressing the
> memory, and it adds the use of two new bits in the third cell specifying
> the DMA transfer requirements:
> - bit[16] to prevent packing/unpacking mode to avoid bytes loss in case
> of interrupting an ongoing transfer (e.g. UART RX),
> - bit[17] to prevent linked-list refactoring because some peripherals
> (e.g. FMC ECC) require a one-shot transfer, they trigger the DMA only
> once.
> It also adds platform data to clamp the burst length on AXI port,
> especially when it is interconnected to AXI3 bus, such as on STM32MP25.
> Finally this series also contains STM32MP25 device tree updates, to add
> DMA support on SPI, I2C, UART and apply the tunings introduced.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v3:
> - Refine commit description of patch 4 about preventing
>    additionnal transfers, as per Rob's suggestion.
> - Link to v2: https://lore.kernel.org/r/20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com
> 
> Changes in v2:
> - Reword commit title/message/content of patch 4 about preventing
>    additionnal transfers, as per Rob's suggestion
> - Rework AXI maximum burst length management using SoC specific
>    compatible, as pointed out by Rob
> - Drop former patches 6 and 8, which are no longer relevant
> - Link to v1: https://lore.kernel.org/r/20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com
> 
> ---
> Amelie Delaunay (9):
>        dt-bindings: dma: stm32-dma3: prevent packing/unpacking mode
>        dmaengine: stm32-dma3: prevent pack/unpack thanks to DT configuration
>        dmaengine: stm32-dma3: refactor HW linked-list to optimize memory accesses
>        dt-bindings: dma: stm32-dma3: prevent additional transfers
>        dmaengine: stm32-dma3: prevent LL refactoring thanks to DT configuration
>        dmaengine: stm32-dma3: clamp AXI burst using match data
>        arm64: dts: st: add DMA support on U(S)ART instances of stm32mp25
>        arm64: dts: st: add DMA support on I2C instances of stm32mp25
>        arm64: dts: st: add DMA support on SPI instances of stm32mp25
> 

Patches [7], [8], and [9] applied on stm32-next.

Thanks
Alex



>   .../bindings/dma/stm32/st,stm32-dma3.yaml          |   6 ++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi             |  75 +++++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   2 +
>   drivers/dma/stm32/stm32-dma3.c                     | 119 +++++++++++++++++----
>   4 files changed, 182 insertions(+), 20 deletions(-)
> ---
> base-commit: 76355c25e4f71ee4667ebaadd9faf8ec29d18f23
> change-id: 20241015-dma3-mp25-updates-d7f26753b0dd
> 
> Best regards,

