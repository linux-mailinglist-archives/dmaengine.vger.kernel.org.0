Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE394C04A
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFSRuX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 13:50:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSRuW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 13:50:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 42C2C61AC9; Wed, 19 Jun 2019 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560966621;
        bh=LMt1J56vKqSJVlnxAZuLoOyLzA7CpdPN6uUwWKgXfHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GlyIVG7drRcJiv+gborhnzd+l6bnTY9GfLUNaM5tIe+QYefb4DD3bW1SMIsDoHK94
         bEsoWyQjhRuwhAIm1UeQA0ACQcr3O+CzF2nQdCNyXKhrc9mQG5yYRWm1hHMk5gDUcE
         W7F2xRq1/gAhcvAdayk0p8FYhEfv4lCqvzZ3WV5U=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.5] (unknown [106.201.161.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72A2F61834;
        Wed, 19 Jun 2019 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560966614;
        bh=LMt1J56vKqSJVlnxAZuLoOyLzA7CpdPN6uUwWKgXfHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DU3vJDkV6f/jqgh4q5TnCq4vrum7XCYu5FI4mdAL3UudQryrnhHNBCyQQUGXRG0jo
         dXwg93ubhVJEoSeiXZMF8Lw30OVthdcBFLfAr/uoQXzA/8/jMBq2qzFWdqeh63fvEa
         W7K6Hjh4FWvbXNKT0HgLZfHTHdgM7iI/3cRc46MI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72A2F61834
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
 <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
 <d84af3ad-5ba4-0f24-fd30-2fa20cf85658@linaro.org>
 <2d370a33-fa16-45ca-cf82-9d775349f806@codeaurora.org>
 <544851f6-58b8-2506-01ce-5c4d1f93fb3c@linaro.org>
 <a50066ac-be85-6706-e7f3-f1069fd0dd0b@codeaurora.org>
 <31574ef2-d675-bb36-08d1-18b756ebd29e@linaro.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <d86b1c3b-19bc-6c51-a364-c46ca019db1a@codeaurora.org>
Date:   Wed, 19 Jun 2019 23:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <31574ef2-d675-bb36-08d1-18b756ebd29e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Srini,

On 6/18/2019 10:20 PM, Srinivas Kandagatla wrote:
> 
> 
> On 18/06/2019 17:27, Sricharan R wrote:
>>   The Macro's expect that buffer size is power of 2. So we are infact passing the actual correct
>>   size ( MAX_DESCRIPTORS + 1 = 4096)
> This will make the circular buffer macros happy but question is that do we actually have that many descriptor buffers?
> 
> This is what is in the driver:
> 
> #define BAM_DESC_FIFO_SIZE    SZ_32K
> #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
> #define BAM_FIFO_SIZE    (SZ_32K - 8)
> 
> Wouldn't having MAX_DESCRIPTORS + 1 = 4096  lead to overflow the actual descriptor memory size of (SZ_32K - 8) ?
> 

Right, but the CIRC_SPACE macro assumes there is 1 space less than the actual size.
That said, agree there is an issue on the boundary. I will also do some testing tomorrow
on this and get back.

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
