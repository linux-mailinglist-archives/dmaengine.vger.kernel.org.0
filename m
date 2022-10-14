Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8A5FF734
	for <lists+dmaengine@lfdr.de>; Sat, 15 Oct 2022 01:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJNX5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Oct 2022 19:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJNX5E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Oct 2022 19:57:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3C9A9E0;
        Fri, 14 Oct 2022 16:57:03 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EIEBCB010260;
        Fri, 14 Oct 2022 23:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YDEfTLXOJppjFZ0Y2gGdqkY+0fCvg0JR4TTDdIGHpk4=;
 b=pGFJYukJnsD5VE/a9Q+VoyEKwtQch4MXvfA92FUKKsXxPl6fY3KZwHDB5W/NqTaXXHGR
 rmHwN+OjCQZ5SuM6Us2dllz+YJyBiPC6A09lpmmuouFSvcc/FR3wst+lngAcRzEWt2I/
 GLPlgMTd+17lhAjBG6wBTQkpxbji0FypFJqv/UogmU2ldk65iJryJl4U+ST+4lYvihRk
 We1/mkoueLGV6YU5fyjJDc8SbNjJaMUlZiAuaRmt8pDRWX3E+KL6dfqzvT8RB7h/FsXp
 8EtwPdvO35e/GwXWTvdoy2X29EOkQ40H+oCh1R9qD1K3+/FpMs70Z/rSMeGsGhMs0Cba vw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k73h6kk34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:57:00 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ENuxj5022933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:56:59 GMT
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:56:59 -0700
Message-ID: <41db98ac-6a90-fa26-2575-6009729537ba@quicinc.com>
Date:   Fri, 14 Oct 2022 16:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] Add dma gpi support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221102.7445-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221102.7445-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LcOzUTZJL-7NZYLq4WKNsUBXF5H7whOy
X-Proofpoint-GUID: LcOzUTZJL-7NZYLq4WKNsUBXF5H7whOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=751
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140132
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/14/2022 3:11 PM, Melody Olvera wrote:
> This series adds the dt bindings and driver support for dma gpi driver
> on the QDU1000 and QRU1000 SoCs.
>
> This patchset is based off of patches found at [1].
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
>
> [1] https://lore.kernel.org/all/20220927014846.32892-1-mailingradian@gmail.com/
Changes from v1:
- fixed ordering
- rebased on top of [1]
>
> Melody Olvera (2):
>   dt-bindings: dmaengine: qcom: gpi: Add compatible for QDU1000 and
>     QRU1000
>   dmaengine: qcom: gpi: Add compatible for QDU1000 and QRU1000
>
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  drivers/dma/qcom/gpi.c                              | 2 ++
>  2 files changed, 4 insertions(+)
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d
> prerequisite-patch-id: 3fbdc40584bde724063f88038e6e5178413fa9ce
> prerequisite-patch-id: 7df51dc9dfa16d11f910c5142513ca7e43e5c4d4
> prerequisite-patch-id: cb57181838cf718e80f2e07b290ffaf67b5acbc9
> prerequisite-patch-id: efc95efd7a81f8bc65dc188f5d7c75769340dbe7

