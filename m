Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397176D5CC1
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjDDKMW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjDDKMS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 06:12:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9072D72
        for <dmaengine@vger.kernel.org>; Tue,  4 Apr 2023 03:12:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso33394777pjb.3
        for <dmaengine@vger.kernel.org>; Tue, 04 Apr 2023 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680603120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1nFAdUtaNleNvdd4R9u83gwyhhW/N23uXd1WaMTM4U=;
        b=syseZK3DkzUTu4rg9+gE6qvvj6nkt4Um45ZGqGK1w3ujhwuOfepRvk0YR7dYLzxOU8
         CdCi8QeP0v0n1rqRzRvN312AW5p6AV7xa9e5gggxbZh4wt8QHtOrnme2BluEspcFyv+o
         rCCL8n3v/vW6kofNuIFITWRyEfc07xCBJhqVKFcew2eAZsntybVtOP5Kb59iMY6yzAzD
         Hbc1GUwymQvu7br9rT8i/sb8WUYoEY17Wwc2lv2uu0LJDw5i5wJSQx4sG3+0Cd40wgP6
         Pv1xHnF4QS7Rfs2dxcKgat/Xu9N6dY4i33A+5E55dLFS7ijmJx1xLzkfd/x4Uh0q4XGl
         7qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680603120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1nFAdUtaNleNvdd4R9u83gwyhhW/N23uXd1WaMTM4U=;
        b=Yoi3Qmps+pUg6Z0ZTUnJ6fOgFq50Yu0PrX5rh6vx26wYg2qx9YW1RN52wCJmEScZ4M
         NPkdVKzp5SVs9Cx01xxnOBg6u5LjhQG+3o3Cj8CR4WfqWOTGUthOToSFhAxloGcK7DvF
         QFH6jlrHVm0G0qroBR439+Em+dQm/FenNzdIFZcv/SHw1G1Gc7quvIEJ2rW4MOgP39fT
         qxFVQUtqEKIJwH+cOAF9v2me98ctyL8+oimYrEZet2iVQ+XFuqmFObwtwBcluO9JsDqJ
         V2xjdx3Z5pUKKeLYmGhdA0ms0/cTH5wWdPVFU8WkKms7MdimHcbXc3q684Jrlk4k3p3q
         R6Yw==
X-Gm-Message-State: AAQBX9esg+I14SlN0Dob6BNWmpjE9JX3AMNwoV5WjDcgbeKaVpeg6lv1
        /g+wRVQyZQ8+h0pSAlHyS/7Aig==
X-Google-Smtp-Source: AKy350Y+vvljfQnHEd/9uDjlC5EDRk7uFc/JYSTm09VsF7x/uh7AC1a4zTjCjeYUdCxWBgayofcOhw==
X-Received: by 2002:a17:902:d193:b0:1a2:73d8:5a87 with SMTP id m19-20020a170902d19300b001a273d85a87mr1760672plb.5.1680603119682;
        Tue, 04 Apr 2023 03:11:59 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001a281063ab4sm8014999plb.233.2023.04.04.03.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:11:59 -0700 (PDT)
