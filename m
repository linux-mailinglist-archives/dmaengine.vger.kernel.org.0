Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964486D5C7A
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjDDJ5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjDDJ5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 05:57:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCC268E
        for <dmaengine@vger.kernel.org>; Tue,  4 Apr 2023 02:57:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so33371854pjl.4
        for <dmaengine@vger.kernel.org>; Tue, 04 Apr 2023 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680602252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EeJ3Vg/hflzXly6UJfLnp/sYv8Ula1ty7RMpEhQjsE=;
        b=DZcbyLkyTGTTuO+N7pa4ARwCTRNuL4ybs38LCUxl4HjBDH9eqjR2F0nnTnp1HWGEfc
         PhRf8bwSKXhOdsUKHc9TxrsB5fNYFMJtf08rWMZhxTVbBRsp71RfQ4+6Ye1omj+dPl4/
         SNS0NCBcfN3EOdGTJjny3/JDM2TZ/qHzsfDC3ASKsNYrR+VAZmbZd8gqmJ1D7hZUiYBj
         y/NqILXWJo+WPf7Fv7k5SH72D5y39NCvUOIRvrbjST8TvSWka2VANi3vardpQuZQF+rc
         BX132iwtB4VLe04nL1nzS6OdsrgWQ5BSA5vOt+Y0Dr1j0WT9LV2DWp1C6KtYOZqFczTL
         6g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EeJ3Vg/hflzXly6UJfLnp/sYv8Ula1ty7RMpEhQjsE=;
        b=LopjB+8OEno7Hk+wfkvCri4ee9zuUptFaIAD7cgVP2uX8vbllWZ3TEXu6ij3F6dnDx
         dDmTSaW0an9c7mCIbLOSaeUFVEAZWcbRpZmNzWPyAXgPs9mqKDagIYKtzBDjcCgjaZrb
         2E+9GV27R5j3Ntot7RE8dACY/iEc39Tdt+9+ZrMz1fJ+ds2cnj4AZcQ/Wn/MkasFE6R0
         lsizE2c7Lf2XozgBPwXTnQE2k6wmaATUPE23aeC5kqyIcE+KwGdPSGBluyXbqXNeQTTl
         3Qw2ciU1N5khUE4Hrao2e9klcRZ1n1zgEZSz91qgPSfP9PdbarPBzUBi7bVdLSbv6sun
         rhUw==
X-Gm-Message-State: AAQBX9cWJLgQWwK4t9ziz4mh5+kMqSaXi9Ah1Hvix71qUKFbd7PqLfZL
        DI3wY+8iThUn3LJfHMzvuu4mdg==
X-Google-Smtp-Source: AKy350YRiaOikp91648dDob3kng7cepINTfluG5WzInZqWo8yO2jZPLEMXzTjVgP71gtXNDkoKdSOg==
X-Received: by 2002:a17:90b:3e89:b0:237:ae7c:15be with SMTP id rj9-20020a17090b3e8900b00237ae7c15bemr2086527pjb.30.1680602251950;
        Tue, 04 Apr 2023 02:57:31 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id iy5-20020a170903130500b0019e81c8fd01sm8005079plb.249.2023.04.04.02.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:57:31 -0700 (PDT)
Message-ID: <79357547-d32d-9916-074d-37354d4016c3@igel.co.jp>
Date:   Tue, 4 Apr 2023 18:57:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 00/11] Introduce a test for continuous transfer
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
References: <20230317113238.142970-1-mie@igel.co.jp>
 <20230331053850.GE4973@thinkpad>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230331053850.GE4973@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2023/03/31 14:38, Manivannan Sadhasivam wrote:
> On Fri, Mar 17, 2023 at 08:32:27PM +0900, Shunsuke Mie wrote:
>> This patchset introduces testing through continuous transfer to the PCI
>> endpoint tests. The purpose is to find bugs that may exist in the endpoint
>> controller driver. This changes able to find bugs in the DW EDMA driver and
>> this patchset includes the fix.
>>
>> This bug does not appear in the current tests because these synchronize to
>> finish with every data transfer. However, the problem occurs with
>> continuous DMA issuances. The continuous transfers are required to get high
>> throughput and low latency. Therefore, the added tests will enable
>> realistic transfer testing.
>>
>> This patchset is divided into three parts:
>> - Remove duplicated definitions and improve some code [1-6/11]
>> - Add continuous transfer tests [7-9/11]
>> - Fix for the DW EDMA driver bug [10,11/11]
>>
>> This patchset has beed tested on RCar Spidar that has dw pci edma chip.
>>
> If you want maintainers to review the patches separately, please remove the RFC
> tag. Unless you are looking for some overall feedback about the approach.
Got it.
>
> But we are in the process of migrating the existing test under tools to
> Kselftest framework [1]. Until then, we cannot accept patches improving the
> existing test code. So please respin the patches on top of the Kselftest patch
> once it got posted. It's already due for some time :/
I understood. I'll track the work of Kselftest migration.
>
> Also the subject should mention "PCI endpoint".
Yes.
>
> - Mani
>
> [1] https://lore.kernel.org/all/20221007053934.5188-1-aman1.gupta@samsung.com/
Thank you for your comments.
>> Shunsuke Mie (11):
>>    misc: pci_endpoint_test: Aggregate irq_type checking
>>    misc: pci_endpoint_test: Remove an unused variable
>>    pci: endpoint: function/pci-epf-test: Unify a range of time
>>      measurement
>>    PCI: endpoint: functions/pci-epf-test: Move common difinitions to
>>      header file
>>    MAINTAINERS: Add a header file for pci-epf-test
>>    misc: pci_endpoint_test: Use a common header file between endpoint
>>      driver
>>    PCI: endpoint: functions/pci-epf-test: Extend the test for continuous
>>      transfers
>>    misc: pci_endpoint_test: Support a test of continuous transfer
>>    tools: PCI: Add 'C' option to support continuous transfer
>>    dmaengine: dw-edma: Fix to change for continuous transfer
>>    dmaengine: dw-edma: Fix to enable to issue dma request on DMA
>>      processing
>>
>>   MAINTAINERS                                   |   1 +
>>   drivers/dma/dw-edma/dw-edma-core.c            |  30 ++-
>>   drivers/misc/pci_endpoint_test.c              | 132 ++++--------
>>   drivers/pci/endpoint/functions/pci-epf-test.c | 199 ++++++++----------
>>   include/linux/pci-epf-test.h                  |  67 ++++++
>>   include/uapi/linux/pcitest.h                  |   1 +
>>   tools/pci/pcitest.c                           |  13 +-
>>   7 files changed, 231 insertions(+), 212 deletions(-)
>>   create mode 100644 include/linux/pci-epf-test.h
>>
>> -- 
>> 2.25.1
>>
Best,

Shunsuke.

