Return-Path: <dmaengine+bounces-5802-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B5B03E81
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71CD3ADDC0
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACE246BD9;
	Mon, 14 Jul 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1uRVocu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB769242D98
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495587; cv=none; b=EdcPpfpLs1ufJQfD9SYA/IK+qb5+sxZsv2Dv+SHXqNMNIVwKHGecAZGlHl5VVe6LSrqlzDpCUO/ryFjATMhIZNk2QMTvBy8c2JXg/sSBUnNcQ/iq+FwE1VvRKEPi+9umOfE/5H6PcNNB2uU+MYw+t4j+qy1NYD4v67TED9q0wSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495587; c=relaxed/simple;
	bh=vg1LPvtok41V62jKgVCViQqz2vZuvfhY4dzciIbvWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILk3yUK0N3ByUrYgkOCFXCkQHhSrAs4i5in349kvr80d/jhF5rQkFzC/kwiFZ/5vj75cqQpdv9zUJFeFPRl0i25Mainl8BmFbUaGiZcU9uYIBQSRfte8qonsMZ+jNgeZyxgxy5T953OLHYmi0WaWxRUz6mSqAo8Vqq6pLnOD2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1uRVocu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9alHU020627
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=; b=E1uRVocuyHFzbOsE
	SDOXrepOxttpPH3XsT7PdQ7+jLPEu7tD+Jpmzx1aIJ6UQOKjYW00inJro8y5rIzS
	Hx2PrhXS2FOqeo+g6j0Z9S13BH3dLGvjK8C8Vssh/E2Jyy1biYQvnFdafuUTxYzG
	PJR9dtqhXuuFM+6bip/DFAgMsGiprQBNz9XSHaU99RAw7D++zeXCZo8C3meXl/E3
	sMTN4UDkxV6Y7d6jX+cSasFcGY3u2FFrvS3DzRWpWsllC1jfMb39ccmMQhljPi1h
	vnUjNpph+H/NkD7/pyLbquKzOVqf4RGuBm/OmBcy2flVbY9AC6Gr5e2byhAmwJRe
	XFJLTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhcn39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 12:19:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e2ced79f97so14944485a.3
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 05:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495582; x=1753100382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=;
        b=o2ZEa14YEsLMOgRBjm1Z/EG8boT+sAQXgGjgNW1wDe8UkQwecwuASy0MIBguwnATMJ
         pe1DmaeG7Rn8KDp0LESDSrPQBgL/6VaWzZvtTro+bj0cHNyM6xFOY9q4J5NqR0BRNCgR
         RkXLmgeHebUn314t0xaHhajtDcl97ukJ2wOItHKxKPNAvYMSa2kmdPNJ8Z9sNB2MEDFF
         Mu8diYneku6HSODwJC9SD1pNrr+F9VFY6m9NzyDQ6YlKlLklqjzOgKL0Zs0ATQtdeksM
         UknQWFQaQfCY5WPByyHGy0OB3l4ABj71aFDAPWLQmKV5UJdU9257r2daZi7eKIUiRhTF
         3vWA==
X-Forwarded-Encrypted: i=1; AJvYcCW8yoiKFcH3J3pepAK/+CLwMOHNDP3dV2IQQnJDgo8TGbv2ahLKCrre9GIC58kAMTw7kqu9Eyx3ifM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNS4dRPlcWu6MhPpgUdKKrNBbcYUqXqUbLZEaDTcyVQDD+rzSV
	Qhi1KUAfwUboVPOo9JcLrRxM2x80zoyZiAar6RUyw/2PJOSMj+G7JguH4Qv5l6b7aJcZu7umTsf
	ptPFX4Fwb1uK621eKCVfG/GaBpv+9XORNViX0iF2BmdX2VFD9dHMv7zQwQzrTjuE=
X-Gm-Gg: ASbGncug0ueFZLOZwmm2/pbjFi9caNWeTINBK9QpqV0MXUGrxYOWw5vI9l4SVch3K9i
	V97hfWX+p3F1x/jA+tRdNfM2jE8c+8aPs501wxv7oMgRQz9eFm4DjnY1qPECnEgZlqry+EZPINH
	eaqCkC/7TJL4VTntxnxueeCOQSL/OsrHK0cC23FvNM+A0Ay2Q8LyOAQ5PXIrE5/uiYpHmxiRyGE
	3vluxjdayL1LE055Ju/ycVmJPszXRXqgf0CSOs4OGNUAI/RTYCxeZpfUt4g0NY3bsNybU6POyvJ
	P0RRw9SmPbZlA2BTI9wYljFKW+1t1c5GaMkLBwjQzrvhTsEnp373d+NtMEs7a2jLHbyRLBaGPbY
	Zv0e6OJYYtWE956u4uKZ5
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786276385a.1.1752495582240;
        Mon, 14 Jul 2025 05:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/vV+coe8tEVfro7qq/0wCJ9/o2FTg1Dgu/ZwIOZQR1tYnvSopD2hrjhYTvFm/GsULL9+YrQ==
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786273785a.1.1752495581726;
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733e9fsm5990826a12.52.2025.07.14.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Message-ID: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:19:36 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WUmyymZkLM8vsWXLC4sbtYeB9lglAByR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MiBTYWx0ZWRfXzR0ydezNE4zm
 nvZKJ60/iI989bSFO20LPwr2p9b1UIelnMSbGrbfFQnQO6kXGgW3ZiAxS2hBavxXhH6kZyPJ5RU
 g6ucJrQ6sFiY1/o5EvHqJW6vnKCeDTXpNQ0eOyzatDhAgDpaV1zWQ9AYmBXuYKPbVm5CZJAS1dd
 Ofx9Q1+7kDPbh5Vf4FvzKaRwG0lXqFKiqaz8SqYy2WtrlwrcAN6QZnOYTzvguyUrRY2RjqecmFg
 T/2gfG03vMhGtPH7ZRO5Cz31CouNcmf5ksoEcrJgiBA0iJqVcOgcAh2aJPWMzs/m/6YGqIb4nfv
 U5IHhx93gksidoVchsMF2w8ZYvAFg0QFMtAJ9dIh88DXWAay8yOvwe1Epo+H38nkZUtvTtmnG+L
 xDCz+EdaBTpcemkZgKHO1yWSBg/wWUfAjrjyuP8AlCijXlv+7MLI7lB5a3tornsQXCCBbSt/
X-Proofpoint-GUID: WUmyymZkLM8vsWXLC4sbtYeB9lglAByR
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=6874f5df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=ZwcaOx7IXxPg4YioGooA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=998 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140072

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the Milos/SM7635 SoC.
> 
> Supported functionality as of this initial submission:
> * Debug UART
> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
> * Power Button, Volume Keys, Switch
> * Display (using simple-framebuffer)
> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
> * Camera flash/torch LED
> * SD card
> * USB
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	reserved-memory {
> +		/*
> +		 * ABL is powering down display and controller if this node is
> +		 * not named exactly "splash_region".
> +		 */
> +		splash_region@e3940000 {

Was it not possible to arrange for a fw update after all?

fwiw the rest looks good

Konrad

