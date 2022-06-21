Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A62B55344F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351199AbiFUOQr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiFUOQr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 10:16:47 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 07:16:46 PDT
Received: from smtp102.ord1d.emailsrvr.com (smtp102.ord1d.emailsrvr.com [184.106.54.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E97205F5
        for <dmaengine@vger.kernel.org>; Tue, 21 Jun 2022 07:16:46 -0700 (PDT)
X-Auth-ID: markh@compro.net
Received: by smtp5.relay.ord1d.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 655E9A0180;
        Tue, 21 Jun 2022 10:07:00 -0400 (EDT)
Message-ID: <9de341bc-fe8d-1820-187a-46455e4b9bf2@compro.net>
Date:   Tue, 21 Jun 2022 10:06:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: markh@compro.net
Subject: Re: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
References: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
 <20220621134837.GA8025@lst.de>
From:   Mark Hounschell <markh@compro.net>
Organization: Compro Computer Svcs.
In-Reply-To: <20220621134837.GA8025@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: dfda2e63-76f1-49d1-aa3e-d56b4b2d24c6-1-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/21/22 09:48, Christoph Hellwig wrote:
> On Tue, Jun 21, 2022 at 09:43:18AM -0400, Mark Hounschell wrote:
>> Revert that commit and all works like normal. This commit breaks user land.
> 
> No.  We had that discussion before.  It exposeѕ how broken your out of
> tree driver is, which you don't bother to fix despite Robin even taking
> the pains to explain you how.

No, this is not the original issue and we never actually had a 
discussion. That original issue was about using Set/ClearPageReserved. 
You nor Robin even tried to explain why it was wrong to use it. It was 
never an issue in previous kernels. Why now? In any case I have removed 
that code. This is what happens now.

What is it you think I am doing wrong. Except for using 
Set/ClearPageReserved you have not explained anything to me.

Mark
