Return-Path: <dmaengine+bounces-5938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0DB18E77
	for <lists+dmaengine@lfdr.de>; Sat,  2 Aug 2025 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105F917EC47
	for <lists+dmaengine@lfdr.de>; Sat,  2 Aug 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4F237707;
	Sat,  2 Aug 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOQMtJD9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7A228CB5
	for <dmaengine@vger.kernel.org>; Sat,  2 Aug 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138401; cv=none; b=pyRAjt0pJRU9Dr1+4YG0sWUV3SkPZacHbOjdCSi9GY4axSR7c3Uz1wU74oip4SI/uXNs0Lyo6y4ll3Cjpz3mrEImKr6IKCNdTnkfgKVCIYDaASLI0nUgRLPienjuphxTtPYYJ3nW6msWkjIPOPELA6vpLqaxhQPj++PTZXyw644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138401; c=relaxed/simple;
	bh=20GZjV/9etu8Dh+QrGksTZEKnBLbOiAfPjovI45mWjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3XTlRtElIFyLYOri7LlquQH8NTGyhHdom+Z0L4uRHSuQHZ5+bLqyH13Cc2CfqHt7AtMZWy0sfs6Ha4aARSB4m1bjHigYqAmOn4xPPswKw7IEuyi3YWhp4LT1RDO+ipSLhn8lF5zIgYZWxpT2lynO+HSK6yBBlHeUfThWw6YJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOQMtJD9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725fp59018802
	for <dmaengine@vger.kernel.org>; Sat, 2 Aug 2025 12:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9VK3kXUy5TNVKQthyOGQ0SFCHNZ+dt1IH8nz2OWv34=; b=DOQMtJD9xjdE7K4H
	vt+tAL+ijFCF/Ppx46PTq6wc0Tn4/X98XLLrGBLGuzMvbAxreC3RezQp8EyPZa0+
	UzJW6dPZmAIDc6+9IQeviwcJmVcn12IlqcBecAfYSutXBJr+KyZvSqxFtgMMo9du
	llmeNIzI2yHwmB8wloQBV8amiGbLg6kLeWquA++hJ11zyqHDF33b7slzh3B0tFYr
	A1fOQ+7KHo3LhiJjF1ji/no0ao8zJy6eh31X7yiFpqa2FD+ip3SBTFBwj/8a5s4d
	xvZZXb4ZGPo/7wRpiihVK7awCZ1GbbBUY6miBEig1e3yCvdFUp5HadPxMnra5b45
	h8VRQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pa8w6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 02 Aug 2025 12:39:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so6687641cf.1
        for <dmaengine@vger.kernel.org>; Sat, 02 Aug 2025 05:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754138398; x=1754743198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9VK3kXUy5TNVKQthyOGQ0SFCHNZ+dt1IH8nz2OWv34=;
        b=hc/lAECR1jw7OvOdYzYDuOrVsLJ585/NkxpLScO7T6RMl5Ztr/Sbxso2X8p/mZF4BA
         9EjV5eWr/F86iJb4jM5UkuKZFawUA+WXvZWnZgmPJobXOwwuyWgDrglPktj04uRZQGQN
         8PbPsU5sJjQIXZyCc2PLcA3LsJOSiOjOAXHKma0sTKQUzS3QdV9U0kc1yiWZgcKgm1GT
         4LEujAtoxxrw3K/8EgVn82+rIncLyhqDlj6jKqHJ7ujtdqsNMsJMgR2zTCqbx3xrlhRU
         QOV/b+nn3jd6+qug7gOrbSzc1jMscFwDiYNmSk57OeB/ptBlAXfI5KMC7ZaoDfKWvPj8
         5KHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRAaTqsXsqhAQP4ZiGERYh2ctpdIhCuEKMCprMogCkPvyw0yASXh9XosvTM6qYg0IX7I0vraWqg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVkzx8KzMdb2G5Nr4kFGTdxx0vxRPN0p+PITTx4sjBYrVqxlO
	dk2FhJFLpeW3+NMXrkZFLuqVMyMFuOWFf7vfQDssS/+9QMzwq2WBi4woVGnAyLDqP9+r82vKSNs
	FB87iqhbP/QCkSz0ItY2kno82PCbXKqeO5sgghEJlEA/MXghTT7744GS+cknM9KI=
