Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7B5F4A0E
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJDUDr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 16:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJDUDq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 16:03:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5191EAF0;
        Tue,  4 Oct 2022 13:03:46 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JQIJq004487;
        Tue, 4 Oct 2022 20:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+4Un6+7BE9002G3mRa+XIvmJ2Jfd03kLNtGuUWJoSp4=;
 b=mtM1H8FNwWxVpm5pnuhs/FIMtx5rt+o4cXeDFt3H5QwIKN30nXRe85FLfyNU/6+BcsCm
 Z1KnhvdNYfRWnOCWRIY6U/qM2Ei1sakuSq+mp0/fkZWE+ew46j/5z0vu/JywaXmiaH8F
 jhRLIOeOaQHS2PmiuEX2WDI0idd/ed98W9sr1Mj5gh0xQi236gmooIT39xREpFwg2HMA
 88ueutcVCz07yHwNo/HyaaJCf7y2WqwS/Q0GoquZIqj6Ek3/1bgyBttJnvjGmJU+e9R7
 DeB4FAIMFVcxQoYhW8W7a18UIZq5ir2FwZsPUOAfhthZ/99XikrP5G3CwRDgHXD4lOx7 Vg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0hxpse2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:03:43 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K3gpb012508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:03:42 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:03:41 -0700
Message-ID: <486ac802-f7b9-7a06-bc10-f068bf29c773@quicinc.com>
Date:   Tue, 4 Oct 2022 15:03:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: qcom: gpi: Add compatible for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030627.29147-1-quic_molvera@quicinc.com>
 <20221001030627.29147-2-quic_molvera@quicinc.com>
 <CAA8EJpo5x4Wva4thoryvh3_jf9WssbRN=94fNq8Xwvph75G_iQ@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpo5x4Wva4thoryvh3_jf9WssbRN=94fNq8Xwvph75G_iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: edKf2_AIPHgiCMEh-d-xfe6PZa3n53j8
X-Proofpoint-ORIG-GUID: edKf2_AIPHgiCMEh-d-xfe6PZa3n53j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=861 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040130
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/1/2022 2:13 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add compatible documentation for Qualcomm QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> index 7d2fc4eb5530..e37cee079c78 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> @@ -25,6 +25,8 @@ properties:
>>        - qcom,sm8250-gpi-dma
>>        - qcom,sm8350-gpi-dma
>>        - qcom,sm8450-gpi-dma
>> +      - qcom,qdu1000-gpi-dma
>> +      - qcom,qru1000-gpi-dma
> You know my comment, qdu/qru comes before sm/sc
Got it.
>>    reg:
>>      maxItems: 1
>> --
>> 2.37.3
>>
Thanks,
Melody

