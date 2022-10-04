Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703385F4A15
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJDUFO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 16:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJDUFN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 16:05:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFA18381;
        Tue,  4 Oct 2022 13:05:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294Ie0Yi030247;
        Tue, 4 Oct 2022 20:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qfssT5YpFgOMBOnB5Y0BUHkDogTACkdGhU+3SYCdOyQ=;
 b=cr9gNp70L7jtzrbv/j2cMRDffhZAHaY2s1tCSvueypq1eIlpdH9YUES75R4JzTq+Hamy
 Agyb7+1heePYVR8qvjz/wtJEIOYtT/0n/yXOFQcawaSAWuk3UWhKuG05ty48/jb0mULi
 4QzNy1vJQxMQ+FJv6RgGbjEHIZ2l/7uDfdr6+ZR6TmEduTFvibwr1MsDWDLaoKqRK/13
 vNGoTsgY0jZjYX7qgTcCA2kmXptwfc0wg/KPRGE3WjdKlHBk1OqERFK9b6/H1o2SOpZ4
 eVm/N85e4TxtrnEww2Z3EobNmsLvMQyTIC9fM9rA2kQ6M7vFycSBarVsojSe2lzpSBse Yg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escsr5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:05:08 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K57IP027171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:05:07 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:05:06 -0700
Message-ID: <0feeb2ae-a332-d645-28b0-e16890b286e1@quicinc.com>
Date:   Tue, 4 Oct 2022 15:05:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000 and
 QRU1000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030627.29147-1-quic_molvera@quicinc.com>
 <20221001030627.29147-3-quic_molvera@quicinc.com>
 <CAA8EJppLd6dti=gbR0hbEAQyj5PHA7xWR3w+DESx1qcKcyf3YA@mail.gmail.com>
 <55b209c4-4fbb-8b09-a5cc-385ff3e5b771@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <55b209c4-4fbb-8b09-a5cc-385ff3e5b771@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WtdxoqD4oSzA0lLjW-z-zldANM1x-bCF
X-Proofpoint-ORIG-GUID: WtdxoqD4oSzA0lLjW-z-zldANM1x-bCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040131
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/1/2022 4:30 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 09:14, Dmitry Baryshkov wrote:
>> On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>> Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  drivers/dma/qcom/gpi.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index 8f0c9c4e2efd..94f92317979c 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>>> @@ -2292,6 +2292,8 @@ static const struct of_device_id gpi_of_match[] = {
>>>         { .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>>>         { .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
>>>         { .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
>>> +       { .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
>>> +       { .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },
>> As usual
Will address ordering.
> I would say - drop entire patch and rebase patchset on:
>
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=680815&state=*
Sure thing; will rebase.
>
> Best regards,
> Krzysztof
Thanks,
Melody

