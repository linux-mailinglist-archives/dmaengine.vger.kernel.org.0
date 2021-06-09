Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C43A1C98
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhFISTq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 14:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFISTq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Jun 2021 14:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0F6C613D0;
        Wed,  9 Jun 2021 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623262671;
        bh=M+chnIa2xloH92XI9Nx/nAijFq/W9ipsvhogMe7juYA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cXPFs22Kf+1RxJyNulN5Fbkpwa+gP8Lcli0VNpLCNDzfVQ/7bkKKy0N+qR1swxagV
         s5zIXu/zNtf0yGq0nnhI9fHG1n7jK/+RpdvGZiz6Z6KuhZIanto0jN813RujUk3wy/
         fxoa8lzKDUmpIlsktrmp4Q5r9So/bqO6CZtLZerFQPXvKGgXgzT+MfzALZewi+0KlN
         pFnFkyTPRGBzyuJsX9Hr5dbCDUm9Oi0+KAfWXEyKJsQ581XRFvdeR+Iw1xIhTmAFmT
         Oi8/uRf+Acc7sFTfLqUgUI0wzGoGFpqi/rGnsntNd7uABOwrKQXE+lGuZumeu5NC5C
         7tVYCQiOM/Fhg==
Subject: Re: [PATCH v2] dmaengine: xilinx: dpdma: fix kernel-doc
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     hyun.kwon@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1623222893-123227-1-git-send-email-yang.lee@linux.alibaba.com>
 <CAKwvOdn0WP53-qNLH8ce7R5meudaXbnvxyAn58p_NOzZhxMGCQ@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <012b541c-7519-3389-7998-5185df7963ee@kernel.org>
Date:   Wed, 9 Jun 2021 11:17:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn0WP53-qNLH8ce7R5meudaXbnvxyAn58p_NOzZhxMGCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/9/2021 11:03 AM, Nick Desaulniers wrote:
> On Wed, Jun 9, 2021 at 12:15 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>>
>> Fix function name in xilinx/xilinx_dpdma.c comment to remove
>> a warning found by kernel-doc.
>>
>> drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
>> xilinx_dpdma_chan_no_ostand(). Prototype was for
>> xilinx_dpdma_chan_notify_no_ostand() instead.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> I'm ok with leaving my reviewed by on _this_ patch because it's so simple but...
> 
> In general, when sending a follow up version of a patch, it's _not_ ok
> to add a reviewed by tag when a reviewer has not explicitly responded
> with "Reviewed-by: ...".  That provides a false sense that a patch has
> been thoroughly reviewed.  Responding to a patch does not constitute a
> "Reviewed-by:" tag.
> 
> And I might be fine with _this_ patch, but that says nothing about
> Nathan, whom you've also falsely attributed a reviewed by tag here.
> 
> For such a trivial patch, it's not a big deal, but in the future
> please do not do that again.  It's ok to send v2, v3, etc, but wait
> for reviewers to explicitly state such reviewed by tag. The maintainer
> will collect those responses (and can be done so in an automated
> fashion via a tool like b4 (https://pypi.org/project/b4/)) when
> applying patches.

+1 with all that was said above. Tags should be explicitly given, except 
for maybe the "Reported-by" and "Suggested-by" tags if the report or 
suggestion was done in the public forum but it is still polite to ask if 
it is okay to add.

For the record, my tag can remain:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

>> ---
>>
>> Change in v2:
>> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
>> https://lore.kernel.org/patchwork/patch/1442639/
>>
>>   drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
>> index 70b29bd..0c8739a 100644
>> --- a/drivers/dma/xilinx/xilinx_dpdma.c
>> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
>> @@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
>>   }
>>
>>   /**
>> - * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
>> + * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
>>    * @chan: DPDMA channel
>>    *
>>    * Notify waiters for no outstanding event, so waiters can stop the channel
>> --
>> 1.8.3.1
>>
> 
> 
