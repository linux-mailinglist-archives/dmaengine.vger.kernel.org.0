Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8727657B6
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jul 2023 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjG0PbW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jul 2023 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjG0PbV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jul 2023 11:31:21 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D51BC1;
        Thu, 27 Jul 2023 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=Dfas0y0eezHGt3ORPFcg54EkFswOHp+7SIWelfc59p8=; b=durHmeRLiJGH1feVB6AVEbtL2S
        w35cK7dO8zDysPgztPnDTMJZUG/3DKxrJW3xGorrO6f8j4koM3CXbtNgM3GhD71i7ERE7NVhNx1+V
        mWdjRo6ZClNSNhTe+qrxBMJWhKU1O8eeRm811oPgm2LVBh53uaLXCTq+jELDsLBrLNthngX89Ww/7
        9X/i0HaGurnWXS7qQ6003/zUlq1cOkF2vBkPXarKX8cCyPmeg1JgOh9cJohIp9wWt0jZ+fauHR3pL
        IQ88BLwgioEKwkRxeS1kBX7m5bsZHKsQsiXe47YrKYWIyLQeDjFyVCMyITLGkfjQiU74i8Vl4Z12t
        7tnTBi5g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qP2xO-00Bv7B-Vn; Thu, 27 Jul 2023 09:31:15 -0600
Message-ID: <bc09cdb8-f349-0eae-8624-457d85d768d4@deltatee.com>
Date:   Thu, 27 Jul 2023 09:31:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org, Yunbo Yu <yuyunbo519@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726104827.60382-1-dg573847474@gmail.com>
 <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
 <ecf68b20-0a07-18bb-42a8-e622054b01f8@wanadoo.fr>
 <0e4caa6c-d5bd-61e7-2ef6-300973cd2db6@deltatee.com>
 <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAAo+4rW_rTsY=TpxZwO8yHB5gFkRKyTvy6kQ-eeiY0vg4+fuYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: dg573847474@gmail.com, christophe.jaillet@wanadoo.fr, vkoul@kernel.org, yuyunbo519@gmail.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/27/23 00:48, Chengfeng Ye wrote:
> Hi Logan and Christophe,
> 
> Thanks much for the reply and reminder, and yes, spin_lock_bh() should
> be better.
> 
> When I wrote the patch I thought the spin_lock_bh() cannot be nested,
> and afraid that if some outside callers called .dma_tx_status() callback
> with softirq already disable, then spin_unlock_bh() would unintentionally
> re-enable softirq(). spin_lock_irqsave() is always safer in general thus I
> used it.
> 
> But I just check the document [1] about these API and found that _bh()
> can be nested. Then use spin_lock_bh() should be better due to
> performance concern.
> 
> 
>> So perhaps we should just revert 1d05a0bdb420?
> Then for this one I think revert 1d05a0bdb420 should be enough. May I
> ask to revert that patch, should I do anything further? (like sending
> a new patch).

Yes, I think you can just send a revert patch explaining the reasoning
further in a commit message.

Thanks,

Logan
