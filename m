Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA8553459
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiFUOTa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349027AbiFUOT3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 10:19:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22214140CD;
        Tue, 21 Jun 2022 07:19:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4474368AFE; Tue, 21 Jun 2022 16:19:25 +0200 (CEST)
Date:   Tue, 21 Jun 2022 16:19:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hounschell <markh@compro.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Message-ID: <20220621141924.GA8348@lst.de>
References: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net> <20220621134837.GA8025@lst.de> <9de341bc-fe8d-1820-187a-46455e4b9bf2@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9de341bc-fe8d-1820-187a-46455e4b9bf2@compro.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 21, 2022 at 10:06:59AM -0400, Mark Hounschell wrote:
> On 6/21/22 09:48, Christoph Hellwig wrote:
>> On Tue, Jun 21, 2022 at 09:43:18AM -0400, Mark Hounschell wrote:
>>> Revert that commit and all works like normal. This commit breaks user land.
>>
>> No.  We had that discussion before.  It exposeѕ how broken your out of
>> tree driver is, which you don't bother to fix despite Robin even taking
>> the pains to explain you how.
>
> No, this is not the original issue and we never actually had a discussion. 
> That original issue was about using Set/ClearPageReserved. You nor Robin 
> even tried to explain why it was wrong to use it. It was never an issue in 
> previous kernels. Why now? In any case I have removed that code. This is 
> what happens now.
>
> What is it you think I am doing wrong. Except for using 
> Set/ClearPageReserved you have not explained anything to me.

Which part of "you must not call virt_to_page on the result that is
very clearly stated in the documentation and has been explained to
you repeatly" is still not clear to you?

Which part of "if your of tree modules stops working, this does not
constitute userspace breakage" is not clear to you?

I'm done with this, please stop bothering me.
