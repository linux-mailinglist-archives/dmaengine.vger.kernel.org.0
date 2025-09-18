Return-Path: <dmaengine+bounces-6633-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B0B84162
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342B43AAF79
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3162BEFEA;
	Thu, 18 Sep 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xj8+bJON"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E71DE4C4
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191240; cv=none; b=u1fUONDCZoJ+BE74jbBHKAGGmgfUvgeqhco+0XDlloYyJepAMYBPN8l4ms9ZOCyvmxf1pyT+yujLQ7OSvSExNJIrMg9pBL6bEyjVR9r1crIxkX6kl4du1ipXU2+gv/VSTViLFWZRzQD7sKbW3WWhycr+cfS6Gf184/yNFeZHN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191240; c=relaxed/simple;
	bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ/qpeWX/ukopnzDEBox5lFncii1BHud/BGBBNG0s7J4ILKOIc125Rx+oUGPt5HA9LYgrgFndW2C8dgqcKk85/LNDprCvi2lKCVa6C5lGM9GmTGe32FHkRpA67OtiKmxeX4gHSqWMlwzD6wrnVgjUS7G8VZ3HQhv//9OoPzaoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xj8+bJON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3TYAA021410
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=; b=Xj8+bJON4h6M4tex
	eud08TlmICVdM46C3Tno3WLRmkhsbNqhTgCberXdpoMD14nQHmlRgjlnHEXKF/2r
	S+J8P8/fiV2JZRB6IsymMfqP7fIVxiS7amroKAScOlJUSy1NJomH6IwwfhRqqgj9
	pOsgXIDONGDPuCe7kEo5WyIhMMCjdyDa4Fwe0bV06eO3TXlDh0HbWW7J6QFnh2tc
	5aR5Xo9CkpAv6qyLtcM8feBGEi3aXP90Yd1yJtKNHZXBbljdopXYR3CgO/pfLQXD
	RH6tVxKP7ZDMibIcy25K4HSl0x5HyrBVpYvDWcSssdxiUbcI1LEFF3zkxLigFthH
	+eP9Bw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5dxd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 10:27:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b79d7413eeso2693321cf.2
        for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 03:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191237; x=1758796037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFFv6NEMjbrj0MqTLSIDkcH/Ec5UzdpQKT06CrRKoh4=;
        b=EP/eaRnjqc8Ni8LBIWFKv7cUVSuWsOKelIYD3z5SbI+bnAorMAYkYtEvlylebKUElY
         iYxZ/ZQOkm6iT3zIIs1tpD5JslBWLWG2YTbtI1v9Bu6fFXBkDv32rwQalEkV/mgKDe2t
         aI+BcPf6Vxb+md+jMQOFWSEZhU7Gb5Z+kUe5sBotMjBWgKVb3iZ8swusxelU5ktTZ/fj
         2cp5Bx+WoyNYh/VwJjhOS9dGAvMk6mV2n+zv7RnElTtZWHE+9wzjOc3n32syCwP14RxP
         6x9rpRkgllLd70YLPKjHjqouTdlAVwzYIMMSS1UvoSlIWpQlJDrMexhl8Lw6RRhVGaNX
         an7A==
X-Forwarded-Encrypted: i=1; AJvYcCV4ucomek6iUuw5JXH57mVPeR/eow8fldr4iAcTjg9gYOefI7+FnoL56VgSpcZAJwtSKt0LwLU8v2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mG4xIZYvCd1gOeaAZRBQmzteMa/bqMXgDYTL7RWsEoaO8Tu3
	QBAKPDcz2hHMbI5eZb490YIo7sNsFqZZ647C9masmNqN+Xp0bGd7OnkJiLvf3v8UrHjW38gfZBm
	F87Q7oxvKeRy4atSSlGPc4Az35YWu/ubsgnqPQsqWG+K8SlrBn09P1wd6h41fX0w=
X-Gm-Gg: ASbGncttOMOD/v9CCM3TDTlQULXyb3+DjzgzmfyAxsNSOO8RFEGraG6AqAbTQ0ErF+r
	1qFjBTymvhRCgvRiSne8XxtJLJQud4BcZlFJ195Yh1fLTR4LYHD35Uwn1j2PHHU+FefGbdSonR8
	94WuyNkywM/5Nnzv3p0dpKAvFj5dzxFdYoxyBdI9WNMGsZCiHG5KV/pwqPImsp/1P1smr6Vcehz
	a9crxljpkN/dB30SrADWm0YFeEmMRBGhn4M5VSOX+g+yq/iOpsIrzMmCl3j5R7CZ21lAsPK9l1b
	X3/FvoAt64gvYT0HAsyh90f861SPdJkX3f1oc1QjmAFZ5wh5rzcHLsRpBRwONajDOroepYG2PUw
	5J4IoQo2Zfkp01/DAiHpKRA==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039416d6.5.1758191237075;
        Thu, 18 Sep 2025 03:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYzlJJuyXGduZqx5WCoB3OgJz/oYERgYQ1D6+IglQ8GmpT3KQfYFFrtxzVLToClE/f0NfFbA==
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id 6a1803df08f44-795c55c8cffmr4039366d6.5.1758191236525;
        Thu, 18 Sep 2025 03:27:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d1a89esm1217938a12.16.2025.09.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:27:15 -0700 (PDT)
Message-ID: <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:27:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ei_T1TorW_9epST0j7A9USy4dCPZrwbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyWJ+wWZs3dLk
 9Liw17mamGJBLwB/3b4jXmf3CPJqM6M/VpKYFadoC10ga+GsyeRpZfhE4//8fU42+9mNC1mFLP1
 z3rIRzyvNV9voS1etG4MKIkc9jXM3eKGk29kMt9a6EnzccicgVDDn7pfoCOiX1jshM5wEmQCc1Y
 5yt5ECrqdWhOifPSbO05eYKkKHIJwbIP0lUBSI3453Q+/dzanqYwwrYkWR4HQZOxPfYFDrjZuHI
 C8/SzBmRBDjNEDvZAv3QLVLvOBV4UvEUvEKqOTAHAjhyi7aA5e8gfhpFih85apDh4jx84y425P+
 qPqEESoRtBEQPeonw187VrJmrGPfijLVTjhcI1P/Rch2bqInRnCmUlVWnZvtbuBM6pJldTKpuxJ
 AiOr12QX
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cbde85 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=MmGnNXLGTzfTIO6JWNsA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ei_T1TorW_9epST0j7A9USy4dCPZrwbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations. In newer BAM versions, the mask
> field for read commands contains the upper 4 bits of the destination
> address to support 36-bit addressing, while for write commands it
> continues to function as a traditional write mask.

So the hardware can read from higher addresses but not write to them?

Plus, you didn't explain what the mask register does on BAM <1.6.0.
If it really masks the address, all reads will now point to 0x0

Konrad


