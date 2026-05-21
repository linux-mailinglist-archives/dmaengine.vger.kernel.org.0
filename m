Return-Path: <dmaengine+bounces-10634-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LyMMcbJDmovCQYAu9opvQ
	(envelope-from <dmaengine+bounces-10634-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 11:00:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FA5A1B88
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A95321BCC2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A836922D;
	Thu, 21 May 2026 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KpoblIp4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dfk8qgv5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1036826B
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353155; cv=none; b=C6pxfJ/yRn+klyPAeIfDzBL0aecVC4A9EnRi3w71+1LGm1tKE2+pDZQeDMoZgy4T42wkV+LwOgwTRWbcpwikxARrn3W40qx5yveV50/g+w0JFXNnam1c5FwM35vql98WLuvGcT1NCygE9zB7CBCYV1vdgvV6ulfSW6YzKnBusjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353155; c=relaxed/simple;
	bh=LI1P7U0gaKVb0FmucV8auUmJuUJiOS5F8FS12dF2UIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxsIv4xtEefJr7fehsiTCLrfxcYHiP8zSlhiFrdGuBGHd3dzzFIYDS0niKfTOfy7ZZzJnt6ondsXtYhhKBVtvjtkrq8c476CiBukR6dOLuL6WlLUE/e0OlMbRmY+9NtA2Ch1/KeT6FoNG5FWtPQGIuX2EF7olWfQtC6rV6gshAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KpoblIp4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dfk8qgv5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7e2iK963945
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 08:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wJVdsUyX98YGeW/ulFXwxng+OTO4Vq5zgb/1dD/SbDM=; b=KpoblIp4FrCA7WaY
	V0aY174JYcUU4bEHOb41Z1Bp0vTX6wVHCNGVSD6LkHlJOKSlEM6pMyCchKMWcI+L
	/FNSpJpvJrPYTW2QcASurlNney0kg8k3i4HM1a1ehtm/ckxjrfjUZ/mbYitG93PW
	kTikwmzGWt0vQk0lL5Iq2AfhfxwguQDqEW8AwlkY7H8eBD54eQeleAGYZ6Oajzp7
	fyfzICeTNV+SCEiVwa+7W66AbpOAarA+WaB8kVMgt+Gk9mFFDoZl75iHWCWO4oid
	dva7CrlwIQtw7Q9S3DmKdpxHHYzFeXEni4Cv/aP+L0g+zR5bblIqcxaYUFqGvfx/
	g+VS4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh3xpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 08:45:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso12791146a91.2
        for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779353152; x=1779957952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJVdsUyX98YGeW/ulFXwxng+OTO4Vq5zgb/1dD/SbDM=;
        b=Dfk8qgv5hpROW86sINUAEQxJgcT+F4cvcIbOhO2ceBzhMK419m283sHyNIGASV3mqp
         1R1GOTm+OkDvS/an8UYLT4WLvLoDMbJeYn+Z/ncpSX5KenDGG+2TzUT0FqCMRcR3LsiS
         mKiAx0t/ybQkaGawAZryW/Aanwt390ElyMWdoa/DYEy94jZ+qBKIef3Met1QXy5L3EQ0
         97fySqxRl5ETCyUkwDUdprqhNRj0m7xzavUmIxCMM1bTwvIjA8uNnqRR1U4ZQBANrDpe
         ND79gjiVUzEibOX0pLHvUUtNs7WhcdAQmVx3Dzht4cI6DjFZMP5wbSrXXfjAaDFOJ7Fx
         z1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353152; x=1779957952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJVdsUyX98YGeW/ulFXwxng+OTO4Vq5zgb/1dD/SbDM=;
        b=F8h/3d8gMbFk1OddbAGRAh7YCr4UVmy/AcyDY+CkaYQseBXMMOiyXuIMp/JxFzy7L9
         2DAf/OMChRA6/C4CDGW39BD0Vfoi8ssk9e0OcFlEhCd1rqqHeun4jltnDPeExAsR7e3M
         /FKA/J9Bm+mPlhOuKs7lLpfF83HisZxZB8Y2A54+Bj/e9FVlMUEoDkHPuA6sudMsLKDd
         2azZY1g/qUfoe5JWWgPxUKFIa/FI4rl14S+gTR+YPNOLOJOnVxiLP0s0dVuN5IWDiAiY
         QtYv+y7jazvmW7EGjVFyxAvAGoYZoiqLN5Gn02k07llkng9IK7LdegGH+P35wJYh+D0f
         fsEA==
X-Forwarded-Encrypted: i=1; AFNElJ8Wd8jt50HRjUWQ351cIviK5/cXs6ZvycMDnbDVyO0v53RtesnGFPrOTKCaip9zHZcaWxa1D1/LuX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNR4NI8buEg3r83Ky9nTYPLVvjCjj4pN5RUgsXb4VeKpZkLEM4
	uuYHaINPOSL+Tk1kB+TaqOZjc8FyhQ2DQF4I59dpkIpJ0BanyLydXcKSfNDMAkY+I4O5tkCAEAJ
	m8xgshW3vS8JOfs+rOm7UMpUR04eILDXpfyHstlu8NVSCrX4nmyNBU6kg+uREy58=
X-Gm-Gg: Acq92OE6TYVEkGCU1IJ35JoytPh5nQaTJh1V3eIh2jsNVPJO353MBD2QlekZ/CXMI8X
	4SrdAGQPrmUsvWAuJdsFXioaQRFiRt8hPm6QVPE7r87+4mVQM2poSZPIl3DBi47Ng9fLk6I0vBz
	JdL25NH8tvGJoWIILfX4MtdExighzcjvz59tl70Xyngtd/AXKg1yTxDVo0Jr4qVaqTwTk/MPppc
	CY085eS/z337sZ9R0NMRD6vprXx56YJmwppWmiBkpv7JfO3KZmz8wb0VOP+8s7JPQs0yvQsOPm4
	XfzjsSJMb494i8ArhpzfyBRe/8I2GmBSRg5vNVBIlpAOwfBQZGAVx38qDbdQ5DXt9lieixr4l7F
	WxOBL7tzPye2XMtuQk96ZrQ8ovHbwenlN9+iTchE5wCQICLqkriz1
X-Received: by 2002:a17:90b:2708:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36a43887a55mr2172276a91.0.1779353152305;
        Thu, 21 May 2026 01:45:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2708:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36a43887a55mr2172239a91.0.1779353151814;
        Thu, 21 May 2026 01:45:51 -0700 (PDT)
Received: from [10.217.222.91] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a46d53ea1sm723782a91.4.2026.05.21.01.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 01:45:51 -0700 (PDT)
Message-ID: <57c26520-42dd-4159-bd2a-69874945cbbe@oss.qualcomm.com>
Date: Thu, 21 May 2026 14:15:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: shikra: Add qcrypto node support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260515-shikra_qcrypto-v1-3-80f07b345c29@oss.qualcomm.com>
 <8dfa0670-7605-497b-9d53-db9b4a8a3d8d@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <8dfa0670-7605-497b-9d53-db9b4a8a3d8d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0ec641 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FZn51bsQql4VyS6HqkQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NSBTYWx0ZWRfX1KYtT1LR8az8
 9bH7+XvSY6PjiDVicnhBnurIfANrBdW231HApammYqUfvbuWClzmwMV9zU3LHUtd4adr3aSQyRz
 /ps/gNWndox4I4sghakBs5YobJrgat2/W3iA2+SO700vP71Fo+gHDNn/Qv5o0huwQzq7u846tNp
 l/aWT1nvvWVIhLGvtWh0bPuT7ZBngz8lqJzt6UJ5ZALoWoTEcZH8yX8TysjIJhd0LzoadDetM9u
 lTisAemj32bSHvdXVdDyCerzd7MRlr0ILBnH4HbSlpg4FBNXNas3gPSIie6TjfHN3j1f/M9eA90
 Egc4nQZvfVQO6l7PO4lnrQ6aTJ7gJJHOJf5fpMu82fig+wFLlIC/8sJR7ZRF4wqIg5ETzBmliFt
 7Fb6w7RtFw2Lmk7s1DjHpUTL35Vc9uVSKCmBQO5c7R0RTq+tNLcBicjGudRvmIm55bnkPbkEw53
 4rw/SO8ptMz67RZmThg==
X-Proofpoint-GUID: hg0BNI_mT6toGQkmmQlnoyfhjJ05-Stz
X-Proofpoint-ORIG-GUID: hg0BNI_mT6toGQkmmQlnoyfhjJ05-Stz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210085
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10634-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D83FA5A1B88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15-05-2026 15:58, Konrad Dybcio wrote:
> On 5/14/26 9:23 PM, Kuldeep Singh wrote:
>> Add qcrypto and cryptobam support for shikra target.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/shikra.dtsi | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index 262c488add1e..dbac0e901d6e 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -541,6 +541,41 @@ config_noc: interconnect@1900000 {
>>  			#interconnect-cells = <2>;
>>  		};
>>  
>> +		cryptobam: dma-controller@1b04000 {
>> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>> +			reg = <0x0 0x01b04000 0x0 0x24000>;
>> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			iommus = <&apps_smmu 0x84 0x0011>,
>> +				 <&apps_smmu 0x86 0x0011>,
>> +				 <&apps_smmu 0x92 0x0>,
> 
>> +				 <&apps_smmu 0x94 0x0011>,
>> +				 <&apps_smmu 0x96 0x0011>,
> 
> These two entries are logically the same (SID & ~mask) as the first two,
> does it still work if you remove them?

Yes, resulting sid is same for 84/94 and 86/92.
Basically, the resulting sid could be same, it's an optimization which
smmu is doing which can result in same SMR(Stream matching register)
routing 2 different sid to same context bank.
So, 2 sid can be used even though resulting sid remains same.

Also, DT usually dictates what hw capabilities are supported and hence,
captured all apps entries here to match the hardware description.

I hope this answers your query.
> 
> 
>> +				 <&apps_smmu 0x98 0x0001>,
>> +				 <&apps_smmu 0x9F 0x0>;
> 
> Let's keep lowercase hex
Sure, will update in next rev.
Please note, I'll be clubbing patches together in one series as
suggested by krzysztof and fix this too that time.

-- 
Regards
Kuldeep


