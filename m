Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54220389B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFVOBi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 10:01:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgFVOBh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 10:01:37 -0400
Received: from oxbsgw03.schlund.de ([172.19.248.4]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrhLw-1j1t691Xc4-00neo3; Mon, 22 Jun 2020 16:01:25 +0200
Date:   Mon, 22 Jun 2020 16:01:24 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <501058700.545185.1592834484568@mailbusiness.ionos.de>
In-Reply-To: <CAFLxGvyNazbyBpySuNA6SU-8tcvqYWKHsAHuhTLsofR=VoiEwQ@mail.gmail.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <CAFLxGvyNazbyBpySuNA6SU-8tcvqYWKHsAHuhTLsofR=VoiEwQ@mail.gmail.com>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:vUZbxgo/OouGbsShJsc/bQjeMXYbOVzbSB/wP1nZxShgucZr6bZ
 2AOEe4HJkldFD7CXfBjfJFyZ/JGuDL5HGVwhDSjKdPhSft9odUjIHmW1Ve5M3t4wA250NKD
 0of89ztTKi1aCYli10qqAZTA9H8hQ8pOboNvMgJINUeibRo4iAnH+zDG/4pOhi9mMhCKDLT
 CMhdIQKwqXbYoqKd/b2aA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zUA8ET7KTVw=:r4loVE6nt/IOlN/lgBbA4K
 bCtT3/AfVymyJQDSvzItt6gqdNlSnHr+4l3bnVpPFZdpblsLj4xb0rQqbiRiJjgfIb94/pL9S
 DB5nHWi+AQQU84OSXqAwkmii7l9axUa7dPyfpHOwfDdT09+qLej3ntdPj5eXHzRXMgB+zI5Y5
 3soG6ETaRbW05NzOm84znyzerWYkAkj8YtQNJnBn+VrLqBPNTqgjFmfi3mzs4+DcpPvEU2bkC
 aSKvbRWSwbRQQC35eUfrDX4/NtLTf3xHO8GQD2jgARhvPPHl9aprf8CuRf/9HQAssZUvz0hcB
 KnD5utRKWB7AnBrMWHCEub8mSysgTu6WCS12ZaFL6DWr5T3X2xDRaQzvQFunjyqLBWPDZ6zmu
 dr4BntfS9x0EVeGwodMsn3ySn21YELlidDc4W8S/xkDtW5grJBTW9yqKgjDrWTefdCrP+W2o6
 icGI2UF+eNMHm7aON1aU0VkITwOKv9lYEC4eHFMxTNymPjwrUb+oT+OiazPoMtr9ZQltc3yVL
 y1LJj9LD3VWtD/9jb/9UC7uD1ox1ny2nm9POXLEH4uxL4bVQgixb9GKRGljJL8TU1U6f/KCM6
 mSYc1IbLle7CsUl1Obbr9Z5GNWzx9SwQ6vo7csy+K0OvnZ6pQfV+woD0m05AD0YaE3t29pz9K
 9BW+3gb988wmRzbmfxwTRCrR1PidyFvI92KBdrLMYkwldleWL4ZTiKYIOmKO314HWtnd1N8rf
 hZZBq1wBwhP6u4YVrPgGN6I4o3ZqHXOTS8Mh5QFYZdpcp23NghsqdoWFeQOG0nGq3vBBaLiFh
 w0PEQfZK99k/3auzGsMDXuRhpwgCkEQASWlCjCrBBr8qq6Kv5o=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On 22 June 2020 at 14:27 Richard Weinberger <richard.weinberger@gmail.com> wrote:
> 
> 
> On Mon, Jun 22, 2020 at 2:02 PM Thomas Ruf <freelancer@rufusul.de> wrote:
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
> How do you preserve bounds? This is the main reason why vfio requires an iommu.

Depends where the pointer "points to", i can detect:
- virtually allocated user memory, the generated scatterlist is slit on page bounderies
- contiguous pyhsical memory, in our case allocated by v4l2 (based on a dma without SG support), the generated scallterlist has just one entry

sorry, i am not really familar with vfio :-(

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
> Is this on top of uio or a complete new subsystem?

Completely independent, just my own idea for a simple uapi.

Best regards,
Thomas
