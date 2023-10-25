Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2B7D6407
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjJYHvD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjJYHvA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 03:51:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC89D43
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:50:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40806e4106dso3052335e9.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698220256; x=1698825056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHCbt3oIyBZTNzG0a6SA3gqBM3qic8b1PW/OzYT0hTY=;
        b=yG8oqy0jJsqkMHIHnQ5LVSHcF2PXJvrJ1rX41nQ8q/vRrXDy+7EUGGB2z9GVQpXtcX
         zeFSo9SHCZazLALnxrghDqJ0RLW1c4dT69fGDgNdVR9ctJzz50qFau5ZJ38yLYfdzeBw
         WNyF6Zi2Lq1g7MM+fhfujMDkpjnNb5Z9ojd8v2TzaJtXrA3UaZ/Mva6NOUGZdYgTPp5V
         vrJ0ZIK9jGPC3vNIovvCxh8GRcnt4vfuqIS+up7EPdlYU/KHnMs0/LbcerZt+KvvUPGN
         gIyaUISHvpNU1ru9dN7nF7/JN9eWw/xPRcvuYAzIEOlRPJBorH6T/0YhG0RS0r3UdsAj
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220256; x=1698825056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fHCbt3oIyBZTNzG0a6SA3gqBM3qic8b1PW/OzYT0hTY=;
        b=tEqxqDOn+It2Uf+ZP/szp5mEaEqrnsD2kApPrnleQ0tlp/EHAKnuSlGvL1WGg7Vlu8
         aJEL6Pq2q0ryt6cQQV9Nej/5lEr9dRfogqcyt8x3JehdpLjIWjEUr+oAQujKEPPS889p
         Aw1DXBkslOqoIrrlBC3oW+OrfO23r9/Pu9/YOKwvbnLDP1I3PoCkAOoi57T7QqW/OmKS
         KlDMJ+VHfnb27ZiRNPR+25ngYLot7DoDiz3hriPuJpKcz38SjYnKC4SAKObI+E/wW6Mw
         PxBBgi5xGA0vGrxIyN6kEYrwvMc5aiB3vazd7OLu8nmHgSD4hodNUa3DXdY6240tWtHp
         3Mfg==
X-Gm-Message-State: AOJu0YxmAFjzGyeU0atDXiKeL9shRXt2QPyK8cUTlcTbeUtR4/sFOPWn
        IyKMKRMPNU0ZrUAkruWOX+kOAA==
X-Google-Smtp-Source: AGHT+IHkFgkIyncR5qpiPGCBrd1mZZZPQhI0m/zUCrlGiixh6mKna/bq06QxEiecV1w1LIBTsixxow==
X-Received: by 2002:a7b:c4d8:0:b0:408:36bb:5b0c with SMTP id g24-20020a7bc4d8000000b0040836bb5b0cmr16035281wmk.7.1698220255693;
        Wed, 25 Oct 2023 00:50:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4b03:ec74:6374:5430? ([2a01:e0a:982:cbb0:4b03:ec74:6374:5430])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b0032dcb08bf94sm11538347wrx.60.2023.10.25.00.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:50:55 -0700 (PDT)
Message-ID: <22441cdc-33d3-4303-9deb-cb91e43594e6@linaro.org>
Date:   Wed, 25 Oct 2023 09:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: document the SM8560 GPI DMA
 Engine
Content-Language: en-US, fr
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-bindings-gpi-v1-1-3e8824ae480c@linaro.org>
 <CWHCDVXDDU74.3U8VFCO1HHIDU@fairphone.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <CWHCDVXDDU74.3U8VFCO1HHIDU@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 25/10/2023 09:29, Luca Weiss wrote:
> On Wed Oct 25, 2023 at 9:25 AM CEST, Neil Armstrong wrote:
>> Document the GPI DMA Engine on the SM8650 Platform.
> 
> Hi Neil,
> 
> The subject of this patch and a few others refer to 8560 instead of
> 8650. Please fix :)
> 
> * dt-bindings: dma: qcom,gpi: document the SM8560 GPI DMA Engine
> * dt-bindings: usb: qcom,dwc3: document the SM8560 SuperSpeed DWC3 USB controller
> * dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Subsystem side channel

Thanks for noticing :-)

I'll wait some time before sending v2, a burst of patches is enough for a day !

Neil

> 
> Regards
> Luca
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> For convenience, a regularly refreshed linux-next based git tree containing
>> all the SM8650 related work is available at:
>> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
>> ---
>>   Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> index 88d0de3d1b46..0985b039e6d5 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>> @@ -32,6 +32,7 @@ properties:
>>                 - qcom,sm8350-gpi-dma
>>                 - qcom,sm8450-gpi-dma
>>                 - qcom,sm8550-gpi-dma
>> +              - qcom,sm8650-gpi-dma
>>             - const: qcom,sm6350-gpi-dma
>>         - items:
>>             - enum:
>>
>> ---
>> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
>> change-id: 20231016-topic-sm8650-upstream-bindings-gpi-29a256168e2f
>>
>> Best regards,
> 

