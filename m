Return-Path: <dmaengine+bounces-8836-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGZuG7TaiWlFCgAAu9opvQ
	(envelope-from <dmaengine+bounces-8836-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 14:01:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9B10F504
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF7F430071CD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88284371063;
	Mon,  9 Feb 2026 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KnCQA/bX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891636E493;
	Mon,  9 Feb 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637415; cv=none; b=Yy6H5h8dQl4bmayh6U3epWfmAb2B0ZNHqSqSAW18hI2f5IyJByD7/Y7uZZDjRFNFumdNcy/l6HddVCJJdaRImd/wjg05M3L+gRPyAti2ejJIyOx9HI0phFCHYpdO0849FKpQ5sghmA22oYhH6vBJHwSe8d9Nnh7jBzeqt97T504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637415; c=relaxed/simple;
	bh=HfAU57NJtKc4YRR2BaBG0R4X3RbAyJhhIodM5FqGjn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AmBgnmGs3gfw6qe9R1mZY1RhVckNQlkcxnnBM6FBcKLUyK/6MpZdo4R5Tob8UyLxrMHetznwIMLEHp+gp1PBr1FiaLzVeJnS8mZzQqYS3I/B4/mt0tb9rqhohk70u5gFD0oIqQ12OP7R66/Rxm1Rnd+MEJk3m0lySICRZ4ga/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KnCQA/bX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619BK94g3347579;
	Mon, 9 Feb 2026 11:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zid3oGCBnfFKJSwoctBf1omD5MUK2hmM4sXh1XtX8Zw=; b=KnCQA/bXzQE4s74W
	Rt+ZoEa0u0N6KVbyns+a04+j7beA3OhxRUL+NqJugzF0x7hIalKTxqe8rbcuwORh
	25tI9iaIrTiXI0PCS0hywbfk9xzIl5MXfbJUeJl3B9DEhnjgmpddq5gaBY6Q4ySQ
	CH9OoskULbiu/GCzdFcQ3pT9LgFYYXiJkqede1D3uzvjQEK+Io5DgLkcbPnSN7Uw
	wi+Tl41tcjD5ya77kPRn4bgcD90GXdFqHLdtP44Bx+hUekZyO3oB2eDB+sZFEkfO
	B7DT4F2ZVJs86x+osdwOk0k55jMuIpDcC0t89unRHrS5GonnrtJZWmJUfbk0ZiHI
	ZclUiA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c79cy189u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:43:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 619BhUJp028440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Feb 2026 11:43:30 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 03:43:26 -0800
Message-ID: <153241e9-f71a-970c-c929-53b195807259@quicinc.com>
Date: Mon, 9 Feb 2026 17:13:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/7] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>
References: <20260206100202.413834-1-quic_mdalam@quicinc.com>
 <20260206100202.413834-2-quic_mdalam@quicinc.com>
 <409c2e5f-1bf2-44ed-9c0f-df762320e068@kernel.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <409c2e5f-1bf2-44ed-9c0f-df762320e068@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vmj_vTRwTRGYo0Xwcvl_imDbpdggcCFV
X-Proofpoint-GUID: Vmj_vTRwTRGYo0Xwcvl_imDbpdggcCFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA5OCBTYWx0ZWRfXxXJAZtBl3aUX
 NdcW+BNVO8HQfE72vA1fuQEXbYLYCbuJm/KopCSJUyAka9thgo6YlUJDr6RxmUEPxqki0SqGqCO
 W7k7YiTzShTH7V8oQTFvjITAXOX748+19RE2j0SDw/PLB/pmrMLZNLcy2sdtw3C76LYlHCSZs2S
 ObTwSPoO1NT0SFiTTWHaU6N642xgfFvh4nTy0L+w9nImW/NcBJW68qnsNbT5lgN8+/3zDtpKVL0
 ELW6C5l8CqH6Dj5LI9le8svVuc1ocw0yFwaJNVMW8IB+KGZphhuHDQF4n5Gj1TKxMSG1/gbUFHJ
 4Pn23UAS/s6mOxewxn1IlgAZwa+b716J9fhkBkL053GKe+/i6Csr9ImpTBxL6qUpgTceyxC/HMz
 LXESBL/+Vyar9HZ9ABnnqapgv7ii0EBp3qJIcZy5ovvZHh7EEsvN3JxFqYNCEJFsymSaMqg/Zdf
 JOcMlDM+0nBxj5Vv8yQ==
X-Authority-Analysis: v=2.4 cv=EtvfbCcA c=1 sm=1 tr=0 ts=6989c863 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=P-IC7800AAAA:8 a=RW8aISsyu9ixVNnXDUoA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:mid,quicinc.com:dkim,bootlin.com:url];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quic_mdalam@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8836-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[quicinc.com:+]
X-Rspamd-Queue-Id: 9FF9B10F504
X-Rspamd-Action: no action

Hi,

On 2/6/2026 10:42 PM, Krzysztof Kozlowski wrote:
> On 06/02/2026 11:01, Md Sadre Alam wrote:
>> BAM version 1.6.0 and later changed the behavior of the mask field in
>> command elements for read operations. In newer BAM versions, the mask
>> field for read commands contains the upper 4 bits of the destination
>> address to support 36-bit addressing, while for write commands it
>> continues to function as a traditional write mask.
>>
>> This change causes NAND enumeration failures on platforms like IPQ5424
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
Ok
> 
>> that use BAM v1.6.0+, because the current code sets mask=0xffffffff
>> for all commands. For read commands on newer BAM versions, this results
>> in the hardware interpreting the destination address as 0xf_xxxxxxxx
>> (invalid high memory) instead of the intended 0x0_xxxxxxxx address.
>>
>> Fixed this issue by:
>> 1. Updating the bam_cmd_element structure documentation to reflect the
>>     dual purpose of the mask field
>> 2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
>>     command type:
>>     - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
>>     - For write commands: mask = 0xffffffff (traditional write mask)
>> 3. Maintaining backward compatibility with older BAM versions
>>
>> This fix enables proper NAND functionality on IPQ5424 and other platforms
>> using BAM v1.6.0+ while preserving compatibility with existing systems.
> 
> Fixes tag? CC-stable?

This patch is not fixing an existing commit. This is to address the 
update in the newer version of the hardware.

> 
> Why is this part of DTS patchset? Do not combine independent work, you
> only make it difficult for maintainers to handle your work.

Will post a new version with the driver change as a separate patch.

Thanks
Alam

