Return-Path: <dmaengine+bounces-1989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46E8BE251
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D641F22430
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2F156F29;
	Tue,  7 May 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yUpJq8Rb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BF14F9E4;
	Tue,  7 May 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085545; cv=none; b=Scqph9jVDk9yxpoGAZpnOoprBaj6vvr7Qx3KEzlQOE9fA7V9LLQJEtjaGmxF6edUov1ZiYW96JuEl0OGgJRGc4JGjB0TCI0rxKoaohaK2i9BWXM1VhyWhUiJtnB/fHwWiJadESr6nr/cKh/36jQAXf9VBNQMWYl3cs1fnHSLUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085545; c=relaxed/simple;
	bh=+Q3D1pwy5ZS+pAVkDDZ5fVc527hZFvpuS1PEQZU9MPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFO4QOIlU96HtUM8UC/sgGzE6rWIAuFm4HGISjemG8A/EG71ZrkjWq+UfWWo7PUty/1O2eV2vzr6zVy8ZCvbgWNb9IFIQcfG4cC9DmFEWd4dTRoSIhuTd+C0bar7hVEODZEPNh9ctkRy+Hcd+lgZbfnSMTi3dJhGxwRaKtR0RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=yUpJq8Rb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447BU3o7015293;
	Tue, 7 May 2024 14:38:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=3qiNad6x8nitVdBqmEwvTox+u+eOjMKAzrRDqOFgNqk=; b=yU
	pJq8RbP6KPnmwTrLGmrjcNLqKBOgXfewISyJ56HJGVNPlxB8OJSXZtpYCPgLx9FK
	qVQmy/NnXOuxKJV3lbKDHz9sKvzctFg/v0NrjNu1FJlfWrsEXceSHbUVLuyd8O3h
	ssMde6+uKwJ8gNT80JL8n3rzuI0wje4rR8Cc5zYzDViXOhQ6WDL8I3DOjrPvCam1
	kv+eeYFAFeXedgUOLaZZ75hSVIubXdGx47WzLDBumLqUlz8aCzh7qFvB+RXHv8cE
	Z1ul+T3OKKFRbu7OZPN3kAqT7RKR6XRXZ09jk3su4OD6LPtdMHwwXSlSTFTjmzjj
	xrKfe9vGo/yvLCKQ/H5g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwxk1hv16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:38:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7F3914002D;
	Tue,  7 May 2024 14:38:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2F1921A8F6;
	Tue,  7 May 2024 14:37:38 +0200 (CEST)
Received: from [10.48.86.143] (10.48.86.143) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:37:38 +0200
Message-ID: <41d66c51-be2d-43a5-9dfd-9e94304980dd@foss.st.com>
Date: Tue, 7 May 2024 14:37:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] dmaengine: Add STM32 DMA3 support
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <alexandre.torgue@foss.st.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>, <vkoul@kernel.org>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-6-amelie.delaunay@foss.st.com>
 <38193848-597d-47c1-9aea-5357e58f9983@wanadoo.fr>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <38193848-597d-47c1-9aea-5357e58f9983@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

Hi Christophe,

Thanks for the review.

On 5/4/24 16:27, Christophe JAILLET wrote:
> Le 23/04/2024 à 14:32, Amelie Delaunay a écrit :
>> STM32 DMA3 driver supports the 3 hardware configurations of the STM32 
>> DMA3
>> controller:
>> - LPDMA (Low Power): 4 channels, no FIFO
>> - GPDMA (General Purpose): 16 channels, FIFO from 8 to 32 bytes
>> - HPDMA (High Performance): 16 channels, FIFO from 8 to 256 bytes
>> Hardware configuration of the channels is retrieved from the hardware
>> configuration registers.
>> The client can specify its channel requirements through device tree.
>> STM32 DMA3 channels can be individually reserved either because they are
>> secure, or dedicated to another CPU.
>> Indeed, channels availability depends on Resource Isolation Framework
>> (RIF) configuration. RIF grants access to buses with Compartiment ID
>> (CIF) filtering, secure and privilege level. It also assigns DMA channels
>> to one or several processors.
>> DMA channels used by Linux should be CID-filtered and statically assigned
>> to CID1 or shared with other CPUs but using semaphore. In case CID
>> filtering is not configured, dma-channel-mask property can be used to
>> specify available DMA channels to the kernel, otherwise such channels
>> will be marked as reserved and can't be used by Linux.
>>
>> Signed-off-by: Amelie Delaunay 
>> <amelie.delaunay-rj0Iel/JR4NBDgjK7y7TUQ@public.gmane.org>
>> ---
> 
> ...
> 
>> +    pm_runtime_set_active(&pdev->dev);
>> +    pm_runtime_enable(&pdev->dev);
>> +    pm_runtime_get_noresume(&pdev->dev);
>> +    pm_runtime_put(&pdev->dev);
>> +
>> +    dev_info(&pdev->dev, "STM32 DMA3 registered rev:%lu.%lu\n",
>> +         FIELD_GET(VERR_MAJREV, verr), FIELD_GET(VERR_MINREV, verr));
>> +
>> +    return 0;
>> +
>> +err_clk_disable:
>> +    clk_disable_unprepare(ddata->clk);
>> +
>> +    return ret;
>> +}
>> +
>> +static void stm32_dma3_remove(struct platform_device *pdev)
>> +{
>> +    pm_runtime_disable(&pdev->dev);
> 
> Hi,
> 
> missing clk_disable_unprepare(ddata->clk);?
> 
> as in the error handling path on the probe just above?
> 
> CJ
> 

Clock is entirely managed by pm_runtime, except in error path of probe 
since pm_runtime is enabled only at the very end.
Clock is enabled with pm_runtime_resume_and_get() when a channel is 
requested or when an asynchronous register access occurs (filter_fn, 
debugfs, runtime_resume) and clock is disabled with 
pm_runtime_put_sync() when releasing a channel or at the end of 
asynchronous register access (filter_fn, debugfs, runtime_suspend).
Adding clk_disable_unprepare(ddata->clk); here leads to clock already 
disabled/unprepared warnings in drivers/clk/clk.c 
clk_core_disable()/clk_core_unprepare().

>> +}
> 
> ...
> 

Regards,
Amelie

