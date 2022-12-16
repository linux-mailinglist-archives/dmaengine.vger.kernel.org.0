Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB664EB3F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLPMPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 07:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLPMPq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 07:15:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EEFD1F;
        Fri, 16 Dec 2022 04:15:45 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG9phJc021843;
        Fri, 16 Dec 2022 12:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KkeWDQxWZ2/R/fyTtI0H/FFTlptZnIxvDrsLlZi7jnI=;
 b=E8T4PSzz2JV+S+xUVMYKh19sczdZ85/+Kieh+lxs54USSQh7oGeBCFchHQaXNjnTI7Yx
 JoQ57ODNKaaBwzdT5f3TEKcdOt2eW0m2Hf94oXEd3yMysoFoWzf40LTjimxDATmUHD/m
 9ZiBlusrAdYm15ztePx6J77Bjq0PE+Q9a83+69rlnzHiQN5rnuI3uuGRLdC3wPDh8cul
 rU54t5M2G7EbAft5yQW0xdHLTC+czFCVLWitAgjPZBSdIhPaceVWD7IohBZOut/iEYe9
 CfpEtdHSKmu7Z2b6dNVKyDRqG3RU9K0A780q0yQeWTD+EOpfm2dHRjI3ntN2qz5RZC/D Cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mgpdb0bx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 12:15:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BGCFedg014441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 12:15:40 GMT
Received: from [10.216.35.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 04:15:36 -0800
Message-ID: <82ec225f-64e2-40a1-aa3e-58480f293d17@quicinc.com>
Date:   Fri, 16 Dec 2022 17:45:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx
 operation
Content-Language: en-CA
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wh1VzmLR3I-iTzU6VL6OjGHFWZ7OmXIY
X-Proofpoint-ORIG-GUID: wh1VzmLR3I-iTzU6VL6OjGHFWZ7OmXIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_07,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Gentle reminder to review/approve please.

Thank you...


On 11/30/2022 5:50 PM, Vijaya Krishna Nivarthi wrote:
> As per GSI spec, link_rx bit is to be set on GO TRE on tx
> channel whenever there is going to be a DMA TRE on rx
> channel. This is currently set for duplex operation only.
>
> Set the bit for rx operation as well.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>   drivers/dma/qcom/gpi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 061add8..59a36cb 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1756,6 +1756,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>   		tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
>   		if (spi->cmd == SPI_RX) {
>   			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
>   		} else if (spi->cmd == SPI_TX) {
>   			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
>   		} else { /* SPI_DUPLEX */