X-Gm-Gg: ASbGncu4rtr/f9+Yhq+L8J+01om0FHeObUZiA5mVrv3KPiHF6On8s72dyGYD2yEyv3K
	XFcsgQvr43KA88xeWLcI9Q1XM/aMNp27f2cumBNSPzfuiCQnwtXcxv/L4C9lgXz5zW2vT8CNKB3
	7GPH+fQe+D1hB94Lf/EQ6h6qmLCQgXk4YoGpWVTBgTTMIC8vS/jouaUXy8haCl3nY6T+KXXBpEN
	puSVEJ3pGIAXXwOv13/chuhcQfxXqGAHSrs12+uDFyJuubS4vPwTG9hFTUgxbYxOzt2rsePwJjD
	uzPFrtgTlMsYOJESzEJU9pUYousffzVHJnuaIsdFe1VHQXbzMgiZy1f02VWUNSRbTncVMnXx9Lt
	iPJZ4k9PvVY5lt3KW0A==
X-Received: by 2002:ac8:5f90:0:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4af10a84c91mr23333621cf.13.1754138398203;
        Sat, 02 Aug 2025 05:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm4NEl6EUx3LCCGFmAhcLGEPc2/M/pvg1mmL0vg2ErLHKHgVKDYHB4PV/P/gfOCagScMPDYw==
X-Received: by 2002:ac8:5f90:0:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4af10a84c91mr23333291cf.13.1754138397693;
        Sat, 02 Aug 2025 05:39:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe77cfsm4167407a12.42.2025.08.02.05.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 05:39:57 -0700 (PDT)
Message-ID: <e0886f9e-bcc1-48dc-a175-2147d8d4fc3e@oss.qualcomm.com>
Date: Sat, 2 Aug 2025 14:39:48 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] dmaengine: qcom: gpi: Accept protocol ID hints
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai
 <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laxman Dewangan
 <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20250730-topic-dma_genise_cookie-v1-0-b505c1238f9f@oss.qualcomm.com>
 <20250730-topic-dma_genise_cookie-v1-3-b505c1238f9f@oss.qualcomm.com>
 <CAMuHMdV0JO=qtregrrHsBZ-6tpNdPUj3G1_LWRfRsj0vBb+qyw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMuHMdV0JO=qtregrrHsBZ-6tpNdPUj3G1_LWRfRsj0vBb+qyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwNSBTYWx0ZWRfX8g83c6GX6P8X
 XjXxyWLZhtkUjL471kUFpiU74oyDv2/L6X/9CxTsJQF5MD9j8ZcLGlyjO42bLLwKC17iatiJ2QA
 gvjEd+E7ZfE9MMQ9y17KQXzK+PJyx6I/x05P6JNRqxt/2Wvb4DGDRiZgbHjHHMmdQk7AlquL1HR
 rpVSmqAI4js65Bw6pTmsYlmL3g4qLbSTHSDyQKnbG/mbRK27PsRJc/8FywqrUegnSbDBbdKgwmT
 qtcCqCghWVqMRJC+BSVAn9N8T1BomRhEcDDRIVFoU5lSY/Soyr7iK9rhgHWnNH7vQWIH/Bq8JA4
 W0dKDOV22pvTKI+4S/LvkHTterIn9JkZSDUMKFk0LirfrJ1joXoud1+tcB7LvmOdSsjQCH0KkTa
 UTBjneMXC7b9MjUGDRmeJgO8Y8BgozpO/cSETpxaU4KB6D8+nYvKC4JmE9+q4Vag/0NSJYtE
X-Proofpoint-GUID: g493h0a-CBu5gHK1U0CJZ5kqdKPBr4N1
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=688e071f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sidZTQT7lcrlHK7IIakA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: g493h0a-CBu5gHK1U0CJZ5kqdKPBr4N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=864 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020105

On 7/30/25 1:32 PM, Geert Uytterhoeven wrote:
> Hi Konrad,
> 
> On Wed, 30 Jul 2025 at 11:35, Konrad Dybcio <konradybcio@kernel.org> wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Client drivers may now pass hints to dmaengine drivers. GPI DMA's only
>> consumers (GENI SEs) need to pass a protocol (I2C, I3C, SPI, etc.) ID
>> to the DMA engine driver, for it to take different actions.
>>
>> Currently, that's done through passing that ID through device tree,
>> with each Serial Engine expressed NUM_PROTOCOL times, resulting in
>> terrible dt-bindings that are full of useless copypasta.
>>
>> To help get rid of that, accept the driver cookie instead, while
>> keeping backwards compatibility.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -2145,7 +2151,8 @@ static struct dma_chan *gpi_of_dma_xlate(struct of_phandle_args *args,
>>         }
>>
>>         gchan->seid = seid;
>> -       gchan->protocol = args->args[2];
>> +       /* The protocol ID is in the teens range, simply ignore the higher bits */
>> +       gchan->protocol = (u32)((u64)proto);
> 
> A single cast "(uintptr_t)" should be sufficient.
> Casing the pointer to u64 on 32-bit may trigger:
> 
>     warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]

Good point, not compiling for 32-bit always ends up biting.. thanks

Konrad

