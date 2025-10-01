Return-Path: <dmaengine+bounces-6739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCCBB000A
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D591D4E10F2
	for <lists+dmaengine@lfdr.de>; Wed,  1 Oct 2025 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3512BE059;
	Wed,  1 Oct 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFYnG04l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E429B8C2
	for <dmaengine@vger.kernel.org>; Wed,  1 Oct 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314400; cv=none; b=ByhfdKqI6N4tqfg1foD1kI1PzIgRazRWWM9ivLcFk1YdNt0uH7dv1lsZc22V7iK//LrBDOVQt1p7l7/O/RJ5Pu4AjwCBmskm/EYkgsPl9vj/ZWSvc2ZA2qEGtFIyRD7SfCJKdGZCzgivttejd/72X8AvvbCLXSqfaZcUDCR1NPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314400; c=relaxed/simple;
	bh=P9Fi1ljGmUThr+8jSoJFfTtVJvJR05niVpmpkyA/Ack=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF8M+/MZzOA5L6VLxSueuK8n9ahU5dkxKD1WaJWwXzw4wPRpVIgV95MQ+F0QFRfUKrTwe5fAyywomTTfven2svWL5a2CbtFBejrLwCFTdtro+TaFVDz2ila4czONDXOYVEbYSDCsmFYKOAMaAyyTb8cT1+wax1etbLW/co+7CyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFYnG04l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59199sXl014983
	for <dmaengine@vger.kernel.org>; Wed, 1 Oct 2025 10:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DoYbUoPn5h4PTq/YMlb34TeBwVEHQG0ctNULUvqXlU4=; b=dFYnG04lUAn1n3pJ
	kr8Lw2MzF2HEuD3idQKToqoMGycgOC0qh/5s8xl8OtIEISCDnkGm5VF++zLZ9hCq
	TmOTmb9jZOg2qg9DVoxZG+CDxF9EnH/ZET9FKO3TMFUP6xYq7a/3TarviUNU+oaw
	DnPWz432ZOZ4haFZnglikO17pBSZIuGh3x7UHckGZ5jLjbJUc95au523eiaRJZFM
	/zelny9foSERCefZ98ZWPJjLqiLuS1j6Zv43G4QfA8uFZSmefmn5K7aD1Gsz+f8p
	KhgTiIEnvKCQD2D1BHyHEgPeDb+3ErQqinndDsPyAgFw0+n0FGzk3iag+k4HYXYE
	DVPc6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr4666-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Oct 2025 10:26:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78106e63bc9so6299060b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 01 Oct 2025 03:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314397; x=1759919197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoYbUoPn5h4PTq/YMlb34TeBwVEHQG0ctNULUvqXlU4=;
        b=F4Lr10cXORLp3SlMm5+eZdpAJhU1/Rk4J7ssF8Ax1neuxBuh4ODTRijlRtC2Q4IwVo
         zqQRbd4ADRzhYxsrxed42W6S/nGgwN32uBVY/vxZFyzD2ywCLPkMstBWwZFo0cvqwc/p
         JTtyfi1ORAogSCzNW1yd0j2Y4T3FYTqQFMENNbfIsru1F9NMcoAVTrGuhUXQeLKEC4uw
         +fM7T01cXb+cEKZOSLzlBBZjuPQypWTdcge73TQkCITaPhJxukqRr8MXfgYSOt2drDtP
         ccuI5NAcTSPRKx6+3qnPLUh2/IghS+vvsievXh3jEI96jKDsC2nFnmiDQjDXZEAEO2r8
         ECgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6leEgJnZmoS5YIiROJDKTE+VH12hh5WDydvQvfPPJSrz8dnAMUCzwB4j4k73oC5g1LN43AgCjq6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIF8pQsORh/e7NpiTpc951PhuhMeCY6r8YcvemAPlJo/fU9fN
	O3xVbJI5PPRErblGaW1LKf6VEDoqnHCwlo5nmQCLCi9kPSPcvT2DQJIXhVi7NN7+4d/2NX3TdeN
	+lpfixhXoW/sP6Z54RO1QQF5G3PPOnUocgwNNE9xeH55g3moruYe+QVP2bTY5i1I=
X-Gm-Gg: ASbGncsP02laBGvsCd8E1xZKzPS+npvUwwEDOs+3tdMwIJNwjRHeTakTzDK6PqstBUm
	9oj0U5fvbs4I3quKytpQGOs3o2jhap1nOYUiA0WIBcwnW8yfMfgOWAId0aMpnr3D5/Z4fWO6QJz
	BBpcJRVfvb3+cqdHZsBygDh6LRcm7nSIGqUrG69iNR0x8yBBRSGRT4GroiBV766sra0B8pCFykX
	2Hi7ePeXAFiwv+RWpQ6qHAnpfpQG/m6hA9KaevfVChJwtM20E/OLbnSBIhmI9umIBcimQONx8Tl
	1TpD4Xpy178BcRs4MtPBnBGL52fIzgtN5bG5ZWMtc/8fFqhC5icrTuneJ3u6fr4kmI2ZQdoung5
	Zmlex
X-Received: by 2002:a05:6a20:3946:b0:319:fc6f:8afd with SMTP id adf61e73a8af0-321d8b06ce0mr4302611637.6.1759314397523;
        Wed, 01 Oct 2025 03:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2JF9jYAQs7P21pVRc4kQw9xYk9dAr+RziIcU6cRwEF5tEhV4BHPHR4FxDdHvAHzFGnPlBNQ==
X-Received: by 2002:a05:6a20:3946:b0:319:fc6f:8afd with SMTP id adf61e73a8af0-321d8b06ce0mr4302582637.6.1759314397056;
        Wed, 01 Oct 2025 03:26:37 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c057ecsm15876881b3a.80.2025.10.01.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 03:26:36 -0700 (PDT)
Message-ID: <671c517f-c04c-4f07-aa65-a93e1e1dbce3@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 15:56:31 +0530
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
X-Proofpoint-GUID: 8dJUEaKV5Tf5dlqLIyhFv1E_sw2q-SB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9tlfc4Yvxv+1
 7DzUOR52Sw6+7SzD3VHYl6hj1Jtfg5U+37wW/UKTvMgeJo4q/QZJWiRim/4GioQQb758mV/N/p6
 ROcKirvknvr2HdgH2LH27iHGaeLllRfNKWgLPTRELzLKd0wBk3aL/ZczJwVEN2ozhlyqOjrdWt1
 kO4/l4yBtyUCleeRvXCrTr2Y+mpexWZawr5gtzr/ikYdVM428kS4ocp5jv3NaDApHZFajx8gl1i
 /0TWU3jHSRXTjI5gdC0hyvTP3soCuDvdM+xr9I7p3DBe4PfgVdDhLUgbUz4GDGR/+OwC9ImlSGr
 MnTDBfIw5rsaglv6PYmLwwy8x5kv6NHxzOrWRIdDkElS71iSRF+Oqv2xRHC6e9lamIP9Wphh9+Z
 dYlLTQrtwtzxzzy2/H006xEyq/EVvw==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dd01de cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fvgdV2PV7z-sFcuOFeoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8dJUEaKV5Tf5dlqLIyhFv1E_sw2q-SB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017


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
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>


