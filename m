Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB212F083E
	for <lists+dmaengine@lfdr.de>; Sun, 10 Jan 2021 17:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbhAJQHJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Jan 2021 11:07:09 -0500
Received: from www381.your-server.de ([78.46.137.84]:33622 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJQHJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Jan 2021 11:07:09 -0500
X-Greylist: delayed 1348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 11:07:07 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=R29doNJpSYKaxeNU2r78cLtxqxuJ6ZMJ9rTHB65R/uo=; b=UeiLT2Huki4bCzWCzEDPcWsiPr
        91nSMjqvYNHvR3MpJXbeV1zIWWEuECmFRAVkCj9qIsr1KKV2IKu1d+sbNVah5u6CcXDxxQ2xbBLJs
        jkS0LFZ6U+bflPZ7e01GcQ6kop8phGH3j+cwA+IwXVf5Q6gaxQbf1vLYdZRGPn6If8QzQvT0lSloL
        nn3ChIOapIIwCp7ax13sCvkLgZLKkeLF1wMVbJRYed/roQCdjpapNxpYZ/JSeYJ8fTyWcYoPYPpHb
        yj+Sfz+hPjmf+xxFz/S1dbTxdLrZRNL9BgwZQMc/WzDP1hOGXVb7pkxJTLjTubayvwpjm4IVD+ycC
        9DLGANDQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kycse-0008Dv-Km; Sun, 10 Jan 2021 16:43:48 +0100
Received: from [2001:a61:2bd0:3301:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kycse-000Day-CA; Sun, 10 Jan 2021 16:43:48 +0100
Subject: Re: dmaengine : xilinx_dma two issues
To:     Paul Thomas <pthomas8589@gmail.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Matthew Murrian <matthew.murrian@goctsi.com>,
        Romain Perier <romain.perier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Ferland <ferlandm@amotus.ca>,
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
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d153eb8c-bc55-37b5-2b22-a4f6c6263d38@metafoo.de>
Date:   Sun, 10 Jan 2021 16:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7eUrNYFnV8dhmRE-2RdAA+dix-dYGHAewDutF6B849b0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26045/Sun Jan 10 13:36:42 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/10/21 4:16 PM, Paul Thomas wrote:
> On Fri, Jan 8, 2021 at 1:36 PM Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>>> -----Original Message-----
>>> From: Paul Thomas <pthomas8589@gmail.com>
>>> Sent: Friday, January 8, 2021 9:27 PM
>>> To: Radhey Shyam Pandey <radheys@xilinx.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Matthew Murrian
>>> <matthew.murrian@goctsi.com>; Romain Perier
>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>; Marc
>>> Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>> kernel@vger.kernel.org>; dave.jiang@intel.com; Shravya Kumbham
>>> <shravyak@xilinx.com>; git <git@xilinx.com>
>>> Subject: Re: dmaengine : xilinx_dma two issues
>>>
>>> Hi All,
>>>
>>> On Fri, Jan 8, 2021 at 2:13 AM Radhey Shyam Pandey <radheys@xilinx.com>
>>> wrote:
>>>>> -----Original Message-----
>>>>> From: Radhey Shyam Pandey
>>>>> Sent: Monday, January 4, 2021 10:50 AM
>>>>> To: Paul Thomas <pthomas8589@gmail.com>; Dan Williams
>>>>> <dan.j.williams@intel.com>; Vinod Koul <vkoul@kernel.org>; Michal
>>>>> Simek <michals@xilinx.com>; Matthew Murrian
>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>> <romain.perier@gmail.com>; Krzysztof Kozlowski <krzk@kernel.org>;
>>>>> Marc Ferland <ferlandm@amotus.ca>; Sebastian von Ohr
>>>>> <vonohr@smaract.com>; dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>> kernel@vger.kernel.org>; Shravya Kumbham <shravyak@xilinx.com>; git
>>>>> <git@xilinx.com>
>>>>> Subject: RE: dmaengine : xilinx_dma two issues
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Paul Thomas <pthomas8589@gmail.com>
>>>>>> Sent: Monday, December 28, 2020 10:14 AM
>>>>>> To: Dan Williams <dan.j.williams@intel.com>; Vinod Koul
>>>>>> <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>; Radhey
>>>>>> Shyam Pandey <radheys@xilinx.com>; Matthew Murrian
>>>>>> <matthew.murrian@goctsi.com>; Romain Perier
>>>>> <romain.perier@gmail.com>;
>>>>>> Krzysztof Kozlowski <krzk@kernel.org>; Marc Ferland
>>>>>> <ferlandm@amotus.ca>; Sebastian von Ohr <vonohr@smaract.com>;
>>>>>> dmaengine@vger.kernel.org; Linux ARM <linux-
>>>>>> arm-kernel@lists.infradead.org>; linux-kernel <linux-
>>>>>> kernel@vger.kernel.org>
>>>>>> Subject: dmaengine : xilinx_dma two issues
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I'm trying to get the 5.10 kernel up and running for our system,
>>>>>> and I'm running into a couple of issues with xilinx_dma.
>>>>> + (Xilinx mailing list)
>>>>>
>>>>> Thanks for bringing the issues to our notice. Replies inline.
>>>>>
>>>>>> First, commit 14ccf0aab46e 'dmaengine: xilinx_dma: In dma channel
>>>>>> probe fix node order dependency' breaks our usage. Before this
>>>>>> commit a
>>>>> call to:
>>>>>> dma_request_chan(&indio_dev->dev, "axi_dma_0"); returns fine, but
>>>>>> after that commit it returns -19. The reason for this seems to be
>>>>>> that the only channel that is setup is channel 1 (chan->id is 1 in
>>>>> xilinx_dma_chan_probe()).
>>>>>> However in
>>>>>> of_dma_xilinx_xlate() chan_id is gets set to 0 (int chan_id =
>>>>>> dma_spec-
>>>>>>> args[0];), which causes the:
>>>>>> !xdev->chan[chan_id]
>>>>>> test to fail in of_dma_xilinx_xlate()
>>>>> What is the channel number passed in dmaclient DT?
>>> Is this a question for me?
>> Yes, please also share the dmaclient DT client node. Need to see
>> channel number passed to dmas property. Something like below-
>>
>> dmas = <& axi_dma_0 1>
>> dma-names = "axi_dma_0"
> OK, I think I need to revisit this and clean it up some. Currently In
> the driver (a custom iio adc driver) it is hard coded:
> dma_request_chan(&indio_dev->dev, "axi_dma_0");
>
> However, the DT also has the entries (currently unused by the driver):
>          dmas = <&axi_dma_0 0>;
>          dma-names = "axi_dma_0";
>
> I'll go back and clean up our driver to do something like adi-axi-adc.c does:
>
>          if (!device_property_present(dev, "dmas"))
>                  return 0;
>
>          if (device_property_read_string(dev, "dma-names", &dma_name))
>                  dma_name = "axi_dma_0";
>
> Should the dmas node get used by the driver? I see the second argument
> is: '0' for write/tx and '1' for read/rx channel. So I should be
> setting this to 1 like this?
>          dmas = <&axi_dma_0 1>;
>          dma-names = "axi_dma_0";
>
> But where does that field get used?

This got broken in "dmaengine: xilinx_dma: In dma channel probe fix node 
order dependency" 
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14ccf0aab46e1888e2f45b6e995c621c70b32651>. 
Before if there was only one channel that channel was always at index 0. 
Regardless of whether the channel was RX or TX. But after that change 
the RX channel is always at offset 1, regardless of whether the DMA has 
one or two channels. This is a breakage in ABI.

If you have the choice I'd recommend to not use the Xilinx DMA, it gets 
broken pretty much every other release.

- Lars



