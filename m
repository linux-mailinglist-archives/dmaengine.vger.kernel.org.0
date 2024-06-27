Return-Path: <dmaengine+bounces-2554-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0391A922
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE81F28084
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0387195F3B;
	Thu, 27 Jun 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CwKLFt/8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5B195F0D;
	Thu, 27 Jun 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498242; cv=none; b=F/jWAo+N82Xx7gYsbDGtL6XLgAlNW12FaAEuiyyuofpwp9Da7WbhHCTTNpSpAQMkMwQ7Votcoy/whCLnexZb8QS/5p5TwWu362AieUYesXSR8V3dS59OOrXWuci1669L2Azvcm9R4RTixdZcxUy6gMuK3gUFuzISazyQQEooEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498242; c=relaxed/simple;
	bh=JOjYQGyh6OKj0Wx4mS4iO0ogcRbdc8vIGsT4DTKNmaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WRem4/7knWKgeJ8xLrzIYgYmrqdq/QISyN3vX2GpgtKBh2l/NaPC1fge2QeSFWZ8rnJptqi3xAmoERwvBWSXKb0WAeKQ0jDpswIQINgp7q0bsRHcOo4H/Yxkan5gWAP604PM5kYkoIRDdJBz8ievM0viM7Zlzba3tOfpjedWWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CwKLFt/8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RB4x1x013769;
	Thu, 27 Jun 2024 16:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	sz4kv46cKOBt8+tdc/6ePG1HkA/ODePgbeH/iJ1pvwU=; b=CwKLFt/8tvvqoLkK
	4xy7rbGBo4o35L2ukA0Ia1tBIG6G7ASNXmlSWql2JFIZ8P8wsummFS3We/RTL7Y1
	SVc1PhLsvk5qNSueOQlsQNA6gW4Q0GYQS2bfSy5XGIYeF8QUguVs85SAVE39rlLf
	wnw+zU1HjR27gRCuwhQuvoe+axpnliInuUf8IOxQb5nMZPdAA3llR1FazB6dL8Vu
	tpLoEZR64PTMGB7/4MGmsX9x5gqdyZDYsmjdLRPn4XrrtvwT4PqFfF0WuUPFv0we
	INMjsPT/wTytgILYZZrap5WEmqiAqDlqXyDgK/P7UkN/gMRutjOx3vpRb7OMTjyH
	1PU/ww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjkeqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 16:23:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 09FE74002D;
	Thu, 27 Jun 2024 16:23:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B888B220B57;
	Thu, 27 Jun 2024 16:22:42 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 16:22:42 +0200
Message-ID: <1139b106-1c05-44ba-9dac-649bcc8d9315@foss.st.com>
Date: Thu, 27 Jun 2024 16:22:41 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] arm64: dts: st: add HPDMA nodes on stm32mp251
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
 <20240531150712.2503554-13-amelie.delaunay@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240531150712.2503554-13-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01

Hi Amélie

On 5/31/24 17:07, Amelie Delaunay wrote:
> The High Performance Direct Memory Access (HPDMA) controller is used to
> perform programmable data transfers between memory-mapped peripherals
> and memories (or between memories) via linked-lists.
> 
> There are 3 instances of HPDMA on stm32mp251, using stm32-dma3 driver, with
> 16 channels per instance and with one interrupt per channel.
> Channels 0 to 7 are implemented with a FIFO of 8 bytes.
> Channels 8 to 11 are implemented with a FIFO of 32 bytes.
> Channels 12 to 15 are implemented with a FIFO of 128 bytes.
> Thanks to stm32-dma3 bindings, the user can ask for a channel with specific
> FIFO size.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> v4: use SCMI clocks now that they are available
> 
> v2: use SoC specific compatible st,stm32mp25-dma3
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 69 ++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index dcd0656d67a8..d057dcee2534 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -107,6 +107,75 @@ soc@0 {
>   		interrupt-parent = <&intc>;

...

Applied on stm32-next.

Thanks!!
Alex

