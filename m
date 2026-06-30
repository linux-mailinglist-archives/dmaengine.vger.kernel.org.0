Return-Path: <dmaengine+bounces-11889-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OVnzOWvHQ2p5hgoAu9opvQ
	(envelope-from <dmaengine+bounces-11889-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 15:40:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D896E4F46
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 15:40:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z9vhIgom;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AoOZaxoT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11889-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11889-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBE03090B8F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D483385B2;
	Tue, 30 Jun 2026 13:34:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D63033D6
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 13:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826495; cv=none; b=XsaKdpNF9wDC1b+mcAeFAchOyP9BYAYtrV4jSh/EJ7qL+7pji+Iwh35s40NAxgrWVASK6R7tzO6XYJk3ba4XI9WyDGBR8NJ0u79IdftTvK1oLyqfl436/No0gy7lgDG5LDcMGl6WblTcoLttTLZ8K6h5Eg+UGimHUvmHg6ih9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826495; c=relaxed/simple;
	bh=lf5muHMerkgYyNulxHootfh/dLZ4mJu+DE9+2JmiVjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxqeaaxUjlX/ml2seiKNAEGl268kLXpGq0oAha7plj19whajBy6vqy0TrWBxJVti3By10YNCiuH5j3OQQxZzgI6Saw2e/YUCizCvhnDnBzu0rT+8mQlRGaDhPfpDernwTRnmeKonEou5na4Gh1VKKUpwdk9FIZtJaNpo58l18lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9vhIgom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AoOZaxoT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mxUB1612151
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 13:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=; b=Z9vhIgomyWkOT0aG
	cGJYJniEsMVpjTvpRpZfeprYaz+liwJq5kOi2lP6ghNNzQ8KX9pURwoY9zQcOqKm
	xBhZgMuZV49nhbT4evKSYwT8gT7RxF45AYt5nH9sGQZstYyZlGddO5mPZI8x5ftq
	r9yp3LM5vDZWY3w+Gd+881d4sZrx1P8XJ1lhr63ePv594N3JxY8bDkVldyrylBBZ
	zynmNZxCl+RfdARry/1BRaYn54wvcXwV3cSfj61+XyqNx0qG99PmfCjnkeuY5i4O
	erSj6ng8nUICXOErRyLC09gd5FnQ0UD21T5bXFrGYWBP/wfSfSR062QuAoVsnZRG
	t9L7rw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gtv98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 13:34:53 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9ee20bde0so959082a34.2
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826492; x=1783431292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=;
        b=AoOZaxoTtbQZFhG08d4xdKuScTjqYv2cbh32mmWNClzntFRRXzDmHsmSFEssvnyi7v
         DCakboZ/D+xUiHhcZ6/uVdItA5+xT+jK7JWZX6BoLp0bi3xqX0bR9FIVkkd4Rd7vdTig
         T0cHZ2Z4dF3bhu9a/QhkbTTkXdlnwLy++2B3XQa6Fml09BkqJ+2ceWRvh2Kf0UUFEjhY
         fooaVE405SjxzKEZQ2Wur/EjkNriDPBIR3k0+l/jLMn6WQ7/mLHsaUu0SUI6/hwqFY99
         6/PfYyDqi9q9BpUCDbKYXa/KwdI7NTZnAtUcLqe8jv6lBuo///myBI/P0Jso/plUB9d6
         xT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826492; x=1783431292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckhdrwMYtOuN/qXXR0kWeVLkD9KT3fYjy7oGRrF/bp0=;
        b=e2s97Oh0EOiZ+Ay8cpjc8noFv143+8pbKovdEVgdbzvsJ6gN3/ucSwCL8zrdHKJX0R
         Ww9B26zYWha9y7MbZejDYeDQW3Q5BbZhBe+OPhuaYk6q7vIRVbEdmr5a8dZO2cPfg2tD
         B4CLAIxwHI2aU3w8LYaJvjD7SsrEZ1gfNy0GidwVw6Tx4I3+HXsdB7RmZ68cXSst8x2X
         G97pmbGuUEyGvMQZ+ju6hwiDx0a35F26u1k2J5xfeT/V330X749YmVfPQBPjVRcxyCkH
         1WSe+VX01jrbRMF4pzi9Nf9NQ8DSl8jYtSrdxl4CZGmn8dCL+3/jquZiATEHu9SeOoLN
         Eycw==
X-Forwarded-Encrypted: i=1; AFNElJ8XsOwT6jXCk+OEHPaHSm6pYa65fDXl8866HUGxIvCx5sIenDhQQacOgf70Jqr1wKr5BvfMFlo0dgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxFcdVXvRn+zf6PsciYC6bSDDcwuDS39YKIIirxGWtPhvB5xt
	ihJF6onIizYqPhuvkwKIEngqp2eFO75b3T4O6Njwsl8PlnJmXP+R/jZHxd1ufPW82wuRMdsCKlJ
	0a1C5qzFNZ8hsvj9s2wJSlbY2fTFDL0jDxwL2b0Dor8QoUbyK2xchiW7PfwFkOtQ=
X-Gm-Gg: AfdE7cmJ8ppll9e+G4ZYsiM+2xGl9BHLicOrAy+OJglnbCWMPKak8HMFVpdhNKIPut7
	DGSUag61P421oqFEjLMxXXfZAMpTrIoYGaevxtENPSMSaMbzVLQCailZ3yUz9b88rdoR10JrANW
	az5Z/Uax0Lb1xyaHheJR7SS5mTAjKcCzvqTk5+4VwZb01ndwDqxX+TCbClCekhxlPs5KJo/YCji
	pQWaka2uAM7JpC3jn7Q1wH6ChBDQ98tYbt5tKGDWbG3zaG7Knyo9VLc6XXrO7yVoZqY6v8rB1Hg
	cYPTJcI7XGUGKOLa/Wk8WQEmwqV0W7k9mscfSkiaKSQZKV4fWuGc2YVCyeEAs+lx9sMVzloYC2e
	gtpKlxCgLlNuC7FUsMqCuNDKTkOQ6dcFKzjxhf3w=
X-Received: by 2002:a4a:d1f0:0:b0:6a1:7ade:766f with SMTP id 006d021491bc7-6a1892be9d6mr2176994eaf.68.1782826487345;
        Tue, 30 Jun 2026 06:34:47 -0700 (PDT)
X-Received: by 2002:a4a:d1f0:0:b0:6a1:7ade:766f with SMTP id 006d021491bc7-6a1892be9d6mr2176847eaf.68.1782826482116;
        Tue, 30 Jun 2026 06:34:42 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448dbb2302csm2293397fac.7.2026.06.30.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:34:41 -0700 (PDT)
Message-ID: <e11f57f2-bf15-4c06-ab3a-ab2843818a41@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 19:04:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
 <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <64691236-178a-4fc2-a9c0-f053b7944e66@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNiBTYWx0ZWRfXwk0Eh36hKsxM
 F04nvp0R0qpShqEQlOBTqNP6HxScUSIf+4p+LFoWvnMLtz6i+K3TUN2H1sGS3InAvkXo3O501bY
 9aJow9/rODT3Cp6JNN9ucMV1IIFp6eA=
X-Proofpoint-ORIG-GUID: Hv6vSedGD6ClInQ1zd9wFlkhRkAuEfLQ
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a43c5fd cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=IW_wJ7xLveG3VXcQuYoA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNiBTYWx0ZWRfX6X5TPF1sJq1T
 /eJr5ESjJXgiFCQK6cC82gv9M8xukAvy04GWAXZSgb+aBQXaZ24TQqllVHKH/vuSIEWiucV9FLH
 HkWTBVPuHg/cXfHzyqnbcjShBaOyA05M2fTEOECQMQSD50EGucKaFIhZ3/UxIIkyO9wwq3XGoLB
 NsUpSZSsF9TDeA8DpGwyKjyzH73Zhk8IL1CLMV90u1av8LUVo5wNNc5/4E3nLBGbeY8tK95oX5c
 fOhkdi+AWnpnlG2JdnyIdLhPKzt6G1xZ9SClfZSLT2Dy/8gCFrJ3/xG7OBU/dENxGEpLZUBp4Rn
 UfujlQFJVpmVeWPn5UtkGCEMpBnFFLEkq+2CGDw+HtPnXncN5SUzFdCLMNRyWTZSx4zSJYI+TSQ
 EUDqyuQS39EcFL63MrTWigjAxHfzRQ2k9+pAGjUKgwsySZxZ+j6rt+f+BHdre0Yy3OPiMVyMyyS
 vIIb8ciOQ6+x5grM+5g==
X-Proofpoint-GUID: Hv6vSedGD6ClInQ1zd9wFlkhRkAuEfLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11889-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89D896E4F46

On 6/29/2026 8:04 PM, Konrad Dybcio wrote:
> On 6/8/26 3:10 PM, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
>> with register space, interrupts, IOMMU configuration and reserved
>> memory. The node is kept disabled by default and enabled per-board
>> with the appropriate PMIC supply connections and calibration variant
>> selection.
>>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> --->  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
> Split the SoC and board changes

Sure, i will the changes.

>
> Should most of the board-level changes go to evk.dtsi, since
> they're almost identical across all boards? You can e.g. simply
> override the supplies in the IQS EVK DTS

For wcn3988-pmu node, I can move it to shikra-evk.dtsi and add the 
supplies in the board DTS files. However, this approach will be 
subjective to per node, as other nodes (such as sound) have 
board-specific changes beyond just supplies.

Thanks
Komal

>
> Konrad


