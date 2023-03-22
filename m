Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117386C49D6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 13:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCVMBD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCVMAt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 08:00:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938555F6F6
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 05:00:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so10651118wrv.1
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679486438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpYhPbFNmhWZbxQ+2pcfKt9iFKv1OlqjHaycSTExZk4=;
        b=T3+P58p7TtpSXyY3ZycUB/vhlz41Yj1CfMNVjOWonYKasqKMq9b8QMuOhuwGy7DcwD
         Bwu9VRMcvxYt+2Er3PEVwKUkveKla8rLhghJRYHGb9eWLMvfoGmiXlB77k8RLeHq4HzH
         4jIVTb4eQOIBz83B0X/g4N4kb0RRmDvN3+gqfS3Ybtpst74o4BdX1ncTx0aspd4FlfGT
         AlgkXYY1OLI6r8WRDofTgbINQ1YR4RC+fdNWji1n2LSPaR51/ZOCOJX9eUEBEZJ7M9dS
         c7oIDNYzGJAvpPuhIvdoKwDc+kyi1eaFNkNJyBpw0Rmo09B+N5wIyyFOUUUZ81r0NCI5
         5puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679486438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpYhPbFNmhWZbxQ+2pcfKt9iFKv1OlqjHaycSTExZk4=;
        b=STuNUoIHG/6FFvzNrOqoOVw6PfGfLGmnBm+SPG7ct/PhlXZ4WRRpWxqENXDr7PB3TX
         D52zEKCWBCmO6naFhOmhVdrrJV6vhqoJWNW6bmU6oRKUmcAs5Aoyxv3HvpL7G9nw0ug4
         RX3XXYLJnXQ7x00dEaArql0YFuBFJgvXGJB8umQy6tn5EmGTDOoTjULlTKftvRVJWfEX
         +DQDxN3Q6kk1DKGP1wxQNhU0IJVVKjLXMDqkIIVUr13d8OwKtVc0lBtAVjKgqnpgx4UZ
         kBeqKT0IGWqlKzLvVkx2CwyOMeEuZJ4+DXRABL1Xs2mGNsxq0Os4zIW4kvaXdgSQsRkq
         i4XQ==
X-Gm-Message-State: AO0yUKWpaKkmWassk0C04cZF9Fk1XYX12haz6QaZWx/uclTfA5/xt4M/
        9hTSfE9jizPoEi7n5WH1n7Egdg==
X-Google-Smtp-Source: AK7set8/yTqjcXgh/0/3dEkcHOUGMYrnXUP5s6INEQiSDvFROBDrAK59IhLwG+g/Y6jATAukLqfvKQ==
X-Received: by 2002:a5d:6ace:0:b0:2d8:908c:8fa0 with SMTP id u14-20020a5d6ace000000b002d8908c8fa0mr5270114wrw.9.1679486438062;
        Wed, 22 Mar 2023 05:00:38 -0700 (PDT)
Received: from [192.168.1.166] ([90.243.20.231])
        by smtp.gmail.com with ESMTPSA id d9-20020adfe889000000b002d97529b3bbsm3362583wrm.96.2023.03.22.05.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:00:37 -0700 (PDT)
Message-ID: <7ecf4fbf-392e-7c55-b731-2d61f962ddeb@linaro.org>
Date:   Wed, 22 Mar 2023 12:00:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
 <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
 <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
From:   Niyas Sait <niyas.sait@linaro.org>
In-Reply-To: <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22/03/2023 09:34, Andy Shevchenko wrote:

>>> Btw, what is the real argument of not using this table?
>>>
>>> Yes, I know that this is an MS extension, but why ARM needs something else and
>>> why even that is needed at all? CSRT is only for the_shared_  DMA resources
>>> and I think most of the IPs nowadays are using private DMA engines (or
>>> semi-private when driver based on ID can know which channel services which
>>> device).
>> The issue is that shared info descriptor is not part of CSRT definition [1]
>> and I think it is not standardized or documented anywhere.
>>
>> I was specifically looking at NXP I.MX8MP platform and the DMA lines for
>> devices are specified using FixedDMA resource descriptor. I think other Arm
>> platforms like RPi have similar requirement.
> Perhaps, but my question is_why_  is it so?
> I.o.w. what is the technical background for this solution.
> 

NXP I.MX8MP board uses shared DMA controller and the current ACPI 
firmware describes DMA request lines for devices using ACPI FixedDMA 
descriptors.

> JFYI: ARM platform(s) use SPCR, which is also not a part of the specification.

SPCR and CSRT tables have permissive licensing and probably okay to use 
them.

The main issue is that the shared info descriptor in the CSRT table is 
not a standard and none of the arm platforms uses them.

 >> [1]https://uefi.org/sites/default/files/resources/CSRT%20v2.pdf

-- 
Niyas
