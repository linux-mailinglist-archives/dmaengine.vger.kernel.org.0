Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5762C2038B2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgFVODs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 10:03:48 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgFVODs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 10:03:48 -0400
Received: from oxbsgw03.schlund.de ([172.19.248.4]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnWx3-1j6aAT0ClJ-00jd9a; Mon, 22 Jun 2020 16:03:40 +0200
Date:   Mon, 22 Jun 2020 16:03:39 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1170180786.545332.1592834619871@mailbusiness.ionos.de>
In-Reply-To: <20200622123019.z3i2tjcfliwkbzkx@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622123019.z3i2tjcfliwkbzkx@cwe-513-vol689.cern.ch>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:31RXAG7PmVL1FE5xGz3AStAC9Xv0UuQ9JmV597Q0V535hVtCO15
 qFcMAQVxLBdvcojAEY/HAcXk2/v1LffyGmRKwOcMjDPxv1TNQItERQW5xNZJNThgVGyZQWP
 yqZ2n6Ep96mK1hedTPxmHWHVTQ5Ve3KtM03PkhCW2h1sD2Bqx13NeKtTMYcY3EfQncCLzVV
 0KxpIt0OGGtmlmBDcKKkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bI90LEGy+q8=:5xY2M9HbXHeSqe9cHrm3ZD
 uXuN4WQr/R09VjR8EpTnulAa1PhQ9WRfYGff67asf8X+x3EQzm5KLHqTeZuqtnumlgCju57fT
 Hhf6YMuQhzSlOe1xfNNopzZaBusM7lgHNeOk7vb0WjaOgpkq9oUq3dE3w2v0C9K4InZa6/WHj
 6MtAysRQCKXAJTb1aVu4D3kGyRmjicJ+BWuaKOUlAWB2VglvRSSibv1JoxnraxxmtMW0xSu8G
 Q/OvaNiRDWbz0JkPN9LflgbM+xqkjOQXb4XUGFDrIFSlsgQT0AV5xdh9DxhucVAzxtL0mKCnF
 tAWep70U97swA1d43NazLwv2Xv7mwboDRH2xuhg68+nq6iiSKtmOX0kksY+JepJaHKqhwZN52
 q+K3HolxE5uIrlc01jyWQqKQ731V4tWE7yE7BKt8NIy/QxGv5zhAfM/e2FewYOC4SJavB8VtM
 mGpnEKbH67SAtcJVEMpO45/9l0KWWkEXNWDXk652vTQvkC/7sZ6v5T1Q/yHOIjgE+XzrMqimq
 WSYLuP7oCy8PzNLk4yyAFPoyQY1MG8iYy2YIF3gR9IBcr37V2AIex5iChqsak4fQTj+se+twr
 p9P/BeobPtB/trAqd0LWmgMNtDqvM9yN1klSMz/ShsmzbNoEfsLTvVXjgsIFQcdpEDBw8R1rl
 yxB/2igy2/9NDZhNYOjw/PcydZBtVdz+WEEwyxXHstS5K7iiibzss65lRMTncLROEL3U17j4U
 0Np3CGf/dGxIDxgAGhgR4ksT77NDB2zgrRNn5SLXEum+zkvUcafKR7fy1T8e7ZL/1NVeCGxA+
 nZZiuSYIXtEt5358Xmu/kzIZ4fzi/BdfOdgRfSt9pZW7yl1+nI=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 22 June 2020 at 14:30 Federico Vaga <federico.vaga@cern.ch> wrote:
> 
> 
> On Mon, Jun 22, 2020 at 02:01:12PM +0200, Thomas Ruf wrote:
> >> On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
> >>
> >> On 21-06-20, 22:36, Federico Vaga wrote:
> >> > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> >> > > On 19-06-20, 16:31, Dave Jiang wrote:
> >> > > >
> >> > > >
> >> > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> >> > > > > Hello,
> >> > > > >
> >> > > > > is there the possibility of using a DMA engine channel from userspace?
> >> > > > >
> >> > > > > Something like:
> >> > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> >> > > > > - read() or write() to trigger the transfer
> >> > > > >
> >> > > >
> >> > > > I may have supposedly promised Vinod to look into possibly providing
> >> > > > something like this in the future. But I have not gotten around to do that
> >> > > > yet. Currently, no such support.
> >> > >
> >> > > And I do still have serious reservations about this topic :) Opening up
> >> > > userspace access to DMA does not sound very great from security point of
> >> > > view.
> >> >
> >> > I was thinking about a dedicated module, and not something that the DMA engine
> >> > offers directly. You load the module only if you need it (like the test module)
> >>
> >> But loading that module would expose dma to userspace.
> >> >
> >> > > Federico, what use case do you have in mind?
> >> >
> >> > Userspace drivers
> >>
> >> more the reason not do do so, why cant a kernel driver be added for your
> >> usage?
> >
> >by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
> >now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(
> 
> Not sure to get what you mean by "DMA_SG is gone". Can I have a reference?

here the link to the mailinglist when DMA_SG was removed:
https://www.spinics.net/lists/dmaengine/msg13778.html

> >just let me introduce myself and the project:
> >- coding in C since '91
> >- coding in C++ since '98
> >- a lot of stuff not relevant for this ;-)
> >- working as a freelancer since Nov '19
> >- implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
> >- last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
> >- subscribed to dmaengine on friday, saw the start of this discussion on saturday
> >- talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future
> >
> >here the struct for the ioctl:
> >
> >typedef struct {
> >  unsigned int struct_size;
> >  const void *src_user_ptr;
> >  void *dst_user_ptr;
> >  unsigned long length;
> >  unsigned int timeout_in_ms;
> >} dma_sg_proxy_arg_t;
> 
> Yes, roughly this is what I was thinking about

cool, i really hope i get my stuff upstream!

Best regards,
Thomas
