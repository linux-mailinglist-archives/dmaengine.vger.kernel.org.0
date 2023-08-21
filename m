Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1967782AE9
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjHUNwJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjHUNwH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377F100
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 06:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73098634B8
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 13:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819BC433C9;
        Mon, 21 Aug 2023 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625921;
        bh=hTbk9T6GPtyq/igxCcbUBcl2mIKG9ck+8lVvteImFkI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uL6bwSVaqyYzFv6/eIMGbpxOUJ+4lW+P8Mx+fzrH4F9dDrehR2oEwmzuNELD/AD7f
         2rbzGbeEYMISKHNR2ZDTBZGvFWKnhivHrKPDwtVpTltHOpVUoUMrYe82exUEBv/BnA
         tRigxvGBOeHsk8ytZjtFxOOxD3YfnzBv/itvJCItlhek5KbA6CYbUqitj531zvHWqM
         fvCeAyQdct8bbCV4gakfCZT9cDnKezeLhbT1B8LHXPCGoM3SqVr++F6p2VDoWGnQZG
         +JY3n5KgrIE/uHVBQgUjM06fyXIhtklNSlMKJOM5PNSOB9TCpX8x1i6Xh7Ur1Sl6hj
         s19EmNpv6w7JQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     liwei391@huawei.com, dmaengine@vger.kernel.org
In-Reply-To: <20230821073600.4078584-1-liaoyu15@huawei.com>
References: <20230821073600.4078584-1-liaoyu15@huawei.com>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: use struct_size() helper
Message-Id: <169262592057.224153.5883028380917500285.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:00 +0530
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


On Mon, 21 Aug 2023 15:36:00 +0800, Yu Liao wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> 

Applied, thanks!

[1/1] dmaengine: fsl-edma: use struct_size() helper
      commit: 33a0b734543ed5a44135e15f00429b94f75f2866

Best regards,
-- 
~Vinod


