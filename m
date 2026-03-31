Return-Path: <dmaengine+bounces-9771-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGxhBmyzy2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9771-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:43:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8644368FBE
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0CF630B4C64
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7523DB62F;
	Tue, 31 Mar 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EMd4PLnE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0F346E46;
	Tue, 31 Mar 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956803; cv=none; b=CRUUTXC5Ja5nAlO7cftXBOGfh1vBTN7BZuOHZiGHrVBndr4+vse2eYNi5YuFaznZqCkvNqUJO9LobJ8DCGY6RLws0+W/NFg1jnjVX+Q8NdmALlA4YNP2Aeb9/2LUFft2Vtok/PPOsCidtqYZDBIk6wfadFRRomUwLslvkrbKxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956803; c=relaxed/simple;
	bh=mOaMnPDgyuMsrsFoPrx7hh3B2z/mugXNaNBIZ6Il/TY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ViKsokzAh0VeKBkmVUMusAfN8SSX1WV29q1Cyn88uE2zGeI5nWYScBUvKugMEgGKFjUA8ttLlncSrRR0PnN1737D1qpbTqrWv1C+d2+wQZeWXKXyXvKOiL1lWvwNDOY9MHxvZNcFoIZRpedNKoLuV3Aa4H2SCNQTrnO9e8lQQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EMd4PLnE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6a6YW2391425;
	Tue, 31 Mar 2026 11:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eIYSrlhSzunjL6LJuOo+pd3YcmHnTM0iPtojTzT1UTA=; b=EMd4PLnEvRVbDQnU
	pZkHlViDXddtgG1L79JF4hjEU5SH0RpHigO/qtjO8aBY1ixQQFj4h+eSbTLBoA4c
	pZQ9gd0dYm9682e4Tbg/aT3afGCBE2FZm2CYml+Z2st5SJjIns0Lj8eaIY7Ecd5f
	ax3h9AfhQEK1wibW7W08ZdAroMexFQKTmtOowyZIFtmo6lD9TMMt5bI/CucXJMvS
	ewbhvaHFK/9/vWmymAubJVU1dHMspdv9c8T/BMNwEn1X/PZBK9mwBfENEEoR3wK8
	VFCuZbqrPHOx5iaRXTA57odVO5UlDuizGTjjJ21gHerw7STYhyGxtzB8tWi6iee4
	2HKAXg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7ue7marc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:33:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 62VBXDjN014348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:33:13 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:33:07 -0700
Message-ID: <ec299ca8-cfa2-4a53-93d5-4395a7cc5e7c@quicinc.com>
Date: Tue, 31 Mar 2026 17:03:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] dmaengine: gpi: Add Lock and Unlock TRE support to
 access I2C exclusively
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>
CC: <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <andi.shyti@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>, <linux@treblig.org>,
        <dan.carpenter@linaro.org>, <Frank.Li@nxp.com>,
        <konradybcio@kernel.org>, <bryan.odonoghue@linaro.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <quic_vdadhani@quicinc.com>
References: <20241129144357.2008465-1-quic_msavaliy@quicinc.com>
 <20241129144357.2008465-3-quic_msavaliy@quicinc.com> <Z01YBLcxDXI2UwXR@vaman>
 <d49b16b2-95e5-42b4-9bc1-40cb0bfa15b1@quicinc.com> <Z1BJSbf+1G8ojTib@vaman>
 <5ef44277-6739-4e1e-af62-0f40ae081ec1@quicinc.com> <Z2qFyQFFjiHy+FvY@vaman>
 <b34e3ac0-70b4-491c-a807-dc13fac41d06@quicinc.com>
 <1566eafb-7286-4f27-922d-0bbaaab8120b@quicinc.com>
Content-Language: en-US
In-Reply-To: <1566eafb-7286-4f27-922d-0bbaaab8120b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExMiBTYWx0ZWRfXyk82Hv1gelpN
 ZoaATjyp8P/pB4siQvJJRmUtG45l5eQgJ9qulrz1/Q+RAK+ZgRLkeO7wUbG+5AmQm9R6BsOkG5w
 RQ+NfQvubS7969UJSpfXATuK+1wOaYlbaI2xiYaMMbbIhuaOYINBaSRBg3e4mk9oDPVL+hI8Z/E
 XAaJaGfpYs8J+eiI98+UyU+c7WTHBodlyvxYKcfHSYIVhGk4PyTBm3UbxdsydkC54+aPMyVPNA2
 +bhK+F1Y5dUd1nlp39DYxLcpNSTAEy2rR2zszmtWBZizBDIER5v5S5+lR/y7t43Od1DAl5xjwad
 u/7hWEXe5aQHho9MXK14asAlveSCj64ndUkU1AQbCv0Sg0hI6QARnWdSnBPPiHRCPAJuyxrFWbE
 NWm2wzNYOoL7T9HowxQ9pT1d2ONLp5VQkWe4uLi86Csbp6ZrcDNVtYqksKgxpihslh0Vym9JVPF
 CO0Mz+AFZHwWC8w7vMg==
X-Proofpoint-GUID: _BQQFibzR4NoAoqiE9bMqYGRhkVys2WL
X-Authority-Analysis: v=2.4 cv=G7sR0tk5 c=1 sm=1 tr=0 ts=69cbb0f9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=JckwoUCwfWRlAPUsidsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _BQQFibzR4NoAoqiE9bMqYGRhkVys2WL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310112
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9771-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:dkim,quicinc.com:email,quicinc.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quicinc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quic_msavaliy@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C8644368FBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod, sorry for responding here much lately. I was completely away 
from this work for long, restarting now. Will close this actively 
following up here and I will upload V6 to share latest changes and cover 
letter details to help review ahead with context.

