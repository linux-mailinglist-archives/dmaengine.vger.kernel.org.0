Return-Path: <dmaengine+bounces-6789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66674BC4CEA
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 14:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C23A6924
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 12:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DB246BB2;
	Wed,  8 Oct 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC0Ya4SP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC07242D9B
	for <dmaengine@vger.kernel.org>; Wed,  8 Oct 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926695; cv=none; b=YcvonFwJiTOucG98Wkex5SWJkc7IkkexM7LjbqnQA5sPiISP3eih27O8D1w+EzAbkPi0l70DnedhGxO2g7M0EvvteNvQBRQONVauSVWgowXtYarRzL8zl5zJsGWIbK3BCgptPy3OFiBsLpuRLlc7zUAVFRj/s1URiq6rIEGE/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926695; c=relaxed/simple;
	bh=ATHazlMaG3uXrz/8bapVZ0QyRnQ3LTj31ll9TPp9054=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c60x5Nm3i7+yPA+aIGyKMQYD5Asp9pMXu7zZPyLjf2YvU0pzQKYyV/1ClBjfU90ynQ/armjM9s26JrlQM7spNE4lDfIS0wOA4WJiyAOxnUcDxOUyJjAC6bWK5oHTChJ1p2JE/89g7GVK4gwB6ECZbnaYOzjmIuGLeid6vIZflsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC0Ya4SP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890NgZ021138
	for <dmaengine@vger.kernel.org>; Wed, 8 Oct 2025 12:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2xJeI3OG9l4i5P/NiO0E6EXHSuabja0k88qJFuiXuE=; b=WC0Ya4SPaTu0KwZ4
	FTweXLcB3jSodnqWhwuo5dwMkiTuAC6SVx+mwi+wZSrgekVIlCtrtSFEyPbhtMCO
	Y2KvqLuxIORVAk0BD8Q2XrumwCGcLhnV25TSVTlXEYMXk/TyA30NjQOwigqUVkta
	J0Cxq0q/CIG1Eyq2/yRzt8Ofam48l/FZ9oI9dMibVVwthHrOLplHhvXrMgm2ayW1
	quAGp42uoohAm4tr253GOnYYtpXouyojAkFnqMii4Tkrf63WPd+M+XtDugY2ctPO
	kdXQeOMKlzNHXCaBufK4GxLuJMVDKfUbZHq18ZyMj6MwXP7WrZ/xaHNBMZHrzmvd
	Oe2TYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1tdt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 12:31:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e0f9bedf1aso22872441cf.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 05:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926691; x=1760531491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2xJeI3OG9l4i5P/NiO0E6EXHSuabja0k88qJFuiXuE=;
        b=CKwbs+Iul+U0FWc446zcoBV/8wgxUSd1JxJvJHaqq7tUIna/EO83xdkILBBj+ncTBw
         d+vgs3TZvz7Ns94Org98nq5Aea01HUxCovUEBhV1ZIvH9KUQN080dM4vzRafAUTsaBv2
         1uFKUOJ2rBgGvUvaV2E3/41YjRCg0zaSahWin9x9yJYc9Mami+udIPHpUl74KdbDswR+
         lNh1j69jCdmy8579pBTMKDOQOjVJcOyV0EtnHtDDiYishGVNvyeD230EO+14GCXCKfKk
         P6GmOJANjVjLbLr6Iq8c8lqWk7XJRr8S5zZNc0/6VUtRbFFUlIY54osRXVRmnUq4B/7d
         y+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZy/CB/hzi9/BSj2Ag3ALJznDDlIbSx+MKXXfL1shjagKuWkTb810C3qDIHNlqxWeRfjXTPQp0o5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx652hbA7LtuNaoQ2fng1gNuJGA8TdgBBvJKvb/nHRExjP9aWCc
	MaXkuJpLqijJDoMe4vsxqVxcPd9cr7Cphj+MI5NpdaHSy1l10g4Y+8wkdK30hkN3NGBJABewpYH
	8j02AAWvTFXKD0mSmIGAU3pNrt3uFSSdIK/1u4y1aYolWIPvvKJHYl6upsQwsjOI=
X-Gm-Gg: ASbGncuvyEpO0Ep1J5gCgmNyLMRtQsJp1rTo32tDyRv0k1lN7Vw0P1RFe+4TkQgM3h6
	UEQydhfxoFDIQGw/HlOGwRLuBrDa9Ik7DGf2TTjx/2AfBqvdphD4Gh2/4IF2LUFotg8r0CNQisf
	rGMYBqh2dfhX1916+z13DFyzIG9A17o2nVM94JCzb6/m94vOdNcUaSWXSQLDH//oZXFeYocfvzO
	zO0ahgsZmJ5FUk8A1EhkIM2+yuPjc1L0hyfx+5On+g0HeobCua6PmJqsKrXiba99RCaCyUfR36A
	UN+YyDXKz8NBupUV4l+fxOXDkeW9nourlsVOt6QCOUTlNP5w6IC7RVyaiUiWHygBYW3WdTJDtJw
	fc5Lj9II86ovra2NAF0fKbWZyjxs=
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29275031cf.6.1759926690680;
        Wed, 08 Oct 2025 05:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf19WcSpWdEUFhuwsgE9dJ2DJvAeifUnbLDZML0K0s/i9UQH0GMuTwSzetRW1A09yhfc7ONg==
X-Received: by 2002:a05:622a:60c:b0:4d9:ac87:1bdc with SMTP id d75a77b69052e-4e6ead0aba7mr29274531cf.6.1759926690078;
        Wed, 08 Oct 2025 05:31:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8d8sm1639249266b.41.2025.10.08.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:31:29 -0700 (PDT)
Message-ID: <0ebc651b-e174-411f-9ecf-c165edc8f754@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:31:27 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: ipq5332-rdp442: Remove eMMC
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-10-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-10-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lRKplhjQbNipY4aahwr9TCdo64wF36DE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX2A6deduZdm7I
 6vmDjh8uYC6ARaR0sblfJQkc64UxMGCkiRRnVzePNlbcmvIIePukArKcSBPY6y9wV6vO0PGKtla
 GundCqSwbBLAfc8eP4TRh1GG0CacMuDdyNLr+uGQBZ2M6hAGC5FsJsWOTT6lJOkaTuc0NuGl0Tv
 TnBb5Ecr5uVPOquw+Ekro1HE5GfW9UYwkOGNk7pkvl/MnYCIbPN55W+UFcG8Zp630qSCgmAVadw
 8oHn1o/lBhmoFtlzRTKEhXVWc39Y0BM9hjgrGSCtgu4qov6nDbsxAWlbO+HUE9VFj3buFeAA3UW
 N9O8cAuBtHjwi/BX9q8w5PidcRP1636EdYv7/qhlFhQDYms2OYAf1afFN0JK6betRUeg9ZymA98
 Bbwhn7Shafzr/ynA8IN5hCHQ8AmcYQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e659a4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VaBRgJVrheE2JgugGuQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lRKplhjQbNipY4aahwr9TCdo64wF36DE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5332 RDP442 board configuration to
> align with the board's default NOR+NAND boot mode design.
> 
> The IPQ5332 RDP442 board is designed with NOR+NAND as the default boot
> mode configuration. The eMMC and SPI NAND interface share
> same GPIO
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

