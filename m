Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4700612A590
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2019 03:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLYCZp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Dec 2019 21:25:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60070 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLYCZp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Dec 2019 21:25:45 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ijwMn-0002rd-Gt; Tue, 24 Dec 2019 19:25:42 -0700
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>
References: <20191216190120.21374-1-logang@deltatee.com>
 <20191224045004.GI2536@vkoul-mobl>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aba86729-b9e7-dc7e-0860-05c95439a673@deltatee.com>
Date:   Tue, 24 Dec 2019 19:25:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191224045004.GI2536@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: kchow@gigaio.com, dave.jiang@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH 0/5] Support hot-unbind in IOAT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-12-23 9:50 p.m., Vinod Koul wrote:
> On 16-12-19, 12:01, Logan Gunthorpe wrote:
>> Hey,
>>
>> This patchset creates some common infrastructure which I will use in the
>> next version of the PLX driver. It adds a reference count to the
>> dma_device struct which is taken and released every time a channel
>> is allocated or freed. A call back is used to allow the driver to
>> free the underlying memory and do any final cleanup.
>>
>> For a use-case, I've adjusted the ioat driver to properly support
>> hot-unbind. The driver was already pretty close as it already had
>> a shutdown state; so it mostly only required freeing the memory
>> correctly and calling ioat_shutdown at the correct time.
> 
> I didnt find anything else (apart from one change i pointed), so I have
> applied this and will fix the comment. No point in delaying this

Great, thanks!

Logan
