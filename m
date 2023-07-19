Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994F75909D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jul 2023 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGSItT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jul 2023 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSItN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jul 2023 04:49:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E431FFC
        for <dmaengine@vger.kernel.org>; Wed, 19 Jul 2023 01:48:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5Txh0PTfzBHYMG
        for <dmaengine@vger.kernel.org>; Wed, 19 Jul 2023 16:48:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689756519; x=1692348520; bh=40Hc0D4Tmx/rHOjdgcxVJLdF/9k
        FAF/oIE2sOyuc27o=; b=QqJddWXW7rvqSs0IZhFCqNZ4WrqrnDF+mVoa7AG7Qve
        4lbmpp+guStUo/hFA94QnKQe94qmD9Gb4Z45s5+7COjAoOoesGUP2rV0M/2pXiTN
        1+GTVQ3man0SFHi+EE6/dcL3uDP4cpSLOxXohxKkWvmd6E8uTUY2cL5kb1RzTVIe
        NcdEZ2WudvOADTYAHzaPEJ2oGTm2s3DHe/tzIEYeJrbfkL4aWMtxb8DgMtEzJOxj
        4OKJcXz92k2hp3mnbmu9oZCvXv9ZuQilJCijcfn0d+3ESZkTIHdWl0b/Pm8K/MFS
        8rHDA//iR8AWFdefhJWQ/YouwEhTVr3Ttwkfz51h+Vw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s32-cDok1rJC for <dmaengine@vger.kernel.org>;
        Wed, 19 Jul 2023 16:48:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Txg66N4zBHYLx;
        Wed, 19 Jul 2023 16:48:39 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:48:39 +0800
From:   hanyu001@208suo.com
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma: at_hdmac: "(foo*)" should be "(foo *)"
In-Reply-To: <tencent_0348568B118A57A1F34115B6FB1D12F38008@qq.com>
References: <tencent_0348568B118A57A1F34115B6FB1D12F38008@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <902c5769afd77f600c9bef24da0da34f@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch fixes the checkpatch.pl error:

./drivers/dma/at_hdmac.c:1119: ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/dma/at_hdmac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index ee3a219..af747a7 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1116,7 +1116,7 @@ static int atdma_create_memset_lli(struct dma_chan 
*chan,
      /* Only the first byte of value is to be used according to 
dmaengine */
      fill_pattern = (char)value;

-    *(u32*)vaddr = (fill_pattern << 24) |
+    *(u32 *)vaddr = (fill_pattern << 24) |
                 (fill_pattern << 16) |
                 (fill_pattern << 8) |
                 fill_pattern;
