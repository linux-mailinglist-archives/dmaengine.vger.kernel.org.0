Return-Path: <dmaengine+bounces-6928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3915FBFCC57
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86833A96CB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA934C138;
	Wed, 22 Oct 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBnRqMYI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77433347BC5
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145316; cv=none; b=cKa1UWzJ3zW2OaqeeyjJ1S4/JCkgYezgwjvdpy0Ch35ENk9ZYRH/Aw6dF3ICmfFU+s0ATd1UuJld2CVZikektfrGhUUYv3aK0hcNDUCaKTuRHNy7qE0ZH2Fk+5usugdf8YC4oBekkMiGEPCZ6/7hrxQgan0a6OUsDp46XQwoh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145316; c=relaxed/simple;
	bh=wBgS1XQbHKjwCZWH331tMpBjONLIz9oIPI0AY2nrSCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeA791UOiXeSr4BJkuDcV2Qezh20w/MpNGr0TAAuAYGKMq5jiTd6IGqTbdfgb0g8zUGjXhdJw16u/EQ1Dmo00JFKbHbUU154P8n8YjUC+YurhUneFKlWF0yJF1j2QtG99dC1jUnzNjQ3DNKb6POuerlIAhZ4VmYR/Nq2k1TH0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBnRqMYI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQB7D005242
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=; b=lBnRqMYI2x4D59hv
	/oK3jFg1Yf8tBQxIJZALIjvUWvQ0RQiQAd83EHATeCV1CU3BGhIehXeyyFci7sip
	+sUlxiB/+l1rPikTXswpa1qe9i7w1SpIOHNclXa5Kr4NebCJldQlfETqotG+oUo8
	eiY4bt6fEIdFbaFv4RdagdUjr43M//PD9tDC1BagJz0pPHZyViRPe6Tm7AyQ5BdZ
	IoHcaFz42fUIDpQS3o+aXwT+kD03kQKyRXvbynvCWJMLf6kJ0EEGpKTcSQQnSG34
	AXnoDoi1zsnb/VdwPcpRW22B9Xx5EB0v7okxoVISDtlB18/H0ClRNeAcxDUmwY54
	6xwKAg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfn1b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 15:01:54 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54a9b177553so82189e0c.3
        for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145312; x=1761750112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMIllqxAxPDQ728CwihRb+R8lpaZm1CZIGmWcY9cBDc=;
        b=PlcSiWPQ0MOSZoDxfRPX/D0koHhbW1gMRmAUx2Te3eSP2efHOpc8Qps57uE7jKh0Ot
         PV1p6LZssq4tuXdBAy88l6WrX4Wptyf0Bx9VK6K0/iaOfXuc4z3brI+KsL4xUEpe3kpf
         I/a4STjCqxfHZUOUpkd8YVL1+IvOdPgF7BgZBd+CosHmmsUsQxxQ0qnC5Z7ajyspXf4o
         QhMZI4Xrh3ChPFDrQZsxg8P9nJSR+WyGYGfPJGSNmO1lWg/1+7HYX+D2SLm7aLEaSput
         4tI3yYsEMCbEzhHbRh3cKofpJAJ1KBfgetWpBo0TPlB5JrrAf/7tyqApdMFkViylzf6h
         /Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCXXHh3RV+dWo8Kf66715SxvNsRM6DJ7PuGloEllPAATgaiPCGbWd2SPqBte1nJun0/GwQYEWKPgX8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36bZXzOFkeP8pai47uMiPsw2IvxhWUcHKHqHCD/YcUeNJtbHg
	oWgwXlXH2wWTknTmoFU5X6LqwFpeOOvZLw0DDvRIFHjxIcdtIhq7cb7chipCz0cnfPgA1Comxoj
	kYu4orHb3RfiuOdTLjkyXPlvMwvLoI4/266pHjhSxn+BADFSJZeq2yJpAOiCdcsk=
X-Gm-Gg: ASbGncu7uqSseH/QRYQ6es5giSILFFv9/YwzWGEwr38b7GUjg65tRInhZo9g7hQjJKh
	s3SjZ6CZxwxcsZDcGeWjJ5wxSlUobwt7dAxHx/qTk5LMK0ucEc9VzYO3n4dGgncazA0ryhcDR7C
	4qphp0wtJIe9DXcD5c6TelAHdAVEk+dSU61Y/2Zxf7AjxGx283KLEUyGJbh48L7rrzhrqLTcwTv
	BK3bO9GKofaAYZ674rB1jF2L+o3U336sOCkxG3dw//vkjOf3QHV7JF10CEDndX+vc1Sl29JZtF9
	NTc3wjYfY2ESPF7lqHaqkN1n0Hg+pHHoEjnrS+A7IknQ+BKNH6ULrvq4rnwPJZqlhjSwg22IfKt
	bICdDi/IruMUGGxMm7Mr871uOLr9IxWUN4iU4Hz0xbv6XyV5Uy4ekiMd4
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67744e0c.3.1761145311474;
        Wed, 22 Oct 2025 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfgRrt5iXa7DFomRJIQGJ8VDhlVThbjhKqjcQAvv0iCP92sfGzYuCXXxlj2xPk/Du2wJYrKg==
X-Received: by 2002:a05:6122:8891:b0:557:594c:54bb with SMTP id 71dfb90a1353d-557594c61b3mr67646e0c.3.1761145309915;
        Wed, 22 Oct 2025 08:01:49 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1354965566b.68.2025.10.22.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:01:48 -0700 (PDT)
Message-ID: <295c775e-852c-436b-84eb-1084e549598b@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:01:45 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014110534.480518-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XJo4YQBVgk4H1IRh0D7XJRJOrgdNqpUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXxpRbAXqwi+Dh
 zisIDI86zCIbiy2WYtNACrcUqVpA7pG+c9YstxuQUiZBhyQkICfTNh2mQ1uU1krGtM+RANETxZw
 jVZ0HMQUxna3P09CGSiedOPh7dZDDneFB6UCbquQGBI3SmrgA8YvbiwFlXpj94gw5DQhqjrbFyE
 lBdAjPbx3JObdzn+sD605H7U6ZKTEbTqrSlqhh+J90ytxntvOnG/av/pQzlzSYF/91c0NvXCHsa
 x/QhVN3YC7wbvncjfMYMexIsKY4MnQM1v+DUXqBqlzm6nauT+eFvGcDJQACM1aLRCIPpqt8BkkD
 acJ7IW8LGy2j+FQbtNIHdNsoYHWurcFefA8Twn/LZrTc5B7gzQHgria/MxSNYZKzDtPn/y1bgyu
 QrXPIdgrIRdxADCMALW0yNZO0VYhBA==
X-Proofpoint-GUID: XJo4YQBVgk4H1IRh0D7XJRJOrgdNqpUU
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8f1e2 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eg2IErnvy-Z71prtMQkA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=XD7yVLdPMpWraOa8Un9W:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/14/25 1:05 PM, Md Sadre Alam wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support
> on IPQ5424 SoC.
> 
> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM
> (Bus Access Manager).
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

