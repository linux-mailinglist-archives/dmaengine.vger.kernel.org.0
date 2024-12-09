Return-Path: <dmaengine+bounces-3931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79A9E8E55
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 10:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54513188829C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2621571A;
	Mon,  9 Dec 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YOj+ENX1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ABA1BC4E;
	Mon,  9 Dec 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734873; cv=none; b=PukS1GsDE3vpZzb4Ps1S2CcwTDIMM8sd5EryfycrHlOajYcSLHayomeLxaFoDof6L9PnLclOAG8yP6dqMxCAqWDhAeJWgCdk8xJp6hOblwZC11H+qUMHv1Tt1xNeG9Ew4tL6LhFm/9vbHFpJp8rhVh39D3rJo18nHw2KydPxtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734873; c=relaxed/simple;
	bh=S3YYC/YNeXowK04rNQ9L8jVyWw3ahMBv+v8lUE0Y0QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FcZMwaWVrVMbkcomU0cpPMJAARGybrquZgD/nhPF1agfzB0jz+T010mJMUu5Wij7LeSOgop0rJmU5bQUwqgLYXhKq4xseaVYaELgaiMiZevtHdRib48t6RFw7xRTMK+3R2ScBXeYdeScesJ+aFh/GHAQ8PBX4lH6FnBEkG6bjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YOj+ENX1; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98VISn028237;
	Mon, 9 Dec 2024 10:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4raHiqxQoPVH+LXWyFUosGW/Q2xLlE6E0wYYvSLxcV8=; b=YOj+ENX1/yu/azn+
	6f4/j18QK7hxDoTpOMaZeTzmhKvPgOhxJWfZTEinxb4/Iq0tBk2UzJAbMsDJI7ri
	S42H1yBbQOZmmhXCglpUjzdChmDv8XOs2UTiDQ7M7SwXRvzFyvzpTuugJRkMXo4D
	u7xCUKFKwoHJdBxfdPUogHgiEDsu3F6upLsENPXtH60KZkJC/Ct1vTBrClM7WEYP
	My56ygdlFcscpK5ATcFo/LDe3dVxvzGIJFJEIs4qT5rvXvKn9qvWYBZDOZuyuBIp
	cu6BTwu3YFBT33nroessU5wdkyfdLi8KRSf3oqMkIeYg51xw2Vcgr42NXJKSkzXG
	2YzWPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccnkxwrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:00:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F07CC40077;
	Mon,  9 Dec 2024 09:59:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 818D524D44F;
	Mon,  9 Dec 2024 09:58:59 +0100 (CET)
Received: from [10.48.87.198] (10.48.87.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 09:58:58 +0100
Message-ID: <18c36a0b-f647-4acd-bed2-d5a09b1694b7@foss.st.com>
Date: Mon, 9 Dec 2024 09:58:42 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: st-stm32-dmamux: Add description for
 dma-cell values
To: Ken Sloat <ksloat@cornersoftsolutions.com>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 12/6/24 12:50, Ken Sloat wrote:
> The dma-cell values for the stm32-dmamux are used to craft the DMA spec
> for the actual controller. These values are currently undocumented
> leaving the user to reverse engineer the driver in order to determine
> their meaning. Add a basic description, while avoiding duplicating
> information by pointing the user to the associated DMA docs that
> describe the fields in depth.
> 
> Signed-off-by: Ken Sloat<ksloat@cornersoftsolutions.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

