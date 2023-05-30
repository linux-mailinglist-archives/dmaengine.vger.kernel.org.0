Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD0716C8C
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjE3Sbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjE3Sbo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 14:31:44 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 11:31:39 PDT
Received: from esgaroth.petrovitsch.at (unknown [IPv6:2a01:4f8:120:527b:6876:2a4f:a044:62ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F2A7;
        Tue, 30 May 2023 11:31:39 -0700 (PDT)
Received: from [172.16.0.14] (84-115-216-26.cable.dynamic.surfer.at [84.115.216.26])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.17.1/8.17.1) with ESMTPSA id 34UFsxK01500577
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Tue, 30 May 2023 17:55:00 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 34UFsxK01500577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1685462101;
        bh=2yoseQpk0oEKpAjWSngakamuL3Rs29Obuu+kf+gqlh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c2/GGaS0sc5BANOVSnmlgp4xetUgAykF+Z7jT/lakOyBAPVCKjv4xM/EcX+O6axU9
         NuiTRKajHjz1s1LYLBvK3ywe2ME574EdotIxouX/dk0mPXqL9MXTh4eGlb6lo3psmI
         6YjM4y8Omfpg16I9lNqn9TMnlFxe0W0viCeRCOPo=
X-Info-sendmail: I was here
Message-ID: <1e87f3fa-58c5-d47f-3335-cd0a554b3144@petrovitsch.priv.at>
Date:   Tue, 30 May 2023 17:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
Content-Language: en-US, de-AT, en-IE
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-x.dcc-servers-Metrics: esgaroth.petrovitsch.priv.at 104; Body=7 Fuz1=7
        Fuz2=7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/05/2023 16:11, Christophe JAILLET wrote:
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().

Hmm, so wouldn't be dma_zalloc_coherent() a better name for the function?

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at

