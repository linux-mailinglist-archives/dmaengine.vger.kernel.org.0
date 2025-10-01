Return-Path: <dmaengine+bounces-6737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F27BAFDFD
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC871C7605
	for <lists+dmaengine@lfdr.de>; Wed,  1 Oct 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEF2D9796;
	Wed,  1 Oct 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1IDEJh4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBD2D9ED9
	for <dmaengine@vger.kernel.org>; Wed,  1 Oct 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311319; cv=none; b=eiYOzAPvDITN9kL+i+5dRMZgVc6nrSOWnXAmCgjjNacXARSqYrxVmm6Sg1G3g74DDhuXntDGGKIArSeyuyFRWaXaRONOgpsK5cNcRS5RryFwit2b3+DDN1COJcQMZ50KNxqGHZ4kQe3Ee8hP43KT4bsXpvrJCiEUNghze0b3YNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311319; c=relaxed/simple;
	bh=clodCt2KFV7idC6nf+b0UvwIapnLPbxEnItnIWj7QEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SENnH4iEPCnDvLT1KSeGk5pKXfjIHUIdbg+vGmoWnb4X20I7L6/DtiE7YoKCcMay1cmYBuPx43gvfaPsnHUw4Ir+OX4enAOHeM8oL+p8QMl89xiRZ9znM+aGwjhZxXj4pk8GDMuF6fu738KeFn3kpbWAUQEdCgQP1TYkues92Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1IDEJh4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULhh4G016961
	for <dmaengine@vger.kernel.org>; Wed, 1 Oct 2025 09:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDF9dailVTb9C+8g1Gxz0cI5TBD6wn76XGlSDfVLb5s=; b=R1IDEJh4EBryW4Sb
	vT9pxjcQ6folIvZgqA+UqusGWBLRXww5TIVxaPn7sLYRgwjLmUkrq8+zsvRI6zKA
	15jaPB+YRd2wsCuJwJs1UNNYjyctsUFM60nIxHtQ1uYrOeboFRQwO7cTqcslIDv0
	AYFqiFUJijfnhIwtIR1Gf0FdEjp6qg1EO/5BWc4F4EN5+Y6VkJnD/PbO6zBp/c8B
	0vi26cHbZqTwqJYj1R8XJ3cPWpShfJa/P+nK1zMHHmpFP+yrxcNooVzKaImHHSlf
	EL2RC3URhNiDYTX4OgtZuc80r2Vvm//aIcBbUXQPRXcBURxGietSfJUTLM+d1B2c
	SbYJvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkqyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Oct 2025 09:35:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27eeb9730d9so58720785ad.0
        for <dmaengine@vger.kernel.org>; Wed, 01 Oct 2025 02:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311316; x=1759916116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDF9dailVTb9C+8g1Gxz0cI5TBD6wn76XGlSDfVLb5s=;
        b=aPqSidQYb88XJzpOvnGJaJvMa+lPsAkqtqrfAm8M5AtzpIQms1xI5YECRhsn+Q/YWQ
         vZo61Lt8Z/UFBwcZraWaGBnATpBcBcw8J5Rzuq6aTisL1+hAIvvlBshxnnzN8/1sDbTY
         phrCf/Frh2rlUTMCllFQsaORBxDQMbpV0JPYfrluRScrt6ooPEq5tUN+7dU8OxlcI95u
         ghAz4uKmrpmLMgC1Xj+q1vWDUC037VJ8xT9kWdSyp4bc9WPNgMzkrVYKL8fk7MlpL9h+
         nlMD1b7MfjjSrjcqS6CdVgET4EWRqzpCzhsRfouQ/wa2rkjw73rM7AF8Jx4OTpiJS/eP
         7XNA==
