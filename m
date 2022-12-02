Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D864640C35
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiLBRek (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 12:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiLBRej (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 12:34:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E78D8277;
        Fri,  2 Dec 2022 09:34:39 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2BYCBr031334;
        Fri, 2 Dec 2022 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uPpeLZnCmiiguyjw3n2BVo8PQFIA2jH3VPEQBkarXRs=;
 b=lXxrhQJ0W+4mFO/6hlcE4Tuwb1igRDr0S/RVQ2p6L0DU4tGPdkUlAKKuoK1wYnGhgUgj
 XVxefxt+0stHsRq8yq1MOt1paLv7/lqDo7OJw7eDocOKlbD69j8S7iD0E7/SRjKPYaeK
 D3TWUFhuaCY4+fcPoGeZxWwokO7XFwXEYyd599d+w+lqwbXX50COvM2Lb6Xmh5u2Jazl
 mH2X6hKcBtXixSKfU159aXlnKW7PxX72LqZmV4Et7Q9JqkVH8o6P+otOTaCtMYycg/kI
 rYBkw59SIWJhTSf8PgXq7yDhFY104x0ZTuie17vx026Lqb5j7WKXDvXGd/I0vx5pfrgx bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7b82tadx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 17:34:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2HYSHi004067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 17:34:28 GMT
Received: from [10.216.34.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 09:34:23 -0800
Message-ID: <d9b8d297-4c6e-8871-782f-bd50c1443464@quicinc.com>
Date:   Fri, 2 Dec 2022 23:03:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx
 operation
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1669810824-32094-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VWJvBU=uAPpyegxYz-k2sx=jBgiNm=qrso3cb3FXtqjw@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=VWJvBU=uAPpyegxYz-k2sx=jBgiNm=qrso3cb3FXtqjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9-yzK5XefpmzQV0ydtmyc2NqzJXo3Xze
X-Proofpoint-GUID: 9-yzK5XefpmzQV0ydtmyc2NqzJXo3Xze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020139
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 12/2/2022 4:17 AM, Doug Anderson wrote:
> Hi,
>
> On Wed, Nov 30, 2022 at 4:20 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> As per GSI spec, link_rx bit is to be set on GO TRE on tx
>> channel whenever there is going to be a DMA TRE on rx
>> channel. This is currently set for duplex operation only.
>>
>> Set the bit for rx operation as well.
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   drivers/dma/qcom/gpi.c | 1 +
>>   1 file changed, 1 insertion(+)
> I don't feel qualified to actually give this a review since I don't
> know anything about the details of GSI/GPI. It seems simple enough so
> I'll just assume that Bjorn will land it. Ideally someone else at
> Qualcomm would give you a Reviewed-by tag.
>
> One drive-by comment, though, is that I would say that your patch
> description lacks an answer to the question: "So what?"
>
> In other words, what is broken today? Does everything work fine today
> but some bit counter looked over your shoulder and told you that you
> were a bad person for not setting that bit? Did the lunar lander catch
> fire (despite the lack of Oxygen on the moon!) because it started
> using the RX transfer mode to talk to its fuel valve system and the RX
> transfer mode never worked? ...or maybe everything today works but the
> super secret Qualcomm SDM9002 (shhhh!) chip needs this bit set? Help
> people looking at your patch be able to decide if it's important for
> them to pick to their kernel tree! :-)

:-) Thank you very much for the input. Will keep that in mind for next.


Some info...

rx is actually broken for spi gsi. A plain rx operation would crash 
right now and patch for same would come next; There are 3 further 
patches as well for gsi.

I started with simplest patch hoping it would get in quick.

While trying to bring up EC use case with spi gsi, we made some changes 
to conform to GSI spec, made some progress but still couldn't get it to 
work.

In the meantime we switched to SE DMA as interim.

> -Doug
