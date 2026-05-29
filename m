Return-Path: <dmaengine+bounces-11026-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHxuGCVnGWrZwAgAu9opvQ
	(envelope-from <dmaengine+bounces-11026-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:15:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93D600912
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBB53009F9B
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA135E1D1;
	Fri, 29 May 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PqwF/bWf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIztQswe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68D35DA6E
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049521; cv=none; b=dMIo4fo7Ja6it2NRtec7Lqte4Vu9B+hYbrAsJMWj8KkMBQn+9WAMC7QRFvKH1gQQCHVaw52jm+XXG4KWD/hG+P38FnzPg1dpAzCmEhsXQXuQO6YpFpIcOb/QTL5IZejWWuLCE2Fona0IbLgMiDWO6uSXazviArlWz5vo6LkQhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049521; c=relaxed/simple;
	bh=RGM49AvjO/SWUeLeg2sf3XNzCTqLcvOQHO39H3cp3+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pU0uVOABGTqB0ThcjAKFNChdHqoGn+HTLKrbARDRkbtkRdeg12Xq2l2dyPQv9JIhE8yX2jQS/OcpGZ1WuJVezsJPwMC+nWRpCdBFRZ70Pr0AW5M0SqT2+NyhySYBf0jTbt254s5wOXC1ggRFX1bvj6mPjnLQxVZciSDzbo3Qxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PqwF/bWf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kIztQswe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T88HF01495603
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=; b=PqwF/bWfVMP6ZobJ
	CAXucgQX6239mSS4aLtKbYiL+25Q/dehvcnhVoTgF4J+qmJ1Sq0dxStCcR/t0HYM
	tCjZ3IwhcHxcDziFhd4dB7emSPdOu94OHy5C3G4UM90CRu2Yt4m5pJV/esnH5ipH
	605HFM/nhAevnilFjF41iFD4Qw77I/cq3IPrvZBiPvNFEgyRD5AvxQqS40MP30G8
	1vCNJ9E0vtpLSNzaoWo/KAI3tMVarD4dpjTgOKBB2dagySp0nQsoMpXdr/RwQISs
	QEt25WJazBae+WtcX/pExWW5gLQeW7kJoJirsJR/d7KCQ1bIhb3ylbauzUNzcr9R
	wtRO6Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015a34e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:11:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso9347881b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780049518; x=1780654318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=;
        b=kIztQswewLUAtHOryxhqpdI4hXxvX3SHOwFOuqqFuBBhExd1pvSBAg9OE2dqzVtqsQ
         Xgti+Z8CIEGUwWrSVVBNw3A7HIrhE9mOaT7IL82Fa7//op9KgxXm074mYn16Rq1E4Ykt
         eDt4o7vw2RIXHUTMW1CA92C39eEgR6Kjb2ij/TXN6ljvG6ZopFYl0Q24Qm2rc2MhNRlI
         s0ZhEC1w15Ac9qsZjJ0J0L4rxsDEt4c2/z3Iq4bx1egcojQJyn/K/3ePECIcOnG7SofH
         oOIGZP0/VL55CvFVPmoU8G1bHr5ULUaJkc4xT/Kxrv3l9dfI1h61EhfeJLDGAa8QqqOa
         q31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049518; x=1780654318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vern+hdJs1cLOUpZgdLqb6ANGUxQ+XS40BsFdW2Gmik=;
        b=AZSKlAWdhM4uL2tZMx2cHoWzqD/K9U9THBp8Kl3e4t0d8J+55iYpllLXM5sdtLxIYR
         GESuLbscgn+G18vrfVnZYuNX0lxyJV7r0uWgIPcXuBPBCh40/Z0mjC+sbS4Od4dtj63V
         SvnS2ClTOIdnmuLfnpqMQAIBgNH+z7pK/0Gt2TlpLVdqqHlC3aRpKuTLB0I1G4IdUfZG
         LtMwB5S/Feeq4vYw5+2cBJIGacRNDyPyWwcAUMY4CxkXh0CVJfgJkzeJq41KFqXQjJSs
         6m3eY7vF3Jp/zxacWi+ys+JQCmSIBU9tef0gp0HuM8GvmMO8EsiMJDjPIrzYC/Y+UJo1
         CdMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WMkLva5W/st3dCxL/R5Iu4FlR9hudvkmCYfWE2v7UODJRR4U0kg9RCng7cZI9Am+9ToAC/jBiGcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+UmRM/gX9q7G2nQ4IA701wKDoL8VBL5GryQgHfusYYKk5AAj
	c+CRIq2O0PQcrzhVTv7ZOe+SD9lEuovcfkIkj+azqrSQ/O9g8a/AVLgRzrLbDF7NJoC7TAqdJly
	v7pniwBfQEz/n2BRSjYG/FvAkZNZFoFEmQURPa7dZpdT7Q58vikcflXtbO60gOog=
X-Gm-Gg: Acq92OEdEGwI9eqciLyc4w+n8vguTalwU/PmkVy9y1lXLrT6cf8TdBoDAarH8N+gnvx
	IjtvMa4b0V8SdKknuY65r4sSS+fwARMXx8/M/IP5OzdM5vBjNCvR07KAFNCdyvtXyjOapTMkAAV
	QfJ0z2ZEaGNFBmCx9T7ZC6zbwSCW5LLlKiLq9z4pVkTb6zfPkFDbC/FHpvODdoQqrk7OKE2kGy3
	wJPDyH13oUHn81V9CuUCzni4J/7tYDrK5zy0KRXbNriZmuhcxddCFKxQZCqjx4HHnqax2cH/uOy
	E03WIw3cXSZPqQWEsjpmGK1QrYF7Q4F7VvJ0mgaWhuNmSe1ek3RaY69u7j4MSSFzP2dslMI9hDZ
	BeANVto9b6IbGY6OQG1UWy0CjLu/bjySTdvBN1JMjYOyfFcm+YVHtFow7Nhc=
X-Received: by 2002:a05:6a00:a215:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-84212d394efmr2331739b3a.44.1780049517874;
        Fri, 29 May 2026 03:11:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:a215:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-84212d394efmr2331700b3a.44.1780049517352;
        Fri, 29 May 2026 03:11:57 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cebf6dsm1459830b3a.53.2026.05.29.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:11:56 -0700 (PDT)
Message-ID: <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:41:50 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
 <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NzRE8tCJoiz1Vt7qQuLMxkmYFGIGgrk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMSBTYWx0ZWRfX6ZVkhKBSxn0R
 jM3jPFOXAPtDazA6nk15HdgIzWJyG1gNnDGf/ZF+LTzqnTWqFwOQGv0TlbczPawgKrsy8266B8Z
 OPJsVMR3bnoBawTvpgih4c4BRjhewmWoP9fx7CDNnxmggj4rd17GVyzpdHSBuh2i+WYfAZZnUnI
 xHTeUxt0qhaJAZLBVYPoa3ytXelW+IVLRV5k3gY5uQHIBeew+954sMMtbnEa0OQWx5Iwu1xCPVS
 s6ON3KdkrkaT1EABiDp+3MTKr9U87KaFf7fCd4IdArv6Wy0SaSBdsJYKItTBC81myU4DBedltpL
 2QWPHaKefU8rnp5etfBFPMVMZY3sbMRbEhzZjg/HAkqkulhqvh5GVxstb6tq2dx8fx2ms3VlU1S
 3aDi3nj2331ZHhNMRklR8u3az+Yo7l0ELJump0PzFgGaiL8dO0fptJcvnFwLneCHTX21ql7IYCG
 NyUGxmvVodgKpjBzWRA==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19666e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zUxKe6W84NKXZjXATOUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: NzRE8tCJoiz1Vt7qQuLMxkmYFGIGgrk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290101
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11026-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,b800000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF93D600912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/2026 2:57 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>
>> +
>> +		remoteproc_lpaicp: remoteproc@b800000 {
>> +			compatible = "qcom,shikra-lpaicp-pas";
>> +			reg = <0x0 0x0b800000 0x0 0x200000>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
>> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
>> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
>> +
>> +			interrupt-names = "wdog",
>> +					  "fatal",
>> +					  "ready",
>> +					  "handover",
>> +					  "stop-ack";
>> +
>> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "xo";
>> +
>> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
>> +
>> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			status = "disabled";
>> +
>> +			glink-edge {
>> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
>> +				mboxes = <&apcs_glb 9>;
>> +				qcom,remote-pid = <26>;
>> +				label = "lpaicp";
> No FastRPC for LPAICP?

No, FastRPC is not applicable for LPAICP. FastRPC is primarily used for 
offloading audio, sensor, or other DSP-related workloads, and is not 
required here.

Thanks
Komal

>
>> +			};
>> +		};
>> +
>>   		sram@c11e000 {
>>   			compatible = "qcom,shikra-imem", "mmio-sram";
>>   			reg = <0x0 0x0c11e000 0x0 0x1000>;
>>
>> -- 
>> 2.34.1
>>