X-Forwarded-Encrypted: i=1; AJvYcCVuoLwj1ArMgh3DuOkdyYo8MoMypjzAZSTBgO/U8Itmj4DwOs5NsJENQHGqXppkM51BFwgyzxpYzzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHXYai9UzDB92GQxc+ja1cfGl24bRaUJc//z8SLgs298eojmU
	kuK8kK5Wrh4Zpxq+XH5abB27ieuixYo9zLTxBhTdzS4Cg+G3eTY9YooiPApHfs5RnM5R8eqNueB
	sktkW8C87LDmwhdlvqzkFXWQnprR9sl1kmnHClHKXIff2y76m0exZU8QxgKZD/Vo/eI4uPnk=
X-Gm-Gg: ASbGncsX8nLaHLcLhqjLl6SfOMDdIL8K2eQT04xR8Pi1lPLtv7s6AUq/LRkETuB418v
	8+zmWQo6Wq9fsbbtnVIGsaarfj9wm3sx7xKoF+9rOuOJimlo56To8X/NKofUXC2TWM6u/xGsPv4
	ijbJrfijSOBFjqTw2puNRtjNkqemDqOn4FaWUzR5TO9k3Su04VX2TjklAGflcXVdaWiXfzFuGoF
	vuxD54lJir+PZ6123/jMkfGV0pAi+9+Kj5B/rGzD/5ULsBYsD9QEYSaBVbaMhhmdoUHajfqkd4L
	+48jE1GQNliMI9G/QXm3+b1PTjLlIAgjMj4b5uan25HFSvx8W9Z6e3yW6ag2u8ve+9N9QKS92xh
	xswZd
X-Received: by 2002:a17:903:2384:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-28e7f2f4ef0mr36261265ad.32.1759311315781;
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYUv/Dm0XesDSTyHwQm2dVe57hhTs7K33D3ebSSuW0U2zhQHMjz1FXWOI+Y+NBaNAKCKO4DQ==
X-Received: by 2002:a17:903:2384:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-28e7f2f4ef0mr36260875ad.32.1759311315356;
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8c6sm181633145ad.56.2025.10.01.02.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:35:15 -0700 (PDT)
Message-ID: <32fd77a1-f352-4f82-be18-c978fabac280@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 15:05:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXzJYMQ+8XULM3
 Jy4AzGywMFrCAmkbRqWjp/2IDnwe0XFQ20o8Lp0RdoKzElo3EDpN45y2G9Z3E8kI0FF/J3rYYDn
 0P3R2Uzm/F47s4xFDZi7HQZwHHNV+ZuZmOImQgJDfd+cp0sWfGm/NOq+m4kaPhl9Ms6339vP2B7
 tmM3bXSQ845cHiocqnWWbcfdI19hRulNLTgAuwgoKAOXkQB4UfO6i8mKbQVtk9+f3ocu/WAUW6v
 XnMKAQIQZznw9puG8Wk6QX+XkQpZFF94dY09iAhOa41J7u0RI+Rb238nfNJb7Sw32AT9oMMd24b
 XGaqrjUslUvoyFym+gD5U9c4ETpet3lPZKRC2qG/OAUSZgDYBc/OU97Igt03wSNYwAYO2aFWORD
 e6rJgbrcjzhd+NR6UInpmKkIvyYWvg==
X-Proofpoint-GUID: uKPDeQclYjo2Z0PnWz5kE1PJmjJ7SsLc
X-Proofpoint-ORIG-GUID: uKPDeQclYjo2Z0PnWz5kE1PJmjJ7SsLc
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dcf5d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fvgdV2PV7z-sFcuOFeoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041



On 9/25/2025 5:30 PM, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> The I2C driver gets an interrupt upon transfer completion.
> When handling multiple messages in a single transfer, this
> results in N interrupts for N messages, leading to significant
> software interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI)
> mechanism. Enabling BEI instructs the hardware to prevent interrupt
> generation and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> BEI optimizations are currently implemented for I2C write transfers only,
> as there is no use case for multiple I2C read messages in a single transfer
> at this time.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>


