Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1C20364D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFVMBV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 08:01:21 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgFVMBV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jun 2020 08:01:21 -0400
Received: from oxbsgw05.schlund.de ([172.19.248.8]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1YpJ-1jqMCo0ArD-0033vK; Mon, 22 Jun 2020 14:01:13 +0200
Date:   Mon, 22 Jun 2020 14:01:12 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <419762761.402939.1592827272368@mailbusiness.ionos.de>
In-Reply-To: <20200622044733.GB2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:vqrA2vYCx1uDKgThEtFbc6VetceM3TsFmqGIYceaPIpVSI5rnwV
 jzWDzPXiDwgkQcxT8pv7GNOBsNYxsO/aTbTl5MNduvTJdzN9E6ySMEGq9oulNx6DLewTTcv
 IbU4Es9KWA2nfkMVzCo7BgUNM53vUPbRVBWn7phzqGV5XbJ5InGXp3ohszv7FweaB3T5dOO
 f+WHDbV6ksaSSCy2OFiOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lTMpz7zt9FY=:e3CrO0pQcDG1ENDm9Agbim
 LwkiEWdidKgMtWnZDC8zwqgwno/NN/u8G3gEE20lZ5xSADOOVvtmlERnTktRfO5tyTYSmh8n7
 Ci/bOL3IPq6DsCeABXLzgZmgztWYL4eweH5DAooRRW6OsJ3wRuaeoEUfkYW1ui1A/GTLBZODp
 Jx7u/j22nPeBWtglUP1HIpR8+a4EFa1/XNsoaH08duAM9TJPdMbuNRuHRKlMHK6zydC7pSBC+
 rZQlQoCaBAmW3ssdjmE19Wm/34T83NC2B5klDwiyectWnyd8ePvTMi4TOxiEDo3QWopZB0P7j
 nhxRXY51XylKbKU2/97HJcNZFszNsZiX8Sf4asmlAY7eZLbAms/DPibtm/MnK4dHiacP3uPDY
 T28T6jQI3bL6c1fK40b732tQVaKVPgNIW2erI6FQb9jYN/EdAu1LhEej5ZjtXOHah7nYECNnH
 y/w0sJOyHKExCrLGfoa8cnYEsLRhVpDx5WwMG9N64aAjE8X3WUFgIABV41qfsPiHLeNSvLNs0
 nln7TCGJaBomeqtuvUVU4DO4TRGzRBvrYK1JGwyv0ia21roRhM0AzEB9x0NVgklAy2PkOBTsz
 Pz5IDdqG4rTp1Ug4UImXvTwN9UL4J/7JB7YHryyuK30/yliYD9vNqnqPDE/aRFGoVjt1BJneS
 CRCHRXwb5aVF0B1w9JnBF49oiuc2wLveoUu15sNWEPzWAl86c8vN1a8SpZP2p8/ZfE/b+zgBt
 4xbMXbOpOjgyQobS/RxjY8tXSBdJ5PY1jyz99Se/+HbRnUsgKQ3XYUZMm6bCa7P7Rr4xV/eQ+
 HM4o8+RoiCUpmz+eX6bc97AQn4xtRY4jyu2Htz2tlcQUpPa7zM=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
> 
> On 21-06-20, 22:36, Federico Vaga wrote:
> > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> > > On 19-06-20, 16:31, Dave Jiang wrote:
> > > > 
> > > > 
> > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > > > Hello,
> > > > >
> > > > > is there the possibility of using a DMA engine channel from userspace?
> > > > >
> > > > > Something like:
> > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> > > > > - read() or write() to trigger the transfer
> > > > >
> > > > 
> > > > I may have supposedly promised Vinod to look into possibly providing
> > > > something like this in the future. But I have not gotten around to do that
> > > > yet. Currently, no such support.
> > > 
> > > And I do still have serious reservations about this topic :) Opening up
> > > userspace access to DMA does not sound very great from security point of
> > > view.
> > 
> > I was thinking about a dedicated module, and not something that the DMA engine
> > offers directly. You load the module only if you need it (like the test module)
> 
> But loading that module would expose dma to userspace. 
> > 
> > > Federico, what use case do you have in mind?
> > 
> > Userspace drivers
> 
> more the reason not do do so, why cant a kernel driver be added for your
> usage?

by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(

just let me introduce myself and the project:
- coding in C since '91
- coding in C++ since '98
- a lot of stuff not relevant for this ;-)
- working as a freelancer since Nov '19
- implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
- last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
- subscribed to dmaengine on friday, saw the start of this discussion on saturday
- talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future

here the struct for the ioctl:

typedef struct {
  unsigned int struct_size;
  const void *src_user_ptr;
  void *dst_user_ptr;
  unsigned long length;
  unsigned int timeout_in_ms;
} dma_sg_proxy_arg_t;

best regards,
Thomas
