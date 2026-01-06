Return-Path: <dmaengine+bounces-8046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF24CF6FAB
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 08:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E859F3003840
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB1309EF9;
	Tue,  6 Jan 2026 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X2rhLxsg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEJZOIaT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7104309EE2
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683458; cv=none; b=VhUDzu/eaVyEfHbE6JMzbxyh8siHZWMXCNpcbSPGQdgyTfu2qNwgWVajp9fn344l91gxw7qQDkQNapIfDRlY9TfUCf+ulTe1Ig0XQBpFFHduEz2zIAREEQXocMp+OYNxatMbReymS9+cecERq8a3ElutkNLEhnjwaEoXIBexWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683458; c=relaxed/simple;
	bh=0vKA38yiagfGrGeqmX2UesyDtC4bAUmn0ChESVuvSV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgLPhVhSp5oocvrdb29Y/zJED71HHTMhxp/vgeGQgqlmgs32wtCWLB1d5yPAfdoszwrTkLqZdhjvHlRrZqqj2bEdyLdgN2vc6RuC0YATNsBPw7amNFyM/qx8B/KMD7XrEZJWj27tnhPP1mLynX+NaRXkeeKf337ajVuhsHJrIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X2rhLxsg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEJZOIaT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066tXPV3295997
	for <dmaengine@vger.kernel.org>; Tue, 6 Jan 2026 07:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=; b=X2rhLxsgYoyoE5AY
	L4b4cQJTQ3YgIfJCOY2LOJVoBKGe5vLK1LpNNiDsUPfYPZFJrCvR5L6HKf8GR76o
	8Xem8H7csVtFQUIFSXCaZou94+irylPnnV29sMLXiknpFDdgHOFgL+jg3vNiCh+U
	u8uJoDzslcYsqpOZb8u3b16lzO2UczbNws/eJs15FDtstTOCjhv8bpMg7IBiBdsU
	zE7CqkcaOz/1l++v2Uo3JcN+XNUAHfVn3rtogIk4FRDqu1x5eiisquylcuSGquLf
	JjcY9vRoINW1D1IPJp/i+YibBXgIyJDSEo3kApXRCtijUJfeLCFyzeiGe3OegeMW
	i1Zuwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgwj001h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 07:10:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee16731ceaso15433861cf.2
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 23:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767683455; x=1768288255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=;
        b=IEJZOIaTzJhDQ5mb8BVqOBB23x1/ExdHX2hVvx5Xv2LcuKg0sWmsPv5AqfnvngW7dg
         XcAGMeohks1A/YjNHTOmbku3ztLasoyOiMEGVR/FobwlJGl6u6wKkSwq7u9295ypWsEK
         Uj32/cbisWupnmEQSuBNM80p+BcL3jAKaU4yiaPWWKFrm4PsiNiHqevTdFvCT+RGj7Un
         r8XDaJoiJyrAtb0orvRVaY2XC5XxvY7f60BV6kZC9yrcHakwNLUmej6YzEE7CSUoiYC8
         zqBWHV7fXaGqqgFaDpTPHx1/RNlbUm12dzKR7S/RMosWZRaLQzhVBGKHW1UBBib33Zzj
         0E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767683455; x=1768288255;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR+2kAsivE/Rvdu/9KWZ7We8zTZVWkvuerZ6CyrQIVY=;
        b=McfuR1ka2CNN5BIfd+DUyWjL2lVt/gHi8ctoeIoXNZWbs/Jgn+ZMV0y4k8OelUKudq
         Y9qxM8f34dVMBLh6Es5Pk7NsnXDIg1hIHWrn9pV6gAnlVvohogcJne751k5waGA3Ftfl
         WJ/k2QWeDI0wm05yQewIZPZbauSR+DC+rELKERfAQSaYDNBeHCckz1lT8VjAGZQy/ckU
         M7kmoOD5M4F7naPKZauJ6rlIyF0qO3B7VgFo/reYqvLHGkDjPjNnuGTVyTUjkngBevWd
         Y6rm1gxsXLU67M+VNpXalbgtVg3Ie7vtRoLfyrxGOUr1UcQJtILX5CmTI8wSXSUcyzo1
         kVIg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKpi4iGjFMkWVG1kZyIQXYdSvo5sCB40gUxap7jZNJbQxZEzAGYYK+2YxRO5sOoEWk5wcO0+fYuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSCA/KYvi4KRbgUIRkVhQLfRQDziodwUC2Gr+BGAwmqk8NomL
	vowPm6bBLRdKhCWAolSAYcMxdg1ihUn+MYLpuJdCcy+knMcxinev+aa6CH9Wm4Q2zpXjtNU07Dm
	AeNMcPKbRNP31acPoPubPAqppXayZgwb42alwiGPh8bPJaBCfsLXxZZ8l8wi+gPI=
