Return-Path: <dmaengine+bounces-6787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DDBC4C8D
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF32A3C1E79
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBD1F1517;
	Wed,  8 Oct 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oI4DYbkW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC9259CB2
	for <dmaengine@vger.kernel.org>; Wed,  8 Oct 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926619; cv=none; b=VH8LIAhi8FhG2zNBf95JP7vDWtLKsqr8Phw8UASXOh3OdrcH0CLJp2eD9cnuFT2yAnuklPf9QCcz0GuX4gQmA+lmnwblhpQxdztTXfN4L2yKlSgYY+g1E0R2xmz6oNudNuv/QcHBhxszPEIXTf4++r44VZhG0CsOiJDM/8xxpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926619; c=relaxed/simple;
	bh=3NutFA/lGn0R2mNE8a1/k3ypM4Mn0sub0aw8bFRL2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQfxhCVTJ1MHd3CgRi9RjiDnzwvbQnevULBeGelztQPsLh3Y9zf/drnrpNn35XRUCdyfkQuHKQeu4h/rEkylZtt1oJH+gR1i/OwbHz4VAx0xL1Ttp4hl3rPwDhpyNxIKXbz9jKneoVM+AIz/0+ygOZWpj0bP4baiYW0bsamBmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oI4DYbkW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Wr3031455
	for <dmaengine@vger.kernel.org>; Wed, 8 Oct 2025 12:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=; b=oI4DYbkWuaD6yH94
	nOZtDEflYZ5xYXXjFMhsljICpLt/7npA7QQoc66K/oRpaHpkYa8OgviwiXofRYBp
	08atq97uw49H8M7CEsDfpErHmHNcgQHOc6/fzjC6Np34FrxGo/zF0s2KzbEM+hhs
	w5ar8HUJZL9mucZ4KWnkdchApE9TCJLOh2ppNLO+J3uG46c5BeaqgGa5Nv9BQDY/
	KFZO0WRkztMRsQ1FJ+y6YcH/x+wxzSrQxU/S965lejl646L5GzQI1xjlMt1WXGla
	y9nGquhxWkbQECj089H/pYvNAKPwF2hdgbX6KAfuypGmczb025yeOJODkshfg14W
	xPaW3A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7tbbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 12:30:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ded29823ebso14013581cf.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 05:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926616; x=1760531416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYwOmmq6eh7c1BlgA/tZn39no0yivZDY9RCiDcAFj/w=;
        b=loIhHFZvPMlkTw7j6I/U8SSMEKdS20cZW65zLqn68xcCxYisn3Hnkgi7tX260DoKIJ
         XHYNZ/oc2dytPz4ZOIvYKHc/nBDqQeCDQXoxWYO42nabKo/Yx0Z66o3vd39jAwql1/ew
         MuDg2rCzJsyv0il1iW1/Il47fvA54Ld0N+tIp9qKENXM1gf0BUdjcv8T+KQ+7W6l7AoS
         slZDaKyz4v8TucqT9Fm0I7wMNXWdEg7qBsTUcZIa0HiSodNoKx81+oCPIpvj5A9d4vEY
         /DFretacvfAUzPBAv8Stiff9Q4+R8LWH/Zx5TP8qkPt1L7x5aorjorCuVrhbOaMcLUUg
         Xs8A==
X-Forwarded-Encrypted: i=1; AJvYcCU7NJhddAM6MJN4QtvF70Imszk9paF+deEdL0qG6GTG4BxZRJcEePIDwiEmMfkzZdON0LsWzvN++u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrDF7JwBHqfYtgk2ZuKBazjHDENceG2lfzITXaA6VzJNxGJfv
	7wQ6yv/kUdUWwgUaTanyknatcjDQyGcFzl+Ig7yopPUWn5NfTzRkEPOCO7AqANhmkMcbroMUvPi
	LfuUy7dq1qENOyyZxqpEUD4F+p2SGDfQjGUvQpzLrt+IM4gZhAmasKT9jyEe1zLE=
X-Gm-Gg: ASbGnctWzCpNzmrrXBIYn2VcmJlJgGN1oTy6dNkcI3M+vGFydi5W2pCZIHKBgz5uhF9
	pHIvio1S/r2o+XWlHAe0VPkocJuOXNV0Zri8IJrbxrKrX6gUnTsCFEjin9Ojm6tHR4W4AkvERWo
	flPnuWXG9kXRmHczI97qry+vCUml3TfVDR2WfQ3bQOAO4McDYvgvrQ2Q23jvuXrfOXjqg93Ji+f
	TUIH0U0NImjGvoaBNvt2hOyEmucZ7xHrCVir7eHRqSl1jZ6XLTMY3jRCk0v0wx6rRUqhtGi0IIc
	36k++iljV1XNDIJ2x6H2rl8vlHBij3cP8R0uCSEas1RJDqt15woXsc6H7KSlpFRa7TXDxdK7mAl
	I6YSs2/Y/RW1Y0joKdvOuzbTUaD4=
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303601cf.8.1759926616083;
        Wed, 08 Oct 2025 05:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AlwhfCmrZxt1Uz+PeJCgLqUiBaGU6v5l4sYwpfDnGoDIJcA7elnm7lMZ7gtM4iXdb4tK9Q==
X-Received: by 2002:a05:622a:30c:b0:4d9:5ce:374e with SMTP id d75a77b69052e-4e6f4acde1fmr5303051cf.8.1759926615439;
        Wed, 08 Oct 2025 05:30:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm1633510466b.16.2025.10.08.05.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:30:14 -0700 (PDT)
Message-ID: <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:30:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX5mPHdc+aFrFq
 ohAURHbCMEeCJk3VLIdQvBFjqG/wnnwINELkrVj4OhxkeP7Q4cOK8M+pFisLFXiU5pOneIR+bje
 v0A1pZu4R25N95ZMDpn2+6bCy3bZ7is3LjvBtVFVIDW3GxcRPhXoVvM+p98A+8P73h0M9KOkwEf
 whHMd9cnmg9r3AF92fym783mt+/YBiGdrl7JmFmgvCRDykQ40w98Zxi1TaDpvxXe/DVYgqR1tH9
 woz2/qj5AUKl4YwhmpJ+mVBrZCXI485GkcuRTGfM4K1EaOwjQhZI+6IUxucQPXyRxXLfnLWF4iU
 BUmJ+pl8C2kps0wKS1R2/7AU3LvbKMKRTRzMMWLLwWrK6sPp9W117N7OYz+ZHxm2rogwyg/b5de
 1J392b7N3/LAaUUE7mGJYbneFh01fQ==
X-Proofpoint-ORIG-GUID: dTkllquhCOtgusmtsXGmG1IUVsGq3w8d
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e65959 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=-ept-RJRzOG-hoP0ccsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dTkllquhCOtgusmtsXGmG1IUVsGq3w8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

[...]

> +		qpic_bam: dma-controller@7984000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0x0 0x07984000 0x0 0x1c000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_QPIC_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			status = "disabled";
> +		};
> +
> +		qpic_nand: spi@79b0000 {
> +			compatible = "qcom,ipq5424-snand", "qcom,ipq9574-snand";
> +			reg = <0x0 0x079b0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&gcc GCC_QPIC_CLK>,
> +				 <&gcc GCC_QPIC_AHB_CLK>,
> +				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +			clock-names = "core", "aon", "iom";

1 a line, please, also below

> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";
> +			status = "disabled";

Is there anything preventing us from enabling both these nodes by
default on all boards (maybe secure configuration or required
regulators)?

Konrad

