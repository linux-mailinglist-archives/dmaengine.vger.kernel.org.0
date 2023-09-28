Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4B7B1B7F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjI1L4h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjI1L4f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4A1BD;
        Thu, 28 Sep 2023 04:56:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D2C433CA;
        Thu, 28 Sep 2023 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902191;
        bh=ZNwcswpO9MkituTBaKUL88/P8cQwts8wIArlNdIRdoE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y21VjvnllBTiS3yH50MHbsKoirgy6TSZEbs5ooqGshVPWnrloO4Sa9OxVNDLryRh5
         +h6ryPfGf61Ma5G4rYrgTlqMaebbxpryxRpfUqoXjsd+cBnwgmK+tSCvHkAl2+bhzI
         J3nqcXgRHVtwHEqgPQDvRefojVYNL5TCNAwzhogOlmNewcV8o6Fqo0qZeeJEooY4bx
         Jm+Uz04odGsET+gDF0oT5rxOvZJT7FpV6sfvFrHrli8R9NRslkLIGDrjSRTZh6W6kk
         ijhbiQCUSRYZYqh1LFHKYA0xZqZk5up20An2/e3Wi+rm3skdRrehe1tTnOhAon7shc
         +xBcxa508WYiQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Kaiwei Liu <kaiwei.liu@unisoc.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
In-Reply-To: <20230919014929.17037-1-kaiwei.liu@unisoc.com>
References: <20230919014929.17037-1-kaiwei.liu@unisoc.com>
Subject: Re: (subset) [PATCH V3] dmaengine: sprd: delete redundant
 parameter for dma driver function
Message-Id: <169590218846.152265.10557304634440839644.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 19 Sep 2023 09:49:29 +0800, Kaiwei Liu wrote:
> The parameter *sdesc in function sprd_dma_check_trans_done is not
> used, so here delete redundant parameter.
> 
> 

Applied, thanks!

[1/1] dmaengine: sprd: delete redundant parameter for dma driver function
      commit: 8038557622beaa6145a6b17be948490b835691ac

Best regards,
-- 
~Vinod


