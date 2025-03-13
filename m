Return-Path: <dmaengine+bounces-4738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C137A5F892
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA7D7A64C3
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80892235371;
	Thu, 13 Mar 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ni0N1Vw0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4802676D1
	for <dmaengine@vger.kernel.org>; Thu, 13 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876645; cv=none; b=sIS8pKRncdFbns3ScCI6kZq1uMXDENxIvYkGjD2zGvO7T9QZ5DGiSRsfvOxzi2Cl6zB6T96d9Pg2/fIQKygmBEZedlM2exIri6mqNyyn8qolOtZ7BFXVT4JQPeEb8Ny5KawmvFyNiXxuaFw0pFMbmihBxobA8GoSlFXt5umwujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876645; c=relaxed/simple;
	bh=+Vnc2/Hj3w94rTEXms9/i3AzD/T69fJGDMl8Wba0QFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPy92Q1dP582nA4w2JMLRHKjCUSUhSTqqZFCdY+nrzeV7HttOvkj2anD1Y/vWv3t+zJjv7S91YNo6+qo4Voo4YHECc3P5f8MiVd3s98d9VTSLTUR/CzCy7OE9XMobu9ZShw3LkoBEZOle0WHcDB40uGYq8h1x29lUDgTL8TKyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ni0N1Vw0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA1XTi025961
	for <dmaengine@vger.kernel.org>; Thu, 13 Mar 2025 14:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sihxzLONHjt8Oh4C9n2BqWvtteMvgUGVMwmPo7YJzWU=; b=Ni0N1Vw0FEkaNeqa
	01t5SuczAihq+8ElIa2m22gvmbHoIov0DCEr815mL99SpHG0hxy5xjZjmjfmGTTk
	QUd050uMF333VpBgysp8FrU0L1HxbAjwdFi43wTd1e5ntdJI+YdSz3Rppd4ovdHX
	rBxjhw21Mv0oudq3n/ycSSUtHi8zlYyYJEcdx/yl06eNDfqaxHyceakJAU1hwLUu
	gbVy0tnpmQ9bJYZdxysZW8ntpimTpxZ4vSaapzBN5PpkYNoQdM3dLo2KF90/Bxif
	9vC0N3Gk0+QyNTpn2ZzseZev6Zcujil4jepN/1+T8jP8dQkfMvjr8HM2q2lx7iAh
	QYgoLg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mp5bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 13 Mar 2025 14:37:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f3c21043so3148686d6.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Mar 2025 07:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876642; x=1742481442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sihxzLONHjt8Oh4C9n2BqWvtteMvgUGVMwmPo7YJzWU=;
        b=YFeOnKeb4l1z5dNZaY43DMPuHFs6408rVA+L7VMv8iFkxtMpMdZGKSuS+Aqt7oPfhL
         uSfT+Ug55B9hF8q6FmgWrg90MO8TyA+4XaIpdFMm6K4ENUkHwOQWsfsFQHJmoWbMnLFc
         T9YUkiePQbzCxsTzfYI7/ypbuiq7PSAISPeyMUCUcc8Oash0C0t6/ti8lMTwnZF+djAv
         ntmtMW/aKNfvxjMB8gXQH+H2VfEx2mFFKfWczcNBJiZfE9BFcSbNqgovAsWXXhRGf+l8
         68WKaTwR0PvBj7KfJcwiUN/1ofZplDbsB437qVBs+gAc0oSjE6xgU44dYKOFM0w9sHZZ
         TQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmJ6AsUvcwrMXMc/MTx8lA/yT1V6gbWSiFaP3kr3HPG0jP16V2bxaH+mW03Zfz1Kwh2TDf610xCxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjqphmDYw9eDZcg3q4+JATVjShyx482pdIDjtE9LsepYwYXVp
	PNYwNZxqfoy4AP5KgECey9bPdX8fEXjRh5Jf3nhLvn7CDHrqrJHo1RMMctiz6TMR0DIzhZmUK7t
	+ZNDv1YlyZc3dfX/0KTUnUd/0nfTSWTugRP1bdHiOzW4NNemokYJ9o1Vlq1M=
X-Gm-Gg: ASbGncuJI0zwDqujYvXieECuS22FBRI0cskeZE+BuQSY7YCT/u3PEq/cBtC7TlUul2D
	28VeaEhE5BmzRwgmnGVfprGji1yiPHd3ZtvUdoeCvFK5gvHXX0Ibj4UrBV2y1EiVYkSM51YBPVD
	YntfIUAFn6+4i/tTbmVPSunvNqjoNVe/zb/mkdH3rChSvIsT/Si3rNPkumwqPhmsBlZ3qM0pf5m
	YSou9+g9n3pkeqhkoAEkXEJi00zTzbZsVZ6bAGn47JxkEaZvW3NvGMazf4vCZZIWbUFB3teRcjv
	avQX1Y0HkgsYb9mu690fqwx+3n0oaLSrryOSI91hAHnCcZpRuGjERo+l5rqpkFrqanTjWw==
X-Received: by 2002:a05:620a:2443:b0:7c0:b7ca:70f6 with SMTP id af79cd13be357-7c55e90cbc0mr638897385a.12.1741876641976;
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERjH7r/ky+QJSZhtuQ428edqrYv/ARSPOHHVI70rPypcSuf+ECqANAAhYxQXbXX/WsiqH7zA==
X-Received: by 2002:a05:620a:2443:b0:7c0:b7ca:70f6 with SMTP id af79cd13be357-7c55e90cbc0mr638895685a.12.1741876641593;
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf219sm85801266b.88.2025.03.13.07.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:37:21 -0700 (PDT)
Message-ID: <d964117a-6e74-42a9-a7fb-c08e3ab84217@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 15:37:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ARM: dts: qcom: sdx75-idp: Enable QPIC BAM support
To: Kaushal Kumar <quic_kaushalk@quicinc.com>, vkoul@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andersson@kernel.org,
        konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-6-quic_kaushalk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250313130918.4238-6-quic_kaushalk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Zjj-9B45Lm1ECE04bAqS00JZ0beXOHBp
X-Authority-Analysis: v=2.4 cv=aKnwqa9m c=1 sm=1 tr=0 ts=67d2eda3 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=eg4k1RuA93h8uGKq0ecA:9 a=QEXdDO2ut3YA:10 a=-9l76b1btMQA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Zjj-9B45Lm1ECE04bAqS00JZ0beXOHBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=702 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130114

On 3/13/25 2:09 PM, Kaushal Kumar wrote:
> Enable QPIC BAM devicetree node for Qualcomm SDX75-IDP board.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---

There's not reason for this to be a separate commit

Konrad

