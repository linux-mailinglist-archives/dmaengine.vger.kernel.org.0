Return-Path: <dmaengine+bounces-4089-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC98EA05969
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5A1165C7A
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4A1F76C3;
	Wed,  8 Jan 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SFpkHwhb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601551F4715;
	Wed,  8 Jan 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334871; cv=none; b=Lvs+FM+/Z2e5QkNP25/+3EmjfJnDZcW4/7z2HDmZsz9C3t8qSAZIo+gKH6fJ+R5JzO3n4SkiCOsYaJ0zGyxsoNtSjyu3dOkW9pXKbX3813+qrs+UsyGGjgk2trxGrrkcVK8W3dU/J1QApBKczKt7EWmXV7HTz/MG8XfagiVpdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334871; c=relaxed/simple;
	bh=LwcXXq7kRXgSFJ0vtLdMRahKm7UjYXZz4PWaPF33DzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=la1AtBil4bdOYNRkD/0UNSlLeHVua2QRM/m1GizLFxlCBmysmL2D6AfQzeBawRmcaXAzAadjp/mpckoQ5wJ9YX/XJotepIn9b7MDRqiDkIBQI5xXksI3rtIKvrZU73dL5luzMM8E+pGw6Wo6a3k5LCwpd940SokFWPKxp+bteJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SFpkHwhb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Ad3WR012254;
	Wed, 8 Jan 2025 11:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/92TmYXRo9o0iUDpS98UMAUS/n/j2ssMtWzzK2anB94=; b=SFpkHwhbPX6WLvgs
	nMuQR9ftYbCShZExgqji7Ea22Js8j5ZimvZsuDCED91/olCPjQkuh0iKTEFXvwHa
	6bKLubhTiePl0jAeAD+uPY0AuJNzXQax3cDaTFe6btSxCkm6/jn8ZPP15D3vRUKH
	bfs7hwsq73HNe9AxvC9dU9aZ0Sss9k1GXj9Y64CsAeXM9EN9YplGONwi2mifcDWl
	AeOvQNGyUm/eS3IdIBvG5bl5I53b2OXWxwnWd0iV7Qd6B8sSH/4xxpW6ZUrzCh4R
	NfSH8w9ms/XOlhTADF8+0pqI3Wi6syduPpgC/IQ6a+/aAX9LpWPiiWtMBxC4a1lp
	PShtOw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441phg8aye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 11:14:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508BEJnt022934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 11:14:19 GMT
Received: from [10.151.36.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 03:14:15 -0800
Message-ID: <a493963e-e044-646e-d973-47a6101a8c59@quicinc.com>
Date: Wed, 8 Jan 2025 16:44:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] dmaengine: qcom: bam_dma: Avoid writing unavailable
 register
To: Georgi Djakov <djakov@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>
CC: <quic_mmanikan@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <robin.murphy@arm.com>,
        <u.kleine-koenig@baylibre.com>, <martin.petersen@oracle.com>,
        <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20241220094203.3510335-1-quic_mdalam@quicinc.com>
 <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <9ef3daa8-cdb1-49f2-8d19-a72d6210ff3a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3lMZeEr7ENshsjDis5iZ5NgQmoE6Q8l4
X-Proofpoint-ORIG-GUID: 3lMZeEr7ENshsjDis5iZ5NgQmoE6Q8l4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501080091



On 1/8/2025 3:00 AM, Georgi Djakov wrote:
> On 20.12.24 11:42, Md Sadre Alam wrote:
>> Avoid writing unavailable register in BAM-Lite mode.
>> BAM_DESC_CNT_TRSHLD register is unavailable in BAM-Lite
>> mode. Its only available in BAM-NDP mode. So only write
>> this register for clients who is using BAM-NDP.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
> 
> My Dragonboard db845c fails to boot on recent linux-next releases and
> git bisect points to this patch. It boots again when it's reverted.
> 
> [..]
> 
>>       bchan->reconfigure = 0;
>> @@ -1192,10 +1199,11 @@ static int bam_init(struct bam_device *bdev)
>>       u32 val;
>>       /* read revision and configuration information */
>> -    if (!bdev->num_ees) {
>> -        val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +    val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
>> +    if (!bdev->num_ees)
>>           bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
>> -    }
>> +
>> +    bdev->bam_revision = val & REVISION_MASK;
> 
> The problem seems to occur when we try to read the revision for the
> slimbus bam instance at 0x17184000 (which has "qcom,num-ees = <2>;").
I am checking this will fix and post the patch asap.

Thanks,
Alam.

