Return-Path: <dmaengine+bounces-5800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFCB03C79
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 12:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CBE17EAE2
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DB23E35F;
	Mon, 14 Jul 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjgikyEb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE4246BC1
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489961; cv=none; b=Jq71A+7UfWuSCdsdg8d/uzqzrOlg6x8Xf9ln284C4AxG6+kA98hrUBHw+RV1hpKK4ZUfTi5HnXOaz8ug+SrUhrL8udkM/HrtJrqQdhuEGEppB/jNSRw0WbDdITd6AP5CEdem0Soey/+5nd9NaV9ZltG7B2dv4rlYa7C+DPj7rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489961; c=relaxed/simple;
	bh=GsngcRU9ghE95V5sobt8zThiAoxS3bXWswd84ZP946Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9ZGEI5a40Nx8n+QhX32jDJzihH0ZC/MKSS51GwE+LX86MdHQDK4Cic6hYA6HcnqW1hyMXskOR+Yp+jqyS4NneE1Ad7gb+FXDGUfXXiFRcjihsrs0KjtLwnR/VFSf3KKnhj5sodKTvtgmzf2/4ZdZ6rDZG2HObWlVE1s9MsUiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjgikyEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9jp8U022925
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=; b=OjgikyEb1mjfDte1
	wtP/hpabasFr7CEflySVgYGJm5q0nSReES76WtUDsAjuVaGWqBaidYYc+ixjFAyW
	B1c+hS+/h5RiQtj9mbC1P/SNWh13uGAsktQ+25BjHlJO2Yp713g1b5IHML/EBtSm
	7GzjdcMCTjs4eqzESvGMBglzsukbovmXSYVcRUR95hJqGozKR0o4Tq+VKiIzkcFL
	d2fSI2y5SYSoWoqem9sJnwPZTiCFACI19+lhnsk1Jfkwn0Ld6LVvaYjNUlAeoL8U
	XKNcKYWWEsO5Gslfhw/4ku1cVVXMLjTp13cMhyuFWE+l4Q/IgOCH250QMqJZNIJm
	+gON1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxavdrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 10:45:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7077ad49so1388741cf.1
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 03:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489957; x=1753094757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvkMX/SfCrQy1ThgqRjv/mjGrsXTIeTx9QKU6pkfYrU=;
        b=YKslRmgrChsXNO2OZzCzSA4ycPn4POHSC8M/Jyck5oPaBhzvvI0OLUDvet4TiVoAhr
         d9fCuriqaMBlrED/576HYzE+uVKubCby1+fb90ND8PuEcxp4NB4SRaoIkL5OZheBfn9o
         fvcWtXcWpgWLkmr65klBNobzcovnfxA8o0bWrS3XtX751Y1NXpaKysP0DQp+IIiiQE6Y
         98hVZlCGeFQxOMvqjkyX7+nfhwc8vemhCpvpQQwOOjRwAgwuAVYQVZ6Urs3JsLJWFJmp
         1X5gofXlszsUlnJxEMjx47TIpE9vUVRJTTwNdoweQrKumQr2svLGFPsNvkw6P4ZVdPzc
         tnqg==
X-Forwarded-Encrypted: i=1; AJvYcCUYuArsIYsyJUp2Jgn3M7r4QQwhV5tOKOSrF+GfdkiosPfVo4KWtnUn4bAtIoQ/4Q2Ovl+QdlOaQdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIgas0flsdpP4o+lCF6POKplkGn79xjvoaTxD7xWV8czMiGQ+O
	aTuryqzwtYpNqR3o688NhEFhqvBrvz9Rj/gbhHvWUlkdLxlh47sOus34nbQK4lTyE3BL+Dys8n+
	QD8giyX2taLLEg92btcetugMkf8EN4LYrKuvxTAbg58IQj6g4z2/XoXA1qUau0gQ=
X-Gm-Gg: ASbGnctoYlH1YPxx7dkznnQwk8nfErsJBlbJ9Qx9b3gn8DFvsFJjQiBE14vKzSmh5V7
	VpSEtrlopE/aXEtNoXnf8Sk9o0CXNWvTg3Yx3ZTycNVRmR3r4St+7UaXmgmV01vHqb2vhvJfTAV
	VnDj3dOmedq3TtGH8l3V1HvcrL9ndSsidBCaR/Xj6yi9yigHchrICjI1kh9rvPyCqzw7IJEKQpm
	7t7SL53CviVCjJp/NWoa3h/4bXmzk6T3nxBkXynmk9ddeWD4fnnXAO1Hp9nAG/wINWMjJq7G5qC
	UXBm1/eIZqq4I071mQphnSwyhuM0DratiFSHFuhSkAcypBP+GR6BOIdooYj1KmaCMyHBRqgpXU+
	uLTG2vb9JXYkXmu2VGXmc
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61407171cf.6.1752489957160;
        Mon, 14 Jul 2025 03:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfiE1hbm9W21cfQCQReZLaomvmcfube3hO9vSP/hdiOgPjCPkHWjuKc+mXLxmKJJITonrVA==
X-Received: by 2002:a05:622a:2308:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4a9fb85981emr61406911cf.6.1752489956642;
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c15sm803864866b.117.2025.07.14.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:45:56 -0700 (PDT)
Message-ID: <e2b92065-e495-465c-957c-ac10db8fec09@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:45:52 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] arm64: dts: qcom: pm8550vs: Disable different
 PMIC SIDs by default
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
 <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b-Yqp2OE2F3poFn2uv9fLZ9VUvt2fOtQ
X-Proofpoint-ORIG-GUID: b-Yqp2OE2F3poFn2uv9fLZ9VUvt2fOtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MyBTYWx0ZWRfXwCPHlsOYk/Z3
 uo6FthUjaMHE+2guFed7cDdpxWMb6PiHFEP4+G+hKrl8EDLZ/bx5y9Gb+zKJfARDi5WfvYEW3ii
 tl375wJNHB6ncwTThfbE5G8pyc498Q3JtwZ+uhQC1oqa9B4Sogb1KH7IY1uuAAo56jcSYcu3pCy
 432SMRH/uadZfDS1z0xmQtNYzrDKSnNZal+9kSG+TEHe5gk9dUpdnp+dQ45LtopvO0HY9jFnwyG
 9gy0Pi7eiRXcnuQGKFC+cFzkkjWCrfHvj6mtzwKjSrvwBCD+3ObFtX775MXh7Qi6406ljz+Msc5
 SOx08mzsLKQ6r4IEkMbjB2W1ndQWqIlu+ZaZJ2xKobkkS6LqQ7nnrgpilMz9gCOZDEZZVCwK6gU
 smQqH6lc3H2og75c+WUpMyWreSRUKL0g/e+sSFGZQGrJMpxT4oQdiPn33Q2Lpq5P7MgiWRj3
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6874dfe6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=yhMgBbtfkmf45w4ReXcA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=670
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140063

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Keep the different PMIC definitions in pm8550vs.dtsi disabled by
> default, and only enable them in boards explicitly.
> 
> This allows to support boards better which only have pm8550vs_c, like
> the Milos/SM7635-based Fairphone (Gen. 6).
> 
> Note: I assume that at least some of these devices with PM8550VS also
> don't have _c, _d, _e and _g, but this patch is keeping the resulting
> devicetree the same as before this change, disabling them on boards that
> don't actually have those is out of scope for this patch.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

