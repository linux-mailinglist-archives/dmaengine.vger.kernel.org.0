Return-Path: <dmaengine+bounces-11278-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1hVLKMoJmqPSwIAu9opvQ
	(envelope-from <dmaengine+bounces-11278-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 04:27:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089626523AC
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 04:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DHsfaltA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=C3Dm3fa2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11278-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11278-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5F5301464E
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211F30FF21;
	Mon,  8 Jun 2026 02:26:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6A31328C
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 02:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885608; cv=none; b=tUfTIPLrsXACXijuHggH1JO7hK6OgaWlr3ei41kQLR961wK/ujitQyZe9SLYlAkwn+xGqKnYtm7VVbdAfnQAXAxQh9Bzalriwectc2pvlCc2uXDKIMe85FOE6edtqO9vkOdjTK7a84tFGgI0qk4LVR07i1qUOksFrn57Yy4/Z5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885608; c=relaxed/simple;
	bh=Jsb64BppIKhCh2w+6BlXRchgQjTK59vwgMt6kvspQOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/NKyLqQWdy8JZcT00zt4kiwUsaWqSNR9E/OWVGTzhlWwNVxr8HGsjkDLDQ74kmQvwpADMbrcH4enCAZ7mrZlJGGz53dVakommAENA3EQL2LUYoAOhphmX90/IRfzUP9TGFYUp60kVRNrO0mAquw0pTEf8rmSspV2LRQnYuWbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DHsfaltA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3Dm3fa2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GtqM1992379
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 02:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=; b=DHsfaltA2c8kxmJz
	LUaphdhyZePFH4GE6hR7qIpO/yD7kxuPVzSZppS+rrBb4y8J/bHPvmbMd1+nFZyZ
	8RUQrqVgl1qe/JT9sJZmCZeDcGxHBTLNLuhxwgvcvnYSshQy/vIiumvN0zTs79Wt
	hi9r5jt/HE/SGzbn0LdjTwBuDmWu3qHDDHBXV5nIa993uFlcn/2ZFI6vs/omB8FC
	U7erNzSk9ltzLkSVifOyoyLJQn8dVmPFzZRqYsDhXcBFmHswLlwIsav/pzHYMem2
	DBEtbZ+6iUCmXeZkoDhCodF18E4KbLTVqfyudOjK6snGMHcIpdbnAhJ0S/C1HD4X
	owDgIQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3nt37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 02:26:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so6511224a91.1
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780885604; x=1781490404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=;
        b=C3Dm3fa2YPrdoULFxxIHH1/HsnoSBayjNjvrscojd00JIE2asND7z2RNkqL/5txbPG
         u8aaoUwfBbrtVR9tfMvcXu3J7An9Dla8PG7NqaYOi+5MDgBaiZO7ET4wmeFNCFDBKC/i
         Np7Vbj/USyI6/79VvCjKE3adNmhuhmilgd4phxSHdUQFnA7exHXYDCr7+EkyxulcJlcW
         y+yqU0PvCBXDhnnH9I8OjaMR0oYAIsg0hwRADau0qK+vzNVCUmlInA7bAjRtMs6pte6A
         oERpinNSC4ti7ROuo73cMe5ACtUX+afMavgf103VYjLJDs+fI6c83UkhQMbj6g/OQ1Iv
         69gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780885604; x=1781490404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=;
        b=EEEFp00XdBtr4YYOOFrDwuyT0JplxDiU8/hAJVVEv6w9ltkasr/MPCZ9biOawy1yo4
         iQljsgstspAimvL9nCFo59tjath+gmYa3eBZ1tYo9E5w+uMNAEGhvQ4Rx7k+kJFUyBNJ
         1S4ID0wwl03VMD0cJF8Bp7DAvOfeoitOaeFBlu5Tu1kO5xXW7RPE6B5dM8CTJMDIVRN3
         /55WiyGAWTGMAdNT7I+08Nl8qoRxPgWrmaqC5eT4q433gZkpVi9Lu6IbGQYYhsDpXl3z
         JHByfJ7GAJaGUsTLJY8cx6ovofyNKZ463Vb7VX1dBYVzY7DKYombAyC4RSYwlazKtvjw
         Lpxg==
X-Forwarded-Encrypted: i=1; AFNElJ+GyvtKgFWU6da7ykS9iTAcwNlQoXrYSQ2VMifNyDpEJNQngMsfLGdJa7I/3GeNW8in4sWTBHbdT+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuJDAGdts9GZD3jnWWCWk+vuMHucl6KB7bZtILMdkmoaucWFP
	4GhZzKfeq8uAPnIepLoMczhR5jodHbMyvwvwvUjqxaTf9L1GxRnIbLfHqppP8GUmw7f1hcFhQ7a
	FgIQt4sY+hVf6pxmwWWwEKznrLf/N0rWWThhtIhSW+62eoOwDnUDEZzpCEq0J8EY=
X-Gm-Gg: Acq92OH5iVSVXdsnX8hVt7elz+O9eLQYck0n4wE78h41G048k+w44oXrIBKCU4rYh5N
	U2ftsWeK5E5WbiSP7PMDN96j7WWh6+yIeSDVDnjE0AJlLS6aySUZkcf2ToLeJEEI6mG2yYAnyzM
	AWE7vbuFZRXTPx9OVUtwiabbTBMLOPSDTUDFFmnHEGUygkmW5A6NPTceviSYfyT1Tn+M+SGiBTq
	+ZL/9Bk0QXMYVmFEKCpE6fQ8g3DScp6u5lHEDYTF5NOeZv15ZK2H7w8TlxaPKsHwwZ552LAC5Vo
	0JnFWoFSR8qb/5N9M9ihV3B3ESIbSLAJSsVRI2L2Vq0P+dgv12+fG7YyNjQAnVeMfJ4EDuxyXxG
	XNAxk6TQD7tBRoaHSZuQFHLGv3P7l/XQ1YhQdGi4ziTiFtaVx86J7luXqJ8iTgo5im086ALmyHS
	IU2x1plP6OtKeoYCT7uXna5QVuF+9f
X-Received: by 2002:a17:90b:3852:b0:369:73a:326a with SMTP id 98e67ed59e1d1-370f096a635mr14237010a91.13.1780885604475;
        Sun, 07 Jun 2026 19:26:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3852:b0:369:73a:326a with SMTP id 98e67ed59e1d1-370f096a635mr14236974a91.13.1780885603863;
        Sun, 07 Jun 2026 19:26:43 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d013c9dsm14548354a91.8.2026.06.07.19.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 19:26:43 -0700 (PDT)
Message-ID: <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:26:37 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfXz1SxBJwODhQ5
 YrAKwGbUUwBRfugPrJjg4/wvkbHkzMWsaSmTC/KynvgUM3XHMBfX7FQos+FUXUqSCGzXiTvWdlS
 63nObf4vCUMVT7TMVpviVfNTvXfSrTkFJyfxgtl7YT5oG4zyc23jXz4Qh7L6ALKHOHnwJlkLbEB
 lAZSGsl7uocG/4QTUywhy5CVEO9/1vRNbCBfbzlQhRyNTfqHwPczd8j2UzwIjJ5KF/17BlVpbFP
 3s+vEbeWqhdFvVCbYlvJwmuAgjrmgWrHThrpHShRbEFyWe1QjCxI0zGG99I0RclJoYbvzpo6nh8
 M0OzOBf2r5MZQaJvUSY4fE3cLqC1RynlOQjiIitm+DTpHbzTLTGw9LbF0v1sV/6W5338SnEwwp2
 PHNdNZUGYrAuyLjDdqoxEZO4rPqH8Ks1HwxdsNT/x7Hh1xzhjQhKLHipxvEzfYfh9jEzGZ9uixH
 ZGpFoqOWWm2kaWsIqUQ==
X-Proofpoint-ORIG-GUID: BFcK6GekTU0pRwoXrP-tANlO19tCa4fQ
X-Proofpoint-GUID: BFcK6GekTU0pRwoXrP-tANlO19tCa4fQ
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a262865 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zxmW70ayUQ2lO-hVVeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11278-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miaoqing.pan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 089626523AC



On 6/6/2026 8:57 PM, Loic Poulain wrote:
> On Mon, Jun 1, 2026 at 2:57 PM Komal Bajaj <komal.bajaj@oss.qualcomm.com> wrote:
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
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
>>   5 files changed, 223 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index b112b21b1d79..c2ed0396533a 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -16,11 +16,48 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm4125_l7>;
>> +               vddxo-supply = <&pm4125_l13>;
>> +               vddrf-supply = <&pm4125_l10>;
>> +               vddch0-supply = <&pm4125_l22>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +94,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> index e62ba5aef71f..3bfd0050064f 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> @@ -16,11 +16,48 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm4125_l7>;
>> +               vddxo-supply = <&pm4125_l13>;
>> +               vddrf-supply = <&pm4125_l10>;
>> +               vddch0-supply = <&pm4125_l22>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +94,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> index 8b03d4eafa6d..a79f44aff968 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> @@ -8,7 +8,22 @@ &qupv3_0 {
>>          status = "okay";
>>   };
>>
>> +&tlmm {
>> +       sw_ctrl_default: sw-ctrl-default-state {
>> +               pins = "gpio88";
>> +               function = "gpio";
>> +               bias-pull-down;
>> +       };
>> +};
>> +
>>   &uart0 {
>>          status = "okay";
>>   };
>>
>> +&uart8 {
>> +       bluetooth {
>> +               compatible = "qcom,wcn3988-bt";
>> +               max-speed = <3200000>;
>> +       };
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> index 727809430fd1..95bd797d009d 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> @@ -16,11 +16,56 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       vreg_wcn_3p3: regulator-wcn-3p3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "wcn_3p3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
>> +       };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm8150_s4>;
>> +               vddxo-supply = <&pm8150_l12>;
>> +               vddrf-supply = <&pm8150_l8>;
>> +               vddch0-supply = <&vreg_wcn_3p3>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +102,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm8150_s4>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
> Does the firmware differ from the one used on Agatti (QCM2290)?
Yes, WCN3950 vs WCN3980.

>
>
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index c1f25ce89bb1..6bac6ebac8da 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -2064,6 +2064,29 @@ apps_smmu: iommu@c600000 {
>>                                       <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
>>                  };
>>
>> +               wifi: wifi@c800000 {
>> +                       compatible = "qcom,wcn3990-wifi";
>> +                       reg = <0x0 0x0c800000 0x0 0x800000>;
>> +                       reg-names = "membase";
>> +                       memory-region = <&wlan_mem>;
>> +                       interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
>> +                       iommus = <&apps_smmu 0x1a0 0x1>;
>> +                       qcom,msa-fixed-perm;
>> +
>> +                       status = "disabled";
>> +               };
>> +
>>                  intc: interrupt-controller@f200000 {
>>                          compatible = "arm,gic-v3";
>>                          reg = <0x0 0xf200000 0x0 0x10000>,
>>
>> --
>> 2.34.1
>>
>>


