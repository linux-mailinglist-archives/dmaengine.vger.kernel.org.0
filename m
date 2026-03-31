Return-Path: <dmaengine+bounces-9772-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO+vN1O0y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9772-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:47:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB53690AF
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0062730620C4
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83CE3DC4C7;
	Tue, 31 Mar 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dfkm+mQd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383463BF680;
	Tue, 31 Mar 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956908; cv=none; b=S4mff3fQrMIL5PFd/ShX/TmKMG97rjA5tTjSSVx6I0jE5EWtS1q7YvcLDQGTtSyEolmzpp3tSd4uAMbHpPf1FrpIN+quldl+JnqaE+m4Defagnaz0Z2e/ULTMdvcY/pomxAm8qdbiQyMndv9xZ8uaxk4mT5s3KnSCrktwR8EdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956908; c=relaxed/simple;
	bh=iw2nbRNvTNhMEZpHJGdylsAbAADzQDP14RngEClAXXA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=NsGm0e9E42hXzE12QlaJvZ4+P04JRk7aP1RhmmduuohDUrHkPPqutxU68TQqpVS7ieKCNP7BFe7Ax6Sb56xfDTj5OwXnPYDvY7d0KdQci9kTOAzs+4Wk+/VgX4d4hCOduYlNrb0xUr+6gOag7wz9kO2RCrYSOTEgbVB1OnBSiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dfkm+mQd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V61prD2407599;
	Tue, 31 Mar 2026 11:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OknH5510GMPxRr3A1I6WUbD2Orc3lEMFsn9yBnFsmDY=; b=Dfkm+mQdNpXDDa8W
	tIIihVmVhJmVP6itykSzuqXq2NjURbQG+oHzWNWorQe8TmLp9jGd2OSmpbrxDML/
	JRTahlOdxaxJxHdMKXWUCqLIVoBMQhny3GNAVHb6eu+2tRQIYQd6LuTYq0H2yiHr
	PC+7mEpmri7CqtIOKihJBYFrHJAkqfBx2cSMRv+tzVPsF/yIiZETi4FKy/ES4e0n
	G5+oUmdmYv0fOyP+8QDxmyQJLwtDX2/x7VZGr1wGCzH+vPtEq6zTCL5slaBbo/Y6
	Ca6VWibGIh/QSM4RHUymUC7rYZ01w9hZuhcqCeaFKKc4NnWf1CpBhrg5QsqXMOpZ
	hyWxKg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hetut3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:34:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 62VBYvc1009312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:34:57 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:34:51 -0700
Message-ID: <614b908c-aa0a-4f05-8761-7b722160cf33@quicinc.com>
Date: Tue, 31 Mar 2026 17:04:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] i2c: i2c-qcom-geni: Enable i2c controller sharing
 between two subsystems
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <konrad.dybcio@linaro.org>,
        <andersson@kernel.org>, <andi.shyti@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <devicetree@vger.kernel.org>, <vkoul@kernel.org>, <linux@treblig.org>,
        <dan.carpenter@linaro.org>, <Frank.Li@nxp.com>,
        <konradybcio@kernel.org>, <bryan.odonoghue@linaro.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>
CC: <quic_vdadhani@quicinc.com>
References: <20241129144357.2008465-1-quic_msavaliy@quicinc.com>
 <20241129144357.2008465-5-quic_msavaliy@quicinc.com>
 <ce9f1ab1-56a0-4c0a-aa5b-f044111288ec@oss.qualcomm.com>
 <57815272-bc07-4c5e-8ae6-8bf8eaaca78f@quicinc.com>
 <cc8655ed-0021-4490-8873-519c9b5b939c@oss.qualcomm.com>
 <5e83f946-e157-4ec0-8ebf-14dbbdb93e34@quicinc.com>
Content-Language: en-US
In-Reply-To: <5e83f946-e157-4ec0-8ebf-14dbbdb93e34@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cbb162 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=e2zjlk6G_uH4ECtknV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Er03ZWea6JqFKSbJsCHwFkxnsaQEo3Q5
X-Proofpoint-ORIG-GUID: Er03ZWea6JqFKSbJsCHwFkxnsaQEo3Q5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExMiBTYWx0ZWRfX3aN/sccOfDEq
 z5TKA8EN5ZjtCxkK1bB8FZ36Z3zMos26qaVzGC+QJyIlo76M/9BrM1hxwDhvQ1hRS+FzJXSPqmj
 eh9wCx49nw6rBRZt584Z+gSBNTkL1s90bayicCSyaWGkZseC/mSC4r7wVMCuccoAC7l8CslmlR8
 TktpIjdKRGmPwi06yM4jO4LEpXWaAw6js9lAbEMQqxNr/O/ODb3jbTeVGbJL8lZoXCvHOwydI2y
 zM3taHL0qYS64N6Ba6HC9Q9VW69XiYBr3w+PN/zvV2kUxSTUO0Oau7rj/Z0g1a5Gh0R9yIB9prg
 +vTPEq3ByUlH+JGimewEpsoggZESy6jOum4qVCBbgt73XN2ekNDLU/F0VK4t3bV9k1zLT7chtn/
 uxLP0VwRRTNsz2BY5MX1xT+Pqzq8lYeFi55T+5OhPlg4GQykcd8781Uux5118VuuP7QVuB3xERq
 eNbn19cEUCj1u96Pp9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310112
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9772-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:dkim,quicinc.com:email,quicinc.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quicinc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quic_msavaliy@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DAB53690AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Konrad, Thanks for the review and sorry for long delay replying on 
this change. I was completely away from this work.
Let me upload V6 to share latest changes and cover letter details to 
help review ahead.

