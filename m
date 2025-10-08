Return-Path: <dmaengine+bounces-6788-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B9BC4CD1
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B714E9A94
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D32494F8;
	Wed,  8 Oct 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8wzapt9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEB23D7EA
	for <dmaengine@vger.kernel.org>; Wed,  8 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926686; cv=none; b=iJk8GVOGPR2qvNCGh+64NXj0BwW1blzSGCf+MoKMrCcAEtm2gGlzBvqcn5uF3TaFqXS3vrPj2GgYXL3yU5b372zf/p32Z9wZkxPjACdqSjCbbsvOL+Sp5owvltQYbZzK4J+zDjyYC/grkvrU7xeyMxsrr8P3acpnTk61RRTZ0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926686; c=relaxed/simple;
	bh=NBUAGxB/tBXvLkcWyZOr1Q4qRMURG2fiZWYNgPUworQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7DiZHMOckl9jLimsOXRpu3H0eZ5HdsUgh682IpHlAI1prfi9PXxkohEm0oQIdK6mdT6ZvliJ5+UAsxeN5mcXL4WLyGcJ5nji6XL4aDU1OyyODwuy7pZi8Rvst3HXF3gSr8hdc9XKUGgCTpxv+070vwj824vQ1KqrCDy5FJV3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8wzapt9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890NGn026660
	for <dmaengine@vger.kernel.org>; Wed, 8 Oct 2025 12:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=; b=l8wzapt9DQeNUk38
	umAl/VcnvDBK5n3FOf3BIKAPQ+KdxaePFfsJ8Wr750zDZ/b9/2e8nRdNtRSL2vHK
	ilu0uyJCvdptf/b0F/XOoAeJ6xiFDSUAmD37jLxBrDCzHjKiM5D8+Dyw1Tm6mxUe
	eP00gzUg+DDXKtCjwrrU2Qy8v0n2uLUUI+zlcXDo0bTZyytMPdkJzIfY0NpRUWnh
	AeRLdUX9BVaqHyOAupU+dvvckN/zUWo8tr2H5HLTNBGvOjE15+N3Jdf3MGTurhbk
	oe3hF/s/VuRt/vHO7YdDa74GShsJRt6exp6kpbMKpS5Q5YSB5JbA9anC3qqq9UvF
	fHYe+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hj7gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 12:31:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso26239171cf.3
        for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 05:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926681; x=1760531481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=;
        b=kdf+1kwrYPwv9bqE/fwc74ac7VLI5TKbM2oPvdy4kQUmH3iUKxOT/ZspNtWiB4Vvab
         H3CTr/uW6nqAsPHHgph9R1w2PqrZhLLRyYikrYUxdjMwL4qmqejNuDKmR52DAjiUmnhw
         IE6Fi8cplbYesFB2xgr/rq9VoBzgKn047Bx7vEcqGWO+2b747d3KlXKT33LNlmZYXhcb
         UmVRso8GOo43p2dwbFAM0VtUBqT1D4H9qYS/B+Ar6V10Ofu7IzKsF4kTLOgk/mCkbLSq
         6j1hOETi3WIgmeSI+N3MSvNpCpvez303MR4edZNHOb6Bn/rAVBg7fB0RMqs5m8nKVCdO
         P9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0jI+HZjoCzqS4TYf0qcPlgoFLy9y6lM3g9NnRCz1xDAqNbVxhbpqj6lBbRPsGpDRaAQf9HnAaz/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGKfPOqAFatXJMEJEWb90/y8YzuNTLYpSnxRZZinU91nVwWIA
	tsPgYZxKEHY8d7PhYJ/SdbfOGVYzK04YCJzIQKlVcVBXBGOE2IpCH5m0xDtq5ielrhBo7YC7lls
	wMP1oe/QHNVI4gGux9T9mXyA8IJ/j/64FsY08ATsJ8la7rPza7yG2cl3cgmDszZI=
X-Gm-Gg: ASbGnctTMGwaOFQtSUdVwX2eeG02aQjhoNZgiNWiZTQmzVbHMXC3u/n/0yVDjY6mC3H
	lJoMuV5+97OdVsmkaGu9UVnnuGdTMuBvzdh+WErOj3io5guWpgmQO1ZE9UQi/hXiYeuRDNLY0M8
	2VBFRcUCuG5XOGEwS57iO4maWmABVercFuxFMMOROrsKqzaxhmLcU2hFSSB0ZyCRez9ghlio8zQ
	ZKVrtYgTHklsHooqTn5NSrVuJJmlFCBg/2lQtDHi5Yz+5KDLKan8N1GE+6hjb1HVwQC1shzE+OY
	7awCX2WZYYrQ1pG4TxIfgfRUObTwTh1IUTlUPwRrNvWnO196vBP0dKwSo3jcb6FqvEKg/8+N92l
	m8tJ0tkZGuPc0rmcgix99lnMZugs=
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572661cf.2.1759926681011;
        Wed, 08 Oct 2025 05:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pwI1MduX8smavHYwiDb2mslV760+0IPE3g2CfsrQdd9P6KG/JHQdrqd0yDzYls3wRPT0LA==
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572141cf.2.1759926680377;
        Wed, 08 Oct 2025 05:31:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f93esm1660139866b.83.2025.10.08.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:31:19 -0700 (PDT)
Message-ID: <eddbe8c5-56ab-4007-8df2-87927696bda8@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:31:17 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfX5iunnlO6v+Ax
 hROU7TMrchb0H6oBphL2us3gd42e/3ti8Qo+9GV8Fm51ZSeDcctCX1i03zFt6GZYlJQAFvPYx0Y
 1JB3QUh2EfBVRryIy6qMfbINo1iIz0jPXgPN91JSlSWQG/CBrQEcYow1FlF17thtT7EN82xvS35
 DsKp7JYg11m7fYg52QC6+Y9hjE4hi3D8B/7Eel8bKZTonuD7vQDm68h1Ssxse5rDl/FSjWYcuiH
 fDESr7kWwp0ljnmSNBD+vVpRANZpL5dM+wwNiXrk+YL2joN8V7Gq8ofmmtjI9nEtU7YprfUdAoq
 Dj/KZ/qiipzm9Fj55pEZxcxJ/z3mWzZJ7Xj+k3vfYG9WXigDQrGFxbS5xwjTHzhQvizjiq6I4XD
 JFnsGo+El/1veSd3hBe9PFnGZFu8CA==
X-Proofpoint-ORIG-GUID: ymDiXNYHz5StQBrWzPnZ6M6W0juLR96w
X-Proofpoint-GUID: ymDiXNYHz5StQBrWzPnZ6M6W0juLR96w
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e6599a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=be57XhxKj-X5Z9eHZJAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5424 RDP466 board configuration to
> resolve GPIO pin conflicts with SPI NAND interface.
> 
> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
> mode configuration. The eMMC controller and SPI NAND controller share
> the same GPIO pins, creating a hardware conflict:
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

