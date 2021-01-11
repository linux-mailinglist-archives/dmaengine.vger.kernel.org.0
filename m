Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEC2F0F32
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jan 2021 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbhAKJea (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jan 2021 04:34:30 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:18817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727716AbhAKJea (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Jan 2021 04:34:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZtwLdHhm5hkt4fhdSzllMjSDD605mRJ9SDZoyBvW1iGPX0S56f9BeotObr22rhITMdYSxHAKfck301BmvfP3IWNKRDqzXBtVWuhvFgjT3ruJn9z9p20JDsJEvKrKlLb+oUIRhzoA7rwXlAjObxAD8dHZjIYnB0LedVRqDdV7bhHhYNzi/L2vjCF+GjrZGTNaLpJqmQVZRsY5qJmQ/SJl130ACOsLQZCUwTu28G5jnC9TTXAtS2rjg5nWInL0ufJxWcXA7ipUAoP+OAI4LLvF970aPneNGATUpT5XUxdJskj5Uxzgap1YeVC/XmbjX5SRe6Zfq7hn01YLkx3IlQh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovci5xCi3ws+SwfsIRs4olueg0eEUixjtL6G5HvnQXI=;
 b=XjlzwKf3ho4J50nTPrKpWbJSn4RBgbQGj1ZUR25p4DVtwwHsPDr6OZqORqLMBQk+mbkaXh79Z2fS0M1zCaqXXUJPrHd/ZlOqm5vqOU9L51kGJj4duqGwKLr0Hd80nwP5XFg4xB59aeUzN6VPHLhgms3954/cb9tpK7a0r5nVXVUQgeO1ARlKuFVX6UU4P7P/TMgKfIaPvyDAzoazrApPkVGeb91ucEDxB/cI/+sghtIV14UhsJEMJPMEA1LjlzIj3tt6Oe5xUc9F8lrGQGwNNSnQOwVwKUYonqiZL+u/7eiJkzQAH6t0eQp6dhd2BsaZFr/b8EAtJt8GoWtJ8pczEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovci5xCi3ws+SwfsIRs4olueg0eEUixjtL6G5HvnQXI=;
 b=Ea8ha4iIgCyetZiftO7LW8PhiJCTpbmeQRANGM8/6FXFj4XRxHXWx2uZNCnvrTlSp+Likxj96yDkFKNvxQNfW2vqc81G3V7s4bs2lTfE4itcdWzMdBTcXvFfCuHln0KsoQUijM8/RNBDnvVFjnqyx7JPHxnV6dE6A1LK6hHeseE=
Received: from MN2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:208:120::39)
 by SN6PR02MB5231.namprd02.prod.outlook.com (2603:10b6:805:70::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 09:33:35 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::f7) by MN2PR10CA0026.outlook.office365.com
 (2603:10b6:208:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Mon, 11 Jan 2021 09:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 09:33:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 11 Jan 2021 01:33:01 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 11 Jan 2021 01:33:01 -0800
Envelope-to: git@xilinx.com,
 dave.jiang@intel.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org,
 vonohr@smaract.com,
 ferlandm@amotus.ca,
 krzk@kernel.org,
 romain.perier@gmail.com,
 matthew.murrian@goctsi.com,
 vkoul@kernel.org,
 dan.j.williams@intel.com,
 pthomas8589@gmail.com,
 lars@metafoo.de
Received: from [172.30.17.109] (port=36176)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kytZM-0006Vs-46; Mon, 11 Jan 2021 01:33:00 -0800
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Thomas <pthomas8589@gmail.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Marc Ferland" <ferlandm@amotus.ca>,
        Sebastian von Ohr <vonohr@smaract.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        Shravya Kumbham <shravyak@xilinx.com>, git <git@xilinx.com>
References: <CAD56B7dpewwJVttuk4GAcAsx62HP=vPF9jmxTFNG3Z9RP4u9zA@mail.gmail.com>
 <BY5PR02MB652004976C500CD4EA763047C7D20@BY5PR02MB6520.namprd02.prod.outlook.com>
 <BY5PR02MB6520C9083F072E6907534497C7AE0@BY5PR02MB6520.namprd02.prod.outlook.com>
 <CAD56B7f9D5HnN-rx2QRi4z4HA-bM1=oVpUv6XY35HxBQkAaXmQ@mail.gmail.com>
 <BY5PR02MB6520112ACAD71BD7339BAE89C7AE0@BY5PR02MB6520.namprd02.prod.outlook.com>
 <CAD56B7eUrNYFnV8dhmRE-2RdAA+dix-dYGHAewDutF6B849b0g@mail.gmail.com>
 <d153eb8c-bc55-37b5-2b22-a4f6c6263d38@metafoo.de>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: dmaengine : xilinx_dma two issues
Message-ID: <8c0dff8b-eac8-f1d9-0ca9-a901a438d6e9@xilinx.com>
Date:   Mon, 11 Jan 2021 10:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d153eb8c-bc55-37b5-2b22-a4f6c6263d38@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 429e0f47-5aa8-4ee9-24a9-08d8b613f7c5
X-MS-TrafficTypeDiagnostic: SN6PR02MB5231:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52319666F06C7C16FEE447A8C6AB0@SN6PR02MB5231.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwz9JfZ29SCkRKebALKoYMuVp8cm06gv70BfZG8DddkW5Rqr+HkcrOTCmbo6Ep1hqLkyY5JOkTK1MpqlUE9avvQ6VGCahph6OWYpnnTtzOZH6+xKn8wbjIR1GvVDwX76gzqQldvZjmWxDCysN6YmfYus31xbcYuvZH5L3jV8I2T883u++joIBTmSY4CWs0r4QX5ruJuNIcpCJN0WI95GAt+DMQdeI14H/iAINb0ULWyTHumtjVMOXMwqgcwZVO+XoQk1U8O7mt9fCBwAGWhOOQ11VMIW1n/dXt3GcSJ0Uli+fbTCX1xYfbpx5/rNXmEnMD55FEfOzYTokm/PHHf0bG3SzgMIDQnbQqkB2zAOaHG+3glNscGTt7x7N9Qb4w+jksiy+YfDWH798m1fzfyUc9lUM5KhJejGQdc0dZLhva3dwFWu9yoCkHLcLBdKFtjzd7mqt6Pa5r7GWwjxdbg2gsqN2iXUk6Io4k6c9rzjK0xmvgAuQ0H/o89h+ip9Xpx11nxylbmNPCeDRxjurGI6+fAlOUukEfAuuwGZX6xRzzzRrsbs8YkjjTr3ny6iSXg2mVHffa2AVNgwfmcfvwhmC3fQyeK6QA0v0sVw6XfaEAdwUkGML1kxNGonPpLwWgxB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(46966006)(6636002)(6666004)(8676002)(8936002)(70586007)(70206006)(107886003)(53546011)(2906002)(7416002)(5660300002)(2616005)(54906003)(31696002)(82740400003)(110136005)(36756003)(83380400001)(316002)(478600001)(31686004)(336012)(7636003)(82310400003)(4326008)(34020700004)(9786002)(44832011)(356005)(186003)(26005)(426003)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 09:33:34.9052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 429e0f47-5aa8-4ee9-24a9-08d8b613f7c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5231
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lars,

On 10. 01. 21 16:43, Lars-Peter Clausen wrote:
> On 1/10/21 4:16 PM, Paul Thomas wrote:
>> On Fri, Jan 8, 2021 at 1:36 PM Radhey Shyam Pandey
>> <radheys@xilinx.com> wrote:
>>>> -----Original Message-----
>>>> From: Paul Thomas <pthomas8589@gmail.com>
>>>> Sent: Friday, January 8, 2021 9:27 PM
>>>> To: Radhey Shyam Pandey <radheys@xilinx.com>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Matthew Murrian
>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>; Marc
>>>> Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>> kernel@vger.kernel.org>; dave.jiang@intel.com; Shravya Kumbham
>>>> <shravyak@xilinx.com>; git <git@xilinx.com>
>>>> Subject: Re: dmaengine : xilinx_dma two issues
>>>>
>>>> Hi All,
>>>>
>>>> On Fri, Jan 8, 2021 at 2:13 AM Radhey Shyam Pandey <radheys@xilinx.com>
>>>> wrote:
>>>>>> -----Original Message-----
>>>>>> From: Radhey Shyam Pandey
>>>>>> Sent: Monday, January 4, 2021 10:50 AM
>>>>>> To: Paul Thomas <pthomas8589@gmail.com>; Dan Williams
>>>>>> <dan.j.williams@intel.com>; Vinod Koul <vkoul@kernel.org>; Michal
>>>>>> Simek <michals@xilinx.com>; Matthew Murrian
>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>;
>>>>>> Marc Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>>>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>> kernel@vger.kernel.org>; Shravya Kumbham <shravyak@xilinx.com>; git
>>>>>> <git@xilinx.com>
>>>>>> Subject: RE: dmaengine : xilinx_dma two issues
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Paul Thomas <pthomas8589@gmail.com>
>>>>>>> Sent: Monday, December 28, 2020 10:14 AM
>>>>>>> To: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>>>>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Radhey
>>>>>>> Shyam Pandey <radheys@xilinx.com>; Matthew Murrian
>>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>>> <romain.perier@gmail.com>;
>>>>>>> Krzysztof Kozlowski <krzk@kernel.org>; Marc Ferland
>>>>>>> <ferlandm@amotus.ca>; Sebastian von Ohr <vonohr@smaract.com>;
>>>>>>> dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>>> kernel@vger.kernel.org>
>>>>>>> Subject: dmaengine : xilinx_dma two issues
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I'm trying to get the 5.10 kernel up and running for our system,
>>>>>>> and I'm running into a couple of issues with xilinx_dma.
>>>>>> + (Xilinx mailing list)
>>>>>>
>>>>>> Thanks for bringing the issues to our notice. Replies inline.
>>>>>>
>>>>>>> First, commit 14ccf0aab46e 'dmaengine: xilinx_dma: In dma channel
>>>>>>> probe fix node order dependency' breaks our usage. Before this
>>>>>>> commit a
>>>>>> call to:
>>>>>>> dma_request_chan(&indio_dev->dev, "axi_dma_0"); returns fine, but
>>>>>>> after that commit it returns -19. The reason for this seems to be
>>>>>>> that the only channel that is setup is channel 1 (chan->id is 1 in
>>>>>> xilinx_dma_chan_probe()).
>>>>>>> However in
>>>>>>> of_dma_xilinx_xlate() chan_id is gets set to 0 (int chan_id =
>>>>>>> dma_spec-
>>>>>>>> args[0];), which causes the:
>>>>>>> !xdev->chan[chan_id]
>>>>>>> test to fail in of_dma_xilinx_xlate()
>>>>>> What is the channel number passed in dmaclient DT?
>>>> Is this a question for me?
>>> Yes, please also share the dmaclient DT client node. Need to see
>>> channel number passed to dmas property. Something like below-
>>>
>>> dmas = <& axi_dma_0 1>
>>> dma-names = "axi_dma_0"
>> OK, I think I need to revisit this and clean it up some. Currently In
>> the driver (a custom iio adc driver) it is hard coded:
>> dma_request_chan(&indio_dev->dev, "axi_dma_0");
>>
>> However, the DT also has the entries (currently unused by the driver):
>>          dmas = <&axi_dma_0 0>;
>>          dma-names = "axi_dma_0";
>>
>> I'll go back and clean up our driver to do something like
>> adi-axi-adc.c does:
>>
>>          if (!device_property_present(dev, "dmas"))
>>                  return 0;
>>
>>          if (device_property_read_string(dev, "dma-names", &dma_name))
>>                  dma_name = "axi_dma_0";
>>
>> Should the dmas node get used by the driver? I see the second argument
>> is: '0' for write/tx and '1' for read/rx channel. So I should be
>> setting this to 1 like this?
>>          dmas = <&axi_dma_0 1>;
>>          dma-names = "axi_dma_0";
>>
>> But where does that field get used?
> 
> This got broken in "dmaengine: xilinx_dma: In dma channel probe fix node
> order dependency"
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14ccf0aab46e1888e2f45b6e995c621c70b32651>.
> Before if there was only one channel that channel was always at index 0.
> Regardless of whether the channel was RX or TX. But after that change
> the RX channel is always at offset 1, regardless of whether the DMA has
> one or two channels. This is a breakage in ABI.
> 
> If you have the choice I'd recommend to not use the Xilinx DMA, it gets
> broken pretty much every other release.

I expect that you are talking about Xilinx releases and I hope that this
has changed over times when most of changes are upstreamed already. The
patch above you are referencing has been applied by Vinod and he is
checking patches a lot. If there is a problem and any breakage it needs
to be fixed. And bugs happen all the time and we have a way how to work
with it.
If you see there any issue please report them and let's fix them and
continue on this topic from technical point of view.
In connection to this problem what are you suggesting? Just revert this
patch or fix ordering differently? Would be good to provide your
suggestion and fix it.

Thanks,
Michal

