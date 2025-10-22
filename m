Return-Path: <dmaengine+bounces-6929-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A152BFCC4E
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B4F3B1311
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D534C14E;
	Wed, 22 Oct 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNHqvOYJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8A34BA52
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145324; cv=none; b=M6pr5RBZGZOHUHku49+dru6XM9RQiLXvBUCJA3rW7Q3MO8ySKE/Q/oeEoPfE5cS5E0Bvq3XbtQ3NZlEq8V0UEXK9RCLsokp1y3sLxxVLKyMI9YcedcGu4++WipIVv54QHNrNE1z1aQRdTppIG0gbFVYiQ89Z5tiTUOTGWALRfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145324; c=relaxed/simple;
	bh=AS6GTchDJiG/VSv415eyoTU4UvcWXjnpLTn/xX286zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NziwnaJS8ZM76BHmNONI+YZis4ebYBZMYWJOxCvPmUQrFSkZ0IUtYDByMaup8eaPA0QzaLHQ8BLWzQZXqfKOPlbqZfNWNe2ARuqrXfOtXFVxBX2xmhfMp6878W/aPC7RIxQrZb7o+7dXIDIwvPPznI+0V3fPrq27vsGDdlrP1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNHqvOYJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8pLcE004699
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=; b=ZNHqvOYJ5BbO4Dbc
	Xtu+XaBVfr47/MXPRQCupdjpSjx62/yERh6mbpW2O8yd4yIaaWW8qWnMniDLruQK
	wK2m75UquT3XJ07ANajsdglGzqF8O/TZHOelLz3IouGK15T+JcSRqm/vo8eGVwYd
	PsksKp3F30DyhpZt9KbhYkXIiBcJ7ToJOJiLZm98X3C87q2f1bvKdMXiaNT1Iiq8
	aS67Fswl/uIIoiWN+ne4Fem1eYUOX3Njlt2VzrOvCu0kP7VOPmYA8tZwJkBLPYaR
	hxfSqhVw6yQ99FgVMmXn6vvUgiXQ4dKfnzQ4NplpIx9D4wdIfmg5ZLj16g2CF2uz
	sbaNWg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsamra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:02:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5d08f3bf4f9so616377137.3
        for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 08:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145320; x=1761750120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVhUC5KfCy052S9d2cEakHXZ3DpmiRO1eWkjBgLlKao=;
        b=ghJti5T1lrrC0s83zlf+COxR14LKg/jcdcwQtuyNghAHt6ycCbM68tbC9AuoEeJ4rx
         MEmWLimQ+2lCysFk/y1pRJ6bmlaBvX8CTi1bfLc6pM4bCJWlHYWRy6wmzmzqjyJqTCz/
         JEm42VoriKq5zX/SzE+5trkCHzEJAeB4M7PftzbezD+JdnvJGJUlTPG766vsJUMa3Txw
         8jb+5+RiFt2rSDIHIlAAh97C8SHmC+HVEftj9jqZtWBwyIYGFagTZjGkxUgaNvettRxh
         Sl+wTDx/DX0pJzBmFuQQsGQeaFY6gcHEEpBTfbFzInqoVrSMHItxj0wckLrjZiGgs8b/
         SZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZlMidB1SNDstVsGloez50yW9GhGwCxh8i80+u3g/IMnRpvZ7hsJnR9m9IRX2GSYCP+UQmlmuN59c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlyBB+TLq5oPiRrPoDbJdB2npQc9eh45L0/yP3AdqF0YLqOgu
	2Tmy75eXepgpBGLJfw0mGg/wr3SILxsl0yW2M9qBdIyQuvSd+Q0vXRL4btezzYQY4xQyvIFz2oI
	4ib6r2bUq2txGqtx1XJIcdZwnQ8J2F22NU/YBEPCEhGhhkRNR1BL0PF1AwZt6oSM=
X-Gm-Gg: ASbGncu4yrIDeGVjGge+fiT9Hn3Uzl1mBJbJKvHkjh5HWNn18s94WojpY6Pfd5r15b1
	ZpLfleyxbjKDa5MyjOcL9c88uFBr5NwY8ACKSdhysI+lTePoXYjVKy1AXj7j8ZiNqKBrauadLQk
	jkfalC8Zjy1lU5cQWI+avWushSK++cyyqeWwW+2Sa8jnhmp0H8VXZyJqBILiUDpKRjPii5O/Gze
	76Lp6yKRkd9wJOLoa82Mwan/26OkSLLjLzaMMpt6991bNTzR8h7LWrZ/jP9ZUA8Oqw7iIYPEyB+
	zjXg7WPLBLK9IVMcFj82/oK7qwJfw+L8niY5ZkkwBxjBcxQIGLSo2eZXJFOM/EC4sIsS4ksamdA
	kloW05Om530lFQyrxxcdT8AA7IxJiuVLu5i1/j1jfcrhSfK+gneIoP2dH
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr660212e0c.0.1761145319410;
        Wed, 22 Oct 2025 08:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5zhFY1onskFYnO+4Fv5ggq4wyPuFkBT13ek6QdXSAtiXahagt25PhXd78pcdYze/hqeLzg==
X-Received: by 2002:a05:6122:15a:b0:556:8b02:f82b with SMTP id 71dfb90a1353d-5568b02feffmr659951e0c.0.1761145316876;
        Wed, 22 Oct 2025 08:01:56 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:55 -0700 (PDT)
Message-ID: <c56d48ad-425e-4e7e-9489-b3c926e4d617@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:53 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX4zVxWY2IhMCQ
 uBR0OiWgn4/euG7TV0Ml8tGtyjMvSAgjFVRj0PoY2F1jarAPnOx44fPkpBdonihpnP4nIQrWEJy
 4PJBrbLe7k5JuU5h6UNOVpeXRfeZzoApd4OILyuVVDXd7FtlWuhH3ZNihOCesb4vjfj1Hm0ZjvB
 X8rpvKNxWPYxxJxF2lPXyMpOIjR0kfCK3hRRR5LD9SchHpLN4CvXlhrplfNBcs+J/qdtf6YXh2P
 Guts/HK4eGDKLmYKtTmT1j3TVLkz958nLRxmNO/C4Rl5FdKZ+zSa3da290rrd8TQTyZXKtrzami
 MjMB35D2U6No+wo96aQsSWfwGYws5yLRXqS3+MmUZjpaorZzvpyHdkag2SnMsj7g3e1ffrLbNEQ
 tkCZ0mp4hw4gHkIswa7k/ZysDJVFRQ==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f8f1ea cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=gYDTvv6II1OnSo0itH1n:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yxnF_6uYWVfscmL8SRzEmDErU_wHZFCK
X-Proofpoint-ORIG-GUID: yxnF_6uYWVfscmL8SRzEmDErU_wHZFCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5332 SoC.
> 
> The IPQ5332 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

