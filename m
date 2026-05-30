Return-Path: <dmaengine+bounces-11050-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHZ5ID8sG2ow/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11050-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:28:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD2611CB4
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71190305E45D
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29003955C6;
	Sat, 30 May 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TijMDtyU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKsg9ul7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308C219303
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165557; cv=none; b=IL50RpMDTJyZyV97si5lzi2iMcrwQILsyBNPhDVNrYUbYcqENgXsmx/GnOFzbHGMLBPI4zl+PUTJHv3gWLCN6UqiFBcFfFTvVI59vlIAgPAJX0UKTwNS8E4cGxz+70g3/iq5gYpCSHQiqpOPuxwNVTSweyBg6PFqJnBKpSWn/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165557; c=relaxed/simple;
	bh=XNmqWPCjkIT/ZliCL7TlGnWUU2zGS6zXacCYJ+HC6OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHPyGgsVDKGNf+T6h4jlglvMCShyDqGXFsbxyZyw81JQ2JQwKchPGXDu6A47J5oUItom3MUyXuUrShtgXlEipt53BgkER1fdnp1Zn1iQaZwWSIeEfRMsTPwnx49FrwmvSQxB2dNy71npJY4ApaRwKzOsphHlp5ENOj85I9qIAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TijMDtyU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKsg9ul7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOUH6211185
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=; b=TijMDtyUksXbENx4
	d+aImu6vsUm6cKeF7jyCAeFqL34FQtwHNmXWsztJSJDV4E63VjGzkCN8tROGRD7B
	t70O6Xu468DmiuvBhDX20cKH6gfbAGGAQRlmbHBdid0zVRE6lXK5C3Ado714W2Q+
	wsnyCiXVh3tb8HysTNNQVqV4WKeJ0Fvi1y8saliQ4t6ea/j5lR9Dq6rgSb/6JUv2
	KT7D6Uv0IqXHTMEDd7vVIBZy0zMZA8Fy9pXtPEuxhkelEhPjPRcLCrrlu8wWkSso
	SCslM+laEDjUySQBc/EeSkmxBh1d9sbaViq84AdSfKxCX55WX0BpJMMR5bmvcUkX
	1oXaAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efrnc9nd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:25:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c854c4b740cso2765772a12.1
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165554; x=1780770354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=;
        b=SKsg9ul7N8nU0RyAXsMfatiZlqJ28463emdvbN/4YXmKNAnSEgXKqM/t2XDbNO0/ck
         irrhCfYrnldPgaSfBMvXtJPNYcjF9hmLdknjVO/QS59rrXgMXF+zDtnoRPJPhMOKvNr6
         g5vSeGQWwW0DtAekSoBEiAXjhqq6EhZtVUl2fo0q0TykQKNWcaUzq557m2CnP25n62rt
         tR9qzWHFddl/XQI0F/F6iB3CKdIvWDPw8rR18iTqoHBTZ5JfIFXC2BlvW3F4ERRC2q3N
         wOHsHs7idBb9Bg5aw4Scnyb88dyiR3bGPMlJL1VVQZE4H9bGXP+NkfhxLP2VRgJnsR8A
         sC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165554; x=1780770354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTxwIUn+I2XU/1G/Q+9zkFJOGVGZUeY2eTBv9rFsEpI=;
        b=nKOn+xaOa7z8eCwTRrv1DeoVHLCsnMAs8tau2d+WmADSVQNbWcYt1L+FQFMtbsg6HQ
         p7uHqWQxZQ5r6/ygfswj3WeDNlqheyJgMEmsTYi77LaKDl0jn3UoRcmKe4Hfu3n5EbRA
         Necu/pOM8DhLVQlPfFB3k6aXhLEjChv3mmDAHf8bZ9r4ZpB1sPUyRn2LTNtSKypOcw26
         RtJDUSp5UhjlhZlK+uQmd8crvElnMd4BxFbmTl0sofge/H6s/fXLNLEOxHi/jADJGIEU
         JXfhIZ6aaBh/Agc6GKRrfdcHwDFw6NUF8q3twVI0BmjnasbON2svrkPBWIH8DrOxprMf
         yfWg==
X-Forwarded-Encrypted: i=1; AFNElJ84sR5ERbJcKe3ZmowDwXJgtcCsLDyeIL4i1obpg9N/+1YkAoMt1UoVFi7lEZZrMdzET9V41I0Y0J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbL4mkUVVYkLJBCWRKJ7TjDy7FEAa6MfJV7S4x/PERRHxYlzGn
	fV5xb88wlRqgbuH4BV2jiCA9eA585UxhVfuQghv/4XCNxdhCl/cn9esMIUNzk8uVq9RTFpYiXUc
	JRWg+VZx0RXUJxMDq0B6sYRaBFoYveK9MQeDmgAIiuwu5bDs0lgJ7nGa5WkolTD4=
