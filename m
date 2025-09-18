Return-Path: <dmaengine+bounces-6636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8BB84AAE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913204A5F00
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40C21B199;
	Thu, 18 Sep 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S4vd72lU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCC2D2494
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199782; cv=none; b=nJPN9o2RplOql4Tx/dhpJv4+AgQ+EBNGiriezf43ZocjSxgHT4TPSt/uQauhsMzpiAYERMV7MLw2EIazkORiN/2IorV+sEaTM9G3uKBJI0DzwO7l0XwrZC/RqfgXXtb4Fe3co6uCWDBtcIdETKIH5kOohIdm7TKV0135FcxtYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199782; c=relaxed/simple;
	bh=T1g8wHxLM9v5baLJeX1hctgeaaXQryX52U4/5MjiOx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPj7j73/I+CerPnJPaHV6EX4gGxepWnVl2wAuuRCgFHynTLS8ym7pVP1T6bx0zPMXs3rr4KBr4kYoLdIhJ/AXs+LeM7KW5BhzmCpFeppvFs0iRQgAQqa5IEiIKfNvL5OaNp2Z8JFGz35EuyXLvaFRfbt7LWCGXduJQVb8pEemcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S4vd72lU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBhd7v011237
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9uvbAUaZJ/mM5qLA1wvd5EkiZnnOCTie1nM1T+8w90U=; b=S4vd72lUuT76G3sS
	Rg8qlJhfc15z0IaPwnZkEG4fFJ/pSzfBuKwoOsR+Mu3Nd23+GxmkhsiaCncgAqTb
	8OEPOP0306KKqFZeM2fX+h1Rxffx0ELM2Mb+1K3f8Tca7qmQHoT+x7W/FOraKM7a
	RSLgaKD+BKGAz0h0lEYsjBEzTS4HG446XWHzVAzHPlIOhGhatEOBd5YUUNONqpun
	V8f9haVjCCIGaWvl9PhZGqc4R+JpfIMd5HPmdT6RRqY6GUARifZvMvUkBpPzkAGW
	j31mwM1mEp+9kv8UifiM07/bb2SvY87hZwSiJn1tJXRGG8x4nrZHH6Srnx/pcXB3
	xMz8DA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxxbrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:49:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-83109ac7444so17519885a.0
        for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 05:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199779; x=1758804579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uvbAUaZJ/mM5qLA1wvd5EkiZnnOCTie1nM1T+8w90U=;
        b=EQuAvAohiQy7AFv+EFdWOoLlADlMLfB03rw6RTLM2MghByiktv5TpreKmq+zfAtW+V
         Vt+TfuMj9O9ORYL181wULihFvCM1uwp2Wmk2QM3dZGODJYdCOfFQa/8Sa9HJdImNYLuH
         i0iCdts6obhdngJB1WVKAOSKRzBe3yfbPOv6QIjaNAwR1jlwICEcS6OE/5m8DxWuUJEl
         Yg4b7JWGFoR4WMcmu6jCBUEuSpo1W+96ag91RrPQQcFt98ns9SpQ/HMzjTwwZrfBeZew
         Pn7eN7LgzpdANgJzOOSJhe8CRcOx5BLQcE2+xtlgefgmMMwJEEbwiRQIT+9rbi0bYvLE
         uNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI8JpnZkX7ZlXoMCjBtLuM1esRWhAWY0QuKEsUYCiSsVoVtW1ZHE95bxQvck2OAkLwJ3G7t2su2Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUfZ9XYTRRFcvoME3Z6uBJ60yw6wvf6oIkwujJQQetpY2ynBC
	125qTx5Ii18kbdhjj2JWpsi7UFPLY5cjyiFx3Yl9hUPp6aLqMxRlmXR+2PaADPYh5fHLB/NFiEA
	ziAUj9vbBqf2NlGJ3lK9T9mA1Wp3UNMtV6OvNzvEwTHz3dcjU/Z9IoqZuqDhe9wc=
X-Gm-Gg: ASbGncubhMhztn3RaukTDVbHYFMvnXtCIdiz2bpav++pAmxjFL8aBiCPwsdZNqMJAI2
	xAjWETaNlT+8s+8OviUT5h+9vcvur9sBT1HkHPX0R2Fe7XvSefDBDPLiU+CLopiGJq2iZ2GQ687
	VQ6t5kCnMU/A/oUtzVqy3BI3yOT1PnYvYQ8rP/xE6Pz+pXqfh5iQciktjsC8RZNGyLVB4KGlJ8R
	gb6JGk19rT2PER9rMDbzjQxcsr+XRNt86qWG833pzNpwQMqyRCqb1bIoDQIbdHecYBoP8D9S4Vw
	QM4FthR9rPz4PuyBemzhCuMDcq7RXBjMc1YguF80cMHyJCeIqDwLMjzTFIYH
X-Received: by 2002:a05:622a:110:b0:4b7:a1e7:25e5 with SMTP id d75a77b69052e-4ba671e4784mr41499061cf.6.1758199779237;
        Thu, 18 Sep 2025 05:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyasYH/VJkP3eENPsuUbGcbWP9AhujaqRkp4Ye74eRiaQ7tYwTMHWC/sWrG+J6Ac53C7TSTQ==
X-Received: by 2002:a05:622a:110:b0:4b7:a1e7:25e5 with SMTP id d75a77b69052e-4ba671e4784mr41498881cf.6.1758199778719;
        Thu, 18 Sep 2025 05:49:38 -0700 (PDT)
Received: from [192.168.149.223] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88894sm186909566b.63.2025.09.18.05.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:49:38 -0700 (PDT)
Message-ID: <8b02e7e6-4ae9-4e6b-8ae6-9688d29d477c@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:49:31 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-9-quic_mdalam@quicinc.com>
 <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6MUCjFdkGoLE
 yGPZ9+wG0asf6mOFpZosJr9y5S6cInNRS6uPpvwq98yKx7dG7k4Mw1NrHR+jXGSwsTuOGQn7/e0
 yeql+1QeRuTVTp6rVIvOm4KgEjgUqA6nL3RGSdIL9fCqhug8D30FT644fJnrSYvgXP/WZISbzMt
 WxOjuq9NCsCAN1MM8C2+WnTN7rQtiH69xlFpT1HER/aTLdBpFvrMT1hv0CEYVvgCt4YftfXDzeY
 iUvO4cLvKtEl+4cheq3bCv9O9Te69W85Nf2bH/HqXMmTK0yH2VNIxX7kkvt36dPXRWTDG4gp7ZT
 S15Z2ZGucpBdPKG9Lu5l7LSZVwy8PDZeEA8pF3mX1pfzg5XRSfuGL1RpvxltlBI7xV9LKgiNGcw
 WYXuJ6Lc
X-Proofpoint-ORIG-GUID: G9hndzQLswC5tRfEpFC0KS420j6q18j7
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cbffe4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=AmzfQV_qY4rmN1R1o4MA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: G9hndzQLswC5tRfEpFC0KS420j6q18j7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 2:46 PM, Konrad Dybcio wrote:
> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>> Remove eMMC support from the IPQ5424 RDP466 board configuration to
>> resolve GPIO pin conflicts with SPI NAND interface.
>>
>> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
>> mode configuration. The eMMC controller and SPI NAND controller share
>> the same GPIO pins, creating a hardware conflict:
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> The subject should contain the board name, i.e.:
> 
> arm64: dts: qcom: ipq5424-rdp466: xxx
> 
> same for patch 9

(and for patches 6-7)

Konrad