Message-ID: <2a4e0f94-4766-8db1-c648-e72b1f7924fa@igel.co.jp>
Date:   Tue, 4 Apr 2023 19:11:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [EXT] [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common
 header file between endpoint driver
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20230317113238.142970-1-mie@igel.co.jp>
 <20230317113238.142970-7-mie@igel.co.jp>
 <AM6PR04MB4838D8F8AF23C61048BDFB9788BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB4838D8F8AF23C61048BDFB9788BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
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


On 2023/03/17 23:47, Frank Li wrote:
>> pci@vger.kernel.org
>> Subject: [EXT] [RFC PATCH 06/11] misc: pci_endpoint_test: Use a common
>> header file between endpoint driver
>>
>> Caution: EXT Email
>>
>> Duplicated definitions between pci-epf-test and pci_endpoint_test are
>> already moved to a header file. Remove the common definitions and include
>> the header file. In addition, the separate register address writes were
>> combined into a single write.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>>   drivers/misc/pci_endpoint_test.c | 42 +-------------------------------
>>   1 file changed, 1 insertion(+), 41 deletions(-)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c
>> b/drivers/misc/pci_endpoint_test.c
>> index 55733dee95ad..d4a42e9ab86a 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -22,52 +22,12 @@
>>   #include <linux/pci_ids.h>
>>
>>   #include <linux/pci_regs.h>
>> +#include <linux/pci-epf-test.h>
> Pci-epf-test.h was only used by these two files.
>
> Actually, I think move  drivers/misc/pci_endpoint_test.c to under drivers/pci/endpoint/functions/
> And shared one private header is more reasonable.
> These two files should be stay together because tight coupling.

I agree that the shared header is not reasonable. However, it seems 
difficult to move pci_endpoint_test.c

because it is not an endpoint function driver. Furthermore, since 
Kselftest adaption [1] is being worked

on, I'd like to reconsider how we can apply the Kselftest patch.

[1] 
https://lore.kernel.org/all/20221007053934.5188-1-aman1.gupta@samsung.com/

>
>>   #include <uapi/linux/pcitest.h>
>>
>>   #define DRV_MODULE_NAME                                "pci-endpoint-test"
>>
>> -#define IRQ_TYPE_UNDEFINED                     -1
>> -#define IRQ_TYPE_LEGACY                                0
>> -#define IRQ_TYPE_MSI                           1
>> -#define IRQ_TYPE_MSIX                          2
>> -
>> -#define PCI_ENDPOINT_TEST_MAGIC                        0x0
>> -
>> -#define PCI_ENDPOINT_TEST_COMMAND              0x4
>> -#define COMMAND_RAISE_LEGACY_IRQ               BIT(0)
>> -#define COMMAND_RAISE_MSI_IRQ                  BIT(1)
>> -#define COMMAND_RAISE_MSIX_IRQ                 BIT(2)
>> -#define COMMAND_READ                           BIT(3)
>> -#define COMMAND_WRITE                          BIT(4)
>> -#define COMMAND_COPY                           BIT(5)
>> -
>> -#define PCI_ENDPOINT_TEST_STATUS               0x8
>> -#define STATUS_READ_SUCCESS                    BIT(0)
>> -#define STATUS_READ_FAIL                       BIT(1)
>> -#define STATUS_WRITE_SUCCESS                   BIT(2)
>> -#define STATUS_WRITE_FAIL                      BIT(3)
>> -#define STATUS_COPY_SUCCESS                    BIT(4)
>> -#define STATUS_COPY_FAIL                       BIT(5)
>> -#define STATUS_IRQ_RAISED                      BIT(6)
>> -#define STATUS_SRC_ADDR_INVALID                        BIT(7)
>> -#define STATUS_DST_ADDR_INVALID                        BIT(8)
>> -
>> -#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR       0x0c
>> -#define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR       0x10
>> -
>> -#define PCI_ENDPOINT_TEST_LOWER_DST_ADDR       0x14
>> -#define PCI_ENDPOINT_TEST_UPPER_DST_ADDR       0x18
>> -
>> -#define PCI_ENDPOINT_TEST_SIZE                 0x1c
>> -#define PCI_ENDPOINT_TEST_CHECKSUM             0x20
>> -
>> -#define PCI_ENDPOINT_TEST_IRQ_TYPE             0x24
>> -#define PCI_ENDPOINT_TEST_IRQ_NUMBER           0x28
>> -
>> -#define PCI_ENDPOINT_TEST_FLAGS                        0x2c
>> -#define FLAG_USE_DMA                           BIT(0)
>> -
>>   #define PCI_DEVICE_ID_TI_AM654                 0xb00c
>>   #define PCI_DEVICE_ID_TI_J7200                 0xb00f
>>   #define PCI_DEVICE_ID_TI_AM64                  0xb010
>> --
>> 2.25.1

Best,

Shunsuke.

