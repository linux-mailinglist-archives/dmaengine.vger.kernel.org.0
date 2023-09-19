Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CBB7A669C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjISO0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjISO0R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 10:26:17 -0400
Received: from mx24lb.world4you.com (mx24lb.world4you.com [81.19.149.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB83B8
        for <dmaengine@vger.kernel.org>; Tue, 19 Sep 2023 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qhbyCVBfFR9YN9wJTHnT0MyeQg7WZBOb/2f+d6Pj3xI=; b=EU1qKODhU3v1sxP7b+r/23eVHF
        /+A+ivU8kcY5SCaeYXLDkCIfurB9QZi8gOQ8RyL1M5UoECuyCeE3QTFgxjf5zZzWXQfNpSzFsn24G
        DEZErDjWTH++MIQlEODbgS4uKqeKY8P9wRopSMfAv/1n2ZAy6LnZAe8XH3mjgA40RtoE=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx24lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qibg1-0008JB-25;
        Tue, 19 Sep 2023 16:26:09 +0200
Message-ID: <39e7223b-6d88-8e38-1752-3e5ce162ef60@sw-optimization.com>
Date:   Tue, 19 Sep 2023 16:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: de-DE
To:     dmaengine@vger.kernel.org
Cc:     vkoul@kernel.org, olivierdautricourt@gmail.com, sr@denx.de
From:   Eric Schwarz <eas@sw-optimization.com>
Subject: DMA Driver Template Stub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Mailing List,

what is your opinion about creating a driver template stub, which is 
regarded as gold standard, which driver implementers can copy then?

This template should be properly maintained.
Fixes should then be made first to that template and then be ported to 
the actual driver implementations.

I have seen quite some isolated locking fixes and also others on the 
mailing list which does not guarantee a homogenous quality standard.

As an example the altera-msgdma driver had been once derived from the 
zynqmp-dma driver but quite some fixes, improvements and extensions only 
made it back into zynqmp-dma and not the altera-msgdma driver (including 
a spinlock fix).

Apart we wouldn't maybe need to change 59 files in the future, twice.

Cheers
Eric
