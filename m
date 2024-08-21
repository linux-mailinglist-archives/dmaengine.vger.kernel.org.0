Return-Path: <dmaengine+bounces-2926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601219593F3
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 07:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CAF1F22E4C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2024 05:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9A1607BB;
	Wed, 21 Aug 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pmU9hxl5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6F1537D1;
	Wed, 21 Aug 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217407; cv=none; b=JGNwoFLE8DQjGSr8ulfArUv/VbuolUZ796WvhXbn3H/is1h4AkWEEhK8A2lXsJT4qekGYDLh4LTR0mSek9va+UWJpCr8Fo2j1in77dz7KZq7vpRjKyL7zcHUCBPbcfAdGBnsPTHLL2n6bUvqxH5gSgF8rf2HJNjGIdkPfMYMwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217407; c=relaxed/simple;
	bh=ZZXp028kuznJ40MHUeSJt4Qcm9NAbrJnKp1wijan5lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cRMid9wv7qiyODG9enoEPb9aQwMf0N/LmdFDNODQeD8ckpRNOOq5BFucZerBoC8S3gNCYi8nABUSSXY1xOrxGqKBcBudQjXkZR4jH985HdiHPYagqUDqOm/lknbn0x539BjHPcw0qXfCCjN0Ss/+9XYCMHX/kTNETYZZmCKiNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pmU9hxl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5AQT6022670;
	Wed, 21 Aug 2024 05:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1mpMc7tEgd9LCX6iqpPcU8hX1X+O3hBWQ6RVnA+nEWs=; b=pmU9hxl5TNCPmcZH
	Kn6SLir45a5KfH9MgsdaLZ9Riy3H4tmvq36bV8eWnIwdkSlGvBjFakLT1crmXYfs
	LKhvZRUmKIQSVbPeQoUknqY8fJlQuxhf7DEMwvGPtPLMmlZ6sOR5ppUtKiYiQfV0
	3uOdLAyyrynCz3oy+iGL5SI+vSYnPE4fw0rUQBDPixQbCruc8UVnpObLmNlMAvgW
	rzxfbsoDsju76kXp+gxxNYE3uJWPPAE7kQxAwgrrPFnsgg9LFA1HuXASkNGba3Mc
	9qShuDfqP88ICXlROhjIQBTWwrqz750JB7dafsyw6sv3UpJi81CnJfSZ8Yb7vUT/
	q777/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmb1bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:16:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L5GYBf026977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 05:16:34 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 22:16:27 -0700
Message-ID: <ef8b3a3d-5791-f5c5-4362-7e2f87d726d0@quicinc.com>
Date: Wed, 21 Aug 2024 10:46:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 14/16] arm64: dts: qcom: ipq9574: enable bam pipe
 locking/unlocking
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <gustavoars@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <kees@kernel.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-15-quic_mdalam@quicinc.com>
 <lr53irikxjjoiks2utckyt5bsflxm52r2nlospkv3id6qwkfih@pycrjkeibx4g>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <lr53irikxjjoiks2utckyt5bsflxm52r2nlospkv3id6qwkfih@pycrjkeibx4g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KN-cptjYjujvWk4URMmF6hvTYq_beEY-
X-Proofpoint-ORIG-GUID: KN-cptjYjujvWk4URMmF6hvTYq_beEY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_05,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210036



On 8/16/2024 10:10 PM, Bjorn Andersson wrote:
> On Thu, Aug 15, 2024 at 02:27:23PM GMT, Md Sadre Alam wrote:
>> enable bam pipe locking/unlocking for ipq9507 SoC.
> 
> Note that the commit messages for the other non-dts commits will not
> show up in the git history for this file. So, please follow
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> and give some indication of "problem description", to give future
> readers an idea why this is here.
   Ok
> 
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>
>> Change in [v2]
>>
>> * enabled locking/unlocking support for ipq9574
>>
>> Change in [v1]
>>
>> * This patch was not included in [v1]
>>
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 48dfafea46a7..dacaec62ec39 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -262,6 +262,7 @@ cryptobam: dma-controller@704000 {
>>   			#dma-cells = <1>;
>>   			qcom,ee = <1>;
>>   			qcom,controlled-remotely;
>> +			qcom,bam_pipe_lock;
> 
> Per the question before about what does this actually lock. Is this a
> property of the BAM controller, or the crypto channel?
   This is the property of BAM controller.
> 
> Regards,
> Bjorn
> 
>>   		};
>>   
>>   		crypto: crypto@73a000 {
>> -- 
>> 2.34.1
>>

