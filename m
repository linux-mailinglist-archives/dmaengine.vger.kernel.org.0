Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153946241C6
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKJLyu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 06:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJLyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 06:54:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F15D6BA;
        Thu, 10 Nov 2022 03:54:46 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AAAtpTw010867;
        Thu, 10 Nov 2022 11:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=woRjAHpd4XAqnUkDVIfDaJmmBYAKKMYj4mzOsmIQnSc=;
 b=naYgI37uxAWOur6q9ajwqpb8O2hK+dhoGiDbwMB2nL83R4CHVvraDxOC5/dHt/+N7ncN
 jH2QoL+DlruOw7Xhfu9u/DpnbX2w4Ua/rAm5/5RBLp1QwOJHUksV/zUCQjngLAmwf9lQ
 fRh9yRWiKUnz/OrDw5OJXGWOM0ZfjXcAD1Gbf5SFb55fI0GFpCDGl5ZvOz1wp0QOV8kX
 Rkc9EGEPO6UN2YuEhpLHmWFpqQdJiwfoe0iJqCocSVB4xHCL4pisY2FFE35ToxJRFSFd
 KgbFiyOR+uzk6fS5BcNPzrheSiPlfZI2vH8reTT8avsN54P7xeLR0jqUW9hHEeOv4bT2 hQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krw8g0fp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:54:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AABsYoZ011802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 11:54:34 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 10 Nov
 2022 03:54:31 -0800
Message-ID: <102b69e4-7b1b-23ef-c4f3-a91598546c97@quicinc.com>
Date:   Thu, 10 Nov 2022 17:24:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] dmaengine: use devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     <ye.xingchen@zte.com.cn>, <vkoul@kernel.org>
CC:     <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <dmaengine@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <202211101726100208529@zte.com.cn>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <202211101726100208529@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qvlJFr4RzMseXCU8x6xHEzQQzDv7LZ4x
X-Proofpoint-ORIG-GUID: qvlJFr4RzMseXCU8x6xHEzQQzDv7LZ4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_08,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 mlxlogscore=808 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 11/10/2022 2:56 PM, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>   drivers/dma/bcm2835-dma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 630dfbb01a40..1547f528a58e 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -902,8 +902,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
> 
>   	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
> 

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>


-Mukesh
