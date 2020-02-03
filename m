Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90241511C4
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCV0c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 16:26:32 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40845 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgBCV0b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 16:26:31 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1iyjEh-004A3s-RK>; Mon, 03 Feb 2020 22:26:27 +0100
Received: from p508832b6.dip0.t-ipconnect.de ([80.136.50.182] helo=[192.168.46.51])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1iyjEh-001uWS-EQ>; Mon, 03 Feb 2020 22:26:27 +0100
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <00734e40-da0b-9d7f-20bc-ce1f9658dcd3@physik.fu-berlin.de>
Date:   Mon, 3 Feb 2020 22:26:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: 80.136.50.182
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert!

On 2/3/20 9:34 PM, Geert Uytterhoeven wrote:
> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>
>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>> for classical SuperH hardware. It was never merged, unfortunately :(.
> 
> True.

Would it be possible to keep DMA support if device tree support was
added for SuperH? I think Rich eventually wanted to merge the patches,
there were just some minor issues with them.

It would be great if we could still get them merged. I would be happy
to help with the testing.

>>> Anyone who cares for DMA on SuperH?
>>
>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>> essential hardware features?
> 
> It may make a few things slower.
> 
> Does any of your SuperH boards use DMA?
> Anything interesting in /proc or /sys w.r.t. DMA?

I have:

root@tirpitz:/sys> find . -iname "*dma*"
./bus/dma
./bus/dma/devices/dma0
./bus/dma/devices/dma1
./bus/dma/devices/dma2
./bus/dma/devices/dma3
./bus/dma/devices/dma4
./bus/dma/devices/dma5
./bus/dma/devices/dma6
./bus/dma/devices/dma7
./bus/dma/devices/dma8
./bus/dma/devices/dma9
./bus/dma/devices/dma10
./bus/dma/devices/dma11
./bus/platform/devices/sh_dmac
./bus/platform/devices/sh-dma-engine.0
./bus/platform/devices/sh-dma-engine.1
./devices/pci0000:00/0000:00:00.0/consistent_dma_mask_bits
./devices/pci0000:00/0000:00:00.0/dma_mask_bits
./devices/pci0000:00/0000:00:01.0/ata1/host0/scsi_host/host0/unchecked_isa_dma
./devices/pci0000:00/0000:00:01.0/ata1/link1/dev1.0/ata_device/dev1.0/dma_mode
./devices/pci0000:00/0000:00:01.0/ata2/host1/scsi_host/host1/unchecked_isa_dma
./devices/pci0000:00/0000:00:01.0/ata2/link2/dev2.0/ata_device/dev2.0/dma_mode
./devices/pci0000:00/0000:00:01.0/consistent_dma_mask_bits
./devices/pci0000:00/0000:00:01.0/dma_mask_bits
./devices/system/dma
./devices/system/dma/dma0
./devices/system/dma/dma1
./devices/system/dma/dma2
./devices/system/dma/dma3
./devices/system/dma/dma4
./devices/system/dma/dma5
./devices/system/dma/dma6
root@tirpitz:~> find /proc -iname "*dma*"
/proc/dma
/proc/irq/52/DMAC Address Error1
/proc/irq/33/DMAC Address Error0
/proc/sys/fs/nfs/idmap_cache_timeout
find: ‘/proc/5703’: No such file or directory
find: ‘/proc/5704’: No such file or directory
find: ‘/proc/5705’: No such file or directory
root@tirpitz:~> cat /proc/dma
root@tirpitz:~> find /sys -iname "*dma*"      
/sys/bus/dma
/sys/bus/dma/devices/dma0
/sys/bus/dma/devices/dma1
/sys/bus/dma/devices/dma2
/sys/bus/dma/devices/dma3
/sys/bus/dma/devices/dma4
/sys/bus/dma/devices/dma5
/sys/bus/dma/devices/dma6
/sys/bus/dma/devices/dma7
/sys/bus/dma/devices/dma8
/sys/bus/dma/devices/dma9
/sys/bus/dma/devices/dma10
/sys/bus/dma/devices/dma11
/sys/bus/platform/devices/sh_dmac
/sys/bus/platform/devices/sh-dma-engine.0
/sys/bus/platform/devices/sh-dma-engine.1
/sys/devices/pci0000:00/0000:00:00.0/consistent_dma_mask_bits
/sys/devices/pci0000:00/0000:00:00.0/dma_mask_bits
/sys/devices/pci0000:00/0000:00:01.0/ata1/host0/scsi_host/host0/unchecked_isa_dma
/sys/devices/pci0000:00/0000:00:01.0/ata1/link1/dev1.0/ata_device/dev1.0/dma_mode
/sys/devices/pci0000:00/0000:00:01.0/ata2/host1/scsi_host/host1/unchecked_isa_dma
/sys/devices/pci0000:00/0000:00:01.0/ata2/link2/dev2.0/ata_device/dev2.0/dma_mode
/sys/devices/pci0000:00/0000:00:01.0/consistent_dma_mask_bits
/sys/devices/pci0000:00/0000:00:01.0/dma_mask_bits
/sys/devices/system/dma
/sys/devices/system/dma/dma0
/sys/devices/system/dma/dma1
/sys/devices/system/dma/dma2
/sys/devices/system/dma/dma3
/sys/devices/system/dma/dma4
/sys/devices/system/dma/dma5
/sys/devices/system/dma/dma6
/sys/devices/system/dma/dma7
/sys/devices/system/dma/dma8
/sys/devices/system/dma/dma9
/sys/devices/system/dma/dma10
/sys/devices/system/dma/dma11
/sys/devices/virtual/misc/cpu_dma_latency
/sys/devices/platform/sh_dmac
/sys/devices/platform/sh_dmac/dma0
/sys/devices/platform/sh_dmac/dma1
/sys/devices/platform/sh_dmac/dma2
/sys/devices/platform/sh_dmac/dma3
/sys/devices/platform/sh_dmac/dma4
/sys/devices/platform/sh_dmac/dma5
/sys/devices/platform/sh_dmac/dma6
/sys/devices/platform/sh_dmac/dma7
/sys/devices/platform/sh_dmac/dma8
/sys/devices/platform/sh_dmac/dma9
/sys/devices/platform/sh_dmac/dma10
/sys/devices/platform/sh_dmac/dma11
/sys/devices/platform/r8a66597_hcd/usb1/1-1/1-1:1.0/host2/scsi_host/host2/unchecked_isa_dma
/sys/devices/platform/sh-dma-engine.0
/sys/devices/platform/sh-dma-engine.1
/sys/class/misc/cpu_dma_latency
/sys/module/nfs/parameters/nfs4_disable_idmapping
/sys/module/nfs/parameters/nfs_idmap_cache_timeout
/sys/module/libata/parameters/dma
/sys/module/libata/parameters/atapi_dmadir
root@tirpitz:~>

On my SH-7785LCR.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
