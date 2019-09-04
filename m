Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD298A7A80
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfIDE77 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 00:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfIDE76 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 00:59:58 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEE8207E0;
        Wed,  4 Sep 2019 04:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567573198;
        bh=caOcihlYyrWS+POv+MXF8ZbW/2HIEy/75fGVXPoQDsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8NVzEItHl8QLeR7aTaZCrzsZ5dhim3p04cVGT9L824+or+3w/nek10u2zcaRo2w6
         o5pnpcbcb4zysu2u9jiTl5G/7W3BdH6wfNX12IiHUGQH40iO47gXHpHT49642GZYlL
         tt5/OwizVnxOKWnC3kOI6P4AJ3D7dy8IWcMSoC/g=
Date:   Wed, 4 Sep 2019 10:28:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] IOAT: iop-adma.c: fix printk format warning
Message-ID: <20190904045850.GA2672@vkoul-mobl>
References: <138f82a9-08ad-2bb2-cfce-f3124ec502fc@infradead.org>
 <CAPcyv4hvPrkMhSKKWnqTs93=G7712j82jRw43tjoqJoqsZfzDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hvPrkMhSKKWnqTs93=G7712j82jRw43tjoqJoqsZfzDg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-08-19, 14:44, Dan Williams wrote:
> [ add Vinod and dmaengine ]
> 
> On Fri, Aug 30, 2019 at 2:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix printk format warning in iop-adma.c (seen on x86_64) by using
> > %pad:
> >
> > ../drivers/dma/iop-adma.c:118:12: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘dma_addr_t {aka long long unsigned int}’ [-Wformat=]

This doesnt apply for me. Please rebase on next and resend with Dan's
ack

-- 
~Vinod
