Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A320700D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgFXJar (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 05:30:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbgFXJaq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 05:30:46 -0400
Received: from oxbsgw03.schlund.de ([172.19.248.4]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MA7X0-1jguBi1Qz4-00Bbjz; Wed, 24 Jun 2020 11:30:36 +0200
Date:   Wed, 24 Jun 2020 11:30:35 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2077253476.601371.1592991035969@mailbusiness.ionos.de>
In-Reply-To: <1835214773.354594.1592843644540@mailbusiness.ionos.de>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
 <1835214773.354594.1592843644540@mailbusiness.ionos.de>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:JkjbXB6gIjXfWDHn+zaE2EgMRkWzkoxUNZFoGem1EWo9Jk0UvLN
 nz1KSGrDEbmmEuVy4jD516504w4qAR+6Ld0pxsBJrF6us2/oyChcD+QWH7co+Fm1ygXhq3w
 ncW/Us9qaI2sTfEHiyjwfLaNlLZOuA9vMQe5UvGXd6mP/M98NMYijYKIOAaSg8R557NjLIX
 zWOeOsFuqG9aLvupjWOIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H4Cu/Gae8GU=:QRgYdJ56wIDVlNDJg1/hua
 1J5QhHWN8CLVGd6NKOSSDAN7YTt2zEgMC+b3Dbrz+nsHfRO13lRRrTE5bYmdW3I6adYIyIS8y
 LOogwO3axds+sqr/OllgiSnCHfKLKI9tCkECZ9o/h9VtLtS88obxdGBXsMP5saL9ik8mfjeIm
 mDO1akk0JBMdsxu7Q0SeeYRemCZVHqGY2CO3ArxsGxqd0D+MGu769WZXDNYyXxSzYM+djwEN0
 67rGEigJL74clXe2DoLYz5uc48GTBtIJ5K1/BowUhV/B5hppdzzGy2PXZ1Q8Tr55RHD2IzbPG
 lUvP3//QtuqazlpGna3xqRzW67u3BUuYD6CurhyoT0XOWXV7OdfB4bP9sPMB7nZSBEEJ3e1Br
 o7X29erl3KBGJJDZC9ZvHSjivv/TKIuguPEm/HzlYG8R6KLAObsNamQWmInhErAytHyxDgF9t
 qlhWjEJI8Gg96X5p1v7og5OZjL2ePrGb1d0F0puVNX9iupZrkSVviSUGauPKansENqdBBEMwS
 vAbb1d4xsjm/E5fZY7hdCNMtb+ULljPefOHS5AGDyveb59538j8gTlw3yXOsUoTSkwpiVvPbV
 P0PaYYz2BEFhpQgSmKUK09qMFhPS3trrJmTJQPwU9Y2X6ttr6Za7WpNuksLTqbtB1R803gvwN
 W7dvglY3iW2xyrYT6iDuUCz6ixq/MFfZhmTEKfY1J+ABScCKmZGGSRFeTYsH3oVNCzrHnvqFD
 K0g3iGb2AtoNTqyMqJWuWNJbRtaLzNDPjI+PTSaSqED49b1O0qI1U403pVyLx51JeJZNqnjxt
 8tJa48rSKmq9sy4cxe3SG/1fiijYIt8O+hA4HXzeMWJY+7rKQI=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 22 June 2020 at 18:34 Thomas Ruf <freelancer@rufusul.de> wrote:
> 
> 
> 
> > On 22 June 2020 at 17:54 Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > 
> > On 22-06-20, 14:01, Thomas Ruf wrote:
> > > > On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
> > > > 
> > > > On 21-06-20, 22:36, Federico Vaga wrote:
> > > > > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> > > > > > On 19-06-20, 16:31, Dave Jiang wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > is there the possibility of using a DMA engine channel from userspace?
> > > > > > > >
> > > > > > > > Something like:
> > > > > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> > > > > > > > - read() or write() to trigger the transfer
> > > > > > > >
> > > > > > > 
> > > > > > > I may have supposedly promised Vinod to look into possibly providing
> > > > > > > something like this in the future. But I have not gotten around to do that
> > > > > > > yet. Currently, no such support.
> > > > > > 
> > > > > > And I do still have serious reservations about this topic :) Opening up
> > > > > > userspace access to DMA does not sound very great from security point of
> > > > > > view.
> > > > > 
> > > > > I was thinking about a dedicated module, and not something that the DMA engine
> > > > > offers directly. You load the module only if you need it (like the test module)
> > > > 
> > > > But loading that module would expose dma to userspace. 
> > > > > 
> > > > > > Federico, what use case do you have in mind?
> > > > > 
> > > > > Userspace drivers
> > > > 
> > > > more the reason not do do so, why cant a kernel driver be added for your
> > > > usage?
> > > 
> > > by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
> > > now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(
> > > 
> > > just let me introduce myself and the project:
> > > - coding in C since '91
> > > - coding in C++ since '98
> > > - a lot of stuff not relevant for this ;-)
> > > - working as a freelancer since Nov '19
> > > - implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
> > > - last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
> > > - subscribed to dmaengine on friday, saw the start of this discussion on saturday
> > > - talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future
> > 
> > DMA_SG was removed as it had no users, if we have a user (in-kernel) we
> > can certainly revert that removal patch.
> 
> yeah, already understood that.
> 
> > > 
> > > here the struct for the ioctl:
> > > 
> > > typedef struct {
> > >   unsigned int struct_size;
> > >   const void *src_user_ptr;
> > >   void *dst_user_ptr;
> > >   unsigned long length;
> > >   unsigned int timeout_in_ms;
> > > } dma_sg_proxy_arg_t;
> > 
> > Again, am not convinced opening DMA to userspace like this is a great
> > idea. Why not have Xilinx camera driver invoke the dmaengine and do
> > DMA_SG ?
> 
> In our case we have several camera pipelines, in some cases uncached memory is okay (e. g. image goes directly to display framebuffer), in some cases not because we need to process the images on cpu or gpu and we for that need to copy to oridinary user memoy first. This seems easier to do by decoupling the driver code.
> And one more thing: in case we engage the dma memcpy we want to copy to target memory which is prepared for IPC because we want to share these images with another process. The v4l2 interface did not look to be made for such cases but is possible by this "memcpy" approach.

To make it short - i have two questions:
- what are the chances to revive DMA_SG?
- what are the chances to get my driver for memcpy like transfers from user space using DMA_SG upstream? ("dma-sg-proxy")

Best regards,
Thomas
