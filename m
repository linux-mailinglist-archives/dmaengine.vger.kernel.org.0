Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040DB604E37
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJSRJM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiJSRJE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 13:09:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408E1CF55B;
        Wed, 19 Oct 2022 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666199335; x=1697735335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XMpHfi/Dvwo8JftuvXLvZW5yVLuSuEHPJySZS0XUGZs=;
  b=SYxV4k15/fpgg+X0F/MkSmRXHetiNdL1nRmBPFvNiLTCyNgmz8KW849c
   JIDiA5BYSdFkl7ZAUmcHNOh/we1SC99365YgXok/JkqTESiUhDmHkD/+H
   mcwsLZSc7sWNcjIGSxPNr0LLeWqFPc0D0q0stqJeRjtaSaoilV2foJ1sf
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Oct 2022 10:08:17 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:08:17 -0700
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 10:08:17 -0700
Message-ID: <a4db0335-33d8-76cd-6f89-b8bde603aedf@quicinc.com>
Date:   Wed, 19 Oct 2022 10:08:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000
 and QRU1000
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221102.7445-1-quic_molvera@quicinc.com>
 <20221014221102.7445-3-quic_molvera@quicinc.com>
 <15b50b09-ba8c-c93c-a5f8-7b0d4d12f223@linaro.org> <Y0/75E7MqCpQml+I@matsya>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <Y0/75E7MqCpQml+I@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/19/2022 6:30 AM, Vinod Koul wrote:
> On 15-10-22, 09:42, Krzysztof Kozlowski wrote:
>> On 14/10/2022 18:11, Melody Olvera wrote:
>>> Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  drivers/dma/qcom/gpi.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index cc938a31dc2d..02438735e92b 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>>> @@ -2286,6 +2286,8 @@ static int gpi_probe(struct platform_device *pdev)
>>>  }
>>>  
>>>  static const struct of_device_id gpi_of_match[] = {
>>> +	{ .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
>>> +	{ .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },
>> The feedback was: drop entire patch.
>>
>> There is really no need for this pattern to keep growing.
> Right, I have picked the patches so you dont need to add yours to driver
> file, please check dmaengine/next
>
Yes, I think I understand now; I'll just use existing compatibles and drop this PS.

Thanks,
Melody
