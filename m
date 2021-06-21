Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4093AE978
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFUM6Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 08:58:24 -0400
Received: from m12-17.163.com ([220.181.12.17]:57941 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhFUM6X (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Jun 2021 08:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=RhEua
        8GR26tvHREEceUWP4wYPENJiGTDNytWgn9r17Q=; b=NZx5Q/R1GsGvehJ0EG7Ow
        RiwmL6IYx7uTs2x4P9QKW8fdFiyZBBd9BsoTtof21Qbu9VEOTvq6WlmCgeq9yCIM
        MpWLetNW+7Zb8TnZc1YvZcPURH9qKn/H6NB3yeVyhtx+Ga2I9CHvf1rywKJ18hmF
        vzVcSuTVtkN+QMfFfpCEAo=
Received: from localhost (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowAD30GhYjNBg8pE98w--.56118S2;
        Mon, 21 Jun 2021 20:55:53 +0800 (CST)
Date:   Mon, 21 Jun 2021 20:56:02 +0800
From:   Junlin Yang <angkery@163.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v1] dmaengine: mediatek: Return the correct errno code
Message-ID: <20210621205602.00003658.angkery@163.com>
In-Reply-To: <YNBN684ZiVdVb4eU@vkoul-mobl>
References: <20210621062048.1935-1-angkery@163.com>
        <YNBN684ZiVdVb4eU@vkoul-mobl>
Organization: yulong
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EcCowAD30GhYjNBg8pE98w--.56118S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1kGw1xXFy3uw4fJw47Arb_yoWxAwb_CF
        1Syry8Wr4DZw4vq3s8GFyrG34SyayYyrWvgFnrCFyDAry3CrWUJr9rCr1Fvw43Jrs7ury3
        uan0ka92qr1YyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0LID7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLBm4I1spa5dUdwAAsD
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 21 Jun 2021 13:59:31 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 21-06-21, 14:20, angkery wrote:
> > From: Junlin Yang <yangjunlin@yulong.com>
> > 
> > When devm_kzalloc failed, should return ENOMEM rather than ENODEV.
> > 
> > Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA
> > support") Signed-off-by: Junlin Yang <yangjunlin@yulong.com>  
> 
> Patch was sent by angkery <angkery@163.com> and signed off by Junlin
> Yang <yangjunlin@yulong.com>. I would need s-o-b by sender as well...
> 
> Thanks
> 

Due to the mailbox problem, I configured a sending mailbox, and now I
change the mailbox display name.

Thanks
--
Junlin Yang

