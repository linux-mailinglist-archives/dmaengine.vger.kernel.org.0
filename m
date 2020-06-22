Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB12203CA4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgFVQeN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 12:34:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbgFVQeN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 12:34:13 -0400
Received: from oxbsgw00.schlund.de ([172.19.248.10]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M89TB-1jjokx3rQB-005KpV; Mon, 22 Jun 2020 18:34:04 +0200
Date:   Mon, 22 Jun 2020 18:34:04 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1835214773.354594.1592843644540@mailbusiness.ionos.de>
In-Reply-To: <20200622155440.GM2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:QPaxUzy3VgmMe1bkzn55F0lHImGPzZK0TV3+DEwcnT35cMd6Od2
 XfLr4gqZfNKDJRYl9f3Y+Pifwmxy/EVNfkL8eig3azDvBjnd2pamyaA6wUqtRGYGExml8Ub
 9WRIgEYzgjvBge6SFAxrf7agXv//emdrWNHoRJnOwbtbJUTbrwAiWJmH0ItPFy+g0KfVEBU
 TqP/77l1VBUGe0qzZChkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b5xqvHzMs/k=:i6nEZ8RPbzMHTnU9YvZxfP
 IDauMXlFFR7GiHsKDfrOPSMgqABTt3lQ8HHCeYqDKmFaDPTIxUNZldeBeIbloTGbBkGga773f
 xC5g9+A80FBq6I/1pWCvDd67vdZqD2leVrgNovrmrfI2ynj7iGMZpy2tf4n5LlnFoHaH7kViu
 86seSaDjNFE2LqTiFUmqJBMYpOTTSn6oZCy3OPboH8eDMN+J1WKI19D8qglpThmD2dnEfFDWP
 kEUjT8RqB6MAU6fNqz5KiODpgoFzf3Fw63JTPpk3Lq+v6qmdqGsE7YI+bn6CI97iaM3SXi6nc
 4nPHR3MJGrDp+5ORyIEku4/0TEwudRb213d/iR2bogv4NNbmu5Jirzjtbel+intiDRan8nzos
 94LFExz2kKSf1PCeHSQkYTGityoS/hn0ACiM6gmXRpAyNiv5w12j3Fjd4aQ/XRf5lLRPLWA0/
 9O2Sfxf1D3GMc0xTcdRsXXSSKMUWydUIN1YXV73L6qxCnEkx3o75MPBlW7YaJiNuElb8fL6iu
 WNmXz42YIpw74Zsh8EsI2+9GfjalZrGf/66VBn8cDJrOPQCHEhfqBE77dt4yZG8DT6RGiMqS5
 idH9hlHTaqufg2RxF8iArc5jP/5pHhfQ2iftRaFBapPPxaBfeMDZe8pv3UebEUpOtbQ8IF3lY
 xZvbA8Kl5aQtKX1aRXjXp5jM2QUsJoZ4Hw/NnanpM+3UpRs10rkriZ6z8piMjWmVembH471y1
 Ye24Nn5EIazYH+cmg6HVoLauZLV88jGu4xZU+o5XeGxqPAOQNxEZNBk8N9lzAPoNDLtltsK8m
 Qbq6vc7FVEWPo85Ju2FFMIBt1Ek4VAlAFS/o4uJ77g9IerZTJk=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 22 June 2020 at 17:54 Vinod Koul <vkoul@kernel.org> wrote:
> 
> 
> On 22-06-20, 14:01, Thomas Ruf wrote:
> > > On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
> > > 
> > > On 21-06-20, 22:36, Federico Vaga wrote:
> > > > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> > > > > On 19-06-20, 16:31, Dave Jiang wrote:
> > > > > > 
> > > > > > 
> > > > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > is there the possibility of using a DMA engine channel from userspace?
> > > > > > >
> > > > > > > Something like:
> > > > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> > > > > > > - read() or write() to trigger the transfer
> > > > > > >
> > > > > > 
> > > > > > I may have supposedly promised Vinod to look into possibly providing
> > > > > > something like this in the future. But I have not gotten around to do that
> > > > > > yet. Currently, no such support.
> > > > > 
> > > > > And I do still have serious reservations about this topic :) Opening up
> > > > > userspace access to DMA does not sound very great from security point of
> > > > > view.
> > > > 
> > > > I was thinking about a dedicated module, and not something that the DMA engine
> > > > offers directly. You load the module only if you need it (like the test module)
> > > 
> > > But loading that module would expose dma to userspace. 
> > > > 
> > > > > Federico, what use case do you have in mind?
> > > > 
> > > > Userspace drivers
> > > 
> > > more the reason not do do so, why cant a kernel driver be added for your
> > > usage?
> > 
> > by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
> > now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(
> > 
> > just let me introduce myself and the project:
> > - coding in C since '91
> > - coding in C++ since '98
> > - a lot of stuff not relevant for this ;-)
> > - working as a freelancer since Nov '19
> > - implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
> > - last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
> > - subscribed to dmaengine on friday, saw the start of this discussion on saturday
> > - talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future
> 
> DMA_SG was removed as it had no users, if we have a user (in-kernel) we
> can certainly revert that removal patch.

yeah, already understood that.

> > 
> > here the struct for the ioctl:
> > 
> > typedef struct {
> >   unsigned int struct_size;
> >   const void *src_user_ptr;
> >   void *dst_user_ptr;
> >   unsigned long length;
> >   unsigned int timeout_in_ms;
> > } dma_sg_proxy_arg_t;
> 
> Again, am not convinced opening DMA to userspace like this is a great
> idea. Why not have Xilinx camera driver invoke the dmaengine and do
> DMA_SG ?

In our case we have several camera pipelines, in some cases uncached memory is okay (e. g. image goes directly to display framebuffer), in some cases not because we need to process the images on cpu or gpu and we for that need to copy to oridinary user memoy first. This seems easier to do by decoupling the driver code.
And one more thing: in case we engage the dma memcpy we want to copy to target memory which is prepared for IPC because we want to share these images with another process. The v4l2 interface did not look to be made for such cases but is possible by this "memcpy" approach.

Best regards,
Thomas
