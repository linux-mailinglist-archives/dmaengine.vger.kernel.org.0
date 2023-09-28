Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8627B1579
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI1IAn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 04:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IAm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 04:00:42 -0400
Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901C95
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fgWMBbIJl9402SB9ewgEM6bntZF2EeCKh6HL/FBkrkY=; b=QbgBggONMiSJ4rnmlm3PTmsn/Q
        Y9NwcsKSYfezR89pwUA2h+4igjf0YMJWkRn6R1lfHrCMRseltm9fJi3GIQDmJA82DXGgKbDaazL3J
        0kHRsBI/lUar3d6aqgmVVCDxMg8NIsIEdiR3r7FWd9t6zJl9zQxKn6D58WwDOeLu0b+o=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx06lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qllws-000333-2X;
        Thu, 28 Sep 2023 10:00:38 +0200
Message-ID: <566384fb-e5c7-d061-62b4-2becd423fe0f@sw-optimization.com>
Date:   Thu, 28 Sep 2023 10:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: DMA Driver Template Stub
Content-Language: de-DE
From:   Eric Schwarz <eas@sw-optimization.com>
To:     vkoul@kernel.org
Cc:     olivierdautricourt@gmail.com, sr@denx.de, dmaengine@vger.kernel.org
References: <39e7223b-6d88-8e38-1752-3e5ce162ef60@sw-optimization.com>
In-Reply-To: <39e7223b-6d88-8e38-1752-3e5ce162ef60@sw-optimization.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vinod,

is it worth putting effort into kind of that?

Cheers
Eric


Am 19.09.2023 um 16:26 schrieb Eric Schwarz:
> Hello Mailing List,
> 
> what is your opinion about creating a driver template stub, which is 
> regarded as gold standard, which driver implementers can copy then?
> 
> This template should be properly maintained.
> Fixes should then be made first to that template and then be ported to 
> the actual driver implementations.
> 
> I have seen quite some isolated locking fixes and also others on the 
> mailing list which does not guarantee a homogenous quality standard.
> 
> As an example the altera-msgdma driver had been once derived from the 
> zynqmp-dma driver but quite some fixes, improvements and extensions only 
> made it back into zynqmp-dma and not the altera-msgdma driver (including 
> a spinlock fix).
> 
> Apart we wouldn't maybe need to change 59 files in the future, twice.
> 
> Cheers
> Eric
