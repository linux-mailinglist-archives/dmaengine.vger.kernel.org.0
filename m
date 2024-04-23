Return-Path: <dmaengine+bounces-1935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A58AE9D3
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2653B22628
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC68593E;
	Tue, 23 Apr 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="miK2/966"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727508593A;
	Tue, 23 Apr 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883675; cv=none; b=gjuNTMUNUuZbcxUkhRWBsjmDWIGC7E/eJnJhkFarRS6HZVZzDXfmS8zSyC/A41OlkZoxvj0KlRTC7TO6dNDkSpJCsyRfuATXN7mGZnb3UKGPyTWURMi1axuCdhadVXLDeTtMe0zHZ4WVBDdz7jgtvduoeYtK9Abj863TFfhQQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883675; c=relaxed/simple;
	bh=KbeP9FpbZs/zotQl9j7iRdG5MtyUxbPN6+XNceuQL5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=slWTqYcV71u84X/kIm+z6njCeX8JoLrpoND0l6+Qke8mY1ScNm31MGdGYRPgckLn4AmuxQmSut3F3WusmS3XCWs/ayLjxOwvhf54x4kfBxgjk8n1oMf5/1QBTxe+ecquQ0uhf0reptTYuu6i/fDrfC423IP96CmLdMEDpdlZ8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=miK2/966; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ND6DeN029735;
	Tue, 23 Apr 2024 16:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=tsJ3O9D5pmdcFP8aKelU9b9B12GbBogw1A8qeP8d7fU=; b=mi
	K2/9667VUERmzU2kC2m6eT0JPhU/vPE5POVystv72OjeoVs0OUxykrpdZpcJKHJA
	i9srr2let0ZDydK5fY2jjxVNCjv1Jw4PBzTZhiH2dic2QvXIX3ejP6pN9585HyMk
	gel1ZgTd5oPw/crxJ8iD9PDFiS0wDSlqkKZo12bPh+rkbNzi7ZFGvrL6OS5zr0iJ
	ESTEUcj90Amq5fPCsSqCjEsjanNRPUA8tw3q94/gdjNoKI/g9onuf9iiPl88C8Ti
	ovFrwG/8hFVRg5192XIaiLni8RK0O6z84I6JwkqoEsGseePZluRWLeeFE03q6P/i
	nxliQfiePYWMS2S7TAWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq90j1m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:47:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6586940044;
	Tue, 23 Apr 2024 16:47:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88B6A2085D9;
	Tue, 23 Apr 2024 16:46:45 +0200 (CEST)
Received: from [10.48.86.143] (10.48.86.143) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 16:46:44 +0200
Message-ID: <19d55a2c-791a-4681-96ca-eb1137913e94@foss.st.com>
Date: Tue, 23 Apr 2024 16:46:44 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: dma: New directory for STM32 DMA
 controllers bindings
To: Rob Herring <robh@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-hardening@vger.kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-2-amelie.delaunay@foss.st.com>
 <171388024017.101826.4338039717721212935.robh@kernel.org>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <171388024017.101826.4338039717721212935.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02

Hi Rob,

On 4/23/24 15:50, Rob Herring wrote:
> 
> On Tue, 23 Apr 2024 14:32:51 +0200, Amelie Delaunay wrote:
>> Gather the STM32 DMA controllers bindings under ./dma/stm32/
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   .../devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml     | 4 ++--
>>   .../devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml  | 4 ++--
>>   .../devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml    | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>   rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dma.yaml (97%)
>>   rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-dmamux.yaml (89%)
>>   rename Documentation/devicetree/bindings/dma/{ => stm32}/st,stm32-mdma.yaml (96%)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/spi/st,stm32-spi.yaml references a file that doesn't exist: Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> Documentation/devicetree/bindings/spi/st,stm32-spi.yaml: Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240423123302.1550592-2-amelie.delaunay@foss.st.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Indeed. I'll wait for reviews of the whole series before sending a v2 
fixing this warning.

Regards,
Amelie