X-Gm-Gg: AY/fxX7EMaaj/Tw2Cn2xpUSxGHW1dBMeLuc/S38AGtdQ08QxD/hNukwvJ17MeBPiw3N
	W2i4ZH5865woUu4NCF6icTTAlwtnySfsbdIVxe065SNBoqBCYk4i30UBoMomM/jeZ/C5O+SdqwR
	j+KGIUamaZLBZ4R5yHXxRDer7d9kUH8OP6mSMwGNtyXx75D1aY80Ui4LsiQF1bP7ieUNolWDekj
	30l5xhvftX2zG/AMCT9oay4zNsGuw5/lVnRh1gslUBp57/5NJBNLblsANc/M3/otTR21WP3A01q
	Wak+yjSb7PjroK86ZtQrmFCPJy1f+P/gOqaOj4FOgP1p1OONrYvKeq+9l7W+B3RD+CYdZCvtpjZ
	KzUagrOa2e6HMEeQ29MyIaBqSqwQkhMrVvtMcPA==
X-Received: by 2002:a05:622a:2449:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-4ffa76ccec7mr26847611cf.19.1767683455256;
        Mon, 05 Jan 2026 23:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8XFjy35zyxBfC3DOLW8LBR5cVdZzZlCAUK/f6DleVwXoBDQ8jjn4JwiDCBEIoRdJUfETm7w==
X-Received: by 2002:a05:622a:2449:b0:4ee:ce3:6c9d with SMTP id d75a77b69052e-4ffa76ccec7mr26847261cf.19.1767683454846;
        Mon, 05 Jan 2026 23:10:54 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm2690447f8f.36.2026.01.05.23.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 23:10:54 -0800 (PST)
Message-ID: <f8e6666c-86cc-4123-b1f5-681b656ccf9d@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 08:10:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] of: Add for_each_compatible_node_scoped() helper
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>
 <20260105223644.GA3633916-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260105223644.GA3633916-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA1OSBTYWx0ZWRfX2HYjWzdFY4mw
 vIRRfa02Ff66/cRZNdcf9fZRm5osmkoHb6Ob9x9DurbLe6u9+9PGE3DCEaD+2Hv1I96XirY92XY
 ANdU2A8rMg8B2V1DuYtve2u2Sr/jw5p3oueQzlp6wYNf0ZlSSxjpfKN59FL6oak7pearXCfa4a6
 ff4zRw5CIYY0IxpvuPnqm2wxfdsMRcyOmK2EHlLOvHIOKhhO6GuGj3QNSAoQCcxByNd9JV95APX
 uwRSJOcHlDSgeNXlpy9+6cptS7YyNKQ0SkRix9wuzNHG46OpvsvzGgLRVhqL7TqiggBq4IISQlQ
 qRGaja7qKBNjELolQV50hz19+vnzASYR3cGrv8Y6NIfpit/15olVmm+Kagcg/ZPoSedhSOWjwvR
 rFbM0Z0ExJQvHEs2CtgyFnwV/LI/HId1jYnb2u28NWcYtMLREozgXChLoFFm3S8j3XhxkhCTgui
 oEbtCzK6twAGCekp26g==
X-Authority-Analysis: v=2.4 cv=bdBmkePB c=1 sm=1 tr=0 ts=695cb580 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=o3VLu0Hs6I0nX9ffGz0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: x-6xZ6TbfgRNNQr3NhqAj2S__suZinIM
X-Proofpoint-GUID: x-6xZ6TbfgRNNQr3NhqAj2S__suZinIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060059

On 05/01/2026 23:36, Rob Herring wrote:
> On Mon, Jan 05, 2026 at 02:33:39PM +0100, Krzysztof Kozlowski wrote:
>> Just like looping through children and available children, add a scoped
>> helper for for_each_compatible_node() so error paths can drop
>> of_node_put() leading to simpler code.
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> ---
>>
>> Prerequisite for all further patches.
>> ---
>>  .clang-format      | 1 +
>>  include/linux/of.h | 7 +++++++
>>  2 files changed, 8 insertions(+)
> 
> You need to update scripts/dtc/dt-extract-compatibles

Right, ack.

Best regards,
Krzysztof

