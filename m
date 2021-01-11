Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8152F1A84
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jan 2021 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbhAKQJO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jan 2021 11:09:14 -0500
Received: from mail-eopbgr770047.outbound.protection.outlook.com ([40.107.77.47]:4615
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387962AbhAKQJN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Jan 2021 11:09:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYDgMgovN0tG1obLZL8gQlKLUsgmooKUO/KGMFdrpmWIB8bzJApeKjRV0SdC21mkeBFGBBTjPREHGRcsCFqVrhN+nryU6aOSEc7gMLtCezXnluvdHiUBfcY53qEutUAmGnXLnHoFCRQfiJVIP1bdtHJISnUqPkXTG/EzZ7HTEy8radELaCr2C45MqzSRh9l/78PDZtFqH2O8+MEHloFmlye2sRfTfD8A+twwTdBQwBVBwq8ZGr+UtyD7FsEl4OYbJIHwuTIQP5TxK7PF78czroBgZ0fvI+/elW7lI9FMTLL5y8sP65MkZykXiVRxkvXpgHTQT5v5grgELoeqsJHeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgivnHdfJ/32XM6hPnEcBv3g03rD+cmyvQcUHtGOs/o=;
 b=Pjo1Fjd9XvnStlnueyLUfLrxpBDLM5FfqP6B1TGjKSIi8AGdkrUoXqsypBSZn/j3gtq51JqPPGFtZnm34kxra1WPdLJCgVB2Sw42d5vzrJlwI8sWIK/wARBsHz1PZNtEkof4PO6Pzk0lSSc8yevuPHnz6i9wlyBKJ3vxa53ln5KiR8nsDHiwmdffWP52B6NlG76LuYefw1HajXUt8TFxl/AKmM8OM2Kd8h9yQy4xwzbIM6pSGY3Rx+e07VEO+ukObcI2wwSULuXZUInX0mmonSstBDiVlp7RsvVv3Omkz5B3CPKRSDTFfHHBk8kjW9zJFN7XfRMc/f2jO7iBGbgjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgivnHdfJ/32XM6hPnEcBv3g03rD+cmyvQcUHtGOs/o=;
 b=IuRLG+SS50P5Hy8S2owTSPX7M1a5ZR6TfM1+4hl4BOUDlddsn9Pyq9tOdf+vEi8KLBv4DpI2M5FN8ZbB6QrAvMeGnVKGikfjVEtBW921IMl+qMJDTsXjyFmlA+M1Hnu09kgiH5loi7M/MDrHFnAEG8flEiibBTGgk85o54wctHQ=
Received: from BL1PR13CA0240.namprd13.prod.outlook.com (2603:10b6:208:2bf::35)
 by BN8PR02MB5953.namprd02.prod.outlook.com (2603:10b6:408:ae::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Mon, 11 Jan
 2021 16:08:22 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bf:cafe::6a) by BL1PR13CA0240.outlook.office365.com
 (2603:10b6:208:2bf::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend
 Transport; Mon, 11 Jan 2021 16:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 16:08:22 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 11 Jan 2021 08:07:58 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 11 Jan 2021 08:07:58 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
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
Received: from [172.30.17.109] (port=47428)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kyzjZ-0003hC-No; Mon, 11 Jan 2021 08:07:58 -0800
Subject: Re: dmaengine : xilinx_dma two issues
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Thomas <pthomas8589@gmail.com>,
        "Radhey Shyam Pandey" <radheys@xilinx.com>
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
 <8c0dff8b-eac8-f1d9-0ca9-a901a438d6e9@xilinx.com>
 <70a1f7eb-9d32-1e9a-764b-781082292ab3@metafoo.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a6378182-cda5-fbfc-38cf-620cc08ff124@xilinx.com>
Date:   Mon, 11 Jan 2021 17:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <70a1f7eb-9d32-1e9a-764b-781082292ab3@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c11141e7-f364-4941-9795-08d8b64b1e6f
X-MS-TrafficTypeDiagnostic: BN8PR02MB5953:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5953C9036AB6B2EC90504987C6AB0@BN8PR02MB5953.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs7eIQ/Dji0nB3n5q05fAjDUa+CEUot0SzJfx8M/Vz8LuEN9iLcUHOc9z6FoW5KLKHfyEAFTpW5NbJHkFOiAAERbrGqsazHmhjkTlL2j9tPjzQFQgYeeEXxX7eu0s1gMO0DHRk23XpWtqjhG+/HR0CBtRvhC7E3dWx0VXqvXKAeFiAuOyh0eqpJXpivHO1vZP5mCj5i4rQSsHfIdOpqnXQx7gpukPc7XFeyydBb/0EQJXAvMxgfHKJfIN6UPx1UvV8OFpLQu52XzChHrVHHkDWrv3meTKW33hdmtFeGXXJ5Oup/V7uTkZNqKSVUw33pPgfKeUAWnHRqGYOgUT/EREU2ng/6KtpQQjm5PXdj4QaV8F2bHebVkHt/sUfeiGZOMV0Mih8MkmcDlOVHB7cWxbbszmw7JBSdWzdHNj0v54YZpTTYWuFBZONiuWr4EHTu5LsEVtHOveBioxTV+C9pLimXtrf0G1oacG7/PwDCxus4c2XBoEDqeZagpBJFsJdqWUGgyb8AcLIl8iE+Kb3ckMVZED2bYow7WmPEiZkPsFog/q/r3rG9VLCA1QuzTX7dzRa9RGaW8ygxAvhIic1hIpNOkQnSF+IFXYFmEU9gqEK+ADkTRrlsDy9G04YRqgBbt
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(186003)(31696002)(47076005)(4326008)(70586007)(2906002)(356005)(44832011)(26005)(5660300002)(70206006)(34020700004)(82310400003)(6666004)(7636003)(6636002)(53546011)(110136005)(478600001)(426003)(31686004)(9786002)(36756003)(8936002)(7416002)(107886003)(316002)(82740400003)(8676002)(83380400001)(336012)(2616005)(54906003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 16:08:22.0948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11141e7-f364-4941-9795-08d8b64b1e6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5953
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11. 01. 21 16:33, Lars-Peter Clausen wrote:
> On 1/11/21 10:32 AM, Michal Simek wrote:
>> Hi Lars,
>>
>> On 10. 01. 21 16:43, Lars-Peter Clausen wrote:
>>> On 1/10/21 4:16 PM, Paul Thomas wrote:
>>>> On Fri, Jan 8, 2021 at 1:36 PM Radhey Shyam Pandey
>>>> <radheys@xilinx.com> wrote:
>>>>>> -----Original Message-----
>>>>>> From: Paul Thomas <pthomas8589@gmail.com>
>>>>>> Sent: Friday, January 8, 2021 9:27 PM
>>>>>> To: Radhey Shyam Pandey <radheys@xilinx.com>
>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>>>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Matthew
>>>>>> Murrian
>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>;
>>>>>> Marc
>>>>>> Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>>>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>> kernel@vger.kernel.org>; dave.jiang@intel.com; Shravya Kumbham
>>>>>> <shravyak@xilinx.com>; git <git@xilinx.com>
>>>>>> Subject: Re: dmaengine : xilinx_dma two issues
>>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> On Fri, Jan 8, 2021 at 2:13 AM Radhey Shyam Pandey
>>>>>> <radheys@xilinx.com>
>>>>>> wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Radhey Shyam Pandey
>>>>>>>> Sent: Monday, January 4, 2021 10:50 AM
>>>>>>>> To: Paul Thomas <pthomas8589@gmail.com>; Dan Williams
>>>>>>>> <dan.j.williams@intel.com>; Vinod Koul <vkoul@kernel.org>; Michal
>>>>>>>> Simek <michals@xilinx.com>; Matthew Murrian
>>>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>>>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>;
>>>>>>>> Marc Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>>>>>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>>>> kernel@vger.kernel.org>; Shravya Kumbham <shravyak@xilinx.com>; git
>>>>>>>> <git@xilinx.com>
>>>>>>>> Subject: RE: dmaengine : xilinx_dma two issues
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Paul Thomas <pthomas8589@gmail.com>
>>>>>>>>> Sent: Monday, December 28, 2020 10:14 AM
>>>>>>>>> To: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>>>>>>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Radhey
>>>>>>>>> Shyam Pandey <radheys@xilinx.com>; Matthew Murrian
>>>>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>>>>> <romain.perier@gmail.com>;
>>>>>>>>> Krzysztof Kozlowski <krzk@kernel.org>; Marc Ferland
>>>>>>>>> <ferlandm@amotus.ca>; Sebastian von Ohr <vonohr@smaract.com>;
>>>>>>>>> dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>>>>> kernel@vger.kernel.org>
>>>>>>>>> Subject: dmaengine : xilinx_dma two issues
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> I'm trying to get the 5.10 kernel up and running for our system,
>>>>>>>>> and I'm running into a couple of issues with xilinx_dma.
>>>>>>>> + (Xilinx mailing list)
>>>>>>>>
>>>>>>>> Thanks for bringing the issues to our notice. Replies inline.
>>>>>>>>
>>>>>>>>> First, commit 14ccf0aab46e 'dmaengine: xilinx_dma: In dma channel
>>>>>>>>> probe fix node order dependency' breaks our usage. Before this
>>>>>>>>> commit a
>>>>>>>> call to:
>>>>>>>>> dma_request_chan(&indio_dev->dev, "axi_dma_0"); returns fine, but
>>>>>>>>> after that commit it returns -19. The reason for this seems to be
>>>>>>>>> that the only channel that is setup is channel 1 (chan->id is 1 in
>>>>>>>> xilinx_dma_chan_probe()).
>>>>>>>>> However in
>>>>>>>>> of_dma_xilinx_xlate() chan_id is gets set to 0 (int chan_id =
>>>>>>>>> dma_spec-
>>>>>>>>>> args[0];), which causes the:
>>>>>>>>> !xdev->chan[chan_id]
>>>>>>>>> test to fail in of_dma_xilinx_xlate()
>>>>>>>> What is the channel number passed in dmaclient DT?
>>>>>> Is this a question for me?
>>>>> Yes, please also share the dmaclient DT client node. Need to see
>>>>> channel number passed to dmas property. Something like below-
>>>>>
>>>>> dmas = <& axi_dma_0 1>
>>>>> dma-names = "axi_dma_0"
>>>> OK, I think I need to revisit this and clean it up some. Currently In
>>>> the driver (a custom iio adc driver) it is hard coded:
>>>> dma_request_chan(&indio_dev->dev, "axi_dma_0");
>>>>
>>>> However, the DT also has the entries (currently unused by the driver):
>>>>           dmas = <&axi_dma_0 0>;
>>>>           dma-names = "axi_dma_0";
>>>>
>>>> I'll go back and clean up our driver to do something like
>>>> adi-axi-adc.c does:
>>>>
>>>>           if (!device_property_present(dev, "dmas"))
>>>>                   return 0;
>>>>
>>>>           if (device_property_read_string(dev, "dma-names", &dma_name))
>>>>                   dma_name = "axi_dma_0";
>>>>
>>>> Should the dmas node get used by the driver? I see the second argument
>>>> is: '0' for write/tx and '1' for read/rx channel. So I should be
>>>> setting this to 1 like this?
>>>>           dmas = <&axi_dma_0 1>;
>>>>           dma-names = "axi_dma_0";
>>>>
>>>> But where does that field get used?
>>> This got broken in "dmaengine: xilinx_dma: In dma channel probe fix node
>>> order dependency"
>>> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14ccf0aab46e1888e2f45b6e995c621c70b32651>.
>>>
>>> Before if there was only one channel that channel was always at index 0.
>>> Regardless of whether the channel was RX or TX. But after that change
>>> the RX channel is always at offset 1, regardless of whether the DMA has
>>> one or two channels. This is a breakage in ABI.
>>>
>>> If you have the choice I'd recommend to not use the Xilinx DMA, it gets
>>> broken pretty much every other release.
>> I expect that you are talking about Xilinx releases and I hope that this
>> has changed over times when most of changes are upstreamed already. The
>> patch above you are referencing has been applied by Vinod and he is
>> checking patches a lot. If there is a problem and any breakage it needs
>> to be fixed. And bugs happen all the time and we have a way how to work
>> with it.
> 
> I don't know if it has gotten better. When I upgrade to a new release
> what takes up most of the time is figuring out why the Xilinx DMA
> doesn't work anymore. Its been like this for years.

Are you saying that upstreaming this driver doesn't improve his quality?
But I would expect when you figured this out you have sent patches to
fix it.


>> If you see there any issue please report them and let's fix them and
>> continue on this topic from technical point of view.
>> In connection to this problem what are you suggesting? Just revert this
>> patch or fix ordering differently? Would be good to provide your
>> suggestion and fix it.
> 
> Reverting would re-introduce the issue the patch was supposed to fix.
> 
> The would have been to use index 0 for the channel if there is only one
> channel. If there are two channels use 0 for TX and 1 for RX.
> 
> The problem is that the change has been around for a while and restoring
> the previous behavior will break users that are expecting the new
> behavior. It is a bit of a catch-22.

Ok. It means we need to find a way how to fix it and don't break
existing users.
I expect there shouldn't be hard to detect if there is only one channel.
If there is just use index 0.

Thanks,
Michal


