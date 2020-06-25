Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B9209B1C
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2020 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbgFYILj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jun 2020 04:11:39 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgFYILi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jun 2020 04:11:38 -0400
Received: from oxbsgw03.schlund.de ([172.19.248.4]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq33i-1j2gDL1V58-00n5Wr; Thu, 25 Jun 2020 10:11:29 +0200
Date:   Thu, 25 Jun 2020 10:11:28 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Message-ID: <84270660.632865.1593072688966@mailbusiness.ionos.de>
In-Reply-To: <581f1761-e582-c770-169a-ee3374baf25c@intel.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <581f1761-e582-c770-169a-ee3374baf25c@intel.com>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:HRzZ5peGV0s505yrNUmy14wLZnN+vfwR82ESXZO9Xn8IosI2Nhb
 tS27+7lVHfyqGmG1X4PlBHEF7VEIRakVZt++yNkg3elhFmdOok/ghZSucGsZ7cEc/CXZi68
 yrGkoR1jdBuNeaYRi52VBN3HGODudojDMPoitdQSngxITKvUATEWz0FTY1iNbmfQfj+sNhx
 Ph+4shDH6JvSWaA/2Ixdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wc8ojQSYAcE=:agm+E9A9YdkiLYUwIfZEsU
 P5e+UVwhMxR2FkAyYvkjGEVfNUIxDvaAqnhIM/rd8I3pYLWL/WrQdsgFTh4nrKnx8L5p5M8Ma
 tTp+qSxmmRaFACz134/c0gcsXWDpOOw/ejBiqQAdAWcYkn08CwSN/UPeGNkOYeZ8F7sR+Ut5J
 hGKBX6n9xT9T0JJfptJQpc5gsMlImiW1ixgNsu90X/M90uW/qVgiKn/yJl9NgNk6kqGzcDnVX
 pobN2gS9pL/pDgbjYrDoQIO6ZCBtu466N2PUvYKL/sfgqNevpEX71LNJ+t8C7EyAamCB/4d+p
 o+KCthWANWuASXEOTzG17H3YNwPG+O4de+iCepWXFF2vWMYnZk0HKhFecMC6qhE4AyE9vrsHN
 Wi6isW8yJqmBYLFPaoi4tjhhwY1r7DfBbQ7fklCJl7g5jgk2wwwwVY5SLhIuW7MhdGgKO4RyX
 LCZZpRms2z9S3tPY6w0D5/hXxZ4nERr8091PUGhjLc1RcKUJtypMI+4hq5QGWUagHPBVJfI1f
 eadrp2Y+YQNTXWLz3yQYSR+5EgfU/AHffU8XkJTif4YtANAToU/8douLYqgbnxk1adSySKadb
 k43cJykTNmWJ5Dnd9S8219J8NsuK2fX4ciTeRNY24bm2kZMnAaBVq/YYRQwz/2UQxr9enluZ2
 e8wXzVRi/luspXO2u+1xdBUa1J2B+7Kz12nVhccnXGa92q7Ou7YMq/+2HS/fO6OuTac5xvKtM
 yrEYVgeDU6BvYaYONSBb8mxPkIEfoQcDfWxD0IVipnhtaOju+zCtrJXPFNNPKlEWjARLv7BC1
 hKjo1LZjZv4LrnnXSMEbztwgrQyR4Rjxbb0eUr7iVDjyAtOnFE=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 25 June 2020 at 02:42 Dave Jiang <dave.jiang@intel.com> wrote:
> 
> 
> 
> 
> On 6/21/2020 12:24 AM, Vinod Koul wrote:
> > On 19-06-20, 16:31, Dave Jiang wrote:
> >>
> >>
> >> On 6/19/2020 3:47 PM, Federico Vaga wrote:
> >>> Hello,
> >>>
> >>> is there the possibility of using a DMA engine channel from userspace?
> >>>
> >>> Something like:
> >>> - configure DMA using ioctl() (or whatever configuration mechanism)
> >>> - read() or write() to trigger the transfer
> >>>
> >>
> >> I may have supposedly promised Vinod to look into possibly providing
> >> something like this in the future. But I have not gotten around to do that
> >> yet. Currently, no such support.
> > 
> > And I do still have serious reservations about this topic :) Opening up
> > userspace access to DMA does not sound very great from security point of
> > view.
> 
> What about doing it with DMA engine that supports PASID? That way the user can 
> really only trash its own address space and kernel is protected.

Sounds interesting! Not sure if this is really needed in that case...
I have already implemented checks of vm_area_struct for contiguous memory or even do a get_user_pages_fast for user memory to pin it (hope that is the correct term here). Of course i have to do that for every involved page.
But i will do some checks if my code is really suitable to avoid misusage.

Best regards,
Thomas
