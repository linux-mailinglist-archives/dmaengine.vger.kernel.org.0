Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7F4A6D8
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfFRQ15 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 12:27:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfFRQ15 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 12:27:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E56C6028D; Tue, 18 Jun 2019 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560875276;
        bh=AZGWFNkJxbGoXKKAkuxIYIe9MRoN3IT0Racj+5YQtMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QSmzxcCLou2m8qnIksmWjuepW2C7BCTNiW75mvNWBrHRmttDyr3aFQ1T5yyEuJQ6K
         joROgUtcscmgAhk5lP6gUL/6IZZ2b9VhfBdp7X6s/cLCY4RoEgjKT3jpon85VTXsdF
         U88nXf+z4KNrw8wB/Zdc1A5/mAs9lQQ/xnAcKwjs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.5] (unknown [122.164.143.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F220602BC;
        Tue, 18 Jun 2019 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560875275;
        bh=AZGWFNkJxbGoXKKAkuxIYIe9MRoN3IT0Racj+5YQtMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NDg+fW5EB2QgBv/KAQ4L5YoyOcCI/KP0uNrDznsvlpPaepCMo+H3dyqeK9wKTIp9s
         Gqj6v0qEGQZNkcUPb4tJTbRMndmC1vtTvujQRiyc+55REkPu8v9IYs+iG55nx8zW2X
         ELuYbvW6D4ck6bv+3+YkCsgt9plraM5Gis3Ble5E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F220602BC
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
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <a50066ac-be85-6706-e7f3-f1069fd0dd0b@codeaurora.org>
Date:   Tue, 18 Jun 2019 21:57:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <544851f6-58b8-2506-01ce-5c4d1f93fb3c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/18/2019 8:42 PM, Srinivas Kandagatla wrote:
> 
> 
> On 18/06/2019 15:56, Sricharan R wrote:
>>    So MAX_DESCRIPTORS is used in driver for masking head/tail pointers.
>>    That's why we have to pass MAX_DESCRIPTORS + 1 so that it works
>>    when the Macros does a size - 1
> Isn't that incorrect to do that, pretending to have more descriptors than we actually have?
> 

 The Macro's expect that buffer size is power of 2. So we are infact passing the actual correct
 size ( MAX_DESCRIPTORS + 1 = 4096)

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
