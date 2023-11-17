Return-Path: <dmaengine+bounces-146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC47EF5CE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 17:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E7B20C59
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101834541;
	Fri, 17 Nov 2023 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jOyDALbl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB1E1;
	Fri, 17 Nov 2023 08:02:53 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHCv0fl014041;
	Fri, 17 Nov 2023 16:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x0M3wklGqflq1G+DQ/EFE56suGOIsWSY/I+nLdmUqqo=;
 b=jOyDALbl6JXQ7g5iwKBUMsdapWtX53GmIZx696gE3wnpWDE+yfLmrmQJsa6YFpeacj2w
 /arnCpHAh3lfTZXYHVIOBEzRtnvcUOhPC8aMVS3570iAw0uZCz4ydTmsBrAOSM++YUHh
 ykEstO0jTkVHXOy2DWnFkPGXIVY+wRtw/Dr+ClnN69KqF1+bn7+gJtb5aeuP/ciWRPJJ
 3lqCi5RkM0pbJEXLDGEY+pyUGkOuSxooyDf2skpEvaJX4hEsxK9A5Lu6loQCSHSkpqWV
 RdSoLBPS6Oom3kMD3I6UarqS/X6589JPeOylR2gu77cj5rnJkxJppJiyhhdYnRHvHVyk jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udkkuu75v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 16:02:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHG2OZg001517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 16:02:24 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 17 Nov
 2023 08:02:17 -0800
Message-ID: <045261f7-ec6d-7c90-bdbe-3cd1a58143b7@quicinc.com>
Date: Fri, 17 Nov 2023 21:32:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/4] dt-bindings: interrupt-controller: qcom,pdc:
 document pdc on X1E80100
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC: <agross@kernel.org>, <vkoul@kernel.org>, <quic_gurus@quicinc.com>,
        <conor+dt@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <iommu@lists.linux.dev>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231117105635.343-1-quic_sibis@quicinc.com>
 <20231117105635.343-5-quic_sibis@quicinc.com>
 <67e7df38-d0a9-4513-9eb8-1114a9ecc3b3@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <67e7df38-d0a9-4513-9eb8-1114a9ecc3b3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YYKJT12kYHoQtWKXUVMdTT2tt_zrJJyC
X-Proofpoint-ORIG-GUID: YYKJT12kYHoQtWKXUVMdTT2tt_zrJJyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_14,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=498 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170119

On 11/17/23 18:37, Krzysztof Kozlowski wrote:
> On 17/11/2023 11:56, Sibi Sankar wrote:
>> The X1E80100 SoC includes a PDC, document it.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> Please rebase on next.

This series was based on lnext-20231117.

-Sibi

> 
> Best regards,
> Krzysztof
> 

