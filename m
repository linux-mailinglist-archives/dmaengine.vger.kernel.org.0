Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CC61E90C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 04:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKGDNK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Nov 2022 22:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKGDM5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Nov 2022 22:12:57 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D1EE14;
        Sun,  6 Nov 2022 19:12:49 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:12:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667790768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOK2mGvwspj+yJ1m6IfEdRaPYM1eCd53hSbNkbFehLQ=;
        b=d2kYWBncbOcByQhtNKmeVNKTE4+a5+LZeB/ln2lrd5KCFIHEsBnwGRNqAkGxd0/+TQedli
        xwcmnUlU4yQ7aGtWcOTQ50dBfoTKnLzZWbtqBVv4NOFeinxZJmys6y1aR9Ra57vgqEHJce
        XohFb6nhDoaT40dFEtXIwVPfOfE5fbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     fancer.lancer@gmail.com, caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20221107031243.GA10444@chq-T47>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-2-cai.huoqing@linux.dev>
 <Y2UWvjNHBGa8PjBZ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2UWvjNHBGa8PjBZ@matsya>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04 11月 22 19:12:22, Vinod Koul wrote:
> On 21-09-22, 14:48, Cai Huoqing wrote:
> > From: caihuoqing <caihuoqing@baidu.com>
> > 
> > Rename dw_edma_core_ops structure to dw_edma_plat_ops,
> > because the 'ops' is related to platform device
> 
> Is that really a case, the device can be non platform too right?
Hi, Vinod

Just means plat_ops is the common part for different mode or chips.
core_ops is the private part for different spec.

Thanks,
Cai
> 
> -- 
> ~Vinod