Thanks for your time and help review this ahead.

On 1/14/2025 2:48 PM, Mukesh Kumar Savaliya wrote:
> Hi Vinod,
> 
> On 12/26/2024 5:52 PM, Mukesh Kumar Savaliya wrote:
>>
>>
>> On 12/24/2024 3:28 PM, Vinod Koul wrote:
>>> On 18-12-24, 18:04, Mukesh Kumar Savaliya wrote:
>>>> Hi Vinod, Thanks !  I just saw your comments now as somehow it was 
>>>> going in
>>>> some other folder and didn't realize.
>>>>
>>>> On 12/4/2024 5:51 PM, Vinod Koul wrote:
>>>>> On 02-12-24, 16:13, Mukesh Kumar Savaliya wrote:
>>>>>> Thanks for the review comments Vinod !
>>>>>>
>>>>>> On 12/2/2024 12:17 PM, Vinod Koul wrote:
>>>>>>> On 29-11-24, 20:13, Mukesh Kumar Savaliya wrote:
>>>>>>>> GSI DMA provides specific TREs(Transfer ring element) namely 
>>>>>>>> Lock and
>>>>>>>> Unlock TRE. It provides mutually exclusive access to I2C 
>>>>>>>> controller from
>>>>>>>> any of the processor(Apps,ADSP). Lock prevents other subsystems 
>>>>>>>> from
>>>>>>>> concurrently performing DMA transfers and avoids disturbance to 
>>>>>>>> data path.
>>>>>>>> Basically for shared I2C usecase, lock the SE(Serial Engine) for 
>>>>>>>> one of
>>>>>>>> the processor, complete the transfer, unlock the SE.
>>>>>>>>
>>>>>>>> Apply Lock TRE for the first transfer of shared SE and Apply Unlock
>>>>>>>> TRE for the last transfer.
>>>>>>>>
>>>>>>>> Also change MAX_TRE macro to 5 from 3 because of the two 
>>>>>>>> additional TREs.
>>>>>>>>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> @@ -65,6 +65,9 @@ enum i2c_op {
>>>>>>>>      * @rx_len: receive length for buffer
>>>>>>>>      * @op: i2c cmd
>>>>>>>>      * @muli-msg: is part of multi i2c r-w msgs
>>>>>>>> + * @shared_se: bus is shared between subsystems
>>>>>>>> + * @bool first_msg: use it for tracking multimessage xfer
>>>>>>>> + * @bool last_msg: use it for tracking multimessage xfer
>>>>>>>>      */
>>>>>>>>     struct gpi_i2c_config {
>>>>>>>>         u8 set_config;
>>>>>>>> @@ -78,6 +81,9 @@ struct gpi_i2c_config {
>>>>>>>>         u32 rx_len;
>>>>>>>>         enum i2c_op op;
>>>>>>>>         bool multi_msg;
>>>>>>>> +    bool shared_se;
>>>>>>>
>>>>>>> Looking at this why do you need this field? It can be internal to 
>>>>>>> your
>>>>>>> i2c driver... Why not just set an enum for lock and use the 
>>>>>>> values as
>>>>>>> lock/unlock/dont care and make the interface simpler. I see no 
>>>>>>> reason to
>>>>>>> use three variables to communicate the info which can be handled in
>>>>>>> simpler way..?
>>>>>>>
>>>>>> Below was earlier reply to [PATCH V3, 2/4], please let me know if 
>>>>>> you have
>>>>>> any additional comment and need further clarifications.
>>>>>
>>>>> Looks like you misunderstood, the question is why do you need three
>>>>> variables to convey this info..? Use a single variable please
>>>> Yes, I think so. Please let me clarify.
>>>> First variable is a feature flag and it's required to be explicitly
>>>> mentioned by client (i2c/spi/etc) to GSI driver.
>>>>
>>>> Second and third, can be optimized to boolean so either first or 
>>>> last can be
>>>> passed.
>>>>
>>>> Please correct me or add simple change where you would like to make, 
>>>> i can
>>>> add that.
>>>
>>> I though we could do with a single and derive
>>>
>> Sure, so as mentioned in the other crypto BAM patch probably 
>> dmaengine.h can hold flag and that can add support for lock/unlock 
>> similar to that patch.
>> I just realized it from your shared patch. let me work internally with 
>> Md sadre and review. Thanks for the comment.
>>> Also, please see 20241212041639.4109039-3-quic_mdalam@quicinc.com, folks
>>> from same company should talk together on same solutions, please
>>> converge and come up with a single proposal which works for both drivers
>>>
> I have discussed with Md Sadre and tried to understand and utilize the 
> enum of lock and unlock in my changes. Below is the summary.
> 
> I can't use those lock and unlock enums here because it's required for 
> first and last message respectively. intermediate transfers will not use 
> anything. So we need to define one more enum like dma_ctrl_none.
> 
> if i create another internal parent structure having required 3 members, 
> then also it will need 3 child members. So i think current one looks 
> good to me.
> 
> Please help review and suggest if anything can be better here.
> 
I have added enum from gpi driver and set it from i2c driver. so GPI 
driver handles the action accordingly for lock/unlock. Let me know if 
this approach makes sense in the V6.

>> Sure
>>
>>
> 
> 