On 12/16/2024 6:17 PM, Mukesh Kumar Savaliya wrote:
> 
> 
> On 12/16/2024 5:40 PM, Konrad Dybcio wrote:
>> On 15.12.2024 9:59 AM, Mukesh Kumar Savaliya wrote:
>>> Hi Konrad,
>>>
>>> On 12/13/2024 6:35 PM, Konrad Dybcio wrote:
>>>> On 29.11.2024 3:43 PM, Mukesh Kumar Savaliya wrote:
>>>>> Add support to share I2C controller in multiprocessor system in a 
>>>>> mutually
>>>>> exclusive way. Use "qcom,shared-se" flag in a particular i2c 
>>>>> instance node
>>>>> if the usecase requires i2c controller to be shared.
>>>>>
>>>>> Sharing of I2C SE(Serial engine) is possible only for GSI mode as 
>>>>> client
>>>>> from each processor can queue transfers over its own GPII Channel. For
>>>>> non GSI mode, we should force disable this feature even if set by user
>>>>> from DT by mistake.
>>>>>
>>>>> I2C driver just need to mark first_msg and last_msg flag to help 
>>>>> indicate
>>>>> GPI driver to take lock and unlock TRE there by protecting from 
>>>>> concurrent
>>>>> access from other EE or Subsystem.
>>>>>
>>>>> gpi_create_i2c_tre() function at gpi.c will take care of adding 
>>>>> Lock and
>>>>> Unlock TRE for the respective transfer operations.
>>>>>
>>>>> Since the GPIOs are also shared between two SS, do not unconfigure 
>>>>> them
>>>>> during runtime suspend. This will allow other SS to continue to 
>>>>> transfer
>>>>> the data without any disturbance over the IO lines.
>>>>>
>>>>> For example, Assume an I2C EEPROM device connected with an I2C 
>>>>> controller.
>>>>> Each client from ADSP and APPS processor can perform i2c transactions
>>>>> without any disturbance from each other.
>>>>>
>>>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>>>> ---
>>>>>    drivers/i2c/busses/i2c-qcom-geni.c | 22 +++++++++++++++++++---
>>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/ 
>>>>> busses/i2c-qcom-geni.c
>>>>> index 7a22e1f46e60..ccf9933e2dad 100644
>>>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>>>> @@ -1,5 +1,6 @@
>>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>>    // Copyright (c) 2017-2018, The Linux Foundation. All rights 
>>>>> reserved.
>>>>> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights 
>>>>> reserved.
>>>>>      #include <linux/acpi.h>
>>>>>    #include <linux/clk.h>
>>>>> @@ -617,6 +618,7 @@ static int geni_i2c_gpi_xfer(struct 
>>>>> geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>>>>>        peripheral.clk_div = itr->clk_div;
>>>>>        peripheral.set_config = 1;
>>>>>        peripheral.multi_msg = false;
>>>>> +    peripheral.shared_se = gi2c->se.shared_geni_se;
>>>>>          for (i = 0; i < num; i++) {
>>>>>            gi2c->cur = &msgs[i];
>>>>> @@ -627,6 +629,8 @@ static int geni_i2c_gpi_xfer(struct 
>>>>> geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>>>>>            if (i < num - 1)
>>>>>                peripheral.stretch = 1;
>>>>>    +        peripheral.first_msg = (i == 0);
>>>>> +        peripheral.last_msg = (i == num - 1);
>>>>>            peripheral.addr = msgs[i].addr;
>>>>>              ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
>>>>> @@ -815,6 +819,11 @@ static int geni_i2c_probe(struct 
>>>>> platform_device *pdev)
>>>>>            gi2c->clk_freq_out = KHZ(100);
>>>>>        }
>>>>>    +    if (of_property_read_bool(pdev->dev.of_node, "qcom,shared- 
>>>>> se")) {
>>>>> +        gi2c->se.shared_geni_se = true;
>>>>> +        dev_dbg(&pdev->dev, "I2C is shared between subsystems\n");
>>>>> +    }
>>>>> +
>>>>>        if (has_acpi_companion(dev))
>>>>>            ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>>>>>    @@ -887,8 +896,10 @@ static int geni_i2c_probe(struct 
>>>>> platform_device *pdev)
>>>>>        else
>>>>>            fifo_disable = readl_relaxed(gi2c->se.base + 
>>>>> GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
>>>>>    -    if (fifo_disable) {
>>>>> -        /* FIFO is disabled, so we can only use GPI DMA */
>>>>> +    if (fifo_disable || gi2c->se.shared_geni_se) {
>>>>> +        /* FIFO is disabled, so we can only use GPI DMA.
>>>>> +         * SE can be shared in GSI mode between subsystems, each 
>>>>> SS owns a GPII.
>>>>> +         **/
>>>>
>>>> I don't think this change makes things clearer, I would drop it
>>> Shall i revert back to previous change ? What's your suggestion ?
>>
>> Yes, drop changing this comment.
> Sure, Thanks for confirming !
Done this change with new flag name addressing the previous comments 
from dt-binding file.
>>
>> Konrad
> 