X-Gm-Gg: Acq92OEincwHcyj/MRFEHSOr/xxYQe+ANbTN/38qJAyg1Ahy9Vn/z0aBBBSaZsWqKHI
	vodtD3vGA9Wo7T4AOY31o9xoC4ZDXVwjRDbmGL8sGFYmVNV5NW8KiYZlVXxnT8hPnMIcBevYlts
	50vqe4FDgAAYDGH2TNRRoVMTBhbOxaayMbxZ2EnOhfBVAcnMCGVj0Qn7sIeEV+H5tqfUDdmBZKl
	THpOPfXOggOeZK2a6BFx1y/Q5d7H1WKyUBE/aBPPDfYHVK650WmH/PLQ+aJY2pkiKhUFuJybTjO
	iLBPl/4Oti2x3dhxqSf3OvbSCCuYZKpkF6GkwEoxtBwMZnONh5REDLs+gWeGF2RpOGI244FVZ1k
	/3B0HGfoFXvlWBF6CM5FdqhxHC5E8T9caAK/q5euLfLsd0/rIrCrMKCsheSrD8qI=
X-Received: by 2002:a05:6a21:4e01:b0:398:840d:39aa with SMTP id adf61e73a8af0-3b427f7611dmr4719720637.29.1780165553989;
        Sat, 30 May 2026 11:25:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e01:b0:398:840d:39aa with SMTP id adf61e73a8af0-3b427f7611dmr4719702637.29.1780165553443;
        Sat, 30 May 2026 11:25:53 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.232.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm6057818a12.15.2026.05.30.11.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 11:25:52 -0700 (PDT)
Message-ID: <d4fa00d7-306b-4aa9-b599-945924c381d6@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:55:45 +0530
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
 <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
 <urft4kklev3palxzpkrbif3jx3fuwdzlj7weyjtodl62vbbzto@v3tpmfvsrlku>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <urft4kklev3palxzpkrbif3jx3fuwdzlj7weyjtodl62vbbzto@v3tpmfvsrlku>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fY0Id0gYe-6Qu6XUi_5KOOfmDVEKAxCH
X-Proofpoint-ORIG-GUID: fY0Id0gYe-6Qu6XUi_5KOOfmDVEKAxCH
X-Authority-Analysis: v=2.4 cv=FcIHAp+6 c=1 sm=1 tr=0 ts=6a1b2bb2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=VhQgrmAlsMqV4Ib2O9uomA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PA2aZWPzbia8iepHnnwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OCBTYWx0ZWRfX+DBv9LPo/XGG
 J3ZJDykYiUuOvL0hkfwc6TdTaz29KymqsK/8YXZpCDq/CAylWI8JR7ZX9ndnP15a0kRprN7bLwi
 uxiwP3SdazAGKzNgzQy5grJoXmyC5EbWOQeHC38SYInb/gQ2SqORRBYszRTGNyMD60F5ZZdYA4b
 j699Teu8WPW1WV98fq+7c6V6pVe64azMdCMVpeYlUFsAbVYB7jcsGxyqqtUXGCzWJ4Fp06lkEOp
 GnR/tnYvLXA0921nQnF+wJSowoU8XEIKjr7Nd0up799hxAc8uFMvnmyxsz1OVstD0sAqjaIrsh9
 aFr6AjrfsqRt/mxU+dk1GODkGTEzOqi32EVdoSyv2kh1Ajp8FnUqwuWRf7FerjWFZIzJNhm3mdh
 DtFYCSX530FWSa7buo3nZB3XyF7GdDtXkvheOyiPo9UM7zWewnfryDxepqMdii9LP0LA766PYi9
 EKUSrTSM608rFavK6XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11050-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,b800000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38DD2611CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/2026 4:47 PM, Dmitry Baryshkov wrote:
> On Fri, May 29, 2026 at 03:41:50PM +0530, Komal Bajaj wrote:
>> On 5/25/2026 2:57 PM, Dmitry Baryshkov wrote:
>>> On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
>>>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>
>>>> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 164 insertions(+)
>>>>
>>>> +
>>>> +		remoteproc_lpaicp: remoteproc@b800000 {
>>>> +			compatible = "qcom,shikra-lpaicp-pas";
>>>> +			reg = <0x0 0x0b800000 0x0 0x200000>;
>>>> +
>>>> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
>>>> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
>>>> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
>>>> +
>>>> +			interrupt-names = "wdog",
>>>> +					  "fatal",
>>>> +					  "ready",
>>>> +					  "handover",
>>>> +					  "stop-ack";
>>>> +
>>>> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>> +			clock-names = "xo";
>>>> +
>>>> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
>>>> +
>>>> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
>>>> +			qcom,smem-state-names = "stop";
>>>> +
>>>> +			status = "disabled";
>>>> +
>>>> +			glink-edge {
>>>> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
>>>> +				mboxes = <&apcs_glb 9>;
>>>> +				qcom,remote-pid = <26>;
>>>> +				label = "lpaicp";
>>> No FastRPC for LPAICP?
>> No, FastRPC is not applicable for LPAICP. FastRPC is primarily used for
>> offloading audio, sensor, or other DSP-related workloads, and is not
>> required here.
> Which likely means, no compressed audio support?

Yes, it's not.

Thanks
Komal

>


