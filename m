Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CA4F9A35
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiDHQPy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiDHQPv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 12:15:51 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56EA377C1;
        Fri,  8 Apr 2022 09:13:38 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Apr 2022 01:13:37 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 2F7262058443;
        Sat,  9 Apr 2022 01:13:37 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Sat, 9 Apr 2022 01:13:37 +0900
Received: from [10.212.182.227] (unknown [10.212.182.227])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 386EBB62B7;
        Sat,  9 Apr 2022 01:13:36 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: dma: uniphier: Use unevaluatedProperties
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1649317447-20996-1-git-send-email-hayashi.kunihiko@socionext.com>
 <Yk80eFKwDVnU67p/@robh.at.kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f350b1d8-23d5-e13b-d908-0fa02f8fcea5@socionext.com>
Date:   Sat, 9 Apr 2022 01:13:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Yk80eFKwDVnU67p/@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On 2022/04/08 3:59, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 04:44:07PM +0900, Kunihiko Hayashi wrote:
>> This refers common bindings, so this is preferred for
>> unevaluatedProperties instead of additionalProperties.
> 
> Yes and no. If you want to define specific common properties are used
> (and not used), then listing them in the specific schema with
> 'additionalProperties' is the right way to do that. If all properties in
> the referenced schema are valid, then unevaluatedProperties is correct.

I understand that having a reference to a common schema isn't a direct reason
to replace with unevaluatedProperties because it depends on how each property
of the common schema is handled in this schema.

Since there is no property to evaluate with "if" etc., I think that it can
be left as "additionalProperties" in this schema.
I withdraw this patch.

> If we wanted using unevaluatedProperties to be a hard rule, we could
> make the meta-schema enforce that.

At the moment it is difficult to decide it to be a hard rule.

Thank you,

---
Best Regards
Kunihiko Hayashi
